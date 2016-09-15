Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B94F22070F
	for <e@80x24.org>; Thu, 15 Sep 2016 19:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753409AbcIOTZs (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 15:25:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64127 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752936AbcIOTZr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 15:25:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A02703C418;
        Thu, 15 Sep 2016 15:25:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tbSClzqPjOFK
        l815Tb9ft62TA6E=; b=L8nG6y1C8EnRCJQ8kQUpKa3eUhFzxNmvf1pVOq1Qft0S
        9qglwN52kP6Y0EZ070Kgbl7Y/T/5l1qA6AsixAoEX/kASOXnCwuNhdPieCdACA3i
        Eg7sxP3kKO6r1rZJ1UdvjjU0VhDK5e8ovT8SDb1E4RBEnBzmGlNAjckSp+vyyIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=HAGEHY
        LjASzpx5wWbFFFGKOcAajfxeTfKf/K+DGZE379TbEb2cyvzfMknbW6AqqVJCcz/f
        gZe6Xbs8r/wRVpaoJ8GCqr3rBhiQS2dxvkg8Jp9gcRQOGdbcKe6BDKsWvu9V5TKx
        Zek8k4yQ5dR4M1U6ygVsZi2HFe7xZ2aA2ZNyU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 969CB3C416;
        Thu, 15 Sep 2016 15:25:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 216823C415;
        Thu, 15 Sep 2016 15:25:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] use strbuf_addstr() for adding constant strings to a strbuf, part 2
References: <f7294ac5-8302-03fb-d756-81a1c029a813@web.de>
        <20160915184448.awipvg2kmlq7weei@sigill.intra.peff.net>
Date:   Thu, 15 Sep 2016 12:25:43 -0700
In-Reply-To: <20160915184448.awipvg2kmlq7weei@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 15 Sep 2016 11:44:48 -0700")
Message-ID: <xmqqbmzpnex4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 32E53AB6-7B7A-11E6-958D-92D512518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Sep 15, 2016 at 08:31:00PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Replace uses of strbuf_addf() for adding strings with more lightweight
>> strbuf_addstr() calls.  This makes the intent clearer and avoids
>> potential issues with printf format specifiers.
>>=20
>> 02962d36845b89145cd69f8bc65e015d78ae3434 already converted six cases,
>> this patch covers eleven more.
>
> Great, these all look obviously correct.

Yes.

>> Silly question: Is there a natural language that uses percent signs
>> as letters or e.g. instead of commas? :)
>
> I don't know, but if they do, they'd better get used to escaping them.
> :)

I do not know either, but I am curious where that question comes
from.  I stared at this patch for a few minutes but couldn't guess.
