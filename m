Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF96AC32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 18:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BBA2187F
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 18:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hwh8uIz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgAOSOJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:14:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50657 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbgAOSOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 13:14:09 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 700E52C3E5;
        Wed, 15 Jan 2020 13:14:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7E9DJ4j+6hpCT+uByVcYFdnzkv0=; b=hwh8uI
        z6wQHE+l9UGKjZf/7zUnvE2wja1m1R7CU3jdzdbkGcTqi9PmhixXcJ2jbTzVcI8T
        3C5jU0/bJIquiTG5U5MMfKlcF1aP3vNvLNOBobFhAec3LEWM5EgSlHBs/GgOwIpY
        6To4mesWImHmy5MPxLVoxfcOJkUjJ0FM+fz/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O11ilIRjUcKJf8YmsUHTqBVyp6KwW7kT
        mGVhPZgyZhowE/xb9TqcD+QLPDOn2QF8vK5rYmOeKFmT1rqgU4ARE3ESagE/0+9w
        8n+NR8SFxkvRfK1dDytw08KIBk1cjGW00WQak9y0x6C87P28kABS7ZrdsYXOqffu
        mg+HF1ZiuHQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 55E2A2C3E2;
        Wed, 15 Jan 2020 13:14:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8BE342C3E1;
        Wed, 15 Jan 2020 13:14:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: "rebase -ri" (was Re: Problems with ra/rebase-i-more-options - should we revert it?)
References: <f2fe7437-8a48-3315-4d3f-8d51fe4bb8f1@gmail.com>
        <089637d7-b4b6-f6ba-cce1-29e22ce47521@gmail.com>
        <xmqqeew4l6qf.fsf@gitster-ct.c.googlers.com>
        <xmqq5zhgkwxx.fsf@gitster-ct.c.googlers.com>
        <xmqqy2ubjkeo.fsf@gitster-ct.c.googlers.com>
        <xmqqpnfnj9p3.fsf_-_@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2001151458100.46@tvgsbejvaqbjf.bet>
Date:   Wed, 15 Jan 2020 10:14:05 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2001151458100.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 15 Jan 2020 15:03:01 +0100 (CET)")
Message-ID: <xmqqftggk2oi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D17AF5DC-37C2-11EA-8CDA-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> ... after about 1700+ steps (which did not take more than 20
>> minutes, including the time spent for the manual rebasing of
>> en/rebase-backend topic) I got the same tree for 'pu' I pushed out
>> last night.
>
> Nice!

Nice indeed---I forgot to say more-or-less there, though ;-)

It is quite an achievement to make it practical to rebuild the
maint..pu chain, which would involve 1000+ commits, while allowing
to edit only a fraction of them.

	[ellided] observation that tips of the branches that were
	rewritten in order to rebase the named tip that contains
	them were left stale

> This has been discussed on the list before this past September, but I
> think the discussion has stalled after v2 was sent,...

That's OK.  One step at a time ;-)

> Having said that, if you ever find yourself wanting Just One Feature in
> `--rebase-merges` that would make it worthwhile for you to think about
> switching your patch-based workflow to a `rebase -ir`-based one, please
> let me know, and I will try my best to accommodate.

Another thing I noticed was that we may want to attempt to recreate
an evil merge and then stop to ask confirmation.  The "rebase -ri" I
did to sanity-check my revert for example failed to bring in the
change made in the existing evil merge when trying to recreate the
merge of the dl/merge-autostash topic into master..pu chain and
silently created a fails-to-build-from-the-source tree instead.

