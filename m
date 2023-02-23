Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F129C61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 19:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBWTz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 14:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBWTz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 14:55:56 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE9955054
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 11:55:55 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id s20so14888838lfb.11
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 11:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rvzNY2TbQ70ARtIsbt+fYJAgEGnXFhmYAv91IX76Mt0=;
        b=QmvIIsycloz/FfvXW3jJZ2gkH/szEXcLkqlvJAsQwWoZecElm+qs+3cBi5YuAZARte
         CdyFctJzSKX5/c+ccZjQfHyqVvAQiYP0BQi4K8IwsfVBIlGs92QX0dIa5o5Gfq9mqFoW
         axbysWVWfWBueMwzfVZYLIUFEtvl4/ZIG4tOC1uqCUBuFt4+NCIaJe2XL2tMdgHN7qdG
         Mfu47W7SgndkB/g9nSTlrBKqrk/oDoJDRgG5JBN1pmTtddssC+MW5GiDxEyQgLMfp6W/
         1a7uXFkJ754BOhrYEya9p2iHd8TkJ2riB6eDHcVvmZHSS04soWt8IURQbHxL7Ol033ic
         H9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rvzNY2TbQ70ARtIsbt+fYJAgEGnXFhmYAv91IX76Mt0=;
        b=uCtn/NBWCtAlKu3EkbSZ4a/fh0MyRNOgpZMAB7NC6hq7fJv9Haju7RL866j0lAgSVC
         dfZBdOGHe5UAbPiqc5jv2/IbOnB1pgrWUwmgj9E7KPMcapaogdQ/IMQ6JLAlL4p8WOeT
         nV+67eWWn/P95RdAcKu9065IPDk9HkvKBOylHPKXg6IXo8hMBh45sgGuV6QF1GHGzI+4
         kddiU4IyAtdby9fDCYaKBpS+yZ6KgIv7NrG8ONJROGY20kuRNnXDnGJ8EgbJB6AgLmLr
         XYzpOaRL6+osypUwQLeVH+f4HKbYkfU7Aiv1COyKWHWhRw+/nTuii9R6RE2dAK6Umysu
         l+8g==
X-Gm-Message-State: AO0yUKUNZulBr8XeuSDYnYREZPsbVnIp6uGe15OgZgUboJLMLbOWT4hI
        pM1mukdFsC4F2DHyncJTnGWNnHT8CkaEp2NHuBoO38FjCZg=
X-Google-Smtp-Source: AK7set98kPaS58wMFrGdzkh+btizCOFzNXA3z77Hzm6G//Cfz/BeQ3e01Ax73ftuLNKgzKBwEv0eYRWiMs1LNrtb3GI=
X-Received: by 2002:ac2:5206:0:b0:4db:3501:5d66 with SMTP id
 a6-20020ac25206000000b004db35015d66mr4171145lfl.2.1677182153784; Thu, 23 Feb
 2023 11:55:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
 <c42261483cff903c8742fd8e1423ac0b14c65099.1677139522.git.gitgitgadget@gmail.com>
 <1bdd1b4f-ca8e-5790-ef24-7e289692a721@github.com>
In-Reply-To: <1bdd1b4f-ca8e-5790-ef24-7e289692a721@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 23 Feb 2023 11:55:41 -0800
Message-ID: <CABPp-BEayudVwVe+Xcm+43+DvnABuA3usXehWf7Rnm-eznES7g@mail.gmail.com>
Subject: Re: [PATCH 12/16] object-store.h: move struct object_info from cache.h
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2023 at 6:20 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 2/23/2023 3:05 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Move struct object_info, and a few related #define's from cache.h to
> > object-store.h.
>
> > diff --git a/replace-object.h b/replace-object.h
> > index 3fbc32eb7b7..3c92ae94610 100644
> > --- a/replace-object.h
> > +++ b/replace-object.h
> > @@ -1,6 +1,7 @@
> >  #ifndef REPLACE_OBJECT_H
> >  #define REPLACE_OBJECT_H
> >
> > +#include "cache.h"
> >  #include "oidmap.h"
> >  #include "repository.h"
> >  #include "object-store.h"
>
> This seems like an unlikely side-effect of the changes you're
> making. What is the reason we need this?

I'll add the following to the commit message:

A surprising effect of this change is that replace-object.h, which
includes object-store.h, now needs to directly include cache.h since
that is where read_replace_refs is declared and that variable is used
in one of its inline functions.  The next commit will move that
declaration and fix that unfortunate new direct inclusion of cache.h.
