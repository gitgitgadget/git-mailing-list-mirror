Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87DC41C63
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 06:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767506545; cv=none; b=uFjpBHX3hDT1la+EpBXNENA/+Rqafrr3LGA7YDCxvfRmAeB+ZOa5vxe2VaQqP9YLAleEUHb1aTMB5dhmoosu0qGhg7f+5UsFImxOQInwf1kFlPgZAwuNbQ9EIXiJwAeDwN3R/SV/NkGG7EP8e+2pUlJlzsr5b+XRnr9NL2o0WDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767506545; c=relaxed/simple;
	bh=XmugvFNcVoKfW5uw381hxAvdXIddo1OS9wLu5CxzhhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRqT5ovzKEW1ZBa6eKd+qpcKxWP3zpCTw6Y6f1rFGE+GpZhKnm1Grtfmg8pxAvq3fPyaBEiVuGE8GBQYTj8TTqQepj739jjTlzpOWCz2TI/mq/XleI4DHf4bdDTlTcFLwTF5iqSDKXeX8+2ZR7/nvIsUV3Vz/l6L3LsgY1lD01M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VapN0SdS; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VapN0SdS"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43246af170aso472357f8f.0
        for <git@vger.kernel.org>; Sat, 03 Jan 2026 22:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767506542; x=1768111342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QoDJNu4Qw0VUmDOPojp8i53zAnbpiLTu2QyWeHFTTo=;
        b=VapN0SdSIS5bCY7BrOV8VbB1AVeFmbsdklCAxhzs0txg7fFdXkKoOBScP7xkBDWCD0
         w32n6+qPFALqvJYBSPDdjwJS+N8H+Yd+AJHiH9MsdjUFnBu/o2nz5xWsVv/rWhaAHD1w
         mRQ9Dqns9pKI5zcMugiHasP9f7lQC7LUngNlwBXovcnIYi/WckMM/iPZj26HNm4/pxEi
         057fglfUJR451ZltlmdVJqRfYQLbNJbvM52cl1Z5hVrVStDZCEH5dBI275Ss/zt+g21j
         uU89jba4q4le5IGj4WmgpbLqjekUxFVqpi2BHD1OlYKQXOZnjd61CBahzdVJUTHOyiAH
         Wpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767506542; x=1768111342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5QoDJNu4Qw0VUmDOPojp8i53zAnbpiLTu2QyWeHFTTo=;
        b=JqPsDQrPE1z3mb91xeLx7MmEpOJE0QiJOreyZ8jJrzQu2oaUkVChIIBoDO7jZlrTql
         5TOImoMjHogGYbQjl21ZOQBPDG2XEVFLME2KEvCd5ElGb6HenVmpExerlkGAic84c4yX
         rp807iA7a6UisaVp+ThzQOx7DvbmpixeRKBf172VKz6uMH7E7RDMsZ53alQCaRMdI8q0
         5yULOmT2MZsoedqtc5tpnHD1RX0lbznS6OtsGlt/k/0ICCTmH63hTbaDL1FFylWFvrgi
         8ZUErBNke9RNq7Kkkb6q5IqRRU6aoISiTw1hJ9Y1TKAO47/veG0t/pR6iO9LNUlv6kuB
         FoQQ==
X-Gm-Message-State: AOJu0YxRU5q1cgkD3CvEmKpEwPTH5ZnPN0wqyar50Vy+rweViK47H+x1
	OWfGbfh8QrfDqw3W76sjuGlb+uv37BwCQqGq++d96AQLcpyCPdAl+mnDsM8EoiMYOGDoFUwUqCg
	rwQZq/A1uFz7SAsQwOQpJOFXfCap5CULwsx77
X-Gm-Gg: AY/fxX4iDmfsew1g/smZ/z+RHkVEZzK6xJMi45uxKkqeHaCMMygWqna0NWrigGfDlz3
	OwhvaKmcGC/p4/2sBiNZ5ojEQnTPp0nYAiFXxje+mE4YltRgWTzGnf1xlkC03sVzbb9CPZWGmOE
	Dfz1z9F8JjGD//7w0+dVICeppN3Ovs0rfZ9aubIF53LAT/l0fGinFoQou4UyIXR31VSZIgGtPdO
	dbGx481eflCVpFNZpLUnTU9MfhypuwhuROEuBfyn+zhrg7CgwrfqWhsC4YfYNgo3Mrfexo=
X-Google-Smtp-Source: AGHT+IEuFEHev/jLpjaX8iPdP5garwZ6Sj2K/K5HGRqXoxPwMMNc3heWjjeRP3OGWOCZUEpgbfKnlmEru7/X4Xynr5E=
X-Received: by 2002:a05:6000:4203:b0:431:de5:93c7 with SMTP id
 ffacd0b85a97d-432aa3e9bc1mr5282434f8f.2.1767506541977; Sat, 03 Jan 2026
 22:02:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
