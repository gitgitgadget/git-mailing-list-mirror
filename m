Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9703B1F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 16:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754227AbeGGQeM (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jul 2018 12:34:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56169 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754220AbeGGQeL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jul 2018 12:34:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id v16-v6so17394470wmv.5
        for <git@vger.kernel.org>; Sat, 07 Jul 2018 09:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sikWMxHnnrn8HDDZVQoVWb/olHSjzzQrqjI/SGHgKfE=;
        b=sYFNLSkvF31z3DkXpYx8fAF2AOVcLOzev+Kt42xtoZP0zFouNaUjq5fl//UL4nAnvW
         dGMogrR5ogdPT3UKYPlR437XRI2uEzyXycVVCYjmAF1X3qjm3wU8UmgF28wc37Q/oLOr
         Onfkeh7v0AEDPmOl8u0mcuj++HQu4WkDrKoDQBsf08JPMPRla5A7phuFLrEVLbtGTHmN
         ppsWRUcE+Acv5aHoShwRSmS8je52VRF6WzlAqmqYp1NY2911VDCTaQclwGxX9fu6aTv3
         aTZysUaNDFfr0tFy1y4x8pUk9HzIV+AatsADZQ2WuTfmvo6WU1rotksVyZjp1HCtYxzb
         3yXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sikWMxHnnrn8HDDZVQoVWb/olHSjzzQrqjI/SGHgKfE=;
        b=I6/qZDaxRP6voYwFZ4pCZwdrifFnUF3u+xx5klce1ixi/EWR72pKNm+zV5jRp1bwD4
         8mgKdP9PThbpELkjSgCicrXrc6UvdLPFpiFo4eHxwvNDi/X7JeTwOY0YYKcuVeX3dGOa
         Gexx+wz3yVvFwRhSByKkj+VkOYmDSthXE1mLLpv2HdKpulnOxggONB2WvSt2z4DIUj8L
         11vqlVdVNBhJtEeT3nz6C6USAjbrgCi8qCkPrYE49DSQ7iH5H6abeFLJFU1pARjGb8PF
         O64LfiC+otQSC9HeISgBigamBaxbqGwXPwzTEzN4ktVmD8eLVKdtqPVRm9kFs5rMEeCO
         IOxQ==
X-Gm-Message-State: APt69E0vdKsYnr8FB8ahcyHxDYCZCl7gbFIgyasi5nIOFDqzcEMpa3Yh
        LA+ZxRYWjuR1xhN3bFcBlhw=
X-Google-Smtp-Source: AAOMgpc2y7WZx5FFb43vrDULOxFp07+HYMGwz6WvMD/tSkaMFU4fwI+2iAV6nK96Ub/3/CFtVUTR6w==
X-Received: by 2002:a1c:b801:: with SMTP id i1-v6mr8470443wmf.30.1530981250109;
        Sat, 07 Jul 2018 09:34:10 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c18-v6sm14864319wrq.17.2018.07.07.09.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 09:34:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 01/20] linear-assignment: a function to solve least-cost assignment problems
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
        <39272eefcfe66de3ca1aa2ee43d6626ce558caae.1530617166.git.gitgitgadget@gmail.com>
        <xmqqtvpcgf40.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807071320110.75@tvgsbejvaqbjf.bet>
Date:   Sat, 07 Jul 2018 09:34:08 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807071320110.75@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sat, 7 Jul 2018 13:34:01 +0200 (DST)")
Message-ID: <xmqq7em7gg3j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Does the "gitgitgadget" thing lie on the Date: e-mail header?
>
> No, GitGitGadget takes the literal output from `git format-patch`, as far
> as I can tell. So if at all, it is `format-patch` that is lying.

format-patch faithfully records the fact about the commit that is
made into the patch.  How pieces of information should (or should
not) be used depends on the purpose of the application that uses
its output.

I'd suggest to match what send-email does, which is to notice but
use the current date when adding a Date: header.  An option to lie
to SMTP servers may be OK but I do not think we want to encourage
such a behaviour by making it the default.

What is missing in the core-git tools is an ability to tell
send-email to optionaly add an in-body header to record the author
date of the original.  We add an in-body header that records the
real author when it is different from the sender automatically, and
it is OK to have an option to allow doing so (but not encouraged
around here---it is easier to reason about the resulting history for
everybody, perhaps other than the original author, to record the
first time you show the change to the public as the author time).


