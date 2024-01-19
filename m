Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4E51111
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 02:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705631903; cv=none; b=A+yNKua4oi/WzbDzHo8yGMx3yAK4P037PwZ+eUKVn86eRKqMaEcLWYJf/0WrDEjjKa5hd+jozzpuR0NnhJTBl+MhZqqhBUp1DpoiKiIf1yk/ie5v8wXbdQg1W/+YeySDufBa38lCJy1lhHtvUlK11MFQboscKBxSDg+Fg51Wus8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705631903; c=relaxed/simple;
	bh=Sp4NZyLP1Ns7P0w8snGhpS07LeB7WAvZAGj24pL/XOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khIvjFifMVebWmGer3NK3zt++RqvpXE34HwgZlXugE+K7bTSFh9gr4JSa9yMDQoQc9x2RZAAUn4V5kOF8mHf/CBdkwCSQi/24ajBM2aC0zBi4ONnA0cS3bGv9P10j+SVP93HaLA4kxOb8uB/owYn15gC+SPuyvyQKSqL57JaG2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAyTPg+S; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAyTPg+S"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cd8b64a52dso3739181fa.2
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 18:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705631900; x=1706236700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbGHIm42O7swOsBLtSGV1Oh1HFGBzqdznWsMK2wMNaI=;
        b=mAyTPg+SH4LjZw6RP1X4lVoqWOoneayGCcCxKLjPqZS/94MU+aFNyRkf/dk0UpyjkF
         4TEeD07rILsQAS5pvBJsXiLz2HnGRLe+Xz8r/T7ZJOh6Aw377ClI5K74yfbgmaQNoG6Z
         a1PYqvDYxuuM7+BGtKtOySDMd9hXCOJXsiJrV6E6f1wiBEXrTqxolIbdIBFAW4nyGxS5
         P4yf5Qyb/dOoWJoEoOWxEsob54wCPX/Z+0gF1TsRw90annl66wtPLLNTJ6v4t1oeuZfn
         I+IEEPk+cFTpV6sb6U0qopoKuT/uRYW2OMD5BCPk6JteatMGHNCCHnu0lO+OZYa6dR94
         5WXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705631900; x=1706236700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbGHIm42O7swOsBLtSGV1Oh1HFGBzqdznWsMK2wMNaI=;
        b=OCQUpKJaeykV3QjaEWrjqtxLJwE45Ifdyr7Obwfdey9CEYBOuKCWh3QU33nJXfrnlq
         RcwV+DxJ3VKHikRP/sN1k8bKShMZwv7mVgpdU5FRg/3lQDtMMOm+EMGY9lLrL2ihptK4
         AKLV/PO/3vQqyZ8arzPn/mhV1gjoI03yS/eb0oRKsl8PGtlad2a0cO5ZUYmJMMitl5RU
         udBtBgTGuYOHl9JjvCuRZZI6rlFNmYo/yMoD/HO4M+c19KswGXpIFuhCzedtvbiyoFeC
         A5+6Ofxev3MQ3tvAQooiE+T8ZTWmfxrxf2ZatO8fi5Y0SH0/dSpsMvv+iOjtbwqp9skb
         2nbQ==
X-Gm-Message-State: AOJu0YzuulRxrqZvHYf/WXf6GGZOLz4PPonLwDm5bamgdAZbgXiHP0tC
	Zcszj0qA3qU1bZvjXHZvX1onEPsBMMMRySIPHzM5IecHbHaA9Hb1KZ6/seo1HAw5oce7InKHTAi
	wlYv1qDcu5KuObtT939vvG+QEXW4=
X-Google-Smtp-Source: AGHT+IEClo1FkFoI6pATM+6P7/364ur1h7MrsPN42+CX1un4wxSZvMaAdSEHnYoYWUGjEPF+rZ9BW1pKyu5EH1NOfbs=
X-Received: by 2002:a2e:b1c7:0:b0:2cd:c1e6:58a1 with SMTP id
 e7-20020a2eb1c7000000b002cdc1e658a1mr1005654lja.64.1705631899985; Thu, 18 Jan
 2024 18:38:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1627.git.1703643931314.gitgitgadget@gmail.com>
 <xmqq8r5gfc3j.fsf@gitster.g> <CABPp-BGSTYDUR1oYYXkCSh-1i2zwxBM=-gnoe-ezNbtPi5CV2A@mail.gmail.com>
 <xmqqsf3nl2b3.fsf@gitster.g> <298F7067-D572-433F-A7DD-5256B43B97D7@icloud.com>
 <xmqqwms6qwr3.fsf@gitster.g> <F214D88E-6837-4EAB-896E-DF8CFC315EE7@icloud.com>
In-Reply-To: <F214D88E-6837-4EAB-896E-DF8CFC315EE7@icloud.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 18 Jan 2024 18:37:00 -0800
Message-ID: <CABPp-BF4Bfr3Hfy7atehHvbQds63+GXO9XPJAW3Mb7dvMcCkDg@mail.gmail.com>
Subject: Re: [PATCH] precious-files.txt: new document proposing new precious
 file type
To: Sebastian Thiel <sebastian.thiel@icloud.com>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Josh Triplett <josh@joshtriplett.org>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 1:33=E2=80=AFPM Sebastian Thiel
<sebastian.thiel@icloud.com> wrote:
>
> Thanks so much for the analysis, as seeing the problem of choosing
> a syntax from the perspective of its effects when using common commands
> like "git add" and "git clean -f" seems very promising!
>
> When thinking about "git add ." vs "git clean -f" one difference comes to
> mind: "git clean -f" is much less desirable it's fatal. "git add ." on th=
e
> other hand leaves room for correction, even when used with `git commit -a=
"
> (and with the exception of "git commit -am 'too late'").

"git commit -a" and "git commit -am 'too late'", by themselves, will
only commit changes to already-tracked files.  So they wouldn't be
problematic alone.

But perhaps the -a was distracting and you were thinking of "git add .
&& git commit -m whatever".  That does remove the chance to correct
before creating a commit, but I don't think it's too bad either.  Even
though it skips the chance to catch the problem pre-commit, there's
still time to review & correct before publishing for patch review (or
PR review or MR review or whatever you want to call it).  And, even if
published for patch review, it can still be caught & corrected by
those doing patch review as well.

So, I just don't see the "accidental add" problem as being very
severe; there are so many chances to catch and correct it.

> To my mind, in order to support projects with both ".config" and
> ".env.secret" they would have to be given a choice of which syntax
> to use, e.g.
>
>     # This file shouldn't accidentally be deleted by `git clean`
>     $.config
>
>     # These files should never be accidentally tracked
>     #(keep)
>     .env*

Reminds me of https://www.emacswiki.org/pics/static/TabsSpacesBoth.png

;-)

Besides, if for a specific file or filetype, accidental additions are
more important to protect against than accidental nuking, then can't
folks achieve that by simply using

    # Don't let older git versions add the file
    .env.secret

    # For newer git versions, override the above; treat it as precious
(i.e. don't add AND don't accidentally nuke)
    $.env.secret

In contrast, if protection against accidental nuking is more important
for certain files, one can use just the second line without the first.

And, whether you have a file with both lines or just the second line,
newer git versions will protect against both accidental nuking and
accidental adding.

In contrast...

Phillip's syntax provides no way to achieve treating accidental nuking
as more important than accidental adding; it can only handle
protection against accidental adding in older Git versions.  And, as I
discussed above, the accidental add problem seems much less severe and
is thus the less important problem to protect against.
