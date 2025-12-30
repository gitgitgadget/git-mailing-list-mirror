Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E257D145B27
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767135074; cv=none; b=eJTxZjfze676MdpsAYggJYzAdHyt8LyVk8C+MdS0/UtBTAqPSmoLYXN0eFFKBZOiYelI76Ojuk4DtWDYbnpYsKcfW66FQh0WGQeqx8u47xF4MpNiUor126bFlTgLXU6LnZY19h9IjvMvtMY1AhmCcyv1qKyL8anmolaLNC67S+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767135074; c=relaxed/simple;
	bh=cfnMuV3UMry3JOKzP4kDP7dqX9+K8+XjLXaWfJNqABE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2UDUjY8g5zUf9hzfBkM8f+pVt6kw8hpuo7MUSHXezP2P2yCP81OIRfRMpTnamEqSC85aWJys+eePUZozamKYhyRnp6ogPv29T/AnBkiq2GlBmaCF/LpUmAUkl66y5RhVeyxE4bRXnUv/NqzdicrGZVdh+MXzCXOSt3zCBX/pmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaH16Pj1; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaH16Pj1"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-65e9430489eso2938155eaf.0
        for <git@vger.kernel.org>; Tue, 30 Dec 2025 14:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767135071; x=1767739871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uRu+o7LrvAycB5DyXLmyqM/SZMg+coiffKEm5SVhLM=;
        b=kaH16Pj14zNNbLvL5G8JRLPRDQvdo4EWFNCqGt2VCRzGlxVkBf4ADSJdaY+QpIbFJy
         NAVISvnbSfZbmxyUEgYZeX1sTLxOoAHLxqmQeqj7c2018fSA+iNpxepO+jVn7WefoMDQ
         g5AHrhopOQJjeS+ImX/vpy6CdQZZN0rQjDVUhu7OlteSjFPkGni7P6Soma5sR1AasgXf
         tPg5+eI1tfb5oiTrsGqb5FWD36cGAPYoZJsbIcZLN9PxiOYwy7G/DW8mUMoaPAIHyBgG
         elaNIONVVtQ06A5vpgbzzep2oBiae6qPRvX2n9Tsh3jzRi0EkZgNhTP3P7slGDpE5QJL
         hwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767135071; x=1767739871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4uRu+o7LrvAycB5DyXLmyqM/SZMg+coiffKEm5SVhLM=;
        b=PvJW24LlcrJ+9GW1nLhCeKxJVVV2jVLj5C/TxndCSrc7pWJkMqCV+ne/U0mRu/5j9Z
         6ISuouQLqM9oLK77aj1gk4rAdF5xZtTwojeUcxyAugFP+kKBKheKS88++kMr/m/JDMh2
         xKwVKMrbltMC8/p0PZzs3+hGeLZFBHw8SfStSrLwoayjermp5zfgKSplHj0J8ZzVUCeO
         9wBz0NyeZpNOXFzu4brsUqn+Tenk/PjoGwQWLbU6RvA4BpPftpMnluAtua8SEfH3NBtJ
         unDLKeiXdaCOsNAgzBIl/zAooAmmqCxNqlWKx6Htzi8PABDT8SkzR5FoguxBV1ru/mtK
         jIbw==
X-Gm-Message-State: AOJu0Yx5Kr23Nlt/gyhv2xpIlQnSq2iLPUzgOPwG4VNzrFpR1YUXXmMR
	L9lrfob6pLYq1/6A735YPyrgItMPKC9rqQoQLUaPEJ+KPJSoSnSD8PTJXhNAEgWi8mNLpyd5ufn
	v+kQN8i5Btu98BDHB3RHVibdtGuPoOW0=
X-Gm-Gg: AY/fxX45LxoqqY1Ms391XukfiKHmn55NSLFIGTg5O7bUFuCZCSg6q494vYZxIlLSaB/
	7hM8O4PYLqskJ/DbIvQj31/JQ31Qaa7GqaBrPFJXrbRkJ/n0rHV+BDtb8TOFROgFfol3wmkVvf6
	CV7ufay/Tht+Q47YGB4D85kQWajxM3qCAf40i6YlB5uIcSD89R6y16HmceTqXZbGoR+sKx8zuYO
	gGElwPqN8yPHyUuinLAYtqSDjB/O99WpqRKOZJJIYCzqYK/pb2CSntii4shkgTOepD/90B3ebOs
	LlMbrAGozRzViwNcnY7cy8fKrqu1
