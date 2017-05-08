Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05A0020188
	for <e@80x24.org>; Mon,  8 May 2017 01:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbdEHBtm (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 21:49:42 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36012 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbdEHBtm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 21:49:42 -0400
Received: by mail-pg0-f66.google.com with SMTP id 64so785095pgb.3
        for <git@vger.kernel.org>; Sun, 07 May 2017 18:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wKrSa4vNIiucY4vu4pj1pscwngkI08VtR2sN8Gw52vQ=;
        b=pWNBN46raiPSq3S2OvLt5XqTv5q8Rzioa+oSi7mnePRrSfXBzjCTzUTxaz0JFOq7Wg
         WuZ58vftSypF/Q2kPQCu6f1PyiP4b/t2D4hr7ohYuof7YGFEgenytlBLhtGzFNZ6o2XU
         6CLq52TlfXAsk7bRV8uUDlGNXEa/ZhKn9xoXEbA+unU39rNh9O/tE4BM+cIeMzAT7Y8w
         BC0HNSOAg3pVHFaLcPC6rRozhEmvu+YsyrL/bD5hF0btz6VnOns95fogtzqvqL8TtziY
         qWF7CQbZ1Pj45W5jCQ+6pyD5JkopZ3Rnj6VyT28SHXr7ysU3UkNAcVQ+I7799wiFF9lp
         3EkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wKrSa4vNIiucY4vu4pj1pscwngkI08VtR2sN8Gw52vQ=;
        b=Elyd4BM1tMZw8AfcLKaW6jsk3dKRqvh4r34q6VHbbiNl6jlz2laD5z3lqkKuu1U/KA
         o4hsMbJ+pRaDva6EL/zFBFueyrLq567RzXHx3rCkjyWoYXN71T1DIP3iuGrzIrtt3kNu
         dqyHfX8AKvYaRG7La3gE1S6If4627d9NMP/mJGJss947NI5dQ8526CUu4oIzriLYH/Ed
         s8jYaCPPJqb0aFhtSPDAoKj4q+rKX+pBJhojgWVqcYAE8xpvh8zDvpF2BTkeIvkgCHh+
         W2/hiVrIf6iIeF/7kmPlS2OONdJntTCWnR7bNZBujz38XkkXwlFuJTJ70/4w1/qv1ZFP
         BaFg==
X-Gm-Message-State: AN3rC/61+vmdsZ2XKzXjj550POdboNKiKnlKw+2N/6ekY7jIN4UqMJji
        fLM9rc026N+0wAXrmhs=
X-Received: by 10.99.163.67 with SMTP id v3mr16389012pgn.210.1494208181532;
        Sun, 07 May 2017 18:49:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3011:642f:81a0:efbd])
        by smtp.gmail.com with ESMTPSA id i67sm10341801pfk.87.2017.05.07.18.49.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 18:49:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/2] split index extra bits
References: <20170505145713.8837-1-chriscool@tuxfamily.org>
        <xmqqo9v4azv7.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 08 May 2017 10:49:39 +0900
In-Reply-To: <xmqqo9v4azv7.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 08 May 2017 10:42:04 +0900")
Message-ID: <xmqqk25sazik.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <christian.couder@gmail.com> writes:
>
>> This patch series contains 2 patches that have already been sent to
>> the list but have felt through the cracks. It would be nice if they
>> could be considered for v2.13.0.
>
> There is no way for anything new to go to 2.13 without getting
> reviewed and discussed at this point---it simply is way too late.

I found that this is <20170419093314.4454-1-pclouds@gmail.com> in
mid April (please do not make readers dig the list archive when you
can).

I didn't see anybody (not even you, to whom the patch was apparently
addressed) commenting back then on the patch and that was why I
didn't touch it.  I've skimmed the change in 1/2 now, and although I
didn't see anything glaringly wrong, it would be good to have a test
if this fixes a reproducible crash.

Thanks.
