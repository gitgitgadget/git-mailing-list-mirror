Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F86A1CEAC3
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740828861; cv=none; b=BAMfkIslQjPmBn2BRnm8OBrDxbFDXHOCMp6wbKdeUcmeRJ66lYsV1RbAkLl3l0S4HymPZ9KUqU6tEDkDwSX1R3zOhICWcrKKIkjqTG4T+Mr63Qej/AGcVPsnMx3OqnpA0I7WOCfCLVunNxO81Rhe0t28ASsIrt4jygmsJSRxa8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740828861; c=relaxed/simple;
	bh=LHUwQDggIg++KF+nSXFH7lZf4pKSZtgy2Wg5s1WW5so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wl59ak9sK4fl3pHkMedIHn9ah9AeOJsPoZuVSoiEVw4/e6JYr8btIWfWZv9jWJhT8+lQItfcMeRcysro9gCmGckryZbi2aQjFuN2aZKGKOrxRQtc1krdc8/UB7y+o5SMQORuj0bsC+cS3oaJ0xr99642PtsDlYJFVBbmNpAGEzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMNLkId8; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMNLkId8"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-6f6ae4846c7so26382307b3.1
        for <git@vger.kernel.org>; Sat, 01 Mar 2025 03:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740828858; x=1741433658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5rXF8eKvvZsUXABhBw2r14T/wg7EqsYOcDwXsCg36c=;
        b=XMNLkId80a9WHuco8Q4nD26FLYWDsvVo+gaygpohQZyLrok6damfx9nYKEeP9WeMgk
         +FpU57lrD17Tc/qgqHlRfnvqSoXFTGy76tblSkeuYrpZZ4Th/v36ypzUZEZXb7btmmE0
         Qmuk7fDOgXbnxZJPmuucYZRbjRCvW6j3bMbsjX2Ms42zYf/5mvtnXurBkjWE7DK8NxXJ
         OHSj7vwW+ENj++5UGvrZBRPwQtXjplnjwqS2R8SZAoJmyZhoCSkdtEG5swlgEvuH9ypo
         EvlJtpj8Jy/xEl4mOG7y3nbhGA8oWW3mtoYvAInub11eSHMmVdmnukJFWBWSBqy4xuwI
         s6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740828858; x=1741433658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5rXF8eKvvZsUXABhBw2r14T/wg7EqsYOcDwXsCg36c=;
        b=d4eA1qdZM6xboPmxrSLYiu0EgU7aTvfNUPDmaqK/yknVnwA/P5KmgFa4JCetWA7xPw
         8yZT+vk37wEeNXFyr9+kBTO8/KVTwnoNcx/aVmT5BQy8Kb/ucsPAhJ2pqpVAwxNVvGp1
         dEvSlDzV2nZmq3F8h5TThrHYyXtSPDTlme5qTCkaRkKY19+9cSyrM8zxl784nvjs4VHx
         50oOswXzj6ZbfRSyDZbVDByrGORLwy0vnFA44XS+l5bDPiZQQPjfVEB7367djbfZES1j
         ZwDpV8cUDtbofH/ENAz6w3vkHTX8gtHijPUh2XCHs2XiT3LihrNaLWA9Dy2hjWH7kIv4
         wgzA==
X-Gm-Message-State: AOJu0YxdXHcZ+ZEYN65l+OTjCCfltDIIX9SuiuCR3tlBBwWtOopWaV6x
	cu6R0cfUCaTQSvRyEUQjgtHtYTFXH86H/lgUzX6nPRnC/bbNft+dEge9x7qVMtoFfigSplGr5uL
	e2X0v6OC8aLQUafnuobMsp11ktwGcInHtcuvy0Wgs
X-Gm-Gg: ASbGncsv6X/3u9l5gNZ03Qt3CtTyBns0G9kCfBin3ZwbyAyt9E3v3doG5CLxTk3JWF5
	ipOwIcI0t7lemWG+lqzmGDJvUBCzLJ7HhLl/HHP4WEZDDvfKOglKDiDu7jRHXBbfmXK8BEQVaKc
	VBP9s7jvbAShpmCR6Llvhj/Aog
