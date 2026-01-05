Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDB71FE45D
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767622722; cv=none; b=is2cpWi9LnvkSw+Pnxg/uViixPaL47yLKtX0rlpDS9DWHjLvujvL4e1pt4zaM5IRlyuKL3f2ktMi4GQqISBPcczTBUgGOvIgrwJIydPLYLJDQelnpyhss+59vEm0d6W/rcINmgbtYM/G02Vtnj6ymuyK239HoNAZAIC6VhdzLWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767622722; c=relaxed/simple;
	bh=Ck88vr0Y0P4XMfmWYu83etWZ6GmpDCeR581UxYpBBlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z18AjFqxKQGcAC97r/5obuA9mHyjazb0Ok7XWTiA4+AqnbjjvwDB0OxXkM5AFhlG8zdGL7C0cqUlnLUjVR5Zv17waoc2oVQ6vqOFGNxlWW/p6upE2GbhqT9bQ5ZJmXR2nxG7PaAq1pTMhFVIwKaUov5PPihs3uZtIWRW9fFSC0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pv3F5iG0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=udoK71fE; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pv3F5iG0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="udoK71fE"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 543CE1D00105;
	Mon,  5 Jan 2026 09:18:39 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 05 Jan 2026 09:18:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767622719; x=1767709119; bh=lFU2z6bXrA
	QdlVrgEtyANmAw8joJ6b4S05QGE82fAYw=; b=Pv3F5iG0hFxMz/cd8nKHhzuw45
	8m6UZiUQhvnq3rvefY7F1fx19OfOfFwXpOAEfd/N1Z2Ywr5xq84G5fNRnghct50K
	mIBJnlnwXLB7EbEHJNJzxdeTGElBkYkCa7HA+Wm6b2t0i/a8VA3tSnQBFXiuVujE
	b8G+0ITabcmgM2He/IdUBTrlMwq/2p/OHosnJzAmY1gXuEGzrp3BF010a8rJ/jUt
	kCiXQhWhu8XwObAIyJH6xnXS+RFC4vxx7n2X+dUOKAIW3NJVRr+nkbs/9YyZN+tK
	2ggJ9jkB1AcaFmuRgydcXDd3sophI3emCgmCsQx4oJsnVyIExv62WjZ//78g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767622719; x=1767709119; bh=lFU2z6bXrAQdlVrgEtyANmAw8joJ6b4S05Q
	GE82fAYw=; b=udoK71fE32ke4QdmxXUWH98WB4XmnpKwYnfEnzmgdvu/dAh+b6C
	wltAqoXUom5k4uhlCvsWC+tPmgjdUcvS6qXuQKsL4tzYYD256JBhWH2TgOlS+RFL
	n+7tJePIGzAQ2nRPYIAtr1CPw6CbqNQBsuI2xVS3/Cus9gEcle8ZhulzebwZ+7C9
	/Cej+sUNl5r36UNXyQOrPUCAciEID04VrdUZ2UC9PZOspZQC125Blhf1Ju/uZWM1
	93L+seR1Io6V/bOs+kfbHsMjYIALeTQy94k8GooR5/HXEImLjgNGOnBdcLbwMs4O
	Viy2j6njXlXrj2TKgtkahkJsyo14pBYXOoQ==
X-ME-Sender: <xms:P8hbaedaBLZS0ItY18w4x7k6SghgLyrY0Qo7pO3LJzzH0I2nrlmtSQ>
    <xme:P8hbaePdDWFF69zikuBGM9qAshLuWVikAIhgTLuOpz3XWvoX7a_0f2_Ge6lyAVwaj
    4D1ybYSQSTaAyQa_E63E9kIpLmWy8xrUc1bdiTzgu1QbZ52Dofe>
X-ME-Received: <xmr:P8hbadJhzmN9SFVHrnUAviW47q8LlhjRFTGL6YkG9dnIcBrakPSEEYT_1j4SEnOT9fcsFXc9gHfNeYY8IPZ4lzrfPEaiNs7Y3Un1wN5R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejtddtgeffkedujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:P8hbaXGbNFz6WLPTVQPWrofHOmh6s-PiOE0qICxU9DGgDzzfnM51BQ>
    <xmx:P8hbadQyALqMQyD3dXbJZduE0tQv-9YlTFBlTPTIVWxhX5ujAFm7Rg>
    <xmx:P8hbabEHyLDQxVXPfVRCfUhbZgCMFwZL4zvdmxFtWoSKyVtuG76R4Q>
    <xmx:P8hbaR__1Gxv98_9bK24ergaFnp3cAR5h_hmjMsoFLY4xQ_1eULBtQ>
    <xmx:P8hbaedQ6iGtwD3-7uAhJBSXs0cou4GlR0-_4njo4Kf2PeUbSi3QLBpj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 09:18:38 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9dbfaa6f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Jan 2026 14:18:36 +0000 (UTC)
Date: Mon, 5 Jan 2026 15:18:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] repo: add new flag --keys to git-repo-info
Message-ID: <aVvIOVVKZVjGCDrL@pks.im>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
 <20251209194616.61620-1-lucasseikioshiro@gmail.com>
 <20251209194616.61620-3-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209194616.61620-3-lucasseikioshiro@gmail.com>

On Tue, Dec 09, 2025 at 04:36:03PM -0300, Lucas Seiki Oshiro wrote:
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index c4a78277df..fd0683631c 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -9,6 +9,7 @@ SYNOPSIS
>  --------
>  [synopsis]
>  git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]
> +git repo info --keys [--format=(default|nul) | -z]
>  git repo structure [--format=(table|keyvalue|nul) | -z]
>  
>  DESCRIPTION

The synopsis should have been updated in the preceding commit to mention
"default" for `git repo info`.

> @@ -131,4 +122,24 @@ test_expect_success 'git repo info --all <key> aborts' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'git repo info --keys --format=nul uses nul-terminated output' '
> +	git repo info --keys --format=default >default &&
> +	lf_to_nul <default > expect &&

Style nit: there shouldn't be a space between "> expect".

Patrick
