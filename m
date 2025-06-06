Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2B320330
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749209595; cv=none; b=W5LODB14IHiZDMSi+4Li94fkwBEQoRBDvr9zdMqzTjipZyicT+sGlaJPJcRJut3NJ1H9whrZeEtTjgTU/OMalT9phLzJVKdziWknJSFnVvJy8NhRp4qq1hni5+Pd/D3WQdAWGELg4FRy7XvUHZsVHqHmnSGxMTpqTsJoBhszO9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749209595; c=relaxed/simple;
	bh=D7QpxdSvJMFAXdrqaTG32huZQOhB2um68rr866/dkZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ww5pqpY1m+ZDjKLIRsBSeJjkb8hOKJJBsSGQQ0KUaJ2Q+pmTaEUVxoxxE1LwOZ+BVZn2/T9NuHgDpV+NlqmfotPVGr/fCgt8D5GbkWoAKHgMkAnzyO/8NVuqYzADScCVzuftgEnq5xVonod4O2btlpRkOfoFBie9ZxM3Lb48sno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODdCN++c; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODdCN++c"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-442f9043f56so11020205e9.0
        for <git@vger.kernel.org>; Fri, 06 Jun 2025 04:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749209591; x=1749814391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VIrsI0v9jAA2OdX81ZaCaXBoFfO5RI0QGWmgg/j3FLE=;
        b=ODdCN++ceure6vI86qa8hNKFraESyksrte9glkVoXNbEQRKma29j7GtMuULE8Nk0ge
         kgrqxyTe/ZOSv6XT+fZQLg/EpkkTIvs3XTBRq04kTu6GoY0qfDIl/4t48CR70zkcAAUq
         bo4QCpfVsPgv2f5KNttnZ8ApkTSP+4YOlWu65LYFECkvpoWWFL8hTR8P6bRI0Jm4iSpC
         lmsZCe3A+7bCBntC9LbcHHSIqQZSafxJuFqPbwMV0Isvb2rDrTUsYnJBuQfnXZaKYxmK
         BXPMRj00Jw2fT6ZWJe7RW4/qT+pGre4mIQenZvpADRm6B+yUXjY/9IelWReIkrg6t5dA
         sA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749209591; x=1749814391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VIrsI0v9jAA2OdX81ZaCaXBoFfO5RI0QGWmgg/j3FLE=;
        b=eR+TZ1e1h1UiCg1vGnbbtuThPbiH0hUD76H6TbYJnQxMgIizZSCL8OHhFOf4ZiI8Re
         P1Fq8kN1gt6uTO736UdW+6uJHHhQWrKj2NhENlkvcT2xOC97vPYhbS5nOL4fQHiCf3Qq
         +8kviNfqf64Daq0pv0sg+LYBZyACZfm/nsTVht/oyIhurwZ4Y4kKtRb9oA2OYI5qdlrr
         o4bQQGatrmMclRXCLSCF+lSzZRSnhRuhn8mIpAJp8eBjAVtadQ7wYi1QviVR3FyRRuyv
         +/KW0W+XynofsvnfJP0SBE/oabpmc+pZbmwaFqNG8mYLwRg/4f9DS0XwsDvQ9/qbNIZo
         wwqg==
X-Gm-Message-State: AOJu0YzDC4eodG+/NbaDyz8xMS9EwuRxV1SfsWAhn1uxxs8NUMT/QGkC
	TYBkyHbs0qCumSa4SwfVjrgK1Ow+AKjJEjya8tXSpbaQCSFh0f9NEx+8YqCJCWRzaUoaFOukLeH
	Bh/YFJB+H0JDtMFN9/v50t3WZVlvQ26o=
X-Gm-Gg: ASbGncvMDCt6iEwn0rCF/1C7p0yZF5x8ImOBKJypb607PoTdEIfLMRNs+pUEddUU8uc
	TRS0c+P4Aw+K+JapneohPyWdic6XJy3b0IJqbVZi8Pl28teX/TbezrgtV4r5TvmjcTmcGBEC0uU
	ZxJwdsHHsA9817E0oanX68e3+I+QgK+8NzRQ==
