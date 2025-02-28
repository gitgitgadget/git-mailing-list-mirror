Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DB0266F0F
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736888; cv=none; b=KdUGywrYGK//w+eHhlLs6v+c77GLuHfPUWxwD6sIKwvSAmyJti5LEDL5yxu9s5c92nQ57IucY5elwd1eVbAVRrfMo/zY4pqC6m+fWI/bvklOOIDj+osDUeLQHDS7tF1rcja9VMg96oYSHl1KwfpLu8LbN17+E2mo951Rkl2a/xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736888; c=relaxed/simple;
	bh=wfGnR5ANUQaumsUU6/gGyg+YjbSU4yQZPhVuzA4OODA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2Vp+ogzFCbmuvMdDj65ufuO/694ar6SEyIkrpTnJwMS6tdsLfAP7W9YzCFPbeW3SLjoVmlU200SJezU1SqGkYl70mVfMB2bMuxSEVMXFfFKsRoikMdtq4LNbKxtakfh+VKggHyEquZFllAPof+NjhcCmw2zsZJCZuIp8Fzajlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IL/Q9Jg6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GUUhCLC1; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IL/Q9Jg6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GUUhCLC1"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DC82B11400F6;
	Fri, 28 Feb 2025 05:01:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 28 Feb 2025 05:01:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740736885; x=1740823285; bh=IMfPyGCdbz
	vjw0OcmJ/Ylyr9px2j+u057eGx3Ltj1uk=; b=IL/Q9Jg6VcZ0V3Op6tejg6eFuO
	OQKFb8rL6skzxbNM+a3yAK7P1wVgNVqHfDcpqe1qi1/l/8hNeQLJh8OjpSy2QM9f
	MU8uJKYOkr0RgrppsA9bgCOPRZwoPWL4Sqht0NNHbWyUH8JYPnmqeh52u3o3zaLU
	PLSQ3aTdZ/vM5wrJsJSJt4wCkxI7VbCHjPKIjy4mBAlhbmuY6w4tGb9irSVjEXcK
	hL52qphjuDh5kRcrdt893CE9UgKvcj4Xd/k8BF4PJGBmeYgk62CvEr02VNIANNJy
	9TULo5kiN6Bf+g+CvT+m4Ain11KNl5Ao029qgDvPUJsgqjwSU1aZa+8C5Uyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740736885; x=1740823285; bh=IMfPyGCdbzvjw0OcmJ/Ylyr9px2j+u057eG
	x3Ltj1uk=; b=GUUhCLC1ZbXr+jRvQL3yZlYkmHK3/k2NsWh5xPjA1BtF7sa4qRN
	wOSotEtb8AnQ8mdCHz2xu8x+eWcpsEeLzxprNF1xReAAnZFveObVNvbNcr6B4snW
	te2uV5AiNoj2lVmTDFJZqYPwo3RfX4mdLg+A7zISQ1nesgxpzOyxAdCLzrFHekQx
	RSX5Ep5ZYb8XPFBHQs0w19RzmRe9mzdrpfPXOYUmK1waiRMzizS+gVYSfqidILIf
	doJEFEjmI6eZsSRL9Sk+zVZwteDfim1V/BJm/IUzG/xi/ynsxF43+/tQm0oVGlwq
	pshKY70IDXG6cEjZTNvRT07S+hiAXYLlX/w==
X-ME-Sender: <xms:dYnBZxCMOPjmF06TEKmWHDvIAZr0hceKKVhGMtNU_Q1HKn23G3QUyQ>
    <xme:dYnBZ_geoMSCCDHe5Y8qTTEmSVQapdp8ubsZeKV1pGqHbJBOYgQFJYHcnrVCBEtPP
    ggSI4Ra0jhfMo29yQ>
X-ME-Received: <xmr:dYnBZ8lXACh8HTQYOAYBD_DjQECB2TkxltJvXIFSzatzjrRVQMUo1pCcz7Pt7i1ylFJkNJMt30HBFug6w6rc85-ZDL9il09q7MDjjRnjC0GkD_as>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:dYnBZ7xiM9cb-XGxM2UtVKi2kEWp8CFHEVPywpXfILNmq1-Cgmfjvg>
    <xmx:dYnBZ2S2KRWXeDXvg05LvS3tUD1kZrL2DGmHgWw5GFKIX6-B6HHm6Q>
    <xmx:dYnBZ-Yct9lGXIvUmQHxTG9D982DBI5HA8AVVE7ky7OMYOd9-SnCUQ>
    <xmx:dYnBZ3SDk8H1nW3wvam_Plmp-cQRPAVVOzpDac9yzzFujn3VqSTdXA>
    <xmx:dYnBZzIXxqPdU3Q8BEXbTYzMV10granWd-5DYZc5XlM4LGI-2SZQmv-d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 05:01:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6e087448 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 10:01:24 +0000 (UTC)
Date: Fri, 28 Feb 2025 11:01:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 06/13] pack-bitmap.c: support bitmap pack-reuse with
 incremental MIDXs
Message-ID: <Z8GJc6iDqueVgc67@pks.im>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
 <c8401fa0fbdbf1fe1422cb3105aab2cb8058f331.1732054032.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8401fa0fbdbf1fe1422cb3105aab2cb8058f331.1732054032.git.me@ttaylorr.com>

On Tue, Nov 19, 2024 at 05:07:35PM -0500, Taylor Blau wrote:
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index c2c824347a6..1dddb242434 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -2347,14 +2348,18 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
>  		uint32_t pack_int_id;
>  
>  		if (bitmap_is_midx(bitmap_git)) {
> +			struct multi_pack_index *m = bitmap_git->midx;
>  			uint32_t preferred_pack_pos;
>  
> -			if (midx_preferred_pack(bitmap_git->midx, &preferred_pack_pos) < 0) {
> +			while (m->base_midx)
> +				m = m->base_midx;
> +
> +			if (midx_preferred_pack(m, &preferred_pack_pos) < 0) {
>  				warning(_("unable to compute preferred pack, disabling pack-reuse"));
>  				return;
>  			}

Instead of completely disabling preferred packs, should we maybe fall
back to the preferred pack of the next-higher layer?

Patrick