X-Google-Smtp-Source: AGHT+IFlbRJjMfMAvbO+wOkKYCXpcRaJB22Hti86mf/7TnanUr34FdX4k4pjVzRKJNPsmSxi6Rvouvp03WYnYVkKxW8=
X-Received: by 2002:a05:6820:1691:b0:65b:29af:b55f with SMTP id
 006d021491bc7-65d0e9b71d0mr13314475eaf.35.1767135070584; Tue, 30 Dec 2025
 14:51:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CV_replay_die_descr.13f@msgid.xyz> <V2_CV_replay_die_descr.17b@msgid.xyz>
 <V2_dead_replay_code.17c@msgid.xyz>
In-Reply-To: <V2_dead_replay_code.17c@msgid.xyz>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 30 Dec 2025 14:50:58 -0800
X-Gm-Features: AQt7F2rWDec5z8wmAIlLqLHbOJ3yaGU_YatRF0JbxljtGzkPaqCm37ajGDKP-LE
Message-ID: <CABPp-BEJV1XG62_hn_OiZ9q9S3jsyTP0VdOEzS4pME2rrkKFrg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] replay: remove dead code and rearrange
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, christian.couder@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 7:03=E2=80=AFAM <kristofferhaugsbakk@fastmail.com> =
wrote:
>
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> 22d99f01 (replay: add --advance or 'cherry-pick' mode, 2023-11-24) both
> added `--advance` and made one of `--onto` or `--advance` mandatory.
> But `determine_replay_mode` claims that there is a third alternative;
> neither of `--onto` or `--advance` were given:
>
>     if (onto_name) {
>     ...
>     } else if (*advance_name) {
>     ...
>     } else {
>     ...
>     }
>
> But this is false=E2=80=94the fallthrough else-block is dead code.
>
> Commit 22d99f01 was iterated upon by several people.[1] The initial
> author wrote code for a sort of *guess mode*, allowing for shorter
> commands when that was possible. But the next person instead made one
> of the aforementioned options mandatory. In turn this code was dead on
> arrival in git.git.
>
> [1]: https://lore.kernel.org/git/CABPp-BEcJqjD4ztsZo2FTZgWT5ZOADKYEyiZtda=
+d0mSd1quPQ@mail.gmail.com/
>
> Let=E2=80=99s remove this code. We can also join the if-block with the
> condition `!*advance_name` into the `*onto` block since we do not set
> `*advance_name` in this function. It only looked like we might set it
> since the dead code has this line:
>
>     *advance_name =3D xstrdup_or_null(last_key);
>
> Let=E2=80=99s also rename the function since we do not determine
> the replay mode here. We simply populate data structures.
>
> Note that there might be more dead code caused by this *guess mode*.
> We only concern ourselves with this function for now.
>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (series):
>     v2: [new]
>
>     See the link in the commit message.
>
>     Not strictly needed for this series but I think it makes sense to fix=
 it
>     here.
>
>  builtin/replay.c | 70 +++++++++++-------------------------------------
>  1 file changed, 16 insertions(+), 54 deletions(-)
>
> diff --git a/builtin/replay.c b/builtin/replay.c
> index 6172c8aacc9..54849f65c87 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -154,16 +154,16 @@ static void get_ref_information(struct repository *=
repo,
>
>                 free(fullname);
>         }
>  }
>
> -static void determine_replay_mode(struct repository *repo,
> -                                 struct rev_cmdline_info *cmd_info,
> -                                 const char *onto_name,
> -                                 char **advance_name,
> -                                 struct commit **onto,
> -                                 struct strset **update_refs)
> +static void populate_for_onto_or_advance_mode(struct repository *repo,
> +                                             struct rev_cmdline_info *cm=
d_info,
> +                                             const char *onto_name,
> +                                             char **advance_name,
> +                                             struct commit **onto,
> +                                             struct strset **update_refs=
)

Renaming makes sense, but the new name is quite the mouthful, and it
feels slightly odd because "onto" is both a command line flag and a
variable -- and the variable value is used regardless of which command
line flag is used.  Since the variable is used either way, there's a
risk someone might be confused by this function name.  Maybe just
setup_replay_mode() ?  Or maybe others have other suggestions?

