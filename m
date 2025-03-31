Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EB715A856
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743445082; cv=none; b=RUMwr7K0qnIVij+jyMCiLIXC/t4quMC/Mzyxx8Xv1HqbLCLvTe93pxo8sdm8tiStDEKuk9JIA/i5TiJdPi0q9GhfyLWpFTTfguEc3Pxi6jr0P2uFWVsDL9x98WheD8t4fyTTubMFZRcHXsOU+NobXIxYdxiFDtFxKSB4NmrksDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743445082; c=relaxed/simple;
	bh=IwM6j27AFjw8uX/QH/jdxPB3oKyRdp0PUTjHO02U07s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlgCVIResluI7Ocm6bKPlgqYTrNf5uVJ5TI9rEH9zSpeB50m1ML4Kpsxb1Tlli8SrCfo+yQ74ptmHYI1pYQvtRsIHHi064Xt5EkaSogtcdNG4IlglWHfBXsWsJIjw22o3ylN5L5oiYWXV/yqZD2KtSFL4biJhHtwE9uq20u/kB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOf82cFG; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOf82cFG"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5ec9d24acfbso10958545a12.0
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 11:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743445079; x=1744049879; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xc4iM90heChlycZE8hI91TMHF+tn9igmaNLHhMsVyZs=;
        b=cOf82cFGX+yc5qRzW99TnirIissr3WMNRA9lZVlBFEx8NMAi2lPltKTFq4Ig7m3WeF
         3redlgRlZmS3Vfl8su+yY5urIgR39QYx6xyvCc1+goPKlDkuYs/Mjnaqg2KD9nhJ3Bhx
         Rjvm/Y4b96Bg7klupF7ZJS+oj94PAVxQZ5K3NFwP1+9BxxWKA3L++Vx1mhWaDlWMrLYd
         g1cxBXIqnynCofHBKYwP6mUULqX5A94bfLcy7YaeaOsJ1DcaH40hO2s9qSCc0jQD6m5W
         I7UUEZ5IlbbskujfJ/mzcijGb8c+DjE6V48fTsj35090s5vEGp3zh3nJu8FbtDBxeDpW
         Skbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743445079; x=1744049879;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xc4iM90heChlycZE8hI91TMHF+tn9igmaNLHhMsVyZs=;
        b=pkzV4LUjTZosRg6ylakBF8SO14CeDVuBz0/8kwDv7FBasI2kNb6H/LaXcGDMjA96Hx
         SvNQ+2JvqiPDHJe+XgXlcYOtLedgUz3qKy6wJe6RlIkKx9L+7Tsn/18fsT64DYrwNC/K
         u6DVQdlfDkC39P0x79bigEs4JkB67GABLgfFN8sIJuf5dhYLzMg05PGfmkFn9XtldBwj
         NNI9z5uEZZVvt7QQMRqwimAVHnoGK8SKAN90il6JsLiAHvyqAW99BuvBfq6Wfjqfjwpv
         Js0I33LBn1171lD5MzASllFi7hcwvJBLG9hJOFpuTPWSxLuwQ+00VL0TlXthSuf6Cbyu
         LStg==
X-Forwarded-Encrypted: i=1; AJvYcCUC4z9ar7wlPzcAQqqTuSKiNzNxJho3nS1kpHNME3cF0xmfDngj/yxzHbujM1qQvNvmfWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvckXKivsq5zHSpBY4ia65BU0UZPPpnow46DB8+TDOEvajWYg3
	wfoxyr/mS80uEt1wjtYjStS90RpVZA4xJckLqkZbmEEQ7GnDHhqH
X-Gm-Gg: ASbGncs5Twws88vhM1E/eqwEUYGQ/QFzp+FqyT/9notPxDpC/6N9nOaQCmUwcCtYa2q
	65TIPHw/KVqvF+5FPJq/XV6JCrr4JNZ5BpRdbZkADt30DmodcrWmkjHjenvUce8WkMJRlbAzV6u
	WijAut66ivpOlc+OdvrG+s51WOEKc6lJbUK98sr5+tkrJYFef+KHecpu2ghp3sRHfaRneguMUZa
	NIU7HCHuJDwTHM7naRPWErUq5XSIrqSG7YmeQX5BaqIhCUqT+h1NMByX9emrXo57m+Wc98AmZC3
	7T8HPpUeqchC7nFOVqORi4H5QZ5/6N1L3uavgdBIAq7td0UHmCDvoRAr3JcXBWF3XAK/eeEx/Qw
	=
