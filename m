Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7280FC43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 21:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240730AbiGSVzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 17:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240587AbiGSVzg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 17:55:36 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4258663922
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:55:35 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id t3so21481518edd.0
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=oI7mrZC7p9nr+0QvqI2t+IP9Qu/kPe+9oc32na1iGKc=;
        b=LJXUNJ0qiySNUp31QEWgJJSpTHomfVm7EwIjAsTODRuBbii2p6lj2KGKSl7lOSiNKl
         a09jHqEPfwuvKwcIK8zhcmPkmQEcWXqcHMgf53/PRfj4vB2aR4KTDH6U2sXAGc6J83Uf
         j3xf/7UCSgwPGGhL5a85PuAhd4N74AWCUr8l/3V8S6b06TnZTIAZ2A4hX5y7oDf+T5Ky
         ZuRx1NNyTCFpzYYegNgbaReY8ulHRsGUb9rdR/BmQRNTVFYhwXcfXjmRttZ3W8/xguwN
         npJIPAqh21M9jDcFj8y9uktlz6jz11vgys8BtHQfZJTOORGABH7EpmEr/6vmiMYRMzsm
         Eubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=oI7mrZC7p9nr+0QvqI2t+IP9Qu/kPe+9oc32na1iGKc=;
        b=tCpyeIhlqppPt0/bmMEodYYI8CSRlwnMp2Hu2Qbu+Xe8c92ANqUOIYCvb4tfQ+Ad6W
         TWovpk8+sbbqOtfHKWIHrRG1brrcePHYqX5CuvGDvNA8uVr6/ZrJBngjkudThP60h+Kc
         YmunG1kbjwCDyxe6F/gUMbtKOPQq8BLye3QgpCUa1tyB75rM+NNvi/89UK1G9fT0fcGt
         Z5gVesAqvSaqQ8Hbcwk68BoRrZMQicPYC78APUT8m1BtkcWWPM6uS7/XOapTPuV4dsIm
         G16pz3cVPN+xZ9pEAEoRNXdmbAvSnvbGLG1w9TKB/62yHdIAW2aR8Pq09YMXCIfGyqgs
         nkwg==
X-Gm-Message-State: AJIora/wuJCqujxi63KVzQySJprOjTg1pbxrju4RWSHwBq3LM4Jbz/FF
        UhAXV8NhpT6qA1JSTqxgCzu0ZFgPMLfNig==
X-Google-Smtp-Source: AGRyM1s8MtJSSuDJ3dZl9RVaggdYJIhhfkXKYXVo8Saw7QA2SLi/U5qZx4jAp0ui+6Rqj/JhCFYaLQ==
X-Received: by 2002:aa7:d64b:0:b0:43b:1f5d:1443 with SMTP id v11-20020aa7d64b000000b0043b1f5d1443mr38976396edr.370.1658267733637;
        Tue, 19 Jul 2022 14:55:33 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g3-20020a170906538300b0072b14836087sm7082018ejo.103.2022.07.19.14.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:55:32 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oDvBj-003qux-OQ;
        Tue, 19 Jul 2022 23:55:31 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] repack: document there is no need to avoid
 delta-base-offset
Date:   Tue, 19 Jul 2022 23:54:18 +0200
References: <patch-1.1-363f84a3fa7-20220715T075114Z-avarab@gmail.com>
 <xmqqsfn21fmt.fsf@gitster.g> <220716.8635f1zdg3.gmgdl@evledraar.gmail.com>
 <xmqq1qujt334.fsf@gitster.g> <220718.86tu7eyhvz.gmgdl@evledraar.gmail.com>
 <xmqqk089ewbx.fsf@gitster.g> <220719.8635exwje8.gmgdl@evledraar.gmail.com>
 <xmqqbktk93kl.fsf_-_@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqbktk93kl.fsf_-_@gitster.g>
Message-ID: <220719.86h73cvkbw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 19 2022, Junio C Hamano wrote:

> As continued use of 1.4.4 by people stopped being an issue long time
> ago, we can safely remove the warning about interoperability that we
> added in 1.6.0 when the use of delta-base-offset has become default.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * Instead of outright removing, it probably is a good idea to hint
>    the reason why the now seemingly useless configuration variable
>    is there, perhaps.

We cover that in git-config(1), I don't see a reason to continue
dicsussing it in git-repack(1) as well. Just above the paragraph you're
modifying we link to it.

The patch you've got here also replaces a specific reason (pre-1.4.4)
with a vague reference to "hardly any reason", leaving the reader
wondering what that reason is...
