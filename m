Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211A7288DA
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 16:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743609787; cv=none; b=LUXyfLzk3pKSyEwe93M8Vk2p0sZseuggcDdm6BVsynxsV+rc/V2ApEuhjAyFAA0eIvexcVKRXPGY3P3R+D4suR2yHinWA3IYHgR9xASUlE4qyFtrHrSM+CBdgKZ0xlnG4k6MHZHo4AgN7vDIJQTGQLOEKrUKUgRBRe9hwK09ja4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743609787; c=relaxed/simple;
	bh=uosmSn7RIfMENEKlC2D6pfXH2++pok2vlkJeiJ8yp78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRN/cZdospQhXrXl2GUGYJOuzKSpi6+vLmWxlk8H//BQZAAxOZefQLrX9xO/wk0kv+lBCNvzqbx63gzc7be6JiLXS36EUwR9R13a8LHriupk36P7gESbJXv7UEyH15xWGBx1y75zolDSNPnTVNM1wz3LccYot4USvYh9Y+czaE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oxt+W2UZ; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oxt+W2UZ"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2c759bf1b2eso3543136fac.1
        for <git@vger.kernel.org>; Wed, 02 Apr 2025 09:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743609785; x=1744214585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oCiDbYbmb7dex91UMrLdvDWai3V3+Msb22FmuKhrfFM=;
        b=Oxt+W2UZIZmqCDI3hnsu2elW6zMXzOE/GM84yqeMOa5tMZc9eXLgFbuMzklmQiOV7j
         u2TDgpg9xj+MVHK4VadLYOAL5FvwY10QLm0O+jB7NLGtA6cVgpKA924PDhQm5C5bprIc
         etsvnvzYipkqhtNaSz79Bzn8RQb8Geocq1yCmBP2Ruqo39dDmDeo7aUbX5tF9kW4sO0d
         xsklv7/+db+j+lsVxpNAiXA+Y7qIeBr5SpmK8PwXS6dE58PSL+2sj0gLkGZP+2FWfsbf
         6d+sSA4dIX0jvTr/Gq5AaK6cn5XSSUlcY6Jf90cOQrG29Y0AHvNb31ioBRyoZjCALLZP
         RGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743609785; x=1744214585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCiDbYbmb7dex91UMrLdvDWai3V3+Msb22FmuKhrfFM=;
        b=VeD6P2CA9XEqNKQZfwBhA4x1pFLuyt7Rf9ciEk5At/JglPQnaYaRdLj82mPMqSmWfd
         8GKoyji8kmG/MSA+QrSN2PzvcRYI5s0NxizSp+lRIHfbceYaRsjxWZJWqAnLkFuUqT/S
         bV5AEPHBLbGKhqr2XkbQ0a2+mFmNYfqiCZlla/1W8tHEqmX8fR+H1wbA7/pXg6QpZq+8
         zUT/KZfX8CU5DB+91iBVM/IZi9bs4vn0omte0Qj9EbSW/CvqkZVypmCoNeUDkc7q6f47
         smmC3V9zFFI1QZX8lLZ9nXALCpWf8ZbwYh4YDWdW4gJK4YIohMGp18MgCQYunO2Bj/4f
         rgPQ==
X-Gm-Message-State: AOJu0YwwuzjymmvNmD0V/MUvuyfnAMZcYc7UoK0Vu1zWdMRdSe02lgsY
	qIfnh7qPsWoDjPakeSV7FHXVn3epzNTU/WJw4c/NrABmDVUX2m67
X-Gm-Gg: ASbGncvi7yeAhR5epy9PlTdfav/Xqjl9cabtdGqPAkAF2MlA+uUVM0yF0yh2YpTioS/
	Sz1JKTOPs7mf08jLF83hrp9SvcNd3/A6K2SmfXRMkVQKT/Q1gSlD9YhPS16K5NLiweIe+JVz0ZA
	rD0nYfbMRm0Ay0ANV7H9LOLlgImD+7bc1gW7sJoAdmIZTLeVZ0Lt5TtsRwUOMzdhnPGXOAfE7Uh
	HdIYlyXVnqA22ZBrECXbz693RW+BL3EiF8NXOk9qUO2yIRkSCxNR45g4y267aRpmVV8udkZVZ4w
	vaf73mn26wxjqBsqeqWygquGPir99gMwNL6ntQ==
