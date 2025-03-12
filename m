Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2B41D5175
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 21:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741815584; cv=none; b=tomL9S7I9A9EiSreJH/Y4MRp+/kd1LWLAhgSM/VPDdj4DEITx4UrcpOrKig4aWJkg0JGq5H2e8gR6aicPfGqz+t3NWKPdhBNCA0ZEIyMfKDlx3VNwiBe7691jt6HAT/sjdwCVuQz7LnyjnPPVP0XTvbZI+w4v54hb4ym46md5jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741815584; c=relaxed/simple;
	bh=DqaR0tM/SZMIn4AwKVDqNA/BR4/q7d9kD4LbT2Xx8Ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJH98Kss2Q92KFcNMvcT1zJtdcbc6Q4Wlt2rVjyh2KJvoBpMij35zp1iaKsEMD8XlwFfxqsNOPHbzqOYEqOxwycHrXHjyGc73UnO+INwaELeJ4AFdF/9DaIjzTWozgKz4v/QIqrpkW5yjAYDxxZYOitW9Sf7wUCS8mOersi52p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iljrx91O; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iljrx91O"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85db872dd80so703839f.0
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 14:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741815582; x=1742420382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKFHOiH7vdn0PPU6luFtvgPLKGiMnG0ZWi5O03HOXyI=;
        b=Iljrx91O3CtOlzAbMfjTp18Wy4Q5aUfumqtlxlDYq6shrNbfqrPJdibhpEkbMNZlGr
         ppC+lbmirSsX1ndrkvrEebs96DcYHjfNSDIQsqqaaotWbAHo8Vwz9+Lc+ZZqQJ3Lla/2
         YdPTm9QhtvWCtn/eccYfv15DjObIuAN8dMZmxw7tX3lIe+riHAOjApEfpwSyvoBTN4XS
         rsD0KVDZTmhqDV6SLtdMNL1WNjRLJBZ12nYKRDiRVXDEX+ki9jFyAoZBDNINzoSuaVP8
         DRi6XkMQq/eiVwIXL+Z83dqr0PMQMmH8cJ3W9i91tR674AtSAu89N1/uqi1sgZUN6cgs
         raBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741815582; x=1742420382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKFHOiH7vdn0PPU6luFtvgPLKGiMnG0ZWi5O03HOXyI=;
        b=jsoDYfDOBJv3wtPvB1jWfIsa1HXHK2rXFx3oPn4gDIhSU0Kz2QpmTifen5DF8idj2z
         4wSeIPy+aOYmHTvG2eRZkl2TGaJHdJtJs6Lmk2YiN2FvCk0khLas8vQ2Jeem/j9sf3Du
         xs144EnfRMAM9trP+RdtIzdmBnskggl/NVDkGylLxm3IyaIihpjR/dHZX6lk7y3ECJ43
         6sh7XGTIutxthdC00N+il0QOGVQittP/orbApgvRZfL6eHxn9DBR+79QKr1odxObI3nx
         AHQArXOge7JKt1Ee8u402MNPr0fzY9njW1BVPrjgiWCo5O+DBhponUrqcWKoFMAhsxZJ
         EHpg==
X-Forwarded-Encrypted: i=1; AJvYcCUiWYyz3/NQiMPIwQIPT9leWf2uyBteCPsQcEp/Z6JVpg4FGZdZgfsRcbWbVFW8LmnrUXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyguRkXxZn256bTvo1Z0aYKoO8i8agSKgF4psLt32xyhctUNmeC
	Anam2k3E3kZRDUdRzzVa50a9bH4Fw6xlXEB1A99x+dNuhhyXhixB+KoTjcfBThyocqSJweD6tiO
	o84bRrwMzh2I8hpE0XCBxxyh9iWBPrw==
X-Gm-Gg: ASbGncuUwczBvnYmifPC5rjVD627LlFmeNWXARRkk1ObBy4BTvXsxWVrqcsxQxK8IPS
	7am0bkEpmzlOVslf0U+zTQIPmNYqtnu7VUQCVt23wQadV3Q7anHaAgxDzSUDdh3qSRmrCs/D96E
	XCclcMr1XGRVheR/EMx5m92AYAmuotb7tZ5HUCB7UeVZU19aj3LMfdRKVf0zY=
X-Google-Smtp-Source: AGHT+IEg/uRj7Zjoq+FfSNeO+eRezZGqUKgmRc0kFRjMkjle/Nkaq1izFDzsv2AgMq0/9iKNadSo5FoAW2B8VBlg3GM=
X-Received: by 2002:a05:6602:4893:b0:85d:a69f:371d with SMTP id
 ca18e2360f4ac-85da69f39c7mr857524239f.4.1741815582024; Wed, 12 Mar 2025
 14:39:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
 <9f73e54224d55b40faeb5d68ebd7ff0c13d69c7b.1741362522.git.gitgitgadget@gmail.com>
 <Z9FAgCSCZSJnzv9d@pks.im>