X-Google-Smtp-Source: AGHT+IGKr0tg4wfa/ow3W/EVExRfnIgxtfl1GG2pUunRVxKOWe+GcvyglhRSUatg+1ES39DdAbfINuD9qEkIGlFNufk=
X-Received: by 2002:a05:690c:4806:b0:6fb:8461:e828 with SMTP id
 00721157ae682-6fd4a14e084mr79033397b3.30.1740828858276; Sat, 01 Mar 2025
 03:34:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAJd+fZSUiiUm05D_eO3HS7p=WoxAWSZo51dUNjyGjUNJBvyGg@mail.gmail.com>
 <bca5c0ec-0995-421e-9745-330f729357d6@web.de>
In-Reply-To: <bca5c0ec-0995-421e-9745-330f729357d6@web.de>
From: H Z <shiyuyuranzh@gmail.com>
Date: Sat, 1 Mar 2025 19:34:07 +0800
X-Gm-Features: AQ5f1JotQbYgSSS0fzAropl7ozgIUL_cEmMiZWzlAzwdbOT8HM8kXKqMtohd9dg
Message-ID: <CAAJd+fazGWXFJ40dwL7mEMXS6FcK7GLUiN2pvN7F7XrHzsfj5w@mail.gmail.com>
Subject: Re: Subject: Memory Leak vulnerability in reftable/readwrite_test.c
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you very much for your reply.

Ren=C3=A9 Scharfe <l.s.r@web.de> =E4=BA=8E2025=E5=B9=B43=E6=9C=881=E6=97=A5=
=E5=91=A8=E5=85=AD 19:31=E5=86=99=E9=81=93=EF=BC=9A
>
> Am 01.03.25 um 07:07 schrieb H Z:
> > Hi, I have found a potential memory leak bug in
> > reftable/readwrite_test.c and would like to report it to the
> > maintainers. Can you please help me to check it? Thank you for your
> > effort and patience!
>
> I wouldn't call it a vulnerability if it just affects test code, as it
> is not executed by git (the executable run by end users).  We still want
> to fix those, however.
>
> > Below is the execution sequence of the program that may produce the bug=
.
> >
> > First, in file src/wrapper.c, function xstrdup allocates memory at
> > line 40 and returns at line 43.
> > Second, in the file reftable/reader.c, the function init_reader calls
> > the function xstrdup on line 202 to allocate memory for r->name, which
> > is the formal parameter of the function init_reader.
>
> Not exactly true since 12b9078066 (reftable: handle trivial allocation
> failures, 2024-10-02); the allocation is done by reftable_strdup() now.
> And 2de3c0d345 (reftable/reader: inline `init_reader()`, 2024-08-23)
> got rid of init_reader().
>
> > Third, in file reftable/readwrite_test.c, function
> > test_corrupt_table_empty calls function init_reader on line 935 with
> > &rd passed as the first argument, causing rd->name to be allocated
> > memory. rd->name is not freed, which would cause the memory leak
> > vulnerability.
>
> This test was moved to t/unit-tests/t-reftable-readwrite.c by 5b539a5361
> (t: move reftable/readwrite_test.c to the unit testing framework,
> 2024-08-13).
>
> t_corrupt_table_empty() calls reftable_reader_new() and returns
> REFTABLE_FORMAT_ERROR before it reaches the reftable_strdup() call, so
> there is no leak in this test (anymore?).
>
> reftable_reader_new() would leak name if its block_source_read_block()
> or parse_footer() calls failed, though.  We could do the name
> allocation only after those calls to avoid that, but that may
> complicate matters.  Alternative patch below.
>
> Also its comment in reftable/reftable-reader.h mentions that
> reftable_reader_destroy() needs to be called after use, but that
> function has never existed.  Odd.
>
> Ren=C3=A9
>
>
> --- >8 ---
> Subject: [PATCH] reftable: release name on reftable_reader_new() error
>
> If block_source_read_block() or parse_footer() fail, we leak the "name"
> member of struct reftable_reader in reftable_reader_new().  Release it.
>
> Reported by: H Z <shiyuyuranzh@gmail.com>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  reftable/reader.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/reftable/reader.c b/reftable/reader.c
> index 3f2e4b2800..f38c83f140 100644
> --- a/reftable/reader.c
> +++ b/reftable/reader.c
> @@ -666,6 +666,7 @@ int reftable_reader_new(struct reftable_reader **out,
>         reftable_block_done(&footer);
>         reftable_block_done(&header);
>         if (err) {
> +               reftable_free(r->name);
>                 reftable_free(r);
>                 block_source_close(source);
>         }
> --
> 2.48.1
>
