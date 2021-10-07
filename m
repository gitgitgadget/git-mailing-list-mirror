Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1F5C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 15:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A058610EA
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 15:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241719AbhJGPqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 11:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242407AbhJGPqq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 11:46:46 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B357C061746
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 08:44:53 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so7956773otb.10
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 08:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NEmIrdaPHZxKPqV6Ea5bFbAL1j4LjuS2jweMpHzHBFk=;
        b=W1jD9lSg2VDQ+yZLxLEzTU8BpyUQoJc+o97wnEx7UJA+UnUhANjo8p+kqs+q//4K6h
         JAc+O5IuMD4UeXS/zsO+A0Dl/XpReBWOTENF4ju0nZmFb+pMhI/SlXj821G8qRBh6NkM
         tO8A7ZhcrpcNO5F6RFOBmP5DEaXmBg9OhhizKj3Qu2iIxhYqkJFnMd9xQ5DRXLFtwocV
         Y6cc0Leau9xeoTjd5tuEE1YfZZvkiMMR5w4YmGRMPvXrLZGRdHJqYqj9fFbXXII1K6yV
         9cHkMOUWGz+HuGbqk4gBiE4AlPrqaj0BxxYXFMjKULSUKMNYF8MQMuYsIzvEHsh3+cVb
         IIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NEmIrdaPHZxKPqV6Ea5bFbAL1j4LjuS2jweMpHzHBFk=;
        b=f9P0iSCXX2a0eZzTSxMGFToLpqnynymtJQNS80AxYFJkQTT1DTrDF1xZSmQ8/6bNaq
         1MqMjaXsAXfH/XpetaVZ6zQDAub7xu0IRRw+ss9ocJ9GLlA0chfpvhP5tDyWocEKWoVe
         zrT4UZDlFRstSuN3X+aJPRCUsq7h5JZwn23IJlXv3c5lKKqAPKvWiXl9+PfVDx9xy+1J
         TUq30h6VxxCk3WAcQvtYfURBVhy63jze+Kb9FsWdOGVMAnaopBf14IEIKU8lMSmIDfoU
         lWu+6WxyMB/NiTasxp3cmM6f2w0B9fP5U9o1weMWmpRp/vSDAnhOl+4Bpym3sYNC8eJk
         elLw==
X-Gm-Message-State: AOAM531djrsenQ4ssQLI9lBuqwW+mJzrGaaF1hrKbkabP8KwaU3l9z1S
        uxOmJOlqSRawThw4lIY+nuk=
X-Google-Smtp-Source: ABdhPJylkAa4MnYjjI/BB2voI7UUg4at87Vrb2TfyTicvBwAjaFVsoTkWm4mu0JUtQsV+hH4shY8Vw==
X-Received: by 2002:a9d:313:: with SMTP id 19mr4303187otv.189.1633621492277;
        Thu, 07 Oct 2021 08:44:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:40be:181f:1763:acf6? ([2600:1700:e72:80a0:40be:181f:1763:acf6])
        by smtp.gmail.com with ESMTPSA id e76sm1710597ote.15.2021.10.07.08.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 08:44:51 -0700 (PDT)
Message-ID: <69f83ec7-315e-0488-774c-bb8490001b13@gmail.com>
Date:   Thu, 7 Oct 2021 11:44:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH v2] sparse index: fix use-after-free bug in
 cache_tree_verify()
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1053.git.1633512591608.gitgitgadget@gmail.com>
 <pull.1053.v2.git.1633600244854.gitgitgadget@gmail.com>
 <3bf4e767-294e-0f30-f0bc-ffa706a86835@gmail.com>
 <028aef79-d4cd-5202-f657-4b5045f85d0f@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <028aef79-d4cd-5202-f657-4b5045f85d0f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/7/2021 11:05 AM, Phillip Wood wrote:
> Hi Stolee
> 
> On 07/10/2021 14:53, Derrick Stolee wrote:
>> On 10/7/2021 5:50 AM, Phillip Wood via GitGitGadget wrote:
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ...
>>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>>> index 886e78715fe..85d5279b33c 100755
>>> --- a/t/t1092-sparse-checkout-compatibility.sh
>>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>>> @@ -484,7 +484,7 @@ test_expect_success 'checkout and reset (mixed) [sparse]' '
>>>   test_expect_success 'merge, cherry-pick, and rebase' '
>>>       init_repos &&
>>>   -    for OPERATION in "merge -m merge" cherry-pick rebase
>>> +    for OPERATION in "merge -m merge" cherry-pick "rebase --apply" "rebase --merge"
>>
>> I spoke too soon. On my machine, the 'git rebase --apply' tests fail
>> because of some verbose output that does not match across the full
>> and sparse cases. Using "rebase -q --apply" works for me.
> 
> Oh, that's strange, the CI tests pass on gitgitgadget and that script passes locally for me. Do you know what the output is that does not match?

It's entirely possible that it's something in git-for-windows/git or
microsoft/git that is causing the difference:

+ diff -u full-checkout-out sparse-checkout-out
--- full-checkout-out	2021-10-07 13:37:00.475394970 +0000
+++ sparse-checkout-out	2021-10-07 13:37:00.531396095 +0000
@@ -1,3 +1,10 @@
 First, rewinding head to replay your work on top of it...
 Applying: update folder1
+Using index info to reconstruct a base tree...
+Falling back to patching base and 3-way merge...
+Merging:
+e1886b3 update folder2
+virtual update folder1
+found 1 common ancestor:
+virtual b4ad7e16921c16e36f1d5d45ea4fa186efa8422a
 Applying: update deep
+ return 1
error: last command exited with $?=1

[1] https://github.com/microsoft/git/runs/3827705316?check_suite_focus=true#step:5:10469

Thanks,
-Stolee
