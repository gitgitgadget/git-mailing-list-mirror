Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D691925A6
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732532157; cv=none; b=k/PJwMUS+oK/4HplelM7Z6Dg+rmiB1MgNoAzzREKJGn4xidbiyEG5tFvN9tIF5qXuSNeCMyeLPf4agLUeWWemB1QT4TeJNSs0EWXFMJPAiRtNV6xEq0kDXecpWxz2EO2ttv4qAKpeggyPJSXbQEyZZNELnnJqL4qmDbIeN6Mo4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732532157; c=relaxed/simple;
	bh=vFHKuh0OCVAnbipc6XIPYGk1D2IeqHyervtJmXxqNYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWfiAOwqMM0mG56QZGIlK2T8u14NrtAO6EKh/j8wQH9uFygOewSTGwq++CvGWXOUW5fEzDtgKlW0LXASosFfUa7GHyyWRB3x/hR+SohlBsX1A3WBI3UAVIf+PNoohswZnUKm0QceYllhBW4J0+WlwsbJE86HpAegNOJVEQh69CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8SVkRgf; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8SVkRgf"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53dd2fdcebcso3542441e87.0
        for <git@vger.kernel.org>; Mon, 25 Nov 2024 02:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732532154; x=1733136954; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kyxsfNt+xcBEi9cA8FkAb9Cl75yclDK3ZGa5xxQsk6o=;
        b=f8SVkRgfiwx/pZ0jJIovcuoIqnJwydAHcDBNa5dm+nb04DqiE8Q1zTMcWYCnA7bjFc
         Rm4ZUTmnAaEy6x6avjYB7FdQFekExjkuiMiNwBtbgIqMwsfca6GwRXeNJcVpOAnin4xW
         NeIgl0WEQBAP0RXgmft0O53w7h3OrKZf6+E/tvOWH8DvEgS/GTpTN2IVqm+L5cePgIWT
         4Ib9UOgDoEn0ZrLZdCmzmqGEY1AHdtUZI2zC3TGI7WfHzQk6IrNgacCxPsYGPD8Ba+0K
         4LdFBwJaG18uJmmYGxSTC+vbcUYeBJRlPZ4RxezODgezQ8YS6UMF13fSOz/oGJa/d5af
         2vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732532154; x=1733136954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kyxsfNt+xcBEi9cA8FkAb9Cl75yclDK3ZGa5xxQsk6o=;
        b=EaM0FCLvxOBUwyumfey86BLsksmgH2rmfjFFJQ9tkcdJ0fSfpYpEOZnYAN4aYyPXJo
         ZPeoZCsI72RgHFE10iiv1x+Q6FALQp31gRO/yKKs+HkZnI+8UfMzNuB4tpZOniNM7BZu
         y5U2KbVfQ9zqW0N7yPhaycwLCOx7StO+qaCyVXVfF5k9+2+Wc7Q4L4OdgSzbDU5S6ggv
         0+CO13o0Z5UNpMhx6VzC8/3eQENaGZW5C5UJuxVm8Ajt0g3kQ83gUbJvttPmw7LGLgnO
         S3/w5yocfyCR8e/1mQz6X31YGBW1TstvWJPBB906E0JqM7Bzby5XXbA63a3geTLFoeg4
         t2RA==
X-Forwarded-Encrypted: i=1; AJvYcCWarve0KRha0gEMeO+eqQrRfiwyXsOj4q/IdY0COMlA1XxqmAK1WMrEIQfV37y6gOcFISU=@vger.kernel.org
X-Gm-Message-State: AOJu0YysVQjNYYXqPHa0ipSSQWoBc52heHFbS8WN6IxXu0Cy8aLmRFLM
	1YTE8fykrI8yZ5+eeUkZh6QQGVB2SUAz2W4zXUcS2vmb09QaA8MCzYsqSw65kEeiHuhClG2zbFN
	UuMwpA4Jl07bVXrHiD/1k/0omKb3DrQ2O
X-Gm-Gg: ASbGncteRa5X1Pek+c5BkT/Rz0AgbBm93Sg9czuD65dDrgKsyYA094c+AAF27xdKnlk
	g7yNIGAlQy12UwPnUsIlGUKdMHUvF2g==
