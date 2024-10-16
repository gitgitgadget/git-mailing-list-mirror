Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71D0156E4
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 06:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729058714; cv=none; b=ehSkVl46ar9KdsSVKJ+MTp7t3itg9ZPxcCL5Fl/oc0DT/bVXfwpHLJ9x0ARP6UunU/h7tm3vxsqu4Nb1ww7NX5QBJfeeVXNO7ase4cghdj0+YwVrp9OrvFVlLaVBtNLLVY8jyvdLm1peh5b8i5Kc7ym+Sk+kt5N1Z3GSO7MYdls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729058714; c=relaxed/simple;
	bh=oC5oM2k1I3hMlLfaBLb4YEwzXBNoJQ1YvXuN+2uzxkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T81cmcAgHeHgF0pG4o97PBkc89WZKtv8aHsbcTDeMaVgcdE75DVypAoPPXJvcjS+9JSDGY4D5OvM6LOjiFEJ91xniIb6VqaCDXXl5mgd+jfyX6FfQZ6XJlGr59HAOwX8lxGgPso8yaT5Y1rCOe5mR//8rWgCRz+q7sCyy0t7Yy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=De9u2HC9; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="De9u2HC9"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e7e73740so3171485e87.3
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 23:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729058711; x=1729663511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBjGIHEegJPy8rwZPOR0o9PeSyDXisDlfar3ja/DaTM=;
        b=De9u2HC9yEzRIk+ZMQakFp9sVdB21cwWxjTiCibOCYb0XHyHtHR7q19+Jzqy2MfU7T
         JNU5imJI4jUTyz6SZ6xXxLNg5u+ROv4nnkV5A2gFUQhSDqQaR9YHBWvFfuNgrGGsNQ/3
         ZW8GwhNsJfeGxN573qjlS9kJopoOq/KLEMZeD9Wlqe7cQn167xvUoBusuKW+9DNhS72Q
         7K5ylw8jSenKwI5dEa/dSSqwg7xB6fGliqHOWK4/CQFW1g9wM4i2cIE2WpGN6rwXPKRZ
         SKiLbLH4IDCQe3aa9sh7bx5KtNtsaqbpnp5YzM0MVn9BgSRxC+R0Lu0o5IRaFUITng+y
         dC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729058711; x=1729663511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBjGIHEegJPy8rwZPOR0o9PeSyDXisDlfar3ja/DaTM=;
        b=XrTNzOgi3VzeJGSpX9fnQDkpGjKGyC81H0fx96BknQDR24WouOFKgtgqj+CIwg4YgI
         KAg8r8fZ/LMZGoKgaFdw0+bN8v35WzE1R3H1fY1UwNIV2aMmnvFkGZlkNTTqyePaKu5d
         zQ7L1KJiind4pmHTcy76Ja7Kft2XMEE6Lx1EKJK6XQma1xOfbwuVqbWPVlGOhxBF3Fd1
         lF235K+EB3Xw8XUC1FzZn+KsFQbf8uhbhsnlJ/gTyMre5jTJd7rCMD/I328OgZ8+HG0s
         LYK5ClbqCW6VBkXAr3N7DCWE/XoSQ84nWYUSbUTQt5qgItEOU/f9JrNgkHV+0sxZPD7U
         lw+w==
X-Forwarded-Encrypted: i=1; AJvYcCVyNqoYQzxMD+fJ69B+hACN6Wk1qBX6cm6oWur4QyEzR1PuV/WbFMGBH+LKTzwYnHzHv/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzu08PwpJSToRGQXBCJ8cG+gieli8XRIJ6FrVB1foljMrYmXSP
	IhA0hkaJzbrINuiArDD98Ou0SX2zeDgWngj1aLShx31NpuOEjo28kibTu0sjU5jVVu8rga3yofA
	hvH4myfzw1ZtAOIP6rgJOVEs6B58=
X-Google-Smtp-Source: AGHT+IGwNfP9jiO9FZzk2/iJo1eyopruge99HQl2aOQx0Xf/QNIGHGGhphFx/rcSpQNSjQQ2RKdjbASr1fGLAcTuJk4=
X-Received: by 2002:a05:6512:3d23:b0:539:d428:fbf2 with SMTP id
 2adb3069b0e04-539da3c58f6mr8597742e87.13.1729058710573; Tue, 15 Oct 2024
 23:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
 <pull.1809.v2.git.1728707867.gitgitgadget@gmail.com> <4ed930cab1b7f5e9738e73c7b9374d927a8acd94.1728707867.git.gitgitgadget@gmail.com>
 <CAPig+cR4WbcDDav0cdXxOMC-EDe2ipWxEzB+0C7zbFjvY_kXtg@mail.gmail.com>
