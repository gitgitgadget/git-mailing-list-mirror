Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15839C43334
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 20:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiGPUvO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 16:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPUvN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 16:51:13 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8B215834
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 13:51:12 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id o21so6092539qkm.10
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 13:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aIvQK4FXi5JrtjRlNESi7keMaGXDyQ1/bl55tFvFmeE=;
        b=AYSmNuHv99lAiOl4M5LlfKtRK48yVCy6YzgrGZlXa6tg5OJArOpMlZH71/QtztM/QC
         85jD5TKj2FdNiLNyA6g/zMF6PUqqEU92g2LRT+XLXNSu60Tg66fYDovepHU2L7uWua0x
         nDo3+O468RskZgx4JUnFosEJh0CEa2U/FOp2mNL7UzxoVeAhdWEvTazZkYagZqJWJrO0
         NNlZxSLFtLQtd1vhSJEeiWMysB4G0p10IDseVSceqdSHELtGfAlyQNEwi8FMF71uX7qJ
         bCQj2NaqIIHyfXYoO4iOLGSSaS2cXXolgJH6E43bFU8PXq+CQ+2WejTUJKRQAfXkou0f
         OrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aIvQK4FXi5JrtjRlNESi7keMaGXDyQ1/bl55tFvFmeE=;
        b=5YsbhMvzFLh3XW18ARCTt68F3IKx1q7sswXd6UxBjdR+r4wF8wgWo9H8mNxlK+wYUr
         cxJv+gYswKxm/uZ+GTcKUxdqfxcgGrv8kPQBNdAN/mXKGITeJRfQGs+P7nV0cbEkaNQK
         N+4GKRQtxHPv4lcz1G3aTRzELQ2zmaO+nkW6iGtbpmDZ08ODwKO+3WWigkWi6fKRjWbx
         LfaLObqk37NDaU5eI5+yPo2OdeBu12lnmSs4/qc+LHclVPLV/n8WrrWPHpAx6IIjNa1o
         g5p4JmF3+HcZ1dnfPG9UQX2eylmQmUGPvbXvbKywEMFrqtI7CUax6/OmPY4nVF5eo+Py
         Qv7Q==
X-Gm-Message-State: AJIora/l/F3i0SR+0DsoME54o8yi8uZ6g+eYKB0glf8OtbTan7FLSeoz
        s32PvVd5SBzv+WdxYPfLcMfZzNhiKfytQjUGGGw=
X-Google-Smtp-Source: AGRyM1uEfy5a9i0T3b/0H2NJAJixHUAuXO8Py58QSNxtmzGv/ERJG4IGIEf0DsOR/1nicj0gbUjB6tb/OQ9tq0JmVEo=
X-Received: by 2002:a05:620a:4547:b0:6b5:879c:5891 with SMTP id
 u7-20020a05620a454700b006b5879c5891mr13362030qkp.187.1658004671811; Sat, 16
 Jul 2022 13:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com> <d5cd4b49e46bc2c186c6e89333360a975700c99a.1657631226.git.gitgitgadget@gmail.com>
 <11ff21b9-7169-00c5-95c0-130675ffe2ae@gmail.com> <fc2e8f9d-0232-4c19-2e4d-9ba6c9b17ab2@github.com>
In-Reply-To: <fc2e8f9d-0232-4c19-2e4d-9ba6c9b17ab2@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 16 Jul 2022 13:51:01 -0700
Message-ID: <CABPp-BHjWQahfHMOvvGL2WdReCpHgfjF9Yp5DHPiKebk0iSHbg@mail.gmail.com>
Subject: Re: [PATCH v4 12/12] sequencer: notify user of --update-refs activity
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 15, 2022 at 6:20 AM Derrick Stolee <derrickstolee@github.com> w=
rote:
>
> On 7/15/2022 6:12 AM, Phillip Wood wrote:
>
> > Thanks for the comprehensive commit message and for implementing an exc=
ellent suggestion from Elijah. I wonder if it makes sense to distinguish be=
tween the current branch and all the others when writing the update message=
 as we do here or if all the refs should just be in a single list. I also t=
hink it doesn't matter much and we can change it later if we want.
>
> I'm definitely open to suggestions, but I also think we should start
> somewhere and see what users think. Since the mechanisms for updating the
> refs are different, I felt it was appropriate to have different error
> messages.

I think the separate messages are fine, but I'm a little surprised by
the wording of this rationale.  The mechanisms for updating the refs
are implementational details that are likely not known by the end
user, and aren't something they can tweak either.  As such, I don't
think the mechanism used should result in any differences in end-user
messages here.

However, one difference here is that one of the refs' changes (namely,
the one corresponding to HEAD) will also have its changes be reflected
in the current working directory and index.  That may be a good reason
to keep its update message separate from the rest of the refs.

But on a related tangent...

I'm still curious if people are going to be surprised to not see an
"update-ref" line in the todo list for the HEAD ref; I was at first,
and only understood the rationale for excluding it based on the
implementational details.  I know as far as the implementation goes
that if such a line did appear in the todo list, then you'd probably
just ignore it (other then ensuring it was the last line) and then let
the pre-existing mechanisms in rebase update the HEAD ref...but even
with that implementation "weirdness", I think incorporating it might
be less surprising to the end user than the current behavior.  Or
maybe I'm just knee-deep in implementation details anyway, and I'm
just guessing what others might think.  I don't feel strongly about
it, just thought I'd surface the thought.
