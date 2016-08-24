Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16AFC1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 17:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754499AbcHXRzs (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 13:55:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55281 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753021AbcHXRzr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 13:55:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE51B37B8A;
        Wed, 24 Aug 2016 13:55:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h5Et8gMJdoPrQYSrQs73ER/Yq1M=; b=Xumai/
        DhdtChe1hV3UFXm2lyJGEL4yN2Vfo8/HjaAhGKVMzlpnY2du4aJp0GE7XWDgjiVQ
        4xT3nuqhxlrJgai3Ix2GLSJAFqQK1TdCVtonyCkZN/9XMgpsAsLzo4OO0HAVWcIy
        b1PqE9wYtqDmAvUHb3RKWntlfzXcd8ZfwHuug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HlSIvraOfVVxaaTXJ96dlfX+SuUB1sfq
        SIEpLjaBJIM287fsTGCGjXVi3wTFV8+mynhgJql1Sf/0YBtfRjsR/8WjhtQ/Wl2z
        DIHaFklzQywBrbXeTS4uKgr1KtRrruS5WI/c1MGkvTnwQ9hoiWqfpEE1a/J2sRF2
        TWKi/e4/CpI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AFFA637B89;
        Wed, 24 Aug 2016 13:55:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2052437B85;
        Wed, 24 Aug 2016 13:55:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 0/4] cat-file: optionally convert to worktree version
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
        <cover.1472041389.git.johannes.schindelin@gmx.de>
        <xmqqk2f6rvx9.fsf@gitster.mtv.corp.google.com>
        <20160824161939.d2h4qlaxhhi6limm@sigill.intra.peff.net>
        <xmqqr39eqevk.fsf@gitster.mtv.corp.google.com>
        <20160824173248.ami3hgadea5zjvf3@sigill.intra.peff.net>
Date:   Wed, 24 Aug 2016 10:55:44 -0700
In-Reply-To: <20160824173248.ami3hgadea5zjvf3@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 24 Aug 2016 13:32:48 -0400")
Message-ID: <xmqqa8g2qcf3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FBC03020-6A23-11E6-A250-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't suppose anybody cares that much either way, but it feels weird
> to behave differently depending on how we looked up the blob (whereas
> for the HEAD:t case, a tree is always a tree).

I do not care strongly either way, but HEAD:RelNotes case we _know_
it is not a regular blob, and discarding that info for the sake of
being consistent with the common denominator case, instead of using
it to point out a possible mistake, feels wrong, too.

In any case, not outputting anything and silently succeeding is
definitely wrong ;-).
