Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF121FE470
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 08:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740126848; cv=none; b=CLYYYZepcDVGbaYi4RmSCOzsrC6lDZTniVmh5Gq4VsCVQsSgoQ/kYw70Y439zUGsnpKPGR8JCwhQm1cc1nPFEHUA3QuwLe0xwl5iJTwrKUv+Hke3//I9IU1AO72B2y61eppZdUxuQlwmN9jf/ZtGeOzWLP1cqbKjDN8Zzc11HGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740126848; c=relaxed/simple;
	bh=kAy+RUajzbofCLOV5NAhL7PBrHMDkTQE/1z3diOj6LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQZEsmBHtjGhOTG/My+MvS2LNt8x6cO0C2jEItTL67ZSIWguweprLqGG1k/c02mnItH8VgU6qYRD3hcKSUhfXPTrbr2J+oZb20npxNZr6DxV5R89OmbAHn/vrw/vDOyhZ2iekYcIaIu8qNL5YruVt5IKSF4f5fI8HXh/qDFqXUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SxFQtqJi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=21WDrS6k; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SxFQtqJi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="21WDrS6k"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DE95D254020D;
	Fri, 21 Feb 2025 03:34:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 21 Feb 2025 03:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740126844; x=1740213244; bh=kAy+RUajzb
	ofCLOV5NAhL7PBrHMDkTQE/1z3diOj6LQ=; b=SxFQtqJiIh/UMwat0zPU5T1Giw
	9qZ74R91h4pz52yb8/kI0effOMoRIRY1/j/B6DmM+iG/eP6EiyNV+1BWvj4q4Jg5
	192aTyOkvIh9thm8zlLvljvqTff1GVVoZC5IEqsaYFHGJQq2MhMSID6XOOfEDqAl
	w0GI7/e8UOWSP24hAKYgQdmgof0hb2EZjFq4//re35B4YoxkFj1w71fsglJg+Kty
	oKI5O5OZLp1SgBAaoYWmPgvdXwww1N9uc57egW8QonYBrpFZEpaKzETrcCVEusm9
	f01vrvXT8qfrLxasT5ZMU2l2BmX7wPRyBs9HVgj5uppPGf5F3tpa3MhS3ljA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740126844; x=1740213244; bh=kAy+RUajzbofCLOV5NAhL7PBrHMDkTQE/1z
	3diOj6LQ=; b=21WDrS6kxs1beZVBA/x58SAIEqb+l24u+1sl2hoBqDi93hA9xBu
	2C3Z+WmGYVopvW5b8lFd1xcZee4NyJUzyGAQi+hwCAvVglSnmek46OqsdJjmXYDa
	6m3Ix41EKWole1nDlF09JtcgQlIjDDDWRxA1KLhSwdLnRjXRhMuMieI5aBwnml6T
	8VyR2kQc1jSazIKauK5x6OQucrpaYvBUN4tCOmhJobdR6ZfmUUD34iSZ8AtamTvj
	ml0yqz08G1kVKVCzggkKyVjN37IX31lPWqz9Uhe4YfZy/zdyiM02hjUa+5drtCPx
	QvynI/97vCCI0nGUiE1JUMSlaNHeSkjD5Aw==
X-ME-Sender: <xms:ezq4Z5qfFhh_e7CusG35L1LbBpDC06LC_XYDWY-scdcGlHY0lzQXzg>
    <xme:ezq4Z7ps9IoMOvsKOJJDeAjZ-2X7L6aCd6gD-0kmAaNQC3zy4nVR1hyXKeMIKEj21
    r1FtCuggfzIHI2A9g>
X-ME-Received: <xmr:ezq4Z2O_mUI3LwQmerEWeeGdD5bpLwAQVMSUj3YYpC81dkhZr_1IN6Vb7Alq0wPigk0dyIljMvEIwYPzpeIHpOQQ1U80zUp2RWPQZ5dXMlXHZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhs
    sggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgt
    phhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprh
    gtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:ezq4Z07bkAvTOSVIelArxw2gRp1RMODdGUhC3MP9NTJZcX2hLsMITw>
    <xmx:ezq4Z4444R162IfyXOUcvV1Fs-4y2Msfx58azb_XyVEIk9DVWpV8PA>
    <xmx:ezq4Z8hEg9l5f3wZVXAoYLnD6hekz_wtGVjPiuW0EzJS12F4ww1_bg>
    <xmx:ezq4Z66Krde36wwiBvUWuzX5-UuOpGrIotNSetF8zEHGL8uJkrHE2w>
    <xmx:fDq4Z1wKX8lL7_W_YKo03CiZTUUV4P1htURPPMizkRUDlTepndsn7tXv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 03:34:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e9471ef7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Feb 2025 08:33:59 +0000 (UTC)
Date: Fri, 21 Feb 2025 09:33:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	"Randall S . Becker" <rsbecker@nexbridge.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 3/3] doc: add technical design doc for large object
 promisors
Message-ID: <Z7g6c8dS_Ttt-T9r@pks.im>
References: <20250127151701.2321341-1-christian.couder@gmail.com>
 <20250218113204.2847463-1-christian.couder@gmail.com>
 <20250218113204.2847463-4-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218113204.2847463-4-christian.couder@gmail.com>

On Tue, Feb 18, 2025 at 12:32:04PM +0100, Christian Couder wrote:
> diff --git a/Documentation/technical/large-object-promisors.txt b/Documentation/technical/large-object-promisors.txt
> new file mode 100644
> index 0000000000..ebbbd7c18f
> --- /dev/null
> +++ b/Documentation/technical/large-object-promisors.txt
> @@ -0,0 +1,656 @@
> +In other words, the goal of this document is not to talk about all the
> +possible ways to optimize how Git could handle large blobs, but to
> +describe how a LOP based solution can already work well and alleviate
> +a number of current issues in the context of Git clients and servers
> +sharing Git objects.
> +
> +Even if LOPs are used not very efficiently, they can still be useful
> +and worth using in some cases because, as we will see in more details

s/because//

Patrick
