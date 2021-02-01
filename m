Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85305C4332B
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 15:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B94964EA7
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 15:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhBAPOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 10:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbhBAPB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 10:01:29 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696DBC0613ED
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 07:01:00 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id rv9so24793987ejb.13
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 07:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=FaO8NdwUrU1OG5bWKo+9ilYd5vPvdHP2d2Typze6KaQ=;
        b=Ky5SZRq/ec0/gAUZ1z49Evrqkh2COfq2NZyU3slSiXIugTKLbVTTISd89vT5munNgF
         cIKQ/aq2uwwYde5IRgxtrMOanZdEaQ9SJA+UU/Um14RRT+6J830QJ33QdiZtMxRWIJ9Y
         fQAcO2vA11kUj69NXuQBA7X5gWfGhIwZFO0YCDIzpxdDBEWyXNJ3TTglY07ge2DukJUT
         fnBJaF3S2gnup3sUtaxZKk65gyHEN9a6ckx2Qj/mTa/JlLFwSQ0/EGLo/UuT8ju961rq
         fsCuF13fJiCTbq1XiTWXv38q7K8R0ZTTX3+k3VK1pK1g+YnjCJFOeiJ2KVtYdHqgTm5o
         z8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=FaO8NdwUrU1OG5bWKo+9ilYd5vPvdHP2d2Typze6KaQ=;
        b=s0TkwEEr/hxxKF8WoZ0HLidXKUdU/ZbpSOPnfwaA2ujeIldvjcLO3cghj7sB5GFy1s
         RmAE+xoV3ohiciqdtAUyMFa7zVRMowKev/lZ0xU2Kn8+jYH5zvoYitSb4S1e7V3ZDYlD
         GxXZAETPv/zO4E1L9VN3IS9uEiGEXkDGKZ1SGKjZyvxoha8+n8HCMwg21fszVMqi3n12
         yC3Rfl4DMlkHph6X1QM4Zu+CBOOemONqVvhheLTTMvEHRFd5+zxetsNISs9W+wTf3CoH
         5fuOzhvGlr206yFtMtPynLB62+YnyJFmDsKxeW4aRWiZckEtS4fltHvrDAvds2ElY8ZV
         +dKQ==
X-Gm-Message-State: AOAM530s3Ipo7XMtu54XceVHXfs2Vtbyoel/yXdcP0/EKShJrQbR+7LP
        gFzJGHKrYsA5NNEx5QYkQLc=
X-Google-Smtp-Source: ABdhPJzG67wHIRujm/jijUfljbnu9c4lGUKVnAo5K5Nvyskz/5WR0/4oApjJFXjgO00srQfrujG5+Q==
X-Received: by 2002:a17:906:25c4:: with SMTP id n4mr18323938ejb.359.1612191654672;
        Mon, 01 Feb 2021 07:00:54 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id j23sm8744240edv.45.2021.02.01.07.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 07:00:53 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Vincent Lefevre <vincent@vinc17.net>,
        Git List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: git fails with a broken pipe when one quits the pager
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
 <8735yhq3lc.fsf@evledraar.gmail.com>
 <20210131033652.GK623063@zira.vinc17.org>
 <87o8h4omqa.fsf@evledraar.gmail.com>
 <20210201103429.GT623063@zira.vinc17.org>
 <CAPx1Gvf92eCnSCZJLeqwyL-SprCxmnfi4w=d0-MHddY38DzADg@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <CAPx1Gvf92eCnSCZJLeqwyL-SprCxmnfi4w=d0-MHddY38DzADg@mail.gmail.com>
Date:   Mon, 01 Feb 2021 16:00:53 +0100
Message-ID: <87ft2fomsa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 01 2021, Chris Torek wrote:

>> On 2021-01-31 21:49:49 +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wro=
te:
>> > ... That we're returning an exit code per getting a SIGHUP here
>> > is a feature. Consider:
>> >
>> >     git -c core.pager=3D/bin/false log && echo showed you the output
>
> This example has a minor flaw: it should use `git -c core.pager=3D/bin/tr=
ue`,
> probably.

FWIW it doesn't have a flaw It should be /bin/false, not /bin/true. See
this reply in a side-thread:
https://lore.kernel.org/git/87im7cng42.fsf@evledraar.gmail.com/

I.e. part of the point here (which I realize I forgot to articulate...)
is that we have a hard reliance on SIGHUP to report *any* pager failures
as a matter of the current implementation.

Part of that has to do with internal git implementation details, i.e. we
get the exit code for the pager either in an atexit() handler (we've
already picked the exit code) or when handling a signal.

Perhaps we could do better there and e.g. exit with <num> if the pager
exits with <num>. I don't know what's the conventional behavior in that
case.

But in any case, we exit with SIGPIPE in those cases in any reasonable
failure mode. That is, unless the pager consumed all the output, and
*then* died that is.

I submitted
https://lore.kernel.org/git/20210201144921.8664-1-avarab@gmail.com/ to
try to address the lack of testing around this, which has tests for the
true/false case.
