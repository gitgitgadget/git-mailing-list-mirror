Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A57D20248
	for <e@80x24.org>; Mon, 11 Mar 2019 02:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfCKCSE (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 22:18:04 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:46542 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfCKCSE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 22:18:04 -0400
Received: by mail-wr1-f42.google.com with SMTP id i16so3278719wrs.13
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 19:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JxGitkbAa3hSCL/ceHAoksAWNShNRUKTAbrCaNpBhpU=;
        b=oHQMm5RxoCH5k+CGZNtHJurbyR7DmoAvuOQdeggUU6voeI9ZlGTbJ4DNcuEo10sYnJ
         zm6B6kIzBaPBQVnKHuwcVfqXKSjwWPJFSq3hKKLMLBN338XZsfJDxAtVVPGA/tQ8fbvc
         gnPtsMRtXs90Fd6fM9ay/1QnitgKoK9m5LYpxtnsm0IwJBxc1TCQ8zEgMUqmHjlvmIRY
         Os0AtPgyX2UctXc8VT73voKgmI9q+5oHXooFA7+jf1rORWS+pcxGbHChXsKnu/TEeT1X
         83Wi0n80hOJWCiN47WEZcz3d49R6pesU2FLxHDBNn+QIQ3mq/U+u9rX/2JaNQoXVquFZ
         5guQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JxGitkbAa3hSCL/ceHAoksAWNShNRUKTAbrCaNpBhpU=;
        b=TWfQheVkvVX58tGgtbiE7mPk3Ged/mIK0pnZury3IrnUMwRB5R79/UB5WatuR9LXwq
         Z0iArTVTHQdsZVxmu1tX4YFobVFDJYAsl1E8opqQ5PdJJ+nPwquYWLrCboLtz4W+UozL
         /Szlt3tBxGRqogw27RP0iGDTu+xpfbGb56RSxiRGHSwhGoj76kQNVGMwlnb3sXR7x6km
         NXnYdM7jzK6kwCIjWVhC3oU10gI4hVw2nSj2h+xvrtmHjsFtT8O13SAW/2iP62x3ufUx
         JDn8dM4peIFuQwKDXynXEB8zb5E3fbgeUBWuwOXhG4NweEvSOEgB5ndrK1uv0BYHVCLw
         Yszw==
X-Gm-Message-State: APjAAAXCh3nVPITJihHrpdpwN+O/QhsqoXhb68vR0JvXxdqaZA+f8YnU
        3X2vpuQFFwBrcLMhg7dfzek=
X-Google-Smtp-Source: APXvYqwzaROu4/HgXK9qwHt5MlijYhinqLoFnON3ELyX4IINhtVZwWPVuXVRSKVKUC80OjACxHOKVw==
X-Received: by 2002:a5d:5042:: with SMTP id h2mr18446623wrt.12.1552270682406;
        Sun, 10 Mar 2019 19:18:02 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id b195sm33069885wmg.36.2019.03.10.19.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 19:18:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Jeff King <peff@peff.net>, Git Mailing list <git@vger.kernel.org>
Subject: Re: is it "git gc --prune=now" or "git gc --prune=all"?
References: <alpine.LFD.2.21.1903020323110.16672@localhost.localdomain>
        <20190305050326.GK19800@sigill.intra.peff.net>
        <xmqqef7ksw2w.fsf@gitster-ct.c.googlers.com>
        <alpine.LFD.2.21.1903091309130.16641@localhost.localdomain>
Date:   Mon, 11 Mar 2019 11:18:01 +0900
In-Reply-To: <alpine.LFD.2.21.1903091309130.16641@localhost.localdomain>
        (Robert P. J. Day's message of "Sat, 9 Mar 2019 13:13:41 -0500 (EST)")
Message-ID: <xmqqsgvukvc6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

> On Wed, 6 Mar 2019, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > ... I do think the documentation should recommend "now". Possibly
>> > builtin/gc.c should be smarter about recognizing "all" in the
>> > conditional you quoted, too, though I don't know that it's all
>> > that important (especially if we tweak the documentation).
>>
>> Yup, as the placeholder for the value is labeled as "<date>", "now"
>> would be the one we should be encouraging.
>
>   i can submit an obviously trivial patch for that

You already did to turn --prune=all into --prune=now in the doc, I
think.

Do we encourage 'false' where we should encourage 'never'?  I see we
do not even mention the negative form in git-gc manpage, and I think
it is a good thing, especially because --prune=<date> is listed just
next to --no-prune, which is even more explicit.


