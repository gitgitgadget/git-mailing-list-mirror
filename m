Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B90F18D63E
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407559; cv=none; b=a9xM5/cA7zoeywWT+DKHoGxJ5igmIc+lVZtJX/jvFyP7rE13yKpaITecv/y2eXWgisF2ezP2/uHpatPqoDn35aY6QZeFmaSs6x2Uuflefi0P7ErbZS4QF3o83hWyfjM0J9lUdlRzjjX8BTSyojk6g+gt7+CriYbt63X1m83DpFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407559; c=relaxed/simple;
	bh=gzb48xIHpFC57s9io3GnLrvO5eJ/uoi+JomYPT3sRLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLYAV9tvwEueQSAaU6ql4b+2h8wZX2/R4TSrgz2ZQBc4GMb1OffHSyVEotkneWSHifyIrMUn2tav4OKjc+8YTKS6agZy1ERp/mIlPxT2U06373iIx4j4hllJpe63CEyRXowdudquAPJKcFVMyBJuxjvwTL2l8m1DxCJ5aa0r9dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=DXBIf6gs; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="DXBIf6gs"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6dd420f82e2so93760586d6.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 11:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742407557; x=1743012357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bfpAEoZZYoAVeMzAeft8kNHi/n1HoPBCnbCJ0E14yIY=;
        b=DXBIf6gsRuFvzVwni+UthdkVy+7blKKB0CN5MhRtrWG8zv3410ITAAzpnSfLstBSlA
         afPeaXh9Uln9JePH/l7bNy8DOkhGVazXHCX7AQ8V7JJJuihvJckmNYLW34sEFxC4bpcJ
         TrHFWBksSiCzXMF0UkjtOlUJcP+ug0KujwV+zbSFQafJUtBuFLJsL5gSjzhrDB2RX1TI
         VK57U9nqV8h22JfdcEEz2CHSxUzh6iI0BykOiE4KUdq8rQlAoZC55uneQThTLKe0WCMi
         BsqX/VLucAg2BZbBXkxuSNKZUCejaauN8UIvXPmcJVMuHF7cg1BQV0nv2Nwap/nGtvnm
         y6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742407557; x=1743012357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfpAEoZZYoAVeMzAeft8kNHi/n1HoPBCnbCJ0E14yIY=;
        b=lwjlxkVagj8Z0yemgoLflwiomp+NFY7a/m6/7uhuXzHJwGV+3iZQGnatEC+fe9DXGj
         4ybtEmnJLy1luGUfzvJj+VVaF+E+74CPALtoGneOIeHAqESHFcfULY7zDJj0v5/m4xqJ
         z+WHMm9pm+axVFExqDgTdHx62u93ZnSvP6q4/qdAEnfG7TSY5fQyifEG23fEc04wVumc
         oFYRe7YR5b6GrwUoXz8xU+hreFo64rXrev7h6XdZSY2n1FZEtTXVZJS94gaRYfhaEjwc
         UnO0ejVDNUOr21D/85qzbV+0jVR2utdbrfVC38CIhXTVnP1IPTShsaWuWOaRzXzEuU5W
         1okA==
X-Gm-Message-State: AOJu0YxwWaMKQT7PG2b13JHoU7jyRYqwwSTVZe02BgCwqiLwytmveTsN
	L6u7EotFa5b0PjoZ2/+CGoSZtWYQ8Mq/JTyKkbnDEVgsRN7EOgh+Wnovdwl+mFk=
X-Gm-Gg: ASbGnculAblBAwa3eW4LcN3yjOir9Qg3gcN9U0XRFNBh7udNijPxoBJCKGBFxkbesbW
	5hdQL1/VmTmYoZ87OoiU0toRZcoVBwFxhpM/xDjW/R2PKtzL7UmaTZFi/+nDe1Dp13DzmK/SniL
	3kCE5ftAbRq3DtGfpRtD4e7c7DTZ2DOHE18ebNNsTPwy1herO/kgGD0SAqhisLaFRBMJ/CsoLnC
	cpNd53GIEyJ9B1exEQpqldOnC4PvZnh8k1LXYPXkv5bfXzEpfhoEFW0Unb77Shb/pUnGVS4Djuq
	fyeJn5XOrtRkpXnAFy3g1Zex9PJuL6EI4Wzq93c802pXKYGQgdGtRBttTPy4WSXueii74nVZeDF
	E40qdOot3p6ry+WSR
