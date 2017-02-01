Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25F061F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 22:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753769AbdBAWdZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 17:33:25 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35897 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753485AbdBAWdY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 17:33:24 -0500
Received: by mail-pf0-f196.google.com with SMTP id 19so32715960pfo.3
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 14:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ycnNVNCe2fj7WzjSpd8ZlNq1F15ny5xC5UPmljA1nlI=;
        b=Z4XUObOkcqGB1+7uRT6NlHDhasWppZXm/DJ7hJ6s4VKp+BsWDFZRIqQHNgMT5AjANp
         5jtDqRx0UuI0X2nk7N+q0EnHJFnHFPLAuR7W1VYIFutbIopkxG6ep16bklxgTewcUF49
         I0Z3tQTqSda2RsAeRBERVYpyopPYRgnbZGt82euTsliugFbwpWXz8nw7MVVZFISDEska
         Jrsa95D2QztY6XvWczMkIYS0ZvxbIGjV4vAmjNskCJEPqqXcH7mDtso5NRjxTpgOd444
         DuL0v1dCV0N7RBMzzPmQ1pudv/9WigyeScOFywX3Xf4GanLzcegh3HHbMM+SzyYiL88W
         0i+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ycnNVNCe2fj7WzjSpd8ZlNq1F15ny5xC5UPmljA1nlI=;
        b=CXQEDMn7EYTJkKPGLMOw4lpwpfXBRGhBAkc3BdBmzupLK3SiFrhUwgU5F60ys3N4Ln
         Y74YAnEABA7Fod2mUxyk/ywUTdRYwrOeu1tMfEcJPrxklrxG1fFVQCVWaqMkwUAMtKGO
         v8VlRLUixGE2G2ErZwSJXmXR9gr2TZ4yquiUYVK41NO7t3QfaxlN8/zn+jvDPQ4BICIB
         WKFHKfscvpuGx4m6j1856G4hNwClKTJj5dKCQLGeNwUHMpiiaitcMS9fy5jQjc1W8orT
         Yz3q/LR2lAcycqggM7zbykMJRfGeJGUWITPo1RZYYMt0olt7hy1T2Vv0Zlho+26yGf1d
         C9DA==
X-Gm-Message-State: AIkVDXInVJ78vBavp5mriAudq2tY0oNja/9xB4WmJ8wsq5FC/tnGcEvA+WWrMyUIbcksYw==
X-Received: by 10.84.247.2 with SMTP id n2mr7714232pll.39.1485988403641;
        Wed, 01 Feb 2017 14:33:23 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:25a6:b4bd:905a:8303])
        by smtp.gmail.com with ESMTPSA id m136sm52762251pga.22.2017.02.01.14.33.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Feb 2017 14:33:22 -0800 (PST)
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
Date:   Wed, 01 Feb 2017 14:33:22 -0800
In-Reply-To: <alpine.DEB.2.20.1702012319460.3496@virtualbox> (Johannes
        Schindelin's message of "Wed, 1 Feb 2017 23:24:04 +0100 (CET)")
Message-ID: <xmqqzii5mthp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> That leaves the "putty" case in handle_ssh_variant(), does it not? Was it
> not your specific objection that that is the case?

Yup, you can remove that while you reroll.

> No worries, I will let this simmer for a while. Your fixup has a lot of
> duplicated code (so much for maintainability as an important goal... ;-))
> and I will have to think about it. My immediate thinking is to *not*
> duplicate code,...

You need to realize that the namespaces of the configuration and the
command names are distinct.  There is no code duplication.
