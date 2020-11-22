Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C810C56202
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 12:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C24D22078D
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 12:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1ubtTtP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgKVMn5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 07:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbgKVMn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 07:43:56 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8971C0613CF
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 04:43:55 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id p8so15724826wrx.5
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 04:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7Fc7P8kQcPQISx2KbEH6F7H0EErAk0HWaiyJDx60mcc=;
        b=K1ubtTtPS3LqLVzxojrqvYKPBDTHyYaGYtcw1bqs/Mq1e8Omue3WBQVSmxLZvFGoKI
         CdzPZaOPfquYXoctixZ70Ek4us4GDziEuzCviLLEMY7TgE4Nc45dUCMvxljS3NVbyvw5
         CBGA6dPWvfbF1qBQt+E4WOmUcFeTj6Q+MACSTuwTuTAifNBbOzW5gEgURk3bugAWhY70
         BmAcfqLUvUVEc8QGFMEwT+c+BcTqv60WvyKfgpKUiJNeUZQxnrFSx3FXnp+Dr/JeaPgw
         mLW67gRzq7o3M0UC5E12Ky1xgfTOAB00GjOy81LWAWmyzLQVN7bedXJW1TMM4r0dMqlA
         cSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Fc7P8kQcPQISx2KbEH6F7H0EErAk0HWaiyJDx60mcc=;
        b=MlkPdQDXx/pA+CgkBdo+lqyaTi6JxZGFMxfCdfxFeZzd/dKm5fv9/xa3bBQ/rjmNFj
         P+21nN1aeakVbPsbLaYyl2Zo9+7A8MEGhpNi6isnaeMhsW8mmzeAU5oSzzwJ2OtbWQmv
         MMZzxchO/OXlMrnrRQ8ZLJf8s31SVEIHEmvRrOHHTQ9b5tmFi1nu9MrjS7ujUYv/5spY
         jbIxKZ3T1UhaH9lcOjvz0tCDYhbH635E3RJAZmiGAV/Iy8ahOWGwQFYrNZrknCegcG1S
         1VEIsa5nbrTJxqHc1sVfHTC4IfxDTyFu10QMrfdGw5lBfEme2ncquMh1/q5tG+TUxe8V
         +XIQ==
X-Gm-Message-State: AOAM530OxksH1CqL8O9pOolMMBZb8q4gogzUO2jOH41yJ5mPJG18Wvnt
        cWqYj7bAueFE6G5F0yY2T/M7n/ZSVB0=
X-Google-Smtp-Source: ABdhPJyT063XpI3vg02vRAOgxm1VX7sQHLhNpC79DKFtNiN764v8RMeeykZT+AnVngf5S8vBWufNtQ==
X-Received: by 2002:a5d:660f:: with SMTP id n15mr26510417wru.345.1606049034440;
        Sun, 22 Nov 2020 04:43:54 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-654-1-307-224.w86-199.abo.wanadoo.fr. [86.199.90.224])
        by smtp.gmail.com with ESMTPSA id m20sm13986635wrg.79.2020.11.22.04.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2020 04:43:53 -0800 (PST)
Subject: ag/merge-strategies-in-c [was Re: What's cooking in git.git (Nov
 2020, #04; Thu, 19)]
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqwnyeqpw9.fsf@gitster.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Message-ID: <8c92f1d0-3f17-d8b2-ca93-c70ee887f37d@gmail.com>
Date:   Sun, 22 Nov 2020 13:43:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <xmqqwnyeqpw9.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 21/11/2020 à 23:57, Junio C Hamano a écrit :

> * ag/merge-strategies-in-c (2020-11-16) 12 commits
>  - sequencer: use the "octopus" merge strategy without forking
>  - sequencer: use the "resolve" strategy without forking
>  - merge: use the "octopus" strategy without forking
>  - merge: use the "resolve" strategy without forking
>  - merge-octopus: rewrite in C
>  - merge-recursive: move better_branch_name() to merge.c
>  - merge-resolve: rewrite in C
>  - merge-index: don't fork if the requested program is `git-merge-one-file'
>  - merge-index: libify merge_one_path() and merge_all()
>  - merge-one-file: rewrite in C
>  - update-index: move add_cacheinfo() to read-cache.c
>  - t6027: modernise tests
> 
>  The resolve and octopus merge strategy backends have been rewritten
>  in C.
> 

There is some behaviour changes and regressions in this iteration that I
intend to fix.  Expect a reroll soon.

I also noticed that I can show which branch has made a branch when there
is a conflict with the "resolve" strategy, like "recursive" already
does.  Should this change be part of this series, or should it be a
separate patch?

Cheers,
Alban

