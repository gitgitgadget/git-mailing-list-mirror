Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68225C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 17:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjCXRXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 13:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjCXRXf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 13:23:35 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A978C65D
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 10:23:34 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-544f7c176easo44967607b3.9
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 10:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1679678613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QwHD1EHNPfxlPSL2Kh74RyhAauhLsordCDwlaRmk24Q=;
        b=WVrKNpJzNq+/blfO5qwDjjpiTRXi2V8r1tFlSxILYjjKn9aeuwzG8BHoiEw3KRIwu4
         ckTBjhzL5hepPtq0u5w6jggAQwcSjaNS/BeqPp3wwHKAq2X2FfbHYU292tZ0q5ENkPnD
         NxTjq45tpdnpBd5QwU5aKlfotmhmGOnbpnG1PwvGP6msg1ttRWPmRJ1lieBzBDe02lVb
         bFUL8RsByAsRztNLYj6dmFI9Aleh5mLcaSgrka4oyATDWLlCe/0QLikkNwf11RgntsCg
         ZU3dH6scGFa+JZBBmAwoPlb1iM/SdJ0EW0qZjtFbuNrIM4gknC/EjwfCd7K1EEK/Rb5T
         Ouwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679678613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QwHD1EHNPfxlPSL2Kh74RyhAauhLsordCDwlaRmk24Q=;
        b=F26HVnceurC1sIj95X2Mj61FuMTBMmOAN9653gT0Fzf9vHrjKyozNw42fAT8MmsY1U
         zpDLAAwbW9FqgxNPjUBytEVn7ESEOkraimKb/AuFmc7x3B6p5aBzOwpY8ZV5oJ33GeTY
         K8FatwbalPZyZup8g0LkVMYezD+P5E6PgKTaoIzZ8zhh5y36LlA6buZTX19wVkgplf6N
         XIyipMHMl6d6KW2ZF2iVj/D/TyiZIrEDehGveelN8qecl8qVoTQ3vhMgQLRoOGqF1REr
         Pbn8+5j00e1ZtBo6bA4j8OxtjebonkAsGYADrJfzZxZZUTRkrLquZj0pT+iBu2EaACjP
         7plA==
X-Gm-Message-State: AAQBX9faXwCeEpm0AulvPxa7ZlVfdkL9yDeISwa2kOwXFwMbrVsHaUud
        D/dImRCNV+OEAVIpl3r2BSe896gxFxWZthU94A==
X-Google-Smtp-Source: AKy350bnq2trm/4yHia8UVgAsYrjmR7k47XsiSlYmVc8VXJXHfL24LHunRSP6kxvEAoiTSaCIGYvLA==
X-Received: by 2002:a0d:cc50:0:b0:544:cbd3:76fb with SMTP id o77-20020a0dcc50000000b00544cbd376fbmr3093299ywd.27.1679678613633;
        Fri, 24 Mar 2023 10:23:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:55e4:a877:13cb:cca6? ([2600:1700:e72:80a0:55e4:a877:13cb:cca6])
        by smtp.gmail.com with ESMTPSA id u7-20020a81cf07000000b00545a081847csm512150ywi.12.2023.03.24.10.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 10:23:33 -0700 (PDT)
Message-ID: <594a358e-7bd4-e7a1-ad0f-7e41ca1fe767@github.com>
Date:   Fri, 24 Mar 2023 13:23:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: limiting git branch --contains
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
References: <ZBygZbz5E6jVNp3y@ugly> <xmqqpm8z8dab.fsf@gitster.g>
 <ZBy6Ku+znv/wuOix@ugly>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ZBy6Ku+znv/wuOix@ugly>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/23/2023 4:44 PM, Oswald Buddenhagen wrote:
> On Thu, Mar 23, 2023 at 12:42:52PM -0700, Junio C Hamano wrote:
>> Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>>
>>> git branch --contains can be a rather expensive operation in big
>>> repositories. as my use case is actually a rather limited search for
>>> commits in my local wip branches,...
>>
>> I can do
>>
>>    $ git branch --list --contains master \??/\*
>>
>> to show only the topic branches that forked from/after 'master', and
>> replacing 'master' with v2.40.0 or any older point and the output
>> starts showing more branches, but the search excludes integration
>> branches like 'next' and 'seen'.  Is that what you are after?
>>
> not really.
> the objective is finding the work branch(es) a given sha1 is coming from.
> the problem isn't that the above doesn't work, only that it is insanely expensive - on my old machine it takes half a minute in the linux kernel tree.
> that's an inevitable effect of trying the branches one after another and not being lucky enough to pick the right branch first. at least that's what appears to be happening.
> this could be optimized by doing a piecewise descend on all branches simultaneously (which i presume is what merge-base & co. do), but if the commit actually isn't on any local branch at all, we'd still walk to the very root commit(s) - which is rather wasteful when we actually know that we can cut the walks short.

Could you make sure to run 'git commit-graph write --reachable' before
testing again?

When the commit-graph exists on disk, the algorithm does do a single
reachability walk from all the initial points. If it does not exist,
then each starting point triggers its own reachability walk, which
is significantly slower. See repo_is_descendant_of() in commit-reach.c
for more information on this split.

Thanks,
-Stolee
