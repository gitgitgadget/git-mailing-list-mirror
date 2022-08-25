Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5718C04AA5
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 04:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiHYEn6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 00:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiHYEn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 00:43:57 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA1D9E0F0
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 21:43:56 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id c13-20020a17090a4d0d00b001fb6921b42aso3641476pjg.2
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 21:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc;
        bh=iazYZtWIgHqiIzBcIPkaBZ8fhBdfCFG4mR4J5sPG274=;
        b=L3e18fznPFAyNYJRsLLFGoT4lcYfFgPNps7xUJU/m3/u+FpKJTHD93G4jBcEdC3Fis
         e0fXb/usjtOm5Zd6P2jpvZfaQ3yVbhy95mNdr8H5x1x6xguSfZPT4q9DuI2/qCpFlkJ/
         CUkLfxcf/xZAdDUrJLWJiO3ukeYjnaBUDp0sM46ghNLOMDN9+aidXoDuNhrYtDI13XZ6
         nK7mN+8YH8pc0gbZTSXYihx2XYb3RDsAqN2oLJbEOSb3rjKBW/PXYDl/AK6yatdQ4TOy
         Jio4HLfixTEhFiwJktjabUTdCG610lGI4w1k++2WkF5K+ysfjOdNtEnStrc3JiDBbTKc
         ANjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc;
        bh=iazYZtWIgHqiIzBcIPkaBZ8fhBdfCFG4mR4J5sPG274=;
        b=yLRPP+zePWDOgi/T75rnCrsR45WDv8kdm7keAPzGGOkNiwuoMuzyRk8gZlYHwyHLpT
         tGF7eSJz98OgDUFZ5vr3ksjhvkz+HWM68pQpTZMBPu5K2YlezHj9uz/oNeIR+gq9aMwE
         YRy4Mq5f76H81C5+vC1Tzz2d4hbhbRk5H9xELPOESJZOfE742QAdgCjw5HymPtlIXqJo
         wiKsG82yZZr2a0pQJ0ozqWp932tXJubWoZAU2naj5YohAvEl4EB8NI3goVEoGJj9Eg4H
         0URLu0BA4wGn+FY8SYGAsx3sdoQSOBK/cm2ab8DDrW9VsAbVhanVZzwKFDEnMe6T9VSQ
         IQ9g==
X-Gm-Message-State: ACgBeo1NOTgjMSmIFiuJb+YTMAp+F8lNDuEZmQR+AzQB3L9DZYDbqtZT
        ayGQB65VHwB6RSNA3YK65Q6BO6Y/HG0=
X-Google-Smtp-Source: AA6agR45OjxQ8kFZqr+RM6BEfsh4DYV7A5yu81odqaj3V2Y66iqQRaFmXtC2W6DuMWg7Zvqnynr12Q==
X-Received: by 2002:a17:902:cf11:b0:172:6437:412e with SMTP id i17-20020a170902cf1100b001726437412emr2110527plg.77.1661402635526;
        Wed, 24 Aug 2022 21:43:55 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p13-20020a635b0d000000b004296719538esm11853288pgb.40.2022.08.24.21.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 21:43:54 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: update 'static-analysis' to Ubuntu 22.04
References: <pull.1334.git.1661275691795.gitgitgadget@gmail.com>
        <xmqqwnax438x.fsf@gitster.g>
        <7364f631-e05b-0db8-aaa4-9f0101b6db56@github.com>
Date:   Wed, 24 Aug 2022 21:43:54 -0700
In-Reply-To: <7364f631-e05b-0db8-aaa4-9f0101b6db56@github.com> (Derrick
        Stolee's message of "Wed, 24 Aug 2022 20:30:51 -0400")
Message-ID: <xmqqfshl3pbp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> We probably need to fix or revert/remove rules we have in
>> unused.cocci that makes bogus "suggestion".
>> 
>>   https://github.com/git/git/runs/8005321972?check_suite_focus=true
>
> Yes, this is definitely a bogus suggestion. It's probable that it
> is picked up by the newer version of Coccinelle.

Yes, I think we should tentatively disable the offending one until
we know how to properly "fix" it.
