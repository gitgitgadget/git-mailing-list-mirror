Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E086E246789
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 07:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403176; cv=none; b=CNNu3u7IDOeyUAlJqa3EmBHxrRzQp6Gkg9AxSoVEPGesYkDfzVGFTKOUo2Xh605uDcro1qlN5fORl5mSFtGu2Stqn6qfJKybYB3tLhNtN5KgIaaRbriRmtgMCTIXHkszWTjNTiyxq8ZiSRDzmtkBAH4pSHf25ot2ho6/Ex0N/7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403176; c=relaxed/simple;
	bh=vZn1ww8dSCEhUYoIVsybASCdWWkqLgp9XLKea7rLJSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fV5iuPzadjphMWAKCMBjgu5xZmBw2J/CqlduY1YT8jFW0SEM3NksxBZTyu729Q8hpIfcXuvgR+nbgQGta3YFQnr6eR3XBBRm9zAp70YBzynLt/90oaEyESu9JljrpagTfuMt6nK6OrCL5BZ48Axw0UQIBKy4tcswp3mdBD18YjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MH7PXmgf; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MH7PXmgf"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3fe48646d40so13952305ab.0
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 00:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757403174; x=1758007974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbToBDw5tRFXiDtlc5HVq15sFAW3v6wmUaDUpEd284I=;
        b=MH7PXmgfSMchtY3oivZrGr7U1boO0vu1LZZk7baoOQaFxuyU/FH/371wXWTwra57Et
         0hs5EOM9bLbW2VRqYzbh8mUSsWbFlRDKum9OrLzRcAYL4u3euhqR8aO51U2dcDXFjXB+
         0+tz5qRTjN4Y35pRW1eeqeEptUMkScj0lC5evZiYbo2CGMyP+L3O0qg4ln8CldYJtmAu
         Vrg6eN1oUiIj20ZlniB7+1x0p7Ys/ZZ0Z8ePVr/kXNPdxLE/G4ZbwLRuwPsiIYruiXZN
         205NSWnHLzAr5V382tPeQKjJKLzhyKY5ZENuex8/W2bSv/1ovZvxx5gMmuZ5m0hKt6Mb
         tTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757403174; x=1758007974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbToBDw5tRFXiDtlc5HVq15sFAW3v6wmUaDUpEd284I=;
        b=wuIz1AF1uyqNsbgWAkYc35HcMeqmKME2v9Ok0uO+evdK12wV5cS9YRyKvQxd1iZVkh
         K4uZ9EWIgJZe/6WQMHIvJxwZvX7r9e7wWH9iBzayZqXk6yl4VQIiWyAiXBqW2CT9iF/x
         xsquDPovuaWx44Dd/FskQ+H4eD885oorOYh2E148D4KH633fXd7QwzGMrHOUaYSaMNdQ
         k2lijLBV2tXpM7XkLUlJgMt4A8naeq6vlAGNBhhKYcsizbF6gvlpdgpae8VXjkBDLUgl
         QZ7+XoRf36+6uo4BKPjMUKv9EbFiLHO+cNyBz2Rmrd4uyJuywvma+3XkWwyWh+KuwIJ4
         Qq7g==
X-Gm-Message-State: AOJu0YyFsq5Va0N7ahtKHdcLbKKDITJLdsLkQtru/fmEAxp4SVKx6VMt
	0u4qzNp0AYIRkTheMU0dCXCtmIcMvS7zBz+M+QlEFOfNpBFI2JiClnSNMF6wQc3YdocVNWap8Mc
	7lsiAGg17s1ibcZcbMFgktJgx0mIrfiQ3P3CTkY4=
X-Gm-Gg: ASbGncsSTgRGcRdEvI2tgEdeGsMwzSBGqD+dB0S1C+Uugb7jMgwFD36rwvKx40xenP6
	EXqKtpe6hDEAL/z+/+Ii1pwTcuN2ZiGs/rTotUWVuT+zVdXsl64w0UTIEO4HDQ//6sMdo2Oib1T
	wpqOzcLzH4WUZVKSPGyJyTxno724b5B6FwHkx/bqVkw+x2+Pm/4htCS02jeOZlS0PHew2d5eiV8
	1zgSetopnqeadjoMJj/zpPTWg2NbAkOofodzPrO6aNmhz1Nwg==
