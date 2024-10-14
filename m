Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5D814A4DD
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 10:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728902387; cv=none; b=RPYR3j8aVt0y2Cgf+nQhpmluCACApzBvkADj9gYmHoPZoV3Yxh7KG+0MvEtC4n5P8A1rAWgWYcrPBCZyQshVIMvXFYWur7HiLvoN37NEb/phJ85/piH2i+9b8yFfCrCXp1fK5Dr/GK2ZQE+WtBtTqDmmYl3PPmgNhytIprwu3/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728902387; c=relaxed/simple;
	bh=GqEZsKhFBaj7gZJV2fMy8p8Tv7O/p3BRNijvWdtAnG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1U6iJt1g1cyxSQncsRtIeTMUHPuz8nRgBLafjm+arA6V0fjqhDZLhQ2zMd5yeqjImz9GQXTbaBbEw6yJNAkfJNkV18cfc5m2URFd0YrnjcUNfjixnf4/NVuMPAZUeUDsuT4FmvBR7OA6qUAEXyRmRIUp+xahgs+rtFbYzvth/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P82vXyiR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lt83ZJWW; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P82vXyiR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lt83ZJWW"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 2447C13803A2;
	Mon, 14 Oct 2024 06:39:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 14 Oct 2024 06:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728902383; x=1728988783; bh=CLTvLRQBdH
	WgTJEmywJEs7eAWDNMPMbwSz/EwhQ0/S4=; b=P82vXyiRwuIK2yfcOg5syljV49
	j7gIjU3UeUnEWcDLj/Ib5DqG7rShPcvlRPkssh3m0OaZ1KbVZuiAXf+2e4u/+eTc
	vfxySnvJcFh5atkjC9jIltCDbsHIddM0/40TQW9CKUCzhaInWZLCwHFgHx/zUxit
	vKZ/7nWBbhhvdqQsuIc3j4utzrOJZyxhoJgrEsps+p31z4taiOHzKAZS6RLDvhZ+
	mVDv92sQ2DhZB8cl35jo2CD4LO7tLh0/e1lEiDZN8Xeke59ZhRkivrvuqjKv70Mf
	CfpMb1rHB43NIMmcpuGkdD83mPi+T+oVbyaw+IMKrRAb24Md2F2/qnG7RXaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728902383; x=1728988783; bh=CLTvLRQBdHWgTJEmywJEs7eAWDNM
	PMbwSz/EwhQ0/S4=; b=lt83ZJWWG376F9/HcnAHwJWPlpS0c62fm7zzNZxVMN9r
	k+Ugm+s1xTEUdVinoJClU0cKJPvFcCHrOBxzShIL8H/u6Nkef2acqtwE+K5EE4O+
	WHsz5hMxsnnTdXwViOt7JZuw83sCYOvyQMCsWgAGpdNAqZzVPC4tcgm3srgR40Qu
	MH8kjuL2w7aTzWBbdOGUgdKmNZ/CYb4ejrk2UJtGIC+w+OKXVxobuk3B3SokMItQ
	lkCYuWYk9bOqHbu/E3Wb/KuPYWDeAaNvon4lpKk4uqWen+jUjl9ZX8f9j5sZDi2I
	jbJezi5q41M28SDGHjjeoy+G1t6EOwCJD+VCWdPQGA==
X-ME-Sender: <xms:7vQMZ6H-Hrnj5ow_1sVdFMNjzB6SfmC55eD9P-LBZnDVS_EK93hwAA>
    <xme:7vQMZ7UsWU1i1gHYNNicFr8rQq7kI4nQvEo3FUG8UtTIwfBopuWtd1JO_YNOootNY
    9X1bvOM_Py8A62Tgw>
X-ME-Received: <xmr:7vQMZ0L_XjExJfP4MvMe5JK-emliklYdeDs3Lipxtcty6B-eeCFPtrdoQV04r7wdPM7SxNQV-EL1_Fo16UXTbLB7tqH2Y7SUCzlZIy8X_BV37w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeejvedugefgff
    ffieegtefhgfeikeevfeefheevvdegieetgeeujeeliefhiedtueenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrlhhgohhnvghllhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:7vQMZ0FngzAJKFApMF4_HAVa2u0n5raZ9c7aNrf98F1AePMkEVpb2g>
    <xmx:7_QMZwUh54CP9e84K8ZZChGNnS0Y2M3zRYXrmUigBYpaKEiXEdmACg>
    <xmx:7_QMZ3MpltH3FRu2i6HyiBZvZE-hLy-vJKYsw4G-cX1JKXTZlIpHMQ>
    <xmx:7_QMZ32Jzoh2ywUNR5qWhyOgSp5oY1NL1mPeSQSmxEAga0jXXMMA-Q>
    <xmx:7_QMZ9hp0ch8lStFsjgmjtP1LPvyr_JOv1-MEamW3tqnyWE97hAMz3ia>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 06:39:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d31e5864 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 10:38:27 +0000 (UTC)
Date: Mon, 14 Oct 2024 12:39:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Andrew Kreimer <algonell@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Fix typos
Message-ID: <Zwz05AIAGLOu_EdD@pks.im>
References: <20241010151223.311719-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010151223.311719-1-algonell@gmail.com>

On Thu, Oct 10, 2024 at 06:11:18PM +0300, Andrew Kreimer wrote:
> v2:
>   - Fix grammar.
> 
> v1:
>   - https://lore.kernel.org/all/20241009114940.520486-1-algonell@gmail.com/
> 
> Interdiff against v1:
> diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
> index 15ab2d1d40..2eeec82f40 100644
> --- a/compat/regex/regexec.c
> +++ b/compat/regex/regexec.c
> @@ -292,7 +292,7 @@ compat_symbol (libc, __compat_regexec, regexec, GLIBC_2_0);
>     concerned.
>  
>     If REGS is not NULL, and BUFP->no_sub is not set, the offsets of the match
> -   and all groups is stored in REGS.  (For the "_2" variants, the offsets are
> +   and all groups are stored in REGS.  (For the "_2" variants, the offsets are
>     computed relative to the concatenation, not relative to the individual
>     strings.)

Thanks, the diff compared to v1 looks as expected to me, so this version
is good to go from my point of view.

Patrick