X-Google-Smtp-Source: AGHT+IFIZZK2IV77MjbyU2IZm1N0hFn/dD1+xJ24tuNDAdTL0nC0hD9hUMF+5H8vAYZglsJG6eko6Q==
X-Received: by 2002:a17:907:6e8e:b0:ac7:1611:d499 with SMTP id a640c23a62f3a-ac7367829c1mr1023246666b.10.1743445079230;
        Mon, 31 Mar 2025 11:17:59 -0700 (PDT)
Received: from localhost (78-131-14-102.pool.digikabel.hu. [78.131.14.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71922bef7sm654931466b.31.2025.03.31.11.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 11:17:58 -0700 (PDT)
Date: Mon, 31 Mar 2025 20:17:57 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Todd Zullinger <tmz@pobox.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	git <git@vger.kernel.org>,
	Derrick Stolee <derrickstolee@github.com>
Subject: Re: Testsuite failure on s390x and sparc64 after 6840fe9ee2
Message-ID: <Z+rcVY7KqEuF1wFw@szeder.dev>
References: <89257ab82cd60d135cce02d51eacee7ec35c1c37.camel@physik.fu-berlin.de>
 <Z-R_Zmr6kxCPLm-O@teonanacatl.net>
 <Z-Zr7BZL1UGqVxKu@pks.im>
 <4276c8d0b72f11f325482756d3bc251327d0ac47.camel@physik.fu-berlin.de>
 <Z-atRMGXHilZRTEL@teonanacatl.net>
 <Z-bCNdOOLrM2Chb8@teonanacatl.net>
 <Z-qKGqpbdaW9WCrP@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-qKGqpbdaW9WCrP@pks.im>

On Mon, Mar 31, 2025 at 02:27:06PM +0200, Patrick Steinhardt wrote:
> One thing I stumbled over: the `--min-batch-size` parameter is parsed
> using `OPT_INTEGER()`, which expects the value pointer to point to an
> integer. But we pass `struct backfill_context::min_batch_size`, which is
> of type `size_t`. Maybe that's causing us to end up with an invalid
> value?

We could teach parse-options to verify at compile time that it got a
'value' pointer to an appropriately sized variable with a simple
trick:

diff --git a/parse-options.h b/parse-options.h
index 997ffbee80..ac63f9548a 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -213,7 +213,7 @@ struct option {
 	.type = OPTION_INTEGER, \
 	.short_name = (s), \
 	.long_name = (l), \
-	.value = (v), \
+	.value = (v) + 0/(sizeof(*(v)) == sizeof(int)), \
 	.argh = N_("n"), \
 	.help = (h), \
 	.flags = (f), \

This bug would then cause a compiler error like this:

      CC builtin/backfill.o
  In file included from builtin/backfill.c:7:
  builtin/backfill.c: In function ‘cmd_backfill’:
  ./parse-options.h:216:25: error: division by zero [-Werror=div-by-zero]
    216 |         .value = (v) + 0/(sizeof(*v) == sizeof(int)), \
        |                         ^
  ./parse-options.h:272:37: note: in expansion of macro ‘OPT_INTEGER_F’
    272 | #define OPT_INTEGER(s, l, v, h)     OPT_INTEGER_F(s, l, v, h, 0)
        |                                     ^~~~~~~~~~~~~
  builtin/backfill.c:126:17: note: in expansion of macro ‘OPT_INTEGER’
    126 |                 OPT_INTEGER(0, "min-batch-size", &ctx.min_batch_size,
        |                 ^~~~~~~~~~~
  cc1: all warnings being treated as errors
  make: *** [Makefile:2811: builtin/backfill.o] Error 1

Alas, the change is ugly (and we should do the same for many other
OPT_* macros as well) and the error message is far from
to-the-point...  Turning this into something usable would require a
more clever trick, and that's more than I can devote to this issue.

