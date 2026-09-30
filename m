Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC3D4CDDC6
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 12:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769937; cv=none; b=lwyj7U9onurmZuhgxTWv5rbVDHo5kg19lNYssByU8SaSwdexIP7xhEC4jjfnzkY4H1A32/V1AZpcEEQ1r9e5woM5S3f0IjPJtQ1a4wZl+FKx5Z4Q6RBiSVLn7y4Xwrhh9ZZMP+RlMsribrWKYewHCoTMHlwG7eiAZbnHsdS8q8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769937; c=relaxed/simple;
	bh=JEJLVZ7eUohN7wmZFRGd9DUtRkvUmVLsz7CVwI1rT10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lI4dnvXhgfjRZ5enYPsPc0To1VDyFXZ/C9Mdd8KaQoklqcIR1yNXy+nkaoiUmf0EZIsOxmT8SYIhPqrPNyREwojgieCakZ9rQGqWnaelC7MaTOMEFDHjHSTOLhM0hv/VKgxa8kFkDRIZTcMSWGZSXkaU04CEyhRq/e16x/j4epE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bAURgcvy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vGfLw/g/; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bAURgcvy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vGfLw/g/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AFC3314001A1;
	Wed, 30 Sep 2026 08:05:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 30 Sep 2026 08:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790769934; x=1790856334; bh=VO2iEbKisw
	avJeKu/IQZvvZjwEFtQDEtbJIIZjDcAuA=; b=bAURgcvyeM6WV36UyfrcHz1pZX
	T5/CG1J3ZYTt2ELtl7zAOZJbd8RXXU83PUWxr4HPiYlzGI/ZuKS72YWiG9EhPWgP
	cGco0BFuV/SFlFc4nmFYITvkkXiMfOA5//SjguSZw0mNlz9Gip/miqc6V6JA+M4K
	WjCoJ7lotv1/k7RQhk7JdtvX7NJcFA8H+wzYn9P20/OtBvPMrn5g5WtQNTYG1Jqs
	nV2oJZcJZSjE+IaHzWe79QgL++Js6bkhRMYrX03atyYtKZNQ3TwWlEHIFCnemgVD
	jcT8QsT5OouiBSuoULZdjf+FVKWCIm8hVeyttawa5Ha/Q+xSQdUQlCmhp9yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790769934; x=1790856334; bh=VO2iEbKiswavJeKu/IQZvvZjwEFtQDEtbJI
	IZjDcAuA=; b=vGfLw/g/2izVkBkBPFh2GFO2/NXYGoymsVaMqa99cHz1vqYDUUS
	e7EJItM+7K4YrMzN3Vx1A+ijkr/ed9mmstiuhbfUUZ2Fu0TsEfXAkLkRGhXz7G0H
	TXSMDdXOEsCE0nR9yQZTPeOZQF7Z+qxdV0u+vwq/O8PwxbuQd/ml/qjQzi9n4rsX
	BxdEg+GAkwvMZ188fYZjFmm9Xir1Y1ucC8YCHG5VUqlPI3MX5Bw+DDyNrVF0URAo
	xGBj1cWAjupoSkkWyoo6+p6CHjGxrS6P74KxXu8IYxWdkLIcG3Gmp2OyPeSpUWJD
	FVLmVnTa+H7WcsFRFhYwMmxJLlMGzPYXjKw==
X-ME-Sender: <xms:Dvu8asItWGOEjBUJcC4Db80jIsTdYouQkpPKfc-JvQUzmWsDmJ2iCQ>
    <xme:Dvu8ap_Vn8nJ3GnJRD5NQul3er8KyECnCYvr_MM363vyaf_d2Yfi8ri7jr9EeBQRE
    neERZFJuAZW_9PokF-f4gU3Xo88i_OkKyja10HJA10fQ3TwJcz22P8>
