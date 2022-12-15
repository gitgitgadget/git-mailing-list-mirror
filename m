Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DAEC4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 12:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiLOMIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 07:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiLOMIt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 07:08:49 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468BF2D1C3
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 04:08:48 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id d123so4971580iof.6
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 04:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=+/VOHpLY7SKzgAUCwchGyTKAf3xtglHngMmlZXSFaw0=;
        b=OxqhLCvhQFjWH6naXcoBIr6ZqzIe4go5Uty0saCQg//Z0G2JQkLnWiK4lGLK8IOm/h
         Lasvq9yy+Y+RicP8zXfRMg+hxw0UwCjHry+b5WOXT98GM4etUun2us8mxuYpPspzgsA1
         rpOSY8xLUcyDtR9wqG/jmyRdG8pESTWrTNmOdEzSzfNGwbzDI7AbtqmEZ8JoAstV2Ald
         ScIM5Rr0/3nYaLp7MWwbvYyLqXju4VjzcetijWHmcBCNhrHmCP+y4RtTSPkAsJQLREf2
         m9FpySdwyD/zadBUkOOb198F8QBj8T4mBvTdH+VPSPnZlb6Guzpa5Nb+TwfvKUOGmgUY
         +seQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/VOHpLY7SKzgAUCwchGyTKAf3xtglHngMmlZXSFaw0=;
        b=WG8F3pd1DoYX9DKO4x7doGDMDmO/XI0eBWoeUCPf1g/LycwVNwCfvWSkt9YU6etak2
         kHnw+E0Sfu6yfndCnZNqF9cA59H93UQPlqkHLkNQvDHpX+wQbx97WtxubxaNbmr7BI7M
         NMSi+tZEk3+83exJR6xHHSLXmzqmmh7I2j1ophPtFUPs3PTscdd3jwoR8tZapIJlvp+Q
         BKXYh3FVX0YIZL2VswtKTLdaECEsr/4N9GU0YFAvYv6j/ZMS6F3NxkFMv7rMAGvVLH4H
         sCdTxdnluFnVa7y0yom1njukmir3KEZ7m5YlA6aQ/ghiMh9U9deE+/m0RAlhdXZ4lWCB
         aTqw==
X-Gm-Message-State: ANoB5pnF6ROsrESnMsCE/eGj+It/j+q5kM1/Xcps3PWF5ejOWf6clCAd
        R+HtaEB2OBW58t6oP6UJk8KcARme4XY=
X-Google-Smtp-Source: AA0mqf6AjVWxkSTnO2I7iZhzxAKLfNsz0VG4jVd7KGclrg0ypySSNY6VvqXotDerHz8IG5E/CVMNEg==
X-Received: by 2002:a5d:9343:0:b0:6db:3123:261 with SMTP id i3-20020a5d9343000000b006db31230261mr3405138ioo.2.1671106126829;
        Thu, 15 Dec 2022 04:08:46 -0800 (PST)
Received: from stargate ([2620:72:0:a40:8650:b190:3f96:89cb])
        by smtp.gmail.com with ESMTPSA id k13-20020a92c9cd000000b003024a44cd95sm5304769ilq.34.2022.12.15.04.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 04:08:46 -0800 (PST)
References: <xmqqiliewbje.fsf@gitster.g>
User-agent: mu4e 1.9.0; emacs 28.1
From:   Sean Allred <allred.sean@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2022, #05; Wed, 14)
Date:   Thu, 15 Dec 2022 05:55:39 -0600
In-reply-to: <xmqqiliewbje.fsf@gitster.g>
Message-ID: <87k02svpgy.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> * sa/git-var-empty (2022-11-27) 2 commits
>   (merged to 'next' on 2022-12-01 at 3b81dcb382)
>  + var: allow GIT_EDITOR to return null
>  + var: do not print usage() with a correct invocation
>
>  "git var UNKNOWN_VARIABLE" and "git var VARIABLE" with the variable
>  given an empty value used to behave identically.  Now the latter
>  just gives an empty output, while the former still gives an error
>  message.
>  source: <pull.1434.v3.git.1669472277.gitgitgadget@gmail.com>

After reading gitworkflows.txt and maintaingit.txt, I take it 'next' is
a proving ground for the larger community to have a chance to suss out
any bugs/regressions. I'm going to assume no further input is needed
from me regarding this topic (unless of course I've got a bug!), but let
me know if I'm mistaken :-) (and thanks to all the folks who've already
provided review!)

Is now a good time to resume the conversation of exposing
GIT_SEQUENCE_EDITOR variable within git-var [1]? I expect the patch to
be mostly the same, but instead following the now-corrected pattern laid
out for GIT_EDITOR (and updated to use the new test helper functions).
Should I then base my branch on 'next' or upon 'sa/git-var-empty'
specifically (now merged to 'next')?

[1]: https://lore.kernel.org/git/pull.1424.git.1668972017089.gitgitgadget@gmail.com/T/#u

--
Sean Allred
