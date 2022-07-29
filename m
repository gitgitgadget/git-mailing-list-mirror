Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C467C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 17:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbiG2RvQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 13:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238420AbiG2RvN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 13:51:13 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF9B491D7
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 10:51:12 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id v16-20020a17090abb9000b001f25244c65dso9066570pjr.2
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ekzf2Qx0wuosEmmLhPytpXhP4QJxxB3ecRZmrsxQSw8=;
        b=EtwIdi4t2w9ENcTXBjSaHMRWl/XrDEc5HmvMjkIA9ifIma0BvkFdxYJ8pbh2lzHHB1
         Q8cdIy4pEgcB37Usl3A3lxFKR1AVtymhikLlWbyolCFrKTswOvevnYLD9t9y/LnXR7nP
         m+zqT2GT8gE1dbX/QK+YIObSg/Vb9AcOzcWhentbwlr0ou+WH0lHV76JbYlVStrh0yIt
         YjlcUZs8uL/1sQZzZ9y4yOCag+lOhLfiDDb2V8aF+J6u7s5PPHboQd/Y331IWIXkQ+Is
         cG6ZuaNpC7Jb5vQLYSKHbpVPBR8fVeIpwgUIiWXIOk+j20JkhQcIjf4g3auQhhHEyq91
         VuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ekzf2Qx0wuosEmmLhPytpXhP4QJxxB3ecRZmrsxQSw8=;
        b=TYcllvHjqtyKTbHg2kTpW+c5IN932FSxY66GerFSJ0kMUwnmRH6fXZcCAHQCJIYNCh
         UAnFhKPfovTYhG9uebbvK2dKNuH8gglLckwpCVif0wFODGpzj/LzSNxOcfkAaDK1QMuT
         /pS6cHPWhtjmHUXJV2pGQZBmlq968FgnKsJQsV2WioGSv8KN2E/pxrikVaaUMsu7ZDOn
         zDoXWPv9/ezhKs7wxa0BJNj1x8g5C52mG+dtqWZpgFJhKRP2NMj/X/Q+T1dlcwjRvT1J
         Hja4KzLC+PrRVLzrz/HDmbsZKcfeURcyV3IsoYUq9oREH63tcOwx2qMJ2HaFOY8lq22g
         b1wQ==
X-Gm-Message-State: ACgBeo000E4YxIqdU3bluord4JYBKbV8LybWZ3EWvIGKNlupRIcPrl6D
        RSUN2ZCfvs7mGb9yZP1wTqJbMzbIKNk=
X-Google-Smtp-Source: AA6agR6ERw83JHlj0Vi0UcG79YvcgJinRpH7f/JWBmWhY8XJBDDC/saUMopVwpUHS9/6k+jbYu7nvA==
X-Received: by 2002:a17:90b:1d91:b0:1f0:7824:1297 with SMTP id pf17-20020a17090b1d9100b001f078241297mr5893862pjb.126.1659117071721;
        Fri, 29 Jul 2022 10:51:11 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local (192-184-217-7.fiber.dynamic.sonic.net. [192.184.217.7])
        by smtp.gmail.com with ESMTPSA id z11-20020a17090a468b00b001f339f9cc57sm1574046pjf.54.2022.07.29.10.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 10:51:10 -0700 (PDT)
Date:   Fri, 29 Jul 2022 10:51:08 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] ci: fix the FreeBSD build
Message-ID: <20220729175108.zk63qonchmrvprsl@Carlos-MacBook-Pro-2.local>
References: <pull.1308.git.1659097724.gitgitgadget@gmail.com>
 <985e4bb8-0cb1-3980-aaf7-bd3c793f7627@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <985e4bb8-0cb1-3980-aaf7-bd3c793f7627@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 08:58:46AM -0400, Derrick Stolee wrote:
> On 7/29/2022 8:28 AM, Johannes Schindelin via GitGitGadget wrote:
> > Since 3a251bac0d1a (trace2: only include "fsync" events if we git_fsync(),
> > 2022-07-18), the FreeBSD builds are failing in t5351.6. See
> > https://cirrus-ci.com/task/4577761405698048 for an example. The run at
> > https://cirrus-ci.com/task/6004115347079168 shows that this patch fixes the
> > bug.
> 
> Thanks for noticing and fixing this bug. The FreeBSD build is slow

It usually takes a little more than 7 minutes for a full run, which is IMHO
less (at least wall time) than the whole CI does; could you elaborate on
why being "slow" would warrant ignoring its failures?

> and flaky enough that I sometimes ignore its output before submitting
> a series. Good that it will be green again.

I'd noticed that because it runs outside GitHub actions it sometimes has
synchronization(ex [1]) issues, but that might be some bug on the integration
with Cirrus which is easily avoided by looking instead directly to their
status page:

  https://cirrus-ci.com/github/git/git

Carlo
