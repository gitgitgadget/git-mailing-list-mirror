Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DC671F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 22:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754502AbdBAWnx (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 17:43:53 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35287 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750777AbdBAWnw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 17:43:52 -0500
Received: by mail-pf0-f196.google.com with SMTP id f144so32796943pfa.2
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 14:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=leRY67y9rLeGYtfV06pxmTY1gbaFA1lD0tdAcgg3St8=;
        b=Uku7Efozw5Ge4TWzdAbcoBkijZxoGQYQwI6nVc6s9bYOi710T5/Hr0jBE8EjzIpI1w
         eCFipHP1pjPaUlLMrjZlpBOKqqoiCbHhff3LHIYxfFCMLFwKhxBsODAz1Myrcccv3qw9
         AeXrYHmZ3c4XYgkliLrPGw5L6hmazs2s4Ed9sfFtHISPgMoZLQamA+ZCwwdMcfzAtWR5
         icmq8nl/JdSX5PK0M3iXUI/3OEdVsiYjW4C7dcnE/6e6hKzNPLq97qRw+eQwnjS/Kwnr
         D0wiacMSr3knT1Bn4JgnfLg1MT2ShVmKSL6X6dk/+sxbZXG5fn2nisL+0c83aZDOXxID
         aVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=leRY67y9rLeGYtfV06pxmTY1gbaFA1lD0tdAcgg3St8=;
        b=ZVDW9tAGH7IdVO/KPdKJ2c6UL+E821NIT+NQPnqJzVduBocts9SdhvyPSne9gMqtxk
         ziVIoFMQckfvXPf8G1LprCpRp7lXroMfJ0R6Dzc1BXZoardngpemrok5f8+rfL5Ai6JS
         tZZ/o8+r32j6QswHg3RNIZRpLgqykZF4VA88W2ykHwXpjHaackKeupXFvA3eX2U0Srt+
         TnB5+z2KmRK0fKmnUh32sJZEv3n0uqDaypm4fsRLLdpvPnP7ttz9cUlMa4TgwzMdsEKf
         YE3plDiu8iDl5hDo7BgyoLnG8yEVaQRhOkWoH2ygGc2Pw1i/TMP3UIonwlCg8zUWBz3B
         c6VA==
X-Gm-Message-State: AIkVDXIa3ORzPefV+Oy7sJZqPrK0SmHkUpu7OGr/6bFxAjILXq9c7AlrduHLhxvrWD865Q==
X-Received: by 10.99.98.193 with SMTP id w184mr6727344pgb.223.1485989031799;
        Wed, 01 Feb 2017 14:43:51 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:25a6:b4bd:905a:8303])
        by smtp.gmail.com with ESMTPSA id 199sm52266504pfu.91.2017.02.01.14.43.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Feb 2017 14:43:51 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Segev Finer <segev208@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/4] connect: Add the envvar GIT_SSH_VARIANT and ssh.variant config
References: <cover.1485442231.git.johannes.schindelin@gmx.de>
        <cover.1485950225.git.johannes.schindelin@gmx.de>
        <9780d67c9f11c056202987377c542d0313772ba2.1485950225.git.johannes.schindelin@gmx.de>
        <xmqq1svhpvm0.fsf@gitster.mtv.corp.google.com>
        <xmqqwpd9ofry.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702012319460.3496@virtualbox>
        <xmqqzii5mthp.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 01 Feb 2017 14:43:50 -0800
In-Reply-To: <xmqqzii5mthp.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 01 Feb 2017 14:33:22 -0800")
Message-ID: <xmqqvastmt09.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> That leaves the "putty" case in handle_ssh_variant(), does it not? Was it
>> not your specific objection that that is the case?
>
> Yup, you can remove that while you reroll.
>
>> No worries, I will let this simmer for a while. Your fixup has a lot of
>> duplicated code (so much for maintainability as an important goal... ;-))
>> and I will have to think about it. My immediate thinking is to *not*
>> duplicate code,...
>
> You need to realize that the namespaces of the configuration and the
> command names are distinct.  There is no code duplication.

To explain this a bit, there is no reason why allowed values for
SSH_VARIANT must be "putty" and "tortoiseplink".  An alternative
design could be "port_option=-p,needs_batch=yes" and it may be more
logical and futureproof if a variant of tortoiseplink decides to use
"-p" instead of "-P" and still require "-batch".

Prematurely attempting to share code, only because the current
vocabularies for two distinct concepts happen to overlap, is not
de-duplicating the code for maintainability.  It is adding
unnecessary work other people need to do in the future when they
want to extend the system.

