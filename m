Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD9A190688
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 11:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729337108; cv=none; b=nxnKTm0sEmfewmvcTUwTL0Tb6JBEL4ElNhqDmGgzoWegXdv6JOhhRbEeMqPTOSWvhsKkkZKcMcuzR3iAGK0ZbKe4wClV1q86YOqj25dRWlFy5E+VA+cUTNn9X9Z+6uA1eO6AppOpTb8TeJb2dU+ExCKb3l5yyW6BNRzZNihIiJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729337108; c=relaxed/simple;
	bh=pdDRjp9XH5YYPqo6wMjp6Y9h7knquKj5YkHyb9M2DPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbRrdFtWDtt9RE2cWcgHOlEUJ034nuHqLOAtkQNQJ/JdbOot6RNTXtKCMgfOSLrzVlUBaeZKNmXFE5dCuQW2wi6xPR38P5X8d336ChjNVfRZuZHRZEn6T7BPjgRVX0/KN1oYljm+yycppe+n8EaXRTTjNpuEvR+qTzWsMB05Gz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaAe6pwm; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaAe6pwm"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d462c91a9so2075856f8f.2
        for <git@vger.kernel.org>; Sat, 19 Oct 2024 04:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729337105; x=1729941905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mWzK9xU8hKq9J9Kty3ul365VnyBR2N7GhsieiOjmU8=;
        b=DaAe6pwm5xNW5ulk+xBy90WbhXCL8n1p8pHwdpxUoirOVt/zir/o04GCxH7nWLIl8T
         kdkKdOALYH28ImTDRbnNveEvp8xoH6gZ79M4129hgr1RomkhJ+X//QWvG007TKjPkDq3
         YhE+Crv+WRz+Dk8d8JaVQGgILFTNNfAbY08HJQOwoVCwyLpExuyTilEZy4GfTAN7gzFW
         1IU7syXDlNttr5Io786fCvVfWEuzAQlsQ3uKYFAd96oIoh4lN8nNcPvAignLhyw47C1m
         5shCR+7EK73ep78uy1iMa8tNnafeLs8ZWCzIgJ5SBmsXDsnfI4RUk9vZP1+7fsBTxHAd
         46rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729337105; x=1729941905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mWzK9xU8hKq9J9Kty3ul365VnyBR2N7GhsieiOjmU8=;
        b=lL0ohQj9ykXva/y7AeUJuO4M1GxW/kuvEomsA0jZX0GrfffyyU1D90L7FVneZl3duJ
         byOZMiFQ0ZeGSTZa1CZ2iN5KiWIAZ/WL0/uyhl+gy1iy8HTnNzi8xvoq11gMJfvIRid5
         F1mBcEvFNCaqgCvw+nDoPEgzBWmNMB3KFgZVTPfikLVv5kSaiXo5GkDGIeW3NwCZpG6w
         Rdb8LM1XtDqMWXGilem3KSAY3QpAp41YGeHxFsbpnolPaHJtxoiBL52u69Gh1DcymTal
         kHB56Vyy4G0L4LF0dl0mpEP4detxZa/qptxt4aH1mhTxeIzd++mGeDV8+99Ho2QEUkgM
         Rf6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlpdsxSSLiyrIVkqLLwuj2lGiq7nEIOsuCoMnD2sRFoAoX0+v28SHozGPmPLCk4lEu0Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl6Eaj/4EdAT/qIHBKw0RrwoIo8SjRZAH6P1BXQSjm4X5GOXWG
	godAmmRgyzywL6C1ru5VK/xBD/JeYo0J9yepmXypqRuCP2NC6jl7eXSHq1vLQZJunIZQ/uwtVy5
	gg6deloVj2ZFD1Z3O2GN4Jq7873Q=
X-Google-Smtp-Source: AGHT+IE/rS3sLlAU3j70sxqrLyWRT3ev+5ASlO/Mxkp15UeGT/Yi3zOri3nrKxK//UqhgVXOAp424BzGE86VqWEwOIA=
X-Received: by 2002:a5d:6b85:0:b0:37d:39aa:b9f4 with SMTP id
 ffacd0b85a97d-37eab6ee783mr3521905f8f.26.1729337104427; Sat, 19 Oct 2024
 04:25:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1817.git.1729296853800.gitgitgadget@gmail.com>
 <ZxL_oAXN5KQ4FVMc@tapette.crustytoothpaste.net> <55176c6e-7ac1-46e6-affa-184307a0edf4@app.fastmail.com>
