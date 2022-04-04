Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37E8C433EF
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 15:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354301AbiDDPtT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 11:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240217AbiDDPtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 11:49:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89430BB5
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 08:47:20 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m30so15180997wrb.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 08:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rAnGy+LzzkbAE42vgNAfrf9PGQYBpRQq/GxB+qsGEtQ=;
        b=Lab442J/zBKo07Fjd6LcSrMDzGimszCo1NqG3fX4GKTMl0cA3F7axTDQuKChUjdA1J
         PnvAyB3cqrjOwMXfAGDfF84Zt558PjPtTdz7kzcR2RfiMrg3PWLw1InRiHoOYfpE2dZh
         6VSNciFIWAVY3hZZeIyX0YNPTuZthxpRBb5FxVkpWNYdDL0KKsGkLtMORz5sbJ3a9Qnm
         mdvLXsNfFvg9gC+aRH1aeWo608wdKdu37ZHn6HvtoIH/SjU2+VnZfxJZ4iOl7ixz45ik
         3b/og+KU17hGH1GwGAgPoRLGOjSJtDnzadPOcDHdlgOVIDDgHugKxMLU65DFuBysjhfu
         7SyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rAnGy+LzzkbAE42vgNAfrf9PGQYBpRQq/GxB+qsGEtQ=;
        b=tV8N07Hp/xZUWnsCEXV3A4LImPapl2IV8/IG/A3WeuKjGt95079OxsVAX+QQC5gNtS
         nsjkEInTsviWxNHdQae7Fbvgj1wflfPEHNUJVZQ49jtn6uZ5OoKU5/soCTFropKsM80X
         oVTeGQdLbTANQtnbQ3OqaEkDya4rrKEfNmpQAZE9pNDI1Cx9CGvhsZzJR3O6L0Hmo2cg
         cTPNcdnmbiQlmjM09r9FP+LNFTjielAFhuxMytK4J47THCenug2qAuhta7LU5KXu7y9x
         Z9aDuJEzNfhen3DXlR++oE/Jq7frfgU1ebow3NBuBrFlVPHY37VUYo+Nih98UMCKi9Iu
         m+8w==
X-Gm-Message-State: AOAM532CcyV3XE1s0t93D7ET+QklMq1aRO2XsoUyK+jHuK6eIhIeQdez
        xZthhK9H4cxnr+lpZBr/dyc=
X-Google-Smtp-Source: ABdhPJx/YNbZyTjFNC0WXguxAJDbYnIYntuEEzz2LpcHQHiV8btAYnu9FsIxX+4cCCvC/tJ9K5rR2A==
X-Received: by 2002:adf:e848:0:b0:206:19e1:fa07 with SMTP id d8-20020adfe848000000b0020619e1fa07mr331330wrn.32.1649087239066;
        Mon, 04 Apr 2022 08:47:19 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.224])
        by smtp.gmail.com with ESMTPSA id w12-20020adf8bcc000000b002060e3da33fsm4490724wra.66.2022.04.04.08.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 08:47:18 -0700 (PDT)
Message-ID: <d0622cca-245a-ac98-cc96-201a9c28c3cb@gmail.com>
Date:   Mon, 4 Apr 2022 16:47:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] worktree: add -z option for list subcommand
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1164.git.1645801727732.gitgitgadget@gmail.com>
 <pull.1164.v2.git.1648743688825.gitgitgadget@gmail.com>
 <xmqqk0c926zf.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqk0c926zf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 31/03/2022 21:37, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
 >
> It also made me wonder if "-z" alone should be made to imply
> "--porcelain" (in other words, is there a good reason to ask for
> NUL-terminated output when you are producing a human-readable
> output?), but we can start stricter like this patch does; we can
> later loosen it if needed.

That's a good point about "-z" implying "--porcelain" we do something 
similar for "git status -z" I think.

Best Wishes

Phillip


