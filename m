Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C682BC07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 09:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2016136E
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 09:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhGOJka (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 05:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhGOJka (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 05:40:30 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5680CC06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 02:37:36 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id h9so5878417oih.4
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 02:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=FlEuSOWq+Jd8Iezpo1W0ITStHTAGwbq07LA7Q7HrU94=;
        b=KVe7zyB2Zppc0Qs7wa7cYf7Ht2i1dIWBKXOXYq7vSekhoO7mCdMWMVfxiar5yxvF8I
         KYdsBo32VI9fFPN4tlBO6xvj5baOaFrdpkFYeAm1yeGTGug5QZ0BRnaECAbBFmTqj2dd
         YTbF2xNei4yIF9jL6vyqZ8xVlS7mmUBqRqXcwbAPkbvyaY/S2udRwiEyd4HWI4BW3GDA
         tLpUScYxMqEmhFM7hYAePpco+Q+lJ+ri7mnesHQwsmcIqc0irF8UqGst6plPFtAbMuWF
         JepL+TMdf7ZReqy9xXXXomJ4erVYZaN3ScpCRrFElhd6QzxsRAoU1S6xUhpO5Z7AONo7
         JgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=FlEuSOWq+Jd8Iezpo1W0ITStHTAGwbq07LA7Q7HrU94=;
        b=jpl6vLCldMYm++mCQMvMXBYyY2C9+6t+8Qal+/gp3zhcz2voGzCrnFHLH3UsPawfEi
         LxdeUWqhYvMqranfEk7WfhczldxRNkjQbypcFGWAN38OxUh8XuE8qQhTFUk4k5Sy0Ek1
         I1IbUsCsV2wwBYTBe0WI4gK3Qf0uOBOCXzBXOejXimewEVwK49MCtsEOXtQjg2AC9X6n
         pubeW2eRFe2F0R7+5p0QoNoee8tHR4LbhJO++A8UBpuf/IfMEdu5eXiaLusFryn+/tOL
         jLufVO9mvUyaV/3FnfYW+f7FVPsNZiJTAu7dvgbwQZ9mZh7/oxhj0dN1T1NmWob2VbEg
         aibw==
X-Gm-Message-State: AOAM533LqbgeBvHQFglK8ipBw4phcoh9BQ/Uc0uFE2P6vm1bR4O/ux+J
        V5Glzk9+7X6T6BJLVIBi0t4=
X-Google-Smtp-Source: ABdhPJyG/zcpj7GnEF6lyCq24T28k7z967TaQXmuvEFEKCG0QIXxf7BrmJcsAaO7hleQ95w+eC/IaQ==
X-Received: by 2002:aca:aac4:: with SMTP id t187mr7206518oie.93.1626341855777;
        Thu, 15 Jul 2021 02:37:35 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id n23sm365230ooq.48.2021.07.15.02.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 02:37:35 -0700 (PDT)
Date:   Thu, 15 Jul 2021 04:37:34 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Elijah Newren <newren@gmail.com>
Message-ID: <60f001ddf33fa_2e67208e4@natae.notmuch>
In-Reply-To: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
References: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
Subject: RE: [PATCH 0/5] Handle conflicting pull options
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren via GitGitGadget wrote:
> We've recently discussed how to handle conflicting configuration and command
> line options in git pull, including at least a few different
> proposals[1][2][3] to handle different subsets of the possibilities. We also
> have a user report from someone who had conflicting configuration and got
> surprised when one of the options overruled the other -- with no warning
> from the command or the documentation that such would happen.

No, that's not what happened, you are assuming wrongly.

It's perfectly fine to have pull.ff and pull.rebase, because the former
will be honored when running `git pull --merge`, as I already explained
[1].

[1] http://lore.kernel.org/git/60ef1f6a83b61_9460a208cc@natae.notmuch

-- 
Felipe Contreras
