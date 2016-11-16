Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B9472042F
	for <e@80x24.org>; Wed, 16 Nov 2016 18:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753924AbcKPSkA (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 13:40:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59289 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752897AbcKPSj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 13:39:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A5E24DCE4;
        Wed, 16 Nov 2016 13:39:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SlrRjxQrNxjybpyiwJC8C8Zvs8M=; b=b5NHTI
        QRvJvsxSp4Y1NFwAKlRW8/qH1RC8PAckPvCh4QPMoaL2PBBKYL7ObSVOQbZWeUG1
        eZi+MjZ6TyfG0FX58isuCBzcyjzKHLjIew4SIL3Xtn3hyUvMbDG+A/GeqZptejk6
        OFbNuBm3GWiXwJwdu5y8Q4624+xMFHO+HqDTo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T3tpXrHnshbWOPCrK0ppZFgJzN4z3WhY
        Ehgaq7mK4F+8EIkALNehYAaoa38AtEmYmoH37Ov54YptBFPmdpq1jdAYK/IJ5cCz
        32trTLi2HkrGftSZy1VS6gSayhxZRzvc7071D7IYClfYTcHddaTip+aytPQ0LMiu
        nqgAPPRaYnY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 807F64DCE3;
        Wed, 16 Nov 2016 13:39:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F04B14DCE1;
        Wed, 16 Nov 2016 13:39:57 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/11] git worktree (re)move
References: <20161112022337.13317-1-pclouds@gmail.com>
        <xmqqeg2gyv1v.fsf@gitster.mtv.corp.google.com>
        <xmqqa8d4yts7.fsf@gitster.mtv.corp.google.com>
        <20161116130533.GA5393@ash>
        <xmqqy40jqoqm.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 16 Nov 2016 10:39:56 -0800
In-Reply-To: <xmqqy40jqoqm.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 16 Nov 2016 10:11:13 -0800")
Message-ID: <xmqq8tsjqner.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1313D2DC-AC2C-11E6-B931-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> The following patch should fix it if that's the same thing you saw. I
>> could pile it on worktree-move series, or you can make it a separate
>> one-patch series. What's your preference?
>
> Giving a stable output to the users is probably a good preparatory
> fix to what is already in the released versions, so it would make
> the most sense to make it a separate patch to be applied to maint
> then build the remainder on top.
>
> I do not think "always show the primary first" is necessarily a good
> idea (I would have expected an output more like "git branch --list").

Yikes, "worktree list" is documented like so:

    List details of each worktree. The main worktree is listed
    first, followed by each of the linked worktrees.

If the primary workree is somehow missing, it still should be listed
first as missing---otherwise the readers of --porcelain readers will
have hard time telling what is going on.

            
