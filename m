Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37145C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 13:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A77F2082D
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 13:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdfC7NeZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgC0NN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 09:13:56 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43909 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgC0NN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 09:13:56 -0400
Received: by mail-ot1-f68.google.com with SMTP id a6so9587902otb.10
        for <git@vger.kernel.org>; Fri, 27 Mar 2020 06:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5Mpxx+iWRBrZ0PGJW9UcgZFWA6mcHXeJA+NZopcvwb0=;
        b=gdfC7NeZBxa9MCNa0iENzItcsISCxkzvyK6ITKC/RQgU3lu/H0rpEw/DLNffEK6FXw
         bUD9SNTf6LrMITIP4GFEVXSWDxIgXFPul7v5xqtH0vAxf+rF1x/weM1bcWhfg7YmxUH9
         vIbnob4WxsPovMzmYuomeWh2H7o+hRNWVKN6z3E7LEFrhA/XuyPg2KiP0cegqTH8zbbD
         eU3pAqgLX6FSt8I9o2AkoeXtWmXLPZMuPquiFtKr0eaLUriqhzLUA4RYVQ/WYJQUoQzm
         jSOyMbfr8/4QXxcw/rIs71dpacJjHbzd5GxdGABWGzHMY2bwPyu1WSSv5LREGwVoOuxU
         mfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Mpxx+iWRBrZ0PGJW9UcgZFWA6mcHXeJA+NZopcvwb0=;
        b=bis8xxGuQbwqnxGVAmoTf8kdZkGm4D+p3g0Z4ajCo04CDwKVE/6sT6j3vkt+dfd0RI
         LepW3UJyS3B9vXJgpoDOlF37p/4WMnLlarKb95kGiH+ilJ8Ulf+NvZLeaLHXr50ES1ha
         x3eu3/Iq88YvxCSRECNh6t9IufDFJPCNCf0rkAB3OHbm0vJ/KeUssblngBaGm5hrF5uj
         dT0rip0SJiALE0Pp8i9ComuPbna8o20N7g4GzKuhb2DOEF1BKIAT0GlmXdfG/s486G/Q
         H9lJiLGr0Ioq04kRkkSjYqv/UTO3wIgyCginGSFdCZaRQ/9Sl6ytb1n3SdtFZoVFOBwa
         ME5g==
X-Gm-Message-State: ANhLgQ18LvJC0ScTxiK0poElblrjVgloTNlTzk6OHK6iqQaHVm2dmVby
        kaMVamRoYRqXaZa+SQy/FGCpgQf+4aU=
X-Google-Smtp-Source: ADFU+vtwagH8MYdDaMlId4z7PaZMNTQeEEuPcjxlaYg5JGO1ynOxfdrRJDlUe7m9YRr9TvKYySusHw==
X-Received: by 2002:a05:6830:10c2:: with SMTP id z2mr3285481oto.234.1585314835083;
        Fri, 27 Mar 2020 06:13:55 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id o73sm1680277ota.77.2020.03.27.06.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 06:13:54 -0700 (PDT)
Subject: Re: [PATCH v4 0/7] Avoid multiple recursive calls for same path in
 read_directory_recursive()
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>
References: <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com>
 <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ad7c7cd7-2f2e-d406-6a1f-9dd7f155dc10@gmail.com>
Date:   Fri, 27 Mar 2020 09:13:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/26/2020 5:27 PM, Elijah Newren via GitGitGadget wrote:
> This series provides some "modest" speedups (see last commit message), and
> should allow 'git status --ignored' to complete in a more reasonable
> timeframe for Martin Melka (see 
> https://lore.kernel.org/git/CANt4O2L_DZnMqVxZzTBMvr=BTWqB6L0uyORkoN_yMHLmUX7yHw@mail.gmail.com/
> ).
> 
> Changes since v3:
> 
>  * Turns out I was wrong about the untracked cache stuff and had some bugs
>    around untracked directories with nothing bug ignored sub-entries.
>  * First patch now is no longer a change of expectation of the untracked
>    cache, but some more thorough testing/verification in that test that
>    helped explain my misunderstanding and uncover the bug in my refactor.
>  * Corrected the check_only and stop_at_first_file logic in the last patch
>    and added a big comment explaining how/why it all works. Also stopped
>    disabling part of the untracked cache in the same patch, and undid all
>    the changes to t7063 in that patch.
> 
> Stuff still missing from v4:
> 
>  * I didn't make the DIR_KEEP_UNTRACKED_CONTENTS changes I mentioned in 
>    https://lore.kernel.org/git/CABPp-BEQ5s=+6Rnb-A+pdEaoPXxfo-hMSegSe1eai=RE74A3Og@mail.gmail.com/ 
>    which I think would make the code cleaner & clearer. I guess I'm leaving
>    that for future work.
> 
> As per the commit message of the final patch, this series has some risk.
> Extra eyes would be greatly appreciated; one pair already helped me find one
> bug.

I'm glad that I could help you discover mixed expectations. This pair of eyes
is now satisfied with this series to the extent I can check it.

Adding the previous patch to our microsoft/git fork pass the functional tests
in Scalar and VFS for Git, for what it's worth:

[1] https://github.com/microsoft/scalar/pull/358
[2] https://github.com/microsoft/VFSForGit/pull/1646

Thanks,
-Stolee

