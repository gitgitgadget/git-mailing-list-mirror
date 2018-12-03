Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33BBF211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 00:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbeLCAaH (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 19:30:07 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63325 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbeLCAaH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 19:30:07 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DCD4A1AFFD;
        Sun,  2 Dec 2018 19:30:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=F8g7I8s6NXC3gTSGFeh5J85Jb38=; b=vhyoUefz4Z2Rquuobb9j
        uNWNHUMCVo9pk3YvplgaTKM/GE2xjqqmW6koL0r/Uui5aoRvDIPLynTFeLZpZ3Ny
        mTGC5EGjeL4qb+c+XEHgOYmvNvJqYAp3lL5nLH9pRUlJUD4146SfYfAJ7mvEL8te
        SPYf2LOjkAvfRNwEvE43FKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=SWJ/YGGi+xgVSSyEaiqWoaJb7ILYtHrxK53Wqo/JCeEBFk
        UPWqsp3GZxFWqlIp1SeaZ/rll9p0iha4GGnQkCYM0xmcQZeoxn3KkQOyPWwAdkMk
        CVvHdfXrAfO5mvPjcfT8l+9ddJgRAgyrd91RkRkFHMjyrcERuKh8BOQWea4MQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D6BC71AFFC;
        Sun,  2 Dec 2018 19:30:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E3D501AFF5;
        Sun,  2 Dec 2018 19:29:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
Subject: Re: [PATCH] Do not fail test if '.' is part of $PATH
References: <20181201180757.0b2d3c89@pc09.procura.nl>
        <20181201193822.GA28918@sigill.intra.peff.net>
Date:   Mon, 03 Dec 2018 09:29:57 +0900
Message-ID: <xmqq4lbviha2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9160D02E-F692-11E8-B837-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Since the test is ultimately checking "can we run should-not-run from
> the current directory", might it be simpler to actually try that as the
> precondition? I.e., something like:
> ...

A nice egg of columbus.  It also would save us from mischievous
users who have should-not-run somewhere no the $PATH that outputs
the string we expect (no, I do not think it is a common thing to do;
I am just saying that the solution covers such an extremely stupid
case without special casing).