X-Google-Smtp-Source: AGHT+IGXRw0YrvDYyOUp8ecnCIyki05r2J4ovlSMCKXXJIvJEdia93UVhkd9DNFIklANvZgopPRTrQ==
X-Received: by 2002:a05:6214:238e:b0:6e8:ddf6:d137 with SMTP id 6a1803df08f44-6eb293a4fa6mr64575486d6.18.1742407556811;
        Wed, 19 Mar 2025 11:05:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eb036e8b00sm48390226d6.17.2025.03.19.11.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 11:05:56 -0700 (PDT)
Date: Wed, 19 Mar 2025 14:05:55 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/3] http.c: allow custom TCP keepalive behavior via
 config
Message-ID: <Z9sHgz0kgb2bYVXQ@nand.local>
References: <cover.1742336481.git.me@ttaylorr.com>
 <d84041580895a653648ee2370e21d7d2aa4fc4bb.1742336481.git.me@ttaylorr.com>
 <Z9rqMxlt1F7lbGk7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9rqMxlt1F7lbGk7@pks.im>

On Wed, Mar 19, 2025 at 05:00:51PM +0100, Patrick Steinhardt wrote:
> On Tue, Mar 18, 2025 at 06:21:41PM -0400, Taylor Blau wrote:
> > curl supports a few options to control when and how often it should
> > instruct the OS to send TCP keepalives, like KEEPIDLE, KEEPINTVL, and
> > KEEPCNT. Until this point, there hasn't been a way for users to change
> > what values are used for these options, forcing them to rely on curl's
> > defaults.
> >
> > But we do unconditionally enable TCP keepalives without giving users an
> > ability to tweak any fine-grained parameters. Ordinarily this isn't a
> > problem, particularly for users that have fast-enough connections,
> > and/or are talking to a server that has generous or nonexistent
> > thresholds for killing a connection it hasn't heard from in a while.
> >
> > But it can present a problem when one or both of those assumptions fail.
> > For instance, I can reliably get an in-progress clone to be killed from
> > the remote end when cloning from some forges while using trickle to
> > limit my clone's bandwidth.
>
> Does this mean that our defaults are insufficient, as well? It's nice to
> add a way to adapt those settings for the future, but ideally no user
> should ever have to manually tweak them and Git should work out of the
> box.

No; the defaults are sufficient for most users. It's the users that have
extremely slow connections and/or are talking to hosts that have very
short timeouts for inactive TCP connections that would want to change
these values.

> > diff --git a/http.c b/http.c
> > index 526f9680f9..c13c7da530 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -557,6 +561,19 @@ static int http_options(const char *var, const char *value,
> >  		return 0;
> >  	}
> >
> > +	if (!strcmp("http.keepaliveidle", var)) {
> > +		curl_tcp_keepidle = (long)git_config_int(var, value, ctx->kvi);
> > +		return 0;
> > +	}
> > +	if (!strcmp("http.keepaliveinterval", var)) {
> > +		curl_tcp_keepintvl = (long)git_config_int(var, value, ctx->kvi);
> > +		return 0;
> > +	}
> > +	if (!strcmp("http.keepalivecount", var)) {
> > +		curl_tcp_keepcnt = (long)git_config_int(var, value, ctx->kvi);
> > +		return 0;
> > +	}
> > +
> >  	/* Fall back on the default ones */
> >  	return git_default_config(var, value, ctx, data);
> >  }
>
> Are the casts really necessary? The compiler shouldn't complain when
> promoting from `int` to `long`.

No, they're not. They match the style of the rest of this file, but we
shouldn't have explicit casts anywhere. I'll send a new round with an
additional patch that drops the unnecessary casts, too.

Thanks,
Taylor
