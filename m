Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA93C43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 01:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B86E206E6
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 01:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="myZanXMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgC2BeY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 21:34:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52095 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbgC2BeY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 21:34:24 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5F9D2C31BA;
        Sat, 28 Mar 2020 21:34:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aniw+C2r/BNvJrJ2iw9CxUvlPJY=; b=myZanX
        MaNHXDV7SFHOet7/0wzIfpjamL+QbVsbbVGVd7Ecgsa41QEqeN4rIOqApRG9S7ia
        dU73QGXx4KktZHtqMgIOMGM0wmzCLWqLiBjECZ2tguJCM2ZYZ3f1rG8FtZu5RTqP
        6nrtYNd8ghVbdO0B7klhY0CRSS89j+fpIluEs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GE8B9uQ6ZKal8miNflwQjjNVTpM11GBU
        eSg6qqB8lZo+31cRlD32FnI98W3AmyVL21pf/cG8KAs3P5XRoSmyjVS5hPxCRrBo
        RSsWqQgRGee13bba+bUpJIT7ElrCRHAV/Se8f1TqwuF4vSzN7QKfM+ilpN2smB4Z
        KPrDP6BidrE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 56D13C31B9;
        Sat, 28 Mar 2020 21:34:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A578AC31B6;
        Sat, 28 Mar 2020 21:34:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] doc: log takes multiple revision ranges
References: <pull.590.git.1585429894378.gitgitgadget@gmail.com>
Date:   Sat, 28 Mar 2020 18:34:14 -0700
In-Reply-To: <pull.590.git.1585429894378.gitgitgadget@gmail.com> (Philippe
        Blain via GitGitGadget's message of "Sat, 28 Mar 2020 21:11:34 +0000")
Message-ID: <xmqqd08wc5bd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67488600-715D-11EA-81C4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> `git log` accepts multiple revision ranges, but makes no mention of that
> in its documentation. Currently readers have to go to the `git
> rev-list` documentation to discover this useful feature.

I have a mixed feeling about this change.  Surely you can write

	git log   v1.0..v2.0   v4.0..v5.0 -- Makefile

and you can explain that the command appears to take two "ranges",
but I do not think we want to encourage it to those who do not
understand what the above actually *means*.  

Specifially, it does *NOT* list commits between v1.0 and v2.0, or
between v4.0 and v5.0, that touch the path Makefile.  In other
words, you didn't really give two ranges with the syntax.  What the
A..B notation means could be called a range, only when it appears
alone.

And we have *no* intention of changing the semantics.

"A..B" is a mere short-hand for ^A B, and it may appear to be a
range, but "A..B C..D" does not make "two ranges".  It still merely
is a short-hand for ^A B ^C D, and if C reaches A and B (in the
above example, v4.0 is very likely to reach both v1.0 and v2.0), it
means the same thing as "C..D", i.e. "git log v4.0..v5.0 -- Makefile".

So I have a mildly strong opinion against the change to the synopsys
and the short-help; it is a bad change that does not help users.  If
there are not sufficient explanation on the equivalence between A..B
and ^A B on "git log" documentation but there is one elsewhere, adding
a reference to help users learn is very much appreciated, though, and
I initially was hoping that the second hunk of this patch was such a
change, but it appears that it is not (it just adds the misleading
"you can have more than one" without making readers aware of what it
means to write "A..B C..D").

Thanks.

