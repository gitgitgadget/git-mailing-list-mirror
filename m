Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C5E120958
	for <e@80x24.org>; Mon, 27 Mar 2017 05:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751944AbdC0Fjl (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 01:39:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54708 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751931AbdC0Fjl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 01:39:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 99D42744C4;
        Mon, 27 Mar 2017 01:39:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZmpNberX8e+8YOx6c5Zykmd/GTg=; b=otx3pk
        l/q2kHGsJHOkKNtZ9/BgLuM7DjsKjzoi35beeBDYK91WinnTDblajmbP1tnjj3qN
        JIKHMnqYndrFzo/Bbo4ahWcSL2RB6IXypE4DXSkPj5cU4jlRfb4X89CUfhzEax7r
        AN/jYVLpcgnlDzzuAZfnP89+dlcqsyMLpwnL4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RK468YdEp8n+EpkkMHXzXAs5Lm4TPMhu
        MPnNEJ9HVqMGxF6qEZ5Pn5LN4wi70K5cE2XZ8u4NWrj4/lLkvCs9G0Cwh6wnlFp6
        QY7cumvfKjnb9xCrVopNSw93QewPpCxmQgDwQy+PaIT3GRW26K45NPALUQ2hgTAH
        hTHtdk5AkLE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91B9E744C3;
        Mon, 27 Mar 2017 01:39:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ECD0C744C2;
        Mon, 27 Mar 2017 01:39:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Conrad Irwin <conrad.irwin@gmail.com>,
        Sitaram Chamarty <sitaramc@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 3/3] rev-parse: match ^{<type>} case-insensitively
References: <20170326121654.22035-1-avarab@gmail.com>
        <xmqq1stszxn4.fsf@gitster.mtv.corp.google.com>
        <20170326121654.22035-4-avarab@gmail.com>
        <xmqq60iv4ku2.fsf@gitster.mtv.corp.google.com>
        <20170327025818.pbm4nwqrfolyto7g@sigill.intra.peff.net>
Date:   Sun, 26 Mar 2017 22:39:18 -0700
In-Reply-To: <20170327025818.pbm4nwqrfolyto7g@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 26 Mar 2017 22:58:18 -0400")
Message-ID: <xmqqk27b2s8p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B90122F0-12AF-11E7-983F-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> FWIW, I cannot see us ever adding TREE (or Tree) as a separate type.
> It's too confusing for no gain. We'd call it "tree2" or something more
> obvious.

In case it was not clear, I didn't mean to say I _want_ to leave
that door open.  Well, I cannot imagine it was unclear, as I said I
do not at all mind declaring that all object names will be lowercase
to allow us freely downcase what we got at the UI level.

> So I don't mind closing that door, but I'm not sure if a partial
> conversion (where some commands are case-insensitive but others aren't
> yet) might not leave us in a more confusing place.

Exactly.

> I dunno. I guess I have never wanted to type "^{Tree}" in the first
> place, so I do not personally see the _benefit_. Which makes it easy to
> see even small negatives as a net loss.

As to the potential _benefit_, I do not see much either myself, but
we already are seeing somebody cared enough to throw us a patch, so
to some people there are clearly perceived benefit.  I do not think
closing the door for typenames that are not lowercase is a negative
change at all.

I just wanted the patch to make it clear that it is making such a
system-wide design decision and casting it in stone.  Which includes
that "cat-file <type>" and "hash-object -t <type>" get the same
case-insensitivity update and probably writing that design decision
down somewhere in the documentation, perhaps in the glossary where
we talk about the "object type".

