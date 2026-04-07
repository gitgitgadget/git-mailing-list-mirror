Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09FE1391
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 05:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775538970; cv=none; b=MOOgk+wlStd3+Sx+61NomeVIWOa6stv2GhY06yxZ8GvIycZqxh7Cn2kQUlePTZlYgaR7jPx99sL8FIo35ucrbnqXms+qcqHzC7AnqpO+v4UKM/HQZR9nxfa79iBPGL4V0kj4toGVPFq+4Zy/JYZj/wncWVzc+4JKsvSD26lpcv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775538970; c=relaxed/simple;
	bh=E4yHdnSg/4HGk7xDAu6m6G0+IGkrjD1aS+QKvySS0Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wr+qRXZu+DjW7TZ3afnEp8fFsuh0Pnl/EXnKnPRGmLLdrq0134h9MFXgE/3EQ82B+qfK29YwTxxsXRsWVcfmxSUg7JphN3aJpGxj5Xkg0qXGk+F8Z28Vp7tE1kvx/93tD68mJlbuOBwtFmi6Yt+SIRFjgq90faLd/P8P3YcmZ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O7dpfMgN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qEnr68xC; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O7dpfMgN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qEnr68xC"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 374DD1D001A0;
	Tue,  7 Apr 2026 01:16:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 07 Apr 2026 01:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775538968;
	 x=1775625368; bh=nwyPKeOdWCf/PFAxXv1JOxeX3WP/3D38KrIhEDnlBfw=; b=
	O7dpfMgNXKla4FemT/yu7xS9dmLGU06sgkZCJ8tp+BKPeZDj1q17f1uAio83GGOQ
	ObLmc36ARDBMHH6dHgUmlrycpAu8wOybmMyVEvsJ8xKIdwcf8p3rVkIGAYPX7HsG
	efBieCzVfBxgbSBCC0Hpi5N8UGWgTMfINJDG+BtxPueCvG081MMJsK8l8PBJq4id
	z2B+kYPMxEsFxGgLvFsfWO9pSG59vYNqf/eFDGprboxCcxl1LpR5cBHxxDUYkkzF
	1Vij50agnUU70aLI2+0UGYXddbNm6FRD6Xix6ETUtElE3SU39Vr7vFXTuq9UAdrs
	Tmj/Tbhe5eXHq+6oryb5tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775538968; x=
	1775625368; bh=nwyPKeOdWCf/PFAxXv1JOxeX3WP/3D38KrIhEDnlBfw=; b=q
	Enr68xCgF5tmHsuETjoSbbtrvCflraX8eiXqX2lWc9E5Z4qq54LG+IzHp/gQvsm7
	9OtyiPo2kU9BdW+SNq2ix60sWkdFWQb+OFG4LvQp4tR1JWR8mNvomvD56ZtByQTd
	GpwottzuTGM1I+PkqH+F2k5/B4QOC2TxPcBPDZmn3oW1PVGovxghSrwLmwZ1LRjc
	GNDlbtq/kFPIlfichQRajDxEsCJk6DThRa+6KuZys8/oYpt0EB69sGOgaRCguYvh
	NSrRqFv8EmSDceBi9tStrHPnmImaEbWs2g06fl7FOGvMTgq/RF4mtpwlbWpyUbiD
	Xf8IG96fSoBooNzjYriuA==
X-ME-Sender: <xms:F5PUaQU41nqRMwJkbuENf0xucIMNI6m4v5EZ6ALUHRdWF7eqSom1AQ>
    <xme:F5PUacBP-G9jt9laOljmuDfcdP6EkDDDGig1YcJ5QwZiH5mmsic9lcv0egAJGm5iB
    6mEEeeZH9cHOnFWZzbTfNBNYzKqqJQvj5cKUOqXdWEVspMfRy8bG2I>
X-ME-Received: <xmr:F5PUaRx93v2COEufV2O2fbG2AkRL8Y8Ee-u3J0SujQ7U5yIiHFl03XhW4cB-GiCldzYdOVYRlRw_jO2xifRAiaWm-QbtkyBnWgxlNJp6eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduleejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeortd
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeduteehffeguedtfeevgfethefhgeevfffftd
    evieffjeelueetkeetueejgeekveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:F5PUaZDwvIKGJpDjigKY_C_PsSkDozrlBL_UF2POjTKEdicLdEn3mw>
    <xmx:F5PUaeZItXn-iuE0ECpKTkbpxkdmxpPKk5_2r97f-KS3iZoliIn7cw>
    <xmx:F5PUaRgvSGQnpc5F6ZdlGrZp7bFAcrpc83g5aqZFK32yFgKAXei4Yg>
    <xmx:F5PUaQ6n_jRWGxiuc0mtjdpxpXM1GGKfiverdJPMGQb3e-90hg0Iig>
    <xmx:GJPUaZqJDeKuhuJSoBTcyrwKekwVVJz-NXQXKgwhnvalBp3ZPC6dy1QO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 01:16:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 15b6430c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Apr 2026 05:16:06 +0000 (UTC)
Date: Tue, 7 Apr 2026 07:16:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] history: fix short help for argument of --update-refs
Message-ID: <adSTEypmnzKNhgoP@pks.im>
References: <ff6a940c-39fc-4dbf-a164-7770c7f26a31@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff6a940c-39fc-4dbf-a164-7770c7f26a31@web.de>

On Mon, Apr 06, 2026 at 11:31:21AM +0200, René Scharfe wrote:
> "print" is not a valid argument for --update-refs.  List both valid
> alternatives literally in the argh string, consistent with documentation
> and usage string.

This looks good to me, thanks!

Patrick
