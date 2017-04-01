Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2748E20958
	for <e@80x24.org>; Sat,  1 Apr 2017 18:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751855AbdDASYn (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 14:24:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56887 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751791AbdDASYn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 14:24:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 35AF16B505;
        Sat,  1 Apr 2017 14:24:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Rl6qjzXh5l8k
        c+PYL1t3vyQgv6o=; b=vdqbIpYJwVUadZ53Z3+vfaLYhkvXk1sDdQ2vhT8uC546
        mlBQdcUEbu8SBHlPVKqE9USYK1vV5ZQ2G5/MTOylQCz4MfKI5FTnYTkLS4gYjZws
        suofgCAkNRagYouc6DmMueV44ao0pRzUoYPpmQ3OsQJmUB3/qnabl78GRSQHDfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=K/JlO9
        F08f3JThzZJ/uPOQupPt/hZt2YZ/7ngvOjoZQLVjpHLDmTPA41P6tJp7mgbq9t/W
        W5DxB2Uc03jj50HYXnddqb5SSTCXuOR++BMURujD3/3twh8I+UVM6QXFj7ZVx31N
        YV8UPITbzivtHpsGdkBerSL9mA+RivZmyMmiI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F0706B504;
        Sat,  1 Apr 2017 14:24:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 54FD96B503;
        Sat,  1 Apr 2017 14:24:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>
Subject: Re: Very promising results with libpcre2
References: <CACBZZX6FcHcY7cYs6s_pv=E43cHNmzyUY5wrcuhPWWmUixCL+g@mail.gmail.com>
        <xmqqtw69vz9t.fsf@gitster.mtv.corp.google.com>
        <CACBZZX416M3YFDAACGAWCjJ4Xt0g78zpFF+iusMCarKb7SSfVw@mail.gmail.com>
Date:   Sat, 01 Apr 2017 11:24:39 -0700
In-Reply-To: <CACBZZX416M3YFDAACGAWCjJ4Xt0g78zpFF+iusMCarKb7SSfVw@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 1 Apr
 2017 10:55:11
        +0200")
Message-ID: <xmqqbmsgugt4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 78E66722-1708-11E7-81A5-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sat, Apr 1, 2017 at 12:48 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> That enables the new JIT support in pcre v2:
>>>
>>>       s/iter    rx fixed   prx
>>> rx      2.19    --  -33%  -44%
>>> fixed   1.47   49%    --  -17%
>>> prx     1.22   79%   20%    --
>>
>> The numbers with JIT does look "interesting".
>>
>> I couldn't quite tell if there are major incompatibilities in the
>> regex language itself between two versions from their documentation,
>> but assuming that there isn't (modulo bugfixes and enhancements) and
>> assuming that we are going to use their standard matcher, it may be
>> OK to just use the newer one without linking both.
>
> There's no incompatibilities in the regex language itself (modulo bugs
> etc). So yeah, I'll prepare some patch to use v2.

Just to make sure that we are on the same page.  While I do not see
the need to link with both variants and allow users to choose
between them at runtime, I do not know if the whole world is ready
to drop pcre1 and use pcre2 (the latter of which has only been
around for a bit over two years).

So we'd probably want to do=20

 (1) keep USE_LIBPCRE and enable v1 when set;
 (2) add USE_LIBPCRE2 and enable v2 when set;
 (3) make sure to error out when both are set.

or something like that.  It is tempting to allow us to say

    make USE_LIBPCRE=3D2

but the existing builds are likely to be depending on "is it set to
anything? then use PCRE1" behaviour, so we unfortunately cannot take
that route.

Thanks.
