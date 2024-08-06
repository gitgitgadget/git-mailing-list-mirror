Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0964116BE1B
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 22:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982714; cv=none; b=K+88zxYf/S+BP/RYyh6ZgR2Hg2CddgyLfyCywJuCdUUK0wXsDL5jVK4oqDnz8Va+bpRhJqPSwHBEGYrgpbwhoxEn/f/Y1XMKzWnpHf4zgr+zVSluUY3OLuw7VH7b9vsyf2yheKSZ1PGsPLPvLeCKcFuGAQvnxQKQeBlEX/76WT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982714; c=relaxed/simple;
	bh=6lblWo6XejTbhRGhGTvGmxbrMcBU+Yv+DDrdL0YJjKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0rrrb+CGOkLsiUQJQNfv2FXMywTWQfr2XRGAdH0XeiQ8/ueHRo+T7LAqG1zVK6ekrj/p28m4D7YrZOUnQe2OAFNOa4c08sKrAKorB2zkADBVaceZWtAX/r8QgcsGaaTAdhCIpC75EQF2YgI+LcKFVnt+iCbuvWe6/c3ljsgCKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XgGgd1S6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XgGgd1S6"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d316f0060so202354b3a.1
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 15:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722982712; x=1723587512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmR3UhU2QJU+8DpWZZlP8iezaXY2sU0XE6tQyXtjWAA=;
        b=XgGgd1S62r0VndwM7k+1SqPjaRkiV6TCFbiFfCPn+VJM3H+kVECXuMsTIzG0divSXx
         YtP+XDdekfaPQbl181TVMWrkLOH4slDEvhcgyA2MCv4LtooqGfU51hKxvvFYuK9sRSon
         /Ox5pIiXTKyQNmsRdNPBKVRSVjtQ0mA6MP1YfX1haGiWtHxNR4utx148VMRYk91nULUM
         6OZByfbO5N6D9ZYgxb/TyXGID08gzCbq1FXMJI75WTPHZisrEwWc+X8p4BcMGyhS0F1x
         HEWESEpqxI1364QOxIAlPQRtnpkjsaH8vBeZM6WikTpLqpqipBsdi0qaqnfo4feSWcbw
         B+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722982712; x=1723587512;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GmR3UhU2QJU+8DpWZZlP8iezaXY2sU0XE6tQyXtjWAA=;
        b=LxB30THyeEKv3iU+cCFAw5vP8vrsRtdXJpSboisJ8O3YF5PGtX/4KD8rVEjALX4kXh
         4lVq/HDAeNs7n/9pSdX+fFk/miHx4IlllYkHAOvCRJ8jCciR+voQCgKCMRnU6Re6xixR
         stgtNOEUX4S2+JpLKf9tFABQb9b0UBT204NCq+2uUVHY2P3mKXfZqoqtJ3zdGAGYcatz
         1hYu87+hHVySVmfmln+kx2sWxHnyqvWImh1JQnZS4eneNh9Nqns4DVW5gcaHs6hJ07DY
         k0WYxN94v8m7fwi+Aa+k8z0q5gQWTDolC7h1k6qQfagofILFaB8NGIx0OKcPF6SdO1AC
         pQ5w==
X-Gm-Message-State: AOJu0Yw5B52ErjlGUliXEFaqDZeIP3NU9SOjIBd+MzmeiQPKMV2+nyi4
	q/HBWeuOreXicM2FSlFoGFBNSKaLVZRMIPwLBNMIElWt5bRZ2tt8jTjPOSFrAGfy6iJC4h2XtCZ
	PUw==
X-Google-Smtp-Source: AGHT+IE92qMltJQ3MQNh896e+iZbllGjLxZDZJh01AIhWVpWtLMqtfhxo3BvIjQ2eR52rPicsnmJ3Q==
X-Received: by 2002:a05:6a21:338a:b0:1c6:ed5e:24e with SMTP id adf61e73a8af0-1c6ed6fa167mr427520637.7.1722982711788;
        Tue, 06 Aug 2024 15:18:31 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:9b03:120a:1a2:b3bb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710bd9064b5sm600b3a.127.2024.08.06.15.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 15:18:31 -0700 (PDT)
Date: Tue, 6 Aug 2024 15:18:25 -0700
From: Josh Steadmon <steadmon@google.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, 
	Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, rsbecker@nexbridge.com, 
	Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [RFC PATCH v2 2/7] t: import the clar unit testing framework
Message-ID: <36e3ukvajteiywmsca7vohyk35ehqsgs5rj7njy4ssmykfb4om@sbolkz7xfafe>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, 
	Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, rsbecker@nexbridge.com, 
	Edward Thomson <ethomson@edwardthomson.com>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1722952908.git.ps@pks.im>
 <6a88cf22a5de3faa77cb22998d27f0c1b63bd4ff.1722952908.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a88cf22a5de3faa77cb22998d27f0c1b63bd4ff.1722952908.git.ps@pks.im>

