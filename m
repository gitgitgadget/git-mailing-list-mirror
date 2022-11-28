Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB33C433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 07:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiK1HvM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 02:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiK1HvK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 02:51:10 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689B815808
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 23:51:06 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id a9so6214090pfr.0
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 23:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OI1/4Opw6Y9pqcMIOslTDvzW1IWDUfCOrUkm758PWv8=;
        b=OV3MQU6XzIU4BhM7DVjsdjigvuufSNU1HPEANtzRtSEasyxHP0lBsawQXkF3xtOenb
         ey7nKU8YYFPijuszvjnsuZOenT85o70jNJoKwV5W0S9VAJi3Pd9LY+n46YbIewhAo55Y
         VFaF24jxD1nFtkezz8PjtW43bWRmxfAvIUJOeWZL26s3JUj+ZMESEVGaSZyC6yj7SwYO
         ANj9KayeBt7knrQBM0JxkJLTFBL2wcOWzUK5v3rLdgX8Kpazk2jchv9ijujzFyPvSwkS
         xWC4Ut88rr4NQKifU07zKZAR3Gksu3aO8k5tJMffd+UYaR1Muzbbqz7HkN1a/Dv+bFc5
         9bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OI1/4Opw6Y9pqcMIOslTDvzW1IWDUfCOrUkm758PWv8=;
        b=EbNgFdV481kiX4Su5UlidiIp0x38tzVXh+D1EcS2t5/ALTgGaaC1gTustHo8mz/wI3
         FNuwdwhZ+H/5kKpvofkpdU/SyZCQx3P9JxAlRhu7bT0AYonw+DhZkkwRaXkN4EALi5ts
         SsIW2Cja0kqPaoo9RqiXzzGh8509OqTl8/xvKGuVw+F66YfXydfDJex2eKF4x30G7Tqt
         eYvZaVRuX8LQU0yrrYiCUJjIOnv4MIFdLMjS/J0vBD+Ihv8ocRUbLW2jL+ULeyB+hUZQ
         y+DOLFPjgVPtiXCQXBG4z9YA9HH+GG/9mF3GTujZA4dFaN+r9YDDWsKrK/Eg94k/R67K
         w0Yg==
X-Gm-Message-State: ANoB5pmRJ8wSIIF0GR5Cn1kYYHGHIB5ll9FHQ7hWxEhPMY9OTDbubEGA
        5742GK3bWhnMTNjKHg0kaSM=
X-Google-Smtp-Source: AA0mqf53i8I6RqaUdYm0hiGcU6aUYICUwTRe5MvwDRSQmla9alP7EyfqkJraQIy39aoR9cwWFoXdmg==
X-Received: by 2002:a63:fe01:0:b0:477:bf35:acb1 with SMTP id p1-20020a63fe01000000b00477bf35acb1mr20408430pgh.439.1669621865699;
        Sun, 27 Nov 2022 23:51:05 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y187-20020a62cec4000000b00574de4a2fc7sm4072461pfg.205.2022.11.27.23.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 23:51:05 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] diff-merges: more features
References: <20221127093721.31012-1-sorganov@gmail.com>
Date:   Mon, 28 Nov 2022 16:51:04 +0900
Message-ID: <xmqqfse37c0n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> 2. log.diffMerges-m-imply-p
>
> Historically, '-m' doesn't imply '-p' whereas similar '-c' and '--cc'
> options do. Simply fixing this inconsistency by unconditional
> modification of '-m' semantics appeared to be a bad idea, as it broke
> some legacy scripts/aliases. This patch rather provides configuration
> variable to tweak '-m' behavior accordingly.

I do not know how this can be a good idea.  For those users who set
the configuration variables, those scripts and aliases get broken
anyway, don't they?  IOW, I am not sure how this is better than the
"modification of '-m'" that is "a bad idea".  I would understand why
it may be a safer and more sensible solution, if the proposed
approach were to find an unused letter $X and to introduce "-$X"
that is the same as "-m" but implies "-p", though.

> 3. log.diffMergesForce
>
> Force specific log format for -c, --cc, and --remerge-diff options
> instead of their respective formats. The override is useful when some
> external tool hard-codes diff for merges format option.

Not convinced it is a good idea for the same reason as above (not
convinced it is a bad idea, either, though).

> 4. Support list of values for --diff-merges
>
> This allows for shorter --diff-merges=on,hide forms.

Good, probably.

