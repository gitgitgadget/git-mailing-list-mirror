Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21A22EA176
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 07:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763622224; cv=none; b=gHPHaSsXFdkM968p2a/CcHvc0FmemXjO7qmLCLUY6sHsItSr/q5/oSb5Axv84lwVuH2MB3enfBi3PJQXiu9HZTNCmeKX30BqBWhxnEtIx0RHs0f1pKZyf9LGphYbK877GCkeyeU7rOF36zEVgGtcfsG+MsjTkEK0eoTHMyxXfww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763622224; c=relaxed/simple;
	bh=0SvpnyswX8Mh+t9lcmvEnCnfJbkjjQ9XFjNBTmJMiHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cM3JNTsTrJSLttTxyXzJdkSQWI7f1iM/06Q6GbsKHvkafoyzm5TCLZNgvkwJaT0/tmfWmsV3coXxkGVAlT6yov+GJUqLzw3ek6hCTNVebctW/Ku/JdlzE2Dc3SkdNZx+sCBqlHLxqX9t0FxKwC2UHGeBLbk3aslsreNJvcCw3Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wrr7Vmw6; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wrr7Vmw6"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-94905c3e2a4so72542439f.1
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 23:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763622222; x=1764227022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPhLwqoz+xWuVss7HD2bh5wU1p+6isSywELc98gXWrA=;
        b=Wrr7Vmw6YVNB27QXNLR6ts+t6sCdr/lcE1d3Mk8rwiR6GAfp7L05UICadJKGg8tK1y
         yCSjkfBryhwkiETetQ/nlX11cJtjBwcOtyUUlbQMILJqtQvZrdDKZ9m4j4uxoKsqnG+M
         cSFi38UWpIR4cTmN1bMLkljuPC9HFwdxT0N7lcUpcP2Wrw75GAk90LzggPuDcvQnYIvp
         Rxeq3fr9dhEtBdcyW4yrreQjuoWJ8N4iVpKYrBCEIanBs8KNbXumKeYxwj8zOagjBEGF
         kJeCZ4+E6BQQMMTwJZFZQX2LtJ2Ud+s1XX3zf+mBDA/WgC8ms85vwn98whjtMr0o1WKG
         XcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763622222; x=1764227022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OPhLwqoz+xWuVss7HD2bh5wU1p+6isSywELc98gXWrA=;
        b=Oj2E4+iLAgkyReD6L3Z6cpj4ODpSb8mdpHmxf3iteZ/xaRMMcVXB3+SnGuLOL1T8OW
         PR9UC04lp2Uium6llqlxYxK3/CZpL0of+rEpUOq1zxK63cPlJQ0oc3hJU+15jUy8CpWo
         DL7ALsfxPjtPkLGPEoxRIrWZzQBj+FQoAb/t//DR4mQ6nQdyev5SssThUS1ULdPzlHBj
         SXRSQmEuh/CPbW29w5fiQ+frq8ydx2EBpY8sXMQMamHDQOgAPf17GPmuZ+9ZYDbFhSAr
         QGwlX6A7GpEXcyRtpKeFSpsbhfdxrunx6DgZQ8t4nEdGFQlg9j+p17fbm+IJeQ1dsjOg
         /wDw==
X-Gm-Message-State: AOJu0YzmG8J8ATkO5yzd+LOnYwm8BYg/uWxlM7Yf4FbtPKwLzaJvMVIc
	N7kYZlNei+REx3S/OOKSLOxxQL3ZEg784OpYFeYwPDqnv7d/rh44v+KrD9xLopDLDvYRYIxEHxx
	okueHe16X8UBdLj6O+KVPCiLiMo8ll5k=
X-Gm-Gg: ASbGnctaDtzMsRAIlQs0awRqnc8dXhPRoYRbz9TSZsmkpEwJKg2eiwmth2XpKkPaa4p
	ztyIa+eA+mDlPb7DAsZyLDHvyfg5qrRLgUA3XmAZl8bswL0W2bSmX/DdM5W59YDyEEs9cabyDdM
	G/T49Id03N4+FtkrPHuI8ss7YsPif/775rRBW+mAL2UYikDkx7tn3Qag7mu/el3M5UGXEfivGJ/
	mEzrdEGh+a8rSKCQFZV0CcbXGb/3Y/PWWS3NFhfSXpgbpzLvvyH2jKvFhkRazvgn01NBdkYO8hh
	xDkq+J6UT7ceSja05cMlCmahon5qEJG56RE/aeQ=
