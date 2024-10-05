Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC1A231CA7
	for <git@vger.kernel.org>; Sat,  5 Oct 2024 03:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728097992; cv=none; b=onNI+ZA9yrwyqkTmEKLEl/1f9KgPWian4oT0XJw797vjoomHyaHzbKFUNWiA6mGjDE8u97+tOPBDDobUlxImSMqnuvmL1hmIV+zJzo2TARn7ezMdZX3z/zjjQ2S/Ma+O1SOHvLJ7A8a3Z8k7z7FDo2smxEdgvmLYjT7nZx50ljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728097992; c=relaxed/simple;
	bh=tXVaALbMrOJEwLQK8fndkJEs0Aw3E0rsiV193DzD65E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcgzlDSElNRIl4ES3cRJFuQ1zoOCNja5tTlll2PT0LHtY1qQTNpWk+E027wxtzWCKFTBSoXU+PCFA37JZeofjH2MpwWpfJAO8961f7y7R9tc1A7m71bhWwd16Ik86k4IuyO2rttfw6y0Dja7ksYTGsZWBwj/t8/HUZB7CG8L4H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b=xFXfZHaP; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b="xFXfZHaP"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6ddceaaa9ddso27488007b3.1
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 20:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree-net.20230601.gappssmtp.com; s=20230601; t=1728097989; x=1728702789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOLbMO6sfRilLpwB9yHm28CHAeJzf1486rt+bpr0Qr4=;
        b=xFXfZHaP5vo7nNrZEDLig3dnDsVmgD2dePoxd/ZT2CT2FLPIdSWqMjO3pkJxQ/ZFs7
         y5FzZySq2/PwMFsMoZcqEeJmcjoSljz+R8+8/lwz5CD+BVnVCWJVVqqJ3q/pufFe8CTs
         z5T2gvF7QpY5wfQiygpwexpsAU8xJ3gSaAv7qk6yBUnNBDY5Ju9YbA1nVifXEjZ5WlFf
         ZhJiB/VU7RWlcKKSgWaOhu2Ks6Xo7YiKg7jv9ECAoLXbpWOfyF5Dt6cwuUNgLLUttYl1
         ZbvMFujM57agv4EH2++u2fjrH6FpzjhwOUgOVWh33TC7bghb6zQFFXvc5HK6jKxaAy98
         xgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728097989; x=1728702789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOLbMO6sfRilLpwB9yHm28CHAeJzf1486rt+bpr0Qr4=;
        b=L8AuqBIDOM4w8/9N7ZYayy1L4fvUliT+YMWUw9clzyhMQDPElKb7j0AkWcgBWlnLN7
         Iuhv0ezsBbiaK2zXjKasM9ccqOaAA9C2clt6hVHZZ9oCGwgQ5RmE0ROaKX/iHK/pjnDc
         cuHesgQmzy495w1p+CpIjTW3X8kMz+gAnLWd1egNONOvNiEACDUvfjrCk8tPW17KVreS
         cZXbdysw43goePKC0ukmx1NzwuzRmKBAuuf4PhrIugxtbBg/arnnmzdxe4rNVdOnThKL
         +7xapzgtiISjNqO/ywomCv1Cp2SzofZLRAbUPb/V1qtTWGZhItmH7XxhMVALqJkCt0R3
         k79g==
X-Forwarded-Encrypted: i=1; AJvYcCUTvA8xjn9TiRbymL/+2in+x/29hGjZAYrOnKXo5u9yQdmVmVcYn45WAYWKRftojldMLZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXgHjUadC4ttnCBZT3u0yFyyS8qZzOy8VAXLIPFCppJSwv+gjV
	MexbnhL9OLTs+dn0691cEXQd/mpNY4QVTaxe4vWRqeGRZiyPps0jkJUhBhuQSWga40JwuJvjdd+
	J6aq4qLvKhNsu/0oz8ltJrJtProqtf6gv+F97iT4LtvbfsmiNAggIGzOMWwHpvpZnDHplY+61i0
	8x+sAA9afwWj6VZAbMOEnnWLqUWk801yt2WG9HjiR2T+CAj1mCZNV2rJeUaE2shty6hp6+HfVLm
	4QC94du6pbRXgwTUN3bqRnEjJvKwyUiINdudsgvrHMxdU7ehzZUZKOjXblYU+fXOOlT3mhrIEXH
	yNWeyfv/JT4=
X-Google-Smtp-Source: AGHT+IGWP/ktUnjLgeoG5o3fE8FY6kJf57WZlyk9tiG0L2PDHUKG3D0auT5Ra4Ta/UO+nV4nSz0VDfs1JOts+kTIuT4=
X-Received: by 2002:a05:690c:f8e:b0:6db:31f6:a812 with SMTP id
 00721157ae682-6e2c6fcba10mr56174767b3.4.1728097989273; Fri, 04 Oct 2024
 20:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1802.v3.git.1727810964571.gitgitgadget@gmail.com>
 <pull.1802.v4.git.1728000433326.gitgitgadget@gmail.com> <xmqqiku7epa7.fsf@gitster.g>
In-Reply-To: <xmqqiku7epa7.fsf@gitster.g>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Sat, 5 Oct 2024 12:12:58 +0900
Message-ID: <CAOTNsDzTNG8-CtRb_Uwn92cUP6+4YHsLmJt4bMcORq1vp7Wa6g@mail.gmail.com>
Subject: Re: [PATCH v4] fsmonitor OSX: fix hangs for submodules
To: Junio C Hamano <gitster@pobox.com>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 2:44=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
> > ... The test is
> > disabled for MINGW because hangs treated with this patch occur only for
> > Darwin and there is no simple way to terminate the win32 fsmonitor
> > daemon that hangs.
> > ...
> >      @@ t/t7527-builtin-fsmonitor.sh: test_expect_success "submodule ab=
sorbgitdirs impli
> >       +       done
> >       +}
> >       +
> >      -+test_expect_success "submodule implicitly starts daemon by pull"=
 '
> >      ++test_expect_success !MINGW "submodule implicitly starts daemon b=
y pull" '
> >       +       test_atexit "stop_watchdog" &&
> >       +       test_when_finished "stop_git; rm -rf cloned super sub" &&
> >       +
>
> Let me update !MINGW to !WINDOWS while queuing.

I see, Thank you.

Koji Nakamaru
