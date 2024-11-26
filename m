Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A409D1A260
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 06:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732604297; cv=none; b=DPXu+rPXH3DiIQNU1o8fpP48jfXLPAh9niKncghlIh6YLKJk0eEZIF3yr+QUi5jk/R2SzFM9fwMVQ40PRTB7vSRWA6wWf1Afurh2AzB8N292YoZ/KSerw2pPOibK00WarZ6x8iRRUOXD9QlTL1ryOp06Y/+r4LgvR8dVpFspV14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732604297; c=relaxed/simple;
	bh=dobB/mWhM9Awv9JS3VW3AcS/1vSEJL9mDT163pR7EW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgAHaIxT9VCOwT1zAjAJbQIaZUqMzaoA6UjReZlNjHYDESmLt89EJqBMcUFSp4kiyeLsjjXzioY2fEUjTkmpKTRdAKf8/6Vu/EzmcBDwQNzKhiaaI+OSlyMEdQ8Kf8ftljYMWwBVTEuWqXRr1aZ8bdvgMaB0qxCbyry5Ufpo114=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qYgZBtr2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xg3cn5Ya; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qYgZBtr2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xg3cn5Ya"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B98D9114018A;
	Tue, 26 Nov 2024 01:58:14 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 26 Nov 2024 01:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732604294; x=1732690694; bh=Lmn+cfF1x+
	G3QvSnUsWmezTq6YCTfzNYhmrVPRHFcPM=; b=qYgZBtr2xWlatZWbx36gYRoglR
	RsEMzOx14fjSo9Wf4mGXeO25qtmE9dlB9MqSqKdb9XSjMMgcutUV4ZP7nNjQgBPS
	oyJoFg9/k7O05k1XKL2EZ1infqx16xWL8uUaoc/k73BmLvausG5mnex2t8HJUVvm
	Y0i1D12SbwERr6tcc2wTxKVX98R0wAzKp/HvBddbNXxvIx/x6eqzsfb+OIGGBvtK
	aDrhKKVNatWF14m2kmtM9J3z7c1z1e1F/msl6tFJkrZp0HbRiIrPRGlZXmDOc+fL
	MyNIL9nyxWh7ftu7Q1Mep2wz/BA1t3CsI8U2ao2dYlsuVUZKrXCkKq72tecw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732604294; x=1732690694; bh=Lmn+cfF1x+G3QvSnUsWmezTq6YCTfzNYhmr
	VPRHFcPM=; b=Xg3cn5YalH4CidNiDcEWvE9eYfwaAxZjOu4VjmF6fhy0AErKlSq
	TKWQgenRVTupo6MgsPdnGpA8QAQuQPJIF1DHRQmn6QpaAZsLo81ZFkv4H8U5BJ9g
	BpOn4NgX1qhjyTNXT8tVEhhr5zkliAUZ6tf6qu//P1BD1AJT+7pYQdi06576ahTD
	j9G5M5SD7ftLu7Oaq//QnxB5iVYKbKRUaysCbRNL2Fhn5oT9wi5ROQalysTcNIwe
	uKsrIBJeFbDXXY4/icCpBHlXSbtQbFZUlABMbPqXixdr8Jf2O8aLdt0sgMjlmsw4
	UlRfrOmlUK3kdolek0YWorS47ad8lDohHvg==
X-ME-Sender: <xms:hnFFZztfc_92nJhzdJr_t2l50GeltCWn3zGQaRkLb5aIzHiYHuleFQ>
    <xme:hnFFZ0eqCKiiQpXaENCp_G3Bd7o3SJHPZOzyCMuhBbFZA9vVu2PTTYkEiZyOe52Mk
    nBvqGhZVOXvOREoxg>
X-ME-Received: <xmr:hnFFZ2yigNdhQEEvbv1UOsKKk-Jlx-S2lW1ZeEEIPGSeHwaunyKGYOPaCYAH88y_OHySdQldNX_IshuQ1WLo6fZCbkCqSRZQnt1bvYv1-fqApIDL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuh
    hnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:hnFFZyOcJfwjRtO92JKeJxp4HIlcpHQYaJEXkJdidcGy8YwF2dP1Fw>
    <xmx:hnFFZz-x0qzUPHNcp9PluvIstsRECY2hPjznjjiLVl0R7cORIgUXpA>
    <xmx:hnFFZyWu7ml-J9FavBLscD11HXptb46uakAoG1sx7IGOr-RKLWGEeg>
    <xmx:hnFFZ0f1zp3LEKqPcA8cpra4gpADalJgiZBcYu95yvyTo3njIrTgkA>
    <xmx:hnFFZ_ZFOcNEFLZavkByvwjYUP5Ve27qfiJjdnlHDc76TmyREr0WxJcA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 01:58:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c47fc429 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Nov 2024 06:57:08 +0000 (UTC)
Date: Tue, 26 Nov 2024 07:57:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] fast-import: disallow "." and ".." path components
Message-ID: <Z0Vxb4OVJYeAdgds@pks.im>
References: <pull.1831.git.1732557520428.gitgitgadget@gmail.com>
 <pull.1831.v2.git.1732561248717.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1831.v2.git.1732561248717.gitgitgadget@gmail.com>

On Mon, Nov 25, 2024 at 07:00:48PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> If a user specified e.g.
>    M 100644 :1 ../some-file
> then fast-import previously would happily create a git history where
> there is a tree in the top-level directory named "..", and with a file
> inside that directory named "some-file".  The top-level ".." directory
> causes problems.  While git checkout will die with errors and fsck will
> report hasDotdot problems, the user is going to have problems trying to
> remove the problematic file.  Simply avoid creating this bad history in
> the first place.

Makes sense.

More generally this made me wonder whether we should maybe extract some
bits out of "fsck.c" so that we don't have to duplicate the checks done
there in git-fast-import(1). This would for example include checks for
".git" and its HFS/NTFS variants as well as tree entry length checks for
names longer than 4096 characters.

This of course does not have to be part of your patch, which looks good
to me.

Thanks!

Patrick
