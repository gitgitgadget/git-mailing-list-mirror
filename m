Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80018C43214
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C27560232
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237983AbhH3RFu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 13:05:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59614 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237892AbhH3RFu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 13:05:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1B54614D557;
        Mon, 30 Aug 2021 13:04:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OBsngRiJevXK
        N6jpMUL8ZnIeDmyDVbRGhGCcEm+qYVw=; b=GWMA8ZvO0oPiw8tBXuHONXjwRPMQ
        f/59+PwIv+AHhSBDllzmKjBi6NY8r+6MAyHk9777PW4xZhFwCmTx4oaa4wAoVZG7
        OWnLF5Mhkgu0eYw+F1ahE7kQ7AgKjDrBR/2U6rzzUlPsFu8PBdIpPeJOWCryTyIv
        GrIMq7l+mICyZPs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 156C914D556;
        Mon, 30 Aug 2021 13:04:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5A38814D555;
        Mon, 30 Aug 2021 13:04:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC PATCH v2 0/2] suppress trailing whitespace on empty
 "notes" lines
References: <20210830072118.91921-1-sunshine@sunshineco.com>
        <RFC-cover-v2-0.2-00000000000-20210830T103913Z-avarab@gmail.com>
Date:   Mon, 30 Aug 2021 10:04:51 -0700
In-Reply-To: <RFC-cover-v2-0.2-00000000000-20210830T103913Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 30 Aug
 2021 12:47:12
        +0200")
Message-ID: <xmqqa6ky6ez0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 64EFEA38-09B4-11EC-9D5C-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This is a review of Eric Sunshin's
> <20210830072118.91921-1-sunshine@sunshineco.com> series.
>
> Side note:
>
>     I'm generally trying to see if just sending a "proposed vX" is
>     more productive for everyone than patch feedback effectively
>     describing it in prose. I don't mean for this thing to be picked
>     up as-is by Junio without the consent of the submitter, and don't
>     have any desire to "pick up" the series myself.

It is impossible to read the rationale behind the change between v1
and "proposed v2" in such arrangement, simply because there is no
place in the "proposed v2" patch to write it down.  Proposed commit
log for it should not refer to what "v1" said, proposed postimage of
the patch should not refer to what "v1" did.  Worse, it is harder to
pick good bits from "proposed v2" and reject the others.

It is not a good way to give a feedback on "v1".  It does not help
the original author.

It certainly does not help the maintainer, who now has to read two
competing series, sort out the numbering mess.

I do not know if it helps other reviewers, but offhand I do not know
how it would, compared to the in-line comments on "v1", which is how
we usually do reviews.

>     My review workflow is just applying the patches locally, fiddling
>     with them, so it seems like the most straightforward and helpful
>     thing to send the result of that local end-state, rather than
>     describing the changes I made in prose, and expect the original
>     submitter to reverse engineer that state if they're interested in
>     trying it out locally themselves.

The end-state as an additional reference material attached as the
end note of the review may be helpful, but the in-line comments on
"v1" is a much better way to convey the reason why the change is
suggested, I would think.
