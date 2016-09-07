Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E16171F859
	for <e@80x24.org>; Wed,  7 Sep 2016 23:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751488AbcIGXFN (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 19:05:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54491 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750909AbcIGXFM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 19:05:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D5A603D023;
        Wed,  7 Sep 2016 19:05:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xeq4eDlozKeuepXWnXgTkRstG2Y=; b=ifZ+K3
        9bREXMWfQMiHkFcW7nA02yba7x3CSmsWsirYjrbqZGvkS1RQe55FrzydOGOGCNzK
        7FmkMh4CC7jZ5gRLiyWSHFsAHdCtxzbLOiZgG7hQSeNV5/Ay25hrDhyDf/Oz89AA
        TtW68Jz7BuLI5HG7/HjLr+YqUyLxZJUU9Gb9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oJV6DjLwMlvrXejYP09pGW1SL4ercX0H
        3J7+GIbxPc1UH9Jty1+WZvf4f2iCcE9L5Aao2kWeV0IwH/EvaKoOhveAKYpOhjKJ
        vM34WSLX6uvL4vy7YQYNKXUIsAOZUmDgFM+2hMVmAlW3kt82rtnbf+U1S+zWtUa2
        BBsb/qWsawM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD3343D020;
        Wed,  7 Sep 2016 19:05:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 511E63D01F;
        Wed,  7 Sep 2016 19:05:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 00/20] object_id part 5
References: <20160905200811.697889-1-sandals@crustytoothpaste.net>
        <xmqq60q7lbae.fsf@gitster.mtv.corp.google.com>
        <20160907222207.6fdorwi4q4p72gro@vauxhall.crustytoothpaste.net>
Date:   Wed, 07 Sep 2016 16:05:08 -0700
In-Reply-To: <20160907222207.6fdorwi4q4p72gro@vauxhall.crustytoothpaste.net>
        (brian m. carlson's message of "Wed, 7 Sep 2016 22:22:07 +0000")
Message-ID: <xmqqwpinjopn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86B314C8-754F-11E6-A038-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Wed, Sep 07, 2016 at 01:12:09PM -0700, Junio C Hamano wrote:
>> It is a bit unfortunate that this conflicts somewhat in builtin/cat-file.c
>> and heavily with builtin/apply.c with other topics in flight.
>> 
>> Let me see how bad the conflict resolution is and report back later.
>
> If it ends up being problematic, feel free to drop the appropriate
> patches and I'll fix them up and send them in in the next set.

Let's see how well I do first ;-) There was another one in
wt-status.c that was touched by the "status --porcelain=v2" series,
but I haven't finished today's merges yet.
