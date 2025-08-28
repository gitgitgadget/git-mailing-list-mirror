Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA0E225D6
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 20:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411216; cv=none; b=j9xvTDSZZlqgF9rmYi8EjHtNxCSN1TxZzGMTgLhfaIqbOHBO6WUrKwgfrNULQVOUSrBmKZF5G3Hjh8bJVxjtJRYwkY41ZxYD4B+UQxSxBjkgAgXUjjMAi6O/E505CWiwSAXwHpWkIPzUyoA4LI3se0lSX5+WC5XihLi7X0Rz0xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411216; c=relaxed/simple;
	bh=/78oC6umwb5dTCdNEdekyfZJT0folz0/9QWH2sxwKnY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=U+QT3mE252D6N9YzJnhTTIiCG3zUsUmsbCJkjUsLYQIhtq8r4bO/5bvqnL3wUzxeJbQrqhgLcdhadg9rC7XAWgiHYYs8P3K/mV5Xr/ajvrT4ir+2fXzSSsK+wD2WVCDpw1P7RyM5LTs+Gk+EIcQlGg7iuUYFtf2Hj9qy6FXVVik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=jZq0oo8L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bzeL/LqI; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="jZq0oo8L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bzeL/LqI"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 09E631D0016F;
	Thu, 28 Aug 2025 16:00:13 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Thu, 28 Aug 2025 16:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756411212;
	 x=1756497612; bh=/78oC6umwb5dTCdNEdekyfZJT0folz0/9QWH2sxwKnY=; b=
	jZq0oo8LGsDkLQuKqT8rrhcmvj5ywmTq8MOxWHAyNHCgCSSE3M4nPvLqQpn+ZdlE
	b4WmB84o3aKs3NeAjiIMgFBcIEhS2n5F3S7eWBYLDRhk6RKypClgDr3+kXg5S+zI
	y5K3rgzNEI51qKYODszTpVdzOdSOleODCFAlf61xWKWFCMksLdUovSobaYbcsOGj
	s7RCPKDi6B9d7QF92vHahv1WFFXpl1FnDb0+UbhZs11o56jvZA1WUtzmi4O0pJke
	4/6jsfoEp1Ig91qxHPH7vzBVQLeBoNtj8Xcjarg2tuMjM4hrzeKHNY+ogbOjAyxA
	LKZV2Obl+BPpfzA/AKh5cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756411212; x=
	1756497612; bh=/78oC6umwb5dTCdNEdekyfZJT0folz0/9QWH2sxwKnY=; b=b
	zeL/LqI0q52F3dXXhz9JzuaRvFPcPpo1hf1OOHm6sCDP21vXyPFNeYnF46MFDT/H
	HDna88r+U4HH4lgb79xyFkYGbENnVcKWCB7SZa6HX4KlrWYw95cnVb2OUqVrgUL2
	gKIQTWnPh3t7PQdaMUnusVptbcKH5gGOl3FNcLER0aFat2CfzIlfWBxWeL+V1Euw
	qQT15EzfJgqjDWLgPBpI0n+++qlf8ZsZC8CECIKaDuh7Lq9LRMQY0/Z8hJld1j7R
	s7APgfmcUyH1QKEjMDuPq74qaT7CalYu+Vj0RtsXmSdHCmY3cJVHLPXsdCPKk5xx
	nLLh4vgPqFkJGeuXhWRGw==
X-ME-Sender: <xms:TLWwaMKHN1PxCcovnIw1KVRC-gRCYsOpufVlptOOXs7349dsr5vOog>
    <xme:TLWwaMI1a_2UQ0Qdus8uOf9FKtqU7KhMTVNSsR79MvYSpgo90GednW8sVgDv-MGwW
    vj1eoDRQG14ktE-Zr0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeduledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TLWwaHQDbXE_ljswgPPUgKqPYiVUCqavZjOZ_kGu3iVXu2c6Lgo2Kw>
    <xmx:TLWwaPor1m3UHqqFL9tV0xruCkUpfNnT-WLppgLfqytaN0qnPfhcXQ>
    <xmx:TLWwaJzWvJBuF0ESM6qCSvaCTF_LEFiUykRsF3KcivgEPUx80mj4uw>
    <xmx:TLWwaEKS2takzkYVEcpQKHEKyy05gv9Znys7OcLDtLavDy24eShIdg>
    <xmx:TLWwaIvvGDhxIlY8D9s6Td4vq2iGLlBMNJGG_kZF-II4AQVFWaFysvM0>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 941537840CE; Thu, 28 Aug 2025 16:00:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2lJ7FwKEGVZ
Date: Thu, 28 Aug 2025 15:59:44 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <2efb789d-db2d-4dae-ae81-373bd231c3c6@app.fastmail.com>
In-Reply-To: 
 <CALnO6CDpsgTnC95CzjOL5MuhFNAnYYSQCR-jC_n5JYLEu0BTow@mail.gmail.com>
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
 <b641874627b3898831c3965616e936bd4ee310df.1756148933.git.gitgitgadget@gmail.com>
 <CALnO6CDpsgTnC95CzjOL5MuhFNAnYYSQCR-jC_n5JYLEu0BTow@mail.gmail.com>
Subject: Re: [PATCH 5/5] doc: git-checkout: clarify restoring files section
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Wishful thinking (see glossary comments): I wish we could teach them
> about "tree-ish"s here rather than stop using useful shorthands
> altogether. Of course, then we have to wonder where we can use the
> shorthand and where we must do the "spell it out (give an
> abbreviation)" dance. Hm.

What I find hard about documenting cases like this is identifying
the use case for providing so much flexibility
("you can pass any tree, not just a commit!), since personally
I've never passed anything to `git checkout` other than a commit.

I've been trying to think of examples of cases where it's useful
to pass a tree instead of a commit. I can see that it's possible to run
something like this

$ git checkout HEAD:Documentation/ git-commit.adoc

to restore `file.txt` into a different directory than it was originally.
This seems cool in theory but it's hard for me to see why it's useful,
which makes it hard for me to document. What I would tell a friend is
"<tree-ish> 99% of the time just means "commit or something
which resolves to a commit, but Git has made it more general for
a reason I don't understand", but of course that's not the right
thing to say in the Git documentation :)
