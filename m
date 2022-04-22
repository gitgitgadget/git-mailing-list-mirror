Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A0FC433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 06:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444567AbiDVGyG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 02:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390582AbiDVGyF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 02:54:05 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B3E50E1C
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 23:51:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 496E519B3B1;
        Fri, 22 Apr 2022 02:51:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z8+8Q7zGZXlZ16TKMqCPvdywkgJPv2wcT7r54h
        Spt9s=; b=JCo9FNIIwz8cec2NEaULxAxaQeSlV7KtIr1qoMpD3dnoJwWCq33XIM
        XhQcp4Pk8kiwTN3qNMapF03FUcBbeD28Q4AAgnDp8RR9ZIJeKlEteyZvigjaYakM
        P1z/zQokvn8gf3QbEaBMO8xGMKy1kNEgS1y+KTvTrplsecGLGtGhQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 41CF519B3B0;
        Fri, 22 Apr 2022 02:51:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C093E19B3AE;
        Fri, 22 Apr 2022 02:51:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Alyssa Ross <hi@alyssa.is>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: Failures in t9001-send-email
References: <20220421194832.lshqkl3bogy2f2hy@eve>
        <220421.86tuam5hoi.gmgdl@evledraar.gmail.com>
        <20220421223843.6z3y4bnrbu76erhk@eve>
        <36a43fbb-92af-3718-f2fb-51645564a961@kdbg.org>
Date:   Thu, 21 Apr 2022 23:51:07 -0700
In-Reply-To: <36a43fbb-92af-3718-f2fb-51645564a961@kdbg.org> (Johannes Sixt's
        message of "Fri, 22 Apr 2022 07:40:07 +0200")
Message-ID: <xmqq7d7hd31g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96D97B7E-C208-11EC-BFC4-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>> I had a look at the tests to try to guess what was wrong, but I didn't
>> come up with anything.  Any ideas?
>
> You run ./t9001-send-email.sh (without `prove`). Add -v to see some
> verbiage from the tests, throw in -i to have it stop at the first
> failure (so you don't have to scroll back to find it), and add -x for
> additional traces of commands that the shell executes (to see the exact
> command that failed).
>
> IFAIC, I always go all in, i.e., either all or none of -v -i -x.

Good suggestion.

I rarely (if ever) use "-x" myself but another useful thing to know,
while learning how the existing test works (i.e. studying a working
test, not debugging a broken test) is to use "-d", possibly together
with "-v", which refrains from removing the trash directory.  Then
you can go in and examine the state of the test repository the tests
left.

Thanks.
