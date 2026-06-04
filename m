Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC8E3CC9E8
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559137; cv=pass; b=Lt6d1sd3jCOSC5sjlls/4XRvPXe1leEOwp9kn+zhWQpLDAzNMRCsxGLsD9TmVLfAZILgWzQAnblDj+3SziqLiVBhF78lTosNQCXLgusnqnhVS2jdnetBFWvyua3O7+r1tW/304orL8QmPoEmU8GeAsb3Z3PZH1byOT6vdrGjUEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559137; c=relaxed/simple;
	bh=XifwBJJCAm1HhJlBQpvEaLJNNjXwTeEPIKfKCRKo8No=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+jh1gikosQfuPsHfkxmUUMFY5/bZBF6g4U6k91nKh4gCxewDAikvTyHqZmrwfdLXaQ0x8l4G24M1o3VsEOWy28PNNthE/DnyNcoYxCUPvCd4f4wg7/kexIh6h6PFxshPMGCgRG8ETirpROQ7gqgCLt6hQphWHriOe558xM8byU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sfUHTgzd; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfUHTgzd"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-137f3cb3f46so135851c88.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 00:45:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780559136; cv=none;
        d=google.com; s=arc-20240605;
        b=eygU6P8Z9Nph4CpM7Ckxpu4ULM90RzJ2aofmdss5y49o3WY3Sy1KxuWndX1zAf8gKX
         zn1uxw3/dplVe6S8DGLStZsmx5r1Nm8yc3c1hWhUC8OhmF+s/au8YZw5SRuYr4OZVitt
         zWAC9q1DcYBanOTjMGkixuV/rHaF+J7i/IXli/ydPMosR5XU6veh80tCG+JAsjy4/Ht8
         uR2v7nySDOWUUt4f4uVBYagOn4kxiqoAxWEoZkTXEFGUc6F6h5eilTKimPULKaGXvCNU
         T2ccYIS1aDyJKPBX6F8grRImHmvx5ZFGHIvYjjcfSGhnXU9O2t7zY0m+VzWIKrU85I8M
         1Ojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w+3pZWho3zpkcIvRPWzTPkh+1QiyLKtr++6FuTu+1HE=;
        fh=Y/d59sITq5949WwvU3zYdo8lHPNrZ3W0dZRkIOr+ZHY=;
        b=NTeP39qhWEGmaCPEIo1h7nhwFZVI2nj7xMNcru5rXeVs2mxqWCbbRpYHmjY8mdiA37
         lvndxBjajCbfDoMzC3G/Sd6uut0ymIjFVEvXlxHEIEM9sXxS2MGnT9qDImkRMkJ34PsO
         kGjx2KePOcQUyls45NOxrtHFVJDOxQDYiqZPhvdFJ+vTQSBhSoi2L97iPr5G/hBdihi0
         ZiPiNvBdvkdo0A0qq9uTh3szFwU0eerlq2p5z91f4nyg58K8rhW5HK/h4cWBKZfsjWMR
         WxJ02w6pctF7oL0oK2cC3WHGRAp18dbdMEaJsSrdYn5kf5KDaAQKr0glOY25mH7r1/dP
         LDkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780559136; x=1781163936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+3pZWho3zpkcIvRPWzTPkh+1QiyLKtr++6FuTu+1HE=;
        b=sfUHTgzdp1LYMTvJ8KBx13MAUvCVfZDlZv8nVl9cyVy3xv043birpvBbMkfSIxKA+/
         EwDUg6mFCeH9bmengU8/4VynkEh2xJpmyMwD5SjlpvXePugdse5BJj19SH7gQGR1Uabb
         f3C9bLApBU+ZOm1hZMaQb5reY/VCnqLEf8l4+okVI+AezCpPYJsZODDElOr3OK55Y6WW
         UQObfaoGgxOvtPegcpnlQg+fLYOwUUDGNULAS0QVhB8t1PZMm67m7LsmBIsmXo56gtUp
         zT1v2ugSN0navVqvjtlQ1/ozxD9ATxhZit6Rj+r/MXyBJWZBKWs2BsCKOq1pemF1H9gr
         gfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780559136; x=1781163936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w+3pZWho3zpkcIvRPWzTPkh+1QiyLKtr++6FuTu+1HE=;
        b=nB9IUTF8WoU2Z57SsD55PIj4ZXrmZX7QyZvCmWy3sbg7i6ZUv+ZL9js4evHhAedXDT
         vDO+eDpNKbHlTKs6KsbKPotK5vqIdoKipAnT91TOFOM58aaNr6cK0ftZlbmKQ3X6j4uw
         lxbBoWDtfne2VgkhLAVOxpLRkIdn24geseLCrD4qDaeE0kR1brdTzlVI3jTlviKeCwaV
         afm6QnUgqOfWd3uANS5ymiIKZYthGMwAnue3/qWXlm4SRYX6x47cBY2Mu8OEQRYUIeqC
         uUMiSpVtJ0oX6JJ/39GF0bbkkh1G7DzUimsN483yUr1Gf1hCzaGS6ecdENVjJj/tSJ3/
         kriA==
