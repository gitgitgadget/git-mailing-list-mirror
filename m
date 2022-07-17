Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90559C433EF
	for <git@archiver.kernel.org>; Sun, 17 Jul 2022 16:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbiGQQhx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jul 2022 12:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGQQhw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jul 2022 12:37:52 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A79213DC3
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 09:37:52 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id v1so1315354ilg.4
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y1exaWAYrKrWPe2/RJxeEJEUklkWH2L3GgSt0FuKXDQ=;
        b=FLMoz4YPe69bILJX4C1/hlGD9r9Nbn7WA9G9itgdvujAptbBIc6afRcfpv1gvwM94i
         PzOXpQu70ZpnCX+aEj6B4YL5f1IZVptbtOIp2+YSxk2ImHpZzkPxBZTBnQU+pzKk5Szr
         QNVXP4aNSTmJI/YRPFuB6xUtpC+XqpvukOPS+6ozSZHamS2xrBFKimkI6THb8abVXdLm
         qoz6MVXpInj6UV8bt6N9U7maiLimRNXuO0msSNy8p9J4Y1DaxoEqYbHrCJdkiAcLD+rc
         yM6kPgohaI/qmUrKTxhQDYsWHYCjFhXVuVKmTSQA5avGL+fUk4HbUCCvMTX9J9Y94WOl
         iubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y1exaWAYrKrWPe2/RJxeEJEUklkWH2L3GgSt0FuKXDQ=;
        b=yFB+SH4e89KoiJEoxqEI2fXjHO/cqtmY+WqYSuxzz29vCn/Z0/sBl9RIm6eNRYCkyd
         xOIv0WPhSGPDHMnwUYaFyZV3vUtySWlz1nGpbtzm3/ilpAkbPZKnmijB1UjPlZfq55Qz
         uCn5jv9iZbPWOfWUxom2luWQvW2EJkCd9JnQq1Bz5VBD69vk03jDE/t9S5h4e/2U8pdb
         XI8DsV+U77mc7j5J+5dib+yXyDoVIsnR32ejnzXJxw+M4fwDfilGYWIxqp7banZiIu3/
         QdfD48C+RkCWi9CIcY0QMTjEwBM5DtEV12wqb0MxblVOraq26/H3WxCTYxH6STeKc78E
         ivmg==
X-Gm-Message-State: AJIora8A0Cij41s6infaob4e16SXMDkIIdp8h+EbpSjmdbBL2yjkF7Z9
        e7thZVbc6U1WYZZzz9OP8mu0PF2c5/wWlzo/eFM=
X-Google-Smtp-Source: AGRyM1vKWGowh2aqRRpgCiDhIdTeQt5AxjkV5H6Bm+5V9q9sWG9EksRurcE9wdNWUEqMYaQSFUR8RUUnCNeXAKQt5zg=
X-Received: by 2002:a05:6e02:1d95:b0:2dc:4746:6a2d with SMTP id
 h21-20020a056e021d9500b002dc47466a2dmr11045201ila.322.1658075871662; Sun, 17
 Jul 2022 09:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
 <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com> <4a8b7c9e06df36444b94b929b2558f40e3f72e81.1655621424.git.gitgitgadget@gmail.com>
In-Reply-To: <4a8b7c9e06df36444b94b929b2558f40e3f72e81.1655621424.git.gitgitgadget@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 18 Jul 2022 00:37:40 +0800
Message-ID: <CAOLTT8RhMZDYM0tuTR64VQRPaj8ghkU=jJdOnodV1txsXXpUQA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] merge: make restore_state() restore staged state too
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren via GitGitGadget <gitgitgadget@gmail.com> =E4=BA=8E2022=E5=B9=
=B46=E6=9C=8819=E6=97=A5=E5=91=A8=E6=97=A5 14:50=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Elijah Newren <newren@gmail.com>
>
> merge can be invoked with uncommitted changes, including staged changes.
> merge is responsible for restoring this state if some of the merge
> strategies make changes.  However, it was not restoring staged changes
> due to the lack of the "--index" option to "git stash apply".  Add the
> option to fix this shortcoming.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/merge.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 8ce4336dd3f..2dc56fab70b 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -383,14 +383,14 @@ static void reset_hard(const struct object_id *oid,=
 int verbose)
>  static void restore_state(const struct object_id *head,
>                           const struct object_id *stash)
>  {
> -       const char *args[] =3D { "stash", "apply", NULL, NULL };
> +       const char *args[] =3D { "stash", "apply", "--index", NULL, NULL =
};
>
>         if (is_null_oid(stash))
>                 return;
>
>         reset_hard(head, 1);
>
> -       args[2] =3D oid_to_hex(stash);
> +       args[3] =3D oid_to_hex(stash);
>
>         /*
>          * It is OK to ignore error here, for example when there was
> --
> gitgitgadget
>

Now git merge (all strategies) can learn to restore origin index state.
LGTM.

ZheNing Hu
