Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9C0B200B9
	for <e@80x24.org>; Mon,  7 May 2018 15:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeEGPSr (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 11:18:47 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:39537 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbeEGPSq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 11:18:46 -0400
Received: by mail-wr0-f178.google.com with SMTP id q3-v6so29160139wrj.6
        for <git@vger.kernel.org>; Mon, 07 May 2018 08:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8BOEAFS/XElN0IbXVcObDPHhCSBTpMrQ1mN4FkGQi/g=;
        b=GC4fSj58vDYZUDkS//rwMa9Wv/WYz7NcmlNf9LDxKLa8aEdfNgDShtI3JLUkDINN5c
         WGb8eFyizq+KcWry+rZWkbfU2WJrXGA4GojZL4ESHdaUZQgYynGGXNpBFxXmIwX6yVLG
         H/58hb/OSdqOL7Z0kqzS+oPvWEd2Fq8wpQV/2sPr+9SXpsRJXC+D18AZTjHZaPcvHMlQ
         /G7nebj1f793NaSiz9BtoP08o36zPyw+ebYBm/g0jFo8x7XUPdplvxwfO+w7LvnSl7i6
         DVWK6S0HoNjKol/yB4kBUR484O7IAs948uigWQaWnzlZzW2+YPZQxDWaEJjSlwf3i9Xp
         Z/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8BOEAFS/XElN0IbXVcObDPHhCSBTpMrQ1mN4FkGQi/g=;
        b=eolD1ogSnLqiLCxuXvzD2uu196s7OVNSyWYDaKSo1J4BZXt3I7N0ALffDEnDd0PBK6
         ii/AOuXCl9VqHQFUCq2QT98oQb5gN8VhG0CyQMm+uFCZGWYQEEzbkl8si7n++Iwo8fOx
         MF85XG7Y7uik4tmPxixsyXpcgiWgl4X0fqpN6hXtMBNUQVfoXdHML6fRMANoK5L15Irg
         Iqi8dWK6A6OKWv1Kl5OryP4EFKKTKbQuxhq5ZBqjbO98RtpgOQqm/8O855hBQNr+/41/
         ggPRmFKjIxukj58VUzLoX9ovPeqoYJWCTZOoUEwXCs91n+Bg8X7Q0jFaN8cQXdPViYa4
         EZAg==
X-Gm-Message-State: ALQs6tArVMzQSTb6A79ADAhtmeWn8LrInBwGw2JqLhQ2yZavXJdUYyOL
        t5gTma0iVvz8IvAmM77rwNVDBYF0AkM=
X-Google-Smtp-Source: AB8JxZrs5e5MbxhFGsnLFJlU9TR4wPLawuy1ko02h08ybfoh0w0IJ9MqmtnOP2HSI0yNmznfdF03ww==
X-Received: by 2002:adf:af28:: with SMTP id z37-v6mr29534271wrc.72.1525706325086;
        Mon, 07 May 2018 08:18:45 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b66sm11236171wma.48.2018.05.07.08.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 08:18:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Ben Toews <btoews@github.com>
Subject: Re: [PATCH 8/8] gpg-interface: handle alternative signature types
References: <20180409204129.43537-1-mastahyeti@gmail.com>
        <20180409204129.43537-9-mastahyeti@gmail.com>
        <CAPig+cT3AobThgZ15iquyRQG0Qes1ZzQxycXcgHYuwQCuDEDBQ@mail.gmail.com>
        <20180414195954.GB14631@genre.crustytoothpaste.net>
        <xmqqbmejyc4j.fsf@gitster-ct.c.googlers.com>
        <20180417001212.GC14631@genre.crustytoothpaste.net>
        <20180507094459.GA3412@sigill.intra.peff.net>
Date:   Tue, 08 May 2018 00:18:43 +0900
In-Reply-To: <20180507094459.GA3412@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 7 May 2018 05:45:00 -0400")
Message-ID: <xmqq1senpk8c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Apr 17, 2018 at 12:12:12AM +0000, brian m. carlson wrote:
>
>> > That argues more strongly that we would regret unless we make the
>> > end-user configuration to at least the whole string (which later can
>> > be promoted to "a pattern that matches the whole string"), not just
>> > the part after mandatory "-----BEGIN ", methinks.
>> 
>> Yeah, I think this patch set is "add gpgsm support", which I can see as
>> a valuable goal in and of itself, but I'm not sure the attempt to make
>> it generic is in the right place.  If we want to be truly generic, the
>> way to do that is to invoke a helper based on signature type (e.g.
>> git-sign-gpg, git-sign-gpgsm, git-sign-signify) to do the signing and
>> verification.  We need not ship these helpers ourselves; interested
>> third-parties can provide them, and we can add configuration to match
>> against regexes for non-built-in types (which is required for many other
>> formats).
>
> Isn't that basically what this patch is, though? Or at least a step in
> that direction?

I think that is what Brian is saying, too (and if so I would also
agree).  It probably is a good step.  It is just the feature may be
sold under a wrong (or, overly wide) label, perhaps?
