Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4920208E9
	for <e@80x24.org>; Wed, 18 Jul 2018 18:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeGRS6J (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 14:58:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39609 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbeGRS6J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 14:58:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id h10-v6so5586337wre.6
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 11:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LK9cvkhtrKIST3wLLeeP6/7o2Zsu+n+KqO3lkMkYXFU=;
        b=Ht/tob5AfIhB8N+ITWqORDHV/k0Wdc8GVARF7h1xgKjTxO1PVEp1V20ShY5YSxePiS
         A2g/Gxg0HO+8Nf0DA2qoBY78jTKVbJPIbS1CuSUrZ7TVy6CsjzrdJtQKKuZrtjY8m45K
         9+H7EoH462FVuF0w67tyRz94Q7B6YWc+4+I3C2WVV9WEQUa01jy8XSqQekxJCVBCCU05
         5XusESiwEIuM/QRLxV00/uqIDnHZ93t9vT7hV3zY78ZNqBSTMMNqvhzw8cxgZa3D3tqD
         ikGpZmaxk3QXYfxSuHkx+tMIlqCyzXsAvHk6jX4jKiYKSELNdGwIdtgQeUHGLVrlvGWq
         FqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LK9cvkhtrKIST3wLLeeP6/7o2Zsu+n+KqO3lkMkYXFU=;
        b=RFHNp3R2KJ5cRpc4KsjGM+76gl4RPrXadFeejyRu2AcNphCoZf5imB7/RcYBIS0EEn
         7CSbyahz2iXdXWrUygkl1Utck18QBDtjce3Pvw4FmNf0EZ7eDnFNcGsBeQ2SuUw0XPgR
         +inooqMdJuqyaQrNkd8xPZUUoGFVaOEb1hurYdX4zk5RJRx8Kb3IizKBjAcpJ9JTDgzw
         o84zXFg9La4jzeUeA5R18Wd5exMAhIKMOQGhMjZxGPVLfbE9rxq8Jiwgn7XqH42IkvSG
         KERo6E7npX+MmeFXOCtF9J7y7WhJsLvb+CnDhS1aV3ak64z5cU3bKm5jtVNKGxIpXOUk
         eCPQ==
X-Gm-Message-State: AOUpUlHYQZRHnDqfFX+pTh/Np8fW5SzAZr09eQGHMWT74dLAX4a4ZmXo
        I9w7sBrBwg73pwc4y/lilc0=
X-Google-Smtp-Source: AAOMgpcs4oep20+MBQdL2Ekg6/kudB6Kln4Cxnvy2vTqgZClMEP+K0v1wMUe1pMPCrSBqPYAGr1cmg==
X-Received: by 2002:adf:fe42:: with SMTP id m2-v6mr5023231wrs.171.1531937942491;
        Wed, 18 Jul 2018 11:19:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y13-v6sm6379063wrg.5.2018.07.18.11.19.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 11:19:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Andrii Dehtiarov <adehtiarov@google.com>
Subject: Re: [PATCH 3/3] gc: do not return error for prior errors in daemonized mode
References: <20180716172717.237373-1-jonathantanmy@google.com>
        <20180717065151.GA177907@aiede.svl.corp.google.com>
        <20180717065740.GD177907@aiede.svl.corp.google.com>
        <20180717201348.GD26218@sigill.intra.peff.net>
        <xmqqk1psldkx.fsf@gitster-ct.c.googlers.com>
        <20180718172225.GA2677@sigill.intra.peff.net>
Date:   Wed, 18 Jul 2018 11:19:01 -0700
In-Reply-To: <20180718172225.GA2677@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 18 Jul 2018 13:22:25 -0400")
Message-ID: <xmqqlga8jtka.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Perhaps we should exit with 2 (not 0) in that "previous error" case
>> by default, and then have a configuration knob to turn that 2 into 0
>> for those who cannot easily modify the calling script?  That way, we
>> by default will *not* break those who have been paying attention to
>> zero-ness of the exit status, we allow those who want to treat this
>> "prior error" case as if there were no error with just a knob, and
>> then those who are willing to update their script can tell two cases
>> by the exit status and act differently.
>
> I think we have been exiting non-zero with "previous errors" for some
> time with the daemonizing code. It was just spelled "-1" instead of "2".
> So just jumping right there does not mean any regression from the
> current state, I don't think (but it also does not fix existing scripts
> like "repo" that check the code).

Correct.  That is why I suggested that default setting.  

However.

If we change it so that by default we exit with 0 but allow those
who care to see 2 with a knob, that would be a regression to those
who actually were acting on the non-zero exit, but they no longer
have to scrape the log/warning output if they choose to set the
knob, so the "convenience" factor might argue in favor of the "by
default we return 0 but you can choose to get the 'sensible exit
codes'" approach.  I do not have a strong opinion either way wrt
which one should be the default.

> I agree the config you suggest would give people the tools to make that
> case work. But it somehow rubs me the wrong way. Can you imagine the
> perspective of a user who is told "oh, your script breaks? Just try
> setting this option to ignore error codes in this one particular
> situation". It feels like a weird hack, because it is.

Well, the message is "your script is broken (and has always been
when 'gc --auto' saw that the previous round failed), but now we
have two ways to help you correct.  An easier but broken way is to
turn this knob to turn 2 to 0 to hide the issue under the rug; or
you can notice the difference between $?==1 and $?==2 and act
differently".  "turn 2 to 0" is a weird hack, but they are also
given the option of doing the right thing, so...

> It's also still inconsistent in the daemonize case. The run that yields
> the error won't return a non-zero exit. But the next run will exit with
> "2".

I do not see this particular "inconsistency" a problem.  The run
that first discovers the problem by definition cannot return with
non-zero; not waiting until finding out the outcome is the whole
point of running in the background and giving control back early.

