Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3EA1C84D0
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774067; cv=none; b=ldkiaMCP4Vycka8ew1Ds1e0RJPlJv+Wk7uAWp5bQpdML7xSb8gdMXNtWcFW67eG28lwhnIK6rewiS8BeRwD6noGtcMyxCoa8/t4ACJTf3077Piz5l8ThvWCZGmx7WoQ45j/foJ4xyo4sTFA4CHaPCUaV9FJexmPJl8r83dGAnpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774067; c=relaxed/simple;
	bh=xJK84kNmwAe5h99kaDnpn+IVS6/RmazEvr6+tuDpryY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=id/uYbPm8/7TPGyDVYgGo5gzed8ZDDXE6Ey0vRiI6Z1NcQcGjaDFaqTCrAAMwuNKzAaVYmyHeIf1pXZ8YGBtc+nDuhBoX7SKBrfTCJjTDo0W73MjIsx6lxCbtD6MI1501s8wFklymknRsrH3LCfqccnK3a3pYo4dr2JpJvWv/oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GqhGlhm3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ttZr45sH; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GqhGlhm3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ttZr45sH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 41CFA1400154;
	Wed,  7 Jan 2026 03:21:04 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 07 Jan 2026 03:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767774064; x=1767860464; bh=lEidYJB4Py
	FbcyMi8O1UAgTxFVRkBeqE85j9cD9DFR4=; b=GqhGlhm3hbmNO61r/f0kfuE/Xu
	xgW7WHRvU8IT3eLJ1M62ySzlrNAkE0k0uJpHfecD5dTeO5cwyokZ5Uw7uk/AA++X
	m2NSMaE1JvZEIi/U5CJqKKEUXgF0YxFG1S6J7he5/47bJkmHcyc+jM0V7lQFQqZW
	cwz9aTogBavaOR4wWSbBahxUaDpg7/C6tSGiADqgceH3sOAutiV0Fkk+4egeMSUk
	qghYGGXqaaniR9wvnc3LnqnHln0GZ0jv2hThPtQ/84cB9EdFnq9/m2m+FQ4K9JCR
	PQha8bDd4XbUAWIUTj41591OKCgXP4LcY7Cz0FbeufAUOzrXrgyCfaeJQoeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767774064; x=1767860464; bh=lEidYJB4PyFbcyMi8O1UAgTxFVRkBeqE85j
	9cD9DFR4=; b=ttZr45sHPggkQvRpKwbnBtBLtUAtLkDMx6PcrT8Ia4RNqHEY69a
	YjUmCcW9kupBQeP65hysF8OdbkgIJvqJS8EdY48cVxSyIkdzb2dUtZGPVkrtep/w
	ZStidZyUK3SrzaTAPMFySEfKdeVSuKY8YZ818JJq23lEgm1eHQ1BlVRQrNPw7Rt8
	F1TB2vK++ak4y8jWsBMRXiD0W2SvZ7ysZ0BsGqbBhbnXBs2LOZahjDsuksHyPhXb
	L8KT24cALmWd6oKYzdJhVqoC2KsuhkdSLIQwTXEfeq5Ek6TNwj4ECxEI7agRODmH
	+GhkPofhmbfiPaHCoBKglpnu3mGEwzrodnQ==
X-ME-Sender: <xms:cBdeaRr2o9pdPQO3hu0nDypv3Mt9boIohrvxvunCLqy6tNOpQc46_Q>
    <xme:cBdeaZrEdqv369MEiFa-HgsmyoTL60yyIgr1vLkoa0_r0D3sRPlLbym5gZkShQ-G9
    Slhq3YX29WKsjUVGZXmHzsNzThxBLEaeERe6nw3vKmO7F3Svaxd>
X-ME-Received: <xmr:cBdeab0HdbQzix7y1X_iGDgAyErzyow_Xl2Y0WjnjmoHa66ViNv8j4xpwkvoTKZEqIet-dyVrfR61CkS1oFplJ_NTg8gViKDy6lJIM1YQzI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddvheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:cBdeaYBi3ioWexZEqa8OxAmRafkURo1ufUMl5rqWO6JbJy1UgOzDvg>
    <xmx:cBdeaTdu9cR5uyEYyZGwk4D659FY_KgrHUwkqTbE7LpLg1zsfLbvaw>
    <xmx:cBdeadhC0UcN1Ge3bCjGL007sDVwmSPHrNIpXBmHH9dIUXLiano1tw>
    <xmx:cBdeabo43GC9e7kMHUUxr3JRyBD8n8SNFDnhUsVQNSv7mY8zIVLTfQ>
    <xmx:cBdeaQLGxQgBID8gEiEKe7OmNBUGRQgBzQZ4let7KqaQsQwF-oB7elFg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 03:21:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 426cee31 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Jan 2026 08:21:01 +0000 (UTC)
Date: Wed, 7 Jan 2026 09:20:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] cat-file: only use bitmaps when filtering
Message-ID: <aV4Xa9ceY4ahYj2m@pks.im>
References: <20260106102558.GA68914@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106102558.GA68914@coredump.intra.peff.net>

On Tue, Jan 06, 2026 at 05:25:58AM -0500, Jeff King wrote:
> There are some timing tests in 8002e8ee18 that claim the non-filter case
> is not regressed, but it's not clear to me exactly which commands were
> run. Given the size of the repo there and the fact that it's more I/O
> bound, I'd guess it is using an output format that requires looking at
> the packed objects.

I honestly can't remember anymore, either. I really should stick with
the actual command run in the Hyperfine benchmark names.

> You can see the mean user CPU does jump by almost 2 seconds in the
> timings given there. So it may be that the problem was there but drowned
> out by I/O noise. At any rate, the new t/perf tests isolate it better
> and reproduce consistently for me.

Could be, yeah.

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 505ddaa12f..3cb725940d 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -846,12 +846,14 @@ static void batch_each_object(struct batch_options *opt,
>  		.callback = callback,
>  		.payload = _payload,
>  	};
> -	struct bitmap_index *bitmap = prepare_bitmap_git(the_repository);
> +	struct bitmap_index *bitmap = NULL;
>  
>  	for_each_loose_object(the_repository->objects, batch_one_object_loose, &payload, 0);
>  
> -	if (bitmap && !for_each_bitmapped_object(bitmap, &opt->objects_filter,
> -						 batch_one_object_bitmapped, &payload)) {
> +	if (opt->objects_filter.choice != LOFC_DISABLED &&
> +	    (bitmap = prepare_bitmap_git(the_repository)) &&
> +	    !for_each_bitmapped_object(bitmap, &opt->objects_filter,
> +				       batch_one_object_bitmapped, &payload)) {
>  		struct packed_git *pack;
>  
>  		repo_for_each_pack(the_repository, pack) {

Yeah, this seems like a reasonable change to me. I would've preferred to
avoid the assignment in the conditional, but other than that this looks
good to me.

Thanks!

Patrick
