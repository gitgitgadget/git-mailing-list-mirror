Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C3243AA1
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 20:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707770562; cv=none; b=GWyZu/3K+bsYFhKLbyOHDpC7A39ZYNbwvFIbq2FHTH4qZ3HP/ugQiVj7w/gJVxicCBksn/ymsiyiUO7DL7X6POre00q9KJT4tGC22lq2H65uWUuMaiMjxZD+XzKtGqbEZ7UWuhuGZYuJru8SKRBvNYc/R0Pa2Ay9bGoSm/53yqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707770562; c=relaxed/simple;
	bh=+ZJutEojR+e939KAc/fb4IltT3ILvNmIwgO53lNe8+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWw5XMRtVOJeu9eP8Cyb2pyHuqEXbmGrqKuoC/Js68nvEsmCFMop0Jumb4g4RsWjo+hpMjqlQOalDCLuUhlJD9lkWTq16SZBQHKb7BH7aVy21hziGVK02qi3VwbRidHEst6Mk0WTXE5gz1sXtUw00amJ4HvD+ol8+KZMFfk7lfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NDVXRl5U; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NDVXRl5U"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d95d67ff45so26197405ad.2
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 12:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707770560; x=1708375360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3YXbIv+WdujLFGn3dO+Y3Zd+nWII0KeIp9xKQVAaAs=;
        b=NDVXRl5UcxYFnmOkjobENmABOuGcLhXx07NNrHle0nlbA02A2ZIAOXkpCtaNh6w0Df
         4pne1RgOdfiDgJWu80V27s1r3ShQw5027n8ZkX5OcprqMqsPkaqkeinrUXv8lAPYVGw8
         uGB2yJggloWFsJineXLaYdL3wz/kBg6nj0DmhKhqXPmSJBJeN+oXLWgFJ5QIrQPmIdM9
         aqXsp8AotvsCHrIuUrHvO74Qlz/XzIwkTxe4zT+NjPitg/Fvkz9HswnASuKuzsykjRUF
         kYCd0W8W8R8Q05NfZgxYFpu5Q7J5j9/L5Ko73F6cA/IWADDuSlfafYKvWAzJacDqeHkI
         p/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707770560; x=1708375360;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3YXbIv+WdujLFGn3dO+Y3Zd+nWII0KeIp9xKQVAaAs=;
        b=G+uQ2nC7rTChMruE2PW39CVvXNOgtw2pUiMoM45qmuuthkokxxgOgmY3JHl6TS+dG7
         LhPdy7eQhm3w/enHePWAsui/PA3SQF2VpK4eo4fM/gvQynsgBaAa8igDCGP9MUcMLEEq
         1r/L9w25X/d1b+Z5OOja3kWFQPnh+UWFAz+dYzeAVM/EjMcjQE4JT/hDunv3Cd2SNsV0
         3Nd054Gv4mP2gpfDLVj9V/UN2NGvMDHhwbYRBD1+h6FV78Nr0L8uDM1F0H1zKkatDG/A
         SzyNkZ7EpXiCqntB+YVOVQeyWdCIeCr8UOyGiCbRtptt8SpWsW0fv25iYBMkPkNi6luO
         HttA==
X-Gm-Message-State: AOJu0Yz1fpp0J9FKjHg7xpPuzOHSofQOEYh0KTMTg3xpSg9TBHqckeJm
	xJ70TSq9iJUOWpwozBt4SlurSBx0EPH17CpbQziSm5fR/D93YOwZoTcXq+mNKA==
X-Google-Smtp-Source: AGHT+IHje3DUitk6o0OKYHjsZZQ0bwyzqwrhW5KdeQ1FJPKZ1TyI/MjXWSBg0wyT6bw5jq4pqCYuvw==
X-Received: by 2002:a17:902:e811:b0:1d9:e180:478c with SMTP id u17-20020a170902e81100b001d9e180478cmr8196148plg.24.1707770559983;
        Mon, 12 Feb 2024 12:42:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWdFRfuEy9QzHZUVRL9ShEH0oD2K250iHNMpdg04O8blPNwA38TD/EMcClcsgN0qT8ymPXNDuG8pMMqK51iDC3kVm7Vjow/7KftQKXfm0I2MKFy3jQke3595Ivs+Wp63s+M17rd4sSdpaAZXxz3fdKloTEHbx8=
Received: from google.com ([2620:15c:2d3:204:5bb3:9725:3d2f:4438])
        by smtp.gmail.com with ESMTPSA id ja6-20020a170902efc600b001d965e737f2sm733355plb.268.2024.02.12.12.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 12:42:39 -0800 (PST)
Date: Mon, 12 Feb 2024 12:42:34 -0800
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net,
	phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 1/6] t0080: turn t-basic unit test into a helper
Message-ID: <ZcqCuseY4jeuKvKE@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, peff@peff.net,
	phillip.wood@dunelm.org.uk
References: <cover.1705443632.git.steadmon@google.com>
 <cover.1706921262.git.steadmon@google.com>
 <da756b4bfb9d1ce0d1213d585e72acfbf667e2a2.1706921262.git.steadmon@google.com>
 <xmqqsf246ll7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsf246ll7.fsf@gitster.g>

On 2024.02.07 12:55, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > -UNIT_TEST_PROGRAMS = $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UNIT_TEST_SOURCES))
> > -UNIT_TESTS = $(sort $(filter-out unit-tests/bin/t-basic%,$(UNIT_TEST_PROGRAMS)))
> > +UNIT_TESTS = $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UNIT_TEST_SOURCES))
> 
> Nice that we no longer need the special casing.
> 
> > diff --git a/t/unit-tests/t-basic.c b/t/helper/test-example-tap.c
> > similarity index 95%
> > rename from t/unit-tests/t-basic.c
> > rename to t/helper/test-example-tap.c
> > index fda1ae59a6..21e4848e78 100644
> > --- a/t/unit-tests/t-basic.c
> > +++ b/t/helper/test-example-tap.c
> > @@ -1,4 +1,5 @@
> > -#include "test-lib.h"
> > +#include "t/unit-tests/test-lib.h"
> > +#include "test-tool.h"
> 
> As the first thing both of these headers include is
> "git-compat-util.h", so the ordering should be safe either way,
> because everybody else in the directory seems to include
> "test-tool.h" before including headers that are specific to the
> subsystem it is testing, and "t/unit-tests/test-lib.h" in this case
> is the header that is specific to the unit-test subsystem being
> tested, it may raise fewer eyebrows if we swapped the order of the
> inclusion here.
> 
> Other than that, looks good to me.
> 
> Thanks.

Fixed in V3.
