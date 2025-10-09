Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1047235044
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760029459; cv=none; b=fhZj70J8gkiMyNCBOHcOpH+UZXU6Pqooo+lwDMRXTmSDX5gZhZcVoI3qgaqVVlxpD7BGGiMuZmVAAr06H0+g9Xrbl2sgYQfAEsJlufRtYAaRorllyduK279pwKFtjBv1gfOH3MXE45wn+18DvIGsX6yNqDbaIQ77JoIB2v1sMpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760029459; c=relaxed/simple;
	bh=cqlkkH61ogjrNO2kBLixFzK7fYMftzKv3A1KgfSCu2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SW/SEO51P9RNcyPH3kdUTQpBYK2QSddLc6Na+ofPpVDkSFKDYQkOBiaukR99LsACjFSJZmvjJeKS9i3vaU8aghs3T1xNx9b2cex7MlG/cwMCZ2qBSBs3yMricv6TKfNrWlsF30OOrQaBj7Igg3Emg/ASh7/g7ViBYViroMtjINQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPEnGwQD; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPEnGwQD"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62fc28843ecso1731491a12.1
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 10:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760029456; x=1760634256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8N+hyWxeceCTSnM1FcDRgWh9+XQxKTYQ7t50EPBaKtA=;
        b=TPEnGwQD5rj3KIQ21IWEobD3im3wmZ2YYbLpnr0abKnSRryLNxYVembwh99Ag//nSZ
         xDJspDzR+pnOECHW1vVDvzT/qxHkUHpIZMf/g6yf9iQKvExnx9FV9E2YsLdSbMC47YSE
         MiBhC2YItag8DIrppHWr/BQgDGXeLeTkbOOme0cI77hFvNHUgF1Lz7hSR8N2Kx42ghox
         lw/t7z4qudXlX1AZpalFt69mkWstp12fPxNtDiohy5ZyeRkjvxjrcsioVMewBRp712nV
         +yeqVzlGAnvHh1jzKFHRqSxHZ4sqWoGsiKwbSimYomV2S9QgNGzXzUCJAK9Xt35AMDmi
         ymsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760029456; x=1760634256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8N+hyWxeceCTSnM1FcDRgWh9+XQxKTYQ7t50EPBaKtA=;
        b=kZeSV/YMtQAwclx2s963+kuHV++wztDC2oMAIAlfnyOd1GP2+ddAqvuqh0fDrWNDzA
         0o260AdQ0yjKE4oRA75tJmriiHxdasNGns7f9HHO5ORVItXAjOCzqhECpW7lKIgv/DuO
         NjtSIwWT/7IQm62hapd2udHB8sVqSHkYgIbIFt9B2uMiMMCc7Ey3r5gzSxdfo79Xbpjc
         1D85Boz6Pj8+3KAkzLQ/gLC0zD4t6D0BTBWAMys90m6dYbVNhh6Pmil1Q33Oz2Kbpug0
         zgS0rIiODhC//DrT9YLu0LI2TaSwblYxEwO6JQhqEW73Y/FQi/ywBivTk32ZMfoh63gd
         738w==
X-Gm-Message-State: AOJu0YyrRj7so0A5qmj8mFSnAEfEdeWfRx2btGdXJKyjXeq/w9J4TdHW
	89bR2Vrc5JtlOpsVRbt36DEFg8+8zM8kpYBW+wvyuafwCrJyWoqwJ81ZqswG9uBN9M5smi9IZ+N
	KmXAH0nXFUadjr+bC+LOYvrbv8y6Ez7U=
X-Gm-Gg: ASbGnct+NnoV/GoDvPe5l1QQF9CKVHfAR/UVYpxb0O5pnXvEDfEXi/s6XuzMv1NTTLI
	TFzyWgjHvENhBezZUPtjfO5WHFuHQC1eTUlWKz0tKx/gE6cT39zaLMUbj6XRjRr/iIkDtnVOBe8
	KY8zpd24rek/nohfe4PnGgyLW1y19+DefivGaoxt7FCc0wBfFkCfgtUS/NWnZU9zoSGF2zFSiWk
	4NRXOsfo6CE1jCPi5f9joEKbi1H5L/SmTr3+6D/zg==
