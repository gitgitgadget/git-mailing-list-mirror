Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 604B01F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 03:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbeJILCz (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 07:02:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36369 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725759AbeJILCz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 07:02:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so334477wmf.1
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 20:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4oJcfulHqosr5CnFtswrtO/SFiUiiA1mz6S1TlcT5K8=;
        b=sD/l4SMteWv7AJRXMq1/YSurvXRva6UlaOWlA2nBSCroI7fvlDg4kFxgUv2xcp+2jW
         tW86w64qwQRt3x849gK5/uZXZcPYp6OuvJ0jgNVdXjYsDU3wc4EmQQR8r+/qgc39A+XA
         Qki3wUtM4zNMavskSSdyBySE1bQTQQaSFpQrpmbhUauKX7urQI2Z3gDaB6UuXM2D5DHf
         NvJ7acccrQno5l9tgwuDrNDDhNkIXje2sDUj49rCGlVJZzNaMSUbqFjNrzibHgpsjqlX
         N7KdjdNK8qEiuoMBJNrI5THxnKW/FRHmaZrYeG4rKWeeNNyCObbRYCBpgedphfJG4oRH
         5O3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4oJcfulHqosr5CnFtswrtO/SFiUiiA1mz6S1TlcT5K8=;
        b=dfqrb2D1PDVh3zWaXzRiDmnuuIRcyzP1Kr/EA6oUu44P7roR/YPlmNiOdkztggfqvI
         qI5aFksSxZ47QIA2Cw5bjaxc0xx36vc7LVViqOiWLIHLKwE+kMTDibrrvnJfuzZgN7bD
         vbW+sOYptNPYJZjkTkQ77jnTFZX9eTQhy1ahpeCptrYnsMySNjzI5nMSkbuza3FbMi0P
         o34eP60Zc6tJOGS7QMOUi8u8GWbx+M2KAztkWESjoSlPZQBriqdchTF888U0IK7/nc4Y
         gLxXgSFvhSw91/PSPmCfBRxWngn7WFGkmBKGV3iGCuW21OQF/i+j1J8Iu1+4QhujzeRj
         m5Yg==
X-Gm-Message-State: ABuFfohCQfV5mY7WNSscTz32oayEJ3ILD5RIGqznz1of9X199H3sEgGj
        h6+3LYNdZ5x9BQC1zEWia4UYb3D4OGU=
X-Google-Smtp-Source: ACcGV62o/UTETGX5NhTT1vFOEY8zRFQjLzkLfX23ypkWnUTofNblOk36apH6IsCZPLgi7P4R/BVf9g==
X-Received: by 2002:a1c:cbc7:: with SMTP id b190-v6mr406048wmg.149.1539056882660;
        Mon, 08 Oct 2018 20:48:02 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x15-v6sm15120592wrt.90.2018.10.08.20.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 20:48:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v6 09/10] submodule: support reading .gitmodules when it's not in the working tree
References: <20181005130601.15879-1-ao2@ao2.it>
        <20181005130601.15879-10-ao2@ao2.it>
        <xmqqd0sjss91.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 09 Oct 2018 12:48:00 +0900
In-Reply-To: <xmqqd0sjss91.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 09 Oct 2018 12:39:38 +0900")
Message-ID: <xmqq5zybsrv3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Antonio Ospite <ao2@ao2.it> writes:
>
>> Finally, add t7416-submodule-sparse-gitmodules.sh to verify that reading
>> from .gitmodules succeeds and that writing to it fails when the file is
>> not checked out.
>> ...
>>  t/t7416-submodule-sparse-gitmodules.sh | 78 ++++++++++++++++++++++++++
>
> This now triggers test-lint errors as the most recent maintenance
> release took t/t7416 for something else.  I'll do s/t7416-/t7418-/g
> on the mailbox before running "git am -s" on this series.

This is an unrelated tangent to the topic, but running "range-diff"
on what has been queued on 'pu' since mid September and this
replacement after doing the renaming was a surprisingly pleasant
experience.  In its comparison between 09/10 of the two iterations,
it showed that 7416's name has been changed to 7418 but otherwise
there is no change in the contents of that test script.

FWIW, tbdiff also gets this right, so the pleasant experience was
inherited without getting broken.  Kudos should go to both Thomas
and Dscho ;-).
