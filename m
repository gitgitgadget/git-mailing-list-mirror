Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2CAC04A95
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 10:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiJYKPn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 06:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiJYKPV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 06:15:21 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0395831DFB
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 03:08:44 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z14so6430689wrn.7
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 03:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AAmJNao8auchqd3CK/G0PXchXq+bBwacUYPy7xkfeA8=;
        b=YsUvnD2l+zN+YMvf+QWfj2AM+EOVUqROwHi4iUp6tyPD32/6sdWSWL5VFrn/uNcpMc
         HXYL5nhVjxLkYHfZPNtxjfwSyYCiqLNtnyPo3WIAJ8iORpQonb8hOi53i48i0c812zKn
         t2+cQzYir04aQK44bsgcjPJFTSLTxUFhT57hNBxo4jEho7JzupWz2iatU21/KbLgbwLA
         QCt/N8TfRCuK2A4+pF/YcAlKc96ZTNVELGSb1w1kg1GreS/qR4qp+KMygZzk0U+fTnLW
         8RJEYeP+yW14q27Mt/LPMr/eBjRb/K9EXVzZAG5rw9bruClyu5L8f6m8HVEB20AI8qua
         tAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAmJNao8auchqd3CK/G0PXchXq+bBwacUYPy7xkfeA8=;
        b=k0QHROSzT56c7SaQgIkrBuPmQRegalL3xJUKBfNCn92wQCgZvs224hnfCwVouMJSUJ
         FIn+54WzKJ0dL4pKSLVSjF+6r1rQpcJ1Frch87crVTn2Um6GfpErk8UE99GEBrrOxnLS
         Xc8KiRbM9V5rg4YdzfKgnxp/5vyEH6qIzIBhS+U9i2aq4zaw5nfy9YjsHrOQOVJtpX0e
         kseZjLKFajQ+1gYulUTNE2rfZKx7PZhAdCFqa297AvwpuGMqZw6O8uNfT8AgM47D0U6I
         UNysfH4VJ2xt9x5X75KKeA1VWw0tdzScv8uvB0WyZzmyf3ZZR2eauiFflkopRhQ0hg52
         yAuA==
X-Gm-Message-State: ACrzQf3Yo33zL328HZK4MbtB9zmYF6NR54EJhzKXyX8cOQOQtviCvf2U
        yfwmplQ9xehhMv7pkWvVJM/4dV/pznw=
X-Google-Smtp-Source: AMsMyM5K6s6aBUGJmJiD3Fm+kP5Liuf/11jxe/7VwgpeoyJy/23ZzoNAC89yUekt84Qvl50rhwELUw==
X-Received: by 2002:adf:f9cf:0:b0:236:6a26:c055 with SMTP id w15-20020adff9cf000000b002366a26c055mr8581601wrr.195.1666692522476;
        Tue, 25 Oct 2022 03:08:42 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id f17-20020a5d5691000000b00231ed902a4esm2201757wrv.5.2022.10.25.03.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 03:08:42 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <86699708-d631-fb49-482c-af27204a3570@dunelm.org.uk>
Date:   Tue, 25 Oct 2022 11:08:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 3/8] rebase --merge: fix reflog when continuing
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>, Victoria Dye <vdye@github.com>
References: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
 <pull.1150.v4.git.1666344108.gitgitgadget@gmail.com>
 <2c965f4b97c1773abc6b844b87fa64c5d6d1524c.1666344108.git.gitgitgadget@gmail.com>
 <xmqqk04tm62o.fsf@gitster.g>
In-Reply-To: <xmqqk04tm62o.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 21/10/2022 18:37, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> ... This
>> introduces a memory leak similar to the one leaking GIT_REFLOG_ACTION
>> in pick_commits().
> 
> Is it just the matter of freeing previous_reflog_action after you
> call setenv(), or does it take much more involved changes?

We should be freeing previous_reflog_action - I had misremembered a 
previous discussion about setenv() but the manual page makes it quite 
clear that it copies the strings passed to it. However we call setenv() 
each time we pick a commit and that leaks the previous value. The 
solution is to avoid calling setenv() at all and instead use the env 
member of struct child_process when we run "git commit".

>> Both of these will be fixed in a future series that
>> stops the sequencer calling setenv().
> 
> If it gets fixed in a future step in the same series, that is a
> different matter, but if it is easy enough not to deliberately
> introduce a new leak, we'd prefer to do so.

It's a couple of patches to fix which are more or less finished, I'm 
planning to send them once this series is in next.

Best Wishes

Phillip
