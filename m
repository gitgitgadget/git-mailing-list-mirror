Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F439C433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 16:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55FC420781
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 16:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EV2GEQ2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgHCQT7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:19:59 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59156 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgHCQT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 12:19:59 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2985FD2120;
        Mon,  3 Aug 2020 12:19:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WZtfXPL08o/KM7fAxV9esa6CPnU=; b=EV2GEQ
        2eyAA1E7xgrP9/ZNMRrCIc84/05H/lfkgFXpWlVQn1oRBiON86514hgAD3teURsI
        6zH4RfIxdG8Qu/eUADIh5sFPeNMPooRg8cXg4DsK/4iMGzZh6elOZcajK236cYME
        rmUGXv1+5oLEs58p8if++g+NowVRlrsmiklu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IZRGHEhOx8v3g+dDT/nXNjgLzcsLcqy5
        8Wm1uk/H0lutcI8RbcJ8ueMZQLlRB+xoQ2tV8Wwdhu/MEfOhzHVJcZ5IpYNDJDwI
        +C6B+hN4gIQUlo2TwaqVSxfg4dgeviOlWqEzbeAEp78BmLjNkIcSy9BoaKAQEAH3
        t9/GQvvRo1E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 23542D211E;
        Mon,  3 Aug 2020 12:19:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 659B6D211C;
        Mon,  3 Aug 2020 12:19:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
Subject: Re: Renaming the "master" branch without breaking existing clones
References: <ec960483f5008e9948271c678d51876920ab62c9.camel@mattmccutchen.net>
        <20200803160051.GA50799@syl.lan>
Date:   Mon, 03 Aug 2020 09:19:52 -0700
In-Reply-To: <20200803160051.GA50799@syl.lan> (Taylor Blau's message of "Mon,
        3 Aug 2020 12:00:51 -0400")
Message-ID: <xmqqh7tjwvkn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A4DF3D2-D5A5-11EA-80D0-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I am a little uncomfortable with the idea that a 'git pull' would modify
> 'refs/{heads,tags}' in addition to 'refs/remotes'.

Those who want to rename their own branches should be allowed to do
so easily when it is convenient for them to do so, whether the
reason for renaming their local branch is because their upstream
renamed the branches they are interested in and have good reasons to
use the same name, or because they made a typo when they created
their local brnach, but I do not think renaming the local branch
should be done automatically.
