Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961EBC4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 05:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiLHFl4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 00:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLHFlp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 00:41:45 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B528790778
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 21:41:43 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so3554344pjs.4
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 21:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZiJp9xbHHbGd5rmn2uVQPUjqjXihk3pt3Dl39INDEc0=;
        b=hHmzwaVv/GpvNt69InzqHqr6s3AKg+XZR/9RnMIp8TnjCAs19J0SYj2Gga55BiLs4p
         QQ5m8572vDWUAdumBZsI+LwSc2xa8/P9nupV/PT4PtWoPVqM46DIziMWEz258zsI8A68
         DZDv/3GW4tNG3d22AXN5VwTpBqfgL9QTQX3rcWOS8DSwuaa9ieyQxt8Cq0yMo1b/KMd3
         O9EKDou8YC0GUy5SzsOK5CsxuM8f7Sr7slxgK6L4q2TYXx0xx9quk9QcAd/YfhDc/afN
         sDjm0JdmxjVqm+OltkLMse+hRyBMty2y34HY5ZoxDLzxph76tUtEY4QjA+qHO0SS7ADm
         Wu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiJp9xbHHbGd5rmn2uVQPUjqjXihk3pt3Dl39INDEc0=;
        b=PdOeGbTATO9Us/byd23fFoX9Ysf0udgYMHu8nTrnFUOtNO4r8JVZKuw8njCFVH9jYa
         ynmBPxdfb3ZyX3IaxoYn77dqjpYPS1De93ac0xrXOe115kTepvzkcnHvXpPTzX0lgClI
         XiiRnD53LNTY0K7gEjL1c6uwj4kXh8ksP2CnhvzD/UE1T6ezin8tojYfERVktzddsGW5
         rOmQDZolDWVkqZGmt/BbzbMgIzUpJNvGBHXNyDiKt9za93H3r5JOaDP1s9Q4nZxlnUvg
         IzrheHdpSPL9PHZDJ7I1JQbPhG1pqF4ayksTNzV3+fiAPSv8ZDNC6o55XB6rZSUZL6Wy
         L61Q==
X-Gm-Message-State: ANoB5pnbG7gPLoUrJ4em8a1Ed6T+eDF0zREckPhrA7CqQeU3midy2SJ0
        o2FcJNOkmoJA8ayG+koK434=
X-Google-Smtp-Source: AA0mqf5aEXz+yYaG4NhoCRIa9d+ougbK3z4oTqhidLWGBZRPcH3ztE6Yz++AUCHMpPgZYrejITdYEQ==
X-Received: by 2002:a17:902:d48b:b0:189:63be:8abf with SMTP id c11-20020a170902d48b00b0018963be8abfmr2182321plg.53.1670478103053;
        Wed, 07 Dec 2022 21:41:43 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id o8-20020a170902778800b00189a7fbff33sm15520055pll.170.2022.12.07.21.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 21:41:42 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] CI: migrate away from deprecated "set-output" syntax
References: <patch-1.1-deb65805345-20221206T195811Z-avarab@gmail.com>
        <patch-v2-1.1-4e7db0db3be-20221207T014848Z-avarab@gmail.com>
        <xmqq359q6a30.fsf@gitster.g>
        <221208.861qpa91ti.gmgdl@evledraar.gmail.com>
Date:   Thu, 08 Dec 2022 14:41:42 +0900
In-Reply-To: <221208.861qpa91ti.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 08 Dec 2022 01:27:28 +0100")
Message-ID: <xmqqmt7y4fl5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> Let's stick to the dumb and proven
>>
>> 	echo "base=$base" >>$GITHUB_OUTPUT
>> 	echo "head=$head" >>$GITHUB_OUTPUT
>>
>> instead, which is used throughout the rewrite in this patch.
>
> Sure, I'll re-roll with that.

Ah, no need.  I've already amended the one under discussion and it
is in 'next' together with the last bit from Johannes to use the
updated upload/download artifact Action.

Thanks.
