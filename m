Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEYkuvtR"
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9332C10FB
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 07:28:22 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c871d566cfso22889441fa.3
        for <git@vger.kernel.org>; Fri, 24 Nov 2023 07:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700839701; x=1701444501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iK++JuCcU7wub2VBJwp4VbCNyBGeZYHIfbZ0fCLVuo=;
        b=FEYkuvtRO58tTVoY996+yPcE3vmZgXzpX8PfnYTb+pmXMHs4kesj6AFVsh+SkdIdeG
         S8MMqeDA3pASoegkBmfQB+ihDDC3glxCaynN1ojb7ClG3JJPHQQmGHtPQg04sAbcU8oB
         FVh1dVFAN9NQGPT4PQLBj6qu+XWgNmCJZY+iM34c+9RpRJZtGXzbQt2RHAMcqh/a5chZ
         dHeO6SnoswlodhIlEqphktlJlXFoMio+JYo2lQ33q7k5p2gVg63axQ0QDVAyWEs79Bv6
         x/S9qOLf+jf120uz8//Qpc18geFwQWs+H0gHOiPGuw0/yaxM+B/ZbK8iwUaP7g2bnDMK
         /1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700839701; x=1701444501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iK++JuCcU7wub2VBJwp4VbCNyBGeZYHIfbZ0fCLVuo=;
        b=hrxcftYu0s6NiWNlH6/4JzL7LI4NFZpNysqV5Y1ndMLNWSvpE+3ex0FgRLhRvICCZ2
         ga9bVdMvSdTu+I6rUuupmks/Oh7LlZDTajcD5aV2a8FgFcpYpsfs4mmoDq8dDlJVXyiW
         PG163ISztXzzD6OQVOWGua6T3Hu96y0xM+A9v0r6k4EItYPiqlgxtnCiMwcxc6i/Xzku
         qqDf/kN3fqkhchR3DEsYCPuiVSJ1oi2D79ob73iFwcnfoSLjXKTnFXeEgwao90pJOrvN
         tL/wtb0PnYSdKR6lkucNysGiqEJg0a3rwNjdCqaMMK2Zs4kRKE3ElrP1+0EEyeM28O1W
         xv6w==
X-Gm-Message-State: AOJu0Ywtk4r/XvvzSqGWiuiKzV7dYoFAK5/RI4lBFsS0p0m23dZBAJaU
	jkHR/fV4YLmRsoKyjnUowC2MkSHerHIBAeubD10=
X-Google-Smtp-Source: AGHT+IHG9EM1/xZhlVEop1I1HEj8RqLjl+1FzGGxwhYR66qdLfl/qFap9j6+6TC94Ww0grTrxsIPswQKDhuaqp6xEGY=
X-Received: by 2002:a2e:9549:0:b0:2bc:d6a8:1efd with SMTP id
 t9-20020a2e9549000000b002bcd6a81efdmr2271354ljh.39.1700839700343; Fri, 24 Nov
 2023 07:28:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1349.git.1700761448.gitgitgadget@gmail.com>
 <fe8669a3f4f05c186e497f870c7e7ba9a94ac63f.1700761448.git.gitgitgadget@gmail.com>
 <xmqqo7fk9cdt.fsf@gitster.g>
In-Reply-To: <xmqqo7fk9cdt.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 24 Nov 2023 07:28:07 -0800
Message-ID: <CABPp-BE73cDq-DBKzsw3R0awiKn5J5LCfdXRULHyPbrS9GEn4Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] completion: avoid user confusion in non-cone mode
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 5:19=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >               if [[ "$using_cone" =3D=3D "true" ]]; then
> >                       __gitcomp_directories
>
> Hmph, doesn't "Providing the files and directories currently present
> is thus always wrong." apply equally to cone mode?

Absolutely, it definitely applies to cone mode.  We (mostly) fixed
that a long time ago, making it not complete on the files &
directories currently present.  In particular, the
__gitcomp_directories() function highlighted here completes on the
output of `git ls-tree -z -d --name-only HEAD`.

However, before this series, there was a problem when
__gitcomp_directories() finds no possible completions.  In that case,
the code would fall back to bash-completion's default of completing on
all files and directories currently present.  But that was fixed in
patch 3 of this series to avoid that fallback.

This patch, though, isn't about cone mode.  It's about fixing (or at
least improving) non-cone mode.

