Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252891E1E16
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754400485; cv=none; b=bL4wvFNJnsvHU9HRYI7bfe36fyiaev5Pm7f70ZOruc/Xz0kxjRL+wZeGsJDfutat1KAZngMzhNxnfsSjgT6ltholqzEw87F30y6KONDctyUDb5R6JuTncM5EyG9zTtRo7+pUb8lSUowOX8nk00KswOlwVxEFwFtoOywAb6P8WYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754400485; c=relaxed/simple;
	bh=/ndxJ8s6YTRsnO7mkxiPEygL0VSg7fyKabrHJTwW4M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAlbJx4s00q3kHNaDGpJUFIXPrevB2XVwW6Un7nO8y4mSDPnrtdmmedugKuSVwkej9FqDfvrahfwLOqYxNe1W+Mwy5uPzh7XlkjY3pUAklAQ2XBCYynXsEjLAL6URbnjTuSP2ZaU35Un8GCplTxuvxcZOdIQ5GonFtp2PnFP56I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VrbqjUuX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xx841zMx; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VrbqjUuX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xx841zMx"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 4D5BEEC02C6;
	Tue,  5 Aug 2025 09:28:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 05 Aug 2025 09:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754400483; x=1754486883; bh=kT8Y5QasM2
	tDkvEeVuwh5FfSVfZxioIulCBoV5t+H88=; b=VrbqjUuX33mqnC/6MtWkyYolXw
	x9rLATZFJNyC858tP7oVNN/hbDwU73bkh0mmogz12R91+1lurKhU5MSL0uBAVe8b
	7aOWYIdPFvq2Zbsq6SL4oERHM8F4hrhw8DkObbrzWQQnp490G//HWODDRVMYugxs
	Nmat/zaNqsdR+x3fa5O16TspZbHeHqk+heIGH7ygu9kJFIPpW7DEYAwpgeXTJB1z
	0ZiBE2xA2NnxdUsSRCuMX96AX7BbmtSmTph0uN9PxmI+XO0ajukmuG5Mr+OqRab2
	/Qz/Fx2VF6Zd67y8/AJFfDLmrKAD5jAkRLWvHNrHwVLlCwPgjQ36aqvRWy5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754400483; x=1754486883; bh=kT8Y5QasM2tDkvEeVuwh5FfSVfZxioIulCB
	oV5t+H88=; b=Xx841zMxXaDwQzl4dfoCXJLuX5vHgUhneQFzJJWBryHMRgM8p9g
	C/8nNZ/6828ZLoIJgVcwkGj7OitN6TYmyW8jyKCD7uqdOJA5PkvCN4DsztHpghYn
	/WmI5GDEL41SdxoSpn75PDSQWM5ozYKMWtUCAb9x8uKURNvBq3I9AZmtVlqjOE5+
	hHXyFRPj3JmsG3lraXRmf8qx63zcUCB8rc7051UwbchU3nj/SfgLE805GXksDACj
	bm5z2wvS12qHLyPQ6LeOkwMWAdLQ2oJpetL3ATb++1demUYMOBzIyIQ30nOjsbY4
	1qK9sCPrA91LE9jM+wlgAaUkhenKCE5/Gtg==
X-ME-Sender: <xms:4waSaDWNA6PJP3BaW_x31Qz8WS3glUmkaL8kmdO0tobppFNB3Cvpbw>
    <xme:4waSaO3FuvAAGX7LAF9Yf-ajmJLu46Q8lid-mqMJtMQb4xAEVCfZZFoXHXBiSo6nT
    _7MkC8luYvMDucD-A>
X-ME-Received: <xmr:4waSaI23nzKQi8sbHfCBjIO1MjGw1UZRIinPIw0aHmfrUfKFINsbLDl8-rY1OQ-fnhwupSarz4LNMiprub3mLoIWIDrw9_xMZ8juUG0BJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheplhhiuhdruggvnhhtohhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:4waSaJ9QR_Osf_kgFwyMvNXSo4KT5pFHAhEARrdBUab85R-ZjnZ_Iw>
    <xmx:4waSaN2u8eYuTIzvP5Z2zZthLDC912NF_sA5Cr6NR-S96d7jJphgtA>
    <xmx:4waSaO8Lkb9bbxMO4Ni06GXqvXkvXSwiQbGX51neX9LTeQVEpgCIBg>
    <xmx:4waSaFuP_Yb33ZSce6qpl2P4Z1ukYWJtx-h8IAarbQMm_lDikGmJNQ>
    <xmx:4waSaLcEXPhFB9emrduXqvxP6HVCqa73VUCHT1F3oMdEDGgxvX5MTGUH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 09:28:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b6431c08 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 5 Aug 2025 13:28:00 +0000 (UTC)
Date: Tue, 5 Aug 2025 15:27:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Denton Liu <liu.denton@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] remote.c: remove BUG in
 show_push_unqualified_ref_name_error()
Message-ID: <aJIG3TNq5eSzwSPX@pks.im>
References: <cover.1754300389.git.liu.denton@gmail.com>
 <cover.1754375026.git.liu.denton@gmail.com>
 <2bd892b26c94133cd1a266d6ff4f2217418b0660.1754375026.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bd892b26c94133cd1a266d6ff4f2217418b0660.1754375026.git.liu.denton@gmail.com>

On Mon, Aug 04, 2025 at 11:24:40PM -0700, Denton Liu wrote:
> When "git push <remote> <src>:<dst>" does not spell out the
> destination side of the ref fully, and when <src> is not given
> as a reference but an object name, the code tries to give advice
> messages based on the type of that object.
> 
> The type is determined by calling odb_read_object_info() and
> signalled by its return value.  The code however reported a
> programming error with BUG() when this function said that there
> is no such object, which happens when the object name is given
> as a full hexadecimal (if the object name is given as a partial
> hexadecimal or an non-existing ref, the function would have died
> without returning, so this BUG() wouldn't have triggered).  This
> is wrong.  It is an ordinary end-user mistake to give an object
> name that does not exist and treated as such.

Yup, makes sense.

> diff --git a/remote.c b/remote.c
> index e965f022f1..4ad20110e9 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1218,8 +1218,7 @@ static void show_push_unqualified_ref_name_error(const char *dst_value,
>  			 "'%s:refs/tags/%s'?"),
>  		       matched_src_name, dst_value);
>  	} else {
> -		BUG("'%s' should be commit/tag/tree/blob, is '%d'",
> -		    matched_src_name, type);
> +		advise(_("The <src> part of the refspec is an oid that doesn't exist.\n"));

I think we should rather say "object ID", as "oid" is an abbreviation
that might not be immediately obvious to the user. Also, should we
continue to mention the object ID? Otherwise it might be hard for the
user to figure out which object ID doesn't exist in case they pass
multiple refspecs.

Patrick
