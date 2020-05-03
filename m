Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01B3C3A5A9
	for <git@archiver.kernel.org>; Sun,  3 May 2020 01:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3A8A2137B
	for <git@archiver.kernel.org>; Sun,  3 May 2020 01:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mbz52bRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgECBDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 21:03:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61507 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgECBDa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 21:03:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 249B34B6A2;
        Sat,  2 May 2020 21:03:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qM1JHPO7B91xt+98jFyWHwVQMgI=; b=mbz52b
        RY0rfa/F37vZp9MMBEeqLmOpbHWvcS0WsK79NY9j3lM6QDRJ3HEvZHIrXbePNdrD
        0xh283GHCi9xkaVKbWCU9HsgHWDcKppnVp4Sh9IRdWHQiHHMebVULoeVTBs/6ZBX
        aU3P9fuIun4XTQMyDFCYb0ZCPZk8D05QHRKCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fKHRVBv0wDkGxIEDIgzqGIm3EzjHwrqU
        lTyNJesCjSsfxVtfmEbD5pqibIguNx5y/kq07HocINQoOlZLxPcYjPbbvNdFgOe+
        s/ncStVlupiHhLFM5rgqwbfSyRheXhM+Flm0hAoSMTspx8qi7ptqDCbojOUQfsEI
        ooC2uaj4dtA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C3544B6A1;
        Sat,  2 May 2020 21:03:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 887CF4B6A0;
        Sat,  2 May 2020 21:03:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 4/4] gitfaq: fetching and pulling a repository
References: <20200429093811.8475-1-shouryashukla.oo@gmail.com>
        <20200429093811.8475-4-shouryashukla.oo@gmail.com>
        <CABPp-BFt_5-OyOw9YbYJhhu1P4CJLOi65wdyRckOY5_acRejGg@mail.gmail.com>
        <20200502065745.GD5582@konoha>
        <CABPp-BGrsw1V3gUWN40DTRCPBD5ZD5kvoqdjMuEJtJKCni09_w@mail.gmail.com>
Date:   Sat, 02 May 2020 18:03:26 -0700
In-Reply-To: <CABPp-BGrsw1V3gUWN40DTRCPBD5ZD5kvoqdjMuEJtJKCni09_w@mail.gmail.com>
        (Elijah Newren's message of "Sat, 2 May 2020 12:00:36 -0700")
Message-ID: <xmqqftchkext.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E4FD4698-8CD9-11EA-B01E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> Also, a nit but, we are supposed to use 1 SP or 2 SP after a full
>> stop(.)? In India we use 1 SP, is it different in other countries?
>
> Ah, the never ending spacing debate...
>
> There may be variation country-to-country, but I doubt it's country
> specific.  It's more a raging debate based on the fact that "official"
> rules have changed multiple times, old habits die hard, different
> contexts exist for different audiences, and various other wrinkles.

https://www.theverge.com/2020/4/24/21234170 ;-)

Since very old days of print media until now and well into the
future, readers want to see longer whitespace after the end of each
sentence than whitespace between words.  Behaviour of programs that
that take your "text file" as its input and produces rendered output
differ.  Some ignore the number of spaces after the full-stop and
"do the right thing" its output (that's the norm for typesetting
systems), and others want to see only one space there, and leaves
more swhitespace than optimal if you put two or more (which is often
how WYSIWYG word processors work).

The ideal would be to keep both the source text file and rendered
output pleasant to the eyes, and that means we type two spaces after
the end of a sentence in the source (which is meant to be read in
monospace text) and we avoid formatting programs that break (i.e.
produce more spaces than desirable) when fed more than one space
after each sentence (otherwise, we would be forced to use only one
space and hurt our eyes).

I think our arrangement to go from source text through AsciiDoc or
Asciidoctor to manpage or XHTML produces the right output with two
spaces, so we are good.
