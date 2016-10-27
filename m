Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 918DE2022A
	for <e@80x24.org>; Thu, 27 Oct 2016 00:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933349AbcJ0AWI (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 20:22:08 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33662 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932430AbcJ0AWH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 20:22:07 -0400
Received: by mail-qk0-f182.google.com with SMTP id n189so24924340qke.0
        for <git@vger.kernel.org>; Wed, 26 Oct 2016 17:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vUcqVPnVEujnU1+OSr6uZZ8UMx838pybQ9I1bECQuaU=;
        b=AD1QbTYUJDuZst49CVu3GPpQcUY5Cyx49gEzeTYqKbojrmCHxvLRR+SP2G+4UAhRVG
         Bp224DK3Rt1kX0Ae2yjTXB8Qh/PP8UKHNrwGdeZgLukR6knU6v9BsbJqy6GBabW9KGK2
         e4oVV8ejBW+yac3Q6pSNcEYt+u3fMffXHdm8lkW8n1PaUmDZteg5ii0smDZZvs0HC6k8
         psSpxEta63FKByFS7KGdFXLcikeOXTsSsUupwRF5nIzETKSE/fIXBs0ZSwpvD5rqwOxl
         8NBB3YZFzJA/9Sv9hgylkwg0Re/JgzEte1rjD32dSGkbfxCwjAdM+uGlEwGB+9eSYn4M
         WeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vUcqVPnVEujnU1+OSr6uZZ8UMx838pybQ9I1bECQuaU=;
        b=aBdRHYnMIWyrzmWXm1bpUY1UevYX/zZBhnuEdRmhE243rmUy/x1L8lGHeBLp6ZNELS
         FRHM/m6DbcMZhV5ccnPkCSXIEbXN+bIgugRxEn+4OZRUujOIxv4By9gmvY7DBs4j0pxc
         IorhqR9qrUNEMQIDe0AAawojQqEyx56LATwy+4SMF7UlO7WxRJvlTrIfbZyhRSCKCbES
         5Uds9uBfduV9y3cKrmdgHCoOAkBF+IUVe8qqOCX+NLf5HmfhCsnVqBEbuznNx7emdRZM
         eZ5lENf9r45nAtH1c48jGk5impcWXwxdV7+FV1V9zWxwiVVX2VlfdzO8vwhKJTXSJtys
         ybMw==
X-Gm-Message-State: ABUngvcR1DUf6F8uynHVEpFi0CvV+FLbpl2PORbFnKULd4IVGG2cqwcnfvv8t9aoKfrw5PUu65oMbNQw+vMTaIoj
X-Received: by 10.55.56.11 with SMTP id f11mr3857613qka.255.1477527726204;
 Wed, 26 Oct 2016 17:22:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Wed, 26 Oct 2016 17:22:05 -0700 (PDT)
In-Reply-To: <xmqqfuniabo6.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kYhMVrKHhNGYcf_D9kWEYp+sC+tMGbuE+gnD8AU27dh8g@mail.gmail.com>
 <20161026224104.31844-1-sbeller@google.com> <xmqqoa26aek6.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaR4DddoHQNUUvRAY=_PK5qqS=ws_Wkfa-EXT2seN5b=A@mail.gmail.com> <xmqqfuniabo6.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 26 Oct 2016 17:22:05 -0700
Message-ID: <CAGZ79kY00mtzwL4kSz6oXSAb-39=axeTP-ax_FxWcL7Z-sAA4w@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] attr: convert to new threadsafe API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Simon Ruderich <simon@ruderich.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2016 at 5:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +* Allocate an array of `struct git_attr_result` either on the stack
>> +  or via `git_attr_result_alloc` on the heap when the result size
>> +  is not known at compile time. The call to initialize
>>    the result is not thread safe, because different threads need their
>>    own thread local result anyway.
>
> Do you want to keep the last sentence?  "The call to initialize the
> result is not thread safe..."?  Is that true?

I'll drop that sentence, as it overstates the situation.

To explain, you can either have:
    struct git_attr_result result[2];
or
    struct git_attr_result *result = git_attr_result_alloc(check);
and both are running just fine in a thread. However you should not
make that variable static. But maybe that is too much common sense
and hence confusing.

>
>> @@ -103,7 +105,7 @@ To see how attributes "crlf" and "ident" are set
>> for different paths.
>>          const char *path;
>>          struct git_attr_result result[2];
>>
>> -        git_check_attr(path, check, result);
>> +        git_check_attr(path, &check, result);
>
> What's the point of this change?  Isn't check typically a pointer
> already?

This ought to go to

    git_attr_check_initl(&check, "crlf", "ident", NULL);

instead.

>
