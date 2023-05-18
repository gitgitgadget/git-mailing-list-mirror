Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FDDC77B7D
	for <git@archiver.kernel.org>; Thu, 18 May 2023 10:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjERKBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 06:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjERKBl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 06:01:41 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C8410CA
        for <git@vger.kernel.org>; Thu, 18 May 2023 03:01:40 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-561da492bcbso19033597b3.3
        for <git@vger.kernel.org>; Thu, 18 May 2023 03:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684404099; x=1686996099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VvBwNH/VQ2SXvXTfkjF2haXUfdmaDcnD/sCyz7y3do=;
        b=GiMRj84VZtyprRW3dSKAj7o/2YeUAzh5hEY0E3ghXdnVnFoRdUuDg6zXS1iXH/kuHA
         Dp/UBZ3IsDjcmqlkfLvzeRtm3xuxktBW77BdLvwbPK9W5MedGBZDysN9liuUmzl/19KC
         7LmcLZfzFwnfmF4RrUyz+S9XnFkvY13YZRIY9DebwPXia/wTGYU5ZzXocSQhMzdVTtFb
         QAK3sWAMvY+oxca1FgaVsW/hJzF346LC+S4O65hONWdxb65CX4fF2m/UV8ZeFXJLAW58
         ZvWH5MIdNyzdpiD8GR/KFHzF9cD4H3oARNKrVkCqiJ92kLlhdtZ0bPO1fmezAknP50Tq
         LOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684404099; x=1686996099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VvBwNH/VQ2SXvXTfkjF2haXUfdmaDcnD/sCyz7y3do=;
        b=HtebLyx7KdcYp/fzajlntEK9JAdLzy6nML1PLo696ZljO1yJoRn9RIy4xkQMzmEfi5
         V04Wny7eoG/UyqQaih6ggk1r73InzvIPR+6EnKvI2+k7gwZ6EpBIvSfwRJuO5kzVtWRH
         VZNaSgNM4uhK5jFw3PVVlVKcVSx/g0g/1FvOlUtTguWSrgwR/SkQ6j/lF8wLflozcB8j
         M3+wt+8IX65Qf82OSPccCADWAqNNs7DlFyBkfhsot7VPaELtcpd6m7s5KuDgLGqpSO4C
         NzxCQ66aRY+l9WHzsexVpHDyo3f/CErLh1qEDVAzJ+BhxuRrihomv9JLOPAtqsX/BBC/
         8jrQ==
X-Gm-Message-State: AC+VfDyLiyYJNfWHAfq4ZOmQ4CmaDRZ66GFQc2HKKT73FDG0jmP70gbv
        N8Y7XZnpuXFHXSmD7WDooeakOJK+RtrI9TrEu46ktLSAnaqbZgXS
X-Google-Smtp-Source: ACHHUZ75pZCwBnTwXNK/t3El/YNPEzEwZmHbrzSCejJbYq8f3ZTi8JbKTCsAwWrLZFfW8aYwoiaAv7MYmZbhgQGz5Ak=
X-Received: by 2002:a81:a1d0:0:b0:561:e2dc:fc60 with SMTP id
 y199-20020a81a1d0000000b00561e2dcfc60mr799844ywg.25.1684404099496; Thu, 18
 May 2023 03:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1533.git.1683969100.gitgitgadget@gmail.com>
 <3f8884457d3628439aa9e6800c976f5a597cdda3.1683969100.git.gitgitgadget@gmail.com>
 <xmqqednicho7.fsf@gitster.g>
In-Reply-To: <xmqqednicho7.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 18 May 2023 18:02:43 +0800
Message-ID: <CAOLTT8TEN38j8k6fnzcTs3X_a7yTrKysi50Nt7sH2bdbgWkwEA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ls-files: add %(objecttype) atom to format option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Martin Monperrus <martin.monperrus@gnieh.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2023=E5=B9=B45=E6=9C=8815=E6=97=
=A5=E5=91=A8=E4=B8=80 13:00=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Sometimes users may want to align the feature of
> > `git ls-files --format` with that of `git ls-tree --format`,
> > but the %(objecttype) atom is missing in the format option
> > of git ls-files compared to git ls-tree.
>
> "Sometimes users may want to" sounds a bit awkward; even if no user
> notices that the two very similar commands supports different subset
> of the vocabulary without good reason, wouldn't we want to align the
> feature set of these two commands?
>
> > Therefore, the %(objecttype) atom is added to the format option
> > of git ls-files, which can be used to obtain the object type
> > of the file which is recorded in the index.
>
> And from that point of view, this conclusion has a bit more to think
> about.  Is the %(objecttype) singled out here only because somebody
> happened to have complained on the list, or did somebody went into
> the list of supported atoms between two commands and considered what
> is missing from one but is supported by the other, and concluded that
> only adding this one atom to ls-files would make the two consistent?
>
> I would not complain if it were the former, but it must be explained
> here in the proposed log message.  That would encourage others to do
> a follow-on work to complete the comparison to fill the gaps on the
> both sides.  If it were the former, saying so explicitly in the
> proposed log message will save others---otherwise they may try to do
> the comparison themselves only to find that this was the last one
> remaining discrepancy.
>
I think the original requirement is that users wanted to obtain a similar
output format to the default output format of git ls-tree directly through
git ls-files --format=3D"%(objectmode) %(objecttype) %(objectname)%x09%(pat=
h)",
but found that the corresponding functionality was missing.

However, from a deeper perspective, the results displayed by git ls-files
for the index and git ls-tree -r for the tree are very similar. Making
git ls-files compatible with the atoms of git ls-tree can provide a
unified view here,
and can also be used for some conversion between the index and tree, such a=
s
git ls-files --format | git mktree.