>  {
>         struct ref_info rinfo;
>
>         get_ref_information(repo, cmd_info, &rinfo);
>         if (!rinfo.positive_refexprs)
> @@ -174,69 +174,30 @@ static void determine_replay_mode(struct repository=
 *repo,
>         if (onto_name) {
>                 *onto =3D peel_committish(repo, onto_name);
>                 if (rinfo.positive_refexprs <
>                     strset_get_size(&rinfo.positive_refs))
>                         die(_("all positive revisions given must be refer=
ences"));
> -       } else if (*advance_name) {
> +               *update_refs =3D xcalloc(1, sizeof(**update_refs));
> +               **update_refs =3D rinfo.positive_refs;
> +               memset(&rinfo.positive_refs, 0, sizeof(**update_refs));
> +       } else {
>                 struct object_id oid;
>                 char *fullname =3D NULL;
>
> +               if (!*advance_name)
> +                       BUG("expected either onto_name or *advance_name i=
n this function");
> +
>                 *onto =3D peel_committish(repo, *advance_name);
>                 if (repo_dwim_ref(repo, *advance_name, strlen(*advance_na=
me),
>                              &oid, &fullname, 0) =3D=3D 1) {
>                         free(*advance_name);
>                         *advance_name =3D fullname;
>                 } else {
>                         die(_("argument to --advance must be a reference"=
));
>                 }
>                 if (rinfo.positive_refexprs > 1)
>                         die(_("cannot advance target with multiple source=
s because ordering would be ill-defined"));
> -       } else {
> -               int positive_refs_complete =3D (
> -                       rinfo.positive_refexprs =3D=3D
> -                       strset_get_size(&rinfo.positive_refs));
> -               int negative_refs_complete =3D (
> -                       rinfo.negative_refexprs =3D=3D
> -                       strset_get_size(&rinfo.negative_refs));
> -               /*
> -                * We need either positive_refs_complete or
> -                * negative_refs_complete, but not both.
> -                */
> -               if (rinfo.negative_refexprs > 0 &&
> -                   positive_refs_complete =3D=3D negative_refs_complete)
> -                       die(_("cannot implicitly determine whether this i=
s an --advance or --onto operation"));
> -               if (negative_refs_complete) {
> -                       struct hashmap_iter iter;
> -                       struct strmap_entry *entry;
> -                       const char *last_key =3D NULL;
> -
> -                       if (rinfo.negative_refexprs =3D=3D 0)
> -                               die(_("all positive revisions given must =
be references"));
> -                       else if (rinfo.negative_refexprs > 1)
> -                               die(_("cannot implicitly determine whethe=
r this is an --advance or --onto operation"));
> -                       else if (rinfo.positive_refexprs > 1)
> -                               die(_("cannot advance target with multipl=
e source branches because ordering would be ill-defined"));
> -
> -                       /* Only one entry, but we have to loop to get it =
*/
> -                       strset_for_each_entry(&rinfo.negative_refs,
> -                                             &iter, entry) {
> -                               last_key =3D entry->key;
> -                       }
> -
> -                       free(*advance_name);
> -                       *advance_name =3D xstrdup_or_null(last_key);
> -               } else { /* positive_refs_complete */
> -                       if (rinfo.negative_refexprs > 1)
> -                               die(_("cannot implicitly determine correc=
t base for --onto"));
> -                       if (rinfo.negative_refexprs =3D=3D 1)
> -                               *onto =3D rinfo.onto;
> -               }
> -       }
> -       if (!*advance_name) {
> -               *update_refs =3D xcalloc(1, sizeof(**update_refs));
> -               **update_refs =3D rinfo.positive_refs;
> -               memset(&rinfo.positive_refs, 0, sizeof(**update_refs));
>         }
>         strset_clear(&rinfo.negative_refs);
>         strset_clear(&rinfo.positive_refs);
>  }
>
> @@ -384,12 +345,13 @@ int cmd_replay(int argc,
>                           "'%s' bit in 'struct rev_info' will be forced")=
,
>                         "simplify_history");
>                 revs.simplify_history =3D 0;
>         }
>
> -       determine_replay_mode(repo, &revs.cmdline, onto_name, &advance_na=
me,
> -                             &onto, &update_refs);
> +       populate_for_onto_or_advance_mode(repo, &revs.cmdline,
> +                                         onto_name, &advance_name,
> +                                         &onto, &update_refs);
>
>         if (!onto) /* FIXME: Should handle replaying down to root commit =
*/
>                 die("Replaying down to root commit is not supported yet!"=
);
>
>         if (prepare_revision_walk(&revs) < 0) {
> --
> 2.52.0.10.g08704017180

Looks fine otherwise.
