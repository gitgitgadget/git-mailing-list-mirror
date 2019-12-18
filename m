Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF69BC43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 02:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982D921775
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 02:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYEZxe0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfLRCoF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 21:44:05 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:45308 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfLRCoE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 21:44:04 -0500
Received: by mail-qv1-f67.google.com with SMTP id l14so162375qvu.12
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 18:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=939nN9U0B0XBiV+y2tey9ZvmXwJnI/+TUvFJD7c2OEo=;
        b=mYEZxe0JRe3gLYtlknH4RHd5qPeSAvdZKWBlQkE48WAdVftkvUXos3W1Bru856JLGa
         LVls9fZN0B3RSNkzqbu/quAo9xGYRMuIA5+LRe6eqJSm7zuDSjekcArSSVvfeI5Fe2la
         L8l3rTiRAMr3iZZawTF8/CazEDaG766fGB3xr+DoZ7RolJz35gBMaRMut46BUBSUoGIt
         R/JZF6t+YBmpsRceUkw+G+NJkcoUvMFCoGdJo/m/gARdjglkkXpw8WXzqGRfZhZB2f/9
         ZJPy7psaWkGumzddFLww8BaR/gwBElJHiXii/Ljkhth3eu/AhdoPTsnb0cEreQRFtQk9
         +hTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=939nN9U0B0XBiV+y2tey9ZvmXwJnI/+TUvFJD7c2OEo=;
        b=CjOKc2wZWuzAn/uFOHVydilsYOqoLtxRBtDnVbTMLjIlVzFYAoiABjI+OvA8lgj60y
         v+YpWVV+WkgcZNd5tXuhjgNE9zrcXc8ULyMgr8iwBIq1ggHXV/jjAD8i0sXxYVKS5o2t
         movia2G10EJ2qHFo/PYDN3izT8lDLa5j8sv3yqU9drFq9Ywjv4bxYIWQqM7YCPZ5glW5
         QBxlUsXs2mGEg5KVQLbOFpXqq2IDyI/gfLg/Cm8Bd8V/fxrvjhiAm0h56JA8ErXFqfkd
         vElKjDRFjtgyWrHebztmuf7RIIrbbMk56kum44JmGvK+CPtAH7Wy+6eXOfCpWjK+KK7H
         EhFA==
X-Gm-Message-State: APjAAAVwXpGDXch9+8vOrEfhb/YyWkf8fXPUOPojKtDt/zhPADwWRONT
        4Kc+7ijZl/47lsh5AUcZ5+0=
X-Google-Smtp-Source: APXvYqzpsmNw6VtUjQDlpKPRMYOCmn5VKhUcDT/CbX0nvsI8AlUw9egEBKU/qbfqX3UUgPOozvotyA==
X-Received: by 2002:a0c:e8cd:: with SMTP id m13mr270620qvo.102.1576637043191;
        Tue, 17 Dec 2019 18:44:03 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id g18sm218630qki.13.2019.12.17.18.44.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Dec 2019 18:44:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/2] Documentation/git-log: document accepted line-log diff formats
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20191217113301.GA8609@szeder.dev>
Date:   Tue, 17 Dec 2019 21:44:01 -0500
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "Thomas Rast <tr@thomasrast.ch>, Junio C Hamano" <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E3047E9B-B269-4DC3-A894-BB39C7A20E77@gmail.com>
References: <pull.494.git.1576559263.gitgitgadget@gmail.com> <0ed04a8629a64d15062e13c1f1739b01436a897b.1576559263.git.gitgitgadget@gmail.com> <20191217113301.GA8609@szeder.dev>
To:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That=E2=80=99s a good point. I did not think of such corner cases. I =
will remove that mention then.