From: Yee Cheng Chin <ychin.git@gmail.com>
Date: Sat, 3 Jan 2026 22:01:45 -0800
X-Gm-Features: AQt7F2re4zDSW8iGO3ef1lMCM2NXnWEK46S6XvlagdD5SUnRTC-wVOyvnK9oBkE
Message-ID: <CAHTeOx_saiv_ftwS9fo8jLJS6VZyWufNzX4Rzbgaa8NmRJS8EQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] Xdiff cleanup part 3
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ezekiel, I wonder if you saw my proposed patch "xdiff: fix outdated
xpatience comments referring to "ha" member var"?
(https://lore.kernel.org/pull.2139.git.git.1766464905719.gitgitgadget@gmail=
.com)
from 2 weeks ago? It simply cleans up a stale comment after a previous
xdiff cleanup when the "ha" member variable was split. I don't think
it conflicts with this part 3 (it's a small comments clean up) but I
wonder if you could take a look? Just to avoid future conflicts.

On Fri, Jan 2, 2026 at 10:52=E2=80=AFAM Ezekiel Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Patch series summary:
>
>  * patch 1: Introduce the ivec type
>  * patch 2: Create the function xdl_do_classic_diff()
>  * patches 3-4: generic cleanup
>  * patches 5-8: convert from dstart/dend (in xdfile_t) to
>    delta_start/delta_end (in xdfenv_t)
>  * patches 9-10: move xdl_cleanup_records(), and related, from xprepare.c=
 to
>    xdiffi.c
>
> Things that will be addressed in future patch series:
>
>  * Make xdl_cleanup_records() easier to read
>  * convert recs/nrec into an ivec
>  * convert changed to an ivec
>  * remove reference_index/nreff from xdfile_t and turn it into an ivec
>  * splitting minimal_perfect_hash out as its own ivec
>  * improve the performance of the classifier and parsing/hashing lines
>
> =3D=3D=3D before this patch series typedef struct s_xdfile { xrecord_t *r=
ecs;
> size_t nrec; ptrdiff_t dstart, dend; bool *changed; size_t *reference_ind=
ex;
> size_t nreff; } xdfile_t;
>
> typedef struct s_xdfenv { xdfile_t xdf1, xdf2; } xdfenv_t;
>
> =3D=3D=3D after this patch series typedef struct s_xdfile { xrecord_t *re=
cs;
> size_t nrec; bool *changed; size_t *reference_index; size_t nreff; }
> xdfile_t;
>
> typedef struct s_xdfenv { xdfile_t xdf1, xdf2; size_t delta_start,
> delta_end; size_t mph_size; } xdfenv_t;
>
> Ezekiel Newren (10):
>   ivec: introduce the C side of ivec
>   xdiff: make classic diff explicit by creating xdl_do_classic_diff()
>   xdiff: don't waste time guessing the number of lines
>   xdiff: let patience and histogram benefit from xdl_trim_ends()
>   xdiff: use xdfenv_t in xdl_trim_ends() and xdl_cleanup_records()
>   xdiff: cleanup xdl_trim_ends()
>   xdiff: replace xdfile_t.dstart with xdfenv_t.delta_start
>   xdiff: replace xdfile_t.dend with xdfenv_t.delta_end
>   xdiff: remove dependence on xdlclassifier from xdl_cleanup_records()
>   xdiff: move xdl_cleanup_records() from xprepare.c to xdiffi.c
>
>  Makefile           |   1 +
>  compat/ivec.c      | 113 ++++++++++++++++++
>  compat/ivec.h      |  52 +++++++++
>  meson.build        |   1 +
>  xdiff/xdiffi.c     | 221 +++++++++++++++++++++++++++++++++---
>  xdiff/xdiffi.h     |   1 +
>  xdiff/xhistogram.c |   7 +-
>  xdiff/xpatience.c  |   7 +-
>  xdiff/xprepare.c   | 277 ++++++++-------------------------------------
>  xdiff/xtypes.h     |   3 +-
>  xdiff/xutils.c     |  20 ----
>  xdiff/xutils.h     |   1 -
>  12 files changed, 432 insertions(+), 272 deletions(-)
>  create mode 100644 compat/ivec.c
>  create mode 100644 compat/ivec.h
>
>
> base-commit: 66ce5f8e8872f0183bb137911c52b07f1f242d13
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-215=
6%2Fezekielnewren%2Fxdiff-cleanup-3-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2156/e=
zekielnewren/xdiff-cleanup-3-v1
> Pull-Request: https://github.com/git/git/pull/2156
> --
> gitgitgadget
>
