Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C911A1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 03:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeJRLWS (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 07:22:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45709 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbeJRLWR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 07:22:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id f17-v6so143797wrs.12
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 20:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=grdZOIzaa+qWSnTqhS5ejYArNTGptLhzqZubkGWumEY=;
        b=gSnmmlFHoxAcOBJ3yDcvE2d+cxHMH8U7vyvhPRiJG3remGqRbGgl+KpXq/j45N0RRJ
         lN+lEVMzJ3j6cyGwG62y1+5LiXeS13Dwp2y3GV3YQMgo+mPLcae2zv0zveyjFhkLqQ1B
         5mgiYsPeqL45STF4kH7ZZOR4Oynr2RFKwNoq1c2bVrNyLXB8AoSlf/Y6YZOkf/pPZBKH
         sK1FIeOGa0uLUgfeN1jhJ6csUzRDIqz8OqFA0TB1m8d+RuBWwLbtM7e1pa538celtAWV
         CHBn1D7XkrsSipLt3ZhTHDXOOVOvbz4sqQ2sQYooIYhZnrz6lPQQIGrowxTCOUk3KHk4
         6s9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=grdZOIzaa+qWSnTqhS5ejYArNTGptLhzqZubkGWumEY=;
        b=NvmzQ+gQblbPkeki5fJ6S1UYgf408l0z+RMDsDiUgisnpgcUIxfWCy/24Lm/zIbPcu
         J/PKI7kqkOMhZBRr09sqa8v9+BOa1bSX3zXA8+SASLkImjKXa9/CSk8Ta9jJXOcI4jJz
         nSNv+GW1rhPwbymaNUHiK+Y1wAwpsaZ+BVCwwK8eA34W/DY340l+SG1Bsth9AD51HHZG
         s8JoQPFx0iqHQJgqraVd8uwY4oQMQA60vut6i4Wstr0TG4R8JYoTu1u4DNfj5kqqM3ut
         sJUx9is8kSJWxDpQ53zSwP4CxeQhwnoQbAwI7QmiagfDqCN+uvKrrEAL99SNLq7Fbwwi
         ctrA==
X-Gm-Message-State: ABuFfogfB6XC0hpi2hQqHdL8btgQlK9Ay2rT+l5JOfq9AR/ho9UXMkHF
        /J8LueL1PBOY4kzv0Y79oTA=
X-Google-Smtp-Source: ACcGV63eQMqUjQ8cizZkJxKUROEbBI7Wmp2t9mpzubxlrFVJqfhVrCSxKyj7cKc/jf0SzSVIUunIDQ==
X-Received: by 2002:adf:ff90:: with SMTP id j16-v6mr25724177wrr.296.1539833008362;
        Wed, 17 Oct 2018 20:23:28 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x17-v6sm16903500wrs.84.2018.10.17.20.23.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 20:23:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>, git@vger.kernel.org,
        Bob Peterson <rpeterso@redhat.com>
Subject: Re: [RFC] revision: Add --sticky-default option
References: <20181016212438.30176-1-agruenba@redhat.com>
        <20181017091215.GA2052@sigill.intra.peff.net>
        <CAHc6FU5mXL2j=jL=LqtRt30uBt8tGop350FnwK845fci-Qc=tg@mail.gmail.com>
        <20181017181350.GB28326@sigill.intra.peff.net>
Date:   Thu, 18 Oct 2018 12:23:26 +0900
In-Reply-To: <20181017181350.GB28326@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 17 Oct 2018 14:13:51 -0400")
Message-ID: <xmqqva60uedt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'd probably call it something verbose and boring like
> --use-default-with-uninteresting or --default-on-negative.
> I dunno.

These two names are improvement, but there needs a hint that the
change we are interested in is to use default even when revs are
given as long as ALL of them are negative ones.  Which in turn means
there is NO positive ones given.  

So perhaps "--use-default-without-any-positive".

Having said that, I have to wonder how serious a breakage we are
going to cause to established users and scripts if we made this
change without any explicit option.  After all, it would be rather
obvious that people will get a history with some commits (or none at
all) when they were expecting no output that the "default behaviour"
has changed.  I also wonder how would scripts take advantage of the
current "defeat --default as soon as we see any rev, even a negative
one"---in short, I am not sure if the theoretical regression this
new "option" is trying to avoid is worth avoiding in the first
place.

Is there a way to say "usually this command has built-in --default=HEAD
behaviour, but I am declining that" already, i.e. 

    $ git log --no-default $REVS

that will result in an empty set if we accept the change proposed
here but make it unconditional?  If so "This and future versions of
Git will honor the --default even when there are other revisions
given on the command line, as long as they are ALL negative ones.
This is a backward incompatibile change, but you can update your
scripts with '--no-default' if you do not like the new behaviour" in
the release notes may be a viable alternative way forward.

If there is no such way in the released versions of Git, then that
would not work, and a strict opt-in like the approach taken by the
proposed patch would become necessary.
