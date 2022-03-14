Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C104AC433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 15:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbiCNPPJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 11:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbiCNPOu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 11:14:50 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A4463C6
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 08:13:35 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id g6-20020a9d6486000000b005acf9a0b644so11963851otl.12
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 08:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hD5z2p6BYyBqiUgHsoR376/EHNP21yPqcvw+jMgxuUk=;
        b=iny1raC3hzp/vh3Hi4+/HPs7X/zHDG/bq5HNVv8ONOW7O7ckT5IOYZseUoyMUPMqS/
         D4Ov1YuS87UQysW3ranzleHo4j7ssrb1jpoUFWCFGIw7EXWPPosbMufhpY9a2oH0ryWx
         0EBSFj/oRH3qNFtkG65NaldTi8l5CR6m5cZZDc9SN7yw0NiNoGZJ0iuUQ6K/Hu2c61m+
         bspOvboBiM49HdGOSEgbKId23s6TbuXfv/LEPVOxHAmyt8sWYIR7p9UwG1VhyLMBGiMI
         9CJRQBL0eSkacxcVjfMEEuyL1PvPytd5nwd9xbdmkLZILz2LCmp+6u5GgAbkrwWbpRmh
         BbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hD5z2p6BYyBqiUgHsoR376/EHNP21yPqcvw+jMgxuUk=;
        b=v5LyjYDj/ko3DB1N7fAegWUIwV0QclSQxdBhC41KeDXq9zQV5A53CC02vkZHgL61tB
         wnuvwr3hmul6tngrdTug1A5Qj0j7r9/H8hkCridB+wBgUStt0VIyuamctXsI35jORAnT
         Mz0UZDCDuy21g5HxT0o+/O7NTgtk8aPqlYkgv++OprXsp+MmtDLfm72mBKFTw547z907
         kHcLWgyKnDvq+2sGBWZO59G+sz9/Lm4WyYj9lEL1PVnNbo2jAxeUc3v9KwDoD5tnI71B
         ZfkbgdR60sH45sUHUrniORbofE0kq962X2rpPGK9L+bQNG2KmRkV46ZkAd2mItdCq4Mu
         O20g==
X-Gm-Message-State: AOAM530O9G2qGr9ZGyWOxIAyl5CNtyXmdYkbwFvqixOzNfb2bB6cgAge
        HXdmI2CdzjmYKrADrDG7Aqj1
X-Google-Smtp-Source: ABdhPJzgrrJnX6168xJ+1jpzjS6GxiG+Nb3YPdS2e9aJV7XVXp10kW809eNp3nceeOLP4TdMRWBpzA==
X-Received: by 2002:a05:6830:82a:b0:5b2:36d5:1603 with SMTP id t10-20020a056830082a00b005b236d51603mr11433701ots.240.1647270814539;
        Mon, 14 Mar 2022 08:13:34 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id dx51-20020a05687076b300b000d9a9e36864sm6616470oab.36.2022.03.14.08.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 08:13:34 -0700 (PDT)
Message-ID: <09550c4c-10ce-5439-98ac-ca71b9309c69@github.com>
Date:   Mon, 14 Mar 2022 11:13:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/5] Separate '--skip-refresh' from '--quiet' in 'reset',
 use '--quiet' internally in 'stash'
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>
References: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/11/2022 7:08 PM, Victoria Dye via GitGitGadget wrote:
> In the process of working on tests for 'git stash' sparse index integration,
> I found that the '--quiet' option in 'git stash' does not suppress all
> non-error output when used with '--index'. Specifically, this comes from an
> invocation of 'git reset' without the '--quiet' flag in 'reset_head()'. Upon
> enabling that flag, though, I discovered that 1) 'reset' does not refresh
> the index if '--quiet' is specified (as of [1]) and 2) 'git stash' needs the
> index to be refreshed after the reset.
> 
> This series aims to decouple the "suppress logging" and "skip index refresh"
> behaviors in 'git reset --mixed', then allow 'stash' to internally use reset
> with logs suppressed but index refresh enabled. This is accomplished by
> introducing the '--[no-]refresh' option and 'reset.refresh' config setting
> to 'git reset'. Additionally, in the spirit of backward-compatibility,
> '--quiet' and/or 'reset.quiet=true' without any specified "refresh"
> option/config will continue to skip 'refresh_index(...)'.
> 
> There are also some minor updates to the advice that suggests skipping the
> index refresh:
> 
>  * replace recommendation to use "--quiet" with "--no-refresh"
>  * use 'advise()' rather than 'printf()'
>  * rename the advice config setting from 'advice.resetQuiet' to to
>    'advice.resetNoRefresh'
>  * suppress advice if '--quiet' is specified in 'reset'
> 
> Finally, tests are added to 't7102-reset.sh' verifying whether index refresh
> happens when expected and to 't3903-stash.sh' verifying that 'apply --quiet'
> no longer prints extraneous logs.

Good find! Code looks great.

There are some test issues in Patch 2 that you correct in patch 5, so
maybe we just need to squash the changes in the right order.

However, I recommended two alternate ways to design your helper so you
can test config and command-line options more easily.

Thanks,
-Stolee
