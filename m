Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B1043B4AE
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109113; cv=none; b=bf+4HwedXTADgNgYEcGxeilc/O9aTIXD4viw+zHwGjZgc7DPNEfZX7NFSP2/9BuSm90KzNNIVkvxNNG+1Ovfcd/07HPOR/HRPPNTjEjtM0DyfQuUg5iLebODk9156IuzRhnPTz1MepxMF3Z7T3kdKre8DSGvdSIJ0pa90/KwTEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109113; c=relaxed/simple;
	bh=Udrvn4Lpmauf8gm39v91M2RC+ryu7wMklQH8xIpub+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psk0EEhV1YATH/ZRNVIy5FibXQmPki2gWb5n7gqmVF1K9lLxMbCHqV4Ayjee0/kG/+RD55lpn9Te53jR++iILu/9mut13gqzp2mRS5kmNHEXD9vdGYCgTXNJ1W4gvpIZ1QCrCma5k4FY8pca+8FZ8MljukByvlFuxk9uHab38Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L+FymnjC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bfr+VgJS; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L+FymnjC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bfr+VgJS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id DE8141D000F6;
	Wed, 15 Jul 2026 05:51:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 15 Jul 2026 05:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784109105;
	 x=1784195505; bh=IZulITMUWWgooosokOaOUFP2ikpgaKT2swkcApOkCck=; b=
	L+FymnjCYvrBceKZbGp/Cet6UYf9w5v1zh8I2kxqceLWzEOTJuWjAU8hfYSZq9hx
	PenKnzwLc9nGqhOPGm0SXZhN+bdbavxMPk0Z51cPXseQf+1mqcaPsv742AkUUDq3
	gLLiC1gTiQidv41Ej0/Za20IFH3j5loBcmuQl1A1uDrBR9i9Qsy/gUEnJ2aRwnf3
	Mkk7p+SlzPYA1mjsxP4Br7Wga/+K8wzarVdFf7Xb/bLRh4T91ujT2sU2aOy09/xa
	/W11NOL0Eh5g5boR68fAetOeUFit11eSw8YBrIiENHhoTb02v7IZ3fQgwhv8qcSU
	iy3OQDvfFlQfboqgdSRX6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784109105; x=
	1784195505; bh=IZulITMUWWgooosokOaOUFP2ikpgaKT2swkcApOkCck=; b=b
	fr+VgJS+8lRsCKYYGFEhdW5Lh+Np042as3IaeofrW9q7iuvyWW1p2e8srQ6eAMPs
	0i8dRRCkiGLigDpyY4A7Dd564RvaTCCZJ3GmWr9C4HErEjlEgYTVjQ3lEeowXlBc
	2vsxEEeHYRKXPRNIelSkfRmm0woOEl+SOgVfuAGbha7dofS68b9doQ+bqEG0I7mL
	cx9dBFjl/4r3vYQSIDOHsJ+wWwZJVVt/TBY/PVnQiTK0Yfp+c/ZOkPWBVMg+zB85
	YtkDTEg/gRZ1KC5BAZM9N6+c6KEh6PuuxhMGMEKFJ1Cl6TbJDc1qnnGtrsi6tO9J
	Rch45ilRxJQ6Hc8fNRV/w==
X-ME-Sender: <xms:MVhXarvNOX-Zq-zKgvY_wcbpIl0fRgxcR2AYh5WXYae9jV8fpB_c2g>
    <xme:MVhXaic6asVPqGRkUIIiSZH47GrKOX3EjaHsM-J7JpDev2di-BMkWgzGU8D_pBO6A
    2x-8UHMkkS0UgqGFw5i6onXirKeEKmiTwzS-r9jDOm10_AlbmgaQA>
X-ME-Received: <xmr:MVhXasbCtiDlpmYu7gsn-sVdgd3iqZnMa5ptghKJ1DvLPAmTupCfw8DNcBvxc-AdvYRyzDP7YCq-RXBv1bvuLTqMCgM6SMYrZq3T9lGMNmI>
X-ME-Proxy-Cause: dmFkZTEoVe5xU2vXSaVceyM1x2urqYo29JXeiCsvKgxPeAdRonQC6Ilv+UXOzYKmFgLweL
    +YH+wwUeZOECvL4MDtyuZRtVAiZN+btTM6nG3OAlf3Pxo5RGPtilsWVqJKAcETr5w/JP1L
    kU0CFD+5wyCgtosKDccFRpM6n6K4tEFF0ov6K+79PEgheLalgyPskSuz44mDcdkfVB8ZtL
    61nvhZ1b+MbUe8yKW9hktxrVmrMxhAjoxpBbUHgvxm7Ygnu0bGwtgdcqGmOAi9yF7c2P+e
    EzIw3ITFoMfG2D0TBx4Ee34/cc6Wpon/9SFC6eOPP72H53ENe23rg5cHwZ4fDpJANyGILr
    lCHrWpIetEizG2x0hAxyUZF1tRJqU4wp70ZKdMaPh4PJUEQummqW1i/vNQ48S8hYmhUfbt
    J7hx0KPZRI08psj7XS+vCxr0yYcPQ95IydhO+f3iAgj83Z1G5eT6dOsA3NleHozzFTKcGT
    wOw/lig30XhRgqYC6KQV3tBspYfz1xLc/Iz3dpGTLY5Xm3iS+lm0cf3tD1Tp5/uYlYq1+L
    0R/HuZhaPgCKJWHjzMPecGOBghj3vwE5i3XSkmFe+LDwokV4JaSJPv0V1BFG3NzIBFQzuy
    VwwC8BUlAzUgfjtEME2zqzpnxJTKgG/N2BiYueQ8W8W2JnPNnZxbt6MPUmnA
X-ME-Proxy: <xmx:MVhXalUbMYsqHgPZMfA7l3-n6MF0pYMsUYY6T3G_amlnrUqsghvuJg>
    <xmx:MVhXauh-mTQrV85w8qmcPqEtqxiDF88Okz9J4fWdDH95rQsLxo9pnQ>
    <xmx:MVhXajVk1xgZ6fuwTWU4h1JunXRvb19RzAjb5z22tJkAGsGusCWrJA>
    <xmx:MVhXalP7LUpqxXRi0Kebiu6Cm8uQR4dTYOwR7wA-ik8OkdbPaixNyw>
    <xmx:MVhXanFVp0rr8sOvG540kLhWz_LVlbm9UDA8zf9kFxLOBBEKIOmgB2fn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 05:51:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b10d7b96 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 09:51:42 +0000 (UTC)
Date: Wed, 15 Jul 2026 11:51:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/5] tempfile: stop using the_repository
Message-ID: <aldYK5rWcU7auJeG@pks.im>
References: <20260714175956.54601-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714175956.54601-1-l.s.r@web.de>

On Tue, Jul 14, 2026 at 07:59:51PM +0200, René Scharfe wrote:
> create_tempfile_mode() and create_tempfile() use the_repository
> internally to call adjust_shared_perm().  Expose that dependency and
> push it out to their callers.

Yay! I was just starting to have a look at this area yesterday because
the implicit dependency got in my way. Happy to see that you tackle it
:)

Patrick
