Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C6FC43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 18:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiGOS1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 14:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiGOS1W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 14:27:22 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF09D68DE5
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 11:27:20 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id u20so4486443iob.8
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 11:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:reply-to:to:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=kf2GFzfszWmTFm/3x38DbkjRug1sp8LnwsrRADc8tJ4=;
        b=uLls/RJGp0y4qdHL88ScKYKhWwlStr5BXHASD0BP9BodNIkGecYfEg0LrY54kusMWF
         IxUL4cpddVRjEY95Dl1h6KgfH4AkQu9UfE2grm166zX39Vaj5MDK4UU0L5BqHF4p/e3a
         D2ZiWLeqsv1Z7F5tLrvh1mPHDYsWLXigcUNiVhYa7l+w94GMtS9FvhN0Naa+Jaxcr/EN
         uV5yxH0dSK+fjE29dXmeJ5Hx05jRtJuZAnf5tn1kp5NICpM+woRJTUylFWdkK51oAVxD
         iATGa1S6t6754UP4AseFkKMHANugylMvGB3cJNQ4mcFqNspKtifJWXgAiW8vQCDz9zSS
         8i2w==
X-Gm-Message-State: AJIora8HADK6aWkvKz6/3aGVOQU9Ux1pnMDItjPmk9NvAR5wHU5rpSFm
        wtuKOxQiyUZrr9L30pBy0phifHlQSHA=
X-Google-Smtp-Source: AGRyM1vzXYHg8C9LXtbzBIvvyxAUOYE0xDu6ek2z6yLuhefOT7o3ttBB9WhuisG4e4YSXVUz+UAz9g==
X-Received: by 2002:a05:6638:3d85:b0:33f:5727:826c with SMTP id ci5-20020a0566383d8500b0033f5727826cmr8124407jab.292.1657909639542;
        Fri, 15 Jul 2022 11:27:19 -0700 (PDT)
Received: from [10.0.0.141] (c-174-62-43-211.hsd1.nm.comcast.net. [174.62.43.211])
        by smtp.gmail.com with ESMTPSA id e12-20020a02860c000000b0032e21876ea8sm2187536jai.72.2022.07.15.11.27.18
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 11:27:18 -0700 (PDT)
Message-ID: <9ccd1e5b-f8f7-f6c9-9e1b-0058ec71cda5@kinzelman.com>
Date:   Fri, 15 Jul 2022 12:27:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Paul Kinzelman <paul@kinzelman.com>
Subject: RDP over VPN can't see a .git directory to be able to pull
Reply-To: paul@kinzelman.com
To:     git@vger.kernel.org
References: <2e592944-edb8-2d49-981a-8ad220f97e82@kinzelman.com>
 <xmqqilnz2tck.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqilnz2tck.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying to 'git pull' between two W10 systems over a VPN with RDP.

I map my local C:\ drive to drive s:\ on the remote system so on the remote
system, I can see my local C:\ drive that has the repository
On the remote system, I do
     git pull s:\gitrepository
but it says
     ...does not appear to be a git repository, could not read from 
remote repository

In a command line window on the remote system, I do
     dir s:\gitrepository
and the .git directory is not shown in the listing. All the other files are
including the .gitignore file (has a dot at the start).

But I can do
     dir s:\gitrepository\.git
and all the files and subfolders under .git are there.

I've set the "Show hidden files, folders, and drives" radio button in 
the Folder
Options | View window if that matters.

Any idea why the .git directory is being blocked from being seen unless
specifically specified, but I can see the .gitignore file just fine?
