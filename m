Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91C142036B
	for <e@80x24.org>; Sun,  8 Oct 2017 01:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753231AbdJHBqo (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Oct 2017 21:46:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59873 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750981AbdJHBqo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Oct 2017 21:46:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 72ACEAA245;
        Sat,  7 Oct 2017 21:46:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0hG862e97lH4CL8i945tXYdQVJI=; b=qdcqZG
        hQhTvIg3Zx5FIsbCIp+C6MA4NcsGlJPEN5ZYOQjec+ku7CRBZDGSuloZLaq6Pj5T
        IAN/B8cmL48vopVh+72FrTXA+HuHSpIX4kMpoIKwVvXuIusvJKadoN7Qd73UNq1t
        KxYdbu8OrBONDhZQc8ADJwcWpy/vh4CgbFRXw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oFk0DPqGsfuIJvV0AqaODjbiE4TborGN
        OLH5HSbqLC7hJZX0BAtSCxswbDs811FPikzyg/43uX9aSYUZ4ol5omA6OcKOzmhu
        KXnh7yYHi44BdCcA9J3cITKlBeDJlMcVPVzja9Ne7Oed+Mcarj7Yz5R41gmhfFZL
        Inj/DTeXWX0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6AAC6AA244;
        Sat,  7 Oct 2017 21:46:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D4E21AA243;
        Sat,  7 Oct 2017 21:46:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH v2 1/5] test-list-objects: List a subset of object ids
References: <20170925095452.66833-1-dstolee@microsoft.com>
        <20170925095452.66833-2-dstolee@microsoft.com>
        <20171005084249.sdkimglkxqh2vi4i@sigill.intra.peff.net>
        <xmqqvaju6i3p.fsf@gitster.mtv.corp.google.com>
        <20171005100001.do5m4zhexcsltvw7@sigill.intra.peff.net>
        <6222f65a-c518-74a4-9df4-89bf997425cb@gmail.com>
        <20171006141128.rkuhd4m7hp2f7vvx@sigill.intra.peff.net>
        <d5b3107f-76ec-8e8c-d7f5-d0f1ec75b1c9@gmail.com>
        <20171007193311.c2izgofpyh357yi7@sigill.intra.peff.net>
Date:   Sun, 08 Oct 2017 10:46:41 +0900
In-Reply-To: <20171007193311.c2izgofpyh357yi7@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 7 Oct 2017 15:33:11 -0400")
Message-ID: <xmqqh8vatnr2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 890912C4-ABCA-11E7-93D6-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Oct 07, 2017 at 03:12:08PM -0400, Derrick Stolee wrote:
>
>> In my local copy, I added a test to p4211-line-log.sh that runs "git log
>> --raw -r" and tested it on three copies of the Linux repo. In order, they
>> have 1 packfile (0 loose), 24 packfiles (0 loose), and 23 packfiles
>> (~324,000 loose).
>> 
>> 4211.6: git log --raw -r  43.34(42.62+0.65)   40.47(40.16+0.27)  -6.6%
>> 4211.6: git log --raw -r  88.77(86.54+2.12)   82.44(81.87+0.52)  -7.1%
>> 4211.6: git log --raw -r 108.86(103.97+4.81) 103.92(100.63+3.19) -4.5%
>> 
>> We have moderate performance gains for this command, despite the command
>> doing many more things than just checking abbreviations.
>
> Yeah, while it's less exciting than seeing the 90% numbers for a
> micro-benchmark, I think this represents real-world gains (and 5-7% is
> nothing to sneeze at).

Yes!  I would even say 5-7% is much better than "nothing to sneeze
at".  We do prefer workload closer to the real-world usage over
micro benchmarks, and consider changes that gain by a few percent as
real improvements.

> You might also try adding "--format=%h" or --oneline to your invocation,
> which would compute abbreviations for each commit (making your workload
> more abbrev-heavy and possibly showing off the difference more).

Again, agreed, and I would not consider it would be inflating the
benchmark artificially in favor of the change.  "log --oneline" is
not something people use rarely---I'd think it would be quite a
normal thing to do.

> I also think "-r" isn't doing anything. Recursive diffs are the default
> for the "log" porcelain (even for --raw).

That's my fault writing "-r" ;-) Together with your "log --oneline"
suggestion,

	git log --oneline --raw

would be a reasonable thing to measure.

Thanks, both.
