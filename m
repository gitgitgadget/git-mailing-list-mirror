Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B0FF1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 01:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbeJ3KTK (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 06:19:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54816 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeJ3KTK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 06:19:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so10108678wma.4
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 18:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GamLbmosFEcLvWaAKG+rBamWeqaKiOqFSUhY4RXjSm4=;
        b=Tj5jHdYPqIfGkHeFpY0jFCiJhPheDzz/+FoFdrFSIG8mn1rwKC6qkoL5Ugk84kvEUN
         2Jc6x27rHRB1/W70d6E0NtH21NFRdRuy7+C4ORYFAyJS0I/dnG7G0Th2FlaOnD/bFEjl
         K4hA80lrRuq9oBB5yVugyoAky3+FPWZMA6+KoxSItn/F0JayNpFnLmgXspjG1ni6GIyo
         35Bm78UV3MAWerjZ4MX+033PX+se7g6yYyJzTavq2Uje9AHpZMiOKM/XvMLhgBvhUY0h
         O4dT2AXAoUG5p7P9VB9d8yR4NVfAkV5dqA8eqdK0Wb9PdVfd8suPr0h5SywX/DDOU0wX
         3oFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GamLbmosFEcLvWaAKG+rBamWeqaKiOqFSUhY4RXjSm4=;
        b=dYqk25Fbkr5Qxz8lKQoifC1WJq01ftunxwHbDoVEA8OPSq42uL4X8CMGsHL6WQUgBe
         NsB7/eqn6F4gQsGcgHq1p02eex43S1CDcA3S45U6I20D07xd5UdnLvVjgUcb8eJQrcJJ
         DZeOWJP6fBCBLQriCegibpTFWmkiBkVYrHV0/A3c228rq8jlE19xjxKG2RqC09T267Ks
         iBeUF8t+Z8jR2q9QQ6JrzYk+M5ZxNqaCoiZeS+vJOpsYzC0/brdaqExcXVaOQLXRoqnI
         Nx4vQJU7/B2zwMarhE5k6S/3ZjEp0Km+LymXFXY5qgKypxVlKygOHQuWK+A3WClit1hT
         Z9jg==
X-Gm-Message-State: AGRZ1gKGYi5UfHBSRc0TvBDPN+TeGlv1nodryG/kTsZIZcAONgqLBBki
        JVtyhCcnw3WKmuATh8J2AUM=
X-Google-Smtp-Source: AJdET5eRLWl5SEShwC2H2gnlEwa6g3cb7+zKCRI57DVPxXxDJyF0Qba2M4Q/Ad9iyG7UmpXfghTACA==
X-Received: by 2002:a1c:3795:: with SMTP id e143-v6mr109451wma.9.1540862868951;
        Mon, 29 Oct 2018 18:27:48 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v184-v6sm9600514wme.3.2018.10.29.18.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 18:27:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 06/10] grep: remove #ifdef NO_PTHREADS
References: <20181027071003.1347-1-pclouds@gmail.com>
        <20181027071003.1347-7-pclouds@gmail.com>
        <20181027074443.GE26685@sigill.intra.peff.net>
        <xmqqo9bd8pko.fsf@gitster-ct.c.googlers.com>
        <20181029142536.GE17668@sigill.intra.peff.net>
        <CACsJy8Bp_9qmGeNZuywtda1_TdQTZM1essUjBD9Q8e31175V=g@mail.gmail.com>
        <20181029162007.GA31497@sigill.intra.peff.net>
Date:   Tue, 30 Oct 2018 10:27:45 +0900
In-Reply-To: <20181029162007.GA31497@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 29 Oct 2018 12:20:08 -0400")
Message-ID: <xmqqo9bc2pgu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Oct 29, 2018 at 05:01:41PM +0100, Duy Nguyen wrote:
>
>> On Mon, Oct 29, 2018 at 3:25 PM Jeff King <peff@peff.net> wrote:
>> > But if the problem is simply that we are not quite there yet in the grep
>> > code, I am OK with taking this as the first pass, and knowing that there
>> > is more cleanup to be done later (though that sort of thing is IMHO very
>> > useful in a commit message).
>> 
>> Since the problem pops up now, I'm ok with updating/cleaning up all
>> this in this series, unless there's benefits in keeping this series
>> simple and merging it early (probably not?)
>
> Mostly I did not want to tax you. I would rather have this series and
> some cleanup left over, than to not have anything. But if you are
> interested in moving it further, I will not say no. :)

Likewise.
