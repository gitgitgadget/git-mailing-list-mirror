Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D24A01F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbeGRUer (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:34:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41004 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbeGRUer (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:34:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id j5-v6so5807639wrr.8
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 12:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oJ3Ig2ny8NRMkM8JAuMsFM+9JkEHhDpiSHW7fHZ72bU=;
        b=rljsyzV9GrxUg2VEd1YxuxcJ3CQVDsNLqOp8VtK0J8pbiwvYgdkniKNnLlrr4vnngA
         JAPRep5E9yYs9fRO5z3KZvvYoaTA9sy2aJpa3Ow3mXyIoQzfPUNOJmM/MYrv/QFKIMmp
         Fe5mnGfsLaOYTmwOMF7HIVZQyi9wbWL7a5+QqxKwtSIaGG2jPPwIdwZ3q0Pc3Og6raBs
         8brGhfqJdcKpfS4/UGSo1ky1Y6+H+915YyGBEAKa+qaxcZpfUFHwKLuwDs8ro8MVP+LV
         q+VSFV4CBVUVvqj0SDZw1QyWYfjOGosz9CqyjYSDbLLKbd6vJNK+ykXWzwBZ1ijqvgGJ
         9t5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oJ3Ig2ny8NRMkM8JAuMsFM+9JkEHhDpiSHW7fHZ72bU=;
        b=PX+RmDXjH5hOl2U4wzpcQWmn0M01Lv30Xb51q0Prb0xtr4ohvK/FHJsE5wMZx0NNMu
         yznTH8bJL4OePKX8DO1yYeuAzgxD5LK/4QLRIaVDbPuU39GDdLOdOKgYOz+F5QUha5FO
         wQ5A10XJBQLRKhl+vRMlY5FFsDZ1NE/3mLb83xs2c5SaY1pkfFhCuJMGjhzePvTIRtKm
         O63RbqeDJzdQSuEEQZzYhidjQrLjc0f6BwlwyK+n81aX4QhUHZlVmFkLvQj4qvLZ7SN0
         lBFhYUaYHyQ2IBRu9m+Pp6ijik46+y6FHj9nKvOnGJOeYTmAyRYoEjtinVIwiGaU+cJG
         mPrw==
X-Gm-Message-State: AOUpUlF6hkIs5/ML0dbDUHyBpdUz4HXBIKVTo6lzHGUJN8QD7VJFj/3h
        r0qDyk+6M2VCG4FV4YQ0dls=
X-Google-Smtp-Source: AAOMgpdqPwE3tujQuSc3bKoZs0qIV4S6jSJUUkNa8RGCGsddepsOMEjoSsvmE3oHw/2TjiMu47HbxA==
X-Received: by 2002:adf:91e5:: with SMTP id 92-v6mr5441012wri.124.1531943720553;
        Wed, 18 Jul 2018 12:55:20 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m4-v6sm12157341wrv.71.2018.07.18.12.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 12:55:19 -0700 (PDT)
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
        <xmqqlga8jtka.fsf@gitster-ct.c.googlers.com>
        <20180718190645.GA7778@sigill.intra.peff.net>
Date:   Wed, 18 Jul 2018 12:55:19 -0700
In-Reply-To: <20180718190645.GA7778@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 18 Jul 2018 15:06:46 -0400")
Message-ID: <xmqq8t68jp3s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jul 18, 2018 at 11:19:01AM -0700, Junio C Hamano wrote:
>
>> > It's also still inconsistent in the daemonize case. The run that yields
>> > the error won't return a non-zero exit. But the next run will exit with
>> > "2".
>> 
>> I do not see this particular "inconsistency" a problem.  The run
>> that first discovers the problem by definition cannot return with
>> non-zero; not waiting until finding out the outcome is the whole
>> point of running in the background and giving control back early.
>
> I guess I just see it as encouraging a non-robust flow. I can see
> somebody thinking they should care about "gc --auto" errors, because
> they can turn up latent repository corruption (because most operations
> try to only look at the objects they need to, and gc inherently
> considers every object). But doing so would give a very delayed
> notification for a repository that is handled infrequently. So finding
> out about a corruption that we detected might takes weeks or months.
>
> I dunno. If your primary motivation is not finding latent problems, but
> loudly complaining when gc does not make forward progress, I suppose it
> makes more sense.

I am not sure either.  If your primary motivation is to protect
yourself from ignoring gc failures that could be an indication of
possible repository corruption, you wouldn't be running it
backgrounded in the first place, I woudl guess.  And if you are
backgrounding, with "exit with 2, not hide it with 0" approach, you
would have a better chance to notice, no?

