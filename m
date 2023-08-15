Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DB9C41513
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 08:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbjHOIG3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 04:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235539AbjHOIFz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 04:05:55 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCC61733
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 01:05:53 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe32016bc8so46350625e9.1
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 01:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692086752; x=1692691552;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDkhM5QRshos5EP2iUppE1deAcsi4etzn31IyJLYpe8=;
        b=jXdnzcVbai8j6RQjoAFUYOM7zOwUqzSh5iSIrXbE2nMjOTz/q5l/SaQwoRPE/ORbb+
         qmBkCXJAYuHDXOlAOshrC86Hfq77TadRXcTw8O5kTVfIDrLig452+3C1MI3rbkilRMb1
         YgS38okjwSVxLOl1kYmMIDl7d3gf+1/cERMIWoRcYqrd47edsiEsrUP8EG5zfYNtEmtl
         ZMX+YK/fLYYFmbzCX8oJUD0pNdjU5tyVCnS2lCk2ObWXfPCK94NJ0lFMsrziQ7pyIFNV
         imu0zA9XUFU3WaUgPNyVZpzHrEPpdTDP75I/PqM2OgQI07f4B0mYq8ZtEliY/lWSxqaE
         jBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692086752; x=1692691552;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDkhM5QRshos5EP2iUppE1deAcsi4etzn31IyJLYpe8=;
        b=gNBy7+cSCVF5x/RBY4yLwkMGRO9HVsbjoYJElhjGe5CyBzrZAGZhPRh78i+B9PNUPZ
         KXIuVfIOxjF+mvPHlir7AlIwZfJwtc1V6BQ/m3ufO+xC88QVqzPWP8/Q2um56A0pKYVt
         Mvh4HPnjGH5/yaPskWjMD1mRy5FJLElMqgqfWslji+v0ySzEHYpukUZCtzaDZul+M6yo
         TFFHFv1v7CB5X1c7o3SN+0bM/WvOuadrPs6tWxwz1NRcipDSytukgOPNbQwNSDxzYoP4
         CJ8p04cbrok3GH6cIShZAW9oOoHApjkveKRZYXgSV12HbIYPXiIG0dsLIF2hdDJRohok
         6HDA==
X-Gm-Message-State: AOJu0YwRbu7ArVxOiixVS49tmHRzwT8BE/6Zs0/JTSWpZnYLNBSfDXBp
        KIZ1bMNTXYkFR/odsG/Pdbhkxs2nIyF0+locKZe0Hg2hU9ofqcHt
X-Google-Smtp-Source: AGHT+IH5jP/8t9h1az7DQ1Wh04voBus/f54qUFuXHRf85jaQROrE3kqXZ/knvVlwIOun5TalPwGUBlNZNP8UJp5pPVM=
X-Received: by 2002:a5d:4e46:0:b0:314:1ad7:2ea8 with SMTP id
 r6-20020a5d4e46000000b003141ad72ea8mr6932321wrt.54.1692086751581; Tue, 15 Aug
 2023 01:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230711133035.16916-1-cheskaqiqi@gmail.com> <20230718232916.31660-1-cheskaqiqi@gmail.com>
 <20230718232916.31660-3-cheskaqiqi@gmail.com> <5e478d8b-9ef4-864b-41e4-e0a79877d278@github.com>
 <kl6la5v82izn.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6la5v82izn.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Tue, 15 Aug 2023 16:05:40 +0800
Message-ID: <CAMO4yUEwjAfe93Kur5XFzrzXLYpP4=vOg17vDvW-cFmjYLAnOw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] attr.c: read attributes in a sparse directory
To:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen,

I just realized I missed your previous email =E2=80=93 my apologies for the=
 delay!
Really appreciate your insights on the patches=EF=BC=81

I'm trying to wrap my head around the points you've made. If I'm reading
you right, you're suggesting that in my patch2, the logic for 'read from
a blob if the .gitattributes is not in the index' isn't being executed?
You think the index is still being expanded and hence this part of the
code doesn't influence the test results. In particular, you're referring
to the 'check-attr with pathspec outside sparse definition' and
'diff --check with pathspec outside sparse definition' tests, right?

