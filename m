Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12F1C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 00:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiLSAsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Dec 2022 19:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLSAsw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2022 19:48:52 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA316374
        for <git@vger.kernel.org>; Sun, 18 Dec 2022 16:48:50 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id n4so7569159plp.1
        for <git@vger.kernel.org>; Sun, 18 Dec 2022 16:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mI7uAlPklBFbvXMQyg0A9/cI6noFaYRDaUygqSP5/XM=;
        b=QyIN5o+fhtoQVSF+DVQVwSXDkYUwcLPClx0T0jiWlUSrvSTPFaYHCl2lN1ij0s3/gE
         398ZzW9O9xNCzCVqxORbTnQzEQv7XxGvKOo9s/a0l2oVKmYqcB4E4hjYP7kQwS+U9IQ1
         Ctv9tN56/vSteW9Bmrf3XwyPAoZJzQFiNUCxuttLU8icnR2LbWAJbR4eD0HiyM+s2VnN
         4vQ84MMpLlcrAd2sjOKb9LD9XD2I5L9PKgs3RgR+2BElCjld2TeEn5bXPDutVS1XXjIt
         V0tFuuGdH9QXfmu4eGx3RMJOYqyAzXfP9JbPRaPeMvcVEFp9lsJvWfBCflPrigEGO9sS
         UAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mI7uAlPklBFbvXMQyg0A9/cI6noFaYRDaUygqSP5/XM=;
        b=RxczIOOJvG4E8ndL7jkwbQwWh01/JLAaAxQWtJQoBC1iiixNPQcTExfge/aat3DigQ
         r+gVXxMIXPcVtxcqFncnjd31aoLwd3lfSM0ZT2C7GZ3K5g9H16uCmu3grY2sMkc3ZJoy
         bkXB2R1+JUQlPbe8EX4mjT7j+FJIRc8ooSB1hz3I3GskmoQWdjDO3D1ClY7+JiTAd7j4
         2JZk1b6MEXsCHv3RCUvJvtgxeWiXsDRsSzM5Dvn0fyCJSib9KMxIP74jagQ4leL+zsiO
         XvCzfa620FG3SzdgDKOryGIMfRlOBplActnywj7Ij8hIyqsOMl8UY406jq/57W4j9c3c
         0QFw==
X-Gm-Message-State: AFqh2krvSxQZ8h60MauipJF2wwOcUZdtN6TQG512iAEV3z1BYj6fM5cH
        ns7/EdzZWjqnA+713CSsFLFrxG9MDe7H+Q==
X-Google-Smtp-Source: AMrXdXszzRuVLQxcVFkiK7uvmFsHyPeWJMfjIimVmX1rMnUrelykdVEtejxakvIcQ/iC6BT35qGoaA==
X-Received: by 2002:a17:902:e845:b0:191:1fc4:5c19 with SMTP id t5-20020a170902e84500b001911fc45c19mr3720952plg.48.1671410930093;
        Sun, 18 Dec 2022 16:48:50 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902650500b0018869119e37sm5687984plk.142.2022.12.18.16.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 16:48:49 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] tests: make 'test_oid' print trailing newline
References: <20221218162905.3508164-1-szeder.dev@gmail.com>
Date:   Mon, 19 Dec 2022 09:48:49 +0900
In-Reply-To: <20221218162905.3508164-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Sun, 18 Dec 2022 17:29:05 +0100")
Message-ID: <xmqqy1r4usjy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> Unlike other test helper functions, 'test_oid' doesn't terminate its
> output with a LF, but, alas, the reason for this, if any, is not
> mentioned in 2c02b110da (t: add test functions to translate
> hash-related values, 2018-09-13)).

I (obviously) agree with the analysis in the proposed log message.
Having to touch the sanity checking tests in 0-basic is a bit
annoying, but having to do an artificial echo is even more annoying,
so these changes may probably be a net win, I would say.

Having said that.

>       $ git grep '\stest_oid ' -- ':/t/*.sh'
>       $ git grep 'echo "\?$(test_oid ' -- ':/t/*.sh'

I found these examples in the log message a bit annoying to see, as
both invite an undefined behaviour by having an ordinary character
('s' or '?')  preceded by an unescaped backslash in a POSIXly
correct implementation of BRE.  GNU libc seems to be OK with it (I
double checked by adding "-G" on the command line to make sure my
experiments are not affected by any grep.patterntype), but they may
fail for folks on stricter platforms.

Thanks.  Will queue.
