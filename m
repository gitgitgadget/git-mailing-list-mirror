Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FBE1DF270
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753207370; cv=none; b=Cp4Fe0YSMCfImiGTrJPWoVQFKHxdk2cDEOD6a6G9rhW1byDXnizFgigzZxzN75+yzV02GANrtz8g8NnGJ0/seMvjNFqVJ15lIAsdBAb+Zz/YlBVxwzW+Z5XdHYuW6eTbyftQziW5QcU+GVMVh6Hn3p4yyMjpWuch4HtYARYtHRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753207370; c=relaxed/simple;
	bh=6Dfo6Auj0n3SOyc/NWkDG8r4HeFB0g6Zv7wQctvwHaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XP7a4kwXuTlMAAoCnZO2W95jgYVtsAlJAibMUyy/v+mwoPFUhYW08QSEbhOgvmqp2mmmlivDJkxVbT5T5S5jsswP9kRXujCsHySYVLlPhJlDvH7fZpELJuTCigoMhhB1KdE4lfUnVNNgQGGu17WOIMnNRfRzhojAPN39y9wHWWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/X+DwMz; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/X+DwMz"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54b10594812so5717095e87.1
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 11:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753207367; x=1753812167; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1XtqzNnkUIlhjEWwZyz5bc7g6jaMaP+69Y1kvfYpakA=;
        b=Z/X+DwMzSOBLirxzq6pV/5W/kFPyMQFwpkTMTllGDoTaXV1f7OF6p+hMKseEgomt+9
         yh/0iHfUa7TRjIFIozZJyRx7a6YffO/fCOqKM8M/IKBkkQ+AlixvUDsi6uSdDgKuA+9U
         cHpBdql0Q5PLMakJDiMHzB6WxBWiIOyOXabdFSxMia+pltboyRYtNpSVtm1899vF3nHf
         JHYUU0XFcHzt1FNKJWpieGt2LB/c+6FdQ8Z1dWmx17mr9CYGrpPBKeeq9ECaOj1WvFOD
         Ij4ZCfOVIzFznSoKPsyydBAPQxQA1ztwrdDE6ITdfF7zoYV/UdqLZ6iDaL55evOHNpI8
         Dvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753207367; x=1753812167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XtqzNnkUIlhjEWwZyz5bc7g6jaMaP+69Y1kvfYpakA=;
        b=RLRDLycIV4N0C8Z2RHKTDgUj+uAvH5dTUpod4M5IEY2bzym0CR6tIwI5S7Hw2PdQ8I
         MEHgKsCtw7dO2CUSbQ5RjvgIEPqSxuVkrZSX5DY8hkNSMXJ8sagjLxB3p1RP2Z2V9iIl
         tVcTJSxXpmyJYvLsrHOVxhN3z0rQgBHbApVuGCCf4dzVSNAjYuxvomBqF7hE0DZjwoOw
         K5OxwiehHuc/V3uWe8CTvOZhWJtQM9NzXn/+8AQiWGRftx3myEHTtiVT2k1o+jGZFPYJ
         sgVjGf5iEbIn+9GutjYFqqwuRpXoD4iuNz8Fdvq2f4dRrY2e0z6StG3oNzNyJF6YkYQ2
         zlVw==
X-Forwarded-Encrypted: i=1; AJvYcCWWz6ievmuEXcXxzOuw5rMIYoVkHwx7hL7gma++5aSzMMOfPHSPOzNvqUfsdsu1NNRw/H8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbeGfxySjGPJbAUaNNhAjUVzvrnVk93PonTbgexyB5zo8huXdz
	6DydSNhRItNaU4kqOd8Z1I5nmynsrkM6T9wpnzk1BQoT+kN9KCFn8qX6Bk84eNt5f2fR9Bmr6nw
	UMUlKYzsShhkXjYPRRFHvpRQshZgXEaY=
X-Gm-Gg: ASbGncsSWnAvnZwRcV7YPDSEAcV7K49rx91vyXRw5MPWAwF+vQSDSQpaDEeQBRdwEBI
	VF5Cn3X85IylqzRj01pYWo2Yb4IwslKjRCpwoYqC5pyeJpSjrHdGNeyw2N8GJMIWhVerCI754jz
	2HLWsr5Umvzpg1NITtthlxHAqIy8lm/viCAVZboJWiAQi4RPqpMjRubTo0EZWaX+zj1aIiUDAvY
	BDB0lV8lKjYt/sMbyTZXZZvwUaHuO7mwwuagNLp9LQI3CdSoSen
