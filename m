Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2EAC4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 10:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE05D60FBF
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 10:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbhHLKFT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 06:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhHLKFS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 06:05:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10EDC061765
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 03:04:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q18so595286wrm.6
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 03:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FlrVB5AiZ/muYWGchWKRbBZmsNTjBcpcL74GWlpEKEc=;
        b=YBHRY5/ZAiWroYGoAWfFDoRpx7jNvUSxINiM3G+8FjsnWWLrA04Hawhz6gHftXG6d2
         EudBGsMlx/r9Fj/EwQ3DV+zd3jBS+kuIbzmAr2NWOeYUUnc1AzcSkIShwLGX7SpdNtCr
         a0kY4oFe/eEUwt3zE0Dyi3SxbhKAY5QHXXpGv49c5sgiNKZum8FGowRQ7eiW/slEMIKQ
         ar+9u5OIBDBTWM99HZWVFLWvzQ/6dPtdimT/0MIFKEc2skNPk3jgDponexiFmqjIsQgy
         Mj5+f8ulVhn+txaHSsafOUJDqicNzNeKIZvhFLL7em659Ixe+yNHLBum7Lx27TAbX2v5
         63zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FlrVB5AiZ/muYWGchWKRbBZmsNTjBcpcL74GWlpEKEc=;
        b=q/rU8esg3TdI6K33WRIAg/r6rUxePV9pTC7o9QhP2D7bZboQeaH3lCRFFN9lLqVd2y
         Ahi31gPF2M4y083O1UPttxa74tLwcs0hQ6L7Xyv85RxHr2Bd5em57piyZUBiU8vR0W8x
         JlOKTIV1ebWkjY3XZlXud0An9QTQ5tJCsBHykP/BAiucIRZacQcAm02b20NaoX0DOh4e
         d/NcZ6nkLeqpgrsPTQYJwCUPNFaqJIdPN+Kxs2CyBbIdNQCR6lbg/pIFPx4/Xn1dfVVJ
         B3rvczCZ9woSWceF1+nJCU7FKXJxhi3Jk2w14abA03chzee5yMjlqRtab2SesnH23lPS
         KV+w==
X-Gm-Message-State: AOAM532mUrVepR1vI+FCsIMBmFWTw7HqPq1dKi7nnpzrB26npTgDQlod
        TCjWYR25GmvjZGIuKlmtL+w=
X-Google-Smtp-Source: ABdhPJzNxdeUbHrtM1x/U/vZFIDE61HWefQ04BXmQvp15O8oksInkeWuG3bKj5OUJcRzz6ZFzA2wGQ==
X-Received: by 2002:adf:a49e:: with SMTP id g30mr3003889wrb.219.1628762692354;
        Thu, 12 Aug 2021 03:04:52 -0700 (PDT)
Received: from [192.168.1.201] (188.96.189.80.dyn.plus.net. [80.189.96.188])
        by smtp.googlemail.com with ESMTPSA id i5sm2325108wrw.13.2021.08.12.03.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 03:04:52 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/3] t3403: fix commit authorship
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victor Gambier <vgambier@excilys.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1013.git.1628587917.gitgitgadget@gmail.com>
 <7559781ca92096f89a6dcbfeeaa4d2b4d7b98094.1628587917.git.gitgitgadget@gmail.com>
 <CABPp-BFFTLgtrs_m9Gp7tSRwpBnAEoArhMZhhJcuzqNS_g8sUw@mail.gmail.com>
 <xmqq5ywddtsn.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <3b438e42-488c-e4ab-d1fe-3d0992ef0619@gmail.com>
Date:   Thu, 12 Aug 2021 11:04:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqq5ywddtsn.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/08/2021 19:43, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
>> On Tue, Aug 10, 2021 at 2:32 AM Phillip Wood via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>>>
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> Setting GIT_AUTHOR_* when committing with --amend will only change the
>>> author if we also pass --reset-author
>>>
>>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>> ---
>>>   t/t3403-rebase-skip.sh | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
>>> index e26762d0b29..6365c5af2f7 100755
>>> --- a/t/t3403-rebase-skip.sh
>>> +++ b/t/t3403-rebase-skip.sh
>>> @@ -36,7 +36,8 @@ test_expect_success setup '
>>>          test_tick &&
>>>          GIT_AUTHOR_NAME="Another Author" \
>>>                  GIT_AUTHOR_EMAIL="another.author@example.com" \
>>> -               git commit --amend --no-edit -m amended-goodbye &&
>>> +               git commit --amend --no-edit -m amended-goodbye \
>>> +                       --reset-author &&
>>
>> Makes sense...but doesn't the fact that this test worked either way
>> suggest that the specifying of a special author name/email was totally
>> superfluous and could just be removed?  If there really was a reason
>> for specifying a different name/email, then is the test faulty for not
>> checking for it somewhere?
> 
> Good point.  The commit tagged with amended-goodbye is later used in
> some tests that ensure the author ident does not change across a
> rebase.  If this commit gets created without authorship customized
> (i.e. before Phillip's fix), we would not catch a possible breakage
> to make rebase discard the original authorship information.
> 
> But with this fix, we now can catch such a breakage.

I'll expand the commit message to make that clear

Thanks

Phillip
