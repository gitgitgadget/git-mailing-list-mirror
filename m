Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51579C433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 11:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241024AbiCOLbe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 07:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbiCOLbd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 07:31:33 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4383F4DF50
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 04:30:22 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n15so15982688plh.2
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 04:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PQ5wfgHsl3uHZNuHSiVciCQuLKS+I/nj8HjSmkxCWHM=;
        b=n1PmagrbRgllGbr/b20e1aNf4sfAzna4pEEzF6Zx6DVGvL5adoXAUOmXxnPwsl7nXI
         KAil0AScoPKZuLsGxfmmp0unbfcmYsA6Hn+GDrbD48pw50HlVji+DdtnTQwPvAut6G0y
         nmWO8a8+ejVt9vbxiFaaaqKcbtDp5gbpQuQb6waZa3rVIZheGMlMa6oXmhNNNSt1qCkJ
         /0dt0V6U9Sy7D2BT4m3e6P430Av5HmOfREG21dRGyXd+f8DkEdZ+96JC3SHJS3l/f3rT
         RdIrgJR0V/XR23cNx+LEVNSOqcEl+vs+HMfjG1s7ZdWqA9MIzvR5Ide0wKxK4XAtfI4i
         fHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQ5wfgHsl3uHZNuHSiVciCQuLKS+I/nj8HjSmkxCWHM=;
        b=QJnDA8zx7VJhLAhpW+Hs9CMp6gHzCXGyb7naeWI0V/SxRhLVbMK9xkPxUcERqiHu8m
         yrm4485PHFKwhFq0qbezIgGxGVCkVGVZtZvN9/iDTWm9CpFs7SXk5i0gkqmNlzEr/mGH
         jgTGI4P96mqE0OPHWhzvQ13aI53rTpWxm/qShnO1jv3jLYVFn4WTcVvovo1sD1IOL4TF
         Fd1Df5pWsqyl+qHyZOZZxhzdDEaN6W13OHiN5+oMWGykcTxiuR7VUKYx56ES7t0sS8TE
         gm5WAop6P/HmBTDYjh+C61/1ggdHrssR+2dtUIPNkVF+jcr+82TuxFv0EwssM7GVWW6/
         RJmQ==
X-Gm-Message-State: AOAM533HDvaJcSPXLfijJuWdB7+wXGx6DNPuGmsC9F/RAJ2rKa07O92/
        FE9K0Hwol9ALWMs3s4Ga+Y8=
X-Google-Smtp-Source: ABdhPJxcCxv3tj4OU2WPS8BVaN6BTPR8ykXfcnJzmnZ5RCqCpXIAIHxTYddwFo8/oKLgDOH2he1nnA==
X-Received: by 2002:a17:90b:3b92:b0:1bf:a61b:742b with SMTP id pc18-20020a17090b3b9200b001bfa61b742bmr3960778pjb.157.1647343821109;
        Tue, 15 Mar 2022 04:30:21 -0700 (PDT)
Received: from localhost.localdomain ([2409:4061:2d81:5a50:75f1:f15c:f519:6733])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090ab38400b001bf9519fe8bsm2777227pjr.38.2022.03.15.04.30.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Mar 2022 04:30:20 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] partial-clone: add a partial-clone test case
Date:   Tue, 15 Mar 2022 17:00:02 +0530
Message-Id: <20220315113002.61748-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <xmqqa6dsnpj9.fsf@gitster.g>
References: <xmqqa6dsnpj9.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> I found it quite a roundabout way to look into trace to see if
> a "fetch" was run to determine if we are doing the right thing.
>
> Regardless of whatever mechanism is used to lazily fetch objects
> that have become necessary from the promisor remotes, what we want
> to ensure is that the blob object HEAD:new-file.txt is still missing
> in our object store after running "log --follow", isn't it?  In a
> future version of "git", our on-demand lazy fetch mechanism may not
> even invoke "git fetch" under the hood, after all.
>
> Don't we have a more direct way to ask "does this object exist in
> our object store, or is it merely left as a promise?" without
> triggering a lazy fetching that we can use in this test?  I think
> such a direct approach is what we want to use in this test.

I did think of other ways to detect the downloading before. Initially I
thought of using grep functionality to see if any download related
messages are printed or not. But I found that `git log` doesn't print
any download related messages (e.g. like "enumerating ...."). So, I
dropped that idea.

The next idea that came into my mind was to detect if the previous file
(the file from where the new file is renamed) is still missing ( you're
suggesting the same approach). But the problem I faced with this apprach
is I didn't find a way to detect if the file is missing.

I tried to use `git rev-list --objects --missing=print` with `HEAD` and
first commit hash. But in both cases, I didn't found a missing `[?]` sign
before ` <blob-hash-ID> file.txt`. That means, both blob objects ( or I
think the same blob object) exists in the local repo.

Most probably, this is because the content of these two files are same.
Blob object is never modified. So, as far as I think, both base trees ( one
which is pointed by the initial commit and other which is pointed by the latest
commit) is pointing to the same blob object. As a result, the file is not
missing. ( I am not sure if git really does it as I said; sorry if I am
wrong here)

That's why I asked Derrick to help me detecting the download and he
suggested me this. It is true that this is not ideal (use of `fetch` may
change later). But this was the only option that I can go with.

If you find another/better way or if you think I tried to use `git rev-list
...` in the wrong way -  please tell me. I would be very happy.

Thanks :)
