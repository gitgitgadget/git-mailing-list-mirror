Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A77820964
	for <e@80x24.org>; Sun,  2 Apr 2017 03:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750841AbdDBDpM (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 23:45:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64037 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750792AbdDBDpM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 23:45:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F00E06F01F;
        Sat,  1 Apr 2017 23:45:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=59J+bhE1kfvY
        YDsd0e503D0DN5k=; b=QaPOu8+ppezuCiNlJNw3YBsPJQgSDnhwz6D9CFCuGlsg
        aWRlP8msBpUVrCfHhdthGSZZpvULJH7Y3lT8yyQa8EpIEYipEE+ppm0oqQPxo/Kq
        YEDQq1dnb1InXtDnG4mxxu+R6/wobFVd58g1b4tm4fWn35fWaWEAI73fufd2K6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NN45IR
        msXHVqSCOxyt3X+WQqvNjbxBEPr6q48A3INTUHpYhkUSRfS6me/PwJvC/pDswQ1J
        12pf1wyPZMghIhsoL3uxMpn5Os1Y6FC1NOERlc/0g9EjE6eVoYbGjiTwzlmBNTTg
        sCRCyuPZEQRobXFbcde42ZGQSSOuLDy/yO4eU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E65FB6F01E;
        Sat,  1 Apr 2017 23:45:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 579206F01D;
        Sat,  1 Apr 2017 23:45:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: Very promising results with libpcre2
References: <CACBZZX6FcHcY7cYs6s_pv=E43cHNmzyUY5wrcuhPWWmUixCL+g@mail.gmail.com>
        <xmqqtw69vz9t.fsf@gitster.mtv.corp.google.com>
        <CACBZZX416M3YFDAACGAWCjJ4Xt0g78zpFF+iusMCarKb7SSfVw@mail.gmail.com>
        <xmqqbmsgugt4.fsf@gitster.mtv.corp.google.com>
        <CAH8yC8mxdNFdpo0ZO0+XpnuHGTpp2NCiMCSE71j2Emt8-NRYDg@mail.gmail.com>
Date:   Sat, 01 Apr 2017 20:45:09 -0700
In-Reply-To: <CAH8yC8mxdNFdpo0ZO0+XpnuHGTpp2NCiMCSE71j2Emt8-NRYDg@mail.gmail.com>
        (Jeffrey Walton's message of "Sat, 1 Apr 2017 19:33:26 -0400")
Message-ID: <xmqqd1cvtquy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C559FB2A-1756-11E7-9E9E-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeffrey Walton <noloader@gmail.com> writes:

>> Just to make sure that we are on the same page.  While I do not see
>> the need to link with both variants and allow users to choose
>> between them at runtime, I do not know if the whole world is ready
>> to drop pcre1 and use pcre2 (the latter of which has only been
>> around for a bit over two years).
>>
>> So we'd probably want to do
>>
>>  (1) keep USE_LIBPCRE and enable v1 when set;
>>  (2) add USE_LIBPCRE2 and enable v2 when set;
>>  (3) make sure to error out when both are set.
>>
>> or something like that.  It is tempting to allow us to say
>>
>>     make USE_LIBPCRE=3D2
>>
>> but the existing builds are likely to be depending on "is it set to
>> anything? then use PCRE1" behaviour, so we unfortunately cannot take
>> that route.
>
> Yeah, that's the question I kinda had.
>
>> make USE_LIBPCRE=3D2
>
> I'd prefer a configure option for consistency. Maybe:
> ...

It is way too early to worry about how ./configure support for this
will look like to the end user.

Because our Makefile is designed to be usable without configure, the
order we do things will be to first decide how we are going to use
Makefile variables to configure the feature (i.e. what you saw that
I said to =C3=86var).

Once we know the decision, then we arrange autoconf to spit out the
chosen Makefile variables using --with-pcre or whatever input.  This
step cannot start before we know the decision of the former.  The
one who writes --with-pcre support in ./configure would not know if
USE_LIBPCRE=3DYesPlease or something else is the desired output until
then.

