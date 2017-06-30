Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1948201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 18:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbdF3S5p (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 14:57:45 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33987 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751919AbdF3S5n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 14:57:43 -0400
Received: by mail-pf0-f172.google.com with SMTP id s66so71204330pfs.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 11:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Du2qkOTA7/Gcxh0F94ZvKpKByETu5IkHt6DgFLZnVMQ=;
        b=D944VLFiW8rBp7e26+LG2Got4qyE664wuDtvvEgZn2w4abo0WsVPSjPr/3++doHsHE
         kDCYq2Aj/YwtBXdU6fGTuNiu2ZPMPUK95EpJndSQyF35NLlxOqlgSDd+tRLQ69RZbbo+
         J/0DlFodubjGoGQzTydbyeHBQctWspuwfvZFxZktcA0PG3QF2MNPECRAbM483sHgTKmE
         Ks0HSBH/8Fknb+g9TlPnC19VNR5gAHavrOe3rD/o9n87R01aigywP1a32mRU+9+H1AOe
         x++v4YsO+9udt+K1l6w3JT5VbLox0tn8phJOtTDQxCciL/WIzMu8ddpNgBrqly4u7ldW
         2gpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Du2qkOTA7/Gcxh0F94ZvKpKByETu5IkHt6DgFLZnVMQ=;
        b=N4M7WepkOxcJZohPHGONgCq+fwGoPJBdWP/5+pGBwuzdr1o/wms7SKbZKKeXs4vLY3
         0K7vDvWsYXB4oUbJ1N7KoGAGDon+wxG1JuARhHyFY4bj9uUppJtc1Vxvxe5BzAuIw/+g
         iP0FMGhKVrUANCua6XZT/r0dExj3K2tog8ZABzwOSTApBrC5N3WS2d/kWoPtFDOmGBbl
         3bOzG6UfPSBs+1lTELY/Yii7HVRiy9Tdu4N4TbHqaMuhj4TuZr5yVpIQfQ/MRQDKZNOq
         z4ZiVNS4WdoalydOhYE57XNqqj5XqdCqUmm4EvUudP74Hqf6U2aqGksOziLi7kLQQTSA
         w3VA==
X-Gm-Message-State: AKS2vOzhMaDc4LCjoqLaykfOk5R5ymBqEE34G6+quQnfCUpapLAHoDkm
        3AWb4ZD+o2NC175DEN+kBc5oMtvUejS9
X-Received: by 10.84.217.138 with SMTP id p10mr25785127pli.66.1498849062918;
 Fri, 30 Jun 2017 11:57:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Fri, 30 Jun 2017 11:57:42 -0700 (PDT)
In-Reply-To: <xmqqo9t5qpma.fsf@gitster.mtv.corp.google.com>
References: <20170629011334.11173-1-sbeller@google.com> <20170629235336.28460-1-sbeller@google.com>
 <20170629235336.28460-2-sbeller@google.com> <xmqqlgo9s7li.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbu2hqc41eBk_AtoeTviJGT4TTV7M6cYp0h4q=gJs2wRg@mail.gmail.com> <xmqqo9t5qpma.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 30 Jun 2017 11:57:42 -0700
Message-ID: <CAGZ79kbqLS-DxOPe+uG9UssD9s3f7JT5qp1YKMPqFMcOGoLL3A@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] hashmap.h: compare function has access to a data field
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 30, 2017 at 11:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Ok, let me redo the patch to have fndata at the front.
>>
>> Looking at other places (that have a similar mechanism mechanically,
>> but are semantically different), such as the callback functions for
>> the diff machinery, we have the user provided pointer at the end
>> of the list. But that is because the diff_options are the objects that
>> should be in front row (they are bound to the callback more than
>> some caller needed data).
>
> Quite honestly, I do not care too deeply about an API specific to a
> particular area like "diff" that passes its "configuration" data
> that everybody in the API knows, i.e. diff_options.  If the
> convention for ordinary functions in the API is to pass that in a
> particular location in the parameter list, I would think it is good
> for a application-supplied callback function to follow that pattern.
> After all, it is to configure the behaviour of the "diff" and the
> caller-supplied callback could have been part of a (hypothetically
> richer) API implementation.
>
> But I view a comparison function that is given to hashmap that is
> supplied by the caller a bit differently.  It is not about
> "hashing", so the reason to have the data close to function pointer
> is stronger there.

Yes I agree with that, I forgot to say so.

I just cited the example to see if we have a preference in the project
already and that's about it, but as it is different, we can put the fndata
first.

Thanks,
Stefan
