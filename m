Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726A81D131D
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 06:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724999971; cv=none; b=P5onia/07FqTQQcZ/6xP/oDY5l3PR0KHj5zC8RJDgrnt6VQLYBjN5g7lz0fOyFAMS/1tRrDlY/JIg+PfQOHjNIRcQmysNq0XTK9YE3Mo88/dKIwakrMJcbhfmB8q52YKxw3QeDYGc5otixkAUo/ghkYi7RCsvI6OWvfC7TrwKyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724999971; c=relaxed/simple;
	bh=CtJwwxvWISoa1dBOK+rVDiNLy6dIkoKEUD4tusq90LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/SZ8YGOcyNPPXOoZ/WjXDEy4CPnuYjMD5V8HqZ3S4Y6ifXaBhlRsog9fTGTvWyfE2bTR1kvUsHMsjnGQUXex/Ougu4/goV1NoT4MHOoFysJNJAa2J3Lyeq5TCAERnI8GlLiKAiX4Q7zCzeLXMeNmgwydduNwamERMghI9avym4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cAuUa2KG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Czs9VJ7L; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cAuUa2KG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Czs9VJ7L"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 527DF13801FA;
	Fri, 30 Aug 2024 02:39:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 30 Aug 2024 02:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724999967; x=1725086367; bh=j76LvuueLo
	m2qf95zd+2peIJPB7j/xCLMHokCTRiYcM=; b=cAuUa2KGGOKsAuq1mUvqIepQNv
	mbaKgkcTAtKQZqmA448FAEd7mttZkKESPZ3Szvr36EiSXW9FAXmV1Sl1iHWbeMPE
	HJRcJXMStlSUZVMpNrfZirSD62wetQQj4s5IPOSwM4OMhcCXDEWWD9Blr2RA+5oi
	zK2QT87xngbh8DCUYZAEjtrm2sfcBiowz0fPZ5B0j9+zftiZ2xD+jWflNPWw0cHX
	KbKGnNS2a8/NLUCKtOYzpn38a4GnR7/nFQWSignmV7XURjW65DebCi1WjJQAOjbF
	ISOMAWr+AYdRQpM2OS2GHB4Z1TYUZcDp2lf0ZF1t/JP7VGVTeg7lfxBrbXLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724999967; x=1725086367; bh=j76LvuueLom2qf95zd+2peIJPB7j
	/xCLMHokCTRiYcM=; b=Czs9VJ7LI3UhsQF1gCWBTkBHi1tIgLaEqxK0XAiMC1tN
	fp576nbb8ppi+/vDytsNMjog4r4MA6uetXcYvNxkmFVMWgt98omRCLFrChYb8p/I
	UzqsTf/G/5UHp0UtfmqrPaTm31yWvQf1TQu8l0WjfzgD6bdPwimbf/+HqUPsDZo7
	NLUEv5BsN5yJteysXZN4JZwE+ZVR39KCOoJcOqnAxzC1MxOAdxQxUjce9tqRFjUR
	1vSL/lePoO+bHpnCDvm7G9T0GN9o4FMQ2KTR5g5j5RLxTpzWGA4GsAQ/vmUR6fTj
	H7Vt8FmPz63dpAx0JVAkfxa/5alaBYh3uXejAf01Jw==
X-ME-Sender: <xms:H2nRZsvdN_NP8Zn-liXpo5NHNlAyQL4Wznm93KFbGEs3dqaX4r5DNQ>
    <xme:H2nRZpftJ4m8w47Lh-m82Glpud-HLw7A8cFNfalvDeKtsIb8TvX6qiEWpd51mYNdt
    BxFfxEOQHZPKhlHwg>
X-ME-Received: <xmr:H2nRZnwrCjYlpRYkORtEf6h8hmThFACnG8EJdNooKH9ZRqr32ocR2of8N5XSh66QHoLJ9NclgSn4TKRCmevzXO18KkXTHahvsj2KVDlScBic7QJY-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefhedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepjedttdegff
    ekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:H2nRZvNXmQgZPkoV8OA9_sknluB93Km_ilB10AiyZHwTIq-P3VqXiQ>
    <xmx:H2nRZs-Ilng9IyQ9mCWN2eeAboIR4XnHONSkPhVlCjpYe3WDDRLz8A>
    <xmx:H2nRZnXWvLh72Jjasy6iik1HUQ127Ct-FixJXhEZjSIBSW2gkABj7w>
    <xmx:H2nRZlf_je0LIGjaYJZ-Ckuu6T70F4_4_TOpGsQEOu7ikgt7gxV-XA>
    <xmx:H2nRZra1G6nrV1zOwMfx2iKcXqB1t4kNcuEgGtocmdpNqASONtFdksW3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 02:39:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 014f91b9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 06:39:14 +0000 (UTC)
Date: Fri, 30 Aug 2024 08:39:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] grep: prefer UNUSED to MAYBE_UNUSED for pcre
 allocators
Message-ID: <ZtFpGjBFlMNPnSld@tanuki>
References: <20240829200807.GA430283@coredump.intra.peff.net>
 <20240829200953.GB432235@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829200953.GB432235@coredump.intra.peff.net>

On Thu, Aug 29, 2024 at 04:09:53PM -0400, Jeff King wrote:
> We prove custom malloc/free callbacks for the pcre library to use. Those
> take an extra "data" parameter, but we don't use it. Back when these
> were added in 513f2b0bbd (grep: make PCRE2 aware of custom allocator,
> 2019-10-16), we only had MAYBE_UNUSED. But these days we have UNUSED,
> which we should prefer, as it will let the compiler inform us if the
> code changes to actually use the parameters.
> 
> I also moved the annotations to come after the variable name, which is
> how we typically spell it.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Where "how we typically spell it" is "me", because I wrote 99% of the
> annotations we have. ;) I'm open to debate, but only if it is
> accompanied by a patch to change all of them to be consistent.

I don't care about the order, but if we settle on one I think we should
also document this accordingly in our code style guide.

In any case, the patch series looks obviously good, except for the one
typo that Eric already pointed out.

Thanks!

Patrick
