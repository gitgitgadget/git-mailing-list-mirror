Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B389C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 510BE61106
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbhDHXHh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 19:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhDHXHh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 19:07:37 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100B7C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 16:07:25 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id n138so6722355lfa.3
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 16:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lu5I+MYH+Gyw9M24OJ+ODTrBHoqBTQBX5UJw7jkowM0=;
        b=A+AO+ppt0UWtHPVzGui7KuT/xaWzTR1gDLsb6gZWjaoIRX0kr6i3BsHlxZxEsK47A6
         lGL3LYcWGa8IwWzAfBVDbzLclWdTa0UYR6uyf/sf90OIuxl6Up0tc4C4gz+6XXNbwBqR
         ePSy+/UN45rtk6ZQJCdtG0IJ33NU+b462VRDlfhVx6NKyz957ZvwR1myVj+MsF3aJKuK
         JUU1M3lp04/iGC5b5KuDOkZhLpO7xzsjSKuMFLhR/VWx17LAfy0LoFVoN9uzuMqBS3Bw
         P5nulhskbECCahGcYamAdAl6lGKDimwc7BFMYP7enhVbw4x4FNHcvp6QAZ+xaTze4n2v
         of2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=lu5I+MYH+Gyw9M24OJ+ODTrBHoqBTQBX5UJw7jkowM0=;
        b=WNo0IT9wBWMOYxeVH5s0d3UAZTfdtRdGKjdZJtporvS2zvM4ik7AD7qfCZAmL2KrTW
         uV+5+z1pCL692ADiUbQpNwMZ/biQ8y8/GKm5MTFMnKYAmVvnwW9vzd6GgLeUwiz8TgRD
         OLPRSEQHI0en9dCJmewLutoYcJzDRjuJ2WozWi7Qf2htbcmVkU6aAHWsPLiKu/XTCuXp
         DBUGYLpIutiSXgFQ0Mib64rVYiLrhybUG8l+TDNmcCyCR09Lyah89Sa0JKjnNM2F42Nm
         nJWDMcBeiG1fFs16thAUGKtIbQ/m9Mty3cd1PpQdt2rb3/vGcZ3GBHRdFgbT9o8IyUSl
         0Z9w==
X-Gm-Message-State: AOAM530z7Fzmiay8IMPwaVXcJRFCgMyYbfg0OagE4UAdpnMZKYg08u+U
        HV6qEasjWcG0N1bgiIEmzt1L4bdBU54=
X-Google-Smtp-Source: ABdhPJwiD03FL1dHSGFaDPXHS9C6x4b3lcRlgXxESeI7wY0u38/oG8gGfAlVxcH+iZArsQVFLnf2IQ==
X-Received: by 2002:ac2:4d30:: with SMTP id h16mr8116306lfk.343.1617923243406;
        Thu, 08 Apr 2021 16:07:23 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t17sm80091lft.224.2021.04.08.16.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 16:07:22 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 7/9] t9902: fix completion tests for log.d* to match
 log.diffMerges
References: <20210407225608.14611-1-sorganov@gmail.com>
        <20210407225608.14611-8-sorganov@gmail.com>
        <87y2dtitlp.fsf@evledraar.gmail.com> <875z0wdekf.fsf@osv.gnss.ru>
        <87sg40imit.fsf@evledraar.gmail.com> <87k0pc7cap.fsf@osv.gnss.ru>
        <20210408221343.GC2947267@szeder.dev>
Date:   Fri, 09 Apr 2021 02:07:22 +0300
In-Reply-To: <20210408221343.GC2947267@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message
        of "Fri, 9 Apr 2021 00:13:43 +0200")
Message-ID: <87h7kg5qad.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Thu, Apr 08, 2021 at 11:26:38PM +0300, Sergey Organov wrote:

[...]

>
>> It looks like something is wrong here, a bug or misfeature, or even two,
>> and if it's fixed before these series, I won't need this in my series at
>> all. Besides, that's yet another reason *not* to squash this change into
>> an otherwise unrelated commit.
>
> The introduction of the new configuration variable, its documentation
> and this test update should all go into a single patch.  The whole
> test suite must pass for every single commit.

OK, fine, thanks for clarification!

-- Sergey Organov