In-Reply-To: <CAPig+cR4WbcDDav0cdXxOMC-EDe2ipWxEzB+0C7zbFjvY_kXtg@mail.gmail.com>
From: Abhijeetsingh Meena <abhijeetsingh.github@gmail.com>
Date: Wed, 16 Oct 2024 11:34:59 +0530
Message-ID: <CAAirc3hF2L1U7ZoQM0pYYiqtnA28o=78MyyxR9eK7GXN9Jfr1A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] blame: respect .git-blame-ignore-revs automatically
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Abhijeetsingh Meena via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Phillip Wood <phillip.wood123@gmail.com>, 
	Abhijeetsingh Meena <abhijeet040403@gmail.com>, "me@ttaylorr.com" <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

Thank you for your thoughtful feedback on v2 of the patch.
Before I proceed with v3, I'd like to address some of the
non-code-related questions and seek your input.

> Presumably this consults ".git-blame-ignore-revs" in the top-level
> directory (as you intended) rather than ".git-blame-ignore-revs" in
> whatever subdirectory you happen to issue the command because the
> current-working-directory has already been set to the top-level
> directory by the time cmd_blame() has been called, right?

Yes, it seems that the current-working-directory is set to the root of
the repository,
as I tested this behaviour locally. The .git-blame-ignore-revs file in
the root worked
as expected, while a similar file in a subdirectory did not.


> But that leads to the next question. Should automatic consulting of
> ".git-blame-ignore-revs" be restricted to just the top-level
> directory, or should it be modeled after, say, ".gitignore" which may
> be strewn around project directories and in which ".gitignore" files
> are consulted rootward starting from the directory in which the
> command is invoked. My knee-jerk thought was that the ".gitignore"
> model may not make sense for ".git-blame-ignore-revs", but the fact
> that `git blame` can accept and work with multiple ignore-revs files
> makes me question that knee-jerk response.

I think both approaches have their merits:

1. Single file
*Purpose:* Having a single .git-blame-ignore-revs file aligns with the idea
of globally ignoring revisions, making it easier for maintainers to
control irrelevant commits.
*Simplicity:* Keeping the file in the root ensures centralized management,
simplifying configuration.

2. Multiple files:
*Large repositories:* In large monorepos, different teams working in separa=
te
subdirectories may want to manage their own ignored revisions. Multiple fil=
es
would offer flexibility, particularly for modular projects or those
with distinct submodules.
*Flexibility:* Subdirectory-level .git-blame-ignore-revs files could
allow users to
 fine-tune blame results for their specific areas, especially when
local refactors
are limited to certain parts of the codebase.

Given this, I would like to know your suggestions, as I=E2=80=99m not too
experienced with
the user workflows and what would be more helpful to them. For now, I think=
 we
should stick with the single .git-blame-ignore-revs file at the top level.
However, we could keep the option open for future enhancements, allowing
multiple files to be consulted by setting a configuration flag if a
specific use case arises.


> Is the all-or-nothing behavior implemented by this patch desirable? If
> so, should the command warn or error out if the user gives conflicting
> options like --ignore-revs-file and --override-ignore-revs together?
>
> A common behavior of many Git commands when dealing with options is
> "last wins", and following that precedent could make this new option
> even much more useful by allowing the user to ignore project-supplied
> ignore-revs but still take advantage of the feature with a different
> set of ignore-revs that make sense to the local user. For instance:
>
>     git blame --override-ignore-revs --ignore-revs-file=3Dmy-ignore-revs =
...

I don=E2=80=99t think the all-or-nothing approach is ideal. Based on Philli=
p's
suggestions and
Kristoffer's conceptual workflow, I explored using `git_config_set` to
set `blame.ignoreRevsFile`
configuration. This would integrate well with existing configuration
logic and provide greater flexibility.

With `git_config_set`:

git blame hello.txt
would consult the default .git-blame-ignore-revs file.

git blame --no-ignore-revs-file hello.txt
would disable the default ignore file.

git blame --no-ignore-revs-file --ignore-revs-file=3Dignore-list hello.txt
would allow the user to specify a custom ignore list while bypassing
the global list,
offering the flexibility you suggested.


> What is this test actually checking? It doesn't seem to use
> --override-ignore-revs at all.

