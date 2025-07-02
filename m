Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08AC746E
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 02:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751423613; cv=none; b=WY7RlHtLX65ZhATAzNxh2NEdWEKqtWpAp/rjrNkW4/1TU9gLKm47HB4URTN5MzwSOIlHHkqyF+rA+QKh4UDp5Zvq2zWsIusgcJeeagwMOtYo0rkwNXh8SY7oLLDxg9mgLs4xExruVxM6D/H9BHm1qKyTFop1OprajFxqKtrwg24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751423613; c=relaxed/simple;
	bh=n/judNrAamOzFQ6nba7P2305sBuXfFLAXU2YM+1ftvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+VPpH6uVOhVLW9Qdcef5gBYNds8V4zhZLr4O9ThMR9/eDCO7swvJ9OweBJaXQ6e4yfyeda9vwkLSYNcEcHtdsBYRHpXwPIIIDtqcChUgnQKD6YJNUvS1L0j79nnKTK5b9Zq/X0jG2BBtA6E76ekCdEUfa9X64ZXcYzgk1UUV0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tR9zymP/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q9qdPwhx; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tR9zymP/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q9qdPwhx"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D7EDDEC04DC;
	Tue,  1 Jul 2025 22:33:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 01 Jul 2025 22:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751423610;
	 x=1751510010; bh=OfXyRp8N60NchscMkDMDKnHUJI7aigCYi680QiopE8Q=; b=
	tR9zymP/EMYQCmB9/azDSPiCYgV/gVAull1mBblBcuUK9nen92Qx5f88v0hNC6rp
	N7kO1TCcFoDqa+pZii9hSNYbCZRJaiWRW4n2zx6uQ71/nlSKkt+uY9l9ge8LbhyA
	Xeb+s3rlz7ZOkbb3/vUewZOgQPIrIU0993mfZX/SyB/CxRqrDErvdrQQs0dgt7Wb
	7bY2gO4oX7vRPqh5KnYBaLduox0KBw2J3q14pA1tZbgC+hHNNv7szX/DbaWPME0E
	ow5VliM64XacwKPgSgHEKFNfkPZcx4rK4V/gzO3jxkyYGwdEOdhbXt+JFEcaQJiS
	08G8IzHsZv9L2/x9pgYIKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751423610; x=
	1751510010; bh=OfXyRp8N60NchscMkDMDKnHUJI7aigCYi680QiopE8Q=; b=Q
	9qdPwhxZ2W8N+xj1A+1cSRwOJj4JoivdgnlTj/FNRTDQOH7D68foJE2TjkE8rvph
	U/sBslElpQ78oghQ003fzNBPMW8phA/F7H+iQU4FTpZcmw0rtBTKfPyaWHNvcBu9
	cWOd03B4gOGscylGKCxy31Bm4acIrkxXPPsWzt6WLN3PvmA/H1mteq6L1UGkT7yW
	Na5aUB3uS8QzFEdZ7/m0bvnjHXmu0jQUjeOGvn+7FnkKViYRlAMSjSLu/MNrjmw2
	OfVapI3oGyT6cKLxJlbAx2RHxOn0NK6fbUDUkT/2H4iO1kx+gmsyZdx+R2MZyt4l
	JXbUclhg8wgznbH0BMg2w==
X-ME-Sender: <xms:eppkaOvbRNrAw5iJ-FDlXJ99oMMPU8q-WXs3VAnUXObRJTI1UnxWdg>
    <xme:eppkaDfhgJsL2-bDlXCxamU7XdEOO44jeYK22DjZzLbOGC4OjGLmErcwuoWkKmh-R
    LGKbXoQ1J6bFx3XoA>
X-ME-Received: <xmr:eppkaJymS0gdVx_s2OEtYVZUUdoy9yAnSxpCZ8dXwlvrYucZanftJMzeYaWoy2LCQdRD0VRq177ynIVZNUbWirMPARvHT5RzV-uOtDTF_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertd
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehke
    dvveetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:eppkaJOEmeQpg9gM71Xa0aNcu966UjnyvlNVObH2otgfXoVrqQDqzQ>
    <xmx:eppkaO9IQTCo8vmG6T6coGj-lmKphqqCm7KCx-Fdhxvxv-2i2katcg>
    <xmx:eppkaBVkjTJD9uZoNPWRDPMZPXweFC2MRli0_87aQW_aaeksHdjEmg>
    <xmx:eppkaHcMGHpDIfxiJBJoq6EMG7saSd9VKkFfVNsF_zRU4hpMQIhCAA>
    <xmx:eppkaKtHZfDeAwpbw_HbQIk86eKI4X4OEHD0brmxh2i1Ug5ToVRwhxil>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 22:33:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 63303f3e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 2 Jul 2025 02:33:29 +0000 (UTC)
Date: Wed, 2 Jul 2025 04:33:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 5/6] parse-options: add precision handling for
 OPTION_BITOP
Message-ID: <aGSadcpxNsp1BLCm@pks.im>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
 <7b970f48-05a8-40c6-8e5b-95ce830705c0@web.de>
 <aGO-kbdAgMMef-A5@pks.im>
 <978e38e1-45b4-4c74-856d-255a87d6c817@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <978e38e1-45b4-4c74-856d-255a87d6c817@web.de>

On Tue, Jul 01, 2025 at 05:21:11PM +0200, René Scharfe wrote:
> On 7/1/25 12:55 PM, Patrick Steinhardt wrote:
> > On Sun, Jun 29, 2025 at 01:51:19PM +0200, René Scharfe wrote:
> >> Similar to 09705696f7 (parse-options: introduce precision handling for
> >> `OPTION_INTEGER`, 2025-04-17) support value variables of different sizes
> >> for OPTION_BITOP.  Do that by requiring their "precision" to be set,
> >> casting their "value" pointer accordingly and checking whether the value
> >> fits.
> >>
> >> Checking "defval" has the side-effect of also requiring PARSE_OPT_NOARG.
> > 
> > Hm, requiring PARSE_OPT_NOARG for what? I cannot see it being touched in
> > this patch at all, so I'm a but puzzled.
> 
> For options with OPTION_BITOP.  Adding the defval check also adds the
> no-argument check by falling through to it:
> 
> diff --git a/parse-options.c b/parse-options.c
> index 6bd7158806..0dc9b0324a 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -620,18 +623,19 @@ static void parse_options_check(const struct option *opts)
>  			optbug(opts, "uses feature "
>  			       "not supported for dashless options");
>  		if (opts->type == OPTION_SET_INT && !opts->defval &&
>  		    opts->long_name && !(opts->flags & PARSE_OPT_NONEG))
>  			optbug(opts, "OPTION_SET_INT 0 should not be negatable");
>  		switch (opts->type) {
>  		case OPTION_SET_INT:
>  		case OPTION_BIT:
>  		case OPTION_NEGBIT:
> +		case OPTION_BITOP:
>  			if (!signed_int_fits(opts->defval, opts->precision))
>  				optbug(opts, "has invalid defval");
>  			/* fallthru */
>  		case OPTION_COUNTUP:
>  		case OPTION_NUMBER:
>  			if ((opts->flags & PARSE_OPT_OPTARG) ||
>  			    !(opts->flags & PARSE_OPT_NOARG))
>  				optbug(opts, "should not accept an argument");
>  			break;

Ah, now I see it, the extended context definitely helps. Might be nice
to point out explicitly in the commit message that it's about the
fallthrough behaviour.

Patrick
