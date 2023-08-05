Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86297C0015E
	for <git@archiver.kernel.org>; Sat,  5 Aug 2023 14:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjHEOsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Aug 2023 10:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjHEOsC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2023 10:48:02 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137034236
        for <git@vger.kernel.org>; Sat,  5 Aug 2023 07:47:59 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-63cf69f3c22so20272306d6.3
        for <git@vger.kernel.org>; Sat, 05 Aug 2023 07:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691246878; x=1691851678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eaPLKtGGR7dgaQF3fuuY68pyaQVWLEmWgShjrefw56w=;
        b=qPbqFFSEGX/udRusEgg7VkcAijBMvCWfmBPy+U1wciASz1L1rTKfogiLGpq4L5RBQV
         MF24m4ix8bupHkLPP53ZdR3WEfmW+fE9oU4gPt6WwI1jNSvRjJE35AUMlCXoeYJ0U9Gk
         UMOYkbdgetOCxoWFStVr71SBTpcB+lnAGvBgCT5YqFwwpHAhe3szqNimg76tubHSKxgd
         XLfk5ocPiaeWo1/XDnYfgbOVBqc77NrJndzHJbFzddN5EDVNypuuAtEHve8afkeXCy2h
         7gBZdNQmQQGJwlCZm9nlBfM4/2/mxREBnyKRs62qereA8krOBYlOoFyW03A8YTw1kG+l
         dapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691246878; x=1691851678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eaPLKtGGR7dgaQF3fuuY68pyaQVWLEmWgShjrefw56w=;
        b=QnmHPZJp5BbKIPWb/CxN8P/6NLUUGcjY6qVokovMz4LQgkv27iNGgr1V11KN385/td
         FCafvDgyCYPU03xgqySHPqM/3lStz/jdTCb5cmz8W3kjNKZnOZ8/EGOJAS4BsHvjV6nS
         oEFU0W02Dr9xSwm+lu+A3ylsMz79Xd6LDAfaC4+jyDBR5THlCig4o57YdOfqcXLpnZpb
         Mrz7c383rBjNScs1XZp7GmKbyjcptHeSzA3Hy8cpE6gcyj1TxeRsgjPMIlXr3CGJ5wXH
         zr/pYHZqkDjynH8gCEBSb+7Idd+Nh/h6hNLeyLvMPr94VORbOnKgVBX+75C0s1nEv/x4
         2P3w==
X-Gm-Message-State: AOJu0YxQ6Te8YnDrUl1n9MTW7gbJgutWD2wtCUK8xbse9Ntz4q0ReXbX
        YSzCJMvPrpJ8kbUM3F9ga4Q=
X-Google-Smtp-Source: AGHT+IEQd1UfTz82cRZSB3Ygl40dlZknCu7YLrIYYoLQmc6veJ6zRFialvpGGtqfif06wM/GxrNNlw==
X-Received: by 2002:a0c:dc8f:0:b0:629:1659:dba with SMTP id n15-20020a0cdc8f000000b0062916590dbamr4274335qvk.10.1691246878146;
        Sat, 05 Aug 2023 07:47:58 -0700 (PDT)
Received: from [192.168.202.112] (pool-141-156-165-177.washdc.fios.verizon.net. [141.156.165.177])
        by smtp.gmail.com with ESMTPSA id q4-20020a0c9a44000000b006300e92ea02sm1492322qvd.121.2023.08.05.07.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 07:47:57 -0700 (PDT)
Message-ID: <07677f17-be9b-dc46-d204-6fe46d46ebc0@gmail.com>
Date:   Sat, 5 Aug 2023 10:47:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 0/4] Remove obsolete Cygwin support from git-gui
To:     Junio C Hamano <gitster@pobox.com>
Cc:     mdl123@verizon.net, git@vger.kernel.org, adam@dinwoodie.org,
        me@yadavpratyush.com, johannes.schindelin@gmx.de,
        sunshine@sunshineco.com
References: <20230624212347.179656-1-mlevedahl@gmail.com>
 <20230626165305.37488-1-mlevedahl@gmail.com> <xmqq4jmsiyhw.fsf@gitster.g>
Content-Language: en-US
From:   Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <xmqq4jmsiyhw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 6/27/23 13:52, Junio C Hamano wrote:
> Mark Levedahl <mlevedahl@gmail.com> writes:
>
>> === This is an update, incorporating responses to Junio's and Eric's
>> comments:
>>    -- clarified what the "upstream" git-gui branch is
>>    -- Removed some changes from patch 2 as requested by Junio, reducing
>>       changes in patch 3 and patch 4
>>         All code is fixed only after applying patch 4
>>         Differences in patch 3 and 4 are minimimized
>>     -- updated comments to clarify G4w dedicated code.
>>     -- updated all comments to (hopefully) clarify points of confusion
>> ===
>> ...
>> Mark Levedahl (4):
>>    git gui Makefile - remove Cygwin modifications
>>    git-gui - remove obsolete Cygwin specific code
>>    git-gui - use cygstart to browse on Cygwin
>>    git-gui - use mkshortcut on Cygwin
>>
>>   Makefile                  |  21 +------
>>   git-gui.sh                | 118 +++-----------------------------------
>>   lib/choose_repository.tcl |  27 +--------
>>   lib/shortcut.tcl          |  31 +++++-----
>>   4 files changed, 27 insertions(+), 170 deletions(-)
> OK, Dscho says v1 looks good, and I have no further comments.
>
> Pratyush, can I expect that you take further comments and usher
> these patches to your tree, and eventually tell me to pull from your
> repository?
>
> Thanks, all.

Junio,

Thank you and Dscho for the detailed reviews. But, there is no response 
from Pratyush in over a month, is there a different maintainer then who 
should take this?

Mark

