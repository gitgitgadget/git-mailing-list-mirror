Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335D1C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 23:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbhK3XbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 18:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238808AbhK3X2r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 18:28:47 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12793C06179B
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 15:25:19 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id t8so23206940ilu.8
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 15:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UwPfMo8P8TVs07tmuV9BnTbmkCSvbNOSd8MrXAZFTq4=;
        b=VYKv/5jXk0itVuyX7I4/GoZOatI0bsNXOdClH1yl2YfVzC4CyPK7WQD+D4XKaVlcwM
         HdSnQFERbHItIe3p8dkS44RKYAC1rTyaaFGW2kpzsbx/SGzQk+ewDAQu7KAvjlFxsz+F
         26BK7+eVbh2w+qw0hVSonwo21Mh1A1KVK7pHTvguyoFPulbNIEhtU5fS2tI74lBEeUox
         Ejch4bT6eu2LaZvL9xmeCCSKLmd12TdWOdlF5BO2TD4CVwCPYWnwBhDLYW3AdxTFrYRP
         aIs+CINDySFL1CS+l/tZqdOSBnhj1/ESgvUrRhoU1lyitctVxM+zKWlFr7qnCKNQWOU+
         35zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UwPfMo8P8TVs07tmuV9BnTbmkCSvbNOSd8MrXAZFTq4=;
        b=l78xMLdNwzLfxSauxR7l085jRhvlQntf3V+sNVL2sS2j80FrwLh7nknRqHGZ/0Iqx2
         +2NDFjVxwGmGzcINEDO486U75hooogEGp9n/NWzZjInDTigum+FISiE656FVlFiAX06Y
         euf6EYXY0U8m2kzcKxxfEg9vBycb9mvfl4ez0SsCrO53xULriZPFko8RLejF22kqteWs
         dW/hOo10q+sTJzGQ2GXHQlu4OCxljJ+ZTrCRTnqnEcSfVqVRnYOAQYrd3SuRWahidqNW
         GWPdJE73QQ6Yy4WL0TEE2VsKGqlO3M5cGA9YeUxSjfjmFpJ4I4hqDcI/d7ZsK2y80Q3l
         RY9A==
X-Gm-Message-State: AOAM531dfLiRwVn2jnf0IWJ995v+nAlvSF03ka6QjKPGnAQ1G4IRKV61
        EvzXIZavc+j1av9yr2vXpcKQMFHpyrs=
X-Google-Smtp-Source: ABdhPJwRNk0gjeS0OMB4YhbNsvNbvd2njxRrCVXbPryvZr3AkgpqZ3LON30yfuIpmk59i9hrR1X7RA==
X-Received: by 2002:a92:cd8b:: with SMTP id r11mr2901430ilb.39.1638314718515;
        Tue, 30 Nov 2021 15:25:18 -0800 (PST)
Received: from [192.168.86.121] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id s3sm10524115ilv.69.2021.11.30.15.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 15:25:18 -0800 (PST)
Message-ID: <07c87109-48ea-074e-8090-7e3db0ec9ad5@gmail.com>
Date:   Tue, 30 Nov 2021 15:25:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v4 1/4] sparse index: enable only for git repos
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
 <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
 <81e208cf454b61c761fa66e4f43a464ed439ba59.1637620958.git.gitgitgadget@gmail.com>
 <xmqq8rxe787g.fsf@gitster.g> <724abbd4-b9ee-3b3d-226c-b7999f138152@gmail.com>
 <xmqqzgpt2z0h.fsf@gitster.g> <6db27c92-6ea6-fa5f-8aa7-e1fef7d5ff5a@gmail.com>
 <xmqqmtlm2lx1.fsf@gitster.g>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <xmqqmtlm2lx1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/29/21 10:32 PM, Junio C Hamano wrote:
> Lessley Dennington <lessleydennington@gmail.com> writes:
> 
>> This is cool! I applied it locally, and it seems to be working well. I
>> will plan to replace my changes to checkout and pack-objects with this
>> for v5.
> 
> I didn't write it to replace the changes you were preparing, though.
> 
> What the patch is meant to solve is that "git checkout -h" in a
> repository, whose .git/config has some custom configuration
> variables that affect how the short help text is shown, were
> ignoring that per-repository settings by not even checking if we are
> in a repository at all.
> 
> When "-h" is in effect, and if you are outside a repository, this
> would cause the setup_git_directory_gently() function to be called,
> and we'd reach checkout_main() without having discovered repository.
> I do not think it removes the need for your "only when startup-info
> says we have repository, do these" safety.  At least, I didn't write
> the patch to remove that need.
> 
To be clear, I am not replacing the change in repo-settings.c to BUG
if we're trying to prepare settings for an uninitialized repository.
I just removed the conditional I had added around the
prepare_repo_settings method in checkout and pack-objects, since the
failing tests for those builtins started passing with the application
of this patch.
