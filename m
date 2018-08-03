Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 630211F597
	for <e@80x24.org>; Fri,  3 Aug 2018 17:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbeHCT3d (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 15:29:33 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:45797 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbeHCT3c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 15:29:32 -0400
Received: by mail-wr1-f52.google.com with SMTP id f12-v6so6076391wrv.12
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 10:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vBAN9UJWmQ/bX+VVlEZ68Ze5qANDBFyIXIpifJ7q+kU=;
        b=gDjz2DUG7/WoUyu4xvEjCjB+BdOM64FAtqp9zIwBmsQpeWmyGVqqaXoRZ/SizeRTTm
         fjWPXogggB8e3uBCuOLPRXfaR6/BmzmUBsNEZMfTIo3sm9xJtd3upGsRVezlwATIEEfC
         M8A74QKIJxoD1+JQqOdVugmlAW+V5s+gEhwIDO1QEhrqiDULU99iEItD79GHZWHg3ZoV
         d0RyBaMk9rEoAcNiW8KevJaRuvcZovt64YE7ZBwPDSjt4ditx+GCMq7Brhn3cvYd47vl
         +UCm1yfAPo6O/xhUbu+7wCZxPz59AzkPZDJGSpLJcpFMMNmLviOMJqXmRZ6DeIivysts
         QV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vBAN9UJWmQ/bX+VVlEZ68Ze5qANDBFyIXIpifJ7q+kU=;
        b=W0npY6x1Upz2kU9xxS+E0f6hrbvFrJ934SrKy82821O2+F7jxwLPOnFZ3HOx+3Iznr
         lpS0nFkABIcp84zReBDGvEOgNyoGg9xJWnGwuLk9Ris93aS6w0duUv8TeH0tw/+hpd4W
         7no/NbYLiOUEGAq7xeUdAa06f4jU/ZUgZqZ2Gy5r/BJeXOQ8Qp640LKwU7wA+6jZV647
         u2sTwM7eeNFPT6GHjWcPLiCRdfar71ecczRJHwALyYFqYpChMhbiNMoMJPGTDURD4PEy
         xghio1ZCy8imRqoZ996CBEUjUlpBlmY/G/lDkq2OU01fLM8o/4Z0X72X6seBmwCM0SrF
         wgDA==
X-Gm-Message-State: AOUpUlEeEvcroFjfHQjEdftyuxWnmXNhFWm4Byj+m94uI9KJB/7x55SM
        Ay7zkQnzuD0SDXrlXprJ8FA=
X-Google-Smtp-Source: AAOMgpcn8gQZluhud4htfwvrtj7YnXtGRVlzjhK8VXeYzpi3vQ9E++Sb/+cWaqCTJoztY5GhZY3uXA==
X-Received: by 2002:a5d:438d:: with SMTP id i13-v6mr3348094wrq.156.1533317535360;
        Fri, 03 Aug 2018 10:32:15 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u1-v6sm6809166wrm.53.2018.08.03.10.32.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 10:32:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     Karel =?utf-8?B?S2/EjcOt?= <karel.koci@nic.cz>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Vojtech Myslivec <vojtech.myslivec@nic.cz>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] verify-tag/verify-commit should exit unsuccessfully when signature is not trusted
References: <09f9803c-3f4b-a97c-2c59-e9d6b924892f@nic.cz>
        <20180801001942.GC45452@genre.crustytoothpaste.net>
        <20180801002546.du52zkxjupzcw2p6@LykOS.localdomain>
        <20180803133630.32oxubwttealvhxk@work-pc>
        <20180803154343.z3lgkudleood6lhs@LykOS.localdomain>
Date:   Fri, 03 Aug 2018 10:32:14 -0700
In-Reply-To: <20180803154343.z3lgkudleood6lhs@LykOS.localdomain> (Santiago
        Torres's message of "Fri, 3 Aug 2018 11:43:44 -0400")
Message-ID: <xmqqpnyzxso1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Santiago Torres <santiago@nyu.edu> writes:

> Now that I think about it though, verify tag can verify more than one
> tag. I assume that this would make it difficult to propagate individual
> errors in trusting. I honestly don't know what's the best way to modify
> this behavior then.

I am not sure if changing the behaviour is warranted to begin with.
Especially when somebody wants to get more than a single bit.  I
think our single bit signals "does signature compute correctly?"
without taking "how much trust do we place in that particular key?"
into account.  As Brian mentioned in an earlier response, those who
want to take different factors like the level of trust etc. into
account can read from "--raw", using the exit code only for "does
signature compute correctly?" and nothing else.  That would allow
them to perform any validation underlying GNUPG let them to do.



