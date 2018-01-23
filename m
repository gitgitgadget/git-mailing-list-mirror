Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D51B21F404
	for <e@80x24.org>; Tue, 23 Jan 2018 18:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeAWSeL (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 13:34:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54694 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752302AbeAWSeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 13:34:09 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E973C5B60;
        Tue, 23 Jan 2018 13:33:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Lh0nolXtJYhSkwi81icjdmi1YIA=; b=EA5kxi
        jP1eZ4EjHP2GD65EopribEih2P8iw8cbsawq3c2Fv3XUMnpzcmbR/HKwjR75LuEU
        UF64gajkL7qxPfsiABptIx6oXC52QB/TNW3VGN9vlBbULAMD9NKLrk2AIx/tz2dA
        5u9Oy04chwiVLQXDBrSTUH1IQ41BcZ1G/MEdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OlIqe5pqkqVYXRzPEW3AOTLUt3R2nI46
        slL3gjAjatFeFFIGW3E5nJ0sNTeE7OhXiB8MjEtuod7qORW2ll43aNyGc86fXPQG
        pU/3Ip5hJTFVMk9XiWrxIa1EMglxdClbMiL6mDwzPlLppOzkYKgDXmUAB13ifSiK
        M/e/n5FoF7g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6654CC5B5F;
        Tue, 23 Jan 2018 13:33:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D0169C5B5E;
        Tue, 23 Jan 2018 13:33:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Fixes compile warning with -Wimplicit-fallthrough CFLAGS
References: <1516665078-107974-1-git-send-email-gitter.spiros@gmail.com>
        <20180123000727.GB26357@sigill.intra.peff.net>
Date:   Tue, 23 Jan 2018 10:33:57 -0800
In-Reply-To: <20180123000727.GB26357@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 22 Jan 2018 19:07:28 -0500")
Message-ID: <xmqqd120ifvu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9E2B784-006B-11E8-A1C6-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> diff --git a/apply.c b/apply.c
>> index 321a9fa68..a22fb2881 100644
>> --- a/apply.c
>> +++ b/apply.c
>> @@ -1450,7 +1450,7 @@ static void recount_diff(const char *line, int size, struct fragment *fragment)
>>  		switch (*line) {
>>  		case ' ': case '\n':
>>  			newlines++;
>> -			/* fall through */
>> +			GIT_FALLTHROUGH;
>
> Ugh, the semi-colon there makes it look like it's actual code. If we go
> this route, I wonder if it's worth hiding it inside the macro.

What?  You mean to shout in all caps without even terminating the
line with any punctuation?  Please don't---I am sure it will break
auto indentation people rely on from their editors.

