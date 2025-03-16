Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC081D531
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 06:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742108018; cv=none; b=ervTtBEpAggz5/wTl+rhXrOdoJsFN/ykQkGpLYGoS0YsHLsCr43T2RcOYE90C6MVgB4g3Tik0Ntk/qj7zpv9MNB+9cTv8TuQWwGcNtSEJFk1dnsfQ1tjsoUNRgqDG6ICHgkaD4RXpGpXXSMpPPOH4JZhxMEPJvRz2orcz4qdxSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742108018; c=relaxed/simple;
	bh=PZw0SKWtq7beyS8sOWcEBkHVsrAYfvpUhT0DQdY21tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXxlPpiOL0wX8/WVvruQMJ7b1ievvlWfF3eoSv1/2RyDQjihCubNwUJuRRwt+TAhXopKi92WZ0/Nq7tI4pNS6QbH3nSPwXR+4+kO8EStTfXewz5w7NxM+iIu9mjYOll3Ho6vkay9UB9fq+/jpfCVcaDI5fNKLwG8iGAxf0zTjic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlkjQ42+; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlkjQ42+"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d46aaf36a2so28625985ab.3
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 23:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742108016; x=1742712816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tf98MlhEajKeYcODGVfeQqz5TNbqsC402D+nQdZSUcI=;
        b=WlkjQ42+TIlhs5PfgOWIQg1R4+f8wG43fyk+yuUxWm/z6Yzw7HE+FMFa1nt5LVzW6D
         MOJQKCetYXcxo+h1fxvOZTvOuNnhT61QXy49IxAAV1ffpzXDDvOKpGK+bkcqTB0RmVAf
         dSuUQBtOJT82JhTv4zvG0wDNieyi1FI1JFblMfdwKakwAQTJozNgpi69PYR4xVQQHZLX
         9ev2cgHwCFprAdYJe2LN9ToxM//qEIKjk0QKd/YrK12cQgVuSDzFcCjfD4D0kC7cgjgh
         WlIlzcHc56RMKUPsbVVYB0LwTVXB2mBT/vkl273KfBjbKvYddb3nDXMbaN6UW34KIccq
         zs6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742108016; x=1742712816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tf98MlhEajKeYcODGVfeQqz5TNbqsC402D+nQdZSUcI=;
        b=sb8HZuX5HMVyJ5f3SfEhwinE0O7Dnp2V5PVzgSuzEuet1uCLsKhPp9yMk4H7I03vrR
         IDNVDJkqQmcopKXktvoHWSSV2sIdDt6KfNavo41+2/c9hLWMFgHmZHrqYw4G2El55H1T
         c6gWgFX2UVb5U/hmS0mfu/j/QFBPOWkt3FO9GM910cqqAv8UDR8jrwCQKlxS61evN6e6
         tlECkYmLlYmZseBCPW1RJ9TU5EubCtuLSE5RU/mD5nOJUsBrtq6iwFH6WCISdERelpae
         hbeIKxi3tW3PhKUPAbWh7zEYp4hn/HYlJESz9RHXEJEQ7rmpoAy4SDMWnrlw79a9IUeK
         +H1w==
X-Gm-Message-State: AOJu0YwXOvPmNrUfn2on2a8F1uG5ida1WcAZovdO3u2+0bOqg8MQYrDH
	ohoUfpNCiJQkasxR9NFOJNUXyAvAcMx9oHRglDuFqLBtGRJZEuJVtVxKyqif4f82TEbEFhv4L1S
	mD+kMCpSCzMZvtE2dIRdJDc4nJo1/Og==
X-Gm-Gg: ASbGnctn2Gvj2EgDYXr5AakeMJH2EfcZE84kHz5AKKreSNXjB5KbFKXi4uJl2tyRIYB
	aulo6hYj15ogfAkWOoy++VH4mjRncgPK5Zu3tEHZZXM2OsX++NGphq1kZ/T8TO7PayqCjPonxip
	R2eOvpl4hb/KE3BjAzJ1ByAAfmUTXgmgU9/fpCeWQXkuzRvirlmF4DD/iUvTEDIXCTKQCz
X-Google-Smtp-Source: AGHT+IE9RQaMFC1MDkjMQKKEU1a5rTJ7t8s89pNb1bO5uOOCmDDGua0kMjOkjo6YPkqSOFpB5++Wi7+Md6CkJcSIoSc=
X-Received: by 2002:a05:6e02:1f11:b0:3d1:a75e:65f6 with SMTP id
 e9e14a558f8ab-3d483a6eb23mr127596355ab.18.1742108015849; Sat, 15 Mar 2025
 23:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1883.git.1742089659610.gitgitgadget@gmail.com>
In-Reply-To: <pull.1883.git.1742089659610.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 15 Mar 2025 23:53:24 -0700
X-Gm-Features: AQ5f1JpiGCzyYADK8y3Vywt0uCKyTPd8mo_AiEMkm3TqFjgdgecV2gl2quJNmZ0
Message-ID: <CABPp-BGbyKPmx=jNFE9TpvhSO0DcvqA8AETAYRt35_dG20rABQ@mail.gmail.com>
Subject: Re: [PATCH] doc: add missing commit C to the graph for
 --ancestry-path=H D..M
To: Han Jiang via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Han Jiang <jhcarl0814@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 6:47=E2=80=AFPM Han Jiang via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Han Jiang <jhcarl0814@gmail.com>
>
> The graph for `--ancestry-path=3DH D..M` should contain commit C.

Yep, C is in the range D..M and C is also an ancestor of H.

> Signed-off-by: Han Jiang <jhcarl0814@gmail.com>
> ---
>     doc: add missing commit C to the graph for --ancestry-path=3DH D..M
>
>     cc:Elijah Newren newren@gmail.com,D. Ben Knoble ben.knoble@gmail.com

In the future, you'll probably want to use separate cc lines for each
person you are cc'ing; I think gitgitgadget expects that to work.  You
also might want to add a space after the "cc:", though I don't know if
that's required.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1883%2F=
jhcarl0814%2Fpatch_ancestry_path_doc_graph_20250315-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1883/jhcar=
l0814/patch_ancestry_path_doc_graph_20250315-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1883
>
>  Documentation/rev-list-options.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list=
-options.adoc
> index 785c0786e0c..5e5cedb9127 100644
> --- a/Documentation/rev-list-options.adoc
> +++ b/Documentation/rev-list-options.adoc
> @@ -640,7 +640,7 @@ commits affected by that topic, we may only want to v=
iew the subset of
>  -----------------------------------------------------------------------
>                 E
>                  \
> -                 G---H---I---J
> +             C---G---H---I---J
>                                \
>                                 L--M
>  -----------------------------------------------------------------------
>
> base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
> --
> gitgitgadget

Patch looks good.
