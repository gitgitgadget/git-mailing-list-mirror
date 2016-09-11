Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 804A81FCA9
	for <e@80x24.org>; Sun, 11 Sep 2016 23:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756076AbcIKXae (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 19:30:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53954 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756044AbcIKXac (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 19:30:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 411993C018;
        Sun, 11 Sep 2016 19:30:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CRksQ4AhVOMB
        tth6EN165qkf4o0=; b=cCFhRrdieaO2HG6bDsz2/STDZc7o5H3LiwSpFGWAt5Iv
        jooSTZZcPbAhtGI+RPhdp216A6AtBugNzIdQtB5gRQIvCP++efSROsIvd+tBWAic
        fhVJpUmXN5m8bfw7+Sq8qPVv1DpPoukU/VMZYD1KU04vbCFq079wowr6P8LX5y4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=r4LA/a
        svzRQrpa9+Hjt2HHcZm5/hvIeozNRKeQXYPca5M5qY39m+Pg104XflXL2r/beq6h
        I4A4omnaGMdLBlGQ6Y1sY0i2zN3DxOSdZGs8siBfuUGzgeWw0076hft39teUqZVX
        CC3xIfAPe3v+NOI7Zdxed5MuTqINMfjZhjmBA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 375343C017;
        Sun, 11 Sep 2016 19:30:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B5E6B3C015;
        Sun, 11 Sep 2016 19:30:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 25/25] sequencer: remove bogus hint for translators
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <cover.1473590966.git.johannes.schindelin@gmx.de>
        <8314699c144c258ca45094beef5953b612eb7f15.1473590966.git.johannes.schindelin@gmx.de>
Date:   Sun, 11 Sep 2016 16:30:28 -0700
In-Reply-To: <8314699c144c258ca45094beef5953b612eb7f15.1473590966.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Sun, 11 Sep 2016 12:56:00 +0200
        (CEST)")
Message-ID: <xmqqa8fe6mln.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BA8C9DDE-7877-11E6-A96D-51057B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> When translating error messages, we need to be careful *not* to transla=
te
> the todo commands such as "pick", "reword", etc because they are comman=
ds,
> and Git would not understand translated versions of those commands.
>
> Therefore, translating the commands in the error messages would simply =
be
> misleading.

This comes from b9c993e0 ("i18n: git-revert literal "me" messages",
2011-02-22) where it said

Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

    i18n: git-revert literal "me" messages
   =20
    Translate messages that use the `me' variable. These are all error
    messages referencing the command name, so the name shouldn't be
    translated.
   =20
    Reported-by: Jonathan Nieder <jrnieder@gmail.com>
    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

This looks like a positive attempt to remind translators that their
translation must flow with these literal command names that will not
get translated in place, not a bogus hint at all, at least to me.

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 465e018..cdff0f1 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -697,8 +697,6 @@ static int do_pick_commit(enum todo_command command=
, struct commit *commit,
>  		return fast_forward_to(commit->object.oid.hash, head, unborn, opts);
> =20
>  	if (parent && parse_commit(parent) < 0)
> -		/* TRANSLATORS: The first %s will be "revert" or
> -		   "cherry-pick", the second %s a SHA1 */
>  		return error(_("%s: cannot parse parent commit %s"),
>  			command_to_string(command),
>  			oid_to_hex(&parent->object.oid));
