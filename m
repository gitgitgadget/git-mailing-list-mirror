Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 981E61FF76
	for <e@80x24.org>; Fri, 16 Dec 2016 19:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758269AbcLPTFz (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 14:05:55 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55647 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757956AbcLPTFy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 14:05:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3426755AF3;
        Fri, 16 Dec 2016 14:05:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vicVqwBf5wyikrFTaltx6I20nJA=; b=VI/ix4
        DYghKTEp05GRrmiRDvOI/D3+cP5pToD764KIbRPvtiQy1JF0uzsgMk+zsKQbUTFm
        7YeL+Sd488E1K5abjSm1I+5zkiXvYMi8I4KE1YtDJ+PE+8gDwUxMSd+XaPvTTaR0
        eG5AdUQhmge7RqYLKdnU4E1dwPcows+943YGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UqlQsaRT+7YeVcCw0WryYfD9Z9dCImlo
        nOPWV2UISHDSr+Jh+SswjW5Q7J6W9bMUb4CW1UMlNcfZaBrhJSGYp3Gchxf2PuVx
        QmaLqFVpP2DhO2iGF93fvUFpXJYrISQNuQ2wCm+kBLIzx7p5XZp6o7gur0h5XEUP
        y1Esay/zwmE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CA4655AF2;
        Fri, 16 Dec 2016 14:05:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9E6EF55AF0;
        Fri, 16 Dec 2016 14:05:52 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 1/1] mingw: intercept isatty() to handle /dev/null as Git expects it
References: <cover.1481454992.git.johannes.schindelin@gmx.de>
        <42ddc270ea04e01e899cc479063e5d602e4a4448.1481454992.git.johannes.schindelin@gmx.de>
        <129f000c-49c1-0e75-26b3-c96e9b442443@kdbg.org>
        <xmqqy3zfsq4q.fsf@gitster.mtv.corp.google.com>
        <5977e71d-da58-7cb0-bc69-343bb3a1341d@kdbg.org>
Date:   Fri, 16 Dec 2016 11:05:51 -0800
In-Reply-To: <5977e71d-da58-7cb0-bc69-343bb3a1341d@kdbg.org> (Johannes Sixt's
        message of "Fri, 16 Dec 2016 19:44:37 +0100")
Message-ID: <xmqqh963snhs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA1FC8A4-C3C2-11E6-BB52-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 16.12.2016 um 19:08 schrieb Junio C Hamano:
>> Sorry for not having waited for you to chime in before agreeing to
>> fast-track this one, and now this is in 'master'.
>
> No reason to be sorry, things happen... Dscho's request for
> fast-tracking was very reasonable, and the patch looked "obviously
> correct".

Oh, I do agree it was reasonable and looked obviously correct.  And
I suspect that it did not make anything worse, either, so there is
not much harm done, other than that I now have to remember not to
merge it down without further fixes to 'maint' and declare the NUL
thing fixed ;-)

> Unfortunately, I'm away from my Windows box over the weekend. It will
> have to wait until Monday before I can test this idea.

Thanks.
