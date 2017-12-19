Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17CD61F428
	for <e@80x24.org>; Tue, 19 Dec 2017 15:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751196AbdLSPxx (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 10:53:53 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57810 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750983AbdLSPxv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 10:53:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C4B9D3764;
        Tue, 19 Dec 2017 10:53:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=P4ABQihJSur3
        sv9K5w6aAmTSnW8=; b=Bg5a5AI4CqOs/bUSZI7r9dhOPblIUJ8Q2J7b5GYthHmi
        2nF5+wsMke8bBTV6oW5Otl1wGDsdeU+NemoiQTTloNfgsKHygEo36CWLpljpG8zJ
        gySqPkoTIYwMWQUeuEZEEA0BSJQMmOsD3z2veGFAokhNb4r9cX3rQYnfHjt21VA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=v7vAg1
        SCtXD3G+YzgV0/wrMX0QJQzXCwSNx4E7gbusR2AUJ36M7QHGE7KSETXlzazQ7yta
        dD55INaxQHmuEuPvwuNTTTjKu2K5tRohbHKpb0xzQvxT+NKFyA2ZbsM2eYp4s1Pf
        C78lyI3bshZNzGmK+BbAzcnlt6jBvWK4MPO0I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 61DEBD3763;
        Tue, 19 Dec 2017 10:53:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA4E0D3762;
        Tue, 19 Dec 2017 10:53:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Michael J Gruber <git@grubix.eu>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Alex Riesen <alexander.riesen@cetitec.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Casey <drafnel@gmail.com>, Petr Baudis <pasky@ucw.cz>,
        Gerrit Pape <pape@smarden.org>,
        "martin f . krafft" <madduck@madduck.net>, Eric Wong <e@80x24.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Joachim Schmitz <jojo@schmitz-digital.de>,
        Bill Honaker <bhonaker@xid.com>
Subject: Re: [PATCH v3] Makefile: replace perl/Makefile.PL with simple make rules
References: <20171129195430.10069-1-avarab@gmail.com>
        <20171210211333.9820-1-avarab@gmail.com>
        <003f01d37390$ed0e0440$c72a0cc0$@nexbridge.com>
        <87a7ynd1ml.fsf@evledraar.gmail.com>
        <b8b4534f-1eda-ee52-faed-ec5188c2ad35@grubix.eu>
        <CACBZZX4ZqVm2HnAbKjdZV=95gq4s7b=gycH3x-sd+zJiWEgDfg@mail.gmail.com>
Date:   Tue, 19 Dec 2017 07:53:48 -0800
In-Reply-To: <CACBZZX4ZqVm2HnAbKjdZV=95gq4s7b=gycH3x-sd+zJiWEgDfg@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 15 Dec
 2017 18:31:51
        +0100")
Message-ID: <xmqqy3lyww6r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CE0B0182-E4D4-11E7-84C3-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Is there anything I'm supposed to do differently now to make our test
>> suite run? If yes then a clear and short hint in the patch description
>> would me more than approriate.
>
> This is a bug in my patch, I can reproduce it on CO7. Will figure out
> what's going on there...

Thanks.
