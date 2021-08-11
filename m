Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54D4C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 09:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 855BC60FC0
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 09:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236764AbhHKJv3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 05:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236760AbhHKJv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 05:51:28 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B668C0613D3
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 02:51:05 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id f5so2139491wrm.13
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 02:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nAi1fZwvoGZ+zxBu2RfTKOSndn45482U7rIB1BwH2gY=;
        b=Hv2PLYAvBkmbjpNd09HfefHUEbQoFLk3e4UX0BeQfh0VE4N5s9lBRm5I0h9xNeeK7q
         eumH/EE8Gp7v/4NzbUeTaKNcTK0/MPL5+mQITVByHQUMqkYRNsf6s+8QZXB25Q06Qg77
         KIjHcMHakGUZP8+RZRDUU4TPsP/oJHDfgJrBEZognggnbvQjUEMPPM6WvbDk56QepCB6
         XlgQkh0tIEi/dTfmSs/xMinSdiX1g4ki2VDgQyv/PhwgwyU1x52j+cIhP7H/h4KiVx+P
         YRL7hkU83ev/xxohhUW9jvW9+/bPwTEgQgil+0pE8W0CHKwnz2y0vPPiFJO3Ka/xLSPk
         D8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:cc:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nAi1fZwvoGZ+zxBu2RfTKOSndn45482U7rIB1BwH2gY=;
        b=AbK5Y5JBNp9iZC5Cg6ZG0LnEv23bs7GhOt1jdwsWRFTFkQB4ga2NSG/h4R3n50Hu75
         rlbw/fUTsChgqKBglE3lMCLBhbBRHt5zcq9R6ID1HckIM2hFXTG04w/nJ0pyARLcGIbu
         nd3z8DNIW3u4+jNoKSr/XN48aYQb7/tyrrjeZxLRs+fuvXP7X5dVxKz3tLNKepuLoxKs
         vHlvc1qVP1WNKBC6X0dlBYJyJ/NseBg5hIsBXAQrREInJFzDwMLbbZYTNVrd0SmfQ4+d
         RjwwRmCw4AfdkunpJyOIEMk6SKk/UcSED1mIP3Q4Cx985uHCaiu8HZDiqo6XQwO+Vs83
         mpGg==
X-Gm-Message-State: AOAM530odA5LAq12uqnpj303voo8gD4TGh/0vNVXgOkx3ukhqzq854Mk
        RLu5DJ78IdsMr4jICrKGKzbaIQTT5ok=
X-Google-Smtp-Source: ABdhPJyvKUdPcVBJN+h3ZwErsvcdN1NIA4u8AMZeEnIBeQfZ6GweLFbjz377y7UG3DFuZ+Q7tleHtg==
X-Received: by 2002:adf:ec81:: with SMTP id z1mr1898857wrn.181.1628675463875;
        Wed, 11 Aug 2021 02:51:03 -0700 (PDT)
Received: from [192.168.1.201] (188.96.189.80.dyn.plus.net. [80.189.96.188])
        by smtp.googlemail.com with ESMTPSA id c190sm23880193wma.21.2021.08.11.02.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 02:51:03 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Aug 2021, #04; Tue, 10)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqh7fwbx86.fsf@gitster.g>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <7fc86441-add0-b08f-17ae-9e0dc5b010b0@gmail.com>
Date:   Wed, 11 Aug 2021 10:51:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqh7fwbx86.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/08/2021 02:12, Junio C Hamano wrote:
> Here are the topics that have been cooking in my tree.  Commits
> prefixed with '+' are in 'next' (being in 'next' is a sign that a
> topic is stable enough to be used and are candidate to be in a
> future release).  Commits prefixed with '-' are only in 'seen',
> which means nothing more than that I have found them of interest for
> some reason (like "it may have hard-to-resolve conflicts with
> another topic already in flight" or "this may turn out to be
> useful").  Do not read too much into a topic being in (or not in)
> 'seen'.  The ones marked with '.' do not appear in any of the
> integration branches, but I am still holding onto them.
> 
> Git 2.33-rc2 will be tagged tomorrow, with a few build and
> regression fixes (not in 'master' yet as of this writing).
> 
> * ab/progress-users-adjust-counters (2021-08-05) 3 commits
>   - entry: show finer-grained counter in "Filtering content" progress line
>   - midx: don't provide a total for QSORT() progress
>   - commit-graph: fix bogus counter in "Scanning merged commits" progress line
> 
>   The code to show progress indicator in a few codepaths did not
>   cover between 0-100%, which has been corrected.

I think the midx patch wants to be dropped cf. 
<87v94jzoxj.fsf@evledraar.gmail.com>
> 
> * zh/cherry-pick-help-is-only-for-sequencer (2021-08-03) 2 commits
>    (merged to 'next' on 2021-08-04 at 9ea14ed106)
>   + cherry-pick: use better advice message
>   + cherry-pick: fix bug when used with GIT_CHERRY_PICK_HELP
> 
>   "git cherry-pick" loses its state file when a stray
>   GIT_CHERRY_PICK_HELP environment is present, which has been
>   corrected.
> 
>   Will cook in 'next'.

Sorry I missed this going into next, I thought the conclusion was to 
drop these[1] in favor of[2]

[1] 
https://lore.kernel.org/git/CAOLTT8S+x3aGRopiXwWcNYsyQtiGWChR+f8u+7nM5A0xpusR3A@mail.gmail.com/

[2] 
https://lore.kernel.org/git/pull.1010.v3.git.1628142482640.gitgitgadget@gmail.com/


Best Wishes

Phillip
