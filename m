Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F053203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 19:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934050AbcLMTMl (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 14:12:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52121 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932912AbcLMTMk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 14:12:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A1B657493;
        Tue, 13 Dec 2016 14:12:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NC9jRSFYNVoymKmgSY8bs8Sgk20=; b=qkz0as
        P7fUvXx0TxMqCMDGvWOWh+lmXc/BgCw8PF8DeFCcaSRNgqX/VZlZfBJfhsvdTZpA
        Ag26klfqFORidVG03SPnX5pmIg5fsuibdYEUwtv0y4YiuIuCNtS8Zr95mkmnIurY
        Fwre8PG+mppV0/oFzs9jXCTodnH31STvCcdzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Dt/UGsJvGy3q076gEl2w7qI0m16KoZpU
        sQtlpnNsdLGOP2YvwIh8KjKJ7Lu84OzzU06lT2jkQEgIvERenZ5b8FUAK4a36tse
        nvSOtoRsgPAO9YftH4jzs6a0lALVXVylxlUF9fH9/k/kZKd+a6aGYgi1Wlffb4Yd
        RBG9cjCM3iI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2189E57492;
        Tue, 13 Dec 2016 14:12:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 848DB57491;
        Tue, 13 Dec 2016 14:12:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stephan Beyer <s-beyer@gmx.net>, Ariel <asgit@dsgml.com>,
        git@vger.kernel.org
Subject: Re: git add -p with new file
References: <alpine.DEB.2.11.1612062012540.13185@cherryberry.dsgml.com>
        <20161209141129.r53b4rbtgd76fn2a@sigill.intra.peff.net>
        <alpine.DEB.2.11.1612091331170.13185@cherryberry.dsgml.com>
        <20161210085556.nwg3pbay367jqin5@sigill.intra.peff.net>
        <xmqq37hvphji.fsf@gitster.mtv.corp.google.com>
        <20161211130034.ygj5l2gbx33uknlk@sigill.intra.peff.net>
        <dc698b79-6311-a2a3-c564-a43ef071e62b@gmx.net>
        <20161213173341.wemlunlixdp6277h@sigill.intra.peff.net>
        <xmqq7f734qe0.fsf@gitster.mtv.corp.google.com>
        <20161213185653.ys3ig377zhmblncl@sigill.intra.peff.net>
Date:   Tue, 13 Dec 2016 11:12:36 -0800
In-Reply-To: <20161213185653.ys3ig377zhmblncl@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 13 Dec 2016 13:56:53 -0500")
Message-ID: <xmqqpokv3aor.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C380FEE-C168-11E6-A4DE-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Perhaps the latter is not advertised well enough?  "add -p" does not
>> even page so it is not very useful way to check what is being added
>> if you are adding a new file (unless you are doing a toy example to
>> add a 7-line file).
>
> I use "add -p" routinely for my final add-and-sanity-check,...
> ... To me they are all tools in the toolbox, and I can pick the one that
> works best in any given situation, or that I just feel like using that
> day.

Oh, there is no question about that.  I was just pointing out that
"add -p" is not the "one that works best" when dealing with a path
that is not yet even in the index.
