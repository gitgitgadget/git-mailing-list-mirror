Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 299A31F461
	for <e@80x24.org>; Mon,  8 Jul 2019 18:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbfGHSbD (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 14:31:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51169 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730629AbfGHSbC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 14:31:02 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 35A5814C55A;
        Mon,  8 Jul 2019 14:30:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=T3XqaHt1WBjS
        vArlpoeXEzBd0d0=; b=oUiUeocYqdEt7t2n6AhDxKQTzGAK1UhOdQJH8EFP3rAM
        +QIRCw3vmdyEOsmF+Vbx5FpvY/+yv7X4J8KgXMFkts0TRsGWK57ZYfiZ10jh57uz
        2BUKolsAnOO/na3LgrnlKYKQQwmjpaSdCXoH7xOSVrAde9RZGnXUcEbF3d520JE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KAHvx3
        wOzUGbz/y4JSrC/iIJ6fK31XxiXIGh5wsSyBI2xJ6pC+au5pNBfWW65Z1i8WvaGJ
        b6GiMou5bxAIgbffV4rAuJgxLVVCVFldoFiFFgp90SrtvDDkFLzoZHKAwe/TMRR3
        GaQ7//H09T0EP17xzUkvlVW0P5EdPXWnxKVMY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A0EF14C559;
        Mon,  8 Jul 2019 14:30:59 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8DA0314C558;
        Mon,  8 Jul 2019 14:30:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Karsten Blees via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Karsten Blees <blees@dcon.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/1] gettext: always use UTF-8 on native Windows
References: <pull.217.git.gitgitgadget@gmail.com>
        <pull.217.v2.git.gitgitgadget@gmail.com>
        <2d2253faef14e5157f8aac4534d9ac9640f3d5fa.1562186762.git.gitgitgadget@gmail.com>
        <87o92976nz.fsf@evledraar.gmail.com>
Date:   Mon, 08 Jul 2019 11:30:57 -0700
In-Reply-To: <87o92976nz.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 05 Jul 2019 00:53:52 +0200")
Message-ID: <xmqq8st8z8da.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 87C83EAE-A1AE-11E9-B200-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> -#	ifdef HAVE_LIBCHARSET_H
>> +#	ifdef GIT_WINDOWS_NATIVE
>> + ... new windows-only code ...
>> +#	elif defined HAVE_LIBCHARSET_H
>>  #		include <libcharset.h>
>>  #	else
>>  #		include <langinfo.h>
> ...
> It looks to me that with this patch the HAVE_LIBCHARSET_H docs in
> "Makefile" become wrong. Shouldn't those be updated too?

I do not think this change has much to do with HAVE_LIBCHARSET_H; it
inserts "regardless of what we have been doing, do this new thing
only and always on windows (persumably '... because libcharset would
not be useful on that platform')". =20

Existing users of HAVE_LIBCHARSET_H and existing non-windows users
that did not use HAVE_LIBCHARSET_H are not affected, and whatever
Makefile documents the macro as still applies to them.

> I wonder if it wouldn't be better to always compile this function, and
> just have init_gettext_charset() switch between the two. We've moved
> more towards that sort of thing (e.g. with pthreads). I.e. prefer
> redundant compilation to ifdefing platform-only code (which then only
> gets compiled there). See "HAVE_THREADS" in the code.

OK, so init_gettext_charset() is the only caller of locale_charset()
in our codebase, and we supply our own locale_charset() if we do not
have <libcharset.h>, either with nl_langinfo(), or with the code
introduced by the patch in question for windows.  Your suggestion is
to add a block of #ifdef cascade in init_gettext_charset() to call
locale_charset(), nl_langinfo(), or the windows-only code (perhaps
inlined right there)?

I am not sure.  We'd need the conditional inclusion of header files
depending on HAVE_LIBCHARSET_H etc. anyway, so...