X-Google-Smtp-Source: AGHT+IEa08LR5Y+GjaKX3aGvbCpyC/y1EzeO87xVSvBUaUII9UY5jWpXBQquJaMEHdVhdX2OWRiNq1Z0thj6TU1aDmc=
X-Received: by 2002:a05:6e02:250f:b0:401:8ce:381f with SMTP id
 e9e14a558f8ab-40108ce38afmr145627965ab.6.1757403173985; Tue, 09 Sep 2025
 00:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908043620.57848-1-siddharthasthana31@gmail.com> <20250908043620.57848-2-siddharthasthana31@gmail.com>
In-Reply-To: <20250908043620.57848-2-siddharthasthana31@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 9 Sep 2025 00:32:42 -0700
X-Gm-Features: Ac12FXyZl3mnlDbUaq3WrLAUFg2LB5ij0CX1Tm2OX1w87vzZWTO8C-kYUu3Sw3M
Message-ID: <CABPp-BEmOor3CLAY6y50DuGR1K7WYu+PVsXXWOOaofXzJpavMg@mail.gmail.com>
Subject: Re: [PATCH 1/2] replay: add --update-refs option
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Christian Couder <christian.couder@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>, 
	John Cai <johncai86@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 9:36=E2=80=AFPM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:
>
[...]
> Option validation ensures --update-refs cannot be used with the existing
> --update option, and --batch can only be used with --update-refs.

There is no existing --update option.

[...]
> +       int update_directly =3D 0;
> +       int update_refs_flag =3D 0;
> +       int batch_mode =3D 0;

Why are we adding three kinds of updates?  You covered two in the
commit message, but mostly only motivated one, and then added three?

> +               OPT_BOOL(0, "update", &update_directly,
> +                        N_("update branches directly instead of outputti=
ng update commands")),
> +               OPT_BOOL(0, "update-refs", &update_refs_flag,
> +                        N_("update branches using ref transactions")),
> +               OPT_BOOL(0, "batch", &batch_mode,
> +                        N_("allow partial ref updates in batch mode")),

Three modes and I can't figure out how update_directly differs from
the others from the description.  Is it different?

Also, --batch seems like a funny name since update-refs is also
updating refs in a batch.  I'd suggest coming up with a new name...but
is there clamor for it?  You mostly motivated the atomic updates, and
I think it might be better to just implement those and then add more
flags later if needed.

> @@ -399,6 +461,7 @@ int cmd_replay(int argc,
>
>         init_basic_merge_options(&merge_opt, repo);
>         memset(&result, 0, sizeof(result));
> +       result.clean =3D 1;  /* Assume clean until proven otherwise */

I don't understand why this change is needed or helpful.  I don't
think it changes behavior looking at the existing code, but to me,
result is supposed to be the result of a merge operation, not an
input, and should not be set other than being cleared initially by the
caller.  The comment feels slightly misleading to me, as well.  So,
I'm surprised by this change and would like to hear the motivation
behind it; could you clarify?  Did I miss something about how you
depend on this being set even if the list of commits to replay is
empty or something?

> -                               printf("update %s %s %s\n",
> -                                      decoration->name,
> -                                      oid_to_hex(&last_commit->object.oi=
d),
> -                                      oid_to_hex(&commit->object.oid));
> +                               if (update_directly) {
> +                                       if (update_ref_direct(repo, decor=
ation->name,
> +                                                            &last_commit=
->object.oid,
> +                                                            &commit->obj=
ect.oid) < 0) {
> +                                               ret =3D -1;
> +                                               goto cleanup;
> +                                       }
> +                               } else if (transaction) {
> +                                       if (add_ref_to_transaction(transa=
ction, decoration->name,
> +                                                                  &last_=
commit->object.oid,
> +                                                                  &commi=
t->object.oid,
> +                                                                  &trans=
action_err) < 0) {
> +                                               ret =3D error(_("failed t=
o add ref update to transaction: %s"), transaction_err.buf);
> +                                               goto cleanup;
> +                                       }
> +                               } else {
> +                                       printf("update %s %s %s\n",
> +                                              decoration->name,
> +                                              oid_to_hex(&last_commit->o=
bject.oid),
> +                                              oid_to_hex(&commit->object=
.oid));
> +                               }

Who would want the update_ref_direct() branch of code here?  Can we
just toss it?
