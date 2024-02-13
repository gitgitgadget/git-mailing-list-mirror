Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1471E1DFFC
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 00:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707785589; cv=none; b=LG72Tj+seVhUFEgNxdGiQ5fKB01Pj7rBaDeR7jUfO8iTh0Jk2KQVmMidxq49g8aX1eSkoDtQt479u97x7QjipmJI9PX/riCzKMo30kUg2ngFNA98dlBe11V5eNal+OCABmBuwOL81/8OoWZDVGcHGvnSDS3/FsSk3fWqk5sQwoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707785589; c=relaxed/simple;
	bh=J3Bmrvg+WSFK1xLg0redyBapUr3sQ58fqjs9r1oRSNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=soqLeqLEuMUzkGm8FALouCGKTfpbiJKVBqdSGUieHcaP0h/0q6vAlgr1LTPGfaSD9viWH24a3zE82LH0OxmNFZwf8su5wBpje/KtUzp9S3Gda08WhyoIKT8Wxi0wiYzuR+Tc9G1PisOXccomJ8pIYdG9O2nSB7+5zF/VOF7DMgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z//RZhrK; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z//RZhrK"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5605c7b1f32so5202819a12.0
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 16:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707785585; x=1708390385; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxdiQI8hgXWB1yJL2Mg6pmTU/Ebz0PSXaqOlkoZXz+g=;
        b=Z//RZhrKvhkAhvAfi8dm3HEPNG4LU8lAh653CFAgPgBaCeIlsFeyJ3LvGskByHWpIm
         kcfQnaQF+JkpGYPIJLgH3MRAhpPg/xiMsXnjE+P62RVzEieq0tA24M/jDfSKhD6o0v4M
         mWwzJHtnbTRKvX6EmwvSXiacn523Y7YruBwuNd0lm0A5sq6r6zs/ugMhDyVoatKRVPRs
         E3GvpC6/9eNOHz/+De/0svFkTPiqxnJEPhxkMZBRA6fMjlBJ9/PlkiMN35ZWKRF2FKCO
         DqKD7cQQ1fyAnbVenCacssRXpwNUb/tv4KxGuEFETYi5A8NEBnAwwbPBSNDOGiSz3EAL
         4rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707785585; x=1708390385;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxdiQI8hgXWB1yJL2Mg6pmTU/Ebz0PSXaqOlkoZXz+g=;
        b=hEL0+pLlnRHgrfd1CG6T+sXRr3A/lQzY6wgmj8l9dm53nzZdR/z9VwNuVpsRy/sOCv
         RV6drK0WVUo9TKyIBRhx0qeBaupZY1ei64wX2Ha3ZSRdvkZEBY6ITenlQQle7VG+y9Fe
         YBzEyPSxENllWAAZS2lTjwf8+kP5Do6gLXJIzbD8VVBoquCKqv+qPjsDNL+7xxkmeovI
         rOE9BWo4dTGny93G2AqoxajbD8hATXFM/hL80rwdjZYel0LCh1o5wCop/eHerffxwOLU
         aH0us35FC6bPmX50e+mW1zp3l/jKuicW/BL2XA4A0hApy/TYX5OYLeTWgJw/en7Purcl
         ihqg==
X-Gm-Message-State: AOJu0YyF3zLY5pleXa4JLlmw10AeE0gn2nC2nHyndrP2VgXUAmq5JDq2
	K3MWqI2GR3nEAroNaIhp/nw/iKvwgJ9jDjJnnV7yLLpwkXYMLLgduAluVqyPQjq74t9APLYLTff
	rPRTRtzdYHNPaTBriCJckHF28mPvgT6RxhHE=
X-Google-Smtp-Source: AGHT+IEMaYWIwJJLcyTzoz37X/eQkLT09H+75TEl+KIU1EPX6yS8PiadTWVxONCm/fbS8ov0S7C6Todq1CzlCyv3zYo=
X-Received: by 2002:a17:907:9849:b0:a3b:aa50:da81 with SMTP id
 jj9-20020a170907984900b00a3baa50da81mr5291072ejc.5.1707785585012; Mon, 12 Feb
 2024 16:53:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4714b88d-df5b-4e37-a5d7-af5033cfb861@smtp-relay.sendinblue.com>
 <20240109005303.444932-1-britton.kerin@gmail.com> <d37781c3-6af2-409b-95a8-660a9b92d20b@smtp-relay.sendinblue.com>
 <40c3a824-a961-490b-94d4-4eb23c8f713d@gmail.com>
