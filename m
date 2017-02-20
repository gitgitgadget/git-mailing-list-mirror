Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F7DB201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 20:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751409AbdBTUab (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 15:30:31 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33655 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751240AbdBTUaa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 15:30:30 -0500
Received: by mail-pg0-f66.google.com with SMTP id 5so14343142pgj.0
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 12:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=M8M9xAS49UQYAC+ooOq6QYoM3OJKAXIGdF345aUYmOI=;
        b=QTelALyb/m4y4LdXaAA1Jpa3VR7wB3bcx0C8s3v0OMRcDvEJ1NHkyEclmaTwOWEXP/
         RcqQOCB1kCggG8yziljC1jJVqFu8ufomvWgt9lQUi2ZlwXLIHFzTmhIVtxBAhzSyNdtJ
         s/itKzR6dUN8KPg4yhERvA1KU3zWng0reE+vVjiW3BnBNa5v58YyZj7zVvaf4M7rvZoT
         m1y05DXPhU56fGA+GM8ufFqrF44tShj3qQGsDTqZ4ZbyLprXwIZ6mxZ20fQvvKk5zbBt
         dd2IBs+Q7MtQ5YKcNlCKv4RaviLe/gd1DHiFVEDaLdXnKErYSeTjZ1VecWAmxLnKcZiX
         36vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=M8M9xAS49UQYAC+ooOq6QYoM3OJKAXIGdF345aUYmOI=;
        b=Mn8LuLB68ELBskRwdXTxD15QKQ1oUvTrx1ZqhfyPe3Vmu/ey5Vk6xdtcKC8lSGjqNr
         ljwrwFOrE0XsvfNAWeeoRFd8qAb0rznjFM1XBreY6BeRCZP9ovEr0pUDACMurBDPPxdb
         myZMoxPl5pjYjICYqR5tan7B0DV6LBZnbHZCSwvJP8SrI5t39CTAamIC8gcyyncHU11f
         vk+IqECV/q42T67zGLLLZbBXbgvAjiuPA7IgrQoF1ITk/KCy41q1zze8N9HiM/XN/xeA
         Xg5KmTcoC+YZCIYG4cVxP2GuWOOcSeELK0yE4EawAI6qJ9AMhGehHvkYlK3zVNbJvKS+
         uZXQ==
X-Gm-Message-State: AMke39mHjzMW45yBDCuZBHQ8Q02S+DHitW4FoFjAFuHOTueY6Kgii2ZLNC6szDw0fTGSCA==
X-Received: by 10.99.157.143 with SMTP id i137mr27701918pgd.132.1487622629643;
        Mon, 20 Feb 2017 12:30:29 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:71d2:895f:c7:4f5e])
        by smtp.gmail.com with ESMTPSA id i15sm716142pfi.94.2017.02.20.12.30.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Feb 2017 12:30:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Jeff King <peff@peff.net>, pclouds@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.ath.cx>
Subject: Re: [PATCH 4/4 v4] sha1_name.c: teach get_sha1_1 "-" shorthand for "@{-1}"
References: <1487258054-32292-1-git-send-email-kannan.siddharth12@gmail.com>
        <1487258054-32292-5-git-send-email-kannan.siddharth12@gmail.com>
        <xmqq8tp6x8b6.fsf@gitster.mtv.corp.google.com>
        <CAN-3QhoXBnLWyfuUsuvvRMYNnoupMrQHxE_G=ysyA_14KX4Yrw@mail.gmail.com>
Date:   Mon, 20 Feb 2017 12:30:20 -0800
In-Reply-To: <CAN-3QhoXBnLWyfuUsuvvRMYNnoupMrQHxE_G=ysyA_14KX4Yrw@mail.gmail.com>
        (Siddharth Kannan's message of "Mon, 20 Feb 2017 19:51:12 +0530")
Message-ID: <xmqqshn8ip0j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Kannan <kannan.siddharth12@gmail.com> writes:

> On 17 February 2017 at 00:38, Junio C Hamano <gitster@pobox.com> wrote:
>> Having said all that, I do not think the remainder of the code is
>> prepared to take "-", not yet anyway [*1*], so turning "-" into
>> "@{-1}" this patch does before it calls get_sha1_basic(), while it
>> is not an ideal final state, is probably an acceptable milestone to
>> stop at.
>
> So, is it okay to stop with just supporting "-" and not support things
> like "-@{yesterday}"?

If the approach to turn "-" into "@{-1}" at that spot you did will
cause "-@{yesterday}" to barf, then I'd say so be it for now ;-).
We can later spread the understanding of "-" to functions deeper in
the callchain and add support for that, no?

>> It is a separate matter if this patch is sufficient to produce
>> correct results, though.  I haven't studied the callers of this
>> change to make sure yet, and may find bugs in this approach later.
