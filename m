Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 203822070F
	for <e@80x24.org>; Thu, 15 Sep 2016 20:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754545AbcIOUY1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 16:24:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63697 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754512AbcIOUY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 16:24:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 20A1D3D215;
        Thu, 15 Sep 2016 16:24:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RRmKOaCjCgelwI4e1TBNe6yO8d0=; b=iqq8Bw
        dIQyQWmH48LRlG4EDgQcZk37o3DHzEqSW+a8M1HSQaoG3XxOHHkyVVw2MBIqXxJd
        KYpftqKb9S35XrWpvvpAhTDtBxP7lvwQvEWFMWTJY1Igun7sZUMJWlXWCODPI4PS
        M0rcYCeSe4qcmZeRMdiDBe747LoJ/UxIAYeLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kiEMgGqg2sRh8w7BNKATxkfp5p97li4y
        Bzfjm8n7RwAZGnosJrcxZfDIdyKLcmcgKgpzQ2obu/yHalI0WTqq0dlWJS20Gj3B
        lOAfGqLU5N/rkT1ybvWch7WJLrRDptSzN6UbY7bYHurkEqhELRLCwtsShRR1019O
        YXBcfipIslY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1987D3D214;
        Thu, 15 Sep 2016 16:24:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9573D3D213;
        Thu, 15 Sep 2016 16:24:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>, peff@peff.net,
        sbeller@google.com, Johannes.Schindelin@gmx.de, jnareb@gmail.com,
        mlbright@gmail.com, tboegi@web.de, jacob.keller@gmail.com
Subject: Re: [PATCH v7 10/10] convert: add filter.<driver>.process option
References: <20160908182132.50788-1-larsxschneider@gmail.com>
        <20160908182132.50788-11-larsxschneider@gmail.com>
        <xmqq8tuvx1sz.fsf@gitster.mtv.corp.google.com>
        <928655D2-312B-4805-99DB-E73448232B9A@gmail.com>
Date:   Thu, 15 Sep 2016 13:24:22 -0700
In-Reply-To: <928655D2-312B-4805-99DB-E73448232B9A@gmail.com> (Lars
        Schneider's message of "Thu, 15 Sep 2016 22:16:41 +0200")
Message-ID: <xmqqpoo4nc7d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64B48FB2-7B82-11E6-9AF5-46717A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 13 Sep 2016, at 17:22, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> larsxschneider@gmail.com writes:
>> 
>>> diff --git a/contrib/long-running-filter/example.pl b/contrib/long-running-filter/example.pl
>>> ...
>>> +packet_write( "clean=true\n" );
>>> +packet_write( "smudge=true\n" );
>>
>> These extra SP around the contents inside () pair look unfamiliar
>> and somewhat strange to me, but as long as they are consistently
>> done (and I think you are mostly being consistent), it is OK.
>
> Ups. I forgot to run PerlTidy here. I run PerlTidy with the flag 
> "-pbp" (= Perl Best Practices). This seems to add no extra SP for
> functions with one parameter (e.g. `foo("bar")`) and extra SP
> for functions with multiple parameter (e.g. `foo( "bar", 1 )`).
> Is this still OK?

Your choice.  I already said I do not care too much either way as
long as you are consistent.

If you prefer PerlTidy's PBP output over what you wrote, and if you
are resending the patch anyway, then why not? ;-)

> Does anyone have a "Git PerlTidy configuration"?

Not me.

Thanks.
