Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BEB21F859
	for <e@80x24.org>; Wed,  7 Sep 2016 19:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753806AbcIGTvH (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 15:51:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51887 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752040AbcIGTvG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 15:51:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9AA3038C44;
        Wed,  7 Sep 2016 15:51:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oIY0WXYKxyBN7sqGZosV8FUFj70=; b=sTshYK
        tS/YsF7TY4EMAvHn9tgGmOgo18ZvAp+CU6zOf9u4tTzseQyeOmZB5QfJudTSSVzX
        FykOCTHNPLTzwRgAs+kSxzhZoe3grwyw4wsN99WNS57SvNb0dxMYVBJRbgzA5BYj
        dzT/uKENNDP4Tm8F6wHmUnJcsSC8AIlPqF64U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X3itPEXgArPN53I7aMy7WCai7ZXlQ50G
        9kmJmI/y1HfPate4X+sdkHPD7VdAI6gqMk4F9/LMme/Q9zIwknCAqxevW6rOPhKd
        AvoqU4fKBoDhFxZWULxDfxLDVdFV9H3t1J+EoPQMKEZEr3uMmcn/4A5LcwImU9q0
        BaxUxtgA4dE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91BCE38C43;
        Wed,  7 Sep 2016 15:51:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EDB7538C42;
        Wed,  7 Sep 2016 15:51:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v14 00/41] libify apply and use lib in am, part 2
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Date:   Wed, 07 Sep 2016 12:51:01 -0700
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Sun, 4 Sep 2016 22:17:52 +0200")
Message-ID: <xmqqinu7lc9m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68EDFFC2-7534-11E6-93C1-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> In patch 29/41 I added some comments in apply.h above the definition
> of APPLY_OPT_INACCURATE_EOF and APPLY_OPT_RECOUNT, as suggested by
> Stefan. This is the only change compared to v13.

OK.


>   - Patches 33/41 to 37/41 were in v10, v12 and v13.
>
> They implement a way to make the libified apply code silent by
> changing the bool `apply_verbosely` into a tristate enum called
> `apply_verbosity`, that can be one of `verbosity_verbose`,
> `verbosity_normal` or `verbosity_silent`.

This is a reasonable approach.

> The only changes since v13 are in 37/41. The name of the first
> argument to mute_routine() is changed from "bla" to "msg" as suggested
> by Ramsey, and the commit message is improved as suggested by Stefan.

;-)

>   - Patch 40/41 was in v12 and v13, and hasn't changed.
>
> It adds a "const char *index_file" into "struct apply_state", to make
> it possible to use a special index file instead of the default one.

Looks sensible.