X-Google-Smtp-Source: AGHT+IHvi4bIAdz4tjHN8L1WN2+uHBLMuBj/OKMLZZUWlG7AoY9JNwwkZE7v3unCPLTmobn7Vcl6SrlJY02jUhRufOw=
X-Received: by 2002:a05:6512:6507:b0:554:f9cc:bea5 with SMTP id
 2adb3069b0e04-55a513bb879mr12225e87.34.1753207366333; Tue, 22 Jul 2025
 11:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
 <pull.1915.v4.git.1752928113.gitgitgadget@gmail.com> <2774b930406819ea60f522e0e0741e4046ee01ee.1752928113.git.gitgitgadget@gmail.com>
 <076bb5e9-e8c4-466d-b8dd-bc84bba708b2@gmail.com>
In-Reply-To: <076bb5e9-e8c4-466d-b8dd-bc84bba708b2@gmail.com>
From: Leon Michalak <leonmichalak6@gmail.com>
Date: Tue, 22 Jul 2025 19:02:35 +0100
X-Gm-Features: Ac12FXxiKl7aLqZA2f15OOjmdj0pyMBl9WTkobSjKoKfe5NHiE53cq4g0lpi-mU
Message-ID: <CAP9jKjExau58dP+=MJXiKWvCcOaBmhB-yta0x76s7b0XWqBQxw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] add-patch: add diff.context command line overrides
To: phillip.wood@dunelm.org.uk
Cc: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hey Philip, looking again for a second time and re-reading previous
replies on this thread, I think I misunderstood a previous reply.

I will add these back as soon as I can get back to the PC, thanks for
spotting that!