On 2024.08.06 16:14, Patrick Steinhardt wrote:
> Import the clar unit testing framework at commit faa8419 (Merge pull
> request #93 from clar-test/ethomson/fixtures, 2023-12-14). The framework
> will be wired up in subsequent commits.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/technical/unit-tests.txt     |   2 +
>  Makefile                                   |   4 +-
>  t/unit-tests/clar/.github/workflows/ci.yml |  23 +
>  t/unit-tests/clar/COPYING                  |  15 +
>  t/unit-tests/clar/README.md                | 329 ++++++++
>  t/unit-tests/clar/clar.c                   | 842 +++++++++++++++++++++
>  t/unit-tests/clar/clar.h                   | 173 +++++
>  t/unit-tests/clar/clar/fixtures.h          |  50 ++
>  t/unit-tests/clar/clar/fs.h                | 522 +++++++++++++
>  t/unit-tests/clar/clar/print.h             | 211 ++++++
>  t/unit-tests/clar/clar/sandbox.h           | 154 ++++
>  t/unit-tests/clar/clar/summary.h           | 143 ++++
>  t/unit-tests/clar/generate.py              | 267 +++++++
>  t/unit-tests/clar/test/.gitignore          |   5 +
>  t/unit-tests/clar/test/Makefile            |  39 +
>  t/unit-tests/clar/test/clar_test.h         |  16 +
>  t/unit-tests/clar/test/main.c              |  40 +
>  t/unit-tests/clar/test/main.c.sample       |  27 +
>  t/unit-tests/clar/test/resources/test/file |   1 +
>  t/unit-tests/clar/test/sample.c            |  84 ++
>  20 files changed, 2946 insertions(+), 1 deletion(-)
>  create mode 100644 t/unit-tests/clar/.github/workflows/ci.yml
>  create mode 100644 t/unit-tests/clar/COPYING
>  create mode 100644 t/unit-tests/clar/README.md
>  create mode 100644 t/unit-tests/clar/clar.c
>  create mode 100644 t/unit-tests/clar/clar.h
>  create mode 100644 t/unit-tests/clar/clar/fixtures.h
>  create mode 100644 t/unit-tests/clar/clar/fs.h
>  create mode 100644 t/unit-tests/clar/clar/print.h
>  create mode 100644 t/unit-tests/clar/clar/sandbox.h
>  create mode 100644 t/unit-tests/clar/clar/summary.h
>  create mode 100755 t/unit-tests/clar/generate.py
>  create mode 100644 t/unit-tests/clar/test/.gitignore
>  create mode 100644 t/unit-tests/clar/test/Makefile
>  create mode 100644 t/unit-tests/clar/test/clar_test.h
>  create mode 100644 t/unit-tests/clar/test/main.c
>  create mode 100644 t/unit-tests/clar/test/main.c.sample
>  create mode 100644 t/unit-tests/clar/test/resources/test/file
>  create mode 100644 t/unit-tests/clar/test/sample.c
> 
> diff --git a/Documentation/technical/unit-tests.txt b/Documentation/technical/unit-tests.txt
> index 206037ffb1..fc201d4b3d 100644
> --- a/Documentation/technical/unit-tests.txt
> +++ b/Documentation/technical/unit-tests.txt
> @@ -203,6 +203,7 @@ GitHub / GitLab stars to estimate this.
>  :criterion: https://github.com/Snaipe/Criterion[Criterion]
>  :c-tap: https://github.com/rra/c-tap-harness/[C TAP]
>  :check: https://libcheck.github.io/check/[Check]
> +:clar: https://github.com/clar-test/clar[Clar]
>  
>  [format="csv",options="header",width="33%",subs="specialcharacters,attributes,quotes,macros"]
>  |=====
> @@ -212,6 +213,7 @@ Framework,"<<license,License>>","<<vendorable-or-ubiquitous,Vendorable or ubiqui
>  {criterion},{mit},{false},{partial},{true},{true},{true},{true},{true},{false},{true},19,1800
>  {c-tap},{expat},{true},{partial},{partial},{true},{false},{true},{false},{false},{false},4,33
>  {check},{lgpl},{false},{partial},{true},{true},{true},{false},{false},{false},{true},17,973
> +{clar},{lgpl},{false},{partial},{true},{true},{true},{true},{false},{false},{true},1,192
>  |=====

Isn't clar ISC-licensed, not LGPL?
https://github.com/clar-test/clar/blob/main/COPYING

