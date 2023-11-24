Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJaHtnEx"
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F3A10F0
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 12:05:16 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507be298d2aso2985280e87.1
        for <git@vger.kernel.org>; Fri, 24 Nov 2023 12:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700856315; x=1701461115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2fqzNjT6sM+RBA6mQxp3JJe5cz2xPnePsW4023h2KI=;
        b=QJaHtnEx6+4nvLUWpFK/puhYfbOYjpbHBs6+jlKedoBDDKEGwMtqDuaDuru3fDdqx1
         HaWaDqt+TUvm3XgeNz8V8RdLHZbBj2d6Uq/e8oNkupaWN/9JNfCXudtgRMgkV6UYFARr
         R2FHsClPgeNT2BRwALg5sUNlxBc8BzUesAWJ8GItsI+KPlpF9/kmws5nS/Ka0XUA0gY7
         bKOz16uROPLcILrWmJMMcQtMqg0KV1wRngoW/nyanHcGrjZXZjbUtGAfu/OE0c+P6oXv
         VOmnTUtQpLjQOIkFazoZCEEi+DLeTtcaCDTd/9Oet6gmqEB5fRCv9FcuLK8CPRXQ9pP8
         b17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700856315; x=1701461115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2fqzNjT6sM+RBA6mQxp3JJe5cz2xPnePsW4023h2KI=;
        b=BDYEQvu1UoLN0+/UCiJxdFwk2nu6yu6S5sQjQCo8qVlgwXGMvp814lIS3jGWCauSax
         7XIc6zWsNfYuA8kvKsZX26Q4vYvsWcb1tKYuwP7gmbqTiQ90eLFLh33w/SlpiRt3hZ2W
         DyTjfyRk1ijJ00LVu7N4aYPa/39ME9krfK/G0DFn4LA+tjjlbzcPsooXCwlukMTOVgDe
         TVkYJZ12IrQmtkHouZBfgrB8s6MKojW7Lrw+UoPGGsgtkfbr79L3tXbxGi1AhfHKuVKc
         Q97BFK2nQr90mdYfmS5HsBguerlmeWYsHLEtzfxv6f5jn9TE63528KwACr6KVcOznE6A
         lGWA==
X-Gm-Message-State: AOJu0YxvToqXv3bc720F5Z3Qr4XzwK6ai5XgWnLBZ4bEqxNhlyG7WmFO
	AGEk2erb9LzkQ4QE+4JuibtkIL77IyFHlabp/QX8jcwl0cg=
X-Google-Smtp-Source: AGHT+IEq3aGoFj6WN7hBwQMseaCg4X0TDuEb9JuY9nMeaCvj05CnX3ZX6SiCMUi1ZxiUs8WgO6gzk6RwmzRSz9ZXe0U=
X-Received: by 2002:a05:6512:15a9:b0:503:3cc:cd39 with SMTP id
 bp41-20020a05651215a900b0050303cccd39mr3960101lfb.8.1700856314419; Fri, 24
 Nov 2023 12:05:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1349.git.1700761448.gitgitgadget@gmail.com>
 <591c7b8d73b1a93feaa749d68156a198a7e32a9c.1700761448.git.gitgitgadget@gmail.com>
 <20231124183938.GB11157@szeder.dev>
In-Reply-To: <20231124183938.GB11157@szeder.dev>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 24 Nov 2023 12:05:02 -0800
Message-ID: <CABPp-BGn0YT4e_ScWVR5riiuZ5kDd7X41WV-xMe91BGeuQ5xPQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] completion: squelch stray errors in sparse-checkout completion
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 10:39=E2=80=AFAM SZEDER G=C3=A1bor <szeder.dev@gmai=
l.com> wrote:
>
> On Thu, Nov 23, 2023 at 05:44:05PM +0000, Elijah Newren via GitGitGadget =
wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > If, in the root of a project, one types
> >
> >     git sparse-checkout set --cone ../<TAB>
> >
> > then an error message of the form
> >
> >     fatal: ../: '../' is outside repository at '/home/newren/floss/git'
> >
> > is written to stderr, which munges the users view of their own command.
> > Squelch such messages.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  contrib/completion/git-completion.bash | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
> > index ba5c395d2d8..6fced40d04c 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -3014,7 +3014,7 @@ __gitcomp_directories ()
> >                       COMPREPLY+=3D("$c/")
> >                       _found=3D1
> >               fi
> > -     done < <(git ls-tree -z -d --name-only HEAD $_tmp_dir)
> > +     done < <(git ls-tree -z -d --name-only HEAD $_tmp_dir 2>/dev/null=
)
>
> It would be better to use the __git wrapper instead, like the wast
> majority of git invocations in our completion script, because it not
> only takes care of squelching standard error, but also takes into
> account any -C dir and/or --git-dir options present on the command
> line.
>
> e15098a314 (completion: consolidate silencing errors from git
> commands, 2017-02-03)

Ooh, nice!  Thanks for the pointer, I was unaware.  I'll make that change.
