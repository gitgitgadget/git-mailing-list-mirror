Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7751430EF64
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 00:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766537422; cv=none; b=fajgtcydusebJOQey8pObGvwGuvJVFkNalFA5FpfhjmBcG7ujrdAG8KdZrc1h4VVCg5NYud07ZHH2SilyT5VsI0AggqCjGF+eT+Ay6PoEK7z4CWurfafq/d8eblMEiLfh8aE8zM2QzVhFdmywcoiarR/MybE/Q1bT0y9DMmWOPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766537422; c=relaxed/simple;
	bh=ffi0tb8VHcXrQWALlZpO+cj3nIrRkObFm2jotup7Pw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/X/u1fjMt9H36VUrxFiWFYQua1TmIXeVPWHyeNn0sbq0LcxAN8jWrZ4F6LTVnAtfSembQOslRKdMAZGmMkuyE9aoctJD7532U3IyZs9CiMMK+3i2O2UoM/YC4w5YUPkNb4nZC0BtaGPNHvI3TJUzcvPORDwIYo0BFYzN27i9AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5JEoo32; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5JEoo32"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso55474535e9.0
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 16:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766537418; x=1767142218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gX9q6wyVvzx0Q+IA+/ikqRyCUQ8g4Xu2keVkhPc5gdo=;
        b=T5JEoo328Or4ieuDxOFIvfiCtJ2IaqZ0461yv1COS46kt4BTs6GWy8nlSwA3qZN4U+
         x9YonV7Hvjd58ZZogIfuBgAiHuGUN+eXbaOJpcHtNkEQooMjQvXb7gzLH/aNDotmcaGa
         yrgBknxyyS2QQTN7jyGoKmSuS5loEjH8evtcCtwukGSTgEzOlnvwPwRrJ7MfgbHO/O8I
         aCjboXuLOmuSkbjELLXHx+3AkZOQQOt4Lbq6v/HIfgO3b+paLtq1HfoLGrMeczLboCtj
         d85XXavQd2K8GDes6WrkcN1ho9nqugTtlRG5pOohy37otE4atqJVjSlMnykXLUtmrSXU
         uQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766537418; x=1767142218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gX9q6wyVvzx0Q+IA+/ikqRyCUQ8g4Xu2keVkhPc5gdo=;
        b=ixW8BJIR+kW3pPyJHQuByb9/u28l4QlfEh0w3nuuXRuVYMcJxch+h1pivtMQwrk2il
         H+mQOI1NaewpqU5SdfxKXBcwpp9+BC8pbZT5fl68SQ6+CsEIaEaBpQHxvk3QntSmGeIQ
         qWnuKrzZwPc5dBnBhfcORAhFYqrut2luh7dxsKOCGU4GxTmGN6zCmquqwQ+pZRkX69HY
         0Xc+kxS7hVmQsqoFqvsiz0HZuO7b6fQMDjAkBuAzy/mVZ0+OJfF31Obmp/d8Emn2OsZc
         ZZOIsE+yU9Qr8A4mUh5RIwJ1PYdnvvH7IYmF+qWvyAWzBesAkLfkPlGzSK+9CgcYYkYb
         iQ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4g54O1sWRH7Q9lLaJnqHe6sP1igzzXo4lBXHtsg2DCTk+qxpAtkbUNHSdk7hF0zh2OSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqME4CSuA6gkLXgjPOpeCnP7Bvr6/NYcatic7Fy2F/H4DkCfTn
	ucbstkgjY0Hsp0WP0ZZx/LoVbdcYnA6PozqdGIe/LyJ4TCvP34zYBMnyXujQRGAR3GyB+9lFOgQ
	iErk2HMCgju/wHtjjQ5a4FCnh3Ur3aSc=
X-Gm-Gg: AY/fxX5qxANTCNGvA72tZJl5hFXLb52C8o0vO5AoIWq03SRxjWsDnuxLAfWbUl/+q1V
	mGbsG14oUP32YSFBPqsvOE8NKc/Rf3LJRlw61Fgtqd8zkfzM5GdTR+vrs36NMu944wWeaYL163Z
	0O7/8sy8tAVaqg3BOTSKLUltHH0vw6oqMR2/y1QFS6SESv26Ca/FhoEmgzlbbXV62MNFAmnFGKT
	if5nBpuBgvAkl13vobUnoTfDtmV4cN51Mf/w4R9oXDdWVPvx0SMUNZ2O9/cnqdNOsKf+Vc=
X-Google-Smtp-Source: AGHT+IElSOTOUgykClFJa75hFKIGp2ihZKfHUgvaR2utsp1qXy691/axzKqCTHmHI9XflA4N5N468juwxp37wSMSGYw=
X-Received: by 2002:a05:6000:250d:b0:42f:bc61:d1d9 with SMTP id
 ffacd0b85a97d-4324e4c9dc4mr18162404f8f.20.1766537417946; Tue, 23 Dec 2025
 16:50:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2138.git.git.1766451217075.gitgitgadget@gmail.com>
 <CAHTeOx_kSX7RhVvjjffSK849MMQbjNreqrq=ezHazw0GjMO2Ww@mail.gmail.com> <xmqqy0msogso.fsf@gitster.g>
In-Reply-To: <xmqqy0msogso.fsf@gitster.g>
From: Yee Cheng Chin <ychin.macvim@gmail.com>
Date: Tue, 23 Dec 2025 16:49:42 -0800
X-Gm-Features: AQt7F2qIMlXWgjcBFbVsgSMDZ1NZq3WxCsQboNx3Pd-OKW9EVwKH-G2uwzoHHhU
Message-ID: <CAHTeOx8nrjJVD0U0=BDTUJZNZX0Xs_b4YGbj=WSavWEPEg-9Eg@mail.gmail.com>
Subject: Re: [PATCH] status: show default branch comparison when tracking
 non-default branch
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 4:38=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Good point.  There is a mechanism to determine where a branch would
> be pushed to with "git push", and where the new material to update
> the branch would come from with "git pull", and these places need to
> be considered when doing comparisons.  This series seems to punt on
> determining both repository and branch and instead uses a hardcoded
> "upstream" (or "origin") and "HEAD", which is not satisfactory.

I may be speaking for the author here, but I think the reason why the
upstream discovery (or alternatively an additional configuration in
the repo) feature was suggested is that not everyone uses the
mechanism you described (which I think is the "pushRemote" config).
It's true that if you *do* indeed have separate push/pull remotes for
a branch, then both should ideally be shown in `git status`. However,
oftentimes when you set up a feature branch it may not be correct /
desirable to set up separate push/pull remotes for those, especially
if you need to collaborate with people on the feature and therefore do
need to pull from the same feature's branch. In this case, I think the
author still wants `git status` to be able to show the diversion from
the original upstream master/main.

Personally I wonder if this feature gets added, people will start
asking for a list of "upstream branches" to be able to be compared to,
rather than just a fixed upstream/HEAD or origin/HEAD. But maybe I'm
thinking too far ahead.

But for example, I maintain MacVim, which is a downstream fork of Vim.
As such, "upstream" is a fluid concept for me depending on what I'm
doing. It could mean deviation between ychin/macvim vs
macvim-dev/macvim, or macvim-dev/macvim vs vim/vim. For complicated
forks, it's feasible someone may ask for the ability to see the branch
comparison against multiple branches concurrently.
