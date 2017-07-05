Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7D05202AE
	for <e@80x24.org>; Wed,  5 Jul 2017 15:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbdGEPRP (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 11:17:15 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:32975 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751664AbdGEPRO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 11:17:14 -0400
Received: by mail-pf0-f177.google.com with SMTP id e7so131302255pfk.0
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 08:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4tpW1uEbbuPm9MLPROGMDQfIgi01rU7c0najMxc8Yuc=;
        b=e9uPSx3LynVAxgngynKFJnP53Am9lgF/LiXn5sC3ZhA80P+mY20YZA9N/YAi+YPGAQ
         2dN3/bTMs3Ya3yJQOZt6xzJRMTPH+V4hPa28a8AIfQww3MFetehNStEpimC/e+zzlTEt
         oHZp/Fw3Aq7pIPcglv8uubTF/uucQcYdn3TDST5dK1hXM1R0BnDLXb8HBoD7d+P/ylZP
         bSkJqCMKV47zyNY2KZeFeAHpUDyVeqIKVgztLAzBXJ08WYtnISYXBu1B9KEyn7/IkmPZ
         XvlkoRXf2n1bB/ifFL6/OdMRtei2lamEjBPmhzN1zhH6bqhhN0rty49r6RsSfshFHDVK
         pYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4tpW1uEbbuPm9MLPROGMDQfIgi01rU7c0najMxc8Yuc=;
        b=X0T4Id/Kz9zHPtKVUcWG5Lzc6EAXcEpvFyku8Ko+ZdC1+6Eig4IuIWjWHvY6Zyj1Wr
         XdLxGNTV1hjE5nS/V/W2Hx5iU+bfDAf/pG2t48goAArAqH+Z2zhR0+JjPPe/G1Mwk8kx
         TaHroYjv6KXzpxs4OPPQ1gR1lR9Ccf0u2xguP4LHkuFZ8li6EpjYsOoQh4lXxgpOtkwW
         3EAysa71XQorTxdm1OBzyaJGv99ChUV2DPYq/s7vG3038KkxpQKKmbgoa01nsJxOUmYk
         xMi9EMm6KdYgdKmeuzvNSq4RRBvlVyC6U7D8eCCR5GGybu757DNEmGu6w1ZwM/zUKyVi
         +SvQ==
X-Gm-Message-State: AIVw110sMfcoHvfUhT08IAhtrPzc+FyaRKaODI23ckGiyfKp8Y/N0c/i
        yu+fMqlRRhP9Lg==
X-Received: by 10.98.74.194 with SMTP id c63mr20555320pfj.58.1499267833183;
        Wed, 05 Jul 2017 08:17:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ad13:9505:c2bc:e887])
        by smtp.gmail.com with ESMTPSA id l3sm46320596pfk.34.2017.07.05.08.17.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Jul 2017 08:17:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Francesco Mazzoli <f@mazzo.li>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] push: add config option to --force-with-lease by default.
References: <1499116727-757-1-git-send-email-f@mazzo.li>
        <xmqqvan8jdje.fsf@gitster.mtv.corp.google.com>
        <CAPB=P5xsssm=RiAkEuAtpxe52+-sNAPVP2qnQGctLjNZFYznkg@mail.gmail.com>
        <CAPc5daXn=PJ47JkZQNnReNNSUhQK3eJm0Namd-A+e9TM4Dnr2A@mail.gmail.com>
        <CAPB=P5z7MA+TuVaFLUQQdOoJXUb74YxEPS6k4O+NorneVpLitg@mail.gmail.com>
Date:   Wed, 05 Jul 2017 08:17:10 -0700
In-Reply-To: <CAPB=P5z7MA+TuVaFLUQQdOoJXUb74YxEPS6k4O+NorneVpLitg@mail.gmail.com>
        (Francesco Mazzoli's message of "Wed, 5 Jul 2017 10:04:32 +0200")
Message-ID: <xmqqa84ikj61.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Francesco Mazzoli <f@mazzo.li> writes:

> So we would have something like
>
> * `push.disableForce`: config flag that disables `--force` and suggests
>     `--force-with-lease` instead;
> * `--disable-force` and `--no-disable-force`, config flags to tune the above
>     config parameter at will.
>
> What do you think?

The take-away lesson that the earlier thread gave me was that the
order in which the three options are ranked by their desirebility
in the UI (and the order we would like to encourage users to use)
is, from the most to the least preferrable:

 - "--force-with-lease=<ref>:<expect>" that is safer than "--force";

 - "--force" that is known to be dangerous, and does not pretend to
   be anything but;

 - "--force-with-lease" that pretends to be safer but is not.

The last form should eventually be eliminated, as there is no way to
correctly intuit what the expected object should be.

To me, a disableForce configuration that encourages use of either
the best one or the worst one alone does not look like a step
forward, unless we also have a change to disable the last form.