Actually, I used the short form -O to represent --override-ignore-revs
in this test.

Thank you again for your time and feedback. I look forward to your thoughts=
 on
these points before finalising the next patch revision.

Best regards,
Abhijeet

On Sat, Oct 12, 2024 at 11:37=E2=80=AFAM Eric Sunshine <sunshine@sunshineco=
.com> wrote:
>
> On Sat, Oct 12, 2024 at 12:38=E2=80=AFAM Abhijeetsingh Meena via GitGitGa=
dget
> <gitgitgadget@gmail.com> wrote:
> > git-blame(1) can ignore a list of commits with `--ignore-revs-file`.
> > This is useful for marking uninteresting commits like formatting
> > changes, refactors and whatever else should not be =E2=80=9Cblamed=E2=
=80=9D.  Some
> > projects even version control this file so that all contributors can
> > use it; the conventional name is `.git-blame-ignore-revs`.
> >
> > But each user still has to opt-in to the standard ignore list,
> > either with this option or with the config `blame.ignoreRevsFile`.
> > Let=E2=80=99s teach git-blame(1) to respect this conventional file in o=
rder
> > to streamline the process.
> >
> > Signed-off-by: Abhijeetsingh Meena <abhijeet040403@gmail.com>
> > ---
> >  builtin/blame.c                      |  8 ++++++++
> >  t/t8015-blame-default-ignore-revs.sh | 26 ++++++++++++++++++++++++++
> >  2 files changed, 34 insertions(+)
>
> This change should be accompanied by a documentation update, I would thin=
k.
>
> > diff --git a/builtin/blame.c b/builtin/blame.c
> > @@ -1105,6 +1105,14 @@ parse_done:
> > +       /*
> > +       * By default, add .git-blame-ignore-revs to the list of files
> > +       * containing revisions to ignore if it exists.
> > +       */
> > +       if (access(".git-blame-ignore-revs", F_OK) =3D=3D 0) {
> > +               string_list_append(&ignore_revs_file_list, ".git-blame-=
ignore-revs");
> > +       }
>
> A couple style nits and a couple questions...
>
> nit: drop the braces around the one-line `if` body
>
> nit: this project uses `!foo(...)` rather than `foo(...) =3D=3D 0`
>
> Presumably this consults ".git-blame-ignore-revs" in the top-level
> directory (as you intended) rather than ".git-blame-ignore-revs" in
> whatever subdirectory you happen to issue the command because the
> current-working-directory has already been set to the top-level
> directory by the time cmd_blame() has been called, right?
>
> But that leads to the next question. Should automatic consulting of
> ".git-blame-ignore-revs" be restricted to just the top-level
> directory, or should it be modeled after, say, ".gitignore" which may
> be strewn around project directories and in which ".gitignore" files
> are consulted rootward starting from the directory in which the
> command is invoked. My knee-jerk thought was that the ".gitignore"
> model may not make sense for ".git-blame-ignore-revs", but the fact
> that `git blame` can accept and work with multiple ignore-revs files
> makes me question that knee-jerk response.
>
> > diff --git a/t/t8015-blame-default-ignore-revs.sh b/t/t8015-blame-defau=
lt-ignore-revs.sh
> > new file mode 100755
>
> Let's avoid allocating a new test number just for this single new
> test. Instead, the existing t8013-blame-ignore-revs.sh would probably
> be a good home for this new test.
>
> > +test_expect_success 'blame: default-ignore-revs-file' '
> > +    test_commit first-commit hello.txt hello &&
> > +
> > +    echo world >>hello.txt &&
> > +    test_commit second-commit hello.txt &&
> > +
> > +    sed "1s/hello/hi/" <hello.txt > hello.txt.tmp &&
>
> style: drop space after redirection operator
>
>     sed "1s/hello/hi/" <hello.txt >hello.txt.tmp &&
>
> > +    mv hello.txt.tmp hello.txt &&
> > +    test_commit third-commit hello.txt &&
> > +
> > +    git rev-parse HEAD >ignored-file &&
> > +    git blame --ignore-revs-file=3Dignored-file hello.txt >expect &&
> > +    git rev-parse HEAD >.git-blame-ignore-revs &&
> > +    git blame hello.txt >actual &&
>
> I would suggest copying or renaming "ignored-file" to
> ".git-blame-ignore-revs" rather than running `git rev-parse HEAD`
> twice. This way readers won't have to waste mental effort verifying
> that the result of `git rev-parse HEAD` isn't intended to change
> between invocations.
