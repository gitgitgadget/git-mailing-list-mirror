Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5A0C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 17:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiBXREQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 12:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiBXRCq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 12:02:46 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373671A6F8B
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:59:52 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id g24so2345588qkl.3
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yVnr1PMAeukIxxyqfgzyNC8M7X12EwILnggqeo8sasY=;
        b=acIUiT8VK3ZpZGlX9M2nDxE3AUo3edgHnWecyu8mPgIppn7CQ2kLp3yExr+swsahUF
         cTugiqMOLMHiqJmn5aMT7IWhuzoJHFeMmQc2/XGlGRyg3cVOphdZd7yaAApluYFIQtft
         /6vOPQvD9LEUik+Al4juiBpZjZ+1w+ZTG5y+9OlJbAgdy2fg55C9NV7lg42rLlVopVJI
         uHgC0jxRr/qp58jumGirRkZI3h7BcDOSKJ9KsxVg7psgpWjvrIN+GhX/v0CwA3IC1Sew
         tU6/iNNi6ftkhPvgQB+iDQ3FqcDlvoVfzwvduvdj/XoRNa0IB0OJLueJIGyp3nlELkd3
         R3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yVnr1PMAeukIxxyqfgzyNC8M7X12EwILnggqeo8sasY=;
        b=A0+QrHbZ/TclH1/YmuP5707Lib1ES8bcAu1alYvAu10hl5OWqK2k2+0QtQWRE0Rl6f
         S+N1szBil61mMLIKqn36586wI6Ldm95XAUKPVsxHnR1WoWSHqzCbdfjsf4rJ88AHQ++N
         nCJNpODmsvl9RY4/CxXIbv2BmBG5utHleGgKGfwTwr4k3vwu/qAi+0fLDufXm7Q5Zw0n
         RoZCHcd4xItrsBEq0TZLHCnoHQoPd2LaFaAq3xqda7kgy5XG9VmnUu3PZY2RgCjw7qjL
         wSF+OyPLLw58z4nK+sg+TZjF4bpKvcUS9l3nOAbMOmuaaTpO7XozfKNarRsB0KHAauSr
         zmuw==
X-Gm-Message-State: AOAM531z3iP0b52y0YAh8feGKHKeUZN2ipbZk0BD3RzL+Sj0rIErObRi
        jYRGfwbCZkrm8BHzerf18wE9syNSyomb
X-Google-Smtp-Source: ABdhPJzvwnsHh4E450/IDpYPM8aQ43Xwk6AilAyETbJAL86YznOhYqp8OsZbbN9AxYcugLcg/bVV0Q==
X-Received: by 2002:a37:b542:0:b0:506:efb6:9955 with SMTP id e63-20020a37b542000000b00506efb69955mr2278451qkf.594.1645721978768;
        Thu, 24 Feb 2022 08:59:38 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id bq42-20020a05620a46aa00b006494fb49246sm57260qkb.86.2022.02.24.08.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 08:59:38 -0800 (PST)
Message-ID: <2bc6fcb6-2d95-c962-3098-ca4e4e0afa00@github.com>
Date:   Thu, 24 Feb 2022 11:59:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/7] Sparse index: integrate with 'read-tree'
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2022 1:25 PM, Victoria Dye via GitGitGadget wrote:
> Like previous integrations [1] [2], this series allows 'git read-tree' to
> operate using a sparse index.

(Fixed the CCs on this reply, too.)
 
> The first two patches are bugfixes for issues found while implementing the
> 'read-tree' integration:
> 
>  * The first (patch 1/7) fixes an edge case in which a repo with no in-cone
>    files or directories would have its root collapsed into a sparse
>    directory; the fix ensures the root directory is never collapsed into a
>    sparse directory.
>  * The second (patch 2/7) corrects the 'git status' reporting of changes
>    nested inside the subdirectory of a sparse directory, ensuring that the
>    modified file (not the subdirectory) is correctly reported as having
>    changes.

Thanks for these! I just found one tiny optimization in the first patch.

> The remainder of the series focuses on utilizing the sparse index in 'git
> read-tree'. After some baseline behavior-establishing tests (patch 3/7),
> sparse index usage is trivially enabled (patch 4/7) for 'read-tree' except:
> 
>  * usage with '--prefix'
>  * two- and three-way merge
> 
> These cases require additional changes in order to work as expected (i.e.,
> outwardly matching non-sparse index sparse-checkout). For the former, the
> sparse index can be enabled as long as the index is expanded when the prefix
> is a directory outside the sparse cone (patch 5/7). For the latter, sparse
> directories that cannot be trivially merged must have their contents merged
> file-by-file, done by recursively traversing the trees represented by the
> sparse directories (patches 6/7 & 7/7).

I enjoyed reading these remaining patches. I'm impressed with how you
constructed these tests and patches to do the smallest amount of change
per patch.

I couldn't find any fault in these patches, but perhaps Elijah's deep
experience with merge machinery could help add confidence, especially
for patches 6 & 7.

Thanks,
-Stolee
