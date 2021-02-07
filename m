Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F03FC433E0
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 20:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39FE664DE3
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 20:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhBGUKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 15:10:37 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65114 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGUKh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 15:10:37 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DE9EF9AA51;
        Sun,  7 Feb 2021 15:09:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vnQmdzmMeFtxMW9KUe0mZmvNz/E=; b=uRPnPl
        VN5EGh8tRJp90B8LytmN1HNizQ9+StyZPMoKUdnPx3uKB0Q8ZzWieVK9rExhnRav
        vSiOdcSa5FYja5rgPNEdkZAdF6EKD9xeuaJ2fxmQTbIvay1CWWFDBSRd7EdAtcD0
        l/WT+4jB8262/ux0mvBDAZmwkXRrFbYoe0wgs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rlF24MzSKuUIxUMbS/46PKZwE1wL2iuB
        vd5LU1G31gRg17fKiilsAnfumevVqd/Lnvdb7wvSsHuLgylXh3+VDV4s7URitDcO
        HW4bzQfxIQhKKNgmA+qVo2tSDjnYjvyxLh8gCf8qXFpux5NIgL4BUJ8YNa08oENF
        3yQyqnPe3EI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C619F9AA50;
        Sun,  7 Feb 2021 15:09:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 424459AA4E;
        Sun,  7 Feb 2021 15:09:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hariom verma <hariom18599@gmail.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 3/3] ref-filter: use pretty.c logic for trailers
References: <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
        <pull.726.v3.git.1612602945.gitgitgadget@gmail.com>
        <47d89f872314cad6dc6010ff3c8ade43a70bc540.1612602945.git.gitgitgadget@gmail.com>
        <xmqqpn1c8m7u.fsf@gitster.c.googlers.com>
        <CA+CkUQ9-OCiEkMDRTpyF3rp-g1mSSzn4s9MgqJZ2BJY=XJCoEw@mail.gmail.com>
        <xmqqh7mn91w2.fsf@gitster.c.googlers.com>
        <CA+CkUQ9kHhbDVMru=pRO90o+k7cc_ykxN9JRFGMvoG3hkeGJpA@mail.gmail.com>
Date:   Sun, 07 Feb 2021 12:09:53 -0800
In-Reply-To: <CA+CkUQ9kHhbDVMru=pRO90o+k7cc_ykxN9JRFGMvoG3hkeGJpA@mail.gmail.com>
        (Hariom verma's message of "Mon, 8 Feb 2021 01:08:26 +0530")
Message-ID: <xmqqlfbz7i7i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7152A510-6980-11EB-A219-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hariom verma <hariom18599@gmail.com> writes:

> As per my understanding it works something like this:
>
> print a ref item... put newline... print a ref item... put newline..
> print a ref item... put newline... (so on)
>
> But the catch is that trailer comes with a newline already included.
> So it becomes:
>
> print trailers with newline included... put newline... print trailers
> with newline included... put newline.. (so on)

We know how it happens.  The question is if that is a sensible
behaviour, and if the trailing blank line was _intended_, or a bug
that nobody has complained about so far.

> we just can't directly remove the newline.

If we agree that the current behaviour is *not* sensible, then we
can.  On the "log --pretty" side, we have "terminator semantics" and
"separator semantics" between "tformat" and "format", when showing
more than one commits in a row, the "terminator semantics" places
one blank line after each commit we emit, while the "separator
semantics" gives one blank line between each commit pair.  I think
we initially (incorrectly) used terminator semantics and our output
for two commits looked like "CommitA <blank> CommitB <blank>" before
we fixed it to use separator semantics to show "CommitA <blank> CommitB"
without the useless trailing blank line.  We can apply the same principle
when "fixing" this issue to show a block of trailer lines (that is, the
change in behaviour to remove the trailing blank line turns out to
be a "fix").
