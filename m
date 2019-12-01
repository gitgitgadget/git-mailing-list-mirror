Return-Path: <SRS0=LEOb=ZX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F02C432C0
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 16:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC8720748
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 16:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YH0OPgyE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfLAQdT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Dec 2019 11:33:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62045 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfLAQdS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Dec 2019 11:33:18 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C9091C4BA;
        Sun,  1 Dec 2019 11:33:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vM4nhPSOqBAxq5mS1BB0Hihq2qs=; b=YH0OPg
        yEsY0YKKEpSXVXNegsn8NV+vfMgZeKWSSIQ2rzPA2/7FvTHFl7JWxYncEdbRfOZr
        JNPMCe2xEgxhxmkuul59fRGNq6aUeAzW3DU3mJxDqxxxLE5pwKXSAez8D0yD/BRe
        8v66QuNUBYRFiJYF8astqORUo5BwBoi7ylbFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GhnYM1+ukEeKyQJo/Z1gFSn2zt2zao7E
        vFq4AWberqxgJQzFlNl6l/MxYjLCaTkXC49/4/N/vjV4Cten/BoaYzf3HO0K/oYI
        K1531eFR+Fo+K1b1eJ/hBAfxqi2/939YVj3EIPX4+ikwJI0WL6xXi8NJAeSv0i1e
        UgCXZZlDG1g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 624C61C4B9;
        Sun,  1 Dec 2019 11:33:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C560D1C4B8;
        Sun,  1 Dec 2019 11:33:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Todd Zullinger <tmz@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] t7812: expect failure for grep -i with invalid UTF-8 data
References: <20191130004653.8794-1-tmz@pobox.com> <87a78ddc9o.fsf@hase.home>
Date:   Sun, 01 Dec 2019 08:33:14 -0800
In-Reply-To: <87a78ddc9o.fsf@hase.home> (Andreas Schwab's message of "Sat, 30
        Nov 2019 09:00:35 +0100")
Message-ID: <xmqqo8wsypit.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 465AA93A-1458-11EA-B6F2-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Nov 29 2019, Todd Zullinger wrote:
>
>> When the 'grep with invalid UTF-8 data' tests were added/adjusted in
>> 8a5999838e (grep: stess test PCRE v2 on invalid UTF-8 data, 2019-07-26)
>> and 870eea8166 (grep: do not enter PCRE2_UTF mode on fixed matching,
>> 2019-07-26) they lacked a redirect which caused them to falsely succeed
>> on most architectures.  They failed on big-endian arches where the test
>> never reached the portion which was missing the redirect.
>
> It's not about big vs little endian, it's only about JIT vs non-JIT.

So, which one of JIT / non-JIT sides did the test fail unexpectedly?

Should I do s/on big-endian arches/with PCRE with JIT disabled/
while queuing the patch?

Thanks.