In-Reply-To: <55176c6e-7ac1-46e6-affa-184307a0edf4@app.fastmail.com>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Sat, 19 Oct 2024 12:24:55 +0100
Message-ID: <CADYq+fY=f5tKJJb0wfmGwTNzzqkMnBNzFZedUxuHhuPNNSgNfQ@mail.gmail.com>
Subject: Re: [PATCH] notes: teach the -e option to edit messages in editor
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Josh Soref <gitgitgadget@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 12:04=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> Hi brian and Samuel
>
> On Sat, Oct 19, 2024, at 02:38, brian m. carlson wrote:
> > On 2024-10-19 at 00:14:13, Samuel Adekunle Abraham via GitGitGadget wro=
te:
> >> +test_expect_success '"git notes add" with -m/-F invokes the editor wi=
th -e' '
> >> +    test_commit 19th &&
> >> +    GIT_EDITOR=3D"true" git notes add -m "note message" -e &&
> >> +    git notes remove HEAD &&
> >> +    echo "message from file" >file_1 &&
> >> +    GIT_EDITOR=3D"true" git notes add -F file_1 -e &&
> >> +    git notes remove HEAD
> >> +'
> >
> > Maybe I don't understand what this is supposed to be testing (and if so=
,
> > please correct me), but how are we verifying that the editor is being
> > invoked?  If we're invoking `true`, then that doesn't change the messag=
e
> > in any way, so if we suddenly stopped invoking the editor, I don't thin=
k
> > this would fail.
>
> I also didn=E2=80=99t understand these tests.
>
> There is this test in this file/test suite which tests the negative
> case:
>
>     test_expect_success 'empty notes do not invoke the editor' '
>             test_commit 18th &&
>             GIT_EDITOR=3D"false" git notes add -C "$empty_blob" --allow-e=
mpty &&
>             git notes remove HEAD &&
>             GIT_EDITOR=3D"false" git notes add -m "" --allow-empty &&
>             git notes remove HEAD &&
>             GIT_EDITOR=3D"false" git notes add -F /dev/null --allow-empty=
 &&
>             git notes remove HEAD
>     '
>
Thank you Kristoffer,

Yes incorrectly used this as a reference and I have however look
deeper into the implementation
of the write_scripts function and the fake_editor file for better understan=
ding.

> And this works because the commands would fail if the editor was invoked:
>
>     error: there was a problem with the editor 'false'
>
> But this doesn=E2=80=99t work for `true`.
>
> > Maybe we could use something else as `GIT_EDITOR` instead.  For example=
,
> > if we did `GIT_EDITOR=3D"perl -pi -e s/file/editor/" git notes add -F f=
ile_1 -e`
> > (with an appropriate PERL prerequisite), then we could test that the
> > message after the fact was "message from editor", which would help us
> > verify that both the `-F` and `-e` options were being honoured.
> > (Similar things can be said about the tests you added below this as
> > well.)
>
> This file defines a `fake_editor`:[1]
>
>     write_script fake_editor <<\EOF
>     echo "$MSG" >"$1"
>     echo "$MSG" >&2
>     EOF
>     GIT_EDITOR=3D./fake_editor
>     export GIT_EDITOR
>
> And it looks like this is how it is used:
>
>     test_expect_success 'create notes' '
>             MSG=3Db4 git notes add &&
>             test_path_is_missing .git/NOTES_EDITMSG &&
>             git ls-tree -r refs/notes/commits >actual &&
>             test_line_count =3D 1 actual &&
>             echo b4 >expect &&
>             git notes show >actual &&
>             test_cmp expect actual &&
>             git show HEAD^ &&
>             test_must_fail git notes show HEAD^
>     '
>
> So it seems that the new tests here should use the `test_cmp expect
> actual` style.

Thank you very much for the guide.
I will correct them and send a modified patch.

>
> =E2=80=A0 1: The different test files use both `fake_editor`, `fake-edito=
r`,
>     and `fakeeditor`.
>
> > Do you think there are any cases where testing the `--no-edit`
> > functionality might be helpful?  For example, is `git notes edit` ever
> > useful to invoke with such an option, like one might do with `git commi=
t
> > amend`?  (This isn't rhetorical, since the notes code is one of the are=
as
> > of Git I'm least familiar with, so I ask both because I'm curious and i=
f
> > you think it's a useful thing to do, then tests might be a good idea.)
>
> Yes, that is useful (both as a use-case and as a regression test[2]).
> git-notes(1) is often used to programmatically add metadata:
>
>     git show todo:post-applypatch | grep -C5 refs/notes/amlog
>
> (And this non-interactive example is not affected by this change since
> `-e` is required in order to invoke the editor)
>
> =E2=80=A0 2: I seem to recall a regression in how git-notes(1) chose to i=
nvoke
>    the editor or not
