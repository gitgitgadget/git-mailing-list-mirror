Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BCDC352A1
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 09:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiK3J5g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 04:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiK3J5e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 04:57:34 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4728DB16
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 01:57:32 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so969620wmi.3
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 01:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m3Ti8lLjLH/oZcTNGBAa1+AMdQiVXm/9RfufJzkbNw8=;
        b=lWy93Lp3zDdMgAhPoauCYSIq4PfWwFoai3wF1jTnWWNzk0/zYJkVyPqeJuneBpDYyR
         aEkx9u4ue7mjZo6NwwjqWjm0XbPHLAAao8Qdodwjc1Gky2G4c8U0jSlnFxRu9h41NONc
         ENr287P2xUWZcvEz7yDqSSqoUQm5D9bqYbItd1KEBPxYc8QwCPQywk8cHdM46O9m477l
         K+Wv90m781rklKd7vJVze5fXk+G/bQEdfqFpqv+qF+BwIhRp9GQW7W8VPytTDRpAWs+U
         PNv+Bfq9q89tmlZYhcwdBdSURfo/JAXF5gCJTz6YJ3E2Pn6KBOoN8W+ZiVtG9o9x8+U0
         txHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3Ti8lLjLH/oZcTNGBAa1+AMdQiVXm/9RfufJzkbNw8=;
        b=vAVVUdLxprCWCVqWyMSxI82Q667HI1EB1I+0EywrUVyM1lc9YyYNwNFw8bttExc0vm
         Pcg4k+TLSacfR/PF73sKE1EQk9+dOlBcsWwLzRmcs19d3sRM/IbjTrEmE5hT78Imtg6h
         ISZ/mMag2pJznY9MJmnzOumxUVBjrDAWyrt43DWmpqzVu33SF9L6xO32S9iFL634aiL7
         q8ohpejZS7GAUPH+mr8Uwh3GCo8F91E6F8JbYof0TFLIq+p/30W+4TcbfDvXzwpE1lbj
         MK4UQPxPhZOBhOnK2V/avQLFmModc+tUuo3jqOajTrO/Fkt/xFzYfuzdBS9UA6Mmo7uq
         oL6g==
X-Gm-Message-State: ANoB5plpmqmTBZFo5UhTiVXYOPpNO95h9m6aLm15ESkEq/gdoVXS8LZe
        +Asxt1z6JEEHWIlfxJakCaM=
X-Google-Smtp-Source: AA0mqf6s/KxLG23WblpT2DISJ6D/ijTx+77Ll2ABxBWB5jeIW6mISW/4scx7B3QDEyEyo8iHFMoFxQ==
X-Received: by 2002:a05:600c:1d93:b0:3cf:d0ba:e5ff with SMTP id p19-20020a05600c1d9300b003cfd0bae5ffmr43612400wms.36.1669802250737;
        Wed, 30 Nov 2022 01:57:30 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d530f000000b002420dba6447sm1031321wrv.59.2022.11.30.01.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 01:57:30 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <544fff8a-7d56-57a1-00a3-d1a9302e227c@dunelm.org.uk>
Date:   Wed, 30 Nov 2022 09:57:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: ab/cmake-nix-and-ci (was Re: What's cooking in git.git (Nov 2022,
 #07; Tue, 29))
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqsfi22j67.fsf@gitster.g>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
In-Reply-To: <xmqqsfi22j67.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 29/11/2022 09:40, Junio C Hamano wrote:
> * ab/cmake-nix-and-ci (2022-11-04) 14 commits
>    (merged to 'next' on 2022-11-08 at 6ef4e93b36)
>   + CI: add a "linux-cmake-test" to run cmake & ctest on linux
>   + cmake: copy over git-p4.py for t983[56] perforce test
>   + cmake: only look for "sh" in "C:/Program Files" on Windows
>   + cmake: increase test timeout on Windows only
>   + cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
>   + Makefile + cmake: use environment, not GIT-BUILD-DIR
>   + test-lib.sh: support a "GIT_TEST_BUILD_DIR"
>   + cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
>   + cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
>   + cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
>   + cmake: don't copy chainlint.pl to build directory
>   + cmake: update instructions for portable CMakeLists.txt
>   + cmake: use "-S" and "-B" to specify source and build directories
>   + cmake: don't invoke msgfmt with --statistics
> 
>   Fix assorted issues with CTest on *nix machines.

If that's all this series did then I think it would be fine. However it 
also makes changes to test-lib.sh to hard code the build directory in an 
attempt to remove GIT-BUILD-DIR. I'm not convinced that is an 
improvement on the status quo. As I mentioned previously [1] I think the 
non-*nix related patches could do with a review from the windows folks 
before this hits master.

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/64b91b29-bbcd-e946-1f20-c0a5be63d9b7@dunelm.org.uk/

>   Will cook in 'next'.
>   source: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
