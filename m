Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AD11DC046
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736169623; cv=none; b=dm3E0+22nVxTWhg0iJ3+u/H9oCmqO+q9X0ib8+AZKOGySw7f2FOpXnv3/CZ0LFXXrhg9bwcz7E3zR3gZsO/foO7iO/9cuEYVHVM58gCg95/ht6Cavk2TDJ5GuBeQyCfgzFH+dRM9+YKH9p3Lnl1ilSEFh5Ga14f75+h8MHtO7uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736169623; c=relaxed/simple;
	bh=n4l+qWp+LYFc35LEThZHKvm+fXjkFTnwWmJ0qdfbyUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M36MAZtH7NAS7Y+9Zfr3TPwmK59CiippeNQEwBKBLQyqWal54Ev3iAzfuWEtxHvVA0YnmDTPxJyuivr/f0NKPRsx04tn2xCOEwUl+ODH8s0u7qiEJISM0t4JIz+mkFKUcjVU2raUeTRjiyenncwReHPT7Hyhd0LScRHv+T+BK6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pwah2oFo; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pwah2oFo"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3f28a4fccso22834910a12.2
        for <git@vger.kernel.org>; Mon, 06 Jan 2025 05:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736169618; x=1736774418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pq+EEL20F7+yPdis1qHV0jVQVe/4lrgbj3qZqusm44Y=;
        b=Pwah2oFoJiexjVsztxQM9xJjuKXE9o/xGb+H6GPQIAkvcsvHW1Ra/4PH3AumeJhLiP
         5ij2HXrkHJSKA51ISB/bynBjuT+bnGFIA+gMrVMifxsiqQpTx2zJrZjoGav7sxgSyCn0
         Xe+WO3CI4J9Cvl7qCUcENSVXiMe8FwtsdumEyCnMwKkoCgbbaAhTx0PpMbzcGX58CJ+k
         5nzFL9bPAwZMLLd757acnT4wcR/5v+tyIgRYP+35pzGNzma4w+taRoYBtRdQs7UC4n+v
         Fdmn/k4R9FAKIITzl44FPvCWBo65g2z4tjvYRcOiwuh0eQex4+I8fEpo9H/os40mTOtg
         tLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736169618; x=1736774418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pq+EEL20F7+yPdis1qHV0jVQVe/4lrgbj3qZqusm44Y=;
        b=EbeR5/rV7460sZNjtsPc118L7zchfRoXWJe4Hlr+N8d9tdfRYwLVe7hbTz4owUpipr
         T9Ilf1kKiYFhnkjGHZyLtUZ6DTGUhSZZWoGmR42aiD0xtz1W91OLMGV9q9SD3MB4Dc28
         wvphhQms6yZ8D5HUwHeWbve8tTM4egHc8IgL1Y0GTkpXDH6/gawgqhB7X2PPRfjh+ecv
         1Z3SOlvZ4KTOzjiTYRjL56TBUccEYgpy7rZXPP+anlbg3D+NqKhFHcW8wWd5Q11SMQye
         NVdq/P0ikDMvsV62NnVEvzVSACz5cPvGPEixRDh0O5+/GBrL5tAZdM/BJU719YoD31Cx
         gUSQ==
X-Gm-Message-State: AOJu0Yy7CJS0KvEERgvlF9YTKvVVw+zXEEAkblAnHAu+yYXF5HidJR5T
	7wQLR59XxANi6LuC77IkIP5QsrurNBAZYoSZZMjWWPbsPXGNDjWT2hUdU9AlKICu2I31/dRYnmf
	5l8fS87B1oPR4fldBKT9jYXV2JeE=
X-Gm-Gg: ASbGncuHq+dolb3GIC1xmWMNVbJYjBUrVkNfsRTBWCoPM+BnLLcF6Bap8mS0XMmjgDy
	x1QWl668t/U9orWl4ryn6qXmCeBMBsCDyx0Uvx/u/
X-Google-Smtp-Source: AGHT+IHAgPLqX6pWwntndMXRaDMBFTl239y70Uqw3M4lhyDJs8PnXASIXoZvJ4qBchQ1OHlFIY9vA1HST4AoULBq/TY=
X-Received: by 2002:a05:6402:430c:b0:5d2:d72a:77e0 with SMTP id
 4fb4d7f45d1cf-5d81de086bbmr52606045a12.30.1736169617995; Mon, 06 Jan 2025
 05:20:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
 <20250106-pks-remote-branches-deprecation-v2-1-2ce87c053536@pks.im>
In-Reply-To: <20250106-pks-remote-branches-deprecation-v2-1-2ce87c053536@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 6 Jan 2025 14:20:05 +0100
X-Gm-Features: AbW1kvb038NUTWyqdznV-QtMKS3I84ruQy7WFhp3VeSS3K_SqEFD7QwXXLKJa1A
Message-ID: <CAP8UFD1wM29BFX7ndh905dX8aDF_vdG_azf9phnY+Cgutgfj_Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] Makefile: wire up build option for deprecated features
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 8:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> With 57ec9254eb (docs: introduce document to announce breaking changes,
> 2024-06-14), we have introduced a new document that tracks upcoming
> breaking changes in the Git project. In 2454970930 (BreakingChanges:
> early adopter option, 2024-10-11) we have amended the document a bit to
> mention that any introduced breaking changes must be accompanied by
> logic that allows us to enable the breaking change at compile-time.
> While we already have two breaking changes lined up, neither of them has
> such a switch because they predate those instructions.
>
> Introduce the proposed `WITH_BREAKING_CHANGES` preprocessor macro and
> wire it up with both our Makefiles and Meson.

It's not clear from the above if the two already lined up breaking
changes are going to use the new build option in this patch, in a
following patch or in a future patch series after this one. Let's
see...

[...]

> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/C=
MakeLists.txt
> index 49904ca8a93981c514540bad5efa6833ddd14426..63d008892848c20d5937d9a62=
4a480f700b19498 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -1198,6 +1198,7 @@ string(REPLACE "@GITWEBDIR@" "'${GITWEBDIR}'" git_b=
uild_options "${git_build_opt
>  string(REPLACE "@USE_GETTEXT_SCHEME@" "" git_build_options "${git_build_=
options}")
>  string(REPLACE "@LOCALEDIR@" "'${LOCALEDIR}'" git_build_options "${git_b=
uild_options}")
>  string(REPLACE "@BROKEN_PATH_FIX@" "" git_build_options "${git_build_opt=
ions}")
> +string(REPLACE "@WITH_BREAKING_CHANGES@" "" git_build_options "${git_bui=
ld_options}")

The commit message says that the new build option is wired up with
both our Makefiles and Meson, so I didn't expect it to be also wired
up with CMake, but it looks like it is.

[...]

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 62dfcc4aaf959d0cf066d07663d939e14f92485c..6e423f655d35adf5a2d4f8b3a=
78d9e8c1119caab 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1864,6 +1864,10 @@ test_lazy_prereq CURL '
>         curl --version
>  '
>
> +test_lazy_prereq WITHOUT_BREAKING_CHANGES '
> +       test -z "$WITH_BREAKING_CHANGES"
> +'

Not expected from reading the commit message, but nice to have too.
