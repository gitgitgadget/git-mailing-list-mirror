Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379D4EB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 21:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjF1VXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 17:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjF1VWs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 17:22:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4203C3A
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 14:18:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c108dd0d9deso147900276.3
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 14:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687987129; x=1690579129;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0RXSqmqBB92ebJn9sji4cGNLz/0cga7JPbs+xleP+J0=;
        b=JMD4wK2zovwU99AkTAW8Wn7ZlJvACXiZ6mm32/WbBdrb98tCgLF+O9Y5XwFAtEVxIr
         Trs7P7Wf/rnVSf7ApqONFjtcXdxgD/r0SwYjAqLB78eZmJnY5F8Cb7HaAZgFVGlZY38j
         cbxnf0l2S9GUR54ECnpGdAUvRW+xatKSGNKT1pvyPMKCGMkden4op6a1gxvcm3gqfNpq
         ZM6i5wJ/LdffaIobf8b3cvGDAVcrTGw6THDeZGLvzW3KYk3K26YmRGtr8BCaOBpSScGX
         zfOEKSbbzaYJlHZYNI31gIW029iH7rpPbSbVUliYAVUlcMtC2oEw233jekszITYWKdWU
         C8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687987129; x=1690579129;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RXSqmqBB92ebJn9sji4cGNLz/0cga7JPbs+xleP+J0=;
        b=FAumpY3KHPl6/SHP7MmDAUzP7VHg+7u06FwBcTG/A/78PIIyN887SiWV7JvKx7ZLUB
         Ip+KaPyHdWrDka48mRDu9OMaJUPNIMRiwLlmNVx9nZob2e2uieRMxYtascKdHHgZtpn/
         kn6ZQN0xjSMlpFAlETlwTDj/DyXkArN1iHJg1SXPrwOuQyFOxe6RrtPNamcq9/mPVmBh
         zgcgliGspsgzsNDAd1jHvBIhxUyO2niMWn7tG3hxUbQOGH2Gfo12+rFjouuTP5rhsU4I
         3O16GRZPnftRzMiBlW5ISXR2XE5/DpcMVupmIEpLldMre+f5DCZJhXWFr0WhxcqzPkLT
         jOPA==
X-Gm-Message-State: AC+VfDyX55Cjk68fqyHbMtDAjur86RHN6sOpSR1ZYl0I7l7gBR97iGuc
        MLrmz+D/ETAt73PfW5fHQGDRHmOFTHp6yQ==
X-Google-Smtp-Source: ACHHUZ4rjVsobiHU6fUDIuP5axqONt9Ejrfpka0OVgqHA8zm/loAiKB46ne5Pz18IlKHHTsaW17sakwa6vd8rw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a25:d605:0:b0:bc8:c749:eede with SMTP id
 n5-20020a25d605000000b00bc8c749eedemr15539494ybg.7.1687987129218; Wed, 28 Jun
 2023 14:18:49 -0700 (PDT)
Date:   Wed, 28 Jun 2023 14:18:47 -0700
In-Reply-To: <xmqqbkgzcnao.fsf@gitster.g>
Mime-Version: 1.0
References: <xmqqcz1gftdn.fsf@gitster.g> <kl6lh6qrqtbj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqbkgzcnao.fsf@gitster.g>
Message-ID: <kl6ledlvqo94.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: cw/header-compat-util-shuffle (was Re: What's cooking in git.git
 (Jun 2023, #07; Tue, 27))
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> I notice that
>>
>>   https://lore.kernel.org/git/20230606170711.912972-1-calvinwan@google.com/
>>
>> is available as cw/header-compat-util-shuffle, but AFAICT that's not in
>> this announcement or 'seen'.
>
> Yes, I have found that it had too many bad interactions with topics
> in flight and, keeping it out of 'seen' was very much deliberate.

Thanks, that makes sense.

Perhaps it should still get a call out in What's Cooking? When Calvin
referenced that series, I went digging in What's Cooking for the topic
name, and when I couldn't find it, I manually listed the topic branches
starting with "cw/"; fortunately, Calvin's contribution history is short
enough to make that tenable ;)
