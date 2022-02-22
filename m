Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91726C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 19:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbiBVTu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 14:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiBVTu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 14:50:59 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62DCBA759
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 11:50:33 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id r7so16257219iot.3
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 11:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6YsRLbNs23Cv6ByKYYgVeFprO9VvfGzdDgs/zUmaSVY=;
        b=sM97bjsqJLbQZztusfn/VrorlK/ppzLWqCvT6VLCOw7pgctwb9YbaLZeNIR8RlU9t8
         5nLQt5SwLiWQtD63K8wEOwMpFY2KuZAB4AEWQWBAJuOHq/T+GmOesxpwpkxCMI9o1bQf
         ArLPzRT5dio3aYMDZz+SJNuJWcqAqPF5n8ce1qsKlXYYt+dImgWV75qyPGlDkQDOZ5MQ
         v5/68VbmXeKjfuHa2NtOm83S+aftxZTNRBmQDry+RUYAiCmYRuPBjbRt71a2XRVoxD9f
         pNrXe4tFtJZOlki21ttBdPVJKGxUKKnCG6YkHGgNnQsyWXh7zrqmw1+1uLQokRejS0DJ
         rucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6YsRLbNs23Cv6ByKYYgVeFprO9VvfGzdDgs/zUmaSVY=;
        b=1pLuEqIHAuGFvDYbjgmuqXjPDSuKmCiJ0HadBRmIafc2UwsUxvhDPL/AaBYfcXQjS/
         1G/+nSxZgrCvU89kx7jW8fm0lI/9Ec0kqwjZiNzXVhUq5DNbo0ui6bhaZLGcQq5k2ZnK
         dcjc9jDjKwXImTIzNLwnwZ26aJfSV4Cuscd9Jr8sRASdZ7aqi7TFaZ6tFXCq2HT3fLk+
         pbMBbDGxpUvAL2dMx+P/NDAvaIQdMJ1dpoBWbqqk61RLlsNlefPwUHvH3SvdZf4QiEPu
         p2HzNNGJFMNInrmEZpqwkWMwMdMdObM+mOQnnD4wSzfcYd8IeQdyOpdnDYfVSYT7Ux4K
         kFcg==
X-Gm-Message-State: AOAM530LaouyKDL5clC/V6zXQNj4lAajGEUnah7Ubl4BI9mIbh/QsYrL
        CjyhfnhXxCnqbCyGWRDwpxBRrA==
X-Google-Smtp-Source: ABdhPJz5hg45FgqTZD0Imw+azK1bEXyjNn1TNhsWABH8kWEcx/aaJKmPm4Hy5MNFJuMpYzdVX/mQxA==
X-Received: by 2002:a6b:ec15:0:b0:640:def4:c0bd with SMTP id c21-20020a6bec15000000b00640def4c0bdmr10025695ioh.134.1645559433196;
        Tue, 22 Feb 2022 11:50:33 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n23sm12126743ioo.55.2022.02.22.11.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 11:50:32 -0800 (PST)
Date:   Tue, 22 Feb 2022 14:50:32 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com, gitster@pobox.com,
        newren@gmail.com, jn.avila@free.fr, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 00/11] Updates to worktree code and docs
Message-ID: <YhU+iI3RmwauYnsI@nand.local>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
 <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 22, 2022 at 12:17:49AM +0000, Derrick Stolee via GitGitGadget wrote:
> Updates in v2
> =============
>
> Based on Junio and Taylor's review, I updated some language in the docs:
>
>  * Some uses of "worktree" should have stayed as "working tree"
>  * Some adjacent wording was improved.

Thanks; these updates (in addition to the handful of fixups that Junio
provided on top) look good to me. I'll leave it to the two of you to
figure out if you want to send another reroll, or if Junio already
caught the minor changes when applying.

Thanks,
Taylor
