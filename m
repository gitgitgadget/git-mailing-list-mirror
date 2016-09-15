Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E21F42070F
	for <e@80x24.org>; Thu, 15 Sep 2016 21:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756043AbcIOVjT (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 17:39:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51705 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755223AbcIOVjS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 17:39:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B71B33E024;
        Thu, 15 Sep 2016 17:39:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UcPJnTg9rbcI
        THrneNf9RtaVRC0=; b=PyxpBZAkcYD8yTAEQF2bWAqDjl3UFyCw+7j9pc7O68k2
        Bzt11ibkx8MLVOyUU2QOiAmgE6BpNZEjZedXDHXLG72doJ+NC2c+SkD4dvBzcqkp
        LO8M9Q/jDAW7PhPeQXrBDOsipdBEWo6gZkKCDiL1DErEh0LBJ+nNJNAEbnZEF1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=cmT1wP
        C087HlIL68hl86wYMGh9pG46vOmf5EYwdArQGqx0NASgLkT77BIdk+qxCGr/pX0q
        1KAi+YnwjVDpG8aGl2UGRxwwD4Hf8LlARA14FtPxEH92oB+OOGpDKnABT6cdORGc
        MYJwX9TGa94b6bR2oHh0wbW5cCRVpd6pOC1Rk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF4543E023;
        Thu, 15 Sep 2016 17:39:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 353403E022;
        Thu, 15 Sep 2016 17:39:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] use strbuf_addstr() for adding constant strings to a strbuf, part 2
References: <f7294ac5-8302-03fb-d756-81a1c029a813@web.de>
        <20160915184448.awipvg2kmlq7weei@sigill.intra.peff.net>
        <xmqqbmzpnex4.fsf@gitster.mtv.corp.google.com>
        <20160915193804.d2mmmeard2rj6vye@sigill.intra.peff.net>
        <79f6cfb5-3b9b-2ae7-d9a3-5c1c65c7d4cf@web.de>
        <xmqq7fadnd9s.fsf@gitster.mtv.corp.google.com>
        <67756074-836f-2238-37c3-0d186325bd00@web.de>
Date:   Thu, 15 Sep 2016 14:39:14 -0700
In-Reply-To: <67756074-836f-2238-37c3-0d186325bd00@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 15 Sep 2016 23:25:55 +0200")
Message-ID: <xmqqwpiclu65.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D9DF066E-7B8C-11E6-B2DF-5D827B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 15.09.2016 um 22:01 schrieb Junio C Hamano:
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>=20
>>> Take this for example:
>>>
>>> -			strbuf_addf(&o->obuf, _("(bad commit)\n"));
>>> +			strbuf_addstr(&o->obuf, _("(bad commit)\n"));
>>>
>>> If there's a language that uses percent signs instead of parens or as
>>> regular letters, then they need to be escaped in the translated strin=
g
>>> before, but not after the patch.  As I wrote: silly.
>>=20
>> Ahh, OK, so "This use of addf only has format part and nothing else,
>> hence the format part can be taken as-is" which is the Coccinelle rule
>> used to produce this patch is incomplete and always needs manual
>> inspection, in case the format part wanted to give a literal % in
>> the output.  E.g. it is a bug to convert this
>>=20
>> 	strbuf_addf(&buf, _("this is 100%% wrong!"));
>>=20
>> to
>>=20
>> 	strbuf_addstr(&buf, _("this is 100%% wrong!"));
>
> Right.  Such strings seem to be quite rare in practice, though.=20
>
>> Thanks for clarification.  Perhaps the strbuf.cocci rule file can
>> have some comment to warn the person who builds *.patch file to look
>> for % in E2, or something?
>
> Something like this?

Yup, with something like that I would understdood where that
puzzling question came from.

Thanks.

>
> ---
>  contrib/coccinelle/strbuf.cocci | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbu=
f.cocci
> index 7932d48..3f535ca 100644
> --- a/contrib/coccinelle/strbuf.cocci
> +++ b/contrib/coccinelle/strbuf.cocci
> @@ -1,3 +1,5 @@
> +// Careful, this is not fully equivalent: "%" is no longer treated
> +// specially.  Check for "%%", "%m" etc. in the format string (E2).
>  @@
>  expression E1, E2;
>  @@
