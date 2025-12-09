Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1342427280C
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 08:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765267474; cv=none; b=LLev8s8Nth5zH8meGEiief2lut/xCAeP7KDa1OQG9atbhSOZ3lmyuXDglud8unm77BXeKYQ9kYB4UuMwjXmNVzeIRM0ecVaRgzsclEmPmkHF1WZ06kGAHGoI6TQnL8VmdrDGzBH1hS+fPWHkDtTRsKoHVb6uEWWtq6rJp+cSddk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765267474; c=relaxed/simple;
	bh=hFpmDqIoLBAzx279TC9YigPf2IpJiFYiM0Its3XNBVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDOss4msi8DstA5Gu0DvRczHZziqyjTNdroqGT90m37UG2ddQMYDie8WhPQI0RnLO7ncPcmFYSusrd57xOU46yLW5zO2T1GXwg/PEI99l4NWXiVfZSedmW+s5YYyx/hVPdt+9p7nNNmpx4zq6S2Rx51xl3vyJ9P/22QEVzs/ETg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ui/Pm8SR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nIzOtczS; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ui/Pm8SR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nIzOtczS"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1893C14000B0;
	Tue,  9 Dec 2025 03:04:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 09 Dec 2025 03:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765267472; x=1765353872; bh=D4qK6h/+0r
	g6fw7Z9uUrC4eqoCNrIJ7RxSV9NDU/ZFA=; b=Ui/Pm8SRI7c0naL6vKDCIVRLGs
	PcTEn/W6jbAPL4sX9b6xuBiN2oMC9HBUm49G7CVNlnm6UAEZifRrHOQw2OO2jFb4
	O7iPskJqfx7V32lkBk/o+1R9fvpNcKNTWSUDa8fR82h6giha0XaUsuFihiUsgnte
	nwpnAhtTAlYX6o0cftqcJe8Hwn3w1X7scUnRq2mg/6bmBlElFiQXHgyoeXRq9wte
	Nz1j/DXsGpkNlZTDdQcJ9dG4frVcwO/9+bX+Pb29YzgEAjNOEUXQSV5yrVYxg5Fi
	FQQDqM3YY9ujl+0Gl100Bub0lap4UTAZa3rFyA4PXA2t+XWyQPY1DCK1x2HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765267472; x=1765353872; bh=D4qK6h/+0rg6fw7Z9uUrC4eqoCNrIJ7RxSV
	9NDU/ZFA=; b=nIzOtczSu0aAxNOCBL8T8vLX6Bjsk9sSrySakRORmTWgi4FgRwh
	CPgiZJWfl11U3p6VH0EpQXW4gaXCrXReDAOhVG8j6zL0uL5UX9LyPt+bHwJdtBaf
	KLOr5ArsTGLr9Jjgs6kua3B4APfVAB7OMWPLNGoCt4WD2zDptFvvvbIfFFVPn3Yu
	r695MLrhSf+bzMuDtvTmHlo3w2GhsGaiLJG6yevgVNmzKYcSokjeGHZ/7qIrQTse
	DdBpUNJ7y5PYz9/r44WoULHiQJOrH9JVZ1ncS6UVWW75dvrjKtZRcnBB1VCR33fV
	khQ2IDSXJZm/90RwOKIhGYYksoEB4AqV2xw==
X-ME-Sender: <xms:ENg3adH_e-kWTEyg1NzopFQFO1qA0-8q0qqxpvwY5pqkxEqpZjPDww>
    <xme:ENg3aYVR4bxZgK1_zdTPSo4ObTWg-QM_bdrz0QSUiSjsi1bwK_siYKuU33n4O1-5u
    7ymy5hgjir-sHLBitCocR05bvoMdHMvuiou1qlLZj2Kb-15K7Q9nLU>
X-ME-Received: <xmr:ENg3acwpEoyXgiRc34sdZOfPhwXMgDKz7AX7md6cfpW6KD8SB51yoNISIDCkqdcV_IL1wjsgvY1eFJfsUA2M5LDlXojT7q2ol3raDoaFBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ENg3aeNcM40Kf0uv__se_s1qMSEFgwQsy0koutcd4toYXWKd4a6gTQ>
    <xmx:ENg3aV78XKnZJbjXw30ELWj1N5UZdjaxhPQaMG_Tczot_1HsnP37QA>
    <xmx:ENg3aXPTk28yjtTXyIPeoBJCM2tq4XeRrZQjnxLdSVEOIqXkNwfEMA>
    <xmx:ENg3abkMg9W-Y7gXblgpH1FbhXM3DaNoBnGecDYiLOJM5mhbIByvYw>
    <xmx:ENg3ad3PStP1LbG190xIEElzBtnjQ5QT5AMqjbrUOCh-92sS9Y6XosVp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Dec 2025 03:04:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 24a62dc8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Dec 2025 08:04:31 +0000 (UTC)
Date: Tue, 9 Dec 2025 09:04:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/8] odb: move computation of normalized objdir into
 `alt_odb_usable()`
Message-ID: <aTfYC5DnxYx2qdPG@pks.im>
References: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
 <20251208-b4-pks-odb-alternates-via-source-v1-3-e7ebb8b18c03@pks.im>
 <cqrno3lfvbfrb6ieestagbs5avshs7znoumky2plvtc4tjye2a@onwb5vmtstbx>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cqrno3lfvbfrb6ieestagbs5avshs7znoumky2plvtc4tjye2a@onwb5vmtstbx>

On Mon, Dec 08, 2025 at 08:34:25PM -0600, Justin Tobler wrote:
> On 25/12/08 09:04AM, Patrick Steinhardt wrote:
> > diff --git a/odb.c b/odb.c
> > index 3ffeece567..2513457a31 100644
> > --- a/odb.c
> > +++ b/odb.c
> > @@ -89,17 +89,20 @@ int odb_mkstemp(struct object_database *odb,
> >  /*
> >   * Return non-zero iff the path is usable as an alternate object database.
> 
> While we are here we could fix this typo: s/iff/if/

This is not a typo: "iff" generally means "if and only if".

Patrick
