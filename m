Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F691C7EE29
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 11:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239807AbjFGLKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 07:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbjFGLKW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 07:10:22 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9691FFF
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 04:09:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30af159b433so7111860f8f.3
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 04:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686136194; x=1688728194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrCVvj6JSMGA+6BEnqmuM2fehZxB6WcBVjCw8lO6v0M=;
        b=Jc05gdsRR15+OutKPvBUoXTqTBeUKliouGkXER19ebgBEWtRFXirtcruftXkIejwVg
         py5/413Cg8eF7M71vJJY9ZI65ND5lSvadq8RecIMcsI18y2UqlyF/cr+cNkVDTjdT9C0
         nvME+8F9lrLEls+qnNon2xxQ49YTO2p58AIff/DewUlRHjAhUFhaEqA7B7a731uFWl88
         skMPtRHM1+IvXS4zCEoYVGOZsJkxOcRVyRsub6/lt9/2xM9c6//ZorKI4LHEsXDoxjZt
         izuROk75TXctjsr7CYVWC2LaVVz7nhyt4o8tkeqtnd7w2nP492BHWjD0Y33dvZQHp38n
         0teA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686136194; x=1688728194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrCVvj6JSMGA+6BEnqmuM2fehZxB6WcBVjCw8lO6v0M=;
        b=ZIN4+R/FI9GQl9LBieNaxyEC24Ko3hWTmZTwBdNy0eD49YUF7anFoLBYMk2IWnjLKG
         e4kJ+8RikDcHRCQWfNulTGBac5p8PVCtJLRWXjiER/dRXgcl0JoC991OlSh7r+YrHYbb
         JUXg3L8HHY+tRCEPawdGAiEKHTn371IJmemB6j7ZS9L6puIShRROwGR/20umE2/QbrxJ
         nxZnXUwPb+T5L/3vlsrO+Ne4uIBprniHCxSERjJkIrC2sFYBtK/0Bxz0x++FbtLFGtbQ
         /vNHNz0/x/FdiwShSnCarFr8lErdKYxHHU32FThrxpQGmhBihGIILOCSrfCKr9j/q0n3
         vcjw==
X-Gm-Message-State: AC+VfDy0rBYzI9tGngsIxQfgwhIXp2R1XS2D6iqEw7a1I+ujYsW4VdSW
        pErbHqfmd4JgjFNDilo624KJ7P83oV8=
X-Google-Smtp-Source: ACHHUZ7e5rB3Ktz3pIBAbiCG+64AOAMppGUmxtt87CbT0AfigFAyYlL8T7MLkfco82MqGGMCzKD3Ew==
X-Received: by 2002:a05:6000:1972:b0:301:8551:446a with SMTP id da18-20020a056000197200b003018551446amr4483718wrb.2.1686136193905;
        Wed, 07 Jun 2023 04:09:53 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id a7-20020adffb87000000b002ca864b807csm15374902wrr.0.2023.06.07.04.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 04:09:52 -0700 (PDT)
Message-ID: <a76a91a0-cefe-807f-f1f6-4a277d724630@gmail.com>
Date:   Wed, 7 Jun 2023 12:09:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] add: check color.ui for interactive add
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1541.git.1685994164018.gitgitgadget@gmail.com>
 <pull.1541.v2.git.1686061219078.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1541.v2.git.1686061219078.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

Hi Stolee

Thanks for fixing this

On 06/06/2023 15:20, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
 >
>       -+	*** Commands ***
>       -+	  1: [s]tatus	  2: [u]pdate	  3: [r]evert	  4: [a]dd untracked
>       -+	  5: [p]atch	  6: [d]iff	  7: [q]uit	  8: [h]elp
>       -+	What now> status        - show paths with changes
>       -+	update        - add working tree state to the staged set of changes
>       -+	revert        - revert staged set of changes back to the HEAD version
>       -+	patch         - pick hunks and update selectively
>       -+	diff          - view diff between HEAD and index
>       -+	add untracked - add contents of untracked files to the staged set of changes
>       -+	*** Commands ***
>       -+	  1: [s]tatus	  2: [u]pdate	  3: [r]evert	  4: [a]dd untracked
>       -+	  5: [p]atch	  6: [d]iff	  7: [q]uit	  8: [h]elp
>       -+	What now> Bye.
>       -+	EOF
>       -+	test_cmp expect actual
>       ++	test_cmp actual.raw actual
>        +'

I know Junio suggested this change, but I'm in two minds as to whether 
it is a good idea. The reason is that we're no-longer testing that we 
add "[]" around the text that would have been highlighted if color was 
enabled. That is with --color we print "1: status" with the "s" 
highlighted rather than "1: [s]tatus". So while the revised patch tests 
there is no color in the output, it does not test that we print the 
output correctly in that case.

Best Wishes

Phillip
