Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA56C7EE23
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 23:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCAXzb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 18:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCAXza (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 18:55:30 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA08E56785
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 15:54:56 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id s20-20020a056a00179400b005c4d1dedc1fso7748397pfg.11
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 15:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677714896;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B5BMtfPrGghC9eGCRwkdOr/nkyzw/BbSpr5HSb2pLR8=;
        b=jlLRV3z8PFCqhzeiOaDgtFGjZgaalO0kqut3rJOungeWlRtTMVHAWq40JYfId4TM2v
         gYWLELnseeCPTQ/5rbWdMFeYSm81zQroVhajceBOLn8g14gatXn9qLIc7IautC1+xtIW
         IdmTIkNPIkAGTDle+a6U7OOi2/uZqGSHxjLRgw/45bYKHJEWB+1hpAFaVggbNYVv1gmz
         WflfKXGXtCa1ny9ZkIEjkvllELu078fL3b+3d3aQiA/Qk+RAZPDsDLbLiOJpZZgtoDsz
         4Myzn2qSD2RhKBtYjxzec+MTbFrn3Ab7g/YvR1ccpRXMlRxcv5sMDEQQ6xv8axwEJ5i+
         JaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677714896;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5BMtfPrGghC9eGCRwkdOr/nkyzw/BbSpr5HSb2pLR8=;
        b=cBg/8DCwj8cjOrH4C86y6i4DNKLNFFa7ToeY7p0Mvg1a4QFkaqx4Go/XnTn8tWkh1o
         hOq3MW2VnBr5hENIYCyTSrzFR5kq5tZM03CBC4PVcyV8vtUBqIsSqzpTwN4zm4x2oOMQ
         cl4LL00zWgByg49NB2Fs27PBVg16a+JqnXFUS+i2GQCdEurhoZrNbur9bBp6OGeSzmPr
         e4+JZepJwzIJ5/2mvO6PR8m/QnYtjq75OGt+9KIA18OX9LtdjKEOz8rjHx6Bfymq6/CN
         szm+2xuA/K3p9z1l/iacyvVMY9qsIztGTRQ1dj0ce6ZzrV2l0X2krgpPYxLbxKK1cQhV
         WJEQ==
X-Gm-Message-State: AO0yUKXslTHAj1ApHpTjFMIsIpYKvi1wPDfJTVU8xZ8N2N9ozFQqBLkV
        VRL8hGyuzpIqDPn5DQUAvDHhgPd6ebNUlg==
X-Google-Smtp-Source: AK7set/Gcp/LjaGLON5a6L6itYN18gDIuQelGlybNMP/P6oXSjJ4m165yK0/k5rYrWxUHrKECG33wWPH7xe67g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:7109:b0:19a:64f6:e147 with SMTP
 id a9-20020a170902710900b0019a64f6e147mr91083pll.2.1677714895907; Wed, 01 Mar
 2023 15:54:55 -0800 (PST)
Date:   Wed, 01 Mar 2023 15:54:54 -0800
In-Reply-To: <878rgg2jnq.fsf@osv.gnss.ru>
Mime-Version: 1.0
References: <xmqqr0v7o0pp.fsf@gitster.g> <871qn5pyez.fsf@osv.gnss.ru>
 <xmqqedr28wwb.fsf@gitster.g> <87357ischs.fsf@osv.gnss.ru> <87wn402u3n.fsf@osv.gnss.ru>
 <xmqq356om831.fsf@gitster.g> <878rgg2jnq.fsf@osv.gnss.ru>
Message-ID: <kl6lk0003u41.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: What's cooking in git.git (Feb 2023, #01; Thu, 2)
From:   Glen Choo <chooglen@google.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey!

Sergey Organov <sorganov@gmail.com> writes:

>>> This is still marked as "probably won't merge" in the recent "what's
>>> cooking". Could it be merged, please?
>>
>> I found the explanation given by Glen last time you mentioned the
>> topic much better written than anything I would write myself, and I
>> haven't seen any new input in the message I am responding to, so...
>>
>>   https://lore.kernel.org/git/kl6lr0v2i0gn.fsf@chooglen-macbookpro.roam.corp.google.com/
>
> I believe I've addressed it with this:
>
> https://lore.kernel.org/git/87wn4tej2f.fsf@osv.gnss.ru/
>
> and seen no follow-up since then.

Sorry for the lack of response, especially if it seemed like your
concerns were not listened to. I did try crafting a response when it was
first written, but it didn't end up adding anything new and valuable to
the conversation, so I dropped it.

I'll leave an updated response, but unfortunately, I am still of the
opinion that we shouldn't merge this series.
