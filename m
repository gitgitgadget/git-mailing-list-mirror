Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE010C2BB1D
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 21:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B522C206D9
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 21:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u6JSKBBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgDQVf6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 17:35:58 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52889 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgDQVf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Apr 2020 17:35:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 54536B91B6;
        Fri, 17 Apr 2020 17:35:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v2DGNUGQ+kWoYCUOCVxraFVT4Rk=; b=u6JSKB
        Bhbg1Y5dDQldg6j0b2VODue3/IfYuHIFYnPjfn+HB9VXwSiR+ygAJqdhQ/I9csSI
        lrm74ukByFmlRzx1lu2B/NtQXXbbITp0FOIukfLIIpLDJAoylg8ZpHujYAQYJqOC
        SDigic9KRWKD0NBOI2Nk9X0HfgWOix6VwjDbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RgY6J0mfST5+VWVR1BFcgXSMgGdgFyOJ
        az8c1zT69sYNKiPP6z3KbLRJMH+8IUe6SPRv7MaTzD90puEZVJruNidvOZkNJAF9
        RHZv2uy1i5Iskb71UX8dlfyAVZ6t5Ao9m8my5uyLLTVDrVHvZue6VA0A3qpq9hlZ
        qwyxqTtJpSo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4C718B91B5;
        Fri, 17 Apr 2020 17:35:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 915E0B91B4;
        Fri, 17 Apr 2020 17:35:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Andreas Heiduk <asheiduk@gmail.com>, git <git@vger.kernel.org>,
        Greg Hurrell <greg@hurrell.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] grep: follow conventions for printing paths w/ unusual chars
References: <xmqq1ronyz1s.fsf@gitster.c.googlers.com>
        <eaae7214925189f562056b1ee6972c05dcf76a32.1587103366.git.matheus.bernardino@usp.br>
        <xmqq8siuwqxp.fsf@gitster.c.googlers.com>
        <CAHd-oW7B1wtHOE7KCtOR-kAXhuj8Du_MAYobWd9nSsSvm_sChQ@mail.gmail.com>
Date:   Fri, 17 Apr 2020 14:35:51 -0700
In-Reply-To: <CAHd-oW7B1wtHOE7KCtOR-kAXhuj8Du_MAYobWd9nSsSvm_sChQ@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Fri, 17 Apr 2020 18:19:07
        -0300")
Message-ID: <xmqqd085vlqg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A3E978C-80F3-11EA-A6C0-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> Right. But the ABC prefix here is always a tree name,...

Oh, then that is perfectly fine.  I did not expect that the code
passes <tree-name>:<pathnname> (like "HEAD~2:t/Makefile") to us as a
single string.

Thanks.
