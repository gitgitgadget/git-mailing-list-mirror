Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8734B1DD0FF
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 23:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733268989; cv=none; b=YZuqPXm5Vwl9ZlCHH/h9eufp5E0Z7E8BOLlZX4ewt4TGBO9m79/bbzwuen/9V3R5PgJsTAqr+NSdBzr9o2FJY1aUpajbeycihTLyxuViHlknUgMgTvYYieoR4LSCqbTb9l4T25oimgkMLkkOFRunyXlBfVCQjLp8qav+6vT7FpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733268989; c=relaxed/simple;
	bh=ajry98LvOYVEzsRvMrDGeiHJYv1gsh6BJnUm4JjYVZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R10a+7dULQTh9PNppAxDgk+YTXohYcYfkeHwIHFG4BOOAvzcZKl3H353J4ZvQA6giPgEVwJgXZtia3A+g7rkovFGn8Ac4pmLav1+33GxEXLVJL3tZcEvKiIAcbm+iFAsh0WWHOScFqHpUkOxfegcMl21amjMfaOQkFra1NUjEAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P6rHSaOJ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P6rHSaOJ"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d0c939ab78so1913a12.0
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 15:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733268985; x=1733873785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1KEmjtQ5FZ0kGPzQW6pXCBV3ptCQuBTmBBa6FE4sbo=;
        b=P6rHSaOJt7/NzcS7Fj26ZG1KfN64NuxKekXAgIF1fPMFz/E7qridl9XjxbSezaDJSw
         ytEKo7yz5y0tNjERTJS4FfhVtqzZpWI9BTiyg4k+B38mvBXQ2tE5sEGlyj6BZ7V/kF3i
         XE01zkBu26JLWl0RU3tnVta8Op5EnfSWgErzCe8+qK0zMtGBJbat3ExbGGHU/J4dI9Lo
         bPUFrE+7dmByw0V2jelSE6byl5Nn7wI/9sBBu4Y7XshIFB01nSdnSFyF0/R1BuOdDwAr
         XXSb7WHFv0+jZGuIJbBvzYazvLUV55mnlMhc3ma2v6PHpd5hhcDHOklIxvoThZtzyOTw
         qzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733268985; x=1733873785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1KEmjtQ5FZ0kGPzQW6pXCBV3ptCQuBTmBBa6FE4sbo=;
        b=CjgnpDvSI1RsNxhzVLLY0uND7Y7MyCQyPWy2mn+X6yICXRG3UisGOO7GemX8Z7zNs/
         9Y2kJZV04lFgLvQcCQA0EpHt2D779LRueNHYya23135DPmHmyUrB2t/sYNz81qBIcaxx
         r37FBn7nWELE1j+mfFIkFOMd6lCy3BjtcMUirwnjrZeh5KzVrO6Wy6uxtnmdK7fag0Pl
         /MHpB4CBJTALf62vdo6PvyHHmu1Rgmq7j/UAftPlOtHXry2386jC6Hn3MyUT2o6iqK+z
         bLDmbYOo0vyiNnR9w7PIeGyHpmt72gcXhahUpnYWpUdl0oY+bN2iu2X/yB5X7zV2wfq6
         bzAg==
X-Forwarded-Encrypted: i=1; AJvYcCW1+CHY9yL/Vhu7J4lXgjR962wpUUQGl3nfjkEsYKxKzD2M3UGvZJGDoDebXlxYvE48ftA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6P8pKhYk1r04lEOO7T6A9m3a7ktfJXpQzUXCfW6Jnp5k3XCLr
	xo/Cyx5NDFBfg+NCKz/B/bV/lRttSN4R97DTYrc9JCYFjNdSVXUY9DFH9PsUnu/w6wJIOkMVyiG
	ewLlNMxGm9t6PrPoZZ7WFSsYS/mtZjnO89s7I
X-Gm-Gg: ASbGnctUVGV7z64IY3MPL4hzB+QZDPIw8gt1TRHJkZb7afjPC8KZHT8SNoVTK/M7NxY
	WPeruQ/S+6wU8pupCR/QjCxtyQlPODvRo18leydnfXO11DP9WFSA1F5ATLRaE
X-Google-Smtp-Source: AGHT+IF0u4Jt1aECGYqq1NKfbeMx2yCbN63MOaMZfRqgH4oCnvzYX24AgQQD2I309wb1LFgKRXeXOfjiZIqSJJkgid0=
X-Received: by 2002:a50:a45d:0:b0:5d0:8752:cecd with SMTP id
 4fb4d7f45d1cf-5d118ed1853mr13466a12.3.1733268984532; Tue, 03 Dec 2024
 15:36:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADYQcGpXm=RTEYyxqdSowQ4Vg9jmXuCzOOpd-TgDX8U814BReg@mail.gmail.com>
 <CABPp-BE1C2izp1a0Xm8_0KU+kas8XKejDyix+AzXqbCOeVp2Dg@mail.gmail.com>
 <CADYQcGpyTL18N2t8t-HwafB8VEVbBt452fsE0yMBvRvZd1mbVw@mail.gmail.com>
 <xmqqfrn5h8zj.fsf@gitster.g> <CADYQcGrD5KtM1sZQbccAtDaLmUXD8Gxv_nUWmapjfZm=TMq=Jw@mail.gmail.com>
 <3bf4e4bc-c807-4bbb-8920-afba077413b4@app.fastmail.com> <xmqqa5dc9wa5.fsf@gitster.g>
In-Reply-To: <xmqqa5dc9wa5.fsf@gitster.g>
From: Kai Koponen <kaikoponen@google.com>
Date: Tue, 3 Dec 2024 18:36:13 -0500
Message-ID: <CADYQcGo_F2STr4BGOz2bbx2yVkQEKZ0ziFOGvBB8x=mSyCgDUA@mail.gmail.com>
Subject: Re: [PATCH] doc: mention rev-list --ancestry-path restrictions
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for fixing the mangling, pickiness is definitely called for a
huge project like this with lots of work on the maintainers. Wish
gmail didn't eat tabs in plain text mode... the github app was easier
to use than I expected though.

On Tue, Dec 3, 2024 at 6:33=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
> > Hello Kai
> >
> > I couldn=E2=80=99t apply this patch to `master` (cc01bad4a9f (The twelf=
th batch,
> > 2024-11-27)). It looks like it is because..
>
> yes it is heavily whitespace damaged.  Here is what I applied after
> manually reconstructing.
>
> --- >8 ---
> From: Kai Koponen <kaikoponen@google.com>
> Date: Tue, 3 Dec 2024 12:14:34 -0500
> Subject: [PATCH] doc: mention rev-list --ancestry-path restrictions
>
> The rev-list documentation doesn't mention that the given
> commit must be in the specified commit range, leading
> to unexpected results.
>
> Signed-off-by: Kai Koponen <kaikopone@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/rev-list-options.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-=
options.txt
> index 0d90d5b154..9d5243e0aa 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -401,7 +401,8 @@ Default mode::
>
>  --ancestry-path[=3D<commit>]::
>         When given a range of commits to display (e.g. 'commit1..commit2'
> -       or 'commit2 {caret}commit1'), only display commits in that range
> +       or 'commit2 {caret}commit1'), and a commit <commit> in that range=
,
> +       only display commits in that range
>         that are ancestors of <commit>, descendants of <commit>, or
>         <commit> itself.  If no commit is specified, use 'commit1' (the
>         excluded part of the range) as <commit>.  Can be passed multiple
> --
> 2.47.1-529-gecd20ec0f1
>
