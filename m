Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655901798C
	for <git@vger.kernel.org>; Sat,  5 Oct 2024 18:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728152579; cv=none; b=IB9tYystLdhJTJPd6uRmjMLzYml+CMnrHUJ0bB+fcN5c4gghFz43nq7y/TxQYabAvt++Cp4r0n36girs2oXP+EBR1XZfEiMFr8/WPnkrqmqbeCHdPHSg9PZN+nY5ZjRQPiav6CZMiD8imZfAyUjtxDWneAVUPc6OPQ3PvkubDc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728152579; c=relaxed/simple;
	bh=97zKs197AYGj4dbdijGy0UmoO/slk1RCKUBwzF5vrN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nwT8zPh6IKfnJv7xkFPfiAAnbWDcU7WF/pSBXEBg+N3X16cmCeeus1I2YGI249VkwqXUc9XAPvC31ujGDk+mWm/wt2XO+pXCq4HU5q7uQHbX4QURdtv9JJ8KITH48yKK0UHmq52tOMVerQ4iBzr8gwHM7eWOOuWxL+tEgtCuj4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqiReO1i; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqiReO1i"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d100e9ce0so351985766b.2
        for <git@vger.kernel.org>; Sat, 05 Oct 2024 11:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728152576; x=1728757376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97zKs197AYGj4dbdijGy0UmoO/slk1RCKUBwzF5vrN8=;
        b=DqiReO1iPVd8VcONQzD8AqgZ22PAuT54DkRQIw2hS3cg0PXLFxF9uo6WmMAWogbTEu
         bPXsWTAjBk1H7JCG5WIEGKswMRPSU8wUH7mB+IaUWHXm3kVVgGsprUObG9N8xRB/JUpg
         6fuk0PPLDpLk6frC4GaFLJ65Fybd/sIF5+9yxjcuU0P3dKNJJTPdP43NW5/SgHZWGGNv
         po+IbIKy3RWxAfYqTQzxniso2BsetKgEuI24+CJ5idAlEBrUsxCFA2OWXhmOGMssAheE
         Iw3YDqjnjXIob/0DUM3wpNTn0tWB35vVFR3U+a5jGr1KcIu0NYtb3kba32tkeKuRnaUd
         b9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728152576; x=1728757376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97zKs197AYGj4dbdijGy0UmoO/slk1RCKUBwzF5vrN8=;
        b=RLwWfWb6RoMTK8BIN64BNISbzWvTaO4PQYxjSlhk3uJnX2wbcT1Nl3dcubrSnmn2of
         eKrud6QDK0RZm8MBu9tp7Q7FUUqpt9k4P2kQYHI45uIu0/Wh0R770894ZcGFmqdDN8Wg
         ySWF0vIzXGZY6g414UyzJMQqw9yv0Mmf9oNch8Pk1UfkWUj6Wz71WKXF3I8JPXddTIQd
         91r342cG2W8o1Zj0w3VBv1r4jHqMUwToplYdbtrh+mbkHclEFRHxRjgfJLdMiq9U5mUg
         VOjelu1BHTFoS0YZ8miyPmdfZAC8gTraNlf+KlWRXKuJTgO4HCtsgIR7ULbRRGeFHZWU
         avPg==
X-Forwarded-Encrypted: i=1; AJvYcCUBs3ykffNZwxCnlxpiBlOtzDj20c7700vwvXXPIMWIofD9WLbq6MsVdrQX3pGBsMiP0ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEYvvjxGArD7IwsS48EpCmEXhPqsLuAdzhdnXVDMfBaBZQpIfY
	XpMa4YeXuzJKlEUx+hXQvTIKbo7q4hhsjQuXdE6dYjChldMJqoQId5ze61dFmzHGRTq8WmEo3oQ
	+9T8yxLScwBJ8dXLdyM09yT0DyCQ=
X-Google-Smtp-Source: AGHT+IFAu6WVVO8o5awXG30Fm8DeY1KDo7m7lbybTsUG0NsQrJavtflGtwGZM4H9eK3HgEZobPMj8ayaqa4XQba7Fro=
X-Received: by 2002:a17:907:97c3:b0:a99:4025:82e1 with SMTP id
 a640c23a62f3a-a9940265054mr226122366b.41.1728152575494; Sat, 05 Oct 2024
 11:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSxiM-+4VFsHkBW8Y3ncY-kjxvAXSOdSom=zBQzTNd-JK+HxA@mail.gmail.com>
 <Zv0-Wv03hSea_Tje@pks.im> <CAPSxiM_fTMCzXg3OrcbJrn=UskyCaR3D=xgR4d6PrnnAdoYcCQ@mail.gmail.com>
