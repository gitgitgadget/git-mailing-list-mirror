Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9057AEB64DD
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 13:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjHINIJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 09:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHINIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 09:08:09 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD5C10FB
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 06:08:08 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3175f17a7baso5111271f8f.0
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 06:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691586487; x=1692191287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=215ELyogPtD67MCU2Fo0upDMzvPcu4mMk9bpj2gKdM8=;
        b=GGmcW2M7/TqQW9pYfnCAyWYkFaHss7ndxVsNCLVmi05CINPHqA0ZTflDumqCt+HqF6
         VBfsNWcFC8feMZ7DWpUeWLX4P4/p8dN4XMplWZnLVcY6H/g6bG9N9fVv2Z5rdkycq+Lu
         quGOLirZRgg3hfCqZg1F0ju7LmcxyNpKOvcY3RLUxJ7SK2ErsZXWfBL2BvOUthWsRP7M
         UO0b+X9ddUdIX4q/Mk5xhFTQzOzcjFdFyGb6NllnhYHafXuBxq4UtqI8Uk5uOSzsM16n
         RQGa7HQzVnqcM+C15iDtrj7hZ/Mk/6H08QNXYK6PfOHpzeN2nnBakcAoxgYIL8aemw28
         +G5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691586487; x=1692191287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=215ELyogPtD67MCU2Fo0upDMzvPcu4mMk9bpj2gKdM8=;
        b=giN3zdaa/vnUmkhDQ4qRLQLK5R9V2eQ+22aTJcURvUzHyN7kxnT0RRWnP0cuqDs1P5
         ySIW5vvwVjEksMB6N6ChPbyIpwH6zZxOHCrLlYpoT9BNoZnB4hw7muID3aswSb7o1kLH
         h+XE9M7GVavWYDA65Sc34/ES7rDMVK10C976/Gk2Zo9SNEByl2h2ACqcZMn6hsK4FFVy
         lPqnZJYXDzwvbiFlDTZzFQ1Kfc4COLEpb5wcbYNbkG4u3C4Az/etm05NYEc8dwi1B0B/
         JxTjlwPb5LZClcv/ee9jdp6CVwATMyl9SN1MXfjdoKvG+Z0I+YRtE4zXng9H36BUw4Y1
         m/nw==
X-Gm-Message-State: AOJu0YyBgqqx61P3evAZtel5UncXSZiWaKYSE5ua+IDX5xGVlWx5WWmW
        erNgZXCqFCpYgXfXeAjpoLs=
X-Google-Smtp-Source: AGHT+IHolQ4j5LHkFpsv3s7dUA9ZCMIIuZXnvUQ0qzuCUFw2GgYkSrCONZe3esTbaz7TAoxqXOEKqw==
X-Received: by 2002:adf:ea05:0:b0:317:c9ad:e96c with SMTP id q5-20020adfea05000000b00317c9ade96cmr1734166wrm.15.1691586486905;
        Wed, 09 Aug 2023 06:08:06 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id s18-20020adfeb12000000b0031779a6b451sm16763213wrn.83.2023.08.09.06.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 06:08:06 -0700 (PDT)
Message-ID: <dd07a578-9a8e-062d-11f8-7c969b026cb3@gmail.com>
Date:   Wed, 9 Aug 2023 14:08:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/7] rebase -i: impove handling of failed commands
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
 <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
 <xmqq8rat6qou.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq8rat6qou.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/08/2023 23:10, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>    sequencer: factor out part of pick_commits()
>>    rebase: fix rewritten list for failed pick
>>    rebase --continue: refuse to commit after failed command
>>    rebase -i: fix adding failed command to the todo list
> 
> I'd really prefer to see the latter half of the series reviewed
> (both for the design and its implementation) by those who have more
> stake in the sequencer code than myself.

Dscho do you think you will have time to look at the last four patches 
after 2.42.0 is released?

Many Thanks

Phillip

> I just noticed that we have a question on the last step left
> unanswered since the very initial iteration.
> 
> cf. https://lore.kernel.org/git/f05deb00-1bcd-9e05-739f-6a30d6d8cf3b@gmx.de/
> 
> Thanks.

