Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3BBB1F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 17:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754010AbdCBRoT (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 12:44:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51052 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751756AbdCBRoG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 12:44:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B34380F5B;
        Thu,  2 Mar 2017 12:07:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Bsf64OZ19pN11j99EORmZOu0szs=; b=UaMXcs
        caB8Qv/Q12eteNyEWT3QvnoVvRqLPmrORlm25uKoAd7O6omn+S4jAl8mTIRG8AyB
        SWvmPAZTsogkU1bu35XP23Lv2/hRuCUJWSDPVzVO12VasA6I3YI1Z2JEgf0qtJHL
        4uWkGtFjIOblD+bUcoNENXNVa1c7QEgvwJbc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dZEzqdw6rqWg+H6dMnuYna6r/Ng8n3gH
        5zIf6dbwyKX5mr8HyJqN3f+7dYM5dFZ+QRWibc1ncn92A7oKmuTc3FlYbdxgBCDu
        lX6JUOPkYIIMu6tvTc6eSyZubJVhbWMHocuQMDzRAmSy0HPrnCUXFT4BnpdudpDe
        2G+7Pyvm20Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8375180F5A;
        Thu,  2 Mar 2017 12:07:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E0AB980F59;
        Thu,  2 Mar 2017 12:07:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] mingw: use OpenSSL's SHA-1 routines
References: <6a29f8c60d315a24292c1fa9f5e84df4dfdbf813.1486679254.git.johannes.schindelin@gmx.de>
        <20170210050237.gajicliueuvk6s5d@sigill.intra.peff.net>
        <alpine.DEB.2.20.1702101647340.3496@virtualbox>
        <20170210160458.pcp7mupdz24m6cms@sigill.intra.peff.net>
        <9913e513-553e-eba6-e81a-9c21030dd767@kdbg.org>
        <xmqqmvdbz23d.fsf@gitster.mtv.corp.google.com>
        <fa38e22e-3114-fab8-38ed-5f52125e81bb@kdbg.org>
Date:   Thu, 02 Mar 2017 09:07:53 -0800
In-Reply-To: <fa38e22e-3114-fab8-38ed-5f52125e81bb@kdbg.org> (Johannes Sixt's
        message of "Thu, 2 Mar 2017 07:07:22 +0100")
Message-ID: <xmqqshmvd2ty.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6DCF3C0-FF6A-11E6-852C-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 24.02.2017 um 22:54 schrieb Junio C Hamano:
>> Johannes Sixt <j6t@kdbg.org> writes:
>>> I'll use the patch for daily work for a while to see whether it hurts.
>>
>> Please ping this thread again when you have something to add.  For
>> now, I'll demote this patch from 'next' to 'pu' when we rewind and
>> rebuild 'next' post 2.12 release.
>
> ... I've used the patch in
> production for some time now and did not notice any slowdowns.

Thanks.  Dscho obviously thinks this is the right thing for Windows,
and you agree.  That's more than sufficient votes to make me feel
safe ;-)

Thanks.