X-Gm-Message-State: AOJu0YwHXpsulZqd5vEfpkC8K++u6YyFZR+sA65e+RxO7cYbjYoUZ/nc
	Z5/erZ6HE6G8w/KUDRxzU5s4k5E6siDYqIJDUhbH+aKf9AKqQ/+9vOHt/u7K5IMLJCmFG5/D7eN
	E7qLqDXNexK0UWMaDe4Xha9FF0oFs07o=
X-Gm-Gg: Acq92OGLugRdl715uFBFXKMiAswavHByF6xdS8fcJTRDqcgHxh043fJ+WGf5tNkuc3d
	c0McOd598s1LlfCUqwsRL2Jnt+H/69i9hAmqbZcBapf7SL3ZAEHFAlCN/2c8RlILwYFtkxJGpXH
	V04ccWyTHGBLOy/c6wMI9YZAmspBhIfxA5fJh6MPmjMhc9OgqpyIxvXoDvZQy+eazktFIgUJUYd
	bqrcgpiFI3OvV8cb9KwG9BL7u8SqwE8wiyUSztjaYfm4A9q4Ylvk8Xr9VlzGATPJVRmqLHCqLLE
	waCIpHU/BbxMUs+h9zefm6Nc5pzfx+SMP/TdxTjMLexNsqc+EpfH6HMYtWmemh2PHIjXPXvTN6o
	U28c=
X-Received: by 2002:a05:7022:2390:b0:137:e45d:7c4a with SMTP id
 a92af1059eb24-137f6c13abfmr2812404c88.29.1780559135462; Thu, 04 Jun 2026
 00:45:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603111044.39116-1-r.siddharth.shrimali@gmail.com>
In-Reply-To: <20260603111044.39116-1-r.siddharth.shrimali@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 4 Jun 2026 09:45:23 +0200
X-Gm-Features: AVHnY4KMtiGE-DLDeWrlIQNtOkiJwpkZdhJEvayEGut9IFzICsLtg4EhxApTJhI
Message-ID: <CAP8UFD2=3V6wRRJU0c1KJ-tGdz_F1DtjNd1aV9dWoO8LK5oeSQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] parse-options: introduce die_for_required_opt() helper
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, toon@iotcl.com, jn.avila@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 1:11=E2=80=AFPM Siddharth Shrimali
<r.siddharth.shrimali@gmail.com> wrote:
>
> Many built-in commands in Git manually check for option prerequisites
> (i.e., option X relies on option Y being present) using explicit
> conditional blocks and duplicated error message strings.
>
> This short series comes out of a discussion with Christian about
> localization and code duplication. To address these issues, it
> introduces a centralized API helper that handles simple option
> prerequisites safely.

I think it would be nice to mention around here that the new function
was inspired by die_for_incompatible_opt2() and similar functions.

> - Patch 1 introduces the `die_for_required_opt()` helper function
>   inside parse-options.
>
> - Patch 2 cleans up `builtin/add.c` as a proof-of-concept by migrating
>   its manual prerequisite checks for '--ignore-missing' and
>   '--pathspec-file-nul' over to the new helper.
>
> If this initial approach looks good, we can later extend the helper
> to handle more complex multi-option dependencies.

Yeah, for functions with more arguments to address cases like "option
X requires both options Y and Z" or "option X requires either option Y
or option Z", I think it's not clear yet what would be the most useful
and what's the best name for such functions.
