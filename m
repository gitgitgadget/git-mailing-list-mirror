Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF198202AB
	for <e@80x24.org>; Thu, 29 Jun 2017 23:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbdF2Xvl (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 19:51:41 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:35332 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbdF2Xvj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 19:51:39 -0400
Received: by mail-it0-f45.google.com with SMTP id v202so53485774itb.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 16:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=btGOzDq4NX4gYN4PTq1Zu5qJZNYsZBezYUBHIa9UV8U=;
        b=HBHR+TwLjfmeD/Q5iXgF8OCaGmSszuzJ3/4HmXMXItMvFupwPzB765/e0iwrwSwdiN
         ZhH6JGTFR0d5Oswlvp+WuW/jd6sbaMV4Jqmq+cacCfKYpczo5/0+qtaqCT34Dwv+/b3r
         cZ71MRzJlUWVW4rOhVrOsdM1pQWx2c6IP9juwTwSK0KJ3WaU1AV8mpw7+LuGfhC2R2Wu
         AEGuHDGKJEOY85YAcCzItDvBx6bGXeaUkf9rV4knXgxBtJqaLzPL6x4oCQOgcRjD83lA
         vPZ/S2A/IpUHxhks/YmTos2JiY/aA0N7sYUPybaVXZsLLLbgd8pEiuQWxTbUN5KXxeTb
         sZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=btGOzDq4NX4gYN4PTq1Zu5qJZNYsZBezYUBHIa9UV8U=;
        b=f/ooYnJvnXFWg+WBsSNwfFyPRNT6yVfovQzJ+zsMLNvEz7JDLAsCecZyhW+E4F7+3H
         vscRCAhGzyBumBsd2DEWQ08GMxpIglusXSv7hsrohEU97/4GhTnSZ62QjvP5BXMTlzXI
         lglxp8UtxgY0RCRyTOlHQTzYKWPf225c4ZOvYQ9YJRnbaRVxIe/Ho7LsBpyrnXeW2bTA
         2dXD3PKzH+bHV9jmg0tdjCT5GAqI0xDuVjve24RO9OJiWokOY8EHWpMCRuaoff2NTw4I
         Pti2/03cjK3aH+5rnzxoTkOClBNEw+nXfQvyOCuAZzuM5miwZCaLa2LT5fF6wNRFgf98
         YNDA==
X-Gm-Message-State: AKS2vOwEfbeaYlJ/8ixGde4sgw0umcRGirJLd0jJjE39qAqoBSS+HHqs
        iWHW3Uq5QQATwkUbQfMzGQOUXoks/23x
X-Received: by 10.36.92.143 with SMTP id q137mr17235937itb.23.1498780298957;
 Thu, 29 Jun 2017 16:51:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.20.136 with HTTP; Thu, 29 Jun 2017 16:51:18 -0700 (PDT)
In-Reply-To: <CAGZ79kaq2ym9aSAcHXRSd=onkqjoO-2_0B8PHed2j4q_9gwvCA@mail.gmail.com>
References: <20170628005651.8110-1-sbeller@google.com> <20170628005651.8110-7-sbeller@google.com>
 <xmqqshikye0o.fsf@gitster.mtv.corp.google.com> <xmqq37akya3j.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaq2ym9aSAcHXRSd=onkqjoO-2_0B8PHed2j4q_9gwvCA@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Thu, 29 Jun 2017 16:51:18 -0700
X-Google-Sender-Auth: CQnBSD_q9udOjTHP5Qm-qTyRq_A
Message-ID: <CAPc5daXBprMyWeQmcUem_Yw9bsyTD8-C818+t94cy5K3onw8Og@mail.gmail.com>
Subject: Re: [PATCH 6/6] diff.c: detect blocks despite whitespace changes
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 29, 2017 at 2:01 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Jun 27, 2017 at 10:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> This probably deserves a bit more illustration of how I envision the
>> code should evolve.
>> ...
> It turns out that the code here is rather a very loose proposal,
> not to be copied literally,

Yeah, whenever I say "illustration", do not take it as anything more than
scribbling on the back of an envelope, whose primary purpose is to show
some idea (in this case, the central idea is that a helper function that lets
you ask "what's the next byte that matters? tell me also when you run out"
is all you need to do an in-place comparison with various "ignore" modes;
by the way, that applies also to ignore-case comparison if there is a need
to support it).

The implementation detail to support that central idea is left
to the readers. ;-)

Thanks.
