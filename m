Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFACF1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 21:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388147AbfG2VoH (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 17:44:07 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59533 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbfG2VoH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 17:44:07 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7F919855CD;
        Mon, 29 Jul 2019 17:44:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GBmFy3S2Mc2B545WvvpobRdmo+c=; b=V2Ag8a
        WgSbVFh/3VKO5xpc4EmKABBPWdRPxHE432FAd7fVEykkvVzhnbHU8VZHMhXMsI7f
        ypDgq7WZJe9Wlevjm0DJscRg42HIE3vPE/lepV/qzJZrEAgd9a+lDOMJmIKLoXu8
        Y8iF3XK8PvnonBiwR1jVdZ18VlujjrGfIyH+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R6vC/+wDOGFrX8wegKQTuy7WmqV/i+yL
        FaldRpyJnbkhJI6htzjyL+b1UOJf42UDLDx/9JF4iJxKnPjO2CBXH42tjNi7TE0B
        x1PdchwPfPSGKbxv2wfl1jdkBXZmbVxXg5nV29C7FtmJFbsOfj0yezDFjfL95VsM
        6KxkmPe5By4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 78D5D855CC;
        Mon, 29 Jul 2019 17:44:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A7246855CB;
        Mon, 29 Jul 2019 17:44:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christopher Head <bugs@chead.ca>, git@vger.kernel.org
Subject: Re: Push force-with-lease with multi-URL remote
References: <20190727095440.1aac3b3c@amdahl.home.chead.ca>
        <20190729102009.GC2755@sigill.intra.peff.net>
        <xmqq7e81vuc3.fsf@gitster-ct.c.googlers.com>
        <20190729192040.GD14943@sigill.intra.peff.net>
Date:   Mon, 29 Jul 2019 14:44:00 -0700
In-Reply-To: <20190729192040.GD14943@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 29 Jul 2019 15:20:40 -0400")
Message-ID: <xmqqwog0tt27.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB1F4360-B249-11E9-B92E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, the auto-update of the tracking refs came later (so I think you
> could argue the bad interaction is my fault!).

Heh, I somehow thought it was somebody else.

> Hmm, true. I'd almost argue that --force-with-lease, at least in its
> default mode with no explicit lease source specified, should allow an
> update from X to Y to be a successful noop if the remote "somehow"
> already moved to Y.

I've already written the --force-with-lease that expects what you
have on your remote-tracking branch off as a gross misdesign that
should be deprecated in the longer term; I do not have a strong
opinion on the tweaks to be done to the feature until it gets
dropped ;-)

