Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ECFC433E9
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7699064F2B
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhCQV2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 17:28:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60523 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhCQV2J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 17:28:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40EC7AA038;
        Wed, 17 Mar 2021 17:28:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zoY2N5ozueYccRpXCJP7rhWXeQY=; b=QE9E//
        KfaFK1DE1vne1LUi++XwOoTbQ6y6FEEfSEWNhWwUMLCK6w/wUhlPXPuse2hX/csR
        2hHomUWXNlsusGwZB2F5h1nNV9ifaSX/RNBOwcgDZvgXLPrg/z5mdMaUHl0ZLpjI
        yJ+O97uiTKXucL3wTt629PX6OnooYnW5ZlSYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yPu65u/sjj/UT+ou/9F/mbB5JU7bI7ni
        AoVOi3sTaaaM/zT4L5RuwyB5LstfPfJCKeAn7T81QVFOj4kzKpnrCLVZsDBVt9w/
        Vob7bTR8mwOyt3H5DlI6Pdz8kyKB06L8xZhBPvgMPy50bnLi/dbwjV725bCtf54g
        73VFUNCS63w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 389ECAA037;
        Wed, 17 Mar 2021 17:28:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C248AAA035;
        Wed, 17 Mar 2021 17:28:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Pete Boere <pete@duel.me>, git@vger.kernel.org,
        John Lin <johnlinp@gmail.com>
Subject: Re: Extra blank lines in "git status" output have been reduced
References: <CAF8W_bFzE8strSWc0_eABdyfCxA+0CA6ph_uXgSyT7YRU-jO6A@mail.gmail.com>
        <xmqqo8fhtvst.fsf@gitster.g>
        <YFJkJvJdO5XsrvO/@coredump.intra.peff.net>
Date:   Wed, 17 Mar 2021 14:28:08 -0700
In-Reply-To: <YFJkJvJdO5XsrvO/@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 17 Mar 2021 16:18:46 -0400")
Message-ID: <xmqqft0ttqqf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB2C399A-8767-11EB-98FE-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Mar 17, 2021 at 12:38:42PM -0700, Junio C Hamano wrote:
> ...
>> You may want to join the list discussion and stop whatever UI change
>> you find undesirable before it materializes next time.
>
> If we discover later that some portion of users prefer an older
> behavior, it may be reasonable to build on top with a config option to
> allow selecting the old or the new.

True.  I do not think this one passes the bar, as the porcelain UI
is subject to change, and it is not worth flipping and flopping
every few years.

>   - how big is the code burden to support both behaviors? In this case,
>     I don't think it's too bad; it's restoring the old newlines with a
>     conditional

Accumulated little cuts will start hurting someday, though.

I think the change was done to make the output consistent between
two cases (with or without "use X to do Y" hints), so it won't be
sufficient to conditionally revert with a switch.  An option to add
these blank lines back would also have to add extra blank lines to
places where there was (and is) no blank line, so it is more like a
new development than a partial reversion.

cf. https://lore.kernel.org/git/?q=d%3A20190415..20190615+f%3Ajohnlinp%40gmail.com

>   - how many people would actually care enough to set the option? Even
>     without a lot of code, each option is _some_ burden to carry, both
>     in the code and in the overall complexity of the interface. I'm less
>     convinced in this particular case that a lot of people care (given a
>     single comment after many releases), but perhaps those interested in
>     the change could produce data (note I said "data", not "argue more
>     vigorously" ;) ).

;-)
