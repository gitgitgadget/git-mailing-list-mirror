Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8A5C433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 18:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4492520738
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 18:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kYmzBC+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgHXSTo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:19:44 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54290 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgHXSTn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 14:19:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E141ED94F7;
        Mon, 24 Aug 2020 14:19:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5uCNkD+oMETrC34WUJlvyom+UDY=; b=kYmzBC
        +EFAIfW00qtUQQR6RyLQrP+zGUII6T1qiPALKHdOsbnzwqZ6GP/Ac+rfmTGpg5Ss
        Z+3C3/T1azMMvwh58j4rr6YnUw9CDE3NcFSDmMt3MQyYC8hBMPgcNXbOEy5F4tbY
        SRYxA1m8K4fJCFb3JDI7B3J4wqH7Ddr6dj4vY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PIeNpfu+t8VAJqnZ2Y/9o08AXG/kSjYe
        FEa268ekuSdsktO3nAKOGdyAa6pzFV0Ly0d4fFup0/6Ee94AeaWUx1ADqZh3cPnS
        KTPbZb8uEKbGSte0AVc5cqdY3HsJVwgFocPmXATYeNLbG21/SesnH/W/qx1yW384
        hhD6K0GA9n4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D8B15D94F6;
        Mon, 24 Aug 2020 14:19:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 15414D94F5;
        Mon, 24 Aug 2020 14:19:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edwin Peer <espeer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        "David A . Wheeler" <dwheeler@dwheeler.com>,
        Jameson Miller <jamill@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        kuba@kernel.org
Subject: Re: [PATCH] commit: provide option to add Fixes tags to log
References: <20200824061156.1929850-1-espeer@gmail.com>
Date:   Mon, 24 Aug 2020 11:19:37 -0700
In-Reply-To: <20200824061156.1929850-1-espeer@gmail.com> (Edwin Peer's message
        of "Sun, 23 Aug 2020 23:11:56 -0700")
Message-ID: <xmqqft8b6h52.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F6149A6-E636-11EA-A9F6-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edwin Peer <espeer@gmail.com> writes:

> The Linux style Fixes tag has been adopted by many projects and represents
> best practice for referring to previous commits which introduce a bug that
> has been fixed by the present commit. Creating these tags manually can be
> error prone and doing so using git log -1 --format='Fixes: %h ("%s")' is
> cumbersome. It's time the commit command learn to perform this popular
> pattern natively.

Sorry, but not in this form.

It is not a reasonable way forward to add a new "--<trailer>" option
to each and every conceivable "Trailer:" a random person wants to
add to the command line.  The presence of "-s" (signoff) option was
an early "mistake" we made, not something we would want to mimic and
make things worse (besides, "Fixes" is not necessarily used with any
object name---projects can use an identifier used in their bug
trackers).

The "interpret-trailers" (Christian CC'ed) subsystem was an attempt
to create a foundation to consistently treat these lines in the
trailer block and the hope back when it was invented was to
eventually integrate it to these subcommands that want to process
commit log messages (like "rebase", "commit", etc.), but it hasn't
happened yet.  And that may be the approach we would want to take.

For example, imagine that "git commit", "git am", etc. learns to
take a new option whose canonical form is to spell it like so:

	--trailer=<trailer>:<arg>

while (optionally) allowing any unrecognized command line option

	--<trailer>=<arg>

to be internally rewritten into the canonical form, as long as <trailer>
is what the interpret-trailers subsystem recognises as configured.  That
would extend the command line option for "git commit" etc. with new

	--trailer=fixes:foo
	--fixes=foo

(the latter is available only if there is no "--fixes" option used
by the implementation of subcommands for other purposes, but the
former is always available) without having to add any new code. 

That kind of future I'd be happy to see.  Not with individual option
with fixed semantics tailored to a single project's convention.

Thanks.

