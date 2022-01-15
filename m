Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E369C433EF
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 19:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbiAOTPH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jan 2022 14:15:07 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52158 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiAOTPG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jan 2022 14:15:06 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 30C4C16D0B5;
        Sat, 15 Jan 2022 14:15:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g/pQ7b8ooqhxgTpVRPjXo+/8N1gSM/CZ34QWgv
        d93Ag=; b=oDh7ESYb2aISxmXE3J2Y3wT6cB3M9TPSWmxwleNaKOzvk2fEgG1aG9
        sbqioQj909v9+ck52u24LpC6hiA4E9rsMmpDliTgY2vycPcZpS309Myw8jJsJcEu
        QhJC+sgtZ01YS12vvuYwBUvwKJUR7UGLWX1RiHNdq2CELj4o1hVe0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A46C16D0B4;
        Sat, 15 Jan 2022 14:15:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7C66316D0B3;
        Sat, 15 Jan 2022 14:15:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jan 2022, #03; Thu, 13)
References: <xmqq35lrf8g4.fsf@gitster.g>
        <CAJDDKr7bYP7JNmY7XML0rkxv8uCKAbO-LdAAn0KkyTq3UX4hkg@mail.gmail.com>
Date:   Sat, 15 Jan 2022 11:15:02 -0800
In-Reply-To: <CAJDDKr7bYP7JNmY7XML0rkxv8uCKAbO-LdAAn0KkyTq3UX4hkg@mail.gmail.com>
        (David Aguilar's message of "Sat, 15 Jan 2022 08:45:02 -0800")
Message-ID: <xmqqo84c4xqh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7126339E-7637-11EC-A989-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> I ran into the c99 test balloon. I get the (expected?) c99 build
> errors and an uncompress2 build error with RHEL7.9's stock gcc 4.8.5.
>
> Are we dropping support for RHEL7.9?

No.  Our expectation is that those who care about various distros
and platforms supply patches like ...

> Using NO_UNCOMPRESS2=YesPlease and CFLAGS += -std=c99 in config.mak

... this, but not locallly but to config.mak.uname, to help the
users and builders on their favorite systems.  It is better done
sooner rather than later.

> works but I'm not sure if we actually expect users to deal with those
> details themselves.

Users would not have to, as long as somebody else on the list uses
the smea system as theirs cares enough to supply such patches to
config.mak.uname.

> Sorry for being out of the loop on the plan for older toolchains, but
> I wasn't sure if we should be expecting a patch that configures the
> default flags so that things build out of the box again or if this is
> considered the new status quo and we're okay regressing?

Obviously the former.  This is a team effort and everybody who finds
new issues is very appreciated to chip in.

