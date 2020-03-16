Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E3AC0044D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 18:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940D720674
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 18:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mGTPispZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732307AbgCPSfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:35:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57124 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731967AbgCPSfL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 14:35:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5C49ABD6D5;
        Mon, 16 Mar 2020 14:35:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t+WveRqCWS7i5FuS7bQOrIXHTcY=; b=mGTPis
        pZv+3z10+lybQVwYep/ZS3zgkyFFdMZJjiVYiq96ZmEOyBzzo5ikpi9X1CB+7IN6
        +RfCiKQNM7rUl9A5fYsOp6VVJ0aSLJ6nsfYz4jo7c3l2ZKew+GJgXFD0BsYWGRAA
        sEKtDXnkjI63VjPaGcWE1kffsuy4HyVXfEIGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xttxVGBV8439ZUmrulPK+AM1Wp70eFIY
        WV+NKHkvdXDckCh2d174i+4L2j3GdxMb1l6MsTJws/yG3stUNEwBsDe/oFoPPOVN
        WLZvsPQRV73J0PsJwosQt6pM6z1Q+V+1uTmnN9jKsqNGVRi//XzE0S3SbbfVc7SP
        UVfS8251BC8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 552DFBD6D4;
        Mon, 16 Mar 2020 14:35:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 99F1FBD6CB;
        Mon, 16 Mar 2020 14:35:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] dir: improve naming of oid_stat fields in two structs
References: <cover.1584329834.git.matheus.bernardino@usp.br>
        <6fee28469e49d501e5184162bc820350f60cc3de.1584329834.git.matheus.bernardino@usp.br>
        <xmqq1rpsako1.fsf@gitster.c.googlers.com>
        <CAHd-oW4OpoW0Qbp6_HfFiXRXasLXVnw3hDkzDG3S4WR3yH9Wuw@mail.gmail.com>
        <xmqqsgi8882t.fsf@gitster.c.googlers.com>
Date:   Mon, 16 Mar 2020 11:35:04 -0700
In-Reply-To: <xmqqsgi8882t.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 16 Mar 2020 11:31:54 -0700")
Message-ID: <xmqqo8sw87xj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBBAD9FA-67B4-11EA-ACBD-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The potential for confusion with "path to these files" is real, I
> would think, so they may benefit from some prefix.
>
> But instead of basing the prefix on their type, can we name it after
> what this struct holds about the excludes file, and what the data
> the struct holds is used for?  Is "oidst" something that conveys it
> well to the readers of the code?
> ...
> In a sense, this struct is a pared down version of cache_entry that
> keeps the filesystem stat data to allow us quickly find if the path
> was modified, and also lets us know if two contents are the same
> without comparing bytes.  It is a mechanism for us to tell validity
> of our cached data.  "struct path_validity" perhaps?  I dunno.

I think "path_validity", while it probably is much better than
"oid_stat", is a horrible name for the struct, so I'd welcome
suggestions from third-party ;-)

But I think renaming "ss_info_exclude" to "info_exclude_validity"
(or any name that talks about "info/exclude" and "validity") would
be a vast improvement, regardless of what the struct is called.
