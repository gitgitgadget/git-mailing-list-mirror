Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 357B31F597
	for <e@80x24.org>; Thu, 28 Jun 2018 16:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964985AbeF1QMg (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 12:12:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52772 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964960AbeF1QMd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 12:12:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id e69-v6so7442575wme.2
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 09:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2sS6S0CK9h7Kn8A26u+GhHJQzZ90Ji02n/SRKxe37T0=;
        b=CYQBAweAM5e0rMnkS4t0cTrtc/Yqi0yHXmYuDFp2fftoa0Ok9WZ8t1KULJYEPIgZ4T
         efPXrbFf5vJlymFDpm1ah13YI48NVN3K8J7fKeZ7UMBHI9UQUgHNCgKsIIBBeon/GZ7d
         ZnBB0p/KoeugulhpYfH8M/1k4hwP7C6L7x3nQE7djqpGNw6cJ7BYp8WTMWAZmwfdaEmC
         qah4j7+8cvxyhNcfiC9hK8MRCrL8Bdv7MdBNmxMfBB7OP9tGDR023X3JF5d+qPu2B8LZ
         t06ZxXs7rHrhlT9bvG0Pisn3Yh2gBFAXDtPR1A6jaahuTdRp7V7EeIKAWQhO4jw2XN+r
         ceSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2sS6S0CK9h7Kn8A26u+GhHJQzZ90Ji02n/SRKxe37T0=;
        b=Mo+JjBqFMVRYmW3TD1/KcaCXGlpnCZ66SWzvVCjqdF6p2mtAee3bphKq/dJ8sLT6Qn
         ZIxclGXDI0z0q3mr4m7ZbggA9To2oFaMIw8uPiOOymvAsV3xNGOftZ/CBaJU508Vf9qM
         KisfQt+lGFnnsnUWygkwSFrlOdzdfGl7fZjBXXHjcnBnsPXDgv5q58QJ2z5XLCbK/d0s
         mHhOpPMbscH2H6R2XSU/3Obvg1gPvdbKU6yhjNZVdG52tN5RiTLN7REj4uqSHDcL3tWn
         5szwnvWFeCxlnmHoA+7HXlnasxyHrLHSQuu6gYhFY40XmFZyofVoUL92Xw9owzZviHnP
         65HA==
X-Gm-Message-State: APt69E18zYTUVHtbLET5MUuiApB+zltGFOJJ9pzvbTrQEhDj90YNn4Qc
        BQtU5P4VerMt4rQXrYWsykmcKk3+
X-Google-Smtp-Source: AAOMgpf5Cqb0nXYFfApS2F3tUj+dSl4kQCYuHpyvhpBxhJBjAUkaFlQr5HcA2eTpdvmJBleXk1GSiw==
X-Received: by 2002:a1c:2489:: with SMTP id k131-v6mr9183150wmk.114.1530202351325;
        Thu, 28 Jun 2018 09:12:31 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v15-v6sm5009383wmc.16.2018.06.28.09.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 09:12:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Tiago Botelho <tiagonbotelho@gmail.com>,
        git <git@vger.kernel.org>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Subject: Re: [RFC PATCH v5] Implement --first-parent for git rev-list --bisect
References: <20180622123945.68852-1-tiagonbotelho@hotmail.com>
        <xmqq4lhqpy80.fsf@gitster-ct.c.googlers.com>
        <CAP8UFD3oEjW75qsk4d_wqo2V8PmzMvZLshutw20CD7AU4b4ocg@mail.gmail.com>
        <nycvar.QRO.7.76.6.1806261540340.21419@tvgsbejvaqbjf.bet>
        <CAP8UFD1TeC4czp_8HCRw5CtjGO78A8gRezw_xspnm4MXuhQswg@mail.gmail.com>
        <xmqqa7rhi40f.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1806271254210.21419@tvgsbejvaqbjf.bet>
        <xmqqwoukgpr9.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1806281505160.73@tvgsbejvaqbjf.bet>
Date:   Thu, 28 Jun 2018 09:12:30 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1806281505160.73@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 28 Jun 2018 15:08:22 +0200 (DST)")
Message-ID: <xmqqvaa2yjo1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 27 Jun 2018, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > 	git rev-list --bisect-all --first-parent F..E >revs &&
>> > 	# only E, e1..e8 should be listed, nothing else
>> > 	test_line_count = 9 revs &&
>> > 	for rev in E e1 e2 e3 e4 e5 e6 e7 e8
>> > 	do
>> > 		grep "^$(git rev-parse $rev) " revs || return
>> > 	done
>> >
>> > I am faster by... a lot. Like, seconds instead of minutes.
>> 
>> I'm fine either way.  I just thought you would not want 9 separate
>> invocations of grep ;-)
>
> I don't.
>
> I like the unnecessary test_commit calls even less ;-)
>
> And yes, we could avoid those `grep` calls, I know. By something as
> convoluted as

I now think you are reading me wrong ;-)  

I think you already established pretty well that it is a good idea
to avoid introducing different history to run the new test on, when
there is perfectly usable one available.  That part, i.e. test_commit,
I do not think we have anything to disagree about.

What I meant by "many separte grep calls" was to contrast these two
approaches:

 * Have one typical output spelled out as "expect", take an output
   from an actual run into "actual", make them comparable and then
   do a compare (which does not use grep; it uses sort in the
   "making comparable" phase)

 * Not have any typical output, take an output from an actual run,
   and have _code_ that inspects the output encode the rule over the
   output (e.g. "these must exist" is inspected with many grep
   invocations)

Two things the "output must have 9 entries, and these 9 must be
mentioned" we see at the beginning of this message does not verify
are (1) exact dist value given to each of these entries and (2) the
order in which these entries appear in the output.  The latter is
something we document, and the test should cover.  The former does
not have to be cast in stone (i.e. I do not think it does not make a
difference to label the edge commits with dist=1 or dist=0 as long
as everything is consistent), but if there is no strong reason to
keep it possible for us to later change how the numbers are assigned,
I am OK if the test cast it in stone.

Another reason (other than "many separate invocation of grep") to
favor the former approach (i.e. use real-looking expected output,
munge it and the real output into comparable forms and then compare)
is that it is easier to see what aspect of the output we care (and
we do not care) about.

It is harder to see the omission of exact dist value and ordering of
entries in the outpu in the latter approach, and more importantly,
know if the omission was deliberate (e.g. it was merely an example)
or a mere mistake.

With "using a real-looking expected output, make it and the actual
output comparable and then compare" approach, the aspects in the
output we choose not to care about will show in the "make them
comparable" munging.  If we do not care the exact dist values, there
would be something like s/dist=[0-9]*/dist=X/ to mask the exact
value before making the two comparable to see that the expect and
the actual files have the same entries.  If we still do care about
the entries are ordered by the dist values, there would be something
that sorts the entries with the actual dist values before doing that
masking to ensure if the order is correct.




   


