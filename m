Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BD6120985
	for <e@80x24.org>; Mon, 12 Sep 2016 01:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755922AbcILB5t (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 21:57:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51151 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755365AbcILB5s (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 21:57:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23F8B3E07E;
        Sun, 11 Sep 2016 21:57:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XI8jfns14TTStX2cHJ8nhRTQsD0=; b=EBpjfL
        /yxS1y63c/nXIfxJhQT9ti/XtASe0d+IRbN1CK24Sn4rPi1TMpuii1VqPhihs7CC
        HdlT6cakFOuDW88fG84tdksQXFLZaG2TqT1PQhK1tOXnf/tTPIeVK5vx2ByQV88k
        jH0oETicSDDssMoxSDEgGpRdmMpoIxQj6Oa3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RZusUMYdCuRxP6wQaMNLJG9O02IDrBhJ
        lUzauj3mTLCOLHLT2+vJKO761l7WidA60kGKdghZZl9+PocbtVt81sfDaJ8NoKeR
        qxglrogH6FdEh4Ikx4dFCoE5WAq/Hsn2EwmYtVgV7k39uR5xXabu5EK5YsUgE7IE
        YE27T8bfBOE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 19E773E07D;
        Sun, 11 Sep 2016 21:57:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 806AD3E07B;
        Sun, 11 Sep 2016 21:57:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Christian Neukirchen <chneukirchen@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: git commit -p with file arguments
References: <87zinmhx68.fsf@juno.home.vuxu.org>
        <CA+P7+xoN+q_Kst=qXG_HRznxbN7cbyi5uZe15zq1c16EifeK1Q@mail.gmail.com>
        <xmqq8tv1c5nb.fsf@gitster.mtv.corp.google.com>
        <23de5ffe-eaf8-2d62-2202-f1bf6087d44b@gmail.com>
        <87inu4bxt7.fsf@juno.home.vuxu.org>
        <b9d63103-011a-9486-2fa1-dcf3a82cbe64@gmail.com>
        <xmqqvay26r8u.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xqdWbERVQenZJTLyirBy2VFrKV2-uBOxB1CwcWs+gy43A@mail.gmail.com>
Date:   Sun, 11 Sep 2016 18:57:44 -0700
In-Reply-To: <CA+P7+xqdWbERVQenZJTLyirBy2VFrKV2-uBOxB1CwcWs+gy43A@mail.gmail.com>
        (Jacob Keller's message of "Sun, 11 Sep 2016 15:05:09 -0700")
Message-ID: <xmqqa8fd6fs7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D155B64-788C-11E6-9666-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> Yes, I'm actually confused by "git commit <files>" *not* usinng what's
> in the index already, so I think that isn't intuitive as is.

You are excused ;-)

In ancient days, "git commit <pathspec>" was to add the contents
from working tree files that match <pathspec> to what is already in
the index and create a commit from that state.  This ran against the
intuition of many users who knew older systems (e.g. cvs) and we had
to migrate it to the current behaviour by breaking backward
compatibility.
