Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D8BB1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 15:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934302AbeGJPvW (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 11:51:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55103 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933381AbeGJPvV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 11:51:21 -0400
Received: by mail-wm0-f66.google.com with SMTP id i139-v6so25010594wmf.4
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 08:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XJKtsEOBlyp2D7rqF/7R8PCqycSrkf00uUvjJqf3XuE=;
        b=aUU5u/4YenFxmqaDSqRhqOHC/bArL9aWG+1q7XCJRBtWOniqEOB1yEUsF+mxC3Uvvl
         pt/8DlC8G/0oy8ppJmx0iLWm+tlBz+wG4CDpeoZwJ2UFH7rCnsQCt+WpP45NtgK7h9qW
         xb2rnWuVpHU0qMPlqsg5Vt/ywpVGJ53Z8d9at47r7BwT3OjVC/izoEV4L+7lz+Z6FVkX
         xuuXGHQY25c/ohcIaxzo4H9taCypOhGzjTPVsWV5A6bF+8wQI10TBgVlJ1IfHamMfFFR
         VZVIuJq23KokBF3HKJcPqNoomF4LRj6emaWeZ2cQP2+fUCj+PwZ63ColJG0AcU7L6udM
         h6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XJKtsEOBlyp2D7rqF/7R8PCqycSrkf00uUvjJqf3XuE=;
        b=nVwj4y5IOpsRofo5xq1SUBxSZGhFussIcQ3cHEiqdJxjYPXEvB30t7a7iWS8hFV1I4
         relHtC0cT2UVzKhz99kinKGlzm8VUDfPl/m/QztTPVr/egzAtoU4kZIp5tNsHm7rlV60
         yRdeVnJKuALzQkERnnhPmdWfBxt4ogKYPEhu5cdAkFr7Y2v6+BA5CjaTpYe+M0LXWhap
         bdVKgXphjndhCU3mugQxDc0zSa8e0DKSvk3auPI59VB8G6vaO3z55rIpzHG5zNTWoODI
         1IKkcdVQ8/hNO/5+yyF/R5dSegL49TFvMROi0QSeIoNtL7OeeZP9d85xyEqig74lunoP
         NRFw==
X-Gm-Message-State: APt69E0qRDC24n0Ubjs+N04suNHiwRuaibPyrXElH2db2RYjXnzevtnO
        WWFSwiPZVcI+yQEVmy4ltJFBboN5
X-Google-Smtp-Source: AAOMgpeOjEn4cGRckMSuV7f7pjfsdjS1hsZ14Pe4Tk+ezHtaJDZlUipMaxng15ThxJ3tSjE5EweSNA==
X-Received: by 2002:a1c:6709:: with SMTP id b9-v6mr15831062wmc.68.1531237879899;
        Tue, 10 Jul 2018 08:51:19 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y5-v6sm9688954wrs.86.2018.07.10.08.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 08:51:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Henning Schild <henning.schild@siemens.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Toews <mastahyeti@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/8] gpg-interface: introduce an abstraction for multiple gpg formats
References: <cover.1530616446.git.henning.schild@siemens.com>
        <db46732d1cd09a71200e00c2d09605d5beaff364.1530616446.git.henning.schild@siemens.com>
        <CAN0heSrXpLCDRjnZC80QXBG27gd6m5reBn1hfNd_KXxnPVkA2g@mail.gmail.com>
        <xmqqa7r4mg45.fsf@gitster-ct.c.googlers.com>
        <20180710153724.GA23438@sigill.intra.peff.net>
Date:   Tue, 10 Jul 2018 08:51:18 -0700
In-Reply-To: <20180710153724.GA23438@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 10 Jul 2018 11:37:25 -0400")
Message-ID: <xmqqmuuz9jih.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jul 06, 2018 at 10:24:58AM -0700, Junio C Hamano wrote:
>
>> What we've been avoiding was the comma after the last element in the
>> enum (in other words, if PGP_FMT had ',' after it in the above
>> quoted addition, that would have been violation of that rule), as
>> having such a trailing comma used to be ANSI C violation as well.  I
>> do not recall offhand if we loosened that deliberately.
>> 
>> 4b05548f ("enums: omit trailing comma for portability", 2010-05-14),
>> c9b6782a ("enums: omit trailing comma for portability", 2011-03-16)
>
> I think we accidentally did a weather-balloon in e1327023ea (grep:
> refactor the concept of "grep source" into an object, 2012-02-02).
> It's still there and nobody has complained about it yet.
>
> So I think we can consider that requirement loosened at this point.

#leftoverbits: update CodingGuidelines and refer to these three
commits.

Takers?

 
