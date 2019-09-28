Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE12F1F463
	for <e@80x24.org>; Sat, 28 Sep 2019 04:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725294AbfI1EBJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Sep 2019 00:01:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64818 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbfI1EBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Sep 2019 00:01:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 437243566C;
        Sat, 28 Sep 2019 00:01:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JVzrIWEYfo2ewk1v1iUVqpz1Rz4=; b=dGVqh4
        V8bWzUR7v2OhOoWCSgER6NVI0rhm9xBTMyzFgGSa3yAWeoNgJA9/8KI23OaSMoRY
        vJUJqybRVmz5icRFiNmwlYXIEpdJzX/khLt8c1DV6lqnIqCKyzG8Z5tPQ6kHrZ4w
        +W+w8Chq+ZXmA+S9+S5MJjpd6SxwIuiyoeCx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y65943wqhJaoq8IGqIGyZ1zEv8N6Ssgg
        1vilbaZi3vPnc4OJn+U0G2dWuq4J7RQBZW8tw8lW0rs2JJzVdnXJv2oIK2FcNsBo
        dxZT/UxuP5YJ6uPuKit3C3xguuhfXitLMSwKkbbTfCW4BMwyNxaL8utfP5wQLIak
        zuI0OvAChwQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 356BA3566B;
        Sat, 28 Sep 2019 00:01:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 49B103566A;
        Sat, 28 Sep 2019 00:01:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
References: <20190827051756.GA12795@sigill.intra.peff.net>
        <20190913200317.68440-1-jonathantanmy@google.com>
        <20190913205148.GA8799@sigill.intra.peff.net>
        <20190916184208.GB17913@google.com>
        <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
        <20190924005529.GA8354@dcvr>
Date:   Sat, 28 Sep 2019 13:01:03 +0900
In-Reply-To: <20190924005529.GA8354@dcvr> (Eric Wong's message of "Tue, 24 Sep
        2019 00:55:29 +0000")
Message-ID: <xmqq7e5tkr28.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98A344B8-E1A4-11E9-8A36-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> C is fine for unit tests, and maybe we can use more unit tests
> and less integration tests.

Nicely put.  I often find it somewhat disturbing that what some of
the t/helper/ tests are trying to exercise is at too low a level
that the distance from the real-world observable effect is too many
hops detached.  For unit tests (of an API, for example), that is
exactly what we want.  For a test of an entire command, it feels
like scratching foot from outside while still wearing a shoe.

> I hope to find time to hack some more batch/eval-friendly stuff
> that can make scripting git more performant; but no idea on my
> availability :<

