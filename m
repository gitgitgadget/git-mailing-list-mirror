Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 782AF1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 21:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbeCEVTP (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 16:19:15 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38670 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752953AbeCEVTO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 16:19:14 -0500
Received: by mail-wm0-f65.google.com with SMTP id z9so18271874wmb.3
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 13:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Va+B03UZK5GnBDh/e2ovL03Qo19D80UXuwLkkZqpwq0=;
        b=nS/t6eepIJw6wKFZnzXWpifEvhcsGl/eG111zcXJaYl9yGZXsYRX7liZbekfTCG8rT
         milTnpGwit/9MB9gk1IBuzvgPdIA0l+IGGkwkFmgc9Npu+LuEGTOljh39ZMndBWXKcMJ
         WrjqLqaCtOiOWTmzVZAey4KmHmGTcrstvFbC76kGNuQKuB9rZPlDGhVpXK5s16xSLgUE
         eXprWkUscyza29659ANR60bWOXnF6u2Od/457ltT/YBMEarXqgdohGLgW68S2BmMNn3r
         OJfkeldqSZiKuKwJ4iCZeja88Igq6sLSMym0a5F1eNzdYflci5qULHe/acs0FvSRdDie
         9gEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Va+B03UZK5GnBDh/e2ovL03Qo19D80UXuwLkkZqpwq0=;
        b=bN/hgC1/V+Ch7+amIuXNeHEhr4IJH0E64uJR/fbYwHUjYJQIUNNaEZVmJk/rkvV6qp
         HYfBhrOqs3mD/JbVvwFQ5lzcg6UI/yHl7osJgis5tg0RJQ2XflFSZQjpSZtBjUKU91mM
         6Lu/DvC0l2kkNAwHlGFGNrta+tAeckbGppYhttKjnK+RV8NXMW/yQQwmVoS0e8p/UwO8
         H1+Rh5HtHCezS2DwscIdgiqmepRtU9o48zg2d4YHrWc9fDIvTX/MibRSGFLA5jUopUYk
         yJx9sNwbeSGqxTi7qygYMGd5yerJrX/0CYcnCLtFDgs4srOjdow2c/hNCMph929gyoNR
         hrjA==
X-Gm-Message-State: AElRT7H3dVBfwB23qjxliCowCP4B8NSk12LEizY9JUASqxAF+rRWPacr
        G7d2fblDmcOgd/oZp2WT3/E=
X-Google-Smtp-Source: AG47ELvUkFA6IED4+9XzoN4m4DDC/UXLpiQiVzOlyboEiZSrVp69avl15GlsX8t4SVwKkR2wym7k9w==
X-Received: by 10.28.136.18 with SMTP id k18mr10079220wmd.111.1520284753306;
        Mon, 05 Mar 2018 13:19:13 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u22sm13523102wrf.86.2018.03.05.13.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 13:19:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Damien =?utf-8?Q?Mari=C3=A9?= <damien@dam.io>
Subject: Re: [PATCH v3] run-command: add hint when a hook is ignored
References: <xmqqh8vcx1nh.fsf@gitster.mtv.corp.google.com>
        <0102015ef0ba0273-ed29c030-7cdc-4535-a411-6cc443bd5f43-000000@eu-west-1.amazonses.com>
        <xmqqy3ojpr9f.fsf@gitster.mtv.corp.google.com>
        <xmqqmv4ymc7w.fsf@gitster.mtv.corp.google.com>
        <20180103083145.GA7049@sigill.intra.peff.net>
        <xmqqk1wwcd2w.fsf@gitster.mtv.corp.google.com>
        <20180303071613.GC17312@sigill.intra.peff.net>
Date:   Mon, 05 Mar 2018 13:19:12 -0800
In-Reply-To: <20180303071613.GC17312@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 3 Mar 2018 02:16:13 -0500")
Message-ID: <xmqqo9k28blb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> True.  The user could tell the server operator to rename them or
>> remove them because they are not doing anything useful, but then
>> as long as everybody knows they are not doing anything, it is OK
>> to leave that sleeping dog lie, as they are not doing anything
>> harmful anyway.
>> 
>> That brings us one step further back to question if the hints are
>> useful in the first place, though ;-).
>
> Yes, that last paragraph definitely crossed my mind. Do we have an
> opinion on doing anything here? (E.g., declaring the hints not worth the
> trouble and reverting them versus just living with it)?

I am tempted to declare that the "hints" was not a good idea and
suggest reverting them.