On Tue, 22 Jul 2025 at 17:02, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Leon
>
> On 19/07/2025 13:28, Leon Michalak via GitGitGadget wrote:
> > From: Leon Michalak <leonmichalak6@gmail.com>
> >
> > This patch compliments the previous commit, where builtins that use
> > add-patch infrastructure now respect diff.context and
> > diff.interHunkContext file configurations.
> >
> > In particular, this patch helps users who don't want to set persistent
> > context configurations or just want a way to override them on a one-time
> > basis, by allowing the relevant builtins to accept corresponding command
> > line options that override the file configurations.
> >
> > This mimics commands such as diff and log, which allow for both context
> > file configuration and command line overrides.
>
> Thanks for updating the quoting in the tests. Unfortunately this patch
> now deletes the tests added in the last commit which I don't think is
> correct.
>
> >
> > -test_expect_success 'add -p respects diff.context' '
> > -     test_write_lines a b c d e f g h i j k l m >file &&
> I think there is some confusion here - why are we deleting the tests
> added in the last commit? This removes the test coverage for
> diff.context and diff.interHunkContext
>
> > +for cmd in add checkout restore 'commit -m file'
> > +do
> > +     test_expect_success "${cmd%% *} accepts -U and --inter-hunk-context" '
> > +             test_write_lines a b c d e f g h i j k l m n o p q r s t u v >file &&
> > +             git add file &&
> > +             test_write_lines a b c d e F g h i j k l m n o p Q r s t u v >file &&
> > +             echo y | git -c diff.context=5 -c diff.interhunkcontext=1 \
> > +                     $cmd -p -U 4 --inter-hunk-context 2 >actual &&
> > +             test_grep "@@ -2,20 +2,20 @@" actual
> > +     '
> > +done
> > +
> > +test_expect_success 'reset accepts -U and --inter-hunk-context' '
> > +     test_write_lines a b c d e f g h i j k l m n o p q r s t u v >file &&
> > +     git commit -m file file &&
> > +     test_write_lines a b c d e F g h i j k l m n o p Q r s t u v >file &&
> >       git add file &&
> > -     test_write_lines a b c d e f G h i j k l m >file &&
> > -     echo y | git -c diff.context=5 add -p >actual &&
> > -     test_grep "@@ -2,11 +2,11 @@" actual
> > +     echo y | git -c diff.context=5 -c diff.interhunkcontext=1 \
> > +             reset -p -U 4 --inter-hunk-context 2 >actual &&
> > +     test_grep "@@ -2,20 +2,20 @@" actual
> >   '
> >
> > -test_expect_success 'add -p respects diff.interHunkContext' '
> > -     test_write_lines a b c d e f g h i j k l m n o p q r s >file &&
> > -     git add file &&
> > -     test_write_lines a b c d E f g i i j k l m N o p q r s >file &&
> > -     echo y | git -c diff.interhunkcontext=2 add -p >actual &&
> > -     test_grep "@@ -2,16 +2,16 @@" actual
>
> This is also deleting a test added in the last patch
>
> > +test_expect_success 'stash accepts -U and --inter-hunk-context' '
> > +     test_write_lines a b c d e F g h i j k l m n o p Q r s t u v >file &&
> > +     git commit -m file file &&
> > +     test_write_lines a b c d e f g h i j k l m n o p q r s t u v >file &&
> > +     echo y | git -c diff.context=5 -c diff.interhunkcontext=1 \
> > +             stash -p -U 4 --inter-hunk-context 2 >actual &&
> > +     test_grep "@@ -2,20 +2,20 @@" actual
> >   '
> >
> > -test_expect_success 'add -p rejects negative diff.context' '
> > -     test_config diff.context -1 &&
> > -     test_must_fail git add -p 2>output &&
> > -     test_grep "diff.context cannot be negative" output
> > -'
>
> and so is this. The tests you're adding look good but we shouldn't be
> deleting the existing ones.
>
> > +for cmd in add checkout commit reset restore "stash save" "stash push"
> > +do
> > +     test_expect_success "$cmd rejects invalid context options" '
> > +             test_must_fail git $cmd -p -U -3 2>actual &&
> > +             cat actual | echo &&
> > +             test_grep -e ".--unified. cannot be negative" actual &&
> > +
> > +             test_must_fail git $cmd -p --inter-hunk-context -3 2>actual &&
> > +             test_grep -e ".--inter-hunk-context. cannot be negative" actual &&
> > +
> > +             test_must_fail git $cmd -U 7 2>actual &&
> > +             test_grep -E ".--unified. requires .(--interactive/)?--patch." actual &&
> > +
> > +             test_must_fail git $cmd --inter-hunk-context 2 2>actual &&
> > +             test_grep -E ".--inter-hunk-context. requires .(--interactive/)?--patch." actual
> > +     '
> > +done
>
> This looks good as well
> >   test_done
> As I said last time I do not think the tests below add any value. They
> also do not compensate for the removal of the tests for diff.context
> that are deleted above as they all pass -U on the commandline.
>
> > diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
> > index 1384a8195705..0158fe6568cb 100755
> > --- a/t/t4055-diff-context.sh
> > +++ b/t/t4055-diff-context.sh
> > @@ -58,6 +58,36 @@ test_expect_success 'The -U option overrides diff.context' '
> >       test_grep ! "^ firstline" output
> >   '
> >
> > +test_expect_success 'The -U option overrides diff.context for "add"' '
> > +     test_config diff.context 8 &&
> > +     git add -U4 -p >output &&
> > +     test_grep ! "^ firstline" output
> > +'
> > +
> > +test_expect_success 'The -U option overrides diff.context for "commit"' '
> > +     test_config diff.context 8 &&
> > +     ! git commit -U4 -p >output &&
> > +     test_grep ! "^ firstline" output
> > +'
> > +
> > +test_expect_success 'The -U option overrides diff.context for "checkout"' '
> > +     test_config diff.context 8 &&
> > +     git checkout -U4 -p >output &&
> > +     test_grep ! "^ firstline" output
> > +'
> > +
> > +test_expect_success 'The -U option overrides diff.context for "stash"' '
> > +     test_config diff.context 8 &&
> > +     ! git stash -U4 -p >output &&
> > +     test_grep ! "^ firstline" output
> > +'
> > +
> > +test_expect_success 'The -U option overrides diff.context for "restore"' '
> > +     test_config diff.context 8 &&
> > +     git restore -U4 -p >output &&
> > +     test_grep ! "^ firstline" output
> > +'
> > +
> >   test_expect_success 'diff.context honored by "diff"' '
> >       test_config diff.context 8 &&
> >       git diff >output &&
>
> Thanks
>
> Phillip
>
