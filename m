Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B45431E0E5
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595696; cv=none; b=lG++QRYcrqd6eF2VPTK5euqW//pFTE9elt5O39zMejYe1wk6NYpyef6XWobq44DgTvJAWVnK7hRUSOPkY2UB16MY8CxXRneMoxjFdgHYxF3At3/2beckgZv/gsUMt04d01VOg2faR/2zf5XrCjRNeR7E5xfqipRWZ7635gPX9gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595696; c=relaxed/simple;
	bh=hbj4PNN8bGzHUyNHHLLkI1iTQdyM2W5KaqR+WzpXMaQ=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=NAcPwEGCVwJuEX+2oEiRSaUx48Y4PQ3Z+4uQTV/O5oJjwvmfeF+GBG/yzapOaMQLgoKaxazuBS5zBJeXECrAgcqCyhHHWgYfj8aKl8wh+0U9csZpV2lCXOgh0qO8jjKfN3GAj7IlElXRN47xnCvCiCOh403GWbwDh455itxyFVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=easV+QnA; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="easV+QnA"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-5fe42994547so261148d50.0
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 06:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757595693; x=1758200493; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7X1KvfcjxHRlgo37DUNg/zQsnO2oLIEA17GfvRiqpIQ=;
        b=easV+QnALSTXqM4KnLpViJRdjXQQ/JTZdin3CoZ5hrN7wjj9kqKUCbsXWmZVEgxMvv
         qVKmaWDyNA4OlYsJUNqmkGd0n0X0rFU8Ll7+Ovep1BUva+sW7+23F/e6Issbhw2puSsj
         ZuenDytOIE20gZCkAmIJkA0XcQ91evBtTSqpieqZFcYoSyo4Rg0EJnngpoRNbUTKlErK
         hdLjb5OhWQZuF2G8JBLjFlwhomKEdzj251pCiQpFFTvo3XXhTY2Jqe9PXrneowYMQ8Yq
         HaAS1VPxdysK0xJv6ckRfIOAi5RB/tqbcEV4wCJVEwWa9fU/c7LXDEULZA37uu3x+drs
         JYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757595693; x=1758200493;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7X1KvfcjxHRlgo37DUNg/zQsnO2oLIEA17GfvRiqpIQ=;
        b=DYyGb8u+HSMTVdyuGIFmCq9tJD+GTKTArfiedw8QQa2C58E3V8801pmfBfjUgCohmD
         ABMvlfikvfrSTfO9H3JM0zg0LYE4uNGNWRcUAo37G7Deka9JiH2F0B5mhcXbj0mok/po
         /AKdQqBSCSwFfOt4HXvdOO0Xg9LHBzFPU0aQSSI+7EfBDiCAO+qBGMJM7wrM+0KrDOJ4
         L07AsP372Q+p+5tUNkuGcrJePl9Qh73JlEnHb8Au0Lh6eOecmmpMpIo/nmqM8gV6B1LM
         z6mOBCe7+wtpWbhgwhMfSf70Vlskoo9WBwRkhifxphnmNHNORv8srFN++YYKzlsDga2G
         FCzg==
X-Gm-Message-State: AOJu0Yw099qbtY0pz+gxRvfqR3plaNUhnk+HD3MR0R9qM/aU3fJ93eub
	w+cnBwvE2Ni6YvCHgKXcWQMmzYAZhlKVDaJuaZXIGB1k2oixQfNe40b7iUCsdQ==
X-Gm-Gg: ASbGncsix9hHT+gBo31WC5qoiIEAnBpxCFvIBpuwmoY1JOm9Rw0Uh/y7DWn2ppxP1C8
	9uVs668erkZCnHCxpxqEw1PAy7MSr2Az60EKm5EUKznDz26Dm3ODdWCxlfI2hS3Z1W9eo1MUUZs
	RU9l4smnu2sAmiu/z6xxz0KuYQ2qZQ8zGuuOKxl9mcJfFyGBJgzy5GZPuXQMebVN2AzC5bk/Who
	MZHjMnijvkSo6R4dl5rlbQJRCFrfUjTy3pDhCDIdJkgjMO9pyN8L3xRmZBxOwdPr+IE1YngXUvy
	3ruGFDCb9NwgR5i5YNObn3d2WoZigAEk3A+1CO1c+hcGYyQJeDTQ7nR9JBGsfK9GsBr4d2Ord5m
	zgBgU+qmyjkJiuLlVovVCKCTP03G3eS5lOJDY6V9o/Yh8LGT0yyo=
X-Google-Smtp-Source: AGHT+IEEqRu2z6cABR+wj7QHib9kMORE/pNFfgzFzbHW78jDsj17GqvmT/FvtkyQTeOOzkTCLGmZ5Q==
X-Received: by 2002:a05:690e:1643:b0:600:97e8:ed18 with SMTP id 956f58d0204a3-6102d26eea3mr12011896d50.2.1757595692532;
        Thu, 11 Sep 2025 06:01:32 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:99a9:dcda:93c0:4caa])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f7969c47dsm3185197b3.60.2025.09.11.06.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 06:01:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 0/7] doc: git-checkout: clarify DESCRIPTION section