> > +             else
> > +                     # NEEDSWORK: It might be useful to provide a
> > +                     # completion function which:
> > +                     #
> > +                     #     1. Provides completions based on
> > +                     #        files/directories that exist in HEAD, no=
t
> > +                     #        just those currently present in the work=
ing
> > +                     #        tree.
>
> This makes a lot of sense.  May make even more sense with
> s/HEAD/index/, though.

Ooh, interesting.  That wouldn't work with the sparse index (where
paths we want to complete on are currently missing from the index
too), but sparse index is restricted to cone mode, and we're
discussing non-cone-mode here.  So, this might be a basis for a good
alternative.

> > +                     #     4. Provides no completions when run from a
> > +                     #        subdirectory of the repository root.  (I=
f we
> > +                     #        did provide file/directory completions, =
the
> > +                     #        user would just get a "please run from t=
he
> > +                     #        toplevel directory" error message when t=
hey
> > +                     #        ran it.  *Further*, if the user did reru=
n
> > +                     #        the command from the toplevel, the
> > +                     #        completions we previously provided would
> > +                     #        likely be wrong as they'd be relative to=
 the
> > +                     #        subdirectory rather than the repository
> > +                     #        root.  That could lead to users getting =
a
> > +                     #        nasty surprise based on trying to use a
> > +                     #        command we helped them create.)
>
> Hmph, would an obvious alternative to (1) check against the HEAD (or
> the index) to see if the prefix string matches an entity at the
> current directory level, and then (2) to prefix the result of the
> previous step with "/$(git rev-parse --show-prefix)" work?  That is
> something like this:
>
>     $ cd t
>     $ git sparse-checkout add help<TAB>
>     ->
>     $ git sparse-checkout add /t/helper/

I thought bash-completion was only for completions, not for startings
as well.  Was I mistaken?

> and when the user gave the full path from the root level, do the
> obvious:
>
>     $ cd t
>     $ git sparse-checkout add /t/help<TAB>
>     ->
>     $ git sparse-checkout add /t/helper/
>
> Another more fundamental approach to avoid "confusion" this bullet
> item tries to side step might be to *fix* the command that gets
> completed.  As "git sparse-checkout --help" is marked as
> EXPERIMENTAL in capital letters, we should be able to say "what was
> traditionally known as 'add' is from now on called 'add-pattern' and
> command line completion would not get in the way; the 'add'
> subcommand now takes only literal paths, not patterns, that are
> relative to the current directory" if we wanted to.

That's interesting...but it opens up a new can of worms:
  * Would we also need both `set-patterns` and `set`, in addition to
`add-patterns` and `add`?
  * In cone mode, the paths passed are literal directories (and only
directories; no individual files), but the thing added is a
telescoping "cone" of leading directories as well.  Does this make it
potentially confusing to users to say that `add` only takes literal
paths?
  * In cone mode (the default), should `add-patterns` just be an
error, since no pattern specification is allowed?
  * In the git-sparse-checkout manual, for performance reasons, we
recommend users _not_ specify individual paths in non-cone mode.
Would our recommendation then be to just not use `add` or `set` and
only use `add-patterns` and `set-patterns`?  If so, what have we
accomplished by adding the new names?

Maybe I'm missing something about your suggestion, but this seems much
more complex than the simple solution we implemented in bb8b5e9a90d
("sparse-checkout: pay attention to prefix for {set, add}",
2022-02-19) for the !core_sparse_checkout_cone case.  I like the
simple solution there, though that simple solution omitted modifying
the completion rules in a way that was consistent (i.e. that returns
nothing when the user is running from a subdirectory).


> > +                     #     5. Provides escaped completions for any pat=
hs
> > +                     #        containing a '*', '?', '\', '[', ']', or
> > +                     #        leading '#' or '!'.  (These characters m=
ight
> > +                     #        already be escaped to protect from the
> > +                     #        shell, but they need an *extra* layer of
> > +                     #        escaping to prevent the pattern parsing =
in
> > +                     #        Git from seeing them as special characte=
rs.)
> > +                     #
> > +                     # Of course, this would be a lot of work, so for =
now,
> > +                     # just avoid the many forms of user confusion tha=
t
> > +                     # could be caused by providing bad completions by
> > +                     # providing a fake completion to avoid falling ba=
ck to
> > +                     # bash's normal file and directory completion.
>
> > +                     COMPREPLY=3D( "" )
> >               fi
> >       esac
> >  }
