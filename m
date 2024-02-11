Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731A35C614
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707674314; cv=none; b=RqAGu8dasDMT5YSi9FahRYTL4z3/x5aKdz2W8n/cHEAYbuMp/ddXxwyxOSJoLCY3g5gy2NmaTfKPjIciTwT1XF3oy2QzU5LapjHubnvQbzmTlVvjxM3WKEdaau3tmyh94N9Y11qeouE2YfpzHqguoVNiRCWYXGcJB90NE1PAhhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707674314; c=relaxed/simple;
	bh=MAsYW/4Oz/lhAzzSjbNyPI6B0YA0qYnF3wvy/sQUIQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kx1ZaiY+kTagYvR2/NmYceZZjLedQTn3u4FTtlxCWHcLc2ZaK2KEeIZvqcLp4UG537PEfLW/SnZ0jmpva4KrEurd0nrxWJkJo2sorjT5aKn3Bozj17zOGogcvQCgCdU0kFRNTAqnWU2N5BI10VzQ0cHvhu2MX+M2HfogrECH0YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-785d53242e6so17339485a.2
        for <git@vger.kernel.org>; Sun, 11 Feb 2024 09:58:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707674311; x=1708279111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkORH69jfYcj9s9uxPFCGoZWiX4YOXcFInnV2APSFLk=;
        b=wYMS+simxNQh96mr9bb+/8nZZeDCSjr8Sfgsh1t2d9yraCEEDDeotLH1yYYcWVkEMD
         jYg4+a7Jjp23RECBE4WeIbWm4GitZT8RmO/vQIW2lkI3geDKXzTYR6bDyhUD6CLUgYNh
         9JwEZSmae9FRbneTEGHPwOW9pR9qCen1fcw4wwNSx8eaNzwLD/uu343KPkm8Ibjoy43w
         L9vZUWvlxqulmKpTnlqDYHKrAQdT6E0d3Y0UI+goJ41VbvD/XkBASX+sqfzok7hjwEKC
         LBfueDk0Ga6RoL25D0tK7kaT7ZcwMt+xCAqMu5R2isRxqY9ywf06q23kWONJbjc0bMsY
         TxBA==
X-Gm-Message-State: AOJu0YyBXu34YSsJgb4usLwHMcSlR7YiTEn3FIY8/kCrP3rGEA6Wu5wT
	U5zzqZjPrrZOdCzkcvqyWrxCar2uDCRPA/+lTZZyPDBijXMK8FdOhIk5fRdZiE79qZj2lEonjq7
	l2TAbp1VAU5MdStv0syjxbDHnNJk=
X-Google-Smtp-Source: AGHT+IFaw6ywd/eQdQmOiFc8GofUkAR/1QEH++bjWvaRuVWuSbuLB+bLi0JRtdffPYYc0nxBaT43TVW6TSg5RAUpE1M=
X-Received: by 2002:a0c:cc04:0:b0:68c:a4a8:b134 with SMTP id
 r4-20020a0ccc04000000b0068ca4a8b134mr4744536qvk.45.1707674311340; Sun, 11 Feb
 2024 09:58:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1661.git.1707663197543.gitgitgadget@gmail.com>
In-Reply-To: <pull.1661.git.1707663197543.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 11 Feb 2024 12:58:19 -0500
Message-ID: <CAPig+cR2jS9fhM8dbWy8pOPcUryv78qYXaB+Lbxjb3kkkqBqSQ@mail.gmail.com>
Subject: Re: [PATCH] t9146: replace test -d/-f with appropriate test_path_is_* function
To: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Chandra Pratap <chandrapratap376@gmail.com>, 
	Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 9:53=E2=80=AFAM Chandra Pratap via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The helper functions test_path_is_* provide better debugging
> information than test -d/-e/-f.
>
> Replace "! test -d" with "test_path_is_missing" at places where
> we check for non-existent directories.
>
> Replace "test -f" with "test_path_is_file" and "test -d" with
> "test_path_is_dir" at places where we expect files or directories
> to exist.

The aim of this patch makes sense, but the implementation needs some
refinement...

> diff --git a/t/t9146-git-svn-empty-dirs.sh b/t/t9146-git-svn-empty-dirs.s=
h
> @@ -20,7 +20,7 @@ test_expect_success 'empty directories exist' '
>                 for i in a b c d d/e d/e/f "weird file name"
>                 do
> -                       if ! test -d "$i"
> +                       if test_path_is_missing "$i"
>                         then
>                                 echo >&2 "$i does not exist" &&
>                                 exit 1

The point of functions such as test_path_is_missing() is to _assert_
that some condition is true, thus allowing the test to succeed; if the
condition is not true, then the function prints an error message and
the test aborts and fails.

    test_path_is_missing () {
        if test -e "$1"
        then
            echo "Path exists:"
            ls -ld "$1"
            false
        fi
    }

It is meant to replace noisy code such as:

    if ! test -f bloop
    then
        echo >&2 "error message" &&
        exit 1
    fi &&
    other-code

with much simpler:

    test_path_exists bloop &&
    other-code

So, the changes made by this patch are incorrect in two ways...

First, the patch retains code which prints an error message even
though this code becomes redundant since the test_path_foo() functions
already take care of printing the error message.

Second, and more problematic, the patch incorrectly inverts the sense
of what is being tested. For instance, the title of this test is
"empty directories exist", and the body of the test asserts that the
empty directories _do_ exist, but the patch changes the condition to
assert that the directories do _not_ exist, which is wrong.

Taking these observations into account, this test should become:

    test_expect_success 'empty directories exist' '
        (
            cd cloned &&
            for i in a b c d d/e d/e/f "weird file name"
            do
                test_path_exists "$i" || exit 1
            done
        )
    '

Many of the other changes made by this patch suffer similar problems

> @@ -138,16 +138,16 @@ test_expect_success 'git svn gc-ed files work' '
>                 : Compress::Zlib may not be available &&
> -               if test -f "$unhandled".gz
> +               if test_path_is_file "$unhandled".gz
>                 then
>                         svn_cmd mkdir -m gz "$svnrepo"/gz &&
>                         git reset --hard $(git rev-list HEAD | tail -1) &=
&

This change is wrong/undesirable for a different reason. Taking into
account what was said above about test_path_is_file() being an
_assertion_ that some condition is true, coupled with the comment
above this `if` statement which says "Compress::Zlib may not be
available", then this `test -f` is legitimately part of the
control-flow of the function. It is not a mere assertion. Thus,
replacing it with the assertion function test_path_is_file() breaks
the test for the case when Compress::Zlib is not available.

> -                       test -f "$unhandled".gz &&
> -                       test -f "$unhandled" &&
> +                       test_path_is_file "$unhandled".gz &&
> +                       test_path_is_file "$unhandled" &&

These replacements are correct in that they replace the _assertion_
`test -f` with the equivalent assertion `test_path_is_file`.