X-ME-Received: <xmr:Dvu8anIE0PDDbuapumIZTfArmwplaxWivam_9NOdX_45D-p9_jSqoA>
X-ME-Proxy-Cause: dmFkZTF8KMLB2CYzVaLj2MQVgP647qUv0SfqCxSwg+eP6EECo8a/8LKW7ZKAVM0yTYxTkd
    /yMVciE75j7bzULDO1ZlJVSC+YRWyV1DsbK7dKKOYakHVNIsG+bm0fe2vo/SPqyPOzjOmA
    Wlvdv7dUtEOaEbLmoBBbi8m1d2p2WuAapCvUOr+ApG/4NeBKfbxQ/DiBlEEC1l/Lq+pOLP
    RhQ2aFZI5fOq1IcaotukfWyl0cfKbGTTKBfVPq1thu0hIFr63QMxOIN1iWtEZw4rx7ahPD
    vCZv1Hf/uneF1pboZ4UzlFCmYG3h21KKrCNZjyVrIOePH/BZrUgFZBa3UfoJ/AUuBHVKa7
    VP95AkFDo2M408tdsVzFcuOSgHQauYyqo3MuTdShOya4Rm1dK1916XS8kCfx8GjqqlAEM9
    XzUaFIY+YgpYfPT4geTjwZj/n9Zs1r8jXivgp1/y9WDUQdimSjMEK45SFSGyZqu1ODIekG
    P480kJBK4KONlVIIbcge446PJMaYi9kFPt4iXV1oectL+UooFj0crRIzgZlQqP5zyqqx6t
    13ZyeLiUG/B2rfzOLujmuM4UlStHc2LoZejP/cQWQvHr6mH9EdSNzWxwjadNUwnsUVxLlE
    VvncF+XTx+I1dKU+yy3LohqHX+0SOPuRtsXP5dh7UozbkVTmHkOoZ0vc2E8A
X-ME-Proxy: <xmx:Dvu8ammePrDb3JJcUy9WSDQ9ewVB39lt-z77LI_8TcbBJPtiT5yBJw>
    <xmx:Dvu8ajPcsuvjc3lv5hzShD9xB-_cqrnao8b8MEvbICSL1DWTU2_wqw>
    <xmx:Dvu8ak16LmEQl9Agzh1WxaLamDF_MjbWNhhcwHbVFoN8xtJI8DNUFg>
    <xmx:Dvu8aqnTuUpmcuNmrHFBu48Rx4-CtpD0R6j6V19nUdvUdBPNk7tCiQ>
    <xmx:Dvu8akgNzUfTYhpMc6EF9FK2X8J-DX58dc1-p10DVtY6R1HaVi26NV3x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 08:05:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dda97a15 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 30 Sep 2026 12:05:30 +0000 (UTC)
Date: Wed, 30 Sep 2026 14:05:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Josh McKinney <git-bugs@lists.joshka.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] date: add helpers to convert between "+HHMM"
 timezones and minutes
Message-ID: <arz7CNEhQSoDwJ77@pks.im>
References: <20260929-pks-reftables-fix-timezone-format-v1-0-3df105a95ed1@pks.im>
 <20260929-pks-reftables-fix-timezone-format-v1-1-3df105a95ed1@pks.im>
 <CAOLa=ZQRDVL2Djh4du1zWGg_ABZTyzaWDYYb0PDg3EXAfpn7bA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQRDVL2Djh4du1zWGg_ABZTyzaWDYYb0PDg3EXAfpn7bA@mail.gmail.com>

On Wed, Sep 30, 2026 at 04:47:02AM -0700, Karthik Nayak wrote:

One suggestion: I'd recommend trimming the mails you're responding to a
bit more aggressively. Otherwise one is hunting for responses in files
and hunks that are not relevant to your remarks :)

> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/date.c b/date.c
> > index 014065b419..63ea9dbc76 100644
> > --- a/date.c
> > +++ b/date.c
> > @@ -103,8 +113,7 @@ static int local_time_tzoffset(time_t t, struct tm *tm)
> >  		offset = t_local - t;
> >  	}
> >  	offset /= 60; /* in minutes */
> > -	offset = (offset % 60) + ((offset / 60) * 100);
> > -	return offset * eastwest;
> > +	return minutes_to_tz(offset * eastwest);
> 
> While mathematically it's the same, but shouldn't this have been
> `minutes_to_tz(offset) * eastwest`?

I guess we can. It's probably less confusing if we do it this way
indeed.

Patrick
