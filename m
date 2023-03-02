Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4458C6FA8E
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 14:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjCBOiP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 09:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCBOiN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 09:38:13 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2320A1632D
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 06:38:12 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id by8so17813182ljb.7
        for <git@vger.kernel.org>; Thu, 02 Mar 2023 06:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eG77Ljsp3KfJByK9xIcTETu2+p/r4OVoOe3kJVUEIOQ=;
        b=DW0i8faR+wz+ASRXeIordfVueo3J0z9Rxjkmtux0w13UAZ9ohUGBJlE+XiLc/KQKoI
         yG4IOfMQmcj1NyYF0DUIdHpjDuHArDHuMnL/4E2NLpvFk3+bYcLPA/iKVYmGW94fYaAU
         4zogVJSK49Tl0HVqZNAJZugQPWQWR3sqsrG3PPoPiVLZqBwgOZudCj93Agp26Ub+3BDb
         t61N2A0cgy5/x/Md9JJzbPY8B57VIIKS744eBfo22lQcBlNJOtfqXd244hBPYa1eqjba
         XhJZ27tIVAsi4zbatr7ckzUPlW+wxLeXMIaTFD9Z+oeNmbbBVTMZZaGXuWOV0YmEOMhj
         SOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eG77Ljsp3KfJByK9xIcTETu2+p/r4OVoOe3kJVUEIOQ=;
        b=o+LpnW9AI8duFg9OXORjtHCbSZM222HJxFkPnTeypX3R20aqPG5iL/7fcA4KGaqoj/
         JGiCRAoQHx8ZJbtoRxmmjuYXtKv/BUqFhxsnGhhosJsyeqlDBOJgQgStACms3iYX5OKT
         bYhBYF35+PSgJWDAnpbkOSdC6ohdNakD3Z/I2sxDHju9MAjGk//SEMxOs8/j6tIP07/y
         kCgnM3+CESNeyNYkT134PzgQlGsMs1mRoOhj0Mugp59crL+jmWQh9J77apqAF3vHeW+e
         fMhaGJhAtkyXLQQTk8q0rX7HZQlrRCmcH9R1i25Pbjg7hYAXVKL6wTYaWLDumINxAmI7
         xaqQ==
X-Gm-Message-State: AO0yUKVQqJthMmAFbvg5Ej8KRoy3IBRfd9zn+hdwgxkeve8LQAW1p1Wc
        XLKqlSbF1+Q12um51w2saR32OWPegGo=
X-Google-Smtp-Source: AK7set/bE/WHq85TftVA4+T0kjcQKqm/5HbiFf3t9/K/qxoPIkMaI0EoymzUrBWP7awqFmCro9hBdg==
X-Received: by 2002:a05:651c:222:b0:295:a3aa:e7c2 with SMTP id z2-20020a05651c022200b00295a3aae7c2mr3163794ljn.36.1677767889693;
        Thu, 02 Mar 2023 06:38:09 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p8-20020a2eba08000000b00295b1afd27bsm1905520lja.66.2023.03.02.06.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 06:38:08 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2023, #01; Thu, 2)
References: <xmqqr0v7o0pp.fsf@gitster.g> <871qn5pyez.fsf@osv.gnss.ru>
        <xmqqedr28wwb.fsf@gitster.g> <87357ischs.fsf@osv.gnss.ru>
        <87wn402u3n.fsf@osv.gnss.ru> <xmqq356om831.fsf@gitster.g>
        <878rgg2jnq.fsf@osv.gnss.ru>
        <kl6lk0003u41.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Thu, 02 Mar 2023 17:38:07 +0300
In-Reply-To: <kl6lk0003u41.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 01 Mar 2023 15:54:54 -0800")
Message-ID: <875ybjrzg0.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Hi Sergey!
>
> Sergey Organov <sorganov@gmail.com> writes:
>
>>>> This is still marked as "probably won't merge" in the recent "what's
>>>> cooking". Could it be merged, please?
>>>
>>> I found the explanation given by Glen last time you mentioned the
>>> topic much better written than anything I would write myself, and I
>>> haven't seen any new input in the message I am responding to, so...
>>>
>>>   https://lore.kernel.org/git/kl6lr0v2i0gn.fsf@chooglen-macbookpro.roam.corp.google.com/
>>
>> I believe I've addressed it with this:
>>
>> https://lore.kernel.org/git/87wn4tej2f.fsf@osv.gnss.ru/
>>
>> and seen no follow-up since then.
>
> Sorry for the lack of response, especially if it seemed like your
> concerns were not listened to. I did try crafting a response when it was
> first written, but it didn't end up adding anything new and valuable to
> the conversation, so I dropped it.
>
> I'll leave an updated response, but unfortunately, I am still of the
> opinion that we shouldn't merge this series.

The primary question here is: why don't allow me to get the behavior I
need, provided it has no impact on anybody else, unless they decide they
need it too? I've already performed "you need it, -- do it yourself"
dance, along with documentation and tests, so may I be rewarded by
getting this feature finally in, please?

Thanks,
-- Sergey Organov
