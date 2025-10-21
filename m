Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079AC3491DA
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761064009; cv=none; b=nI8q+q+1p///7xKpBSny35FbOF/CKmD6FerGDCcIQbEPYxZOeVmg9+ZwqhN9dWgZudcjE/Z75tiv7E1lt8UnNrHebuetB3wUAfxf+ZgG73l1kaOuv3XOxeA6iZjLcWxLP2vuKiGW2XGlwrVGFyXuQAKYFgClq0DNRgP7u94gJgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761064009; c=relaxed/simple;
	bh=EZgisqY5b8CO/6uinDMGi4cTZ56fv+Rbj8fhytYkhTc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lzjt+xlSATepW/vFkB1fvqWbFzjyw51NglxDZHzFEJnhwZwYJ6+VjUdSg5EQWy5rcxZNqNsK89Uw42g54VPBy5E9eZt+W3aTr2+TjPvz2H+FQqdsHFeyQzNbymGAlwz6DKOkvTpB9l+RySfnryeNxOhe+JZfWoyOVNHwDv8vLTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=A3Wp53TW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u4Qx7ZuQ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="A3Wp53TW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u4Qx7ZuQ"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0F0877A0010;
	Tue, 21 Oct 2025 12:26:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 21 Oct 2025 12:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761064006; x=1761150406; bh=8AtY0QVXLw
	B7Rbjj9bEl2MUm4lAHlksslSAT49KN4MM=; b=A3Wp53TWcDfgXdQ8VYi2DMFwcl
	AOA6As218sCuxDfA3QkWf0Bi6AO8t/kxW5CP1mjcRMCs6Y/lRFJAOmCW5CvCeujt
	Ecb2SJFxtgVIKiowlXRhTdaP3uCAKxbDZojBetPv0dpTfY4I+BdwVPu6dqHi4Aw7
	BtD2byy5bmR1corEOlekudUpedWQ1nmteSV5mFzyuxjOWCDWIUtaAH/li9aWNst/
	A3Yd8eyuQmTcebknrMitiXsNMvvoNNLfULWai7VIYJaS3kSii7DCO1isZDvWymIl
	pZ2JJCBq7HLXjJkYlqnmWdGL0janXxlt+oUJGu9+M8fyYxFfF0/L75sKMChQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761064006; x=1761150406; bh=8AtY0QVXLwB7Rbjj9bEl2MUm4lAHlksslSA
	T49KN4MM=; b=u4Qx7ZuQuW4c6PBsuTg4dYReIGvRup0v8baiYi5fbbUKLXCc21Z
	vItGdT8mWPqZ401kaBXscUtTr4QNHdUoOJvDBBtCPhnkTSX+bcIYcLW4KImjTSMk
	yiUoj/Pg+y6TW7ZcD1BEq10GLCN7IpNYgE8ZYT39vRc1QRH71lQ7QHYBYZIWAPaS
	33OQbBKGE1lx2yw49mJ6CJvVYij/dEEpjGC871T6MsZiqoVITEwA+dNCf7W2Vi8J
	P0ZrTi6bYFzKwPLBhHFoCZe+8DEeDeiIlRgreGxUaQHNwrFlYZSwXss2ddY9/Ntx
	/Qlzm34SbG6a2fJOyE06QP79W7GprGAq3XA==
X-ME-Sender: <xms:RrT3aHRX_8xXTskTMRC0aIvvKjV2ihVUZB79p5SU3xB6u4xwC92Uyw>
    <xme:RrT3aMe1q99FMZSp4x5nrQv4HQmyXJ1Q5QOA-flODMgy34PZzSH6bYozMZT9CQ6_v
    VPwgOjsbyTejoYxyaoVYqsKvQ0PZHx2qLd6D0s0htlL719t-Vwe>
X-ME-Received: <xmr:RrT3aGqKpO-mnKKfw2Ec-6Ws60gvvALPnV7SVfc0IXzKyuW-0CRcn0KMbVjz424fGujAF62zzCC316goRzBxPmUtNiI2gEvQemca>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeduudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepsggvlhhkihguleeksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehushhmrg
    hnrghkihhnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RrT3aN-aD0eigGCYpThn1Bjz2ynGCcSqyx71RR2sFK9erePdBIYczw>
    <xmx:RrT3aCca09SlNO0V0ocAzfdpyg1T8LdtOXbPYrBpUyqUeydBGat7Og>
    <xmx:RrT3aHJLhcSiaWe-Ap94bkpqkEo-Lk1R0PpnojLuIjDTSO03rp1U8A>
    <xmx:RrT3aCgCquVeuXvjwZRNVfCGvGN3ALoE802BbBl9FYvTotn3T2dGFQ>
    <xmx:RrT3aA1VLUZvx36Pahzz1wvca-CincujJ0uMQEmGgvMiFv1z_LP1XOmb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 12:26:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Olamide Caleb Bello <belkid98@gmail.com>,  git@vger.kernel.org,
  usmanakinyemi202@gmail.com,  kristofferhaugsbakk@fastmail.com
Subject: Re: [Outreachy PATCH v4 1/2] gpg-interface: do not use misdesigned
 strbuf_split*()
In-Reply-To: <CAP8UFD1J_B9W62bv=0yccQNGahkv2vco3arQOs0oe0DccdTeYg@mail.gmail.com>
	(Christian Couder's message of "Tue, 21 Oct 2025 08:46:22 +0200")
References: <cover.1760997183.git.belkid98@gmail.com>
	<2879d9be3659a9c1ea554fff7814507caae24b65.1760997183.git.belkid98@gmail.com>
	<CAP8UFD1J_B9W62bv=0yccQNGahkv2vco3arQOs0oe0DccdTeYg@mail.gmail.com>
Date: Tue, 21 Oct 2025 09:26:45 -0700
Message-ID: <xmqqms5kw796.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>> Reported-by: Junio Hamano <gitster@pobox.com>
>> Helped-by: Christian Couder <christian.couder@gmail.com>
>> Helped-by: Junio Hamano <gitster@pobox.com>
>
> Nit: Junio reviews all the patches and adds his own "Signed-off-by:"
> to the patch that are accepted, so there is no need to also mention
> him in an "Helped-by:" trailer like this.

Just this point.

Somebody is later expected to sign-off on the patch has little to do
with who is on Helped-by: lines.  The provenance of whatever help by
others the author incorporated into the patch is covered by the
author's sign-off.  The sign-off I would give to this patch later is
only to certify that I received a signed-off patch and commited
verbatim, or with my own changes that can be shared under the same
DCO.

Not that I think the amount of help I gave is substantial enough to
deserve a "Helped-by" credit, though.

For everything else in your review, I would very much appreciate you
for helping the author of the patch.  Thanks.
