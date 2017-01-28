Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E62751F437
	for <e@80x24.org>; Sat, 28 Jan 2017 00:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750847AbdA1AUm (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 19:20:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57866 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750741AbdA1AUk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 19:20:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C88C63E88;
        Fri, 27 Jan 2017 19:20:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oKw7UD1CzcYtXkZ6VqTLsy7tULQ=; b=nFL5gN
        AP0GgR4qAGi7wGsCrDCqP1EqcZR8jQiKtZ5/9azQz1J+6Re/Lze2fU1IgTkOApeB
        Gj6UnDtiUlVN77gAFQFotTwlMRTP9ItmzjwPBoeGPLUg/MZBxz9qAkU2OmgmYQfc
        +Q8rzCylBdtWr12V0IjHNfq3Tal5Ppvddr3J4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BEThl1+XNgkcMyxd4cCx+uapjDzOiZHV
        Oo3lPQZSue50aMp+0uP5podx4dRxkgUVlP1VH/VX4cdVFnogJmAM4jLlW6eJKq4k
        60bT9ezKK4leJQFpS/wsc9XhE5OY51RiTqRmza9B2bboxR9Ko4reEEiTGHh9NFqa
        Yjd9HXm2pWM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 61CA463E87;
        Fri, 27 Jan 2017 19:20:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C2ACD63E86;
        Fri, 27 Jan 2017 19:20:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 1/1] reset: support the --stdin option
References: <cover.1476202100.git.johannes.schindelin@gmx.de>
        <cover.1485520718.git.johannes.schindelin@gmx.de>
        <3b0bad26045ed175f40f050e15b65cb6a8f2368c.1485520718.git.johannes.schindelin@gmx.de>
        <20170127170422.lvpghp6jdud37zxx@sigill.intra.peff.net>
        <xmqqh94kz76v.fsf@gitster.mtv.corp.google.com>
        <20170127221221.d53icsq7mdkbqm23@sigill.intra.peff.net>
Date:   Fri, 27 Jan 2017 16:20:32 -0800
In-Reply-To: <20170127221221.d53icsq7mdkbqm23@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 27 Jan 2017 17:12:21 -0500")
Message-ID: <xmqqa8acxcfj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9584015A-E4EF-11E6-A62A-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think a lot of the documentation uses <paths> to refer to pathspecs
> (e.g., git-log(1), git-diff(1), etc).  As long as we're consistent with
> that convention, I don't think it's that big a deal.
>
> This spot needs a specific mention because it violates the convention.

Yup, I think we are in agreement.

> I don't know if the are other spots where it might be unclear, but I
> think we're probably better to tighten those as they come up, rather
> than switch to saying "<pathspecs>" everywhere.

Oh, I do not think I would disagree.  As I think this change is an
instancethat makes the resulting text unclear, it would set a good
example to tighten existing one as part of its clean-up.

It can be done as a follow-up bugfix patch (i.e. "previous one made
the resulting document uncleasr and here is to fix it"), but that
would not serve as good ra ole model to mentor newer contributor as
doing the other way around.