X-Google-Smtp-Source: AGHT+IFnLFoo3zwxtjdyONb4bZPJp+LrdaVAsd642NYY9O7nbXQWXxMGQoIwRh3YmEBiBkRpUsM/0dzsh7cMCQqFNCQ=
X-Received: by 2002:a05:6000:2289:b0:3a4:ed62:c7e2 with SMTP id
 ffacd0b85a97d-3a5318856acmr2722346f8f.28.1749209591274; Fri, 06 Jun 2025
 04:33:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6292feee7c4347efad31e9fb2a1763779b7df133.1747407473.git.phillip.wood@dunelm.org.uk>
 <cover.1747733203.git.phillip.wood@dunelm.org.uk> <98ad3de977090a793408b25ca880b65f058ea44e.1747733203.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <98ad3de977090a793408b25ca880b65f058ea44e.1747733203.git.phillip.wood@dunelm.org.uk>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Fri, 6 Jun 2025 13:32:58 +0200
X-Gm-Features: AX0GCFv_wcc0HO0q8r7FgEadnN4tlG10Og4HC9F_ZE-7eoLSk8aELH0wpaxyW3o
Message-ID: <CAN0heSq56q5nQnrd0YBOWEvj7uXEFkWG3DH6Ms6JVkFNnuUmBA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] stash: allow "git stash [<options>] --patch
 <pathspec>" to assume push
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 May 2025 at 11:27, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> The support for assuming "push" when "-p" is given introduced in
> 9e140909f61 (stash: allow pathspecs in the no verb form, 2017-02-28) is
> very narrow, neither "git stash -m <message> -p <pathspec>" nor "git
> stash --patch <pathspec>" imply "push" and die instead. Relax this by
> passing PARSE_OPT_STOP_AT_NON_OPTION when push is being assumed and then
> setting "force_assume" if "--patch" was present. This means "git stash
> <pathspec> -p" still dies so that it does not assume the user meant
> "push" if they mistype a subcommand name but "git stash -m <message> -p
> <pathspec>" will now succeed. The test added in the last commit is
> adjusted to check that push is still assumed when "--patch" comes after
> other options on the command-line.

All makes sense to me.

>         if (argc) {
> -               force_assume = argc > 1 && !strcmp(argv[1], "-p");

This is where we drop the very specific approach of "let's look for -p".

> +               int flags = PARSE_OPT_KEEP_DASHDASH;

This is the flag we've always been using.

> +               if (push_assumed)
> +                       flags |= PARSE_OPT_STOP_AT_NON_OPTION;

Now we use this, too, if we've assumed "push". Makes sense even without
the specific context of this patch: we've assumed an implicit "push", so
let's be a bit less aggressive in parsing the remainder.

>                 argc = parse_options(argc, argv, prefix, options,
>                                      push_assumed ? git_stash_usage :
> -                                    git_stash_push_usage,
> -                                    PARSE_OPT_KEEP_DASHDASH);
> +                                    git_stash_push_usage, flags);
> +               force_assume |= patch_mode;

Rather than looking for "-p" in a fixed place, we see if option parsing
spotted it. Makes perfect sense. Although, why `|=` here? We initialize
`force_assume` to 0 at the top and this is the only other time we write
to it. Why not just `force_assume = patch_mode`? Future-proofing?

> -test_expect_success 'stash -p <pathspec> stash and restores the file' '
> +test_expect_success 'stash --patch <pathspec> stash and restores the file' '
>         cat file >expect-file &&
>         echo changed-file >file &&
>         echo changed-other-file >other-file &&
> -       echo a | git stash -p file &&
> +       echo a | git stash -m "stash bar" --patch file &&
>         test_cmp expect-file file &&
>         echo changed-other-file >expect &&
>         test_cmp expect other-file &&

We lose the test of `-p` that we just added. Ok. We should be able to
trust our option parsing machinery to get this right. This s/-p/--patch/
demonstrates that your patch works, and as for running this as a
regression test in the future, we'll be using one of the equivalent ways
of spelling this option. Ok.


Martin
