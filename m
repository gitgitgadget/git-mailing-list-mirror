Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6D8C433B4
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 19:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF1761168
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 19:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhD1TKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 15:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbhD1TKP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 15:10:15 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BC5C061573
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 12:09:30 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso4330793otn.3
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 12:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KXcv6AnNPvvGKmqO6VeFrvwtA7GuEZWNgHXh6v++86g=;
        b=tCZO3NkdPn+SpN4oSgiiwoqCTvTNf6o4RMuZ/L/amUk1vyuTudGorFbiq22ytYxVS5
         8WU8WNT6WBl7gUqPODyi1jAhBKCeQWRzE6XLy1lOsKBgyBVvEi5GTgK91AMfysrxGJu8
         w/oH8sbOjyl54VnsXnxAMNtL6/Wjncza7ow/QcuMq4EoxvQZnAVqs8aNuANf60d7uNaC
         aFQLs78ppDfSm1rASWAiIsuFMNOmslam+Sf+ynw9keEMf+5qXQ8sLMFL75PBBZPhb588
         V/nDdKByO2kbFQoX+rRW1M9RbvD2LIk9n48xrjwfxAHqqOsDr6CliLSmKaTS2bxVdyn6
         KqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KXcv6AnNPvvGKmqO6VeFrvwtA7GuEZWNgHXh6v++86g=;
        b=JucdfFch+pCgf8VMsQd+1l+IdbePhQaUeFmDx8PbCpEgY13UWLSVEdZlIPLpQMTa8n
         2cwVigBy989s76pJAMK3l2/Qdt70wvuwyd5BT4S2/6gNgNKwxr7liLjDkb+TrG3EPjWk
         jFXxPHpIDb2rF4uoeBXVsdy6lVrt8ASrMQKaNRolGopStHw88LZ/UcaqtnzQBx9AgMVY
         X3ELpRJ9NMmE4fd+OTgJmci/lHrst0gYtgb9ywFLipfRi+p6VDW478quuF7lppH12nKq
         ZQWgFGJjLOLaI3pWLq3UUnU5oS3QcBHdXYAfZlU5UIZFLm2fo3YWp3hos+rDPkDXGXMa
         NqVw==
X-Gm-Message-State: AOAM530ezOyiv9Z5JcFY3bkNfQAnHxktD+d53BWeYtZhVIZCE9UDD+y6
        EtlElAMKJxmc/0pYOAnrN5k=
X-Google-Smtp-Source: ABdhPJzZSKT0eUv3InxggaXiuUOqLKuM2/Hhqdqcn466mGezBQ+QdCJ1tKYNPc6xmkvXvFnJTVuM2A==
X-Received: by 2002:a05:6830:1584:: with SMTP id i4mr25939499otr.129.1619636970027;
        Wed, 28 Apr 2021 12:09:30 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:2cdf:297c:4e71:33bc? ([2600:1700:e72:80a0:2cdf:297c:4e71:33bc])
        by smtp.gmail.com with ESMTPSA id b12sm174606oti.17.2021.04.28.12.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 12:09:29 -0700 (PDT)
Subject: Nesting topics within other threads (was: [PATCH] repo-settings.c:
 simplify the setup)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Patrick Steinhardt <ps@pks.im>
References: <87k0omzv3h.fsf@evledraar.gmail.com>
 <patch-1.1-e1d8c842c70-20210428T161817Z-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1ecb3727-106f-3d04-976a-36aa03a61caf@gmail.com>
Date:   Wed, 28 Apr 2021 15:09:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <patch-1.1-e1d8c842c70-20210428T161817Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/28/2021 12:26 PM, Ævar Arnfjörð Bjarmason wrote:
> Simplify the setup code in repo-settings.c in various ways, making the
> code shorter, easier to read, and requiring fewer hacks to do the same
> thing as it did before:

This patch is interesting, and I'll review it when I have some more
time. Probably tomorrow.

But I thought that I would point out that this pattern of adding a
patch within the thread of a larger series makes it very difficult
to separate the two. I use an email client that groups messages by
thread in order to help parse meaningful discussion from the list
which otherwise looks like a fire hose of noise. Now, this patch is
linked to the FS Monitor thread and feedback to either will trigger
the thread as having unread messages.

I find it very difficult to track multiple patch series that are
being juggled in the same thread. It is mentally taxing enough that
I have avoided reviewing code presented this way to save myself the
effort of tracking which patches go with what topic in what order.

Since I've committed to reviewing the FS Monitor code, I'd prefer if
this patch (or maybe its v2, since this is here already) be sent as
a top-level message so it can be discussed independently.

Thanks,
-Stolee
