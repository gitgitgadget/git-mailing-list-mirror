Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A36C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 10:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A7A61184
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 10:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhFJKPW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 06:15:22 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:40686 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhFJKPV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 06:15:21 -0400
Received: by mail-ed1-f52.google.com with SMTP id t3so32315816edc.7
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 03:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=i9gdepz+Sz61UT/xx3Y/R8lD2mDxrjH0EqbUSjfmOro=;
        b=kS2innObpg6g9s9DB3RPVS6n+9lzhDnDpKIVwU+vzfucbZqx7Fk230lO2U2B3YUjTs
         iRZplms9CG1N4Ay43KmyT/R3MlZMEb6TD7UKWzWNwlTy2bnxv8TSg+CeC2o8HTjZMSC0
         utx9mlfeJGXmkkCqVoCQyNWina7lq53H6oO+/x3qGXuoeN8vrkPYSdIY9xwekpeWbsSk
         4vfITUXFqpxXNbKF4p8JzmkiY0XXc0dAeFvrYNL5WgTZKyts1YNPWbbaMlm1f0ybKvS2
         ggnKUbXcD49tDYskdSYHN+kSG9MhV20bOh3sMiPZp5RfqTpCFxRUrO1ZHyzcSDx247BL
         7kUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=i9gdepz+Sz61UT/xx3Y/R8lD2mDxrjH0EqbUSjfmOro=;
        b=Ehs0ScWoRb7cgjTIAsPJeUbRrSHBnjaJdzRzCzUSCCQtmA4ikAkf27HrHodXLjI0RL
         pYmC3BWwnt7RmGveBOraDBu7AaeZR+cPwMJVmcHawAf1hFs52EAKhqOv53JibcNvPyD+
         8IsVjj7h82IB9Y0pKVn1M9RwCtsVqKrAgSksYkrt5znqC6AjslL1K2+JJAKEDGTpeWnh
         eImrHFiDJmmVTs6Qkz1UBWytRfWLE2rbTVmCo2HfuWIQDCf0zlpWzpLl4JXouwUxiiSm
         Y1jSCyog07BvVAY9hNd8Ft7v0ca28LvGzON6UXoScmrLtZPLBcZ0SxJyPPw1uJ2cQEKf
         GKvw==
X-Gm-Message-State: AOAM531BDkycK6tMMaGd1CNqM7VPyPQ0TPHu8DCcLCtxt6n48zRg35AF
        tSqAlbA5ZyhJfkXlqd1Ys5zAOsYMQeE=
X-Google-Smtp-Source: ABdhPJwhTex82+im0JPiZCJ4bdNLdlUcWQV3CgqlM4gpcRZsZ8MkWeE39ZWbDDCJInTeg71MEEQQgw==
X-Received: by 2002:a50:9fe5:: with SMTP id c92mr3928282edf.93.1623319930604;
        Thu, 10 Jun 2021 03:12:10 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id au11sm838697ejc.88.2021.06.10.03.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 03:12:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] multimail: stop shipping a copy
Date:   Thu, 10 Jun 2021 12:04:52 +0200
References: <pull.977.git.1623313765122.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <pull.977.git.1623313765122.gitgitgadget@gmail.com>
Message-ID: <877dj22fly.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 10 2021, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The multimail project is developed independently and has its own project
> page. Traditionally, we shipped a copy in contrib/.
>
> However, such a copy is prone to become stale, and users are much better
> served to be directed to the actual project instead.

Let's CC its maintainer / other people who've actively contributed to
it. I've taken the liberty to do that.

It seems to me that the state is that we're on the 1.5.0 release, and
upstream hasn't cut a new release. The upstream maintainer(s) are active
contributors to git, so the risk of this becoming stale seems low.

Having written a system in the past that made use of git-multimail.py
(and sourced it from git.git's copy) I'd think a better direction would
be to keep this and modify githooks(5) to actively recommend it over the
older and less featureful post-receive-email script.

Sure, people can also just get it from github, but to the extent that we
ship any sample/default hooks at all let's start with the one that we'd
recommend using against in favor of git_multimail.py for anything new.