I tried out the code changes you shared, but the tests didn=E2=80=99t pass =
for
me. In the original setup, even with the expanded index, the base code
couldn't read the attributes from files within a sparse directory.
So, I'm inclined to think that the modifications in patch2 have a direct
bearing on whether the tests pass or fail.

Would love to hear more about your thoughts on this. Thanks again for
diving deep into the patches=EF=BC=81

On Fri, Aug 4, 2023 at 12:22=E2=80=AFAM Glen Choo <chooglen@google.com> wro=
te:
>
> Here's something odd that I spotted that I think other reviewers haven't
> mentioned. That said, Victoria has already given quite extensive review
> and I trust her judgement on this series, so if I accidentally end up
> contradicting her, ignore me and trust her instead :)
>
> Victoria Dye <vdye@github.com> writes:
>
> >> -test_expect_failure 'check-attr with pathspec outside sparse definiti=
on' '
> >> +test_expect_success 'check-attr with pathspec outside sparse definiti=
on' '
> >
> > Re: my suggested change to the test in patch 1 [2], when I applied _thi=
s_
> > patch, the test still failed for the 'sparse-index' case. It doesn't se=
em to
> > be a problem with your patch, but rather a bug in 'diff' that can be
> > reproduced with this test (using the infrastructure in t1092):
> >
> > test_expect_failure 'diff --cached shows differences in sparse director=
y' '
> >       init_repos &&
> >
> >       test_all_match git reset --soft update-folder1 &&
> >       test_all_match git diff --cached -- folder1/a
> > '
> >
> > It's not immediately obvious to me what the problem is, but my guess is=
 it's
> > some mis-handling of sparse directories in the internal diff machinery.
> > Given the likely complexity of the issue, I'd be content with you leavi=
ng
> > the 'diff --check' test as 'test_expect_failure' with a note about the =
bug
> > in 'diff' to fix later. Or, if you do want to investigate & fix it now,=
 I
> > wouldn't be opposed to that either. :)
> >
> > [2] https://lore.kernel.org/git/c3ebe3b4-88b9-8ca2-2ee3-39a3e0d82201@gi=
thub.com/
>
> Because the 'diff --check' test is broken, and 'git check-attr' still
> expands the index (as noted in the next patch), the code that implements
> 'read from a blob if the .gitattributes is not in the index' is not
> exercised by the tests in this patch (it gets exercised in the next
> patch). IOW, you can remove this logic and the tests still pass, like
> so:
>
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
> diff --git a/attr.c b/attr.c
> index 1488b8e18a..abfa2078ac 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -23,6 +23,7 @@
>  #include "thread-utils.h"
>  #include "tree-walk.h"
>  #include "object-name.h"
> +#include "trace2.h"
>
>  const char git_attr__true[] =3D "(builtin)true";
>  const char git_attr__false[] =3D "\0(builtin)false";
> @@ -847,9 +848,11 @@ static struct attr_stack *read_attr_from_index(struc=
t index_state *istate,
>             S_ISSPARSEDIR(istate->cache[pos]->ce_mode) &&
>             !strncmp(istate->cache[pos]->name, path, ce_namelen(istate->c=
ache[pos])) &&
>             !normalize_path_copy(normalize_path, path)) {
> -               relative_path =3D normalize_path + ce_namelen(istate->cac=
he[pos]);
> -               stack =3D read_attr_from_blob(istate, &istate->cache[pos]=
->oid, relative_path, flags);
> +               /* relative_path =3D normalize_path + ce_namelen(istate->=
cache[pos]); */
> +               /* stack =3D read_attr_from_blob(istate, &istate->cache[p=
os]->oid, relative_path, flags); */
> +               trace2_printf("Tried to read from blob");
>         } else {
> +               trace2_printf("Tried to read from index");
>                 buf =3D read_blob_data_from_index(istate, path, &size);
>                 if (!buf)
>                         return NULL;
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
>
> If I were writing patches and encountered this situation, I would squash
> patches 2-3/3 together since both are closely related and quite small,
> but I'll leave the decision to you + other reviewers.