X-Google-Smtp-Source: AGHT+IHdGVEFra0vgzQr5JcrPEqETzrUCVAc1QBzhRLkO4PRioTRrDd51nu/Ct99hzjlMKUPzCI0FGnLRzweyl+TIpQ=
X-Received: by 2002:a05:6512:6cd:b0:53d:dda4:c145 with SMTP id
 2adb3069b0e04-53ddda4c154mr2724232e87.8.1732532153746; Mon, 25 Nov 2024
 02:55:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120101741.8225-1-dev.mbstr@gmail.com> <CAN0heSoryo-DO6WXKqqASJ5nDLqb3PNNiZv1TP=Pq11wsiSM6A@mail.gmail.com>
 <xmqqmshrrxpq.fsf@gitster.g> <D5SWT5JKU6S9.2LH8H7ECRZXXM@gmail.com>
In-Reply-To: <D5SWT5JKU6S9.2LH8H7ECRZXXM@gmail.com>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Mon, 25 Nov 2024 11:55:42 +0100
Message-ID: <CAN0heSqb+dzGAVnN6=_AkKa-qh4GYo7ku90No=uXBg2+wobL1Q@mail.gmail.com>
Subject: Re: [PATCH] git: fix paginate handling for commands with DELAY_PAGER_CONFIG
To: Matthew Bystrin <dev.mbstr@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Lessley Dennington <lessleydennington@gmail.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Elijah Newren <newren@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	idriss fekir <mcsm224@gmail.com>, Joey Salazar <jgsal@protonmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Nov 2024 at 19:13, Matthew Bystrin <dev.mbstr@gmail.com> wrote:
>
> > The whole thing started with
> >
> >     Calling commands using editor in terminal with `--paginate`
> >     option will break things. For example `git --paginate config
> >     --edit`.
> >
> > which many of us may respond with "it hurts? do not do it then", so
> > I agree with you that a fallout would be worse than the problem the
> > change is trying to "fix".
>
> I see the point and totally agree with it.
>
> The root of the 'problem' is related with editor, not with commands. So maybe it
> is a good way to deal with it in editor code? I've quickly come up with
> something like this:
>
> diff --git a/editor.c b/editor.c
> index 6b9ce81d5f..04a1f71694 100644
> --- a/editor.c
> +++ b/editor.c
> @@ -13,6 +13,7 @@
>  #include "strvec.h"
>  #include "run-command.h"
>  #include "sigchain.h"
> +#include "pager.h"
>
>  #ifndef DEFAULT_EDITOR
>  #define DEFAULT_EDITOR "vi"
> @@ -60,6 +61,9 @@ const char *git_sequence_editor(void)
>  static int launch_specified_editor(const char *editor, const char *path,
>                                    struct strbuf *buffer, const char *const *env)
>  {
> +       if (pager_in_use())
> +               wait_for_pager();
> +
>         if (!editor)
>                 return error("Terminal is dumb, but EDITOR unset");
>
> Brief testing shows what it works, but more complex approach may be needed. What
> do you think about that? Should I continue work on that despite the fact it does
> not really hurts? If yes, is it better to create new patch or send as an update
> of the current?

So the high-level idea here is "if we're going to open an editor, let's
first shut down any pager".

This helper is relatively recent, from e8bd8883fe (pager: introduce
wait_for_pager, 2024-07-25) and fc87b2f7c1 (add-patch: render hunks
through the pager, 2024-07-25). The context there seems to be that a
long-running git process wants to open the pager, maybe even more than
once. So we need a way to shut down the pager we just opened -- it's
done its thing.

What gives me a bit of pause here is that we're now approaching this
from a quite different direction: a git process wants to shut down the
pager not because it just opened it and the pager has done its thing,
but because we want to open an editor and think that any pager might
interfere.

If `git add -p` is a long-running process that wants to repeatedly
launch a pager, what could the opposite look like? A long-running
process that wants to repeatedly launch an editor? While paging?

Maybe `git rebase -i` could be one such example. TBH, running its output
through a pager might not look super-pretty today due to it producing
temporary output that it then erases, but at least it works. The editor
might be graphical (or a script?) that won't actually suffer from the
pager running. Killing the pager might be unwanted. So I don't know.

What is the original problem here? Is some kind of tooling issuing a
`git -p tag -a` where it's not possible to teach it to drop the `-p`?

Martin
