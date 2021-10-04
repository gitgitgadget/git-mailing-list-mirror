Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352FFC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 10:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1976261373
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 10:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhJDKCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 06:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbhJDKCO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 06:02:14 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365AEC061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 03:00:25 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p21so3276363wmq.1
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 03:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H67pxyNuXuZbPajfCJ5n/l36PNEsU0Dd7NmAkZncdxY=;
        b=lOK+NGeskF8u4M2exN5f0PPwJf0FEq93/Rogt4cPcw/IJRtzD6Eviv4KeHQUWT+YAd
         4jBwEobUPaalnZ8H1j666+yHJH7SClIN3dC7pVD+N/7JQfnWasAc1HbCdYMiHNwqfuAv
         gnRRtowcR3xHuZtexYOJKj4+WVyLugd9W+ih1DIksPlvWqcewLmWKht7QoMBTTD8idBj
         zfFB7KIKn0TAusU51pkHHXNd6/7k6Vt11IHWJePE5/i64BbnpkD0TwK7bXVI387fwIPu
         x0Ct+4ZD27UbXG343PHMztnK/kyciv5vq7gZ0qHkdBNcB+utvSYmlPCe8z56/ftkTm3n
         t3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H67pxyNuXuZbPajfCJ5n/l36PNEsU0Dd7NmAkZncdxY=;
        b=e1AhLjgz8YLD5qvaO4tDE0ixEirMcPcmYfF53sFnu6YF6CR6GwOwZf2JhqlJWGnTOD
         p/0ip6V9kTypLBMU6iLyPCo7hiAlVZJy8t1fmDXMdXP1RcYClrNjYaaZc7va0O57WVJ2
         i8n47jRHEKyWDd9yBFXSc9Ton8+B8vDYtcnGzx0yCXLmVblq37UPEnjzVZiG6kxASCUl
         TZMEw/pFuedXnC1b86XC0a4A7W+3aQrsJkziiTyPBAnMHScd3Sdj0qWol3jDYUIJnsLc
         lmC3jE2Ms51+8Calx7BKuFAaRDpn8BrRQAb+8Umwra8lcV1xqVZ3+uSxgEkPFwiDv6Ag
         CYiQ==
X-Gm-Message-State: AOAM533VTXSg7vgxSPcHcvwCYtY4ONMJriW/lsAwLv1ukDABmmljRCUU
        j+XE6O3TYEIrv5rjokRbSfs=
X-Google-Smtp-Source: ABdhPJy0ButaMSmrxS6/uZarGXmHBerCbwT+X5yNeUwFqpScWEZL1MY0IkDYoW7EA8fGUGeBkKFgvA==
X-Received: by 2002:a7b:c216:: with SMTP id x22mr3721576wmi.32.1633341623880;
        Mon, 04 Oct 2021 03:00:23 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id v18sm13574398wml.44.2021.10.04.03.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 03:00:23 -0700 (PDT)
Message-ID: <97b8cbdb-60f9-cba5-2db0-6ae77a9afd60@gmail.com>
Date:   Mon, 4 Oct 2021 11:00:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 04/11] reset_head(): remove action parameter
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
 <fbaf64d6b282730f91b16ea7d5844fb0e8d779da.1633082702.git.gitgitgadget@gmail.com>
 <xmqqpmso5uno.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqpmso5uno.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 01/10/2021 21:58, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> The action parameter is passed as the command name to
>> setup_unpack_trees_porcelain(). All but two cases pass either
>> "checkout" or "reset". The case that passes "reset --hard" should be
>> passing "reset" instead.
> 
> Describe how the parameter is meant to be used (presumably "this is
> to record in the reflog", perhaps?); without such explanation, it is
> hard to either agree or disagree with the claim that "reset --hard"
> should be "reset".

How about

The only use of the action parameter is to setup the error messages for 
unpack_trees(). All but two cases pass either "checkout" or "reset". The 
case that passes "reset --hard" would be better passing "reset" so that 
the error messages match the builtin reset command like all the other 
callers that are doing a reset. The case that passes "Fast-forwarded" is 
only updating HEAD and so the parameter is unused in that case as it 
does not call unpack_trees(). The value to pass to 
setup_unpack_trees_porcelain() can be determined by checking whether 
flags contains RESET_HEAD_HARD without the caller having to specify it.

> Also state if this change is supposed to have any externally
> observable effect.

It'll change the error message if we cannot clear the stashed changes 
form the working tree from saying "reset --hard" to "reset".


Best Wishes

Phillip

> Perhaps this improves what is shown in an error message by affecting
> what setup_unpack_trees_porcelain() does?  I am just guessing,
> because the proposed log message is not telling.  Please do not make
> me (or other readers of "git log") guess.
> 
> Thanks.
> 
