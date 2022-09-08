Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B09C54EE9
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 23:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiIHX7A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 19:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIHX67 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 19:58:59 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A25D100406
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 16:58:57 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so3800919pjq.3
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 16:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=rZse/pI2lJfKtcc4LHRJUuNMDZn5HljWv6Nh3KWR0lw=;
        b=RlTobrNxXo8A8vERrT9DrIdvq1h22DKv7WlSuvU69KxOBPHoi6TfFx0PKB52K7xzzz
         LiFo0TOx8T7j2LDnLwC1DL/+Pu2RaDGhnULRuS81XsRQpFkeIcSaxvKLsc8WtnJK8e4v
         pKpJjxAyVEC9BhhN6GsnRJhG0zgpCc3bxAPp6w6g2F5QfL/IeZ4pfsH1+xk6eFhO6GYm
         Eeqg0r7KXLZbPtSfxT2c1GM9gxPHBdy4cIawDQrlYKHIo/ycvsM8/Ob18E8H07PH7D6z
         CGDDRR5Syxpn1C8YTZ+wa3/fvy/2cX3+ky051NKEWWOBwONKoMnRbooLwIigWqk3E+DN
         ZVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=rZse/pI2lJfKtcc4LHRJUuNMDZn5HljWv6Nh3KWR0lw=;
        b=aAdx0cN+B83i/mCBhtOKCOlQRnEsJQrGxi5z17r59c9vPl9D3QLtL+XC/ifsAMk/C3
         RU1ZTVC5OuYqFOsIzHKr+Tv2BGXI0B92Y7IbYDpjGpEDST8BCPV+E59Ea1VIph0Lo/Ye
         SxPjV9rp034SBRkzyTExdhZmzf0p5tptq6lMMnRqHnanFKofASXyisiWPNWelW0qvWci
         G6oy45zmRqWLC5/MJJKWwNBYuHV8FIW4y5rAJW0YIRyt0/CTA0h3njZt07KLkPGouVcY
         cu0WwTqVXwzQyFz7p5lKQ/vXlJdvLWQmGljyJt8n3YcxS9sUt2QuW5J7m3vrO+I06jE8
         cxeg==
X-Gm-Message-State: ACgBeo2wIqkDLAssyP1wNsKnXHHaQMn/8OM0fwVd5Hobf2TYQU9/3odW
        QMSGENH1oS6cp7MzjqRZC2VtJLeM2lI=
X-Google-Smtp-Source: AA6agR59XYfJQJqIz9WYeKGVYfWDYxwAEEDeZfeV90VAofSqZCpCTavsm0jXEySKZh78W8aVZDiJCw==
X-Received: by 2002:a17:902:ecce:b0:16e:e6e9:69b9 with SMTP id a14-20020a170902ecce00b0016ee6e969b9mr11256623plh.139.1662681536675;
        Thu, 08 Sep 2022 16:58:56 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id g12-20020aa79f0c000000b0053f5266a62csm188802pfr.170.2022.09.08.16.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 16:58:56 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 4/5] cmake: avoid editing t/test-lib.sh
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
        <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
        <22473d6b8f3d4e4c482c27a4fb3b58705d4c93ca.1661243463.git.gitgitgadget@gmail.com>
        <531620e1-de4c-74aa-c840-c12ce81f8740@github.com>
Date:   Thu, 08 Sep 2022 16:58:55 -0700
In-Reply-To: <531620e1-de4c-74aa-c840-c12ce81f8740@github.com> (Victoria Dye's
        message of "Thu, 8 Sep 2022 16:37:44 -0700")
Message-ID: <xmqq35d1o1ts.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> I don't think it does more harm than good, but I wouldn't go so far as to
> call it a definitive "net improvement." I'd personally very much prefer a
> solution that didn't involve adding 'GIT-BUILD-DIR' just for the sake of
> CMake.
> ...
> ... "switching between make & CMake" file staleness (if I'm not mistaken, the
> same thing can happen now with the modified 'test-lib.sh', so this patch
> doesn't really make anything worse), I do think the changes to 'test-lib.sh'
> should be rearranged to preserve the "PANIC" check:

Thanks for a quality review.
