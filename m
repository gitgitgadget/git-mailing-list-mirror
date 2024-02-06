Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77BD137E
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 01:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707183728; cv=none; b=r9COiYjzqSZdh9L3LKpHLcRtPNx7jT42JUOqHr9RyOzGpg+popLzWm8Y2us6PliQp6k997XDPyHLxCLayEztSlkwquZis0OQy5qTbQ5hmroHFg42ZfCG0hfzkFQBlVJ51Hu+UZHbBiTLm58xWhWNl9P6X64JGuCy/1ANHIszKcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707183728; c=relaxed/simple;
	bh=xSe7EgMUNX3LCvJzPDrs95dN6A7cgqUBYG5RrM0BWi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPWFEA01RqILxbEmHbmoOriLdPXdmnor32qb3s0NyczFMkMjd55TH6EDsIXhEoLS+DsrtiT7LqRmHqobPTkyaxOZHCWzsiP16npS+v+DqMjMpCcMMdFaFEurLBVAxyahwbHzXsdgj/K6k4Nf5FO1GDdEBWb0/jcesBWb3okLUJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kBTp9q+I; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kBTp9q+I"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a354fc17f24so580703366b.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 17:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707183725; x=1707788525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IH6OZMKn3TaQoa+NHJyCYf1b7lAvH3/pzb+x/+rQL+g=;
        b=kBTp9q+IdZic1T48nFcUc2Q5TA+KBVgBPVkBfbhPil7TEeJsmXK37WQ0rdjPTTnANd
         fofK7fRo3cylWaFbwLe4CC7nsiWvGKq6upHhnPyGiiYn+CvAbbEOGcUMV4aivBecCJKL
         IEecm2Jb3G12E4mEP+Gu23d+E0X4qXdmENZkjC8iXv8UV44m4I0uFoYxkKuwhHycjVT5
         8zopkqb/sHhm2Cf1A/eJU2oE8giMkQ4pvsVJeOvlfHFjONLoUMezFDUpSh/P5wG+6acJ
         B7kcr78FrBJhiAIo5L6kRRygCjxL/05MUfgdqvBvTvI9fc1emrGr4lWn2N2Mc93NyCO8
         Qy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707183725; x=1707788525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IH6OZMKn3TaQoa+NHJyCYf1b7lAvH3/pzb+x/+rQL+g=;
        b=H/Vz79P/+FvAea2qBnfTWTuL8jq0CPSeioR0AyuMOn3eRfbcrMlRgZn7H24A1lQQR7
         pUSOo8X1xvCzWU70zLU62gOVxd0LUN89arNrQ8vpFb3yqsbhG4ey8+fmlCCF06e12qMH
         pjSCf1Z+RKjgmO9HA3pT6wJdvA9QSJ6377b3RcwGdMSgtDCv7AXQ15ndO2pPHLntKykp
         huD6kIFleMp44xPwvcPb/95g8jQAoIzwxPq4wqVvFeCxWZs8QaR/Xg8sn6zr1pqvpaFQ
         9mDR9FEZ/rgBIoFQvDhZ3OTsRlz44F2UkzV68boI6hx248qN/fK/AADY6zhhO0Cs4thx
         kSRw==
X-Gm-Message-State: AOJu0YwQe4PSbsckRXlctw3Zev4sIPnQhAgrDsA79Px6rt1IZ/6VUx0/
	M+KPo1fPncyFWduBfQQZ9yPWXW6yC1+2cEEIiX+7HvEYf9kDL54PJh4lGfB9f+NaZARR/Z0dzga
	J4m9n8Ka3Uz5z0UqzzATvfr77O+5ZhrTfngz7
X-Google-Smtp-Source: AGHT+IGrMW2w5sjfY0BxHWR5WwjOvbXkB6+BvVI2HgvT8wP3J7CCRbTW5sPQXMOqElFHLCVSU/nPa1GMQWNeTpVsVoA=
X-Received: by 2002:a17:906:ae4f:b0:a36:f993:a853 with SMTP id
 lf15-20020a170906ae4f00b00a36f993a853mr740059ejb.74.1707183724782; Mon, 05
 Feb 2024 17:42:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1652.git.1707153705840.gitgitgadget@gmail.com>
In-Reply-To: <pull.1652.git.1707153705840.gitgitgadget@gmail.com>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 5 Feb 2024 17:41:49 -0800
Message-ID: <CAO_smVg8EepRvpDwpEiq8pVJvX08GSTX=WUpzsOVQwm46JbTcA@mail.gmail.com>
Subject: Re: [PATCH] commit.c: ensure strchrnul() doesn't scan beyond range
To: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Chandra Pratap <chandrapratap376@gmail.com>, 
	Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 9:23=E2=80=AFAM Chandra Pratap via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Chandra Pratap <chandrapratap3519@gmail.com>
>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>     commit.c: ensure strchrnul() doesn't scan beyond range
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1652%2F=
Chand-ra%2Fstrchrnul-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1652/Chand=
-ra/strchrnul-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1652
>
>  commit.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index ef679a0b939..a65b8e92e94 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1743,15 +1743,9 @@ const char *find_header_mem(const char *msg, size_=
t len,
>         int key_len =3D strlen(key);
>         const char *line =3D msg;
>
> -       /*
> -        * NEEDSWORK: It's possible for strchrnul() to scan beyond the ra=
nge
> -        * given by len. However, current callers are safe because they c=
ompute
> -        * len by scanning a NUL-terminated block of memory starting at m=
sg.
> -        * Nonetheless, it would be better to ensure the function does no=
t look
> -        * at msg beyond the len provided by the caller.
> -        */
>         while (line && line < msg + len) {
>                 const char *eol =3D strchrnul(line, '\n');
> +               assert(eol - line <=3D len);

I don't think this is sufficient to address the NEEDSWORK. `assert` is
only active in debug builds, and strchrnul would have already
potentially exceeded the bounds of its memory by the time this check
is happening. We'd need a safe version of strchrnul that took the
maximum length and never exceeded it.

>
>                 if (line =3D=3D eol)
>                         return NULL;
>
> base-commit: a54a84b333adbecf7bc4483c0e36ed5878cac17b
> --
> gitgitgadget
>
