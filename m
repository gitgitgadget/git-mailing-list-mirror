Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9951C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC2F60724
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346863AbhIHBvI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 21:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbhIHBvH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 21:51:07 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E54C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 18:50:00 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id u4so580247qta.2
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 18:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xnuL7r5497pNpYA8FkqnyYgPKwThxdFOq8Dcr5/dJA0=;
        b=WxpDJCe8EoXiX6kGBkgSO5CZxMo6yFzGehYJ2BhHO3cS/kDjDYP1WIsxnW8t9zyNuL
         23Cw5dSwAeOgAPo7Ty+M2upQr4OLlWxWDTJU311r/9JqlxT/kd8Y1PzzwNRgMzr9EO4p
         8LqhUNxT4KnzYXkkU/iCdDePftLWxYMOAF0Wjp9oLZKfY5VSRKH7nbhFxOc3JJj6TmyW
         k1w0eycry2rdE6TyieTQLKAUixjrWaIs4fwFbOaRJ/mm5mjofdeltuY2zMBwZaA7fDcF
         VRNZBqY+was2v5Nhkc2sdZpsQP3bQcJqJJep/4d7TEqi9c9YnL5OswLxDZOzFAxZwYYF
         Z1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xnuL7r5497pNpYA8FkqnyYgPKwThxdFOq8Dcr5/dJA0=;
        b=Zuj6g2c2jDW0RyZIgI3OPMJfWA3x9KLrkoM2nFwF/cjkdfj3zwPPvesbc/lhZP2TWD
         9j+A/CQfWtrOVzg7ITyPFJjn6iDeIX9Q//Qqxfy4QUnaE3XDp0QgZYmFxwxKPe7Gwwp4
         U+CM8PkfSb5YETjblUjuFhpSdsw8ej8JS/f6Xz5I6t566HqiJgcxizIkLb1ipaBICnJ3
         vvpaWXyepv1CfAE6B2hXXl728omCjKDwU31rtmR/gMWBTmLPA7n5wPeGrW4ZVgbMTXf/
         ODcmQwOrY3G9vDKev2IG7jS/+NtN5JQxDwMNGqKIEdzQk+ZVQShKLMy+7ttAC9nfixJY
         M3kA==
X-Gm-Message-State: AOAM532yMDOL5R4XKaQ3izk457yoxNQ5WwEcMAwQicE2VShEOfpbk+XL
        jhFpvz6mCfW5t33bTHEuscxMc4ql5g4=
X-Google-Smtp-Source: ABdhPJx4PhjGgdgZmrQXp8sG8fkVH8umIMdNhszMt6SE7gbAZ1CKOvGFVfAg7k0aDPPidCBs3TzxfQ==
X-Received: by 2002:ac8:7d0d:: with SMTP id g13mr1376239qtb.367.1631065799612;
        Tue, 07 Sep 2021 18:49:59 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7cea:2105:277f:d972? ([2600:1700:e72:80a0:7cea:2105:277f:d972])
        by smtp.gmail.com with ESMTPSA id o23sm629036qkk.40.2021.09.07.18.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 18:49:59 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] merge: make sparse-aware with ORT
From:   Derrick Stolee <stolee@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
 <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com>
 <bb150483bcfd0469cd88bab735bc1178fb6628f5.1629841966.git.gitgitgadget@gmail.com>
 <CABPp-BEF0htk-Q-+wiF+XgTWRRtDc5FPJKauWZAivLGuMgWeAQ@mail.gmail.com>
 <e8a875aa-181f-e71f-55ee-012edccf7ecb@gmail.com>
Message-ID: <b9591211-e58c-f913-d72c-1c0c5cd4a9c7@gmail.com>
Date:   Tue, 7 Sep 2021 21:49:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <e8a875aa-181f-e71f-55ee-012edccf7ecb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/30/2021 1:18 PM, Derrick Stolee wrote:
> On 8/27/2021 6:43 PM, Elijah Newren wrote:
>> On Tue, Aug 24, 2021 at 2:52 PM Derrick Stolee via GitGitGadget
>>> +       ensure_not_expanded checkout -f update-deep &&
>>> +       (
>>> +               sane_unset GIT_TEST_MERGE_ALGORITHM &&
>>> +               git -C sparse-index config pull.twohead ort &&
>>> +               ensure_not_expanded merge -m merge update-folder1 &&
>>> +               ensure_not_expanded merge -m merge update-folder2
>>> +       )
>>>  '
>>
>> Should you use test_config rather than git config here?
> 
> That's a better pattern. It's not technically _required_ for these
> tests because the repositories are completely rewritten at the start
> of each new test, but it's best to be a good example.

Actually, test_config runs test_when_finished, and that results in
the following message and failure on macOS and Windows:

	BUG 'test_when_finished does nothing in a subshell'

So, I'll leave this as-is.

Thanks,
-Stolee
