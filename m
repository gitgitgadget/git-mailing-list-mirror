Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7838D2035F
	for <e@80x24.org>; Fri, 28 Oct 2016 20:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756540AbcJ1U3r (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 16:29:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64541 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754450AbcJ1U3d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 16:29:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0094D49A9A;
        Fri, 28 Oct 2016 16:29:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2nZg3u5VFSAzVrIrTTmh4XU/zEU=; b=Rbrwm+
        9qzAYrvUfAE4YM9HYzqJQs+B+bZZmuIuMzjcK7HQ18fjSqADxrZIHiSOktWCIAlB
        sd6ZtAfaGyGU+vQl/sYlA779r/RKBFnw8nHH0TKZ6sogoI7G5Zqy1gHOcIafKui5
        N6b6b0+D2MfbeRMOD9zQcbpE+EfzBpLb95CPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pEmpmAMqV1si2sCsmlrKn0aX7/sQns+1
        voSweYkUv6rivrFr2vZ8CxH2VUpu1Rmoe7xzuyRIGTHXQNile1C33od1YcHRZC2k
        g7lR3JeRswaWvrSlE390ZXSYFajiX0qnFmPLXmOpu9Ik0zuah6Bk0PZTNMXxJ8zi
        ed1OVB28vW4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB94549A99;
        Fri, 28 Oct 2016 16:29:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 54FC849A92;
        Fri, 28 Oct 2016 16:29:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Simon Ruderich <simon@ruderich.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] compat: Allow static initializer for pthreads on Windows
References: <20161026215732.16411-1-sbeller@google.com>
        <93be5d21-6cb6-ee2b-9f4f-c2fe7c690d6c@kdbg.org>
        <xmqqlgxa8h3a.fsf@gitster.mtv.corp.google.com>
        <67e38b43-0264-12f2-cca8-4b718ed7dc9d@kdbg.org>
        <xmqqh97y8g74.fsf@gitster.mtv.corp.google.com>
        <xmqqd1im8foi.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbP3pgPHgv-x1Q-Q1QwmXc=gOyxWhXh2SngO8WSZc3PFA@mail.gmail.com>
        <34c88c40-2088-fd74-5d26-56c0599b7eb9@kdbg.org>
        <xmqqr3716301.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kY_fZ_pDtVnwJoDkR6PjTNoqDMN5OC70Z8SH_J0Wvkq-w@mail.gmail.com>
        <a2e5acd6-485d-0387-7a85-6042dee702f7@kdbg.org>
        <CA+P7+xpckfaeHmoEGQBdLD-=Kf7gQ-jOxGFKrKmiFH1SBN7GjA@mail.gmail.com>
        <alpine.DEB.2.20.1610281356310.3264@virtualbox>
        <CA+P7+xoyF8EG079eC-dfTSj+YrbxhPWx356-jZ90gDs6SwyppA@mail.gmail.com>
        <38b70094-5550-8512-7735-a6739f435803@kdbg.org>
Date:   Fri, 28 Oct 2016 13:29:24 -0700
In-Reply-To: <38b70094-5550-8512-7735-a6739f435803@kdbg.org> (Johannes Sixt's
        message of "Fri, 28 Oct 2016 22:26:01 +0200")
Message-ID: <xmqqr370z07v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 38510620-9D4D-11E6-83C5-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Another problem with the proposed patch is that there is no
> declaration for attr_start() before the call in compat/mingw.c. We
> would have to move the declaration of attr_start() to cache.h (for
> example), because #including attr.h in compat/mingw.c is plainly
> wrong. However, it would not be a major offense to #include attr.h in
> common-main.c. But when we do that, we can certainly spare the few
> cycles to call pthread_mutex_init.

That sounds like a good argument to have it in common-main.c.  

Would it mean that the code that defines the mutex needs to have
#ifdef that defines a no-op attr_start() and defines the mutex with
PTHREAD_MUTEX_INITILIZER with #else that just defines the mutex
without initializatin, with the real attr_start(), though?
