Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1173C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 02:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjDRClT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 22:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjDRClS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 22:41:18 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6056440D1
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 19:41:17 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2a8baeac4d1so15479711fa.1
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 19:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681785675; x=1684377675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNxJDszVbx17IjGCqAAyG5l4Rxh1JPPAejHdD37riT8=;
        b=KoGC4XSLJVacCumK5RshJ4mS6/RQDl6IJl0RHZdeGD/ksYdGQzMuAp+V8knrDQc584
         2oaiZ4dbOgc7wS9R1irnLIQCHS6eg61OZpSSY2pIHG+wN2xOssCZJyIOMhY8ru484mbf
         oNXSr6I5DJd4am7jgMwIxYvWOpwB2vsC2zHIIuVUqdeI3MacJBl4NI9g2EbHXm0MaCGD
         Z9BCvyQQBrZ9mVK6QrT3ZibqGLyUdvUwQOqHfxW9GI16nWdXGV4dOXyHWPDTRXs1SuSE
         a5V0ekQKFEAZCpPxxYhJxsCe4/cOsRiLXuZ7v3b2IIUU3QnnOaXCAD1FSP6ygt5zUMMw
         pzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681785675; x=1684377675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNxJDszVbx17IjGCqAAyG5l4Rxh1JPPAejHdD37riT8=;
        b=SeQBexwjZgm94ZcF2pCuNuYPcMWaXmOB29Lr3CGPyBTIe9mu0JOMxlcvzVl8m1mR3L
         UL8yqq5fjYvqJKHRXdRCNSZda+ZcaRoVT834alSpc7rvmIN3a2AZRWlBNLwAC7fYvd8i
         9aeFa2Nhx6uxpB3PvGqygD7Cd88qHiLjvFKLDzHPz4f1L70yYvqtblO6gUVzYli1NkgF
         MizCcNOGV+hRWD2dmWcFJViSj9JqYMAzJtqjU3XYBf9jADkS1oM7P5qRLhkrPmQzezCH
         v0vhvDu9XTjqpIHSGcy34aPYY2lL7dNATrOIlPhIKR/D9yXGlbz4306erzBtOyvQS0I7
         cBuA==
X-Gm-Message-State: AAQBX9cbe28z/EoHY2MtGaDbcIE5+aOp2QV8cfmWb2w43Ay6pN/SjlR8
        /whhsffm1UHYoCpG2dO0tlgxz23BKR9dd4l6nKw=
X-Google-Smtp-Source: AKy350bRvCeO49rsqokaqJK0/8rJzFE+csI+2Jux18OcjQcUUcDW3ylaDJLpAjtBSffmp61tlJ8ERaytzbOp5oSimzo=
X-Received: by 2002:ac2:5383:0:b0:4ec:a052:9e93 with SMTP id
 g3-20020ac25383000000b004eca0529e93mr2738933lfh.7.1681785675361; Mon, 17 Apr
 2023 19:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com> <ce9ef1c6-23c1-2e9f-ed5f-3790e5ff3e1f@github.com>
In-Reply-To: <ce9ef1c6-23c1-2e9f-ed5f-3790e5ff3e1f@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 Apr 2023 19:41:03 -0700
Message-ID: <CABPp-BE4dsPc0u7D4mYtsQ6Ko-j1fOKfEwfmrpiCoAgvdG0AXA@mail.gmail.com>
Subject: Re: [PATCH 00/23] Header cleanups (more splitting of cache.h and
 simplifying a few other deps)
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023 at 2:07=E2=80=AFPM Derrick Stolee <derrickstolee@githu=
b.com> wrote:
>
> On 4/15/2023 11:03 PM, Elijah Newren via GitGitGadget wrote:
> > This series continues to focus on splitting declarations from cache.h t=
o
> > separate headers. This series also untangles some dependencies between
> > hash.h and repository.h, and between read-cache.c and tree.[ch], and cl=
eans
> > up a few other headers. At the end of this series the number of cache.h
> > includes drops from 189 down to 149.
>
> Thank you for continuing to do this work.
>
> >  * Patch 14-16: move functions between hash<->repository and
> >    read-cache<->tree to simplify dependencies
>
> My only comment was on patch 14, where I'm not sure I like the methods
> moving from hash.h to repository.h. If we can find an alternative, that
> would make me happy.

I'm not aware of one, but I tried to deviously nerd snipe an expert on
cleaning up compatibility macros for the_repository to see if he might
have any bright ideas.  :-)

Also, if you have any other ideas that might work, I'm all ears.

> The rest of the series looked very good.

Thanks for taking a look!
