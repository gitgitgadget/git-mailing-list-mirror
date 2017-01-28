Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82DC61F437
	for <e@80x24.org>; Sat, 28 Jan 2017 01:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750789AbdA1BBu (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 20:01:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56025 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750767AbdA1BBt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 20:01:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DDF4463471;
        Fri, 27 Jan 2017 19:27:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ForlLAJVEfZpdYdCHRjfO8JkaMA=; b=Orjtk8
        SyXobd4x16mZ7edhcepV5s/l9mabwfBluEFTcnBgxbRqSK40OzhHqm2A53ekyzMD
        D1v8i36Qcr1grTZBlmD7ffB04ZsAiFtqQy/yoVkzJ65fpt7c3JLrupUSNjv5idnP
        RJDOsJo1X9X8xlHwAhligsX+ElxIJPJUIFMu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VFZRrdrLgfz21HAENglH5WRQ1r2rE15a
        xTWN1qU7JPJRT56svGVM3w207MEJqiJ2+Ee5ykaEocF2hLGZ5EGkCq1WPz5Prh0t
        mzBiQQ6nwWs2WRs2pvL1pczLdsPSXv+tq+gc8U55R6LUgfbRWllU2T82/fT1uB8K
        zIJUYkGs5QA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D38C463470;
        Fri, 27 Jan 2017 19:27:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 31D706346C;
        Fri, 27 Jan 2017 19:27:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/2] pack-objects: enforce --depth limit in reused deltas
References: <20170127220143.boo5phhgogqlucsj@sigill.intra.peff.net>
        <20170127220233.mwg36mgxdklwz7lr@sigill.intra.peff.net>
        <xmqqinp0xep3.fsf@gitster.mtv.corp.google.com>
        <20170128000959.l7aztgu46ytkhmk3@sigill.intra.peff.net>
Date:   Fri, 27 Jan 2017 16:27:29 -0800
In-Reply-To: <20170128000959.l7aztgu46ytkhmk3@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 27 Jan 2017 19:09:59 -0500")
Message-ID: <xmqq60l0xc3y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8DB6662E-E4F0-11E6-BBD1-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> > +#    On the receiving end, "index-pack --fix-thin" will
>> > +#    complete the pack with a base copy of tree X-1.
>> 
>> blob? tree? I think the argument would work the same way for either
>> type of objects, but the previous paragraph is using blob as the
>> example, so s/tree/blob/ here?
>
> Oops, yes. I had originally sketched out the example to use trees, but
> it was easier to assemble with blobs so I switched (I never actually dug
> into my "wild" case to see what it was segfaulting on, but I agree it
> applies equally well to either).

OK, then I'll squash in s/tree/blob/ here, in addition to the "my"
thing.  Thanks.