X-Google-Smtp-Source: AGHT+IGVZQf9gxLz6B/Y6z+uj6CLGKAqSYZ7nFjiN16ZQ5U7FcGNqOctsqr4tX/9vTnM2JTes0Fro7EKKqfx2paPYk8=
X-Received: by 2002:a05:6638:3586:b0:5ab:f3b9:431c with SMTP id
 8926c6da1cb9f-5b95677eae8mr1157040173.4.1763622222092; Wed, 19 Nov 2025
 23:03:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im> <20251027-b4-pks-history-builtin-v6-6-407dd3f57ad3@pks.im>
In-Reply-To: <20251027-b4-pks-history-builtin-v6-6-407dd3f57ad3@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 19 Nov 2025 23:03:30 -0800
X-Gm-Features: AWmQ_bnuUAqBbgoxdyTccIN6jWNWn9hf4v9xXW4NsYJs3F3KlbLBx9Jy5a2AtTI
Message-ID: <CABPp-BFx-8bxSmrzO-2i81e7XP4pbXNV6Y+Ot=RkeuhU-N0VHg@mail.gmail.com>
Subject: Re: [PATCH v6 06/11] add-patch: split out header from "add-interactive.h"
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 4:34=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> While we have a "add-patch.c" code file, its declarations are part of
> "add-interactive.h". This makes it somewhat harder than necessary to
> find relevant code and to identify clear boundaries between the two
> subsystems.
>
> Split up concerns and move declarations that relate to "add-patch.c"
> into a new "add-patch.h" header.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  add-interactive.h | 23 +++--------------------
>  add-patch.c       |  1 +
>  add-patch.h       | 26 ++++++++++++++++++++++++++
>  3 files changed, 30 insertions(+), 20 deletions(-)
>
> diff --git a/add-interactive.h b/add-interactive.h
> index da49502b765..2e3d1d871d2 100644
> --- a/add-interactive.h
> +++ b/add-interactive.h
> @@ -1,14 +1,11 @@
>  #ifndef ADD_INTERACTIVE_H
>  #define ADD_INTERACTIVE_H
>
> +#include "add-patch.h"
>  #include "color.h"
>
> -struct add_p_opt {
> -       int context;
> -       int interhunkcontext;
> -};
> -
> -#define ADD_P_OPT_INIT { .context =3D -1, .interhunkcontext =3D -1 }
> +struct pathspec;
> +struct repository;
>
>  struct add_i_state {
>         struct repository *r;
> @@ -35,21 +32,7 @@ void init_add_i_state(struct add_i_state *s, struct re=
pository *r,
>                       struct add_p_opt *add_p_opt);
>  void clear_add_i_state(struct add_i_state *s);
>
> -struct repository;
> -struct pathspec;
>  int run_add_i(struct repository *r, const struct pathspec *ps,
>               struct add_p_opt *add_p_opt);
>
> -enum add_p_mode {
> -       ADD_P_ADD,
> -       ADD_P_STASH,
> -       ADD_P_RESET,
> -       ADD_P_CHECKOUT,
> -       ADD_P_WORKTREE,
> -};
> -
> -int run_add_p(struct repository *r, enum add_p_mode mode,
> -             struct add_p_opt *o, const char *revision,
> -             const struct pathspec *ps);
> -
>  #endif
> diff --git a/add-patch.c b/add-patch.c
> index ae9a20d8f23..3594dd22534 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -3,6 +3,7 @@
>
>  #include "git-compat-util.h"
>  #include "add-interactive.h"
> +#include "add-patch.h"
>  #include "advice.h"
>  #include "editor.h"
>  #include "environment.h"
> diff --git a/add-patch.h b/add-patch.h
> new file mode 100644
> index 00000000000..4394c741076
> --- /dev/null
> +++ b/add-patch.h
> @@ -0,0 +1,26 @@
> +#ifndef ADD_PATCH_H
> +#define ADD_PATCH_H
> +
> +struct pathspec;
> +struct repository;
> +
> +struct add_p_opt {
> +       int context;
> +       int interhunkcontext;
> +};
> +
> +#define ADD_P_OPT_INIT { .context =3D -1, .interhunkcontext =3D -1 }
> +
> +enum add_p_mode {
> +       ADD_P_ADD,
> +       ADD_P_STASH,
> +       ADD_P_RESET,
> +       ADD_P_CHECKOUT,
> +       ADD_P_WORKTREE,
> +};
> +
> +int run_add_p(struct repository *r, enum add_p_mode mode,
> +             struct add_p_opt *o, const char *revision,
> +             const struct pathspec *ps);
> +
> +#endif
>
> --
> 2.51.1.930.gacf6e81ea2.dirty

Simple enough.