X-Google-Smtp-Source: AGHT+IHuWVLTvMu8BZRPxkXmqlEYr+ImG/SGgohuZNeaVlxVTMeqdLvciZxYEup9F836Ehdpb+32pcoz66YvFJXGIw0=
X-Received: by 2002:a05:6402:5cb:b0:634:ce70:7c5 with SMTP id
 4fb4d7f45d1cf-639d5c440abmr7519206a12.17.1760029455633; Thu, 09 Oct 2025
 10:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2066.git.git.1759741252581.gitgitgadget@gmail.com>
In-Reply-To: <pull.2066.git.git.1759741252581.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 9 Oct 2025 19:04:03 +0200
X-Gm-Features: AS18NWAN4tmwIgB000nbij7emh-3FxHGMFObEc6A6jsiGHkK5d9MQdqg7rtGG3o
Message-ID: <CAP8UFD0wa6s1z==dVhuiCALeC7X56CS50qMhoPAdTzT-qy6wXA@mail.gmail.com>
Subject: Re: [PATCH] t1410: modernize test path checks
To: Imvedansh via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Imvedansh <veds17007@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 11:01=E2=80=AFAM Imvedansh via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Imvedansh <veds17007@gmail.com>
>
> Convert old-style "test -f" and "! test -f" checks to use the
> modern helper functions 'test_path_is_file' and
> 'test_path_is_missing' in t/t1410-reflog.sh.
>
> This improves readability and consistency in the test suite.

I think that it might also improve the error message when a test fails, rig=
ht?

> Signed-off-by: Imvedansh <veds17007@gmail.com>

We prefer when the "Signed-off-by:" contains the full real name of the
person contributing.

"Documentation/SubmittingPatches" says:

[[real-name]]
Please use a known identity in the `Signed-off-by` trailer, since we cannot
accept anonymous contributions. It is common, but not required, to use some=
 form
of your real name. We realize that some contributors are not comfortable do=
ing
so or prefer to contribute under a pseudonym or preferred name and we can a=
ccept
your patch either way, as long as the name and email you use are distinctiv=
e,
identifying, and not misleading.

The goal of this policy is to allow us to have sufficient information to co=
ntact
you if questions arise about your contribution.


> ---
>     t1410: modernize test path checks
>
>     Hello,
>
>     I'm Vedansh and I'm interested in contributing to Git through Outreac=
hy
>     2025.

Thanks for your interest in contributing to Git!

>     I have successfully built Git from source on Ubuntu (via WSL2) and ru=
n
>     the test suite. All tests pass.
>
>     For my microproject, I'd like to modernize the path checking in
>     t/t1410-reflog.sh by replacing 'test -f' with test_path_is_file in li=
nes
>     133-136 (in the 'rewind' test).
>
>     I found 4 instances that are assertions (part of && chains):
>
>      * test -f C
>      * test -f A/B/E
>      * ! test -f F
>      * ! test -f A/G
>
>     I've verified these are test assertions, not flow control statements,
>     and the test currently passes on my system.
>
>     Is this appropriate for a microproject?

It seems to me that Usman already answered this.

>  t/t1410-reflog.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> index e30f87a358..ce71f9a30a 100755
> --- a/t/t1410-reflog.sh
> +++ b/t/t1410-reflog.sh
> @@ -130,10 +130,10 @@ test_expect_success 'pass through -- to sub-command=
' '
>
>  test_expect_success rewind '
>         test_tick && git reset --hard HEAD~2 &&
> -       test -f C &&
> -       test -f A/B/E &&
> -       ! test -f F &&
> -       ! test -f A/G &&
> +       test_path_is_file C &&
> +       test_path_is_file A/B/E &&
> +       test_path_is_missing F &&
> +       test_path_is_missing A/G &&

This looks good to me.
