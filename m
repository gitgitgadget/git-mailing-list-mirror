Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D97C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 16:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239278AbiEIQtH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 12:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239276AbiEIQtE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 12:49:04 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCD454020
        for <git@vger.kernel.org>; Mon,  9 May 2022 09:45:10 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id a22so11342914qkl.5
        for <git@vger.kernel.org>; Mon, 09 May 2022 09:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N6ccBIO791otVSCf6DpIVkRSqXBKdNOSCg04zqevAAM=;
        b=DpsPYnkvtC/bi9TW7umcqWiuF6tH8Lp4LL55jrAXsxity3m4zplqHwkpYXcmBDmrcs
         N4RIMU1/uR5u6hMDvORPUHYSMx5l/BO+AY94wuPSundUkP59nwhW+IboMZvWsO1GmGKG
         j0FfojdWqwXs8Sgnuyt2BN4pFYs9Bntbhrm6Rx9JWBWv3RgNb4lHcbkiTJZPsjj7RbG/
         YoktLrf6QwQOmmdpPQf0PrOwH1eYYWexnRTWE0YyAuk+91+j6CCYPGIsb0MH3OmR9S0U
         /KF294l9wkyO9J5ZfhzNCPAiROmn505kyBF86qCk1+ebe53abUZ2NHA12evTMqZ5hc50
         3QQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N6ccBIO791otVSCf6DpIVkRSqXBKdNOSCg04zqevAAM=;
        b=e/tLLfUG+H4TN+Xu+qWu1acgwQHZzSv2BN9RFOdgKc0MzBW0kbhj7WMZrfbOchMh8R
         z8tuksEnz4o9++LvgYgclcgf88eKXVZPPF1VTXUfxNx7j05Hw31iYUU7dWL2rfiH0Kmf
         DSCPVVAi3/y7cjwEci8GXP2ScPyeFUNcxvguFLdJdAOK6AQTK/C6HTdJi1bvMX53nfA/
         XDkhdn/Bhcni1CXNljN/0wEeMucGEtMg4xN+44I8pMsBF7xOrGZY9WNWnCQX62VB65/d
         mfyvXQMUDH6A7gV27+rpOumUhX/yfVUQD1bFUQSd8m8Sq6/hcK3zr+9h6zpGoo2hsjht
         s/aA==
X-Gm-Message-State: AOAM5305I5WyeF9Pt8p4RTBuJiWqlF1SDuHTLNYYEWQs0bZPCZ6dFeZu
        XiYwIny3FeJqvaQPN+QBLtk=
X-Google-Smtp-Source: ABdhPJxP3EWnGlYJEuENmnZ86yIkAq9J/5WWpgiublbi6J1fu49ZsBodK1bIS0FOXGgWRLsAyA3W8A==
X-Received: by 2002:a05:620a:4256:b0:67e:87a1:ffdd with SMTP id w22-20020a05620a425600b0067e87a1ffddmr12172760qko.647.1652114709189;
        Mon, 09 May 2022 09:45:09 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id v65-20020a372f44000000b0069fc13ce218sm7392277qkh.73.2022.05.09.09.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 09:45:08 -0700 (PDT)
Subject: Re: [PATCH v3] builtin/remote.c: teach `-v` to list filters for
 promisor remotes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <pull.1227.v2.git.1651591253333.gitgitgadget@gmail.com>
 <pull.1227.v3.git.1651933221216.gitgitgadget@gmail.com>
 <aa9884d5-b69a-bfd2-4235-a30326bd65f6@gmail.com> <xmqqilqeekk2.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <94558e1c-7d0a-8d53-1304-2eecaf6e40fe@gmail.com>
Date:   Mon, 9 May 2022 12:45:09 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqilqeekk2.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2022-05-09 à 12:29, Junio C Hamano a écrit :
> Philippe Blain <levraiphilippeblain@gmail.com> writes:
> 
>>> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>>> ---
>>>     builtin/remote.c: teach -v to list filters for promisor remotes
>>>     
>>>     Fixes #1211 [1]
>>
>> I don't think this matters much, but if Junio is OK with that, it would
>> be nice to include the reference to the GitGitGadget issue in the commit
>> message itself, though with its full URL, something like:
>>
>> Closes: https://github.com/gitgitgadget/git/issues/1211
>>
>> as another trailer before your signed-off-by. By including it in the 
>> commit message we allow the issue to be closed automatically when your topic
>> branch is merged to 'master'. By using the full link we make sure that GitHub 
>> knows we are targetting that issue specifically, not any other issue or PR in 
>> any fork of Git with the same number.
> 
> Nice to know.  Is there a handy GGG users' guide that mentions these
> "magic trailers" (the other one I have seen used is "Cc:")?

"CC:" is GGG-specific, it is mentioned on the GGG homepage, 
https://gitgitgadget.github.io/, under "How can you use GitGitGadget?".
It's also mentioned on the Welcome message GGG adds to the PR for new 
contributors [1].

"Fixes", "Closes" etc. are GitHub features (though GitLab implements the same
feature), see [2], [3].

[1] https://github.com/gitgitgadget/gitgitgadget/blob/main/res/WELCOME.md#welcome-to-gitgitgadget
[2] https://docs.github.com/en/issues/tracking-your-work-with-issues/linking-a-pull-request-to-an-issue#linking-a-pull-request-to-an-issue-using-a-keyword
[3] https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#closing-issues-automatically

Philippe.
