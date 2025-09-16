Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEA618FDBE
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009089; cv=none; b=KVLin5yg+cRLm03aqFvuzq4Y1akHxb2jLVjQr5CrdIkk3CYzHCrv3iTzbXz2iE5vmiV3ZDZ0wRvuI17ErXZBJmeiL6ulnqob8ZsyukS0d7d14n00efjMlcBHhVstJWeylJeobEDf3seakasD6bAuC8qblJ1aWtLD0XIKoyglx1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009089; c=relaxed/simple;
	bh=ukMqGgy5E6xuqDtzvTvshzTOFw3T0bGS2ek1veKRQvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJ8A4Ll1EBtHUp6+5DlMN0N+WfhcSlQ3H2p+0YO8Md2kUbHLkMCaC7x++mGJ+utDXVvUmFYMXBVMpgVR4/rsYA1jgqzxe5ehrBAobZIoJTJl6r/RrEwWvIYSY3RguzX7hfLLWsIRRbMefGP1P3l/HyS1VYwO7nXQ7+syyNAIpV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aUd7cXvl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NHVtRhd9; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aUd7cXvl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NHVtRhd9"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6CF5F7A00E6;
	Tue, 16 Sep 2025 03:51:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 16 Sep 2025 03:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758009086; x=1758095486; bh=i9iSjEfcL2
	ixC0F63CVri+GaLd/Tgx1djjP8uh4r7zA=; b=aUd7cXvlU85qk9z4T9gJRjj3+7
	kGEg0E4L0n3EznOSHPnBoCfvqa1RUa4/AMeF00cVTFLzyDIZmbk1oXu7GPCkwRWG
	eHZyUFMZQufbPPAF7SHIk4RvfO4kIQt9+TV1cjQg/CZMjy5QtC1iUwK0iOYYXjj2
	8OXzhWMKpinLnQeZ1a8xwKJuG4ElUmTnXCJOOQEZEPce1L2y0E4H6/RFDvmgsxjs
	0fOQKyuz919aRxSjNO1p8sLF/nVsU6WgKjD9bblTqidteRfajxl+ym6K3QZe2Qwa
	I9qXZKJGsfaJ5vuW/myXg2kNdq9cJhNaNCAoRtcKOeiLzsyiPc3EfQTRmFTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758009086; x=1758095486; bh=i9iSjEfcL2ixC0F63CVri+GaLd/Tgx1djjP
	8uh4r7zA=; b=NHVtRhd9fMNsJtJm1kpZQM/ksdNKG6SffdRp9MAjVDZ7jBmnmc+
	8SZuVMttLKLRFQgxJ+WoKU9EkwK6SBj2BpKUgXrs5U2HH2BCaBfcThTed0m0qlIW
	3r6XKrLtqCdNFFB1Zh8LuushravbH/aAb4c16qPovAAfN5ipv6IIjEWc0NB76nbL
	aPXgmD+nqs8VG/iWcbj3/5JSBgvWlRKkpXoAF5Brdz5bqL1kvfGqZxlAC0FGuXq9
	4P1PXrRW19VRoDHf6MAG1h0ebruZo/NHNC52ibd781H59EgvJQ/j6Ot7E4AuzLXI
	wXoaxD2wO+/WGDWIKG9CUfOK1rlMxPPj6TQ==
X-ME-Sender: <xms:_RbJaBNPAWmexjd5RkcHUcZwGoNhzp7xICkJ5NFMWg6htFzjWcDCTg>
    <xme:_RbJaPdPMOXtJ2AiqW6buTEwPpdInff_XqS5IGN38WgHCYt9jfsz3uXdhG7zlqBXj
    upE3S-n3HPE8mDQUg>
X-ME-Received: <xmr:_RbJaGsgv2xeOwXbA9K0sUSlWI3117uQGK_lCr8qOyrDbMlIV1jMpztYSX1WL3Pyg-g3UN5Onx4Lo_IxAkgKly8DK1gYbdSZf7ERbU1Z_x4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegtddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehjohgvrdgurhgvfiesihhnuggvgigvgigthhgrnhhgvgdr
    tghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_hbJaImsOuZt-0OuiezwR7EfOwlk_mEbcSuLJFQe-v9i-2YkS9gdiw>
    <xmx:_hbJaAzmRp7uDf5AYFIdLb2wa76p-fxu_HYksUrFz8AEN6_BU0pZsg>
    <xmx:_hbJaCMDKOiy_8OOJYFNokX6ElYEBS1u0MElgfv4kc12cM1ha_D7Sw>
    <xmx:_hbJaEoJkAFtU0PUpU1tCgSD6-nsgDfajytjwj8Dg-DTLocccrmNlw>
    <xmx:_hbJaDQ_4fEu1K9k0p7OzwbjT1wOi1VgfLSEG20VEuX56PJS1nmVWcfA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 03:51:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d1705109 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 16 Sep 2025 07:51:23 +0000 (UTC)
Date: Tue, 16 Sep 2025 09:51:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, joe.drew@indexexchange.com, peff@peff.net,
	gitster@pobox.com
Subject: Re: [PATCH v3 2/4] refs/files: use correct error type when lock
 exists
Message-ID: <aMkW-HOAsU8YZ8Lp@pks.im>
References: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
 <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-2-195569740b57@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-2-195569740b57@gmail.com>

On Sat, Sep 13, 2025 at 10:54:30PM +0200, Karthik Nayak wrote:
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 01df32904b..69e50a16db 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -797,9 +797,23 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
>  			goto retry;
>  		} else {
>  			unable_to_lock_message(ref_file.buf, myerr, err);
> -			if (myerr == EEXIST && ignore_case &&
> -			    transaction_has_case_conflicting_update(transaction, update))
> -				ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
> +			if (myerr == EEXIST) {
> +				if (ignore_case &&
> +				    transaction_has_case_conflicting_update(transaction, update))
> +					/*
> +					 * In case-insensitive filesystems, ensure that conflicts within a
> +					 * given transaction are handled. Pre-existing refs on a
> +					 * case-insensitive system will be overridden without any issue.
> +					 */
> +					ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
> +				else
> +					/*
> +					 * Pre-existing case-conflicting reference locks should also be
> +					 * specially categorized to avoid failing all batched updates.
> +					 */
> +					ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
> +			}

Tiniest nit: I think it would be preferable to use curly braces for such
multi-line comments. This nit isn't worth a reroll though.

Other than that my feedback got addressed, so this looks good to me.
Thanks!

Patrick
