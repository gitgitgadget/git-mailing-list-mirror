Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FA0D207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 17:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161280AbcIZRjP (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 13:39:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52744 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1161042AbcIZRjO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 13:39:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 960DE412AC;
        Mon, 26 Sep 2016 13:39:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7S6VnDmSmk6O0T9A8r21esKoCSM=; b=W7QUWS
        prm23VbjFOt5aiAOBw2ZO9sP064zR+2R+L/5mnQy0XISgnlWUSDMFFerKoB1lu3h
        axnJ0079SHQhhhR84q9dPrmfu9pHq25jXv+bytm6jBOy5xQRE/vBcMzVNYpTCa3i
        m40nZbWc1hgcUdmLbZ2CriZxFQt4v8Lu4kr5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PItw7NJaV9139tOI15P0Dyd0d46plAnT
        XebMfI/MQUVmIHGy+fHmXSiBxCYa6rlFG+iXg7HSFBvRMza9Eap+fOyOg78e7LkA
        WsqCuCQL3+MyXa3LVl1axJIArgiVpPxBC27deB6M0/34riS0GUQm5Puyq+gI00U1
        EkHP9SdSKxE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F3DC412AB;
        Mon, 26 Sep 2016 13:39:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 05325412AA;
        Mon, 26 Sep 2016 13:39:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 10/10] get_short_sha1: list ambiguous objects on error
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
        <20160926120036.mqs435a36njeihq6@sigill.intra.peff.net>
        <xmqqwphytvp3.fsf@gitster.mtv.corp.google.com>
        <20160926173413.prp3wevf6kkksy7c@sigill.intra.peff.net>
Date:   Mon, 26 Sep 2016 10:39:10 -0700
In-Reply-To: <20160926173413.prp3wevf6kkksy7c@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 26 Sep 2016 13:34:13 -0400")
Message-ID: <xmqqfuomtvb5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 237174FC-8410-11E6-B729-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Since it's attached to an error path, I'm guessing nobody will be too
> upset about it, so my inclination was to wait and let somebody add the
> conditional advice code if they're bothered.

Fair enough.  At that point of getting an error message, the only
thing they can do is to start wondering what object the person who
gave the now-non-unique abbrevation to them, so I suspect this is
one of the "advice" messages that can always be there.
