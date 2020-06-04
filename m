Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0291BC433DF
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 20:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4957207ED
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 20:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hlCT/qlg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgFDUTE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:19:04 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63398 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729723AbgFDUTD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 16:19:03 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F25ADC2058;
        Thu,  4 Jun 2020 16:19:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wu50yyin1QvRNpcU1/5GegGs6h4=; b=hlCT/q
        lgEllaersBnmMZ3MgJ/xF1fPwoSDAGUy32znM2EvMvqPimnAWjZV0Pi63H8oWazh
        41qWZ54o/e9jyyZcOUwHjtfU/GW/+KBReK5TKum1JtuHOMIYRGhUAXBcpxA06WBs
        xQZJLrRUsIGbeOgYrMU6FlZC0QZcF/4cDog14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oVt5Ucj92C+oExu74tY6tAMgA73mHO8P
        G6nXfxtvM124KQWGdYhBP73F/4r/4lqPlPeVnKwA9D7fbeRSf7+2xpU+tIm6c3Ri
        ICDQ8kZDtFUmvsGrEB82Uw9ow5/AzOemE4luahxgLUL+xgT3Kj2LjgzO8GExcr/y
        LQwVfy/nMqA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EA371C2057;
        Thu,  4 Jun 2020 16:19:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 356E5C2054;
        Thu,  4 Jun 2020 16:18:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Laurent Arnoud <laurent@spkdev.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] format-patch: generate valid patch with diff.noprefix config
References: <20200602204924.GA1853335@spk-laptop>
        <xmqqpnahrx2y.fsf@gitster.c.googlers.com>
        <xmqqeeqxrufz.fsf@gitster.c.googlers.com>
        <20200604193238.GA1911544@spk-laptop>
Date:   Thu, 04 Jun 2020 13:18:57 -0700
In-Reply-To: <20200604193238.GA1911544@spk-laptop> (Laurent Arnoud's message
        of "Thu, 4 Jun 2020 21:32:38 +0200")
Message-ID: <xmqq367aposu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FB04532-A6A0-11EA-B317-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Laurent Arnoud <laurent@spkdev.net> writes:

> I don't know if its a bug but I founded strange that I needed to use an alias
> "git -c diff.noprefix=false format-patch" to generate a patch that I can apply
> directly with "git am".

The same thing can be said about the diff.relative option.

As I do not use either of these variables myself, I am somewhat
indifferent, if those who set these variables find the consequences
of doing so unpleasant.  As people often say, if it hurts, then...
;-)

Because the recipient of format-patch output who consumes it is
typically different from the one who generates it, it probably does
not make much sense to attempt linking diff.noprefix=true with the
-p0 option (there isn't even a configuration for 'git am -p<num>',
if I am not mistaken).

Depending on the project a user works with, allowing
log/show/format-patch to honor certain diff.* configuration
variables, without a way to countermand them with more specific
configuration for log/show/format-patch, may smell like a bug.  

I am not sure where to draw the line, though.  Would we treat only
format-patch and no other commands in the log family specially?
Would we treat each commands in the log family specially and
separately, so that you could say "diff and show uses noprefix, but
'log -p' and 'whatchanged' uses the standard a/ and b/ prefix and
format-patch uses old/ and new/ prefix" independently?

> I didn't know the -p option but to send a patch to a
> mailinglist it should have the prefix I guess ?

The participants in this project would certainly find it unusual
when they see a prefix-less patch.

There probably are projects older than Git whose convention is to
use .noprefix; we didn't want to force them to switch and instead
accomodated their preference with .noprefix but in hindsight, it may
have been a better idea to force one true way to everybody, which
would have kept the world simpler.  I dunno.


