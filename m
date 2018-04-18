Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2E591F404
	for <e@80x24.org>; Wed, 18 Apr 2018 00:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752975AbeDRASC (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 20:18:02 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44022 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752915AbeDRASB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 20:18:01 -0400
Received: by mail-wr0-f194.google.com with SMTP id u4so8639250wrg.10
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 17:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=s1Nl68Lynukqdb+EIw/GisMuL12ZVyUm+ahHpZV8qnM=;
        b=V0AIcwVUOCco9hikHg8qM7HokfjJ3ERllcuO7d5CBS/mxqk51Q6h/lGPKcpHwqFEgo
         3jegBvzJ/tVF+sfbWGxdlwpnPhLfO6vEptjsuKFsD9a6LFOo2lWBQB/uHMLoswbCuVXz
         p1xvLbMQ0yCML2G6mO/qxeRSozVFPMvUU6HitEQyrWzq8h2oLM02gyVGSGNPLh2eaOrA
         xaymCLC/MRxq8+UJcbCzEyIvz2jLmxTNMMkbxLntcK3/iLXgkFr4tKoexSE9LWK/Rblj
         XRp9FTR5izAfnGiA+4482SQW1vIj5fhkzdMdGhWFrwIQ+oQ9jcQZVt7U7ij0fnEqUIS8
         rnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=s1Nl68Lynukqdb+EIw/GisMuL12ZVyUm+ahHpZV8qnM=;
        b=EmVG2t07cgIPJPX4nuMRSaMNU8aSezyEXjyT3szmhdcI67y36aXCFhsUvILQ1fnPSE
         yaQcTFF2oXWH+9Cku3j6vCNpBgl0XZ1uLMzzutqXLimN0euDMycXnVAXLjSNakuriykw
         dGPAq9SiWSxz2YZIIbE1iLmq+7Asl5TYu352pMj+zPBRB0TC6vXTr0o2Wam/JbxOsRHz
         /GXvDq8GkUccdEFFyHnbVRK84JRqefg1Joq0uRilJBrO0Sv58cTHwyQyTpoeJv7hxja2
         TdXv/vmNfREnNjBbZrEma++5vDIRUuoBxq7VOYrJxAuUg40rKdOAgevHYwly6DRwtMtu
         PDOg==
X-Gm-Message-State: ALQs6tAWmM2QIf1YyBp5VllKkZSOE6P8jkktoDa35ZoPpggHonNn3I0s
        GLMnXtLU052HPnbmaRRZC7k=
X-Google-Smtp-Source: AIpwx4/6sqBzOIB6zj099gGyjn+yN3mgPnZ7r7pHyfb6kLkQU7Pjkk42sty/EhEn7a4UStu0QcBtmw==
X-Received: by 10.223.209.66 with SMTP id b2mr3150881wri.178.1524010680432;
        Tue, 17 Apr 2018 17:18:00 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 185sm448241wmj.46.2018.04.17.17.17.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Apr 2018 17:17:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] worktree: accept -f as short for --force for removal
References: <CAPig+cSHmxtsz2NNAFvbqXRFKE87ZVyUYpRigjgXE5p8LcR09A@mail.gmail.com>
        <20180417181939.247898-1-sbeller@google.com>
        <CAPig+cTgoD-GvpoBQ6tcGX4T2XhuKccJAZ40P76vxVD_PfEc9A@mail.gmail.com>
Date:   Wed, 18 Apr 2018 09:17:59 +0900
In-Reply-To: <CAPig+cTgoD-GvpoBQ6tcGX4T2XhuKccJAZ40P76vxVD_PfEc9A@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 17 Apr 2018 14:46:49 -0400")
Message-ID: <xmqq4lk9l64o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Apr 17, 2018 at 2:19 PM, Stefan Beller <sbeller@google.com> wrote:
>> The force flag is very common in many commands and is commonly
>> abbreviated with '-f', so add that to worktree removal, too by using
>> OPT__FORCE instead of a self cooked OPT_BOOL for force.
>
> The missing bit of this sentence:
>
>     ...self cooked OPT_BOOL for force which forgets '-f'.
>
>> While at it, add the PARSE_OPT_NOCOMPLETE flag to the force command line
>> option as forcing a removal may lose files.
>>
>> The short form of "-f" is already documented in the man page,
>> so we do not have to adjust the docs.
>
> Makes sense. A possible rewrite (of the entire commit message):
>
>     worktree: remove: recognize -f as short for --force
>
>     Many commands support a --force option, frequently abbreviated as
>     -f, however, "git worktree remove"'s hand-rolled OPT_BOOL forgets
>     to recognize the short form, despite git-worktree.txt documenting
>     -f as supported. Replace OPT_BOOL with OPT__FORCE, which provides
>     -f for free, and makes 'remove' consistent with 'add' option
>     parsing (which also specifies the PARSE_OPT_NOCOMPLETE flag).
>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>

Looks better.  I am not sure if s/--force/-f/ in the synopsis
section is warranted, but '-f' is commonly understood as '--force'
(and that is the point of this patch after all), so it is probably
an improvement to be briefer.

Thanks, both.

>
> The patch itself looks good. Thanks. With or without the above rewrite
> or minor adjustment, this patch is:
>
> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
