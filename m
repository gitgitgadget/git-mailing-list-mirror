Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F66C74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 15:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjCWPvj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 11:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjCWPv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 11:51:29 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DE71BFC
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 08:51:24 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so1421359wms.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 08:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679586683;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wDWXcycjFXtczCy1EfybbHUYiKV+apwW//gsbXaWDrM=;
        b=S6aIUsaqsweVpnnH2EVwLzBBln6UZ7SvEbJ5jZM6aLTIyHonwKPYe0exXPbTH2tz2n
         T4wHRaXmPFZYpOoFI0SNzCXD/9nuhDTg4sz25/119gCNFaz3xxMen+A3cUr0mGhJhCP0
         wDInlqBAmzIRn0Vq6icOs8ZjvWRXxMCki5GfoyXQSzYaasKPfnrcXAl8ALb+j2Ilqndi
         89y6eTpJcCp8kNqpKUwTNiG6KBUeTbHHaA+7/XIRmR/G8ZRl22HFKUDsoJZRshAdsM7G
         yuDwWBJMgDYEAZu+VgzBPHhcZfRF3LPMaH7g53Ed/hCwylDHAF8rXsXuSOZBTWLBLzYp
         dvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679586683;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDWXcycjFXtczCy1EfybbHUYiKV+apwW//gsbXaWDrM=;
        b=uWSTjxhn+NCsQLNXfSpfnDyBZjAwzM6Nuvn6VbQHjovCt2Z0SxV002z6AfnsM/+Ark
         f1/iOxWrVn2KC0tynI1k/YrKZwYwVlXQZtdjDDuuptMHILcf1hWzwQkyaIRTd9mobtzk
         /fvUak+ih/atkqSbTZmImlHr8x4G0ylK8YZKDSefnJrI5r4gI9zoKXL+G2Gf/Xwmav7D
         pEsfgz/MSQp8oVWYm19asjr+GtgAxqdH6ZfZHOhqp5qP4+R86RJus15JBDGfjtHSV3J/
         19qGwInmNfYFXWBaxC9///yLQbGX9MR/RP83qftzhFLPjTXFr+VKlmy8GcoTV0gJlbRv
         j6WA==
X-Gm-Message-State: AO0yUKXdC4slBXaDjQJSmPWARolLK8i+zIs20ejevZE2nex9S5ww6gM/
        0Y4Nw9XKt17ciy4BzNWmT8M=
X-Google-Smtp-Source: AK7set/UtNT/jYRJ7sRq83V9dz3p67/1bYx25ScP5VPVwHKTUYsmV67Ahp8Sft7WPEeroO7l9fZsJA==
X-Received: by 2002:a05:600c:3ca0:b0:3eb:38b0:e748 with SMTP id bg32-20020a05600c3ca000b003eb38b0e748mr2735074wmb.13.1679586682910;
        Thu, 23 Mar 2023 08:51:22 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:8346:b700:d93c:afe0:40cb:5597? ([2a01:cb19:8346:b700:d93c:afe0:40cb:5597])
        by smtp.gmail.com with ESMTPSA id n26-20020a05600c3b9a00b003e1202744f2sm2329694wms.31.2023.03.23.08.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 08:51:22 -0700 (PDT)
Message-ID: <cffce108-c39d-f13f-9fb6-60624f7e7cea@gmail.com>
Date:   Thu, 23 Mar 2023 16:51:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Clement Mabileau <mabileau.clement@gmail.com>
Subject: Re: [PATCH v2] branch: improve error log on branch not found by
 checking remotes refs
To:     Junio C Hamano <gitster@pobox.com>,
        ClementMabileau via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1476.git.git.1679478126.gitgitgadget@gmail.com>
 <pull.1476.v2.git.git.1679515402379.gitgitgadget@gmail.com>
 <xmqq355wctjq.fsf@gitster.g>
Content-Language: en-GB
In-Reply-To: <xmqq355wctjq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 22/03/2023 23:25, Junio C Hamano wrote:
> "ClementMabileau via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: ctmbl <mabileau.clement@gmail.com>
> 
> This "name <address>" should match what is on "Signed-off-by:".  I
> offhand do not know where GitGitGadget gets the information, but I
> suspect the original commit object you created records ctmbl as the
> author name, not "Clement Mabileau"?  I can fix it for this single
> time, but if you plan to contribute to the project in an ongoing
> basis, you may want to fix your .git/config (or $HOME/.gitconfig)
> with a "[user] name = ..." entry.

Well maybe it got it from the original commit or from my GitHub
username, I can't know for sure. But sorry for that :/ , I'll make
sure it's fixed it for potential future contribution!

> If the user said "git branch -d frotz", we would have 'frotz'
> there, right?  Then we apply FMT_REMOTES (Yuck, now I have to go
> scroll up, see that it is set to "refs/remotes/%s", and hope or
> verify that its value hasn't been changed in the meantime---in
> short, don't introduce that variable.  A macro might be OK, but I do
> not see much point here) and we get "refs/remotes/frotz" back.
> 
> So, we check "refs/remotes/frotz" here ...
> 
>> [...]
> 
> ... but why should we?  If your workflow interacts with the original
> repository you cloned from, you would have remote-tracking branches
> like "refs/remotes/origin/frotz" and it may be plausible that you
> meant to remove with "git branch -d frotz" the remote-tracking
> branch "refs/remotes/origin/frotz".  But the new code makes no
> effort to figure out the name of the remote (e.g. 'origin') here,
> and I am not sure what value it adds to check and try to tell the
> user about "refs/remotes/frotz".  Or are we assuming that the user
> would say "git branch -d origin/frotz" in such a case?

Before fixing anything about the code maybe I should first address your
last point which is the interest of the patch in the first place (and I
should have started with that...).

A few months earlier, for the first time, I had to delete a remote ref
(because of a fork I fetched but no longer wanted: maybe a designed
solution exists but I'm not aware of it). However, despite being used to
git I had a hard time figuring out how to do it, I tried different
things, one was `git branch -d origin/<branch>` (I recently discovered
that it was written in `git branch --help` but I didn't find it at the
time). Even googling it proved difficult (because of a poor keyword
choice I must confess), most results was dealing with deleting remote
branches, such as `git push remote :branch`.
In the end, I finally understood that I needed that `--remote` flag and
really regretted that there wasn't an hint message to head me towards
the solution when I was getting close to it.

Now I hope you'll understand why I suggested this patch. Maybe I'm the
only one that ended up in this situation, in this case I'd understand
that you would no longer be interested in the patch!
However if you still are, I'll be happy to make the modification you
asked for.

>> +				if (virtual_target)
>> +					error(_(MISSING_BRANCH_HINT_MSG), bname.buf);
>> +				else
>> +					error(_(MISSING_BRANCH_ERROR_MSG), bname.buf);
>> +			}
> 
> Are you leaking virtual_target here?

Yeah probably, I'll fix it along with the other.

Thanks for reviewing this!
