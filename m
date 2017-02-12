Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04CA71FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 18:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751328AbdBLS4v (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 13:56:51 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35684 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbdBLS4t (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 13:56:49 -0500
Received: by mail-pg0-f67.google.com with SMTP id 204so7635233pge.2
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 10:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=O6cqDUfX0Dz72BBfLsvUe7UglFwqaSysCnbasX/cq00=;
        b=B6wJRBtjOcrB4sV2CvOzgKVb/RBYBZv4omZOvmf6SamZEBpoXFaHd3TnbhsvrH98SM
         gLTA+IR0lxVSmsNQ41FYp+to8ONvdn02e5vuVT+PHI4VYvYiEeVlmLv1+jldcR7Fnamt
         VYH3L5yHWnN9oFxwx4vvUhMALCHiCabrCLjEmsbsEUgKAJw2XsLv6PUgVM1g3Yj0Tqdv
         QkfL5UDPTgxxFb8PXMOVQ8lWDFmipYvyZVkZytTS1Wdg/apyJFIwP8lsOWy3fU7/yBCY
         wihNmKG/2sUFF6xY1ZhcqldOJwLv2RvO+DYI/h813t170yu8JWrh5dvGwU4P6eJEHxWe
         pgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=O6cqDUfX0Dz72BBfLsvUe7UglFwqaSysCnbasX/cq00=;
        b=K/hJEZ3y0eIE3Gp7TNlHI9EGSelFpvGpBuIp2pAluTS5ac2sPTlQ5pZFSLdQePmd8T
         0IxI8Z65Y6gN53aZQu9GBWNSV6ShVZN2qgrGM++lEULRwL2Bpn/md867q4WCsMbesAl0
         oy/rCIfkvEv/8hMlSjGUaP7PIHaujyTGwhWk2fFU4EMdHxZq84XnHb263bWajjtsvk3v
         b1TkJukJQzToBOzd/vc1Q1dVjJhrvyzGU8t1fIbi1yd+JZZLvvJPRFSUOrko95EeO3Kn
         wOGB0GMmDAWOqA7Lu+/3qPIF3oRFnYV6ORtmTR48KcFJlD9JhzZq5AADd7+PBIufSX/X
         1kQg==
X-Gm-Message-State: AMke39nenmyGv3+g8490rwuyeVC6osbyB4l7V3JT5ANEBhqow3cduK9NLo5fJwCt3Yvcmw==
X-Received: by 10.99.94.195 with SMTP id s186mr22738636pgb.197.1486925809130;
        Sun, 12 Feb 2017 10:56:49 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:644a:2999:a3b7:74ee])
        by smtp.gmail.com with ESMTPSA id r4sm10085749pgr.53.2017.02.12.10.56.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 12 Feb 2017 10:56:48 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Cc:     git@vger.kernel.org, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx
Subject: Re: [PATCH 1/2 v3] revision.c: args starting with "-" might be a revision
References: <1486752926-12020-1-git-send-email-kannan.siddharth12@gmail.com>
        <1486752926-12020-2-git-send-email-kannan.siddharth12@gmail.com>
        <xmqqh941ippo.fsf@gitster.mtv.corp.google.com>
        <20170211075254.GA16053@ubuntu-512mb-blr1-01.localdomain>
        <xmqqefz4h1vq.fsf@gitster.mtv.corp.google.com>
        <20170212123630.GA20872@ubuntu-512mb-blr1-01.localdomain>
Date:   Sun, 12 Feb 2017 10:56:47 -0800
In-Reply-To: <20170212123630.GA20872@ubuntu-512mb-blr1-01.localdomain>
        (Siddharth Kannan's message of "Sun, 12 Feb 2017 12:36:30 +0000")
Message-ID: <xmqqwpcvfdao.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Kannan <kannan.siddharth12@gmail.com> writes:

> This "changing the order" gave me the idea to change the flow. I tried to
> implement the above steps without touching the function handle_revision_opt. By
> inserting the handle_revision_arg call just before calling handle_revision_opt.

Changing the order is changing the order of the function calls,
i.e. changing the flow.  So at the idea level we are on the same
page.

I was shooting for not having to duplicate calls to
handle_revision_arg().  

>> But I think the resulting code flow is much closer to the
>> above ideal.
>
> (about Junio's version of the patch): Yes, I agree with you on this. It's like
> the ideal, but the argv has already been populated, so the only remaining step
> is "left++".
>> 
>> Such a change to handle_revision_opt() unfortunately affects other
>> callers of the function, so it may not be worth it.

See the 3-patch series I just sent out.  I didn't think it through
very carefully (especially the error message the other caller
produces), but the whole thing _smells_ correct to me.
