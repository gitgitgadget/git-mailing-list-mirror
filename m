Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A72F155C83
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723035735; cv=none; b=S1CwRvIdDq2tOSW5u6859qfu5ax00hcegg1xcKIbwXStPkKfg3ydmIEO7HwVdu/fWJnpecj0sWQAKd/fB4D4sk9p2XgmGwk/lvFjL2p5Its9knVe9P194XAExJckAc9nYxE8GTV1B+uYdtv6tg+NGlWA872vrJocxwmKHXVrIU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723035735; c=relaxed/simple;
	bh=Rp5VdntqtE8O6Ux1HQ7TNm3j3pFb+0t7WCSwDfIDNYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0qlJrruzf/DzBoGtxTqNZR0AI1EvD6tkpxDR/rvKTwKMMiZIYxRiPDy+ZcL4fkv5ZTcdf1NCLxANwG51PQagH5oTYJ0ETFwc9csofg2m4S7PCmyRy6hzk0crWZiOwxkslap+zJkrjKOh8LYVdwoHeYlkcgL6YwhC56R8Cx2E48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReU6uYef; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReU6uYef"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso26528621fa.2
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 06:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723035732; x=1723640532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=di6vk/WqVcB5PN1VC06V4dk+W6bNhv0qnOlICBtltw4=;
        b=ReU6uYefpNAnAI7yvsa21bIdxahfTF57OQsezPo9eyn+XFV1wx/OyVZAKrCfRD0dnQ
         VhgKsI8Ydp2HOgpNl745crptfUUz6LpyB8jgW7uS+Dn5kK8iHPp5d5bvq9/cVy1He6uj
         sz7x2IYv2WcNwY7U2dxPgxz4ZNnIiQJZC4fXbsElkbtQGIP7FQ4MP6XxGmIp1w+7TRyF
         JTwCCFqyEeBVh2jDRiog9ZOwnkjxSz2ZJNU5T8QHpZotuCZt0A9YdMHE504cdX2fB5jy
         v2qdhmoG/Wg7a0JBjJ6n5a0jQ3CuEUcl3qkaoSwcmiJmn6TfTTDA6S0c3BH+TFUAh0GZ
         o7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723035732; x=1723640532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=di6vk/WqVcB5PN1VC06V4dk+W6bNhv0qnOlICBtltw4=;
        b=tabK821Fbh3jQjdZdsjdPf42BUietXmMgwL/kXFEqCf44ncM7DtOss8B8e2nS4ZOtv
         YRRrhTcNkMu5rllAoU0dzHI/Dl37UjzDR2W3fQ5VIgiAqcYPzSMXvfKYL4rhNCZ9kpVm
         UZbTyPK2BcfQIpYgSPGrwHBM31eQZZEEBl/e97UJg0neGss+H5w0CBpFjxKBPgGjt+bA
         azTTxIs/kdJrOS/hpILZ+oM5uOzdAPEr57hZ5fyHonhac1uonRx2Cs9DU4SUfQN4AByy
         Yl212EWhWolOW/j2XMVYqGRfXepyTV/9yAu37svVMM9483x8BMBVNfVf9wRDbfwrRR62
         nwQw==
X-Gm-Message-State: AOJu0YwS8XXN0XIS3tyizA+gsiv3qcEr1ljHqL+s/ks+Fb9Bc733YsZ/
	Q+YYP89SrLtl9tHBgmZvz4pIUgAh8zbcfSP6LNHOT4RESM/UgnnJo5b1PW5EJip7BQ6bPQIrnw6
	gvaXN7RD+TFSk2E0VpMV2fo4fhKs=
X-Google-Smtp-Source: AGHT+IE3uLmmBK+3gZwp79OtLAN5++Cst6qG4rt3Ny1Kaa+v1iPdH437UGYAesf4pVyAs0Mc0V88FJlCLExBvppCXcc=
X-Received: by 2002:a2e:9a85:0:b0:2f1:924b:851e with SMTP id
 38308e7fff4ca-2f1924b86bemr26006341fa.40.1723035731987; Wed, 07 Aug 2024
 06:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806142020.4615-1-chandrapratap3519@gmail.com> <xmqqed71s7yf.fsf@gitster.g>
In-Reply-To: <xmqqed71s7yf.fsf@gitster.g>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Wed, 7 Aug 2024 18:31:41 +0530
Message-ID: <CA+J6zkTr1m7WSpE3-GSCkhQhaTsG3Kvzuh-z5SPnK8qXvsg3qA@mail.gmail.com>
Subject: Re: [GSoC][PATCH 0/6] t: port reftable/stack_test.c to the unit
 testing framework
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Aug 2024 at 02:08, Junio C Hamano <gitster@pobox.com> wrote:
>
> Chandra Pratap <chandrapratap3519@gmail.com> writes:
>
> > The reftable library comes with self tests, which are exercised
> > as part of the usual end-to-end tests and are designed to
> > observe the end-user visible effects of Git commands. What it
> > exercises, however, is a better match for the unit-testing
> > framework, merged at 8bf6fbd0 (Merge branch 'js/doc-unit-tests',
> > 2023-12-09), which is designed to observe how low level
> > implementation details, at the level of sequences of individual
> > function calls, behave.
> >
> > Hence, port reftable/stack_test.c to the unit testing framework and
> > improve upon the ported test. The first patch in the series moves
> > the test to the unit testing framework, and the rest of the patches
> > improve upon the ported test.
>
> However, reftable/stack_test.c currently is a moving target because
> there is an in-flight topic that improves the table compaction and
> that topic wants to add more tests there.  So let's wait until the
> dust from the other topic settles before doing the first step of
> this topic to move the file to t/unit-tests/ hiearchy.
>
> Thanks.
>

Oh okay, I will focus on the other tests in the meantime.

--snip--
