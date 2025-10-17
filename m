Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410262D94A5
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760702119; cv=none; b=VKGdfYZsv3tMtkqgXH4v4BXVQkTQwWR0cuIGwqeMoiXJvXHgISduQaSh+BsnJv0lC5XYYAf8mzXgdrVx7/d0putIKfoJD51qeRRcPpfpnvhb2TpOfHFUwgQjrilJmfk2Q2PhNRSGgkVElW5xlT7NyT77WYaew/oUTpJgxlPDDQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760702119; c=relaxed/simple;
	bh=sCDTpe3t4ONgW30+k052suQNVTCJY0nYvPeapPcBBcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivT9SfIHjgbx9HGM6vY4R6WrvtpkbMfkml4Fbx43NI3DRytI7wIFoUDIlf3tK43lgy14LJ+gv1v8fnS1KEjmUbq4T/TW1hARwop0H7j6vI1kbsvrObrkllvEVeXu9IP2NLYerLO/MEYvL5W+DncY+RX8GRyNC56dcpRRYAyPaZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiaboJ4u; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiaboJ4u"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3f5e0e2bf7so346977666b.3
        for <git@vger.kernel.org>; Fri, 17 Oct 2025 04:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760702115; x=1761306915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbrawJqTwAxdnlSAJr4MEhWcMA7sI5+CoSLOlod2pLg=;
        b=ZiaboJ4uyaQKd6i61+0mFVHTehAo6gU+3VKbkGL741jWtBpnE5/LiIFrh12kvoTr+X
         ZZpihdBEXD5aL1j5fHhKGy1w8iG6G+PjR62s8v0r3Vd8pdd1gE1lGPk3d5TXC3T0d6j7
         2KGcc3tkFalXh9Gaok4Q930XaJ2Od8EWOT8uj3P6FFAL0adYW8amAdEER3GIYRGHwWsk
         jTRz9RJLq/tdpV0dFHKR7d9xqsaFLc3RwPlcuaJHLyZxaqLGTitZXwhMamhjOv8/MyZ6
         bDikrQD41/97zlmWLqVMQhndljr/IptaPGm0VD4nvfBTxpj93b+4TQJPkaoD1aiw8Reh
         65LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760702115; x=1761306915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbrawJqTwAxdnlSAJr4MEhWcMA7sI5+CoSLOlod2pLg=;
        b=sNC3gyr9r+nGSbk+8wpyjN/J9ji8F8HLOhMfzZnUGPezOQvgoMeNBSNwHzp6+Ig1Wm
         y1+wHERCVsmoja0GnZZsVLfazk5J+di7aFIL8hVlBAhtD371zihaVW8ueTs1ibNewHT6
         0LmaSXs5eFhit+z1ge/aSzwSVOBRXOs5xq707wtYC+av6H3cjJ2U1avfTNmzdsz5L6Wh
         RqgGdtwLrkzhMzjWT0E3rwex+6xGExCWYwW2fMgh8s8LhDqMTrb2aWU6zm8rUNn5nSpE
         7Q122SqdkRO9FH3BIL3ts5SL/5iEU6Ir2ORYY8MG8jJmhWiCzKzxoO+IKwYN2fmiGlGA
         zsYg==
X-Gm-Message-State: AOJu0YxONsU78n6u6GLiaSzoQM3jQgWq5l4yyhMNY8787NRXaD5uabVA
	tDQveIuqqLUd48XBhq8lpVO3eT6XNlfZcD3YlaRrGXsEqpFfyWggkZvOaIu8QldZsTP9Bakdt6W
	skS/MxW2D4yhE1NY7jjI3Bt/63EucPjE+5MK538I=
X-Gm-Gg: ASbGnct1qmME5sLJ8XjJE8jfswsl4xvd/AkTIimZeG5wyN+9MQepOg2vVDNkTvcYc0Q
	pb698rEVrcGxBn4hCzjxnpo7/UK32/PQQFGdvWkCdy1YWfeWbJDSeeo1Sg+XsaZe3paNncxBB1y
	SiCrS2w0/uLyaDDRPdoBpSquLJKeNOZEBS75RJ7ek/bcOIPUaQOXnpWzkJH+6GKKUIHYObE+9rH
	qM8DISkbkjoGK7xp2tHCw41Xy04KngV85rzmUnDSodQlmXW3EHTVjKJX8bwKr/NrbjoAQ8=
