Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD676C433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 18:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 748696509B
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 18:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhCESKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 13:10:37 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51452 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhCESKN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 13:10:13 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FCB7A00CC;
        Fri,  5 Mar 2021 13:10:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gVtvmkcliMBg6vvAAuIEg+A73LI=; b=tvgN6R
        yXcHHvhhHheeOXmbd25GZ+YmzEiR7Oy/JbZ8dZ2/2So6uoEJ2PaWPoRj6J4T8nFJ
        rki3jMNZzaSEOKFwL3w1bTN7gtAxKc5+cjaU2N8N9FOTvq0Q4lmVBB4xbcTcXSg4
        Zpkbe8oka/GorVxvUDpTzfDlDhNLCOa6YfddI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fsqB6Qg4AO3zPofeguDaEmIdVJ4EdOoX
        kcbGls3AT9OpgH9GWt2y7/1WazbHa9BIbq0hQ4MSBNsg4O9X/67Eixw3EFHeGkGr
        /3rdvrb6llS2YeDUBf7yLXcicOFtiSOzdLJ5YUtBLqo1RZDXmzldkdzG99XHr0xw
        xkNZ222uJ0E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A39AA00CA;
        Fri,  5 Mar 2021 13:10:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 76D7EA00C9;
        Fri,  5 Mar 2021 13:10:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        LKML <linux-kernel@vger.kernel.org>, git <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: A note on the 5.12-rc1 tag
References: <CAHk-=wjnzdLSP3oDxhf9eMTYo7GF-QjaNLBUH1Zk3c4A7X75YA@mail.gmail.com>
        <YEFIXFyP5tWrPDMw@localhost>
        <CAP8UFD07ezNOXU5Q3RZAHOJGMjuaJY-R=x=hhQcQvYOAKzKF2g@mail.gmail.com>
Date:   Fri, 05 Mar 2021 10:10:05 -0800
In-Reply-To: <CAP8UFD07ezNOXU5Q3RZAHOJGMjuaJY-R=x=hhQcQvYOAKzKF2g@mail.gmail.com>
        (Christian Couder's message of "Fri, 5 Mar 2021 06:39:51 +0100")
Message-ID: <xmqq8s71bhfm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06323918-7DDE-11EB-8F08-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> (git notes would be nice for this, but they're hard to share reliably;
>> the above mechanism to accumulate entries from a file in the repo seems
>> simpler. I can imagine other possibilities.)
>
> If the notes are created automatically from the `/.git-bisect-skip`
> files and stored in `refs/notes/skip`, then they might not need to be
> shared. If people already share notes, they would just need to stop
> sharing those in `refs/notes/skip`.

Ehh, doesn't Josh _want_ to share them, though?  I do not know if a
single "refs/notes/bisect-skip" notes would do, or you'd need one
notes tree per the kind of bisection (iow, people may be chasing
different set of bugs, and the commits that need to be skipped while
chasing one bug may be OK to test while chasing another one), but I
would imagine that for this particular use case of marking "these
commits are dangerous to check out and build on", it does not depend
on what you are bisecting to find at all, so sharing would be a
sensible thing to do.

It is trivial for you to fetch the refs/notes/do-not--checkout notes
tree from me and merge it into your refs/notes/do-not--checkout
notes tree, I would think; "git notes merge" may have room for
improvement, but essentially it would just want a union of two
sets, no?
