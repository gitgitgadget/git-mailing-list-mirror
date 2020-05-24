Return-Path: <SRS0=NZH0=7G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C777C433E0
	for <git@archiver.kernel.org>; Sun, 24 May 2020 16:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF0B320776
	for <git@archiver.kernel.org>; Sun, 24 May 2020 16:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rjEohgLf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgEXQPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 May 2020 12:15:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56653 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgEXQPh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 May 2020 12:15:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3000965D8C;
        Sun, 24 May 2020 12:15:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IfG1YwmHHIBl
        ei5bkRHgXB1BHHY=; b=rjEohgLf7zCE1BXrjdrP8a0BwuCgH1pn/NBtFuaSBJGN
        f+VHnHeBD9M1g0gSTfpE6BMvqiPzXND3Fu+HmYn9DT19SXk+iGSw/Tm4psf97NQd
        /MU8I5/1UmCCCjRWJOYoQHkKx8CQxzofFoNqwr3aYbZcq7+jA55Eiye8E5hkXFs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KqfCDL
        vIo5F5S43L55l8uRe89vwRvMFM0dExnu8gY5+SPKzsZp8Ra6z/xfjEPHzcA7X4fW
        o6Cjx4T3nNV4zR9dZ1hhZ55pSoBvBBD2vgyoB+l8rO/Zwt9PtRdYAa+JnJb+ggVx
        9Pc0/zctvNiYXcr39QkhfVjhTa6NK/rfApa6k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FFB365D8A;
        Sun, 24 May 2020 12:15:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7967565D89;
        Sun, 24 May 2020 12:15:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Dana Dahlstrom <dahlstrom@google.com>,
        git@vger.kernel.org
Subject: Re: 'HEAD' is not a commit (according to git-checkout)
References: <CACqwCQiLpZ1HFzgJw0p0KR3jXNsxkhjXmF_huzhv+qkMZmybBQ@mail.gmail.com>
        <20200521191626.GC1308489@coredump.intra.peff.net>
        <9f26099a-e77b-ede4-bee3-27382a5a0875@web.de>
        <20200523162914.GA2178752@coredump.intra.peff.net>
        <ad267e83-eea0-bb78-d88c-a37a28d04dbe@web.de>
Date:   Sun, 24 May 2020 09:15:33 -0700
In-Reply-To: <ad267e83-eea0-bb78-d88c-a37a28d04dbe@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 24 May 2020 09:23:32 +0200")
Message-ID: <xmqqimglqpga.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CC0D833A-9DD9-11EA-952F-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> OK, but stepping back a bit and trying to forget what I know about the
> option --track and pretending to see it for the first time, I have to
> ask: Why doesn't it take an argument?  If I check out a raw commit, it
> cannot guess the upstream branch anyway.  So I'd assume this to work:
>
>    git checkout -b new-branch --track=3Dupstream start-point

Assuming that --track option is marked with PARSE_OPT_OPTARG and
when the option is given, we internally do a rev-parse of both
upstream and start-point and make sure the tip of the "track" is an
ancestor of the "start-point", I think it makes sense.  That would
catch cases like this:

	git checkout --detach origin/master
	... work work work ...
	git checkout -b new-branch --track=3Dorigin/master HEAD

On the other hand, some use case might want to go the other way, e.g.

	git checkout --detach origin/master~12
	... work to fix an older bug ...
	git checkout -b new-branch --track=3Dorigin/master HEAD

in which case the start-point and the current tip of the tracking
branch has no relation other than they share a common ancestor.

So, should we allow a random upstream & start-point combination?  It
appears to me that as long as they share _some_ common ancestory, it
may make sense.
