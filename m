Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727C7C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 11:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56821611CE
	for <git@archiver.kernel.org>; Mon, 24 May 2021 11:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhEXLP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 07:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbhEXLPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 07:15:25 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5587C06138A
        for <git@vger.kernel.org>; Mon, 24 May 2021 04:13:57 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ot16so12698050pjb.3
        for <git@vger.kernel.org>; Mon, 24 May 2021 04:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1/luphSk7G1OcM0oarvk/BAwra5cbx0hl0Kxw5h2Kuk=;
        b=JKKu6yf90OXNvOY31/7hiGs0eW1oeSw7Ir7y+XAc3zZT1mLkdewp42tR5adw3C0SOC
         xf7N5pbDr/5Z4NArr7gaoa/FvX7NcorBct8tYZfl/YMcVaeeWBF6rU895z2s3//HBXVz
         mozff0IU7eJ7y2EmBzcUOqs/jBt3vaTUsGLpj00cwLgzcfNKd0hQyozDFBYqN9DUkzDq
         KJd0jSEuiPvVVE9k0lXl41Dacc+ZacVCvNv3jGiCaaDXo+wBV41SvY+Yfo1wzrYVkeFM
         HvZi2ddHHy1S3jdgWEYmUtb25v3msOSI8MRN6PcPN5UyvG82LBKwU6nhQvTwVrporru+
         JrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1/luphSk7G1OcM0oarvk/BAwra5cbx0hl0Kxw5h2Kuk=;
        b=fTbxysY8zW6bHlc5JfS0UoLUCJuhP4lSAN0oNF4y6VRSva3feVEupNZDBJ25y6dHA3
         L/02o34Sh+ZHF7+/AqgK+xaydAnyxk3Xdp4Gdl1BbDZwcnltumGX2hLNVVaffYFOEI2w
         xC1uEhd8d8hg9j6vPpDEiQCoZ1TsHgcN84KhI7rvoCFYV06PJbjbF4LWmyI4/1Zz0fG1
         n9V44SZdiq9lfgTLZKJlrtzaf68LGeFlXWYXbsvFjrtrM6cnM+ntl/lnIdStSFKNuX3b
         lZgV3ofLasf1NRtP/ANFnVhNZ7wXt20Tb3VMvaoBhdCd9nYpcPqSJoRjZOXJYUi+TbpW
         aZsA==
X-Gm-Message-State: AOAM530eOM9q0YYmVVjnMNI1aHZeQncvw28MgBJN69x6RvE0XVTpCFux
        efTV5q6svzd1KTDEAOFX4XOIj9dhnsQyHg==
X-Google-Smtp-Source: ABdhPJxeias0nrXIgQEe2dwq+v2YK3DBjsr1iIfum6TddE7Y71SH27nz0Y03EPJxwiMl5L1cYpbztA==
X-Received: by 2002:a17:902:6b02:b029:e9:8e2:d107 with SMTP id o2-20020a1709026b02b02900e908e2d107mr25017169plk.61.1621854837145;
        Mon, 24 May 2021 04:13:57 -0700 (PDT)
Received: from [192.168.43.80] (subs09b-223-255-225-232.three.co.id. [223.255.225.232])
        by smtp.gmail.com with ESMTPSA id h66sm4352399pfe.53.2021.05.24.04.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 04:13:56 -0700 (PDT)
Subject: Re: fast forward merge overwriting my code
To:     Andre Ulrich <andre.ulrich@smail.fh-koeln.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
References: <20210522154815.Horde.rqiNSyIc3CGJECACotWLO1T@webmail.th-koeln.de>
 <4c1c3dbc-7a89-02db-3883-b7eea644cd83@kdbg.org>
 <YKrsC9CaG/KDvDBi@camp.crustytoothpaste.net>
 <20210524061355.Horde.I7EpK9A1l-KtI_TwFo97eNd@webmail.th-koeln.de>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <3b5ecbcb-5d94-e7c4-e73b-2e00acdd0232@gmail.com>
Date:   Mon, 24 May 2021 18:13:53 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210524061355.Horde.I7EpK9A1l-KtI_TwFo97eNd@webmail.th-koeln.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andre,

On 24/05/21 13.13, Andre Ulrich wrote:
> So the last point is where we still want to do some fine tuning. Right now this looks about: my prof fetches my edits and locally checks out a branch to compare the changes with git diff.
> But in this diff view you can't edit the files. So you have to separately open up another window to edit the changes (lets say my prof only wants to keep some of my changes, but not all).
> 
> So my Question is: is there any possibility, to be able to view (and even edit, if necessary) the changed notebook in the merging process (as in my example with the 3way merge)?
> Or is the only option to separately view the diff and edit the notebook (two seperate steps instead of one)?
> 
> The latter would also be acceptable, if it really is the only way. Bu it would be nice, if viewing and editing could be done in one convenient step during merging.

When you run git merge, when Git decided that automerging with 3-way
merge can be done without conflicts, the editor will be fired up for
you to enter commit message. Delete or comment all the message lines
to abort the commit by "empty message" mechanism.

Now you can view diff (git diff) or edit the merged files as you
wish. Of course, you can coordinate with author of branch you're
merging from to get consensus. After then, git commit.

Similar steps can be done for merge conflicts. Git will pause merging
process when conflicts occur, and you need to edit to resolve them.
Again, coordinating with original branch author is helpful to decide
the resolution.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
