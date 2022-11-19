Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A027C433FE
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 01:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbiKSBiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 20:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiKSBhq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 20:37:46 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C75173553
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 16:41:40 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id a29so10749160lfj.9
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 16:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pA/mS/L9kd9zz4Dwtp4ScR+7JLb27S7zu562nBEvBwI=;
        b=TMIG61rQE0/zBYNsCoxYWs17WsrDhxaS3OFcKVVW7v0gw137cXGc1UQjl0E5xqOS10
         NWDXXiusxOowMFLDa4lsZbikiHRKBTXQapm8TjjCYKw9n1PVZf1+ceXX5vJAqdQNhyPR
         EswqKgXYGEU9OCAdPUeMz9WGe4nAhYv41/NJ+kN+FzmV+hlE2fQbNWzBsaF/husk1PoL
         ClkBYuLQCExexMNYNqGONuuGgLgCmu6vNcsYPUQx0IlpMKO1Ox6utktYvmNABwM1H3Jm
         k1Jqe5SqMXEsOTgXxSfWwuH8uZ/QbkJpErmfc6dcMews/AGFjkgr2tvKJnegJ2j/GG3r
         WwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pA/mS/L9kd9zz4Dwtp4ScR+7JLb27S7zu562nBEvBwI=;
        b=p16E+0TjTo0xyAAhk/LvCLNzoxbOYP4G8jkwnhuHYbn9tN6Ufocwukez370XPvkt11
         Zj0dnedT/M94kTICJUMleBLmKBXwsbFbrnyUNKLtMawaPSi2dteYQqBWxKSFfXd8gDu1
         D6pBN25Wb1+A8geFJtx7tqNidrCZGof0tsfThGvV0Ao2DqNC18W19WClJSGutEAEmsNz
         YcIz3Di0KDjQ8geU0XGUOzBrD8/ZdKrDvvRwxJ3wcs09XWI1wuW6P0XDtvSiNx/NKJm0
         TU4nLKLD7BA8k1YiYOLSeBrM1TCFx6R6PSSvZQkeW+chwF/JsQfsSMjjr0IxRcFLaK92
         67lA==
X-Gm-Message-State: ANoB5plQPmRHDKssALPPGCcVaf4VKHNDiHzI5aA/gk7sKIo2DcjEHkUo
        LgCnoQUDn5MZFRXhLpwUxq9HKqJ81QCZJnqYvaZMGwT2
X-Google-Smtp-Source: AA0mqf4YE+EcuzUN9uQMiDmgst6mM6iAQt58YgoakzpWXM+BIMmiN/X62ZOUVsZFfW9WNype5U89J59xPL88wd/NvXU=
X-Received: by 2002:a05:6512:280e:b0:4a2:5154:ead9 with SMTP id
 cf14-20020a056512280e00b004a25154ead9mr3297054lfb.32.1668818498210; Fri, 18
 Nov 2022 16:41:38 -0800 (PST)
MIME-Version: 1.0
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
 <CABPp-BEZK2KJHY+=Ta3VUzNjJKY=evPiAtp5UQFTVLMD0qreVQ@mail.gmail.com>
 <0e156172-0670-2832-78cb-c7dfe2599192@github.com> <xmqqiljbkfg9.fsf@gitster.g>
In-Reply-To: <xmqqiljbkfg9.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 18 Nov 2022 16:41:25 -0800
Message-ID: <CABPp-BGqXbO9SyF_V_fPEOcZ2uQEWzr0V+KrdcHmfWOq3upniQ@mail.gmail.com>
Subject: Re: [PATCH 00/30] [RFC] extensions.refFormat and packed-refs v2 file format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 18, 2022 at 3:31 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Derrick Stolee <derrickstolee@github.com> writes:
>
> > On 11/11/22 6:28 PM, Elijah Newren wrote:
> >> On Mon, Nov 7, 2022 at 11:01 AM Derrick Stolee via GitGitGadget
> >> <gitgitgadget@gmail.com> wrote:

> I have been and am still offline and haven't examined this proposal
> in detail, but would it be a better longer-term approach to improve
> reftable backend, instead of piling more effort on loose+packed
> filesystem based backend?

Well, Stolee explicitly brought this up multiple times in his cover
letter with various arguments about why he thinks this approach is a
better way to move us on the path towards improved ref handling, and
doesn't see it as excluding the reftable option but just opening us up
to more incremental (and incrementally testable) improvements.  This
question came up early and often in the cover letter; he even ends
with a "Relationship to reftable" section.

But he is clearly open to feedback about whether others agree or
disagree with his thesis.

(I haven't looked much at reftable, so I can't opine on that question,
but Stolee's approach did seem eminently easier to review.  I did have
some questions about his proposal(s) because I didn't quite understand
them, in part due to being unfamiliar with the area.)
