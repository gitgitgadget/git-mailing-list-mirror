Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E7735885
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 07:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731483383; cv=none; b=BgZmcGbK/Zl7ejFS1w+5UTr6H6rYbRU08CngnoGIH7a8JFOGYBiWBcd17Tk1Tc2+Vi6ZSNZGUa6EybuOgSptq9by3hnnEG4mQ2gMg/WHhDcPfTVEY8grvooS3kYLPDdYVR65270ex0Rx4hAuWJwLVmWkaGfd97rPvx8TpYmyEHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731483383; c=relaxed/simple;
	bh=LnbM2dPlhowcrOkjgsBlBMCbwvZ/plk1cdbmfVAM1VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilhsWS9YyvcYj5jCXT6dFHDEb4f/ev0D/V8i7VLGtfUOIiONDjupPTwf6puOMwZSllq+c8PBApBE9bnhpmxPYDSj+m3tA5CoytAXQBM8X46ddaJUWzO48RtWJdf7xm8lqOLxXfQJHsM4G9I6sQdBNYOQROsnFmNFsfTo+xpIImY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tTAktqu2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mp49igny; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tTAktqu2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mp49igny"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id C00951380368;
	Wed, 13 Nov 2024 02:36:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 13 Nov 2024 02:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731483380; x=1731569780; bh=58YgPUDbU7
	t52ATP5gL++wZWZAF9JP3ng6uryZ0FQmg=; b=tTAktqu2s1p2ZodYc71C0/jnNX
	yv2ABUfyvVAY2+EuUPh+I7yka+jKJH552++B8+VWvwpr08AHzo5HX5WrIMUm0M/o
	sGPGWcWmLYTAjTJJljlbsUoznjSxCVdzBsjQ3mFs7PgYexsdMMgpvyow/cyX66Jc
	sC3CNVwVUDaKnQk+Wi/IBNBfdYmP+q5ZCZqsTKMGgsIxWnqIo/4ExGE8/AxYRoKS
	V5tNgeWNcc3IteU4GSKOlzytGBdUtSDfBu45oLuVQZ9tnMqolIrQHBzRco3bU4aq
	TXTe/YgJbO/qCVbUdKIN53uiz3w2vnYBJiKNN4yeNHy4vdw2QCLZVRmHJO6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731483380; x=1731569780; bh=58YgPUDbU7t52ATP5gL++wZWZAF9JP3ng6u
	ryZ0FQmg=; b=Mp49ignyS5bYpYYxWvTyX7NLG39Fnv8iobvxAqMGMnCch0WmAiE
	3bQq/i/HEvQWgPDSEBJvmP1qkqF5f03wokOdTcCrFl1XVdjzt3iuT6HSBOW8J5yR
	RmylNqgzvIZ3U2i/0/Ww4EXWd+O3gPE7CFeKxh+S/qpHAywPOFgcBsnwFusj3xAm
	MXvIbqLQYUnL7HglPTb0Ies86cznjL9y+xcG27185CWsPRi+yabrX9gMcGMr2kso
	PCmtTPbAEbZXPT1TMrRTk+3vpGZXoVt7vV6aX13fxkiBleG2EE95MZHvOu1Qzk3g
	m+AhU/D/n2gAqHpjG15DM5S45UvdQhmCn3Q==
X-ME-Sender: <xms:9FY0Z75lwKGdRaq8KFSkQCFqaoFnMSA-NjQWwdWxWjVHtbJCGizHkQ>
    <xme:9FY0Zw4icpGv4kdCD4QnIRLrZwYvCu2XHkEdqpTo6jMUsXAKPA6ZJNPGa2p2pcbzQ
    5TRno77tocNyYV7vQ>
X-ME-Received: <xmr:9FY0ZydsefjdwKD9IFTwThVUUl9DF5F0pVNvMIxbbbC0sznBBaO_j0uaZ6060X968LpEoMYEb_kRc-BSe2-rvyEd5Jd_Qo4cdEBGft8NqFOL2aA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudelgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:9FY0Z8KCta02kf-MJFj9rv-vpmn84bOjTLEFEAdqsehwEc9Egdo0Cw>
    <xmx:9FY0Z_K83gy8_0PwzFGxMlP2bpLbmJvWh1kxCOKgrjHkxR0p-WgJMA>
    <xmx:9FY0Z1x7liQKKSwbkTnBD7Ad7EQHlvuJHZMTyaqKwgzRpJ-ZVI34jQ>
    <xmx:9FY0Z7K_VLpahtwpsxO3v9S4EV_fsCqlsPd-X6V4nhvkqnB8JDBonw>
    <xmx:9FY0Z8HSpz9dHbZDkCaUIqxRUx-FWFKhAko1O43wBGmhJ2fIJLjCf3LF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 02:36:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ae530eb2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 13 Nov 2024 07:35:39 +0000 (UTC)
Date: Wed, 13 Nov 2024 08:36:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 0/9] add ref content check for files backend
Message-ID: <ZzRW2zFHUNeeT7Jb@pks.im>
References: <ZxZX5HDdq_R0C77b@ArchLinux>
 <ZzCiCGxL4Adnd_eq@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzCiCGxL4Adnd_eq@ArchLinux>

On Sun, Nov 10, 2024 at 08:07:36PM +0800, shejialuo wrote:
> Hi All:
> 
> This new version solves the follow problems:
> 
> 1. Enhance the commit message suggested by Patrick.
> 2. Rename "target_name" to "refname".
> 3. Enhance the shell scripts to use `for in` to avoid repetition. And
> this is the main change of this new version.
> 
> Thanks,
> Jialuo

I've got two more comments, but otherwise this series looks close now.
Thanks!

Patrick