X-Google-Smtp-Source: AGHT+IHe/ZY/CRcrzFE+mG/liMGakdwIS1JO8fFDzF3ffUW7yR5bGU1H09TEdC/Qygs9SVTxEERg7g==
X-Received: by 2002:a05:6870:b149:b0:2c2:561c:47e3 with SMTP id 586e51a60fabf-2cbcf56480emr10065801fac.21.1743609784788;
        Wed, 02 Apr 2025 09:03:04 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-72c580d2ed8sm2290587a34.33.2025.04.02.09.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 09:03:04 -0700 (PDT)
Date: Wed, 2 Apr 2025 10:59:16 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [PATCH v2 2/2] help: include unsafe SHA-1 build info in version
Message-ID: <46xnrbtafdg2iafownzujbpzjuygpns4g4r26wzxxv6xmi5mg7@m3dw6cfk6f7q>
References: <20250328170121.157563-1-jltobler@gmail.com>
 <20250401203630.285451-1-jltobler@gmail.com>
 <20250401203630.285451-3-jltobler@gmail.com>
 <Z-zpau_DsOGVVtjj@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-zpau_DsOGVVtjj@pks.im>

On 25/04/02 09:38AM, Patrick Steinhardt wrote:
> On Tue, Apr 01, 2025 at 03:36:30PM -0500, Justin Tobler wrote:
> > diff --git a/Documentation/git-version.adoc b/Documentation/git-version.adoc
> > index f06758a7cf..753794988c 100644
> > --- a/Documentation/git-version.adoc
> > +++ b/Documentation/git-version.adoc
> > @@ -25,6 +25,9 @@ OPTIONS
> >  +
> >  Note that the SHA1 options `SHA1_APPLE`, `SHA1_OPENSSL`, and `SHA1_BLK` do not
> >  have collision detection.
> > ++
> > +If built to use a faster SHA-1 implementation for non-cryptographic purposes,
> > +that implementation is denoted as "non-crypto-SHA-1".
> >  
> >  GIT
> >  ---
> 
> I got basically the same comment for this new paragraph as for the first
> one. I'd either drop it or expand it so that readers know what's going
> on.

Ya, this should also be expanded a bit. I think in combination with the
expanded documentation for the prior patch, something like this might be
a bit better.

"When a faster SHA-1 implementation without collision detection is used
for only non-cryptographic purposes, the algorithm is diplayed in the form
`non-collision-detecting-SHA-1: <option>`."

> > diff --git a/help.c b/help.c
> > index 3aebfb3681..1238a962b0 100644
> > --- a/help.c
> > +++ b/help.c
> > @@ -772,6 +772,11 @@ char *help_unknown_cmd(const char *cmd)
> >  static void get_sha_impl(struct strbuf *buf)
> >  {
> >  	strbuf_addf(buf, "SHA-1: %s\n", SHA1_BACKEND);
> > +
> > +#if defined(SHA1_UNSAFE_BACKEND)
> > +	strbuf_addf(buf, "non-crypto-SHA-1: %s\n", SHA1_UNSAFE_BACKEND);
> > +#endif
> > +
> 
> Should we maybe print the equivalent of "none" in case no unsafe backend
> was selected?

It is suggested later to rename "non-crypto-SHA-1" to "SHA-1 without
collision detection", which could lead to something like this:

    SHA-1: SHA1_OPENSSL (No collision detection)
    SHA-1 without collision detection: none

which could be a bit misleading IMO. It might be best to leave the
option omitted if it is not defined.

> I also think we shouldn't name this "non-crypto". The backend still is
> SHA1, which is a proper cryptogtaphic hash function. It may be somewhat
> broken nowadays, but that doesn't change the fact that it's a
> cryptographic primitive.

I was trying to indicate that this SHA-1 backend was used only in
non-cryptographic scenarios, but I agree that this name is not great. 
Calling it "SHA-1 used for non-cryptographic purposes" is a bit of a
mouthful, but maybe that is fine?

Another idea I had was to call it "fast-SHA-1:" since it's intended as a
performance optimization used in certain cases.

> How about we rename this to "SHA-1 without collision detection:"?

Being verbose here is probably best. I'll probably use something like
"non-collision-detecting-SHA-1:" in the next version.

-Justin
