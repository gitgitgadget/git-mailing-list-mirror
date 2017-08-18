Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 481831F667
	for <e@80x24.org>; Fri, 18 Aug 2017 07:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751055AbdHRHpm (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 03:45:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62239 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751027AbdHRHpk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 03:45:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE1229D74C;
        Fri, 18 Aug 2017 03:45:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=74PeDvawpQu8qCkJgZfiohV9ynI=; b=dFFdyI
        jPd5T6R/TcwNF+8oAwJPuX0jFDIqHhwhAjV8SXMjb1mHmgJxQgp505FLlbaKiO1b
        5dgSK+IAJHSnc4QvvHXxSnLpVDTM1Kikdg1d+/0tEp7LNQmi768be5QGYS3xHeAc
        5y4GNhpgzHJGG5ZTjgaR4iCHWGCrdA4u/ivcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PtXjiN6iuV19p4pim29zYPavKVlhcavn
        jvdTTaXmJi88o3gifi56x7gjjPxy57KypfO0y4qcgxQPeLKjGlIz78UGnqYd+IwB
        /kAxro//ycpQaBYPU4+xR/66NjTcoisqGK8lLby0TkzkBZ3URhd9E5J1ZTPivDru
        p3/vywIZfCw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A58A39D74B;
        Fri, 18 Aug 2017 03:45:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0E3F39D74A;
        Fri, 18 Aug 2017 03:45:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Marko Kungla <marko.kungla@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] check-ref-format: require a repository for --branch
References: <CAKY_R-uk9hpR2hbkPsw2cqoMo6bQKoyp6cWTO20L3fOWfLW2-Q@mail.gmail.com>
        <20170714180313.apsnbnw7no2nvtf5@sigill.intra.peff.net>
        <20170714181831.fvi2coppzhm747mk@sigill.intra.peff.net>
        <20170717172709.GL93855@aiede.mtv.corp.google.com>
        <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>
        <xmqqy3qhevaq.fsf@gitster.mtv.corp.google.com>
        <20170818062021.gqhsose5kepth55h@sigill.intra.peff.net>
Date:   Fri, 18 Aug 2017 00:45:32 -0700
In-Reply-To: <20170818062021.gqhsose5kepth55h@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 18 Aug 2017 02:20:22 -0400")
Message-ID: <xmqqvallco9v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 378D498C-83E9-11E7-8FD9-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I _do_ think it's a misfeature to put it in check-ref-format. It should
> be part of rev-parse. Which admittedly is a kitchen sink, but this kind
> of resolving is one of the main things it should be doing. And in fact
> you can already do:
>
>   git rev-parse --symbolic-full-name @{-1}
>
> But I stopped short of suggesting we remove the feature entirely. It
> would obviously require a deprecation period.

Yeah, I realize that "nonsense" was a bit too strong.  I do agree
that it was a misfeature to place in "check" ref-format, though.

Thanks.
