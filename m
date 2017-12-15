Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A30A81F407
	for <e@80x24.org>; Fri, 15 Dec 2017 16:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932523AbdLOQ6Z (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 11:58:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63146 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932348AbdLOQ6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 11:58:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C79DB7D8B;
        Fri, 15 Dec 2017 11:58:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pN8udQo0mDvG21eYzspsBvSfo18=; b=dSn+MF
        OrFDxlbBIpUzdIMJG69UfG1AqrXw1DH8HOd9NEaqUFw2eTR7MPq7hVcrqwDz2tfL
        sbzrFHJu4zh5xxtczEkgjtIXtaRYQSsvQNJaVQAXcHkVkhsdcNFKfe7QJ25NzqRL
        PQK6cu1XyNhuiOxGmQvHftltJrWmMe+SX5vd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bXsO5EEMMMZxMnuM4wk0Z/TJNJQ5Vj+Y
        RVBjkW7SjokEndk11LwT/o8FmSYLzBNmobP8JQ2r3ipGWLhvLVLItfSjb9GeR0cU
        QV2lJEDCS/SPUb97eFLiREZ5CTCB07Qws0OpyO4kaedzuMUo4tTrjzYAgo3scDtx
        tC02RCIRxAY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0485BB7D8A;
        Fri, 15 Dec 2017 11:58:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6E93AB7D84;
        Fri, 15 Dec 2017 11:58:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 4/4] t/Makefile: introduce TEST_SHELL_PATH
References: <20171208104647.GA4016@sigill.intra.peff.net>
        <20171208104722.GD4939@sigill.intra.peff.net>
        <alpine.DEB.2.21.1.1712081602570.4318@virtualbox>
        <20171208220046.GA26270@sigill.intra.peff.net>
        <alpine.DEB.2.21.1.1712091443560.4318@virtualbox>
        <20171210142309.GA19453@sigill.intra.peff.net>
        <xmqq4lox57c9.fsf@gitster.mtv.corp.google.com>
        <20171215104101.GA11637@sigill.intra.peff.net>
Date:   Fri, 15 Dec 2017 08:58:22 -0800
In-Reply-To: <20171215104101.GA11637@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 15 Dec 2017 05:41:01 -0500")
Message-ID: <xmqqmv2kq66p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29362B0A-E1B9-11E7-93BF-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think (4) and (5) are the only things that actually change the
> behavior in a meaningful way. But they're a bit more hacky and
> repetitive than I'd like. Especially given that I'm not really sure
> we're solving an interesting problem. I'm happy enough with the patch as
> shown, and I do not recall anybody complaining about the current
> behavior of these options.

OK.  Thanks for thinking it through.

>> There is a long outstanding NEEDSWORK comment in help.c that wonders
>> if we want to embed contents from GIT-BUILD-OPTIONS in the resulting
>> binary, and the distinction Dscho brought up between "build" and
>> "test" phases would start to matter even more once we go in that
>> direction.
>
> I guess you're implying having a GIT-BUILD-OPTIONS and a
> GIT-TEST-OPTIONS here.

I admit that my thinking did not go that far to introduce the
latter, as "git version --how-did-we-build-this-exact-git" only
needs the former.  But you're right that some information given
at the top-level must be stored somewhere t/test-lib.sh reads in
order to allow us run tests from outside Makefile (your point 1.)