X-Google-Smtp-Source: AGHT+IHLPhfoe4PigVOy6ga8QjFMZQbaUyhVHIL9k0xUigmE9eGQbvvBrAeQMY148Qfb5ds5ziWrcRsFQHuIEGMEAjo=
X-Received: by 2002:a17:906:4792:b0:b4f:4940:6a23 with SMTP id
 a640c23a62f3a-b647314712bmr369861366b.24.1760702115278; Fri, 17 Oct 2025
 04:55:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016200344.43239-1-okhuomonajayi54@gmail.com>
In-Reply-To: <20251016200344.43239-1-okhuomonajayi54@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 17 Oct 2025 13:55:02 +0200
X-Gm-Features: AS18NWBp_bze7_bm0K5GwywZ6mlStrZqDv5MblWwbQZKEdCRJM8XpvXLq699ALQ
Message-ID: <CAP8UFD2sdvkv_ZqiLZU9k5zF+tM3UTQ8+mJjziRZGzOra6dMFA@mail.gmail.com>
Subject: Re: [PATCH] [PATCH v2] gpg-interface.c: trim CR only before LF
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 10:04=E2=80=AFPM Okhuomon Ajayi
<okhuomonajayi54@gmail.com> wrote:
>
> Problem:
> The function remove_cr_after() stripped CRs blindly. The comment suggeste=
d
> NEEDSWORK: trim only CRs before LF.

We use the present tense to talk about the current situation. In
"Documentation/SubmittingPatches" there is:

"[[present-tense]]
The problem statement that describes the status quo is written in the
present tense.  Write "The code does X when it is given input Y",
instead of "The code used to do Y when given input X".  You do not
have to say "Currently"---the status quo in the problem statement is
about the code _without_ your change, by project convention."

Also you don't need to prefix this part with "Problem:". We should
understand from the description of the status quo that the situation
is not good and should be improved.

> This caused potential confusion.

It's not clear what caused potential confusion. Is it the "NEEDSWORK:
..." comment, or the fact that remove_cr_after() stripped CRs blindly,
or both?

Also it's not clear what the confusion is about. Is there confusion
because a reader can wonder if stripping CR blindly could be a bug?

What about something like:

"The remove_cr_after() function removes any CR it finds in a buffer
after an offset, but a 'NEEDSWORK' code comment in front of it says
that it should only remove a CR that is before an LF. This can make
readers wonder if stripping CRs blindly could result in bugs."

> Solution:
> Rename remove_cr_after() to trim_cr_before_lf() and update the comment:

Here also, from the description of what the patch does, we should
understand that it will improve things, so no need to prefix it with
"Solution:".

The issue is that to know what should be done about the current
situation, it would help to know if stripping CRs blindly could result
in bugs or not. So there should be an analysis part before the part
describing what the patch does. For example the analysis part could
say something like:

"As the remove_cr_after() function is only used to replace CR LF
sequences (generated by software on Windows) with a single LF, the
'NEEDSWORK' code comment seems to be correct. It seems safer to only
remove a CR when it is before an LF even if the buffer is not likely
to contain any other CR."

(Then you could even further clarify the goal of the patch when
starting to describe what the patch does with something like:

"To implement this safe solution suggested by the NEEDSWORK comment,
rename remove_cr_after() to trim_cr_before_lf() ..."

It might not be necessary here, but I mention it so that you can see
how to smoothly transition from the problem description.)

By the way you mention renaming remove_cr_after() to
trim_cr_before_lf() and updating the comment before it, but you don't
mention actually changing the implementation of the function so that
it only removes a CR when it's before a LF.

> "Trim CR characters only when they appear before LF (\r\n) line endings."

No need to duplicate the new code comment in the commit message. We
can see it in the patch.

> This keeps lone CRs intact and documents intent clearly.

This sentence is fine.

> Also improved formatting.

It's not clear what formatting is improved. And this should use an
imperative tone, like the above did with "Rename remove_cr_after() ...
and update ..."

> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> ---
>  gpg-interface.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index c961607444..2d114e05e8 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -964,23 +964,37 @@ int sign_buffer(struct strbuf *buffer, struct strbu=
f *signature, const char *sig
>         return use_format->sign_buffer(buffer, signature, signing_key);
>  }
>
> -/*
> - * Trim CR characters only when they appear before LF (\r\n) line ending=
s.
> - * This avoids removing legitimate lone CRs from teh content.
> - */
> +/* Convert CRLF to LF, in case we are on Windows */

I don't see any "NEEDSWORKS" here. It looks like this is a patch that
was made against the version 1 of the patch you sent earlier. Instead,
all the versions of your patches should be made against a relatively
recent version of the 'master' branch.

This way if your patch is accepted, only your patch needs to be
merged. Also that makes it easier for reviewers to see that the commit
message (which starts by describing the current situation in 'master')
is correct.
