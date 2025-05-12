Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3737925178A
	for <git@vger.kernel.org>; Mon, 12 May 2025 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071435; cv=none; b=iMiYJs9h/s7LWq1T/q30+SFFBf0FN4AWqri3wd6zg0hGyo4wdvmn8VLRvf4etapNSWrV9Q0FeN1ZOR19jZTVIIZ3X6y4UF15Z0hslJw2nmp/pT8TVK3OvzStRI194ZC0xulcnXI/+3QsGsstP7jxTitVNXzb/hs5VRNdG2y8gwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071435; c=relaxed/simple;
	bh=4TjsDajlFHdXbTrh4khpoy6Vpxg7mp7VAwJZcgczYNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCXsDAlOkY+8Mgz8E0wab5oLy8NwWzdRl+tJeKP/ljQXdiomZHeH4y4JHunsMX+NHvRCkmVHWBbffV2ad+iM/gEPLN7laUJYL4KvGw7tymAayOOveS9qu++qkyUKKAXFY1jDJ1d9ilvIuXonWDF/Ex/WEXWXqfAz/u9toK0Fhz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSQQydl5; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSQQydl5"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3da7d0d7d58so33297295ab.0
        for <git@vger.kernel.org>; Mon, 12 May 2025 10:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747071433; x=1747676233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lDGquQIuhh8CKqCGlwkNG3AEQOXI4i55F9vnuTFmIA=;
        b=TSQQydl5Q2v9+3dcmBd8RCxaiFBf9Y9tqj4Q7nkkQ0kRr1S15tMDQrVDZ3ibMXWYcL
         Y8KbEIrIyiF4fdAapr8Sw7+ksttxiUQ+JrgoJcUuim2R5p9yZ37C2dT05Yt6qv8a6tSE
         4rYYSnvQaXxvoBhqtmL76S6i/Un4mBLye9Kkp3xuaZxcwT0vbhxm2zEeQ6uwgUKdd/7w
         j+eZMFkTBkE1KJM4jLOkqjnjdSR97FiJIOmuL53g2jdSeb19DfLYhIjEPchb2d+qDmCa
         OxgFsVZSPQf+69pmz9lF5UnYPJybRz7aD4/5Y3NZXoBrDK9eDczne0il01FQttNGPqe/
         0KLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747071433; x=1747676233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lDGquQIuhh8CKqCGlwkNG3AEQOXI4i55F9vnuTFmIA=;
        b=M667NVNq0fgpY07joKpuD/bJwLOfT2O/3MMpAm8BbYGAN6JIVo8eHhZXVvMfNxWqt6
         EFWV+ccMkVkGohfE1IZE+ijH9Kz4KS7zI/I0IPQQDz/iwb6JinBMHZXzvyDWewshV++7
         sT0O48w3dalBvQOUAZ0z6Gle7rhzGqDJOdZAx6/oWjvdW5GQcrGUrCa0FgZ3YtdMtMyA
         VNJ+Y/1xcXzZszbAV/fHS3hKoYb36z5RHAERdyYU1dU87WDxR8dsVpzogbwRUGaifWfx
         HTx36XTXx43yOK6v8fDOj8G5JUgMKYg4n0r/u89iw9Q+2ofkF1pLTtl302US8djZT9X1
         U4dg==
X-Gm-Message-State: AOJu0YwzwZ3P5S1eyB+yLP4ibXK3mhmjY/QHWxX+99nbQ1evKwl8uulB
	FcN2gYLAKpIyLSKviT8V8OLjZtsWsXNxQg8sDajgsSeDcttiCeWoB8sSXPebKfp9NS1Lsz8nYMZ
	tvj1hdjRMleC087rKKiwHjgYeN9yHwq7D
X-Gm-Gg: ASbGncvlwRXz0aM/L7c2S7N29CkYpeswCLpwELHbif3cPWuYOWfrFMyXnqJ0tPJe5bW
	fPxBP5cQIF+NKtns/26en2AqrPvRp/Bz3aVsfmAbwnwjAr5f9JPwkc9WSXZEK9oBa2YUsjioVxD
	2yDqXBMueAASlV9MsEJ9nyX9sHecKUeWuUgjI0GdR47tKuO6E6B83ozJJgtYCZB7WkDA==
X-Google-Smtp-Source: AGHT+IG6pYBiSpjA9sh8Oy3XRwz1AsHCvTKWnR8S72TSVAAVEZ537v7Y7Ac+MewL9haheu4ncckBoEaLk1irrFkANPo=
X-Received: by 2002:a05:6e02:1845:b0:3d8:2023:d057 with SMTP id
 e9e14a558f8ab-3da7e1f4172mr131702955ab.11.1747071422380; Mon, 12 May 2025
 10:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501225958.2947677-1-gitster@pobox.com> <20250503005814.3030099-1-gitster@pobox.com>
 <20250503005814.3030099-7-gitster@pobox.com>
In-Reply-To: <20250503005814.3030099-7-gitster@pobox.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 12 May 2025 10:36:50 -0700
X-Gm-Features: AX0GCFsupzztXvTLdLfA8belQIgfefJ5rpdDhEn-RArS61pLEyU8-2lHThLK4Pc
Message-ID: <CABPp-BE3Qh55=6GR7s-Wv2rS9+oAFokw=9R_1WiayLWDMsuAVA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] whatschanged: list it in BreakingChanges document
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 5:59=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> This can be squashed into the previous step.  That is how our "git
> pack-redundant" conversion did.
>
> Theoretically, however, those who want to gauge the need to keep the
> command by exposing their users to patches before this one may want
> to wait until their experiment finishes before they formally say
> "this will go away".
>
> This change is made into a separate patch from the previous step
> precisely to help those folks.

Were these three paragraphs intended to come after the "---" line, but
accidentally placed in the commit message?

>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/BreakingChanges.adoc | 9 +++++++++
>  Documentation/git-whatchanged.adoc | 6 ++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingC=
hanges.adoc
> index bdfad29d8a..f9026d004c 100644
> --- a/Documentation/BreakingChanges.adoc
> +++ b/Documentation/BreakingChanges.adoc
> @@ -178,6 +178,15 @@ references.
>  +
>  These features will be removed.
>
> +* The git-whatchanged(1) command has outlived its usefulness more than
> +  10 years ago, and takes more keystrokes to type than its rough
> +  equivalent `git log --raw`.  We have nominated the command for
> +  removal, have changed the command to refuse to work unless the
> +  `--i-still-use-this` option is given, and asked the users to report
> +  when they do so.  So far there hasn't been a single complaint.
> ++
> +The command will be removed

Missing period at the end of this sentence?


> +
>  =3D=3D Superseded features that will not be deprecated
>
>  Some features have gained newer replacements that aim to improve the des=
ign in
> diff --git a/Documentation/git-whatchanged.adoc b/Documentation/git-whatc=
hanged.adoc
> index d400b68d4b..d21484026f 100644
> --- a/Documentation/git-whatchanged.adoc
> +++ b/Documentation/git-whatchanged.adoc
> @@ -11,6 +11,12 @@ SYNOPSIS
>  [synopsis]
>  git whatchanged <option>...
>
> +WARNING
> +-------
> +`git whatchanged` has been deprecated and is scheduled for removal in
> +a future version of Git, as it is merely `git log` with different
> +default; `whatchanged` is not even shorter to type than `log --raw`.
> +
>  DESCRIPTION
>  -----------
>
> --
> 2.49.0-601-ga5925c3955