Date: Thu, 11 Sep 2025 09:01:20 -0400
Message-Id: <1629C205-700F-4A8A-84BE-302D172416F8@gmail.com>
References: <pull.1962.v4.git.1757531669.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Julia Evans <julia@jvns.ca>
In-Reply-To: <pull.1962.v4.git.1757531669.gitgitgadget@gmail.com>
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 10 sept. 2025 =C3=A0 15:14, Julia Evans via GitGitGadget <gitgitgadget@=
gmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFI got feedback from 22 existing Git users on the existing git che=
ckout man
> page, using this tool: https://text-feedback.wizardzines.com/git-checkout.=

> =46rom a short survey they filled out, about 90% of the users who gave the=

> feedback have 5+ years of experience using Git.
>=20
> This series goes through the DESCRIPTION section from beginning to end,
> addressing points that users found confusing in each variant of git
> checkout. The goal is to clarify while communicating the same information.=

>=20
> Changes in v2:
>=20
> * Remove the numbered list from the beginning, from Junio's review
> * Describe what it means to "switch branches" in a way that's hopefully
>   more accessible to newcomers, from Junio's review
> * Improve the ARGUMENT DISAMBIGUATION section, from Junio and Ben's review=
s
>   ("conflict" =3D> "ambiguity", explain correctly what the default is)
> * The explanation of git checkout [<tree-ish>] <pathspec> had a lot of
>   issues, from Junio's review. Resolve this by splitting up the git
>   checkout [] section into two sections. Use "Replace" instead of
>   "Restore".
>=20
> Changes in v3:
>=20
> * Fix incorrect description of when git checkout <branch>, from Junio's
>   review
> * Take a different approach to the git checkout -b description (keep reset=

>   in -B, but simplify the description of -B a lot to remove the
>   "transactional equivalent.." paragraph), from Junio's review
> * Say "switch to the commit" instead of "switches commits", from Junio's
>   review
> * Try a different approach to git checkout file.txt ("Discard any unstaged=

>   changes...")
>=20
> Changes in v4:
>=20
> * Rewrite all the commit messages to try to take a more Problem / Solution=

>   approach, from Junio's review and thanks to help from @nasamuffin in
>   Discord. Also change the cover letter format to match the style in
>   https://lore.kernel.org/git/CAOLa=3DZStgwBN0fMK3YxoqeR+1i772f621supva3Kv=
r7YPq4g8g@mail.gmail.com/T/#m8c99a3144cbdfb445e04f8f83a79364bfe8d797d
>   , which hopefully matches the norms of this mailing list better.

This was pleasant reading to me. Not sure how it felt for you to write? Or i=
f the convention was just not spelled out enough to get you where you wanted=
 to be? :)

> * Try a different approach to the "left unchanged...", from Junio's review=

