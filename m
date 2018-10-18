Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9D6B1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 06:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeJROuT (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 10:50:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36055 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbeJROuT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 10:50:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so32312574wrw.3
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 23:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0y62n40x9mlUdtSewXDgq7/JR9fZ++w4oejsPnSsEIc=;
        b=IJ3oJSp7gp4XRpKsZmLOhfydY8A3PuC33DWC+Yb4+rcNnPL4zfkpp9/5+GsLAw8jHa
         Cl5V9yiPfF0yunHotNcwQvJ9YdXZaUOPoiWAHOXJ2SwQWcx4Eqdk8reHOmAwr+lXeU8h
         fMvUchao26VOlzugjwfi93khAyQCEiFJsRzEwC70uNo1RhKLT+QM2JDUTgOjLnV2JMMr
         Ajiq8LjGb4gj7LqobGI2gwVFSDfCJFnvv5JqC4GgA/UxfknrFj0dh+dtAUd+c4fPcSna
         EtasPjGJ5SQOiDkXFD2+CMeqsNMemJgvvHTkP21Fuky7TK025nieGVd3NZawZxLyyAa+
         g0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0y62n40x9mlUdtSewXDgq7/JR9fZ++w4oejsPnSsEIc=;
        b=VvTHR34RGAbi2W7UnwswWTeGYv0ag/SSkn98ARr5giHVUqtauVhtuZSW4hTKJ4lx8p
         usxBI7DsmV3OE+a64nsRHrZbkA+j0SkcwF23/Drk+fn3WzC9xChRKtYclv8co/CWVFmp
         kHk2WCBuwhBG0dWUOR6OtlC7Ydkp5pNIqV0JZgvSRiWdJriTPiXIaY5FUTrzeakAYuGL
         cxcslgL0FFWSqPFcf1zjJ+x5EoVYgl/7nh3BnNjXCvkup5YSe2bp4jwQUSqvOS8Q4Xpz
         aYr9zNQpmgeoPv0pZNkt9fcPMgYbcB+Nx20wStaTAEyONDkq6R09PYeKk0x8hggKd1g7
         M1Ig==
X-Gm-Message-State: ABuFfoiOWsRXHzJR04kJOy/uACWHZ69MrxuRjTNX40tfzc9nMp8n8bH2
        rhtsPXP84DmEd0RMQEeIVy/qi0/dk8Y=
X-Google-Smtp-Source: ACcGV622Npl8HbSJ3uCtaqEK1y6NkkTnp0exTr61sxWThTNu6sg0vVmNonIQOFbghmqutox3KP08fw==
X-Received: by 2002:adf:e0c9:: with SMTP id e9-v6mr27786055wri.199.1539845446325;
        Wed, 17 Oct 2018 23:50:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w11-v6sm30002657wrn.65.2018.10.17.23.50.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 23:50:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] ref-filter: free memory from used_atom
References: <CAL21BmkdUiNgr4NqpwTdi9f47i85s8oXCZMmVx5VyNKotL78uA@mail.gmail.com>
        <0102016657e7cfee-f1343b1e-9a85-4cae-990a-cc7177ea8487-000000@eu-west-1.amazonses.com>
        <xmqq5zy9jnv1.fsf@gitster-ct.c.googlers.com>
        <xmqqa7njevu2.fsf@gitster-ct.c.googlers.com>
        <20181018063306.GA23497@sigill.intra.peff.net>
Date:   Thu, 18 Oct 2018 15:50:44 +0900
In-Reply-To: <20181018063306.GA23497@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 18 Oct 2018 02:33:06 -0400")
Message-ID: <xmqqr2gnu4sb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Presumably it came from the manual comment-style fixup.

Wow, that was embarrassing.  Thanks for catching it.

>
> With that fix, the tests run fine for me under ASan/UBSan (with the
> exception of t5310, but that's fixed already in a parallel topic).
>
> -Peff
