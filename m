Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5ACC433ED
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 13:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D677A60FE9
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 13:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhDRN1g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 09:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhDRN1f (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 09:27:35 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280FFC06174A
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 06:27:07 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u7so14509540plr.6
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 06:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b21DSjhaWDhR/CaGWm5Ftgr51CRSVAAjRfWwQAZ6qRQ=;
        b=gIS9x5CbPXDzpWVTivncBPP48AH2fnYIUahAOrCgkQ6RFIHABb+cB6Q/cA0IC8kQNT
         GhPmdO/GI6K+lBKFMfFV1eO1Z1G0DvY4e9MJJc3GN+JBbiqkDMq2CewJB94+UR0v/TjL
         hA9Q++HjMUYRPMUfvCFAUTN9Fh5b1yZCiVi5vvKI8qpLuQ9C6c1RViUhiED91s/30+E2
         Dzc4uuQCwLKpNb2wS3mo+MpBxj51bJdbm6xD54Epe1uevSrBW7RE9IfE55HDCvTWRQkQ
         UTRtdJUShInECA5baG3YRopQMMWyDWdY7S5L7IO3nt00OnflFPiPcyHAx56jBgOUlI7j
         0Gjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b21DSjhaWDhR/CaGWm5Ftgr51CRSVAAjRfWwQAZ6qRQ=;
        b=JrkmUwYcQdLOFTK/sd4JZlHpfxCek3N0HfWskX0YUnFKruTweMkuIIbmAc8L/tqu62
         KLP/AYPW8SuDRRYerllvl0UEOkRmRvrI90H2+9aIzW/m8Krv5FdDQ6/B2wTN9nJ7uFat
         jvAdU1a7u1V60dQVLEhBxIU8eGi/TAqlHioKy2DDzAGYEkKHsgzA7Z8r6QroN3EVxSAd
         s/Cwdl9uJi5hdq+EBdmw5s0NJk1k36u9wRJ/PNcCUHKtrUK1eo4BB6vGpvl4yHB1o12C
         vfYc2UMKNeRqXDELaKPxCnPaz3YbERgMojfbLwdLjfzHnza7dACno5GNlMi2DRWscUsv
         Xqfg==
X-Gm-Message-State: AOAM531rkUxDMOswK6WijSaOUy7LO9eHnDlKxDAizfz952v6YrPjQxWT
        BfGx4kyetvdlUA6D3O7CeOob1IDERLA3NA==
X-Google-Smtp-Source: ABdhPJykFD+pk14FLc6ZniUhzYHMXoUJVOc8kxJDz0IwwAcQ/KYEc8GDjNZCVkPHWSP+dcRDBde2sA==
X-Received: by 2002:a17:90a:9509:: with SMTP id t9mr20030250pjo.3.1618752426327;
        Sun, 18 Apr 2021 06:27:06 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-89.three.co.id. [180.214.232.89])
        by smtp.gmail.com with ESMTPSA id r3sm7933748pfl.159.2021.04.18.06.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Apr 2021 06:27:05 -0700 (PDT)
Subject: Re: [BUG?] 'git describe seen'?
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>
References: <xmqq1rb8bhl4.fsf@gitster.g>
 <5cb071aa-16d1-8ea8-39e7-a0f5b89cbf3a@web.de>
Cc:     Git Users <git@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <41392642-d4ff-7a0f-f92c-ea78f4a0b0e1@gmail.com>
Date:   Sun, 18 Apr 2021 20:27:03 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <5cb071aa-16d1-8ea8-39e7-a0f5b89cbf3a@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/04/21 17.26, René Scharfe wrote:
> And vice versa, the fifteen commits that increase the depth of v2.31.1,
> but not of v2.31.0:
> 
>     834845142d l10n: de.po: Update German translation for Git v2.31.0
>     408985d301 l10n: pt_PT: add Portuguese translations part 1
>     1369935987 l10n: vi.po(5104t): for git v2.31.0 l10n round 2
>     b0adcc311b l10n: es: 2.31.0 round 2
>     c21ad4d941 l10n: Add translation team info
>     8c4abfb8be l10n: start Indonesian translation
>     8278f87022 l10n: zh_TW.po: v2.31.0 round 2 (15 untranslated)
>     2f176de687 l10n: bg.po: Updated Bulgarian translation (5104t)
>     1ecef023a9 Merge branch 'fr_next' of github.com:jnavila/git
>     5b888ad949 Merge branch 'master' of github.com:nafmo/git-l10n-sv
>     068cb92300 l10n: fr: v2.31 rnd 2
>     f6a7e896b8 l10n: tr: v2.31.0-rc1
>     929dc48e96 l10n: sv.po: Update Swedish translation (5104t0f0u)
>     9b7e82b940 l10n: git.pot: v2.31.0 round 2 (9 new, 8 removed)
>     4dd8469336 Merge branch 'master' of github.com:git/git
> 
> That matches the observation above that the depth of v2.31.1 was
> increased by twelve more than the depth of v2.31.0.

Did you mean fifteen commits between v2.31.1 and v2.31.0? If so it's
illogical, because these commits (from git-po workflow) were merged
on rc1-rc2 of v2.31.

-- 
An old man doll... just what I always wanted! - Clara
