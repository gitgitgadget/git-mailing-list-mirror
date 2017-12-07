Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D710A20954
	for <e@80x24.org>; Thu,  7 Dec 2017 21:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751792AbdLGV7m (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 16:59:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52076 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750973AbdLGV7l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 16:59:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7570FC590C;
        Thu,  7 Dec 2017 16:59:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PamuozwnKCu/V0MknZMSJI3GIQg=; b=vkjn1u
        EpC4iy2eJORlScLZcefFfEntHauhy64JUdqbsEAPeymXXhXU88QzkDmr/21bjzFj
        HmXEmmh0r0PMX4wmZ5YBDNjhTc508waZZJ2shh78Wna1y11pYQ8+Jo+kTzPW2mXw
        SSLMZ+haYTAmiTSzG42pGz8jjPpv4rYaWAsUI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A+vRS5WCq41JBV35PsoWLpNSva2Z+mea
        DJqX5ciiMJPmlhVZl2785yYQedHovVKohLoaY/jx6oHRA14V+CxdgFGmlTBBDctx
        U2DGZ1eyiynOUd1PmOXU6kitmEol5eMck58rNRRCP+oC2/0jKyM2Dmf7SOjomut6
        R/P2KxxTV/g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C023C590B;
        Thu,  7 Dec 2017 16:59:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D3792C590A;
        Thu,  7 Dec 2017 16:59:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        jacob.e.keller@intel.com
Subject: Re: [PATCH v2 5/7] diff: use skip-to-optional-val in parsing --relative
References: <20171207003517.11729-1-jacob.e.keller@intel.com>
        <20171207173034.12865-1-gitster@pobox.com>
        <20171207173034.12865-2-gitster@pobox.com>
        <20171207211102.GA12850@sigill.intra.peff.net>
Date:   Thu, 07 Dec 2017 13:59:39 -0800
In-Reply-To: <20171207211102.GA12850@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 7 Dec 2017 16:11:03 -0500")
Message-ID: <xmqqpo7qb3n8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ECE2093C-DB99-11E7-8424-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Dec 07, 2017 at 09:30:32AM -0800, Junio C Hamano wrote:
>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>
> It might be worth mentioning why this conversion is pulled out from the
> others (because its "default" case is "do not touch the pointer").

I am not sure what you mean by "pulled out from the others".  I did
not intend to keep these 3 additional patches permanently; rather, I
did them to help Christian's rerolling the series, and I do not think
this one should be separate from other ones that use the _default()
variant when that happens.


