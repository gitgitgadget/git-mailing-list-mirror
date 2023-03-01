Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299F6C7EE23
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 22:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCAW0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 17:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjCAW0N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 17:26:13 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C272532B5
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 14:26:05 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id r27so19657144lfe.10
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 14:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4CMtUzR7SMuF7gH2kJx1d8Al8eCHA/ZcNgvBBV4zTF0=;
        b=QlU8WjzXY6OpoY4TzwJTPaA/JOsTHQ7MbprwDGU+XCpzyQQZaYjbHRnJA0aVqK0OWJ
         a4H6ksZDDV9gAVZuduS9GDQoMyGiPJMP4UtdNlw9TQUQ+FnF1fHHeK7SOm1dJeKXNtCF
         FFPdalZaeeb11yqoq9AebToGoU2pDh2LzLCLcvayZj7iKpWtfyJrfW5sItyToG7OYaW+
         obMgD7HeqdBD0E5xi0JsRq+ziufwbUxqCSYzrZptfc2S+PkyR/0FmcwleSF214AY6i42
         nyep15fET69tdsrw6Ud52oV532YNtcWOuLXQYTkqBshqAovNqZdJu662Vn8pOpFRYmoY
         B/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CMtUzR7SMuF7gH2kJx1d8Al8eCHA/ZcNgvBBV4zTF0=;
        b=FsoUnMegpcQOkOb3XYXxD1g1upA3NyazIVb01pCHKa8dX0TtThonGSuDD0cSTlIEc6
         dm8W6wH6SeXBAeWQ2r50PcWShMZBuqbhqJC2WeFUMmEEdeXWcfP23ytZYk3WM1btML8M
         1oOBh+gdkKS5JMliYkHIdhGRxf+3cYPcQkCQdIoCCWxcUJIa8qKxzmNNO+6Vni70rGwc
         fXmB1mecPRbhzGMRMi8puvxm/MbvuI2XSfVeoZbmn72hsOfwozXqv8zp3lYA6OVHvtBe
         c6lxmX0DU+i2IzY0uPv85SgtHJatSj3zddu2mNH4dmlrPM3NLczauFKQDPaN6nnCUTUp
         hUWg==
X-Gm-Message-State: AO0yUKXuReV1fzqQM86si+e8ZxnP/Hc2hZBaN9cNbWKHUlIp61FKXyCT
        KZ+OVbRfpZKXnVNxyt6ctFzohRILyws=
X-Google-Smtp-Source: AK7set9UVfjEv4ovkueICxwSgUH1hgzTPnHvoIJ8FKQiypfLdU6NTamuCcP1lJnsINOsN+dcCG6LAQ==
X-Received: by 2002:ac2:4c89:0:b0:4dc:84b3:bc5f with SMTP id d9-20020ac24c89000000b004dc84b3bc5fmr2189606lfl.30.1677709563543;
        Wed, 01 Mar 2023 14:26:03 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id a18-20020a056512391200b004a91df49508sm1882215lfu.177.2023.03.01.14.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 14:26:02 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: Re: What's cooking in git.git (Feb 2023, #01; Thu, 2)
References: <xmqqr0v7o0pp.fsf@gitster.g> <871qn5pyez.fsf@osv.gnss.ru>
        <xmqqedr28wwb.fsf@gitster.g> <87357ischs.fsf@osv.gnss.ru>
        <87wn402u3n.fsf@osv.gnss.ru> <xmqq356om831.fsf@gitster.g>
Date:   Thu, 02 Mar 2023 01:26:01 +0300
In-Reply-To: <xmqq356om831.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        01 Mar 2023 14:15:46 -0800")
Message-ID: <878rgg2jnq.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>>>>>  May want to discard.  Breaking compatibility does not seem worth it.
>>>>>>  source: <20221217132955.108542-1-sorganov@gmail.com>
>>>>> ...
>> This is still marked as "probably won't merge" in the recent "what's
>> cooking". Could it be merged, please?
>
> I found the explanation given by Glen last time you mentioned the
> topic much better written than anything I would write myself, and I
> haven't seen any new input in the message I am responding to, so...
>
>   https://lore.kernel.org/git/kl6lr0v2i0gn.fsf@chooglen-macbookpro.roam.corp.google.com/

I believe I've addressed it with this:

https://lore.kernel.org/git/87wn4tej2f.fsf@osv.gnss.ru/

and seen no follow-up since then.

Thanks,
-- Sergey Organov
