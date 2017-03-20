Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9297C20958
	for <e@80x24.org>; Mon, 20 Mar 2017 19:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755905AbdCTTiG (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 15:38:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54992 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755696AbdCTTh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 15:37:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C31E27C117;
        Mon, 20 Mar 2017 15:37:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nf5l3cYqH6uslPHaRHLcwn+c3eo=; b=Ape4eB
        i09yNxbJxJUP4ZnCPcaJTXomdPj88DNM1v0uaZzfDLHdQ+i3Gc5Vd0S+tkcEuzYW
        x63cZdczujcx2E/hE2q1lufB02PCtKkYnR330k/GC1H7Fnzq5evyrnqhVxvi1HNg
        C82ARuWmi43/41yh8dG+ZoNJJLGuVZzgc5OZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Xu0QLo9FnZemfRuTGXefzWDISZaPbnec
        YFKOv2BhIyh+x47KHJjUTrbxp2s+PWui7ALxfzZ+Cpoeaa6SGgyA3CvInv+hJX12
        HoPS3fTqOl69NkKE/K9PNXauOSpisDmS+0AayjkFzpJrsT6KchJo3HVGJzPlUjfm
        0+WXt8GcWLQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC9777C116;
        Mon, 20 Mar 2017 15:37:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 265B47C115;
        Mon, 20 Mar 2017 15:37:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     jrnieder@gmail.com, git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH 0/2] use "working trees" instead of "worktree" in our API
References: <20170320185038.GU26789@aiede.mtv.corp.google.com>
        <20170320192225.18928-1-sbeller@google.com>
Date:   Mon, 20 Mar 2017 12:37:09 -0700
In-Reply-To: <20170320192225.18928-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 20 Mar 2017 12:22:23 -0700")
Message-ID: <xmqqy3vzvixm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9CA1BED6-0DA4-11E7-97A8-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> For what it's worth, this conversation makes me think it was a mistake
>> to call this construct a worktree.
>
> So the way forward is to purge the use of "worktree" meaning actual working trees?

GIT_WORK_TREE environment would have be a victim of this clean-up,
so is setup_work_tree(), together with numerous in-code comment
about "work tree".

While I would say that we would certainly pick one and stick to it
if we were inventing Git from scratch today and just started caring
the distinction between core.bare and not, I am not sure how far we
would want to go, and what's the expected payoff of doing this
clean-up would be, given that we are starting from today's world.

So, I dunno.  If the response and list concensus to Jonathan's
earlier comment came up with a better name for the newer "worktree"
concept, we may not have to even worry about this and instead can
just declare "these are used interchangeably".