> Le 17 d=C3=A9c. 2019 =C3=A0 06:33, SZEDER G=C3=A1bor =
<szeder.dev@gmail.com> a =C3=A9crit :
>=20
> On Tue, Dec 17, 2019 at 05:07:42AM +0000, Philippe Blain via =
GitGitGadget wrote:
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>=20
>> Currently the line-log functionality (git log -L) only supports
>> displaying patch output (`-p`, its default behavior) and suppressing =
it
>> (`-s`). A check was added in the code to that effect in 5314efaea =
(line-log:
>> detect unsupported formats, 2019-03-10) but the documentation was not
>> updated.
>>=20
>> Explicitly mention that `-L` implies `-p`, that patch output can be
>> suppressed using `-s`, and that all other diff formats are not =
allowed.
>>=20
>> Additionnally, mention that the ':<funcname>' form implies =
`--function-context`.
>>=20
>> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>> ---
>> Documentation/git-log.txt | 6 +++++-
>> Documentation/gitk.txt    | 6 +++++-
>> 2 files changed, 10 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
>> index b406bc4c48..1c52bf184d 100644
>> --- a/Documentation/git-log.txt
>> +++ b/Documentation/git-log.txt
>> @@ -77,7 +77,11 @@ produced by `--stat`, etc.
>> 	not give any pathspec limiters.  This is currently limited to
>> 	a walk starting from a single revision, i.e., you may only
>> 	give zero or one positive revision arguments.
>> -	You can specify this option more than once.
>> +	You can specify this option more than once. Implies `--patch`.
>> +	If ``:<funcname>'' is given, implies `--function-context`.
>=20
> ':<funcname>' doesn't imply '--function-context', but defines a line
> range starting at the function-name-looking line that first matches
> "funcname" and ending just before the next function-name-looking line,
> and line-log will then show that line range as context for each
> commit.  Although in many cases it shows diffs that look like as if
> '--function-context' were given, there are corner cases where they
> clearly differ, e.g. when following the history of a function that was
> at one point combined with the function directly below it.
>=20
> Note the two commits in the middle that show two functions although
> only one of them was actually modified in each of those commits:
>=20
>  $ git log --oneline -L:func:file.c
>  04b0c16 Combine funcA() and funcB() into func()
>=20
>  diff --git a/file.c b/file.c
>  --- a/file.c
>  +++ b/file.c
>  @@ -1,9 +1,4 @@
>  -int funcA()
>  +int func()
>   {
>  -	return A;
>  -}
>  -
>  -int funcB()
>  -{
>  -	return B;
>  +	return A + B;
>   }
>  ed0d4d9 Modify funcB()
>=20
>  diff --git a/file.c b/file.c
>  --- a/file.c
>  +++ b/file.c
>  @@ -1,9 +1,9 @@
>   int funcA()
>   {
>   	return A;
>   }
>=20
>   int funcB()
>   {
>  -	return b;
>  +	return B;
>   }
>  0d4e9b5 Modify funcA()
>=20
>  diff --git a/file.c b/file.c
>  --- a/file.c
>  +++ b/file.c
>  @@ -1,9 +1,9 @@
>   int funcA()
>   {
>  -	return a;
>  +	return A;
>   }
>=20
>   int funcB()
>   {
>   	return b;
>   }
>  c3f8a44 Add funcA() and funcB()
>=20
>  diff --git a/file.c b/file.c
>  --- /dev/null
>  +++ b/file.c
>  @@ -0,0 +1,9 @@
>  +int funcA()
>  +{
>  +	return a;
>  +}
>  +
>  +int funcB()
>  +{
>  +	return b;
>  +}
>=20
> Now compare that to the same two middle commits shown with '-p
> --function-context', which doesn't show the unmodified function:
>=20
>  $ git log --oneline -p --function-context file.c
>  04b0c16 Combine funcA() and funcB() into func()
>  diff --git a/file.c b/file.c
>  index 89571b3..33301ea 100644
>  --- a/file.c
>  +++ b/file.c
>  @@ -1,9 +1,4 @@
>  -int funcA()
>  +int func()
>   {
>  -	return A;
>  -}
>  -
>  -int funcB()
>  -{
>  -	return B;
>  +	return A + B;
>   }
>  ed0d4d9 Modify funcB()
>  diff --git a/file.c b/file.c
>  index 13592c8..89571b3 100644
>  --- a/file.c
>  +++ b/file.c
>  @@ -5,5 +5,5 @@ int funcA()
>=20
>   int funcB()
>   {
>  -	return b;
>  +	return B;
>   }
>  0d4e9b5 Modify funcA()
>  diff --git a/file.c b/file.c
>  index 11e1e87..13592c8 100644
>  --- a/file.c
>  +++ b/file.c
>  @@ -1,6 +1,6 @@
>   int funcA()
>   {
>  -	return a;
>  +	return A;
>   }
>=20
>   int funcB()
>  c3f8a44 Add funcA() and funcB()
>  diff --git a/file.c b/file.c
>  new file mode 100644
>  index 0000000..11e1e87
>  --- /dev/null
>  +++ b/file.c
>  @@ -0,0 +1,9 @@
>  +int funcA()
>  +{
>  +	return a;
>  +}
>  +
>  +int funcB()
>  +{
>  +	return b;
>  +}

