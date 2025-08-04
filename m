Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288D786340
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 06:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754288660; cv=none; b=cYj7biV+FS8+b18n/D65glmIwqoQ32WMhyXW445ZZxsyobqoi25PGV08cpr03cWoOBgekRhjZO4Vq6A7GhCPkdxGzN3KDy4GApjQyTaBTNLM8CKH0oNN3uSA3rMGvyYEhBJkmOEk1d4sMQgraMszf6K2RQur65XhgKYF8ei1WZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754288660; c=relaxed/simple;
	bh=JH9puTaL7yJnLujrHfiibCNOL3ctCfG48wRY0AGkfUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbPWwjQutBYtmnc0aLUQU7IG+ax2oMQoKCneN2THIwyR0JxCtntWTIgzkgBDoq34aNXR5qzVZSrcTcOF/Pq2KePOFd9BPr6Y7sxXaiZeo188A3vHQwYuanwpqwXUFBlFbgCnkb+vh1Tboc5Tq9edz3lsMGxiRUXmBtjJlnhwTDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cn5vAN2w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RsCm9A9F; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cn5vAN2w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RsCm9A9F"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2D0697A010F;
	Mon,  4 Aug 2025 02:24:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 04 Aug 2025 02:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754288657; x=1754375057; bh=JH9puTaL7y
	JnLujrHfiibCNOL3ctCfG48wRY0AGkfUs=; b=cn5vAN2w1lo2KUnmYe5Gzz7E47
	/HI6UE8qAOueS/rcBAFfiC+MHvhx34in5//JyI40+3i7CpqcLMZ1CWVxJo6kJ1pJ
	neTGGLh5g+iwzJMuHGXvZhdpnnrULTxdUB8ZgHdO46yMHLj2BYrVgvKN0+Ov+Isl
	qeIuJM1OhU23QCETOCaSiYBvD0pxPuwBtPSwS8eTSmESDeFDiFTbnn5L8GuyC1DU
	7kjUGebLI/Fgfjgd7KhTM3xnR+/mJa33abm2A9a+usk19D6ArqG6kI6vxEtA1uyl
	zFVms/w6FDeus+q2Qu4CPLhyXcwkSd/D3qQZZX1COdO0caavtDbWy/+tj+FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754288657; x=1754375057; bh=JH9puTaL7yJnLujrHfiibCNOL3ctCfG48wR
	Y0AGkfUs=; b=RsCm9A9FWx91XKOCQb3Ne8OMefZmc/pUf7jN4tA+sn7rOxLxXS8
	4JJ/6kVRb2wIdP3YH+VieAW91mCnR8JjhP1dl1LNb1EYoI6zEQkDnJIuKTtY9ZIE
	vgBMSPs7QIUTsB/cS8zktYeFXF0lYp2iNfZWH2vFwX6CYb5BVhRBntFEfB5pQ609
	jaq+qOzbrODI65b9800RAy24dzR/l7CDCGQtb+ya4a7UOCpH9mfqBmg5xdBc7DZb
	yvQuY4h+3oVRNwYEphaDMh/3f6vJdzL80tVTVyPS94QIxtvU4FVBvWudEZoMfSGX
	i9ylKvI3qLYrhVXX3f/NFeMzgLiTfm3X8hg==
X-ME-Sender: <xms:EFKQaEEj88g04rUT9qDTc7qGiET3a986fodnUHFM2j6Po7cZEx7iaw>
    <xme:EFKQaNheZxNTVcQwsmFR2w7IB831nE2xZeyMXgR7KvOwzoLP0FXeVKJbBUONT_din
    7DoJ2O7_aa8YTOLTQ>
X-ME-Received: <xmr:EFKQaP-6Mwmb7J6ubkK_T4H1jhQWENFHlgTXWJ14MauxKFtGHl7Dw8mEHRT9J3WByb4NHNtwHTzrzTb1SN2-Y3ckGPYuNm00benQEao8NtM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EFKQaEo24tPqufofJp1FanCn9R2zK45IGkiKu-_m6RH1MqHVvTEK8A>
    <xmx:EFKQaO-E50nf5hTuulvFXYQbbeIKBYLTQJ4tB6oaMTnRnsa2HK2OIA>
    <xmx:EFKQaIUG6yKEBI4EUJKuthPdnCu_N1Fczk9HgV7RS9LKNzVrDGo9mQ>
    <xmx:EFKQaEA8WxCPKD-9t5u04Y135ZvW3r6xDn4H_f1BYIh1hn-UjT12VQ>
    <xmx:EVKQaGrTIzx2yskJllORwAAQYwNoNRhBEl4ire2tWBeakWden9mvEbRK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 02:24:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d5c80b69 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 06:24:14 +0000 (UTC)
Date: Mon, 4 Aug 2025 08:24:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 0/7] string_list_split*() updates
Message-ID: <aJBSCpPRSJoPN7EC@pks.im>
References: <20250801220423.1230969-1-gitster@pobox.com>
 <20250803065223.3325111-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250803065223.3325111-1-gitster@pobox.com>

On Sat, Aug 02, 2025 at 11:52:16PM -0700, Junio C Hamano wrote:
> Relative to the v3 iteration, the v4 iteration explains the history
> behind string_list_split_in_place() in a bit more detail, and
> expands in-code comment to clarify what the verb "trim" means in the
> context of STRING_LIST_SPLIT_TRIM.

Thanks, this version looks good to me.

Patrick
