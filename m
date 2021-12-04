Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5785FC433EF
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 05:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbhLDFtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 00:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhLDFtI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 00:49:08 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B26C061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 21:45:42 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id t5so20037770edd.0
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 21:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5dntss3Z+D6T3ssA7SkcPglfO44LTYdkDMlUdC4jNF0=;
        b=LWsdemeD1OZ9EmbHvmwcc6IBOxGp0tuVkliBWfIa/VgxJrVtivvn4ErYbkupHWZk62
         lSKYKKhWGIGBOLPEgADKBrIGB4y6gRcfnyQbGP5S8cDJeC4EgXudiTpVLG8Y10yqV7Rn
         dE4B3SOAK2RLMGJcmqo2UTPeCe9CPB2MVyMqLkn5sl6LVkhNnOId0+IWrMQ7/27/MhuF
         EJJH7ZFMe/OXEKIYWiM2lnbJdOfX7/YzTbTFmtwtDOJfm4kr/pgGjY3g8IE+tevcaxbB
         ce+OwTHkSkPhmiSj/oNmF/wWavtxJ+A4xViXDAN/PVgLCt2+fwb04xlWbA86ddPSZAqi
         EgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5dntss3Z+D6T3ssA7SkcPglfO44LTYdkDMlUdC4jNF0=;
        b=KbB8Vuzpt9cVvcCZzudIzAm1WR6f4MaNANrjvkhQg2u1jgJjT6XiKT1RVler8ITWaF
         ifE0C70mJNreqrC0yqje1owl3lt4lyTAD7u/2hwZp1uCFD0MF6Bpj/q68JtG+/3pGotU
         YPJf54GJNWXTFzssHVBXmX8qLEV5HtDRJ1JaZsIucUCVVOJl9H83jbgqE3IpCEpw/Hk5
         7e19Se+1CycNLP+6iKWmVJs/R7B7d54MEOz9EnDWBHIgU2WsKDHed3L4SxwhZsNbyv+X
         r7805HMzkoJsDM612oTcBWARqd9hVVkaUjiaEK747Vr4ozXju5SWPnodC3hP/o1nd5Dr
         71zw==
X-Gm-Message-State: AOAM5320Y+VqgSYIiJn2akleZYOiIVrC22ug776Di5MNnuSGMeQizpAl
        IEoWpDyx1JNdrHZWo0jgcUJffDb3JpVqdk/Zouk=
X-Google-Smtp-Source: ABdhPJzWE3Vfgd+fbl7VWezapbc/KOmh8gVq0QLOL3wlDrgpBpi6kqC/ia2fRSACsRpfM/iZPPe14L5B+hdoAzfxEU4=
X-Received: by 2002:a05:6402:d73:: with SMTP id ec51mr32346391edb.175.1638596741422;
 Fri, 03 Dec 2021 21:45:41 -0800 (PST)
MIME-Version: 1.0
References: <pull.1092.git.1638586534.gitgitgadget@gmail.com>
In-Reply-To: <pull.1092.git.1638586534.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 3 Dec 2021 21:45:30 -0800
Message-ID: <CABPp-BHHqLvnMbR5Q+UmfTy7GPy4vz73zZdNc99PogCyxTFJHw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Sparse Index: fix a checkout bug with deep
 sparse-checkout patterns
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 3, 2021 at 6:55 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This week, we rolled out the sparse index to a large internal monorepo. We
> got two very similar bug reports that dealt with a strange error that
> involved the same set of paths. One was during git pull (pull was a red
> herring) and the other was git checkout. The git checkout case gave enough
> of a reproduction to debug deep into unpack-trees.c and find the problem.
>
> This bug dates back to 523506d (unpack-trees: unpack sparse directory
> entries, 2021-07-14). The reason we didn't hit this before is because it
> requires the following:
>
>  1. The sparse-checkout definition needs to have recursive inclusion of deep
>     folders (depth 3 or more).
>  2. Adjacent to those deep folders, we need a deep sparse directory entry
>     that receives changes.
>  3. In this particular repo, deep directories are only added to the
>     sparse-checkout in rare occasions and those adjacent folders are rarely
>     updated. They happened to update this week and hit our sparse index
>     dogfooders in surprising ways.
>
> The first patch adds a test that fails without the fix. It requires
> modifying our test data to make adjacent, deep sparse directory entries
> possible. It's a rather simple test after we have that data change.
>
> The second patch includes the actual fix. It's really just an error of not
> understanding the difference between the name and traverse_path members of
> the struct traverse_info structure. name only stores a single tree entry
> while traverse_path actually includes the full name from root. The method we
> are editing also has an additional struct name_entry that fills in the tree
> entry on top of the traverse_path, which explains how this worked to depth
> two, but not depth three.

Thanks for the detailed explanation.  I looked around for similar
potential problems elsewhere, but only noted that the comment at the
top of the function is also wrong and should be updated (as I
commented on Patch 2).  After you fix the comment similarly, feel free
to add my

Reviewed-by: Elijah Newren <newren@gmail.com>
