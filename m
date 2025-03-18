Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791D41A264A
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 05:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742275879; cv=none; b=DlbZ3iX8wLY3yzKuTG9vPAHYUpjZMMQZp8TOJ3QIF6b/uMWuf2Jbx+zlLkXUvg7s/Jr+HLKiW8LUsMo5Z+z/qCjY2t/9LjDcLEfexGD8Z7l4HOpOZ5vW2rVBza/9lJeuwTZNoNa2BkUKB0gBNDNY+seoanxC/nn/iC/yXgm/kNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742275879; c=relaxed/simple;
	bh=IUyUdSmPWQGL1gBYgvdITwV30QQKdnNpAwMcqniLUsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nw8IqgNnKDTwoVM5NAD9fIWfq7v1WwZyKCTviNw19lpVzIBtrw0OqE/93yimMg0oNHgP2R6kgskqIEugSHlN56m61ooigYJ3Ecy6pqFrbQkgI7IfAvH7dkI3frL1q/1/apNUWkljJZzE2QRfVlts3yzOeI1DoZtpcEixgV+ayu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkzBN1Pu; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkzBN1Pu"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-85b4170f1f5so105297539f.3
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 22:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742275877; x=1742880677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcL9vQbh6s5k3HAIh5HZFPyKWo9dPRJgNZ6bfGvA1zs=;
        b=PkzBN1PuAqQoAHhjLJCVjF4umHerUn1kKphw2hnH6ZnFbZlPqPlUiMGBdb6Zb/6IE1
         yIDkHWMnjZ248ZGAiVvV3zmbRRvXX7DjA83e3FMH64N3BfPIR3wvyg2dfrCv6fktDKd+
         ri/dzE1nxivM6dVDP31geJ0hf5T2OtViLHhDZ786HX8y9XCYNmC7wxErgxPkEJ9pSXYA
         lEobiWbrIXYE4brtThvTIZqr5M74rJZfLe4Bi2bMztekzqvzAUaiDKtEEnv5s5ageOyR
         8EpH+KzeOLAmab+TPAfWUI2BtJwKq7BuJy5Hm0WNdRq0R5Of7z1wsbHk1xxzAmsK0IqE
         56+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742275877; x=1742880677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcL9vQbh6s5k3HAIh5HZFPyKWo9dPRJgNZ6bfGvA1zs=;
        b=Wit01iZ4z/yfqQaEV+Gg+56zW0zTx0qk2ztAMlNCGcMawJ21tsSvuVfIkfs+KT6mVo
         nUk5hUVhWXhPO/NNsJ8JmUZR6VsSA4qDiFc+sW7lkSOXFaJvaoNvapEsy+D0DDYeItrG
         x2cFIZlyxZ+ocEO6Mg+hcG3u3LzNWXu6ZRIF50l8TEgrBnZfo2oZ+3mDxNDv7iq4tzyf
         fUf7Q+EDqQ4MWR5bpa3US4kT6SEQ03tBr/XfjHoo9q6IUsqwbDn8fTdCOZAuxUADnN6o
         viTCCuAdHuDTIILbnqmXEoQf29RK8tcAAU/3cGbGPkz/Jw5Sl7lmwgqkrTPaOlMEa+41
         0HPA==
X-Gm-Message-State: AOJu0Yyg8Q/ZBm4Sj185GCFyKmtqfy25SzKxOxHjUz/vbqdeZVbefN4Y
	BZFrDPHe/uie1jrHSE4N0THGTUPY/CNt9bVcxABoCiAWGfL5htO43u0qlS6TCMGLSX6gI9PMVZd
	yHYqEbffPmo7s1rHaURsN/I7lSRs=
X-Gm-Gg: ASbGnctUHAqrgrxqCoFJ6pxj7F05cY48AQj4H/FqstIULKIrwMT0X7MLf7tdTQrkSWe
	qupsppn4UbEucXu4Cyg3YIV31Z1LTFCol5iqKQta63idACoDmUCklzS4rdNPTy1mz4RvsEr9tD+
	q6E2YwG53YohIJ5Z4PNupU/PsNX95Y/e2G/WhbqgZoQiSEat3aj64ViXbgrEA=
X-Google-Smtp-Source: AGHT+IGJJthaM4m4I4FADqZcgUEI4uq+75rb4lqoyNsockpOUKQ0J8G3biM3xh7CZOcBcs+P0AUz2XHc8PZ7/J7SZi4=
X-Received: by 2002:a05:6602:2983:b0:85d:a173:323c with SMTP id
 ca18e2360f4ac-85e00545d8dmr236734739f.8.1742275877448; Mon, 17 Mar 2025
 22:31:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723755667.git.me@ttaylorr.com> <cover.1741983492.git.me@ttaylorr.com>
 <b45a9ccbc20180e3358e314b4fd5e46bfa566241.1741983492.git.me@ttaylorr.com>
In-Reply-To: <b45a9ccbc20180e3358e314b4fd5e46bfa566241.1741983492.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 17 Mar 2025 22:31:06 -0700
X-Gm-Features: AQ5f1JqTqip0SHiEHrOqDl9tPbqI2Oeyen7K8m0Y_4FklvExqUpGzPs6AM4cb-k
Message-ID: <CABPp-BEyKkbVMs=7AgSf1P9CTXqA5CY5epG-piuSzppAWfPe4g@mail.gmail.com>
Subject: Re: [PATCH v4 07/13] pack-bitmap.c: teach `rev-list --test-bitmap`
 about incremental MIDXs
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 1:18=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> Implement support for the special `--test-bitmap` mode of `git rev-list`
> when using incremental MIDXs.
>
> The bitmap_test_data structure is extended to contain a "base" pointer
> that mirrors the structure of the bitmap chain that it is being used to
> test.
>
> When we find a commit to test, we first chase down the ->base pointer to
> find the appropriate bitmap_test_data for the bitmap layer that the
> given commit is contained within, and then perform the test on that
> bitmap.
>
> In order to implement this, light modifications are made to
> bitmap_for_commit() to reimplement it in terms of a new function,
> find_bitmap_for_commit(), which fills out a pointer which indicates the
> bitmap layer which contains the given commit.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  pack-bitmap.c | 107 ++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 86 insertions(+), 21 deletions(-)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 7a41535425..bb09ce3cf5 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
[...]
> +
> +static void bitmap_test_data_prepare(struct bitmap_test_data *tdata,
> +                                    struct bitmap_index *bitmap_git)
> +{
> +       memset(tdata, 0, sizeof(struct bitmap_test_data));

So, the first thing this function does is 0 out tdata.

> +
> +       tdata->bitmap_git =3D bitmap_git;
> +       tdata->base =3D bitmap_new();
> +       tdata->commits =3D ewah_to_bitmap(bitmap_git->commits);
> +       tdata->trees =3D ewah_to_bitmap(bitmap_git->trees);
> +       tdata->blobs =3D ewah_to_bitmap(bitmap_git->blobs);
> +       tdata->tags =3D ewah_to_bitmap(bitmap_git->tags);
> +
> +       if (bitmap_git->base) {
> +               CALLOC_ARRAY(tdata->base_tdata, 1);

We use CALLOC to both allocate the array and set it all to 0...

> +               bitmap_test_data_prepare(tdata->base_tdata, bitmap_git->b=
ase);

and then call bitmap_test_data_prepare() which will re-zero it all out.

Should we either ditch the zeroing at the beginning of the function,
or use xmalloc instead of CALLOC_ARRAY, to avoid duplicate zeroing?

> +       }
> +}

Didn't spot anything else.
