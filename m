Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9295AC636D6
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 18:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjBWSZt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 13:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjBWSZs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 13:25:48 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5145AB4F
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 10:25:35 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id a10so11801279ljq.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 10:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fveaV+1eGgTlQ8yyDrcVdFsydmCuaW7wQgy7m19/6to=;
        b=ExIKGaIzUI8kW4snDEocurhUHJfC6vUtzBMkwI7naomK289aNlboKcOpTMa2c9CAzw
         MHc10Nbt1kC193G/zVkZFm81anoE1Y3VMIJlNDwwHJnaxmcGdgNVgj1nHx1KHWT3f80b
         4/H4xdoYIC9vvxM4UNR5OPj7TrF0KPsLg/vdpdHP5D613cvBwBy2Z/TOuU9ApLhBWOQQ
         NBfewXG7Kvym+VNVmEY7LAIymJiP/SdJuLLkL6DUzCVO8td+lhFgueaVKoUMoNd1C5OV
         vrigCTztrLQenXpBP2yneG/pWgvhiEbltkYhOTf/TPvCy0+J6j3PLshe2BQNoPP7ycY1
         b06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fveaV+1eGgTlQ8yyDrcVdFsydmCuaW7wQgy7m19/6to=;
        b=3HvhNLbJCclm7AMxc3One7QNXrAMDlb9ePv9yzfgNDsm40y6gNTIxYE4kNMrUsCpnx
         NqiYIT9soJ5Q3L5/r22fEjMunPbpHQ/IwcgeLg7iEyayCUjYnpVKSXjdEZCyu1tecoIn
         ki9JBArX54ZX0hQsjwn1b6V0EzgueRlA+oKQ0O7j3+n5+GhzaWTKYV4o0Y5n9UNDM2Fk
         knnGvcSg7UV+UAYrIzZYhih7tFNOAhLnVcOjtUblZdg0h7ppxKSnZlu3YuPOu0obxyJR
         oqEOLwGuoXg4Sgt3qxJE3PXL2ow33/584rjebg5XY898wBgQ4J+z+SjiPZpLW5SZeziX
         WcUg==
X-Gm-Message-State: AO0yUKXnrqO8IRIx9sKrxkg8MNrkieqdM3FIQqlcMxqYUmin1Hk157hN
        cyHa+duISIJBsszkIFV7yF8q1RvMfeppr023wDI=
X-Google-Smtp-Source: AK7set9Fs7ftP2UtqefshYKXKRDzhLQEjaDPqeurooda6PQhLdenrkAH3koi4VGcXWy+NhAWAtpGMo4JDl7TyAIfRPI=
X-Received: by 2002:a2e:b4b1:0:b0:290:613e:d4a0 with SMTP id
 q17-20020a2eb4b1000000b00290613ed4a0mr4024294ljm.6.1677176733344; Thu, 23 Feb
 2023 10:25:33 -0800 (PST)
MIME-Version: 1.0
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
 <9f78f0f215595d55ead4d82d20e1d0c9892171ec.1677139522.git.gitgitgadget@gmail.com>
 <49082769-81b7-8a47-ace1-59c21b4396c9@github.com>
In-Reply-To: <49082769-81b7-8a47-ace1-59c21b4396c9@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 23 Feb 2023 10:25:20 -0800
Message-ID: <CABPp-BGccOAVSmOaqtohRWVBHk-nq7Wxtj=rCj1uZzJLszdYJw@mail.gmail.com>
Subject: Re: [PATCH 06/16] hash.h: move some oid-related declarations from cache.h
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2023 at 6:08 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 2/23/2023 3:05 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > These defines and enum are all oid-related and as such seem to make
> > more sense being included in hash.h.  Further, moving them there
> > allows us to remove some includes of cache.h in other files.
>
>
> > diff --git a/line-log.h b/line-log.h
> > index 82ae8d98a40..adff361b1bc 100644
> > --- a/line-log.h
> > +++ b/line-log.h
> > @@ -5,6 +5,7 @@
> >
> >  struct rev_info;
> >  struct commit;
> > +struct string_list;
> >
> >  /* A range [start,end].  Lines are numbered starting at 0, and the
> >   * ranges include start but exclude end. */
>
> This hunk seems unrelated to the current patch. Perhaps misplaced?

Yeah, I can see how it might be surprising, but this is necessary.
line-log.h includes diffcore.h, which prior to this patch included
cache.h, which includes the kitchen sink.  With this patch, diffcore.h
stopped including cache.h, and suddenly line-log.h has some 'struct
string_list *' parameters to functions that the compiler will complain
about.  Adding a forward declaration fixes it.