> * Bring back "index" (with a few hints about what the word might mean),
>   from Junio's review.
> * Bring back the numbered list at the beginning from v1, since I think I
>   misunderstood a comment about lists, and that the original was clearer
> * Fix an issue I noticed in -B ("instead of failing", not "instead of
>   creating it")
> * Add a comma after branch or commit, to try to make it clear what "either=
"
>   refers to in that sentence
> * Replace "will fail without making any changes" throughout with just "wil=
l
>   fail". I think the default assumption is that Git will fail operations i=
n
>   a clean way, and that cases where it does not fail cleanly are the
>   exceptions that the documentation should flag.
>=20
> Julia Evans (7):
>  doc: git-checkout: clarify intro sentence
>  doc: git-checkout: clarify ARGUMENT DISAMBIGUATION
>  doc: git-checkout: clarify `git checkout <branch>`
>  doc: git-checkout: clarify `-b` and `-B`
>  doc: git-checkout: deduplicate --detach explanation
>  doc: git-checkout: split up restoring files section
>  doc: git-checkout: clarify restoring files section
>=20
> Documentation/git-checkout.adoc | 151 ++++++++++++++++----------------
> 1 file changed, 76 insertions(+), 75 deletions(-)
>=20
>=20
> base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1962%2Fj=
vns%2Fclarify-checkout-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1962/jvns/c=
larify-checkout-v4
> Pull-Request: https://github.com/gitgitgadget/git/pull/1962
>=20
> Range-diff vs v3:

Range-diff looks good to me!

>=20
> -:  ---------- > 1:  4b52ffd497 doc: git-checkout: clarify intro sentence
> 1:  1975384dd0 ! 2:  08f0a5efab doc: git-checkout: clarify intro
>     @@ Metadata
>      Author: Julia Evans <julia@jvns.ca>
>=20
>       ## Commit message ##
>     -    doc: git-checkout: clarify intro
>     +    doc: git-checkout: clarify ARGUMENT DISAMBIGUATION
>=20
>     -    - Reduce use of jargon ("index", "pathspec", "tree") by using an
>     -      example, and by mirroring the "switch" and "restore" language f=
rom the
>     -      first line of the man page.
>     -    - Reference and clarify the ARGUMENT DISAMBIGUATION section, as w=
ell
>     -      as fixing a small error (in "`git checkout abc`, `abc` is a com=
mit,
>     -      not a `_<tree-ish>_`)
>     +    There's no need to use the terms "pathspec" or "tree-ish" in the
>     +    ARGUMENT DISAMBIGUATION section, which are terms that (from user
>     +    feedback on this page) many users do not understand.
>     +
>     +    "tree-ish" is actually not accurate here: `git checkout` in this c=
ase
>     +    takes a commit-ish, not a tree-ish. So we can say "branch or comm=
it"
>     +    instead of "tree-ish" which is both more accurate and uses more f=
amiliar
>     +    terms.
>     +
>     +    And now that the intro to the man pages mentions that `git checko=
ut` has
>     +    "two main modes", it makes sense to refer to this disambiguation s=
ection
>     +    to understand how Git decides which one to use when there's an ov=
erlap
>     +    in syntax.
>=20
>          Signed-off-by: Julia Evans <julia@jvns.ca>
>=20
>       ## Documentation/git-checkout.adoc ##
>     -@@ Documentation/git-checkout.adoc: git checkout (-p|--patch) [<tree-=
ish>] [--] [<pathspec>...]
>     +@@ Documentation/git-checkout.adoc: DESCRIPTION
>     + 2. **Restore a different version of a file**, for example with
>     +    `git checkout <commit> <filename>` or `git checkout <filename>`
>=20
>     - DESCRIPTION
>     - -----------
>     --Updates files in the working tree to match the version in the index
>     --or the specified tree.  If no pathspec was given, `git checkout` wil=
l
>     --also update `HEAD` to set the specified branch as the current
>     --branch.
>     -+`git checkout` has two main modes: it can
>     -+**switch branches**, for example with `git checkout <branch>`, and
>     -+**restore files from a different version**, for example with
>     -+`git checkout <commit> <filename>` or `git checkout <filename>`
>     -+
>      +See ARGUMENT DISAMBIGUATION below for how Git decides which one to d=
o.
>     -
>     ++
>       `git checkout [<branch>]`::
>           To prepare for working on _<branch>_, switch to it by updating
>     +    the index and the files in the working tree, and by pointing
>      @@ Documentation/git-checkout.adoc: $ git log -g -2 HEAD
>       ARGUMENT DISAMBIGUATION
>       -----------------------
>     @@ Documentation/git-checkout.adoc: $ git log -g -2 HEAD
>      -to checkout these paths out of the index.
>      +When you run `git checkout <something>`, Git tries to guess whether
>      +`<something>` is intended to be a branch, a commit, or a set of file=
(s),
>     -+and then either switches to that branch or commit or restores the
>     ++and then either switches to that branch or commit, or restores the
>      +specified files.
>      +
>      +If there's any ambiguity, Git will treat `<something>` as a branch o=
r

> 6:  90fe48cfe3 ! 7:  db603b1e5f doc: git-checkout: clarify restoring files=
 section
>     @@ Metadata
>       ## Commit message ##
>          doc: git-checkout: clarify restoring files section
>=20
>     -    - Reword to avoid jargon ("tree-ish", "index") where possible.
>     -      Use "commit or tree" and "stage" (as a verb) instead where appr=
opriate
>     -    - Add examples
>     -    - Use a simpler sentence structure to describe options for handli=
ng
>     -      unmerged entries: "use -f to.., use --ours to..., or use -m to.=
."
>     +    =46rom user feedback on this section: 3 users don't know what "tr=
ee-ish"
>     +    means and 3 users don't know what "pathspec" means. One user also=
 says
>     +    that the section is very confusing and that they don't understand=
 what
>     +    the "index" is.
>     +
>     +    =46rom conversations on Mastodon, several users said that their i=
mpression
>     +    is that "the index" means the same thing as "HEAD". It would be g=
ood to
>     +    give those users (and other users who do not know what "index" me=
ans) a
>     +    hint as to its meaning.
>     +
>     +    Make this section more accessible to users who don't know what th=
e terms
>     +    "pathspec", "tree-ish", and "index" mean by using more familiar l=
anguage,
>     +    adding examples, and using simpler sentence structures.

Without re-examining the individual patches, I see that 2/7 and 7/7 (possibl=
y also new 1/7) lost pointers to pathspecs. I think I mentioned this previou=
sly: I hope we can find some way to direct folks towards the glossary entrie=
s that describe them. I would consider pathspecs a power-user feature, and t=
hey create lots of useful affordances. So it is fair to more gently introduc=
e newcomers, but I would also still like to make sure it clear when commands=
 accept pathspec =E2=80=9Cmagic=E2=80=9D :)

OTOH, I=E2=80=99ll take a look at the docs after this series lands and see i=
f it feels like something is missing. It may be just fine to have pathspecs i=
n the synopses and add a sentence somewhere after the gentle introduction =E2=
=80=9CFor more ways to specify paths, see=E2=80=A6=E2=80=9D=
