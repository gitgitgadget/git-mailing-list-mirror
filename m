Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82B181FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 12:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbdJFMJc (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 08:09:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51411 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751901AbdJFMJb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 08:09:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 426E8A1AD1;
        Fri,  6 Oct 2017 08:09:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VQA/lY0WgUfp
        Hpmno/lKkjWrqdw=; b=nox9oBPdCdK06XxvJhyne6bThN4REaO5ZXUYIC/Hi1Wc
        pCDOJhwOdPrKt7CiUg+Q+N7VMGoqu3HBqEQa6jUEJfJZLHUO3MgGuIINxde+gURO
        5XuDxf5FFPPLmQW+sZRwXXrQ1D3LuIsoEKrFPsmyfKzG8+UewwC/6nmD6MacNoU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=De1OJY
        Z3K8zr9/5uO95tPdWk6Q4QG2qc6w1H4eadYNjeSHs2vIoda/xZ1cZZ1Da1lBMDnq
        5z6ZbDzIcIXtUx3jYhd/5NeNC9vF8YQyBDy95S9HHza3pGnRnKOtyrdYqJFi7a+4
        SDf55egcc7buJeGZxPV1w+d4jQxJNMMGxgvI4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 39A13A1AD0;
        Fri,  6 Oct 2017 08:09:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A0AAA1ACF;
        Fri,  6 Oct 2017 08:09:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Simon Ruderich <simon@ruderich.org>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        bturner@atlassian.com, Jeff Hostetler <git@jeffhostetler.com>,
        jonathantanmy@google.com, Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 03/10] protocol: introduce protocol extention mechanisms
References: <20170926235627.79606-1-bmwill@google.com>
        <20171003201507.3589-1-bmwill@google.com>
        <20171003201507.3589-4-bmwill@google.com>
        <20171006090907.gbsgygulzj3bgqrg@ruderich.org>
        <xmqq4lrcwr5c.fsf@gitster.mtv.corp.google.com>
        <CAN0heSrWekXdzqzhL3Lk37YOGPHUdKCDU85t3hJgqK7PSVBZ_g@mail.gmail.com>
Date:   Fri, 06 Oct 2017 21:09:29 +0900
In-Reply-To: <CAN0heSrWekXdzqzhL3Lk37YOGPHUdKCDU85t3hJgqK7PSVBZ_g@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Fri, 6 Oct 2017 13:11:50
 +0200")
Message-ID: <xmqqr2ugv5om.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 35177E94-AA8F-11E7-8CB8-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Maybe I'm missing something Git-specific, but isn't the only thing that
> needs to be done now, to document/specify that 1) the client should sen=
d
> its list ordered by preference, 2) how preference is signalled, and 3)
> that the server gets to choose?

I think Simon's reminder of Stefan's was about specifying something
different from (1) above---it was just a list of good ones (as
opposed to ones to be avoided).  I was suggesting to tweak that to
match what you wrote above.

> Why would a server operator with only v0 and v1 at their disposal want
> to choose v0 instead of v1, considering that -- as far as I understand
> -- they are in fact the same?

Because we may later discover some reason we not yet know that makes
v$n+1 unsuitable after we introduce it, and we need to avoid it by
preferring v$n instead?
