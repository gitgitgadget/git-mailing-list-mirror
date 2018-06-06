Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E3711F403
	for <e@80x24.org>; Wed,  6 Jun 2018 00:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932895AbeFFAcS (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 20:32:18 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34410 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932897AbeFFAcR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 20:32:17 -0400
Received: by mail-pl0-f65.google.com with SMTP id g20-v6so2635230plq.1
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 17:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=okPEUAL1Z6+yyeKYOvu+azpwXJZ8owmjaxIQ8CLDH24=;
        b=PITrhJN1hxAZGzSoVu9cCMskVr0dfNNB1ixTWDuqInGf//6ime8p37RpPF40mdL2uw
         DiigwelrtkQXEd5ulUVrmrK7TJ4RxO0YbVJgGwi+lUpoj1WKk2NhFpumYLpvKcy+AJ67
         lRIFqR0Yfe0W3oZfO6pfLdKjftm9pVBY1QofJQmTFdV/Z0Vjk7xOzKSQzXHzOln4GQ3E
         BSDjRlompnTw2U0kIc6gi+Kc7nKRGUL2fljgwtjPPGijxZWpuiUu2XMp0PeaoyGxPkvw
         9SEJDlt4EPZfefKv7DpG7EK2+MehUbeL9m7iooEeWDO/LH+1tj7eH2v3S5T+P/wv9Um3
         eB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=okPEUAL1Z6+yyeKYOvu+azpwXJZ8owmjaxIQ8CLDH24=;
        b=QfFuUA5Tu2Wa9kG36wEUSU7eQ9c9lErWshNeAAJpcpFALW4TM0ED/IW7QAKxRTpt8P
         yNErnl3dn8GEwL4BBNzWqjqIqQqeDUo5O+6dT9rCCgItn+hZ2UAj7DpSQxXdKKmG7k1o
         8jAcJ43ecFOta0JYKPZw7pyhvujCBiDLgwe4PqMql8OrfM2r2gPnQi8SjiIRUVusJ2m2
         EhYcJyaNEDH3WD9iXTI1reaHMncI1lQUUjogSNNndYrGX9Xppsv93qhD4XWKiNV9mdsI
         qpzR9y8itSt7Uy++tP6nOnyOqgH464tTB0wS1EQJAgB3RfljOGveRaGRzVMFc8jWKo4z
         cXQw==
X-Gm-Message-State: APt69E1Lumfi9n48DMqX8k76etrqy5r5xT4HmBAbqGbRLR6tQGxc2CCh
        MuhvBVK0KKzYHIRpT4t/Z7aOdZGOn0Q=
X-Google-Smtp-Source: ADUXVKJ4tYRwuweLjsbOBtldF/QfmRO1/nlut0zTMBXmEEHQ5Dv3YhS+IsgbrQxorkg4iKcqew07bg==
X-Received: by 2002:a17:902:b416:: with SMTP id x22-v6mr826484plr.267.1528245136843;
        Tue, 05 Jun 2018 17:32:16 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id j14-v6sm77086337pfn.151.2018.06.05.17.32.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 17:32:15 -0700 (PDT)
Date:   Tue, 5 Jun 2018 17:32:14 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, bmwill@google.com
Subject: Re: [PATCH 1/6] fetch-pack: clear marks before everything_local()
Message-Id: <20180605173214.c3920e67cbbbd463be33bc70@google.com>
In-Reply-To: <20180605230821.GC9266@aiede.svl.corp.google.com>
References: <cover.1527894919.git.jonathantanmy@google.com>
        <b9d6d8fef370fae316f78c851833dbd706ff6f7c.1527894919.git.jonathantanmy@google.com>
        <20180605230821.GC9266@aiede.svl.corp.google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 5 Jun 2018 16:08:21 -0700
Jonathan Nieder <jrnieder@gmail.com> wrote:

> Hi,
> 
> Jonathan Tan wrote:
> 
> > If tag following is required when using a transport that does not
> > support tag following, fetch_pack() will be invoked twice in the same
> > process, necessitating a clearing of the object flags used by
> > fetch_pack() sometime during the second invocation. This is currently
> > done in find_common(), which means that the work done by
> > everything_local() in marking complete remote refs as COMMON_REF is
> > wasted.
> >
> > To avoid this wastage, move this clearing from find_common() to its
> > parent function do_fetch_pack(), right before it calls
> > everything_local().
> 
> I had to read this a few times and didn't end up understanding it.
> 
> Is the idea that this will speed something up?  Can you provide e.g.
> "perf stat" output (or even a new perf test in t/perf) demonstrating
> the improvement?  Or is it a cleanup?

Firstly, I don't know of a practical way to demonstrate this, because we
don't have an implementation of a transport that does not support tag
following. If we could demonstrate this, I think we can demonstrating it
by constructing a negotiation scenario in which COMMON_REF would have
been helpful, e.g. the following (untested) scenario:

 T C (T=tag, C=commit)
 |/
 O

We run "git fetch C" and on the second round (when we fetch T), if we
wiped the flags *after* everything_local() (as is currently done),
negotiation would send "have C" and "have O". But if we wiped the flags
*before* everything_local(), then C would have the COMMON_REF flag and
we will see that we only send "have C". So we have more efficient
negotiation.

> As an experiment, I tried applying the '-' part of the change without
> the '+' part to get confidence that tests cover this well.  To my
> chagrin, all tests still passed. :/

Yes, because we don't have tests against a transport which doesn't
support tag following.

> In the preimage, we call clear_marks in find_common.  This is right
> before we start setting up the revision walk, e.g. by inserting
> revisions for each ref.  In the postimage, we call clear_marks in
> do_fetch_pack.  This is right before we call everything_local.
> 
> I end up feeling that I don't understand the code well, neither before
> nor after the patch.  Ideas for making it clearer?

One idea is to first separate everything_local() into its side effect
parts and the "true" check that everything is local. I'll do that and
send it as part of v2 of this patch series.
