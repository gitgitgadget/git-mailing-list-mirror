Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000813D542
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 05:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705987437; cv=none; b=B8KUej8uiHge1RmMbXGC3wWaP7cwEIpvKhy+O4ql3b+IrVUo3KJ+sSzzL5v82Y6hQzZmhn9mPefFSmSF70/fLKnwAw7nLgc00hdIFW5XnAWNW6rz3/Euz5ww4qSTUF3r5PXvK9ZecSLsz6L5K4lFsAiij1zhNQ0rtB/6f3ThSW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705987437; c=relaxed/simple;
	bh=Y28Jd84IM7FqIk9stxd2yKSjm71L37vR1r65dtT00lM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MDfXVxncct3QG36T326QBGO2KFavVu2BVj2QUWB3ZYXDymHYNggXMdFlQOqp4Qt+yperpUlRUZYnR4YFwONbamvymqMQlbKRFb8vHTlp3bebpNjILYxr8G0HRIDxMY4P9wzq9Y0A0xPtuEgqSkr4a/0scZi2/rnXxT6R8KjBV6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boajjYA1; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boajjYA1"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50eaaf2c7deso4284124e87.2
        for <git@vger.kernel.org>; Mon, 22 Jan 2024 21:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705987434; x=1706592234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y28Jd84IM7FqIk9stxd2yKSjm71L37vR1r65dtT00lM=;
        b=boajjYA1RpV7CyX+aDrKnMtS7L6lX2kKsgptmxVwe1/BBoT9XjUCf3rcSFkXSgNwyh
         R1ny+hVIwycoBjGjyV2PSXazVXZjjlg63Oay3YxNWV9+EJgn3u2uXEjD9ixFYTn4Mk3C
         AMXHVQmiMGObpZPsLmJv2SNPwKIQMcPQB75UoT33X0waubKHs+1xJrb8Vlq9V8irirKF
         MDSrdfn+DPbUxyLlQX3Y5UiZmly13rb81FiFoAa1VMwJEUNXZ+6S6Dy8QKuG9Qr3EiYA
         JjqwRnW3Nfkpi+C6LInxM1wrR7/7Frv2TGuSZ0CEb+YrtHloQQScPkjpfgcoduIa/N2c
         8ebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705987434; x=1706592234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y28Jd84IM7FqIk9stxd2yKSjm71L37vR1r65dtT00lM=;
        b=KebZhOV949HLjmi1isJWXQMwY6AHhedTlDQSIF1RaIDplonPmc8YDQGGgv9xodbqgD
         +8oo2koA/UUSMe58i2OoRq0gXtL+th4c0fqOo0PYePUvKYlZTd/7EOit8sNtXMDrC55D
         LktgyjRnJYLXzSSPjdqKkYP6kK4B8Ph3G/WqdkG323cQCShy/7zWyUQdRUdE/Hj7wUkN
         JZkaTfKZPevjUpEdu0QIwJlhCMv8vJq1tgwDvQtWxlygp7GVy0kqVEGYKOChbPDE6K6a
         KuyPMElQ8eNjijKiaiZ8bVA//sQsK154Z+kQ24hfx1f92QEuDxu1y5dLFZWq7iXTrTDk
         Rn1g==
X-Gm-Message-State: AOJu0YyzVP98Ya9H6vOo+8093cVXqd1X5cZhZHlp3rm3ykh9Gx5K6Cyw
	HIj3Bq0bUj2B4ezeLhJSbkTJceK/YveNHH+G4aKBiTom75Y812qYgyb/ZW73Jfo4n7hdDna3+Pa
	uOUdxHXIaSpV58nJWznjubx+FSpU=
X-Google-Smtp-Source: AGHT+IE3GrdXXHIWTe3SMthE4ddnj0fEawYSOWj3QcrOVspFhrm9P9fubAuSwBp4x1nEaH5dsQKT72pvkSzKOxJEJ60=
X-Received: by 2002:a05:6512:230b:b0:50e:d4b4:c0b with SMTP id
 o11-20020a056512230b00b0050ed4b40c0bmr2593389lfu.29.1705987433699; Mon, 22
 Jan 2024 21:23:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240119060721.3734775-5-brianmlyles@gmail.com> <06eb93d7-7113-4583-9860-28a6a6d528a2@app.fastmail.com>
 <CAHPHrSddqTEjtfhgVJ=vmRhbtuwXcGEiE1KFZqR1QhKw-HDtSg@mail.gmail.com> <10838549-c364-429b-a086-68a41b7369de@app.fastmail.com>
In-Reply-To: <10838549-c364-429b-a086-68a41b7369de@app.fastmail.com>
From: Brian Lyles <brianmlyles@gmail.com>
Date: Mon, 22 Jan 2024 23:23:17 -0600
Message-ID: <CAHPHrSd8rLj_TDE11dYQW+51--8YC4rumnfT+v2bYr+K7AMQrQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] cherry-pick: Add `--empty` for more robust redundant
 commit handling
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 4:05=E2=80=AFPM Kristoffer Haugsbakk
<code@khaugsbakk.name> wrote:

> I don=E2=80=99t know of any global config. So a pre-commit hook is probab=
ly the
> safest bet. Personally I set all my editors to remove trailing space and
> they very seldom mess it up. :)

Fair point -- Apparently this was a gap in my nvim config.
Easily added.

On Mon, Jan 22, 2024 at 2:55=E2=80=AFPM Kristoffer Haugsbakk
<code@khaugsbakk.name> wrote:

> Oh, and this thread reminded me https://lore.kernel.org/git/xmqqle8hrtcs.=
fsf@gitster.g/T/#t
>
> that editorconfig[1] has this option:
>
> ```
> trim_trailing_whitespace =3D true
> ```
>
> So I guess that should be enough for all editors that respect this
> config (although I haven=E2=80=99t tested it).
>
> =F0=9F=94=97 1: https://editorconfig.org/

Is there a good reason that this should not just be added to the
`.editorconfig` in this repository? Would a patch for this be welcome?

I do see that there are ~130 files with trailing whitespace in maint
today, though I suspect that most of those are not intentional.

Brian Lyles