In-Reply-To: <CAPSxiM_fTMCzXg3OrcbJrn=UskyCaR3D=xgR4d6PrnnAdoYcCQ@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 5 Oct 2024 20:22:43 +0200
Message-ID: <CAP8UFD2QN59LVAJgqwj5V6dJ9sTCHjdDG=XtuWcFkgANmfvnrQ@mail.gmail.com>
Subject: Re: [Outreachy] Potential intern.
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Usman,

On Sat, Oct 5, 2024 at 6:42=E2=80=AFPM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> Hi Patrick,
>
> Following this, I have gone through [1], [2] and some other resources.
>
> I was able to get potential three interesting MiniProject which I can
> work on. I have also checked through the mailing list to ensure no one
> is working on any of the particular file. As advised, I am sending
> this just to be sure if it=E2=80=99s worth doing and if it=E2=80=99s appr=
opriate for a
> miniproject. I am sending three MiniProjects so I can have one to work
> with in case any of them is not appropriate.

Great, thanks for your interest in working on Git!

> 1. Use test_path_is_* functions in test scripts
> An approved sample -
> https://lore.kernel.org/git/20240304095436.56399-2-shejialuo@gmail.com/
>
> Two email threads of discussion and feedback from maintainers.
>
> https://lore.kernel.org/git/CAPig+cR2-6qONkosu7=3DqEQSJa_fvYuVQ0to47D5qx9=
04zW08Eg@mail.gmail.com/
> https://public-inbox.org/git/CAPig+cRfO8t1tdCL6MB4b9XopF3HkZ=3D=3DhU83AFZ=
38b-2zsXDjQ@mail.gmail.com/
>
> Two potential test files which I saw that I can work one.
>
> t/t7003-filter-branch.sh
>
>
> test_expect_success 'test that the file was renamed' '
> test D =3D "$(git show HEAD:doh --)" &&
> ! test -f D.t &&
> test -f doh &&
> test D =3D "$(cat doh)"
> '

Yeah, this looks like a good instance where test_path_is_* functions
could be used.

> t/t2003-checkout-cache-mkdir.sh
>
> test_expect_success 'use --prefix=3Dpath2/' '
> rm -fr path0 path1 path2 &&
> mkdir path2 &&
> git checkout-index --prefix=3Dpath2/ -f -a &&
> test -f path2/path0 &&
> test -f path2/path1/file1 &&
> test ! -f path0 &&
> test ! -f path1/file1
> '

This looks like another good instance.

> These two are asserting that if a file exists, it can be changed to
> test_file_exist

There is no test_file_exist() function in our test framework as far as
I can see. I think you should use test_path_is_file() or
test_path_is_missing() to replace `test -f ...` and ` test ! -f ...`
respectively.

> 2. Avoid suppressing git=E2=80=99s exit code in test scripts
>
> Sample email thread about the same issue.
> https://public-inbox.org/git/pull.885.v2.git.git.1603032125151.gitgitgadg=
et@gmail.com/
>
> First file - t/t6050-replace.sh
> code sample
> test_expect_success 'replace the author' '
> git cat-file commit $HASH2 | grep "author A U Thor" &&
> R=3D$(git cat-file commit $HASH2 | sed -e "s/A U/O/" | git hash-object
> -t commit --stdin -w) &&
> git cat-file commit $R | grep "author O Thor" &&
> git update-ref refs/replace/$HASH2 $R &&
> git show HEAD~5 | grep "O Thor" &&
> git show $HASH2 | grep "O Thor"
> '

Yeah, I think it would be a good change to remove the pipes after git
commands in that code.

> Second File - t/t3404-rebase-interactive.sh
> code sample that needs improvement
>
> test_expect_success 'retain authorship' '
> echo A > file7 &&
> git add file7 &&
> test_tick &&
> GIT_AUTHOR_NAME=3D"Twerp Snog" git commit -m "different author" &&
> git tag twerp &&
> git rebase -i --onto primary HEAD^ &&
> git show HEAD | grep "^Author: Twerp Snog"
> '

Yeah, here too, I think it would be a good change to remove the pipes
in that code.

> 3. Modernise test.
> Description
> https://lore.kernel.org/git/CAPig+cQpUu2UO-+jWn1nTaDykWnxwuEitzVB7PnW2SS_=
b7V8Hg@mail.gmail.com/
> Sample code t/t7611-merge-abort.sh test_expect_success 'Reset index
> (but preserve worktree changes)' '
> git reset "$pre_merge_head" &&
> git diff > actual &&
> test_cmp expect actual
> '

From the sample, it's not clear that the code would benefit a lot from
being modernized, so I would recommend focusing on improving one of
the other code you mention above.

Thanks,
Christian.
