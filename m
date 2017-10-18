Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F5001FF32
	for <e@80x24.org>; Wed, 18 Oct 2017 05:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966473AbdJRF5l (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 01:57:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54849 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933350AbdJRF5k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 01:57:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 286EBA30F3;
        Wed, 18 Oct 2017 01:57:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3WHJGU3sOavF9/OIDDXWcpNmuYM=; b=DK8UBD
        xkEj86fgAFe42u68/dPQfCioDkqtKhOovmSL94L+Dri77bYMDJZm+245rbi+e9zV
        JBBmoLsVtkbSuPW1FSghM5TP6OJlx47Smhm3TivBL2DcWKEiRmYH/iL7XoRL751h
        30ZKkkQYd6iwU/M8HTYJNnd/XQf51XJuJKICI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VnQuZmlGynZpBn+K2MUyBWiRqItb4rap
        NZKB9oG76pKde26jAGIfIFA9BgwGMO5ilU1lpbdZ4I4q+oXu/4pgqrWoM6A87Hdc
        MOadoCt7i4O/7jV2NvL9KU/3lqJKfbO4eQGKu/FuaCk4pp3pRdl6TYPyuQfKMzQt
        LezxBNTP+uA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FD8AA30F2;
        Wed, 18 Oct 2017 01:57:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9653AA30F1;
        Wed, 18 Oct 2017 01:57:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] color: downgrade "always" to "auto" only for on-disk configuration
References: <20171012021007.7441-2-gitster@pobox.com>
        <20171012123153.i265nun6pklw7kjg@sigill.intra.peff.net>
        <xmqqinfjykm2.fsf@gitster.mtv.corp.google.com>
        <20171013014721.d4vesqv4v5j7tmk2@sigill.intra.peff.net>
        <xmqqzi8vvht6.fsf@gitster.mtv.corp.google.com>
        <20171013130638.dgc6kawy5mvrbasz@sigill.intra.peff.net>
        <xmqqshemtoth.fsf@gitster.mtv.corp.google.com>
        <20171016215311.m72jarmqhjagy6o6@sigill.intra.peff.net>
        <xmqqo9p6r3ai.fsf@gitster.mtv.corp.google.com>
        <xmqqvajenvce.fsf@gitster.mtv.corp.google.com>
        <20171018052845.y54l6cd3dz64l5i4@sigill.intra.peff.net>
Date:   Wed, 18 Oct 2017 14:57:38 +0900
In-Reply-To: <20171018052845.y54l6cd3dz64l5i4@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 18 Oct 2017 01:28:45 -0400")
Message-ID: <xmqq4lqxknfx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3FAF4880-B3C9-11E7-8464-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> It was a bit more painful than necessary to make sure I have
>> something that can be merged for 2.14.x maintenance track, but I
>> think the topic is now in a reasonable shape, and I've merged it to
>> 'next'.  On the first-parent chain from 'master' to 'pu', the merge
>> of this topic is the very first one, and after reading it over once
>> again, I think this is OK.
>
> Hmm. I think you would just want the top two commits for maint-2.14
> (reverting 136c8c8b8f and fixing up git-tag to check color config). But
> of course you can't do a partial merge because they come on top of the
> other dead-end/revert pair. You'd have to cherry-pick (and even then fix
> up a few bits, like adding in the "add -p" test).
>
> Though if we take all of jk/ui-color-always-to-auto-maint, and then do
> the whole reversion on top of that, I think that should work. It just
> doesn't look like that topic ever made it to "maint" (I see mention of a
> jk/ref-filter-colors-fix-maint in the log for master, but there's no
> such branch).

Yeah, that is what ended up to be jk/ref-filter-colors-fix; the
branch merges cleanly to 'master', but also to 'maint' without
dragging the rest of the recent development along with it---I did a
rebase before sending out the message you are responding to.