In-Reply-To: <Z9FAgCSCZSJnzv9d@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 12 Mar 2025 14:39:31 -0700
X-Gm-Features: AQ5f1Jo26TjCHJy7Hqzv3SXD93wFpZhvNdgprE_mvlJpu_I7HYm-ENa_K1pI3Sc
Message-ID: <CABPp-BGUjLm+G1_LsEOp3P2b962rADxmgoWxn1MgREHWiTvOQA@mail.gmail.com>
Subject: Re: [PATCH 1/3] merge-ort: add new merge_ort_generic() function
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 1:06=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Fri, Mar 07, 2025 at 03:48:40PM +0000, Elijah Newren via GitGitGadget =
wrote:
> > diff --git a/merge-ort-wrappers.c b/merge-ort-wrappers.c
> > index d6f61359965..62834c30e9e 100644
> > --- a/merge-ort-wrappers.c
> > +++ b/merge-ort-wrappers.c
> > @@ -64,3 +68,63 @@ int merge_ort_recursive(struct merge_options *opt,
> >
> >       return tmp.clean;
> >  }
> > +
> > +static struct commit *get_ref(struct repository *repo,
> > +                           const struct object_id *oid,
> > +                           const char *name)
> > +{
> > +     struct object *object;
> > +
> > +     object =3D deref_tag(repo, parse_object(repo, oid),
> > +                        name, strlen(name));
> > +     if (!object)
> > +             return NULL;
> > +     if (object->type =3D=3D OBJ_TREE)
> > +             return make_virtual_commit(repo, (struct tree*)object, na=
me);
> > +     if (object->type !=3D OBJ_COMMIT)
> > +             return NULL;
> > +     if (repo_parse_commit(repo, (struct commit *)object))
> > +             return NULL;
> > +     return (struct commit *)object;
> > +}
>
> This is an exact copy of the same function in "merge-recursive.c".
>
> > +int merge_ort_generic(struct merge_options *opt,
> > +                   const struct object_id *head,
> > +                   const struct object_id *merge,
> > +                   int num_merge_bases,
> > +                   const struct object_id *merge_bases,
> > +                   struct commit **result)
> > +{
> > +     int clean;
> > +     struct lock_file lock =3D LOCK_INIT;
> > +     struct commit *head_commit =3D get_ref(opt->repo, head, opt->bran=
ch1);
> > +     struct commit *next_commit =3D get_ref(opt->repo, merge, opt->bra=
nch2);
> > +     struct commit_list *ca =3D NULL;
> > +
> > +     if (merge_bases) {
> > +             int i;
> > +             for (i =3D 0; i < num_merge_bases; ++i) {
> > +                     struct commit *base;
> > +                     if (!(base =3D get_ref(opt->repo, &merge_bases[i]=
,
> > +                                          oid_to_hex(&merge_bases[i]))=
))
> > +                             return error(_("Could not parse object '%=
s'"),
> > +                                          oid_to_hex(&merge_bases[i]))=
;
> > +                     commit_list_insert(base, &ca);
> > +             }
> > +     }
> > +
> > +     repo_hold_locked_index(opt->repo, &lock, LOCK_DIE_ON_ERROR);
> > +     clean =3D merge_ort_recursive(opt, head_commit, next_commit, ca,
> > +                                 result);
> > +     free_commit_list(ca);
> > +     if (clean < 0) {
> > +             rollback_lock_file(&lock);
> > +             return clean;
> > +     }
> > +
> > +     if (write_locked_index(opt->repo->index, &lock,
> > +                            COMMIT_LOCK | SKIP_IF_UNCHANGED))
> > +             return error(_("Unable to write index."));
> > +
> > +     return clean ? 0 : 1;
> > +}
>
> There are two differences here:
>
>   - We use `error()` instead of the custom `err()` function that
>     "merge-recursive.c" uses. I'm happy to see us using standard error
>     reporting.
>
>   - We don't have the check for `num_merge_bases =3D=3D 1`. I have no ide=
a
>     why we don't have it, and it's likely that other readers may be
>     puzzled in the same way. So this is something I'd expect to see
>     explained in the commit message.

Yeah, it looks like when I was splitting commits, I had more of this
explanation in a commit which was explaining differences in testcases.
I'll copy the relevant bits here.  Thanks for reading carefully.

>
> Other than that this function looks identical.
>
> > diff --git a/merge-ort.c b/merge-ort.c
> > index 46e78c3ffa6..b4ff24403a1 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -5186,6 +5186,8 @@ static void merge_ort_internal(struct merge_optio=
ns *opt,
> >               ancestor_name =3D "empty tree";
> >       } else if (merge_bases) {
> >               ancestor_name =3D "merged common ancestors";
> > +     } else if (opt->ancestor) {
> > +             ancestor_name =3D opt->ancestor;
> >       } else {
> >               strbuf_add_unique_abbrev(&merge_base_abbrev,
> >                                        &merged_merge_bases->object.oid,
> > @@ -5275,8 +5277,13 @@ void merge_incore_recursive(struct merge_options=
 *opt,
> >  {
> >       trace2_region_enter("merge", "incore_recursive", opt->repo);
> >
> > -     /* We set the ancestor label based on the merge_bases */
> > -     assert(opt->ancestor =3D=3D NULL);
> > +     /*
> > +      * We set the ancestor label based on the merge_bases...but we
> > +      * allow one exception through so that builtin/am can override
> > +      * with its constructed fake ancestor.
> > +      */
> > +     assert(opt->ancestor =3D=3D NULL ||
> > +            (merge_bases && !merge_bases->next));
> >
> >       trace2_region_enter("merge", "merge_start", opt->repo);
> >       merge_start(opt, result);
>
> These two hunks look related to my above observation that we don't have
> the check for `num_merge_bases =3D=3D 1`, as in "merge-recursive.c" we us=
ed
> to set `opt->ancestor =3D "constructed merge base" if so.
>
> Patrick