In-Reply-To: <40c3a824-a961-490b-94d4-4eb23c8f713d@gmail.com>
From: Britton Kerin <britton.kerin@gmail.com>
Date: Mon, 12 Feb 2024 15:52:53 -0900
Message-ID: <CAC4O8c9z4s4fFU6_h6ZRBnDhZyiTp3XR8j0DrARj+1SauLbQEQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] completion: dir-type optargs for am, format-patch
To: =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 3, 2024 at 6:13=E2=80=AFAM Rub=C3=A9n Justo <rjusto@gmail.com> =
wrote:
>
> On 08-ene-2024 15:53:03, Britton Leo Kerin wrote:
> > Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
> > ---
> >  contrib/completion/git-completion.bash | 37 ++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
> > index 185b47d802..2b2b6c9738 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -1356,6 +1356,29 @@ __git_count_arguments ()
> >       printf "%d" $c
> >  }
> >
> > +# Complete actual dir (not pathspec), respecting any -C options.
> > +#
> > +# Usage: __git_complete_refs [<option>]...
> > +# --cur=3D<word>: The current dir to be completed.  Defaults to the cu=
rrent word.
> > +__git_complete_dir ()
> > +{
> > +     local cur_=3D"$cur"
> > +
> > +     while test $# !=3D 0; do
> > +             case "$1" in
> > +             --cur=3D*)        cur_=3D"${1##--cur=3D}" ;;
> > +             *)              return 1 ;;
> > +             esac
> > +             shift
> > +     done
> > +
> > +        # This rev-parse invocation amounts to a pwd which respects -C=
 options
> > +     local context_dir=3D$(__git rev-parse --show-toplevel --show-pref=
ix 2>/dev/null | paste -s -d '/' 2>/dev/null)
> > +     [ -d "$context_dir" ] || return 1
> > +
> > +     COMPREPLY=3D$(cd "$context_dir" 2>/dev/null && compgen -d -- "$cu=
r_")
>
> This assignment is problematic.
>
> First, COMPREPLY is expected to be an array.  Maybe a simple change can
> do the trick:
>
> -       COMPREPLY=3D$(cd "$context_dir" 2>/dev/null && compgen -d -- "$cu=
r_")
> +       COMPREPLY=3D( $(cd "$context_dir" 2>/dev/null && compgen -d -- "$=
cur_") )
>
> But, what happens with directories that have SP's in its name?  We're
> giving wrong options:
>
>     $ mkdir one
>     $ mkdir "one more dir"
>     $ git am --directory=3Do<TAB><TAB>
>     dir   more  one
>
> Setting IFS can help us:
>
> +       local IFS=3D$'\n'
>
> Now we're returning correct options:
>
>     $ mkdir one
>     $ mkdir "one more dir"
>     $ git am --directory=3Do<TAB><TAB>
>     one       one more dir
>
> Here, the user might be expecting directory names with a trailing '/',
> as Bash do.  Again, a simple trick:
>
> -       COMPREPLY=3D( $(cd "$context_dir" 2>/dev/null && compgen -d -- "$=
cur_") )
> +       COMPREPLY=3D( $(cd "$context_dir" 2>/dev/null && compgen -d -S / =
-- "$cur_") )
>
> Now looks better, IMO:
>
>     $ git am --directory=3Do<TAB><TAB>
>     one/      one more dir/
>
> But, after all of this, we're going to provoke a problematic completion d=
ue
> to the SP:
>
>     $ mkdir "another one"
>     $ git am --directory=3Danot<TAB><TAB>
>     ...
>     $ git am --directory=3Danother one/
>
> We should complete to:
>
>     $ git am --directory=3Danother\ one/
>
> Here we need a less simple trick:
>
> +       # use a hack to enable file mode in bash < 4
> +       # compopt -o filenames +o nospace 2>/dev/null ||
> +       compgen -f /non-existing-dir/ >/dev/null ||
> +       true
>
> Some commits you may find interesting:
> fea16b47b6 (git-completion.bash: add support for path completion, 2013-01=
-11)
> 3ffa4df4b2 (completion: add hack to enable file mode in bash < 4, 2013-04=
-27)
>
> Well, so far, so good?  I'm afraid, not:  What happens with other
> special characters like quotes '"'?
>
> I suggest you take a look at how we are already doing all of
> considerations for other commands, like git-add.

Thanks for all these suggestions.  Considering them and working on it
some more I end up with this function:


__git_complete_dir ()
{
        local cur_=3D"$cur"

        while test $# !=3D 0; do
                case "$1" in
                --cur=3D*)        cur_=3D"${1##--cur=3D}" ;;
                *)              return 1 ;;
                esac
                shift
        done

        # This rev-parse invocation amounts to a pwd which respects -C opti=
ons
        local context_dir=3D$(__git rev-parse --show-toplevel
--show-prefix 2>/dev/null | paste -s -d '/' 2>/dev/null)
        [ -d "$context_dir" ] || return 1

        compopt -o noquote

        local IFS=3D$'\n'
        local unescaped_candidates=3D($(cd "$context_dir" 2>/dev/null &&
compgen -d -S / -- "$cur_"))
        for ii in "${!unescaped_candidates[@]}"; do
                COMPREPLY[$ii]=3D$(printf "%q" "${unescaped_candidates[$ii]=
}")
        done
}

This one works for all weird characters that I've tried in bash 5.2 at
least, and in frameworks that do their own escaping also (e.g.
ble.sh).  Since your advice so far was so good I thought I'd ask if
there is anything obvious to you that is still wrong here?

If not I guess what's left is special code to make it work better with
old versions of bash.  I'm a little sceptical that this is worth it
since bash 5 is already 5 years old and it's only completion code
we're talking about  but I guess it could be done.

Britton
