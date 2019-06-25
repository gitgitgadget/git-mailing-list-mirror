Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5F471F461
	for <e@80x24.org>; Tue, 25 Jun 2019 17:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfFYRvA (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 13:51:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61532 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfFYRu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 13:50:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 76B1A82E1D;
        Tue, 25 Jun 2019 13:50:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WTrfAtCWZ4ar74wb8L4WhJVKN4U=; b=MwxMnL
        PyfH5HvSua8NesLzsmxwsDOnRaxU1YXS0Ki+JbPfcySElf3HEsUu3TdvwpC5rubQ
        4jW0O0h10VMxXD440G36QHIV2IVL1vv6ZA3hQDm13+hr1WWZ0/ZdIqPzKxRM15Wu
        XKXJnXKJLUbw4LRMb6XtjiI9ZlR1f3nm0np+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BgI43mlSpxXCyS9iq3sfVHk3fwGTaG4g
        LQhCcAcQ9c7lcO4BNVz7p0O50H9BWcYwH0KJz/mKWE+OlFSgmk0hi1x6kHXfMy/A
        JUy+wQbBcqF0ZEl8pJm/0C/EXY6t5sbiqrFJ6VzHF3CKmAS3wBuNzvotsZxlUCwZ
        hasRCPasrHg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6E67E82E1C;
        Tue, 25 Jun 2019 13:50:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 62C2E82E19;
        Tue, 25 Jun 2019 13:50:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 00/20] Fix MSVC support, at long last
References: <pull.149.v2.git.gitgitgadget@gmail.com>
        <pull.149.v3.git.gitgitgadget@gmail.com>
Date:   Tue, 25 Jun 2019 10:50:54 -0700
In-Reply-To: <pull.149.v3.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Tue, 25 Jun 2019 07:49:28 -0700 (PDT)")
Message-ID: <xmqqmui5fta9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C89B1178-9771-11E9-BA70-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Philip Oakley and Jeff Hostetler worked quite a bit on getting Git to
> compile with MS Visual C again, and this patch series is the culmination of
> those efforts.

Thanks, all.  Relative to the previous round, it seems there is only
one patch changed, which is a sign that it is stabilizing rather
quickly ;-).

> Please also note that this patch series is part 1 of 3 in a bigger story:
> the next patch series will add support to build Git in Microsoft Visual
> Studio, and the third patch series will add Continuous Testing by adding an
> MSVC build and a corresponding parallelized test job to our Azure Pipeline.
>
> Changes since v2:
>
>  * Fixed the incorrect split-out of the "msvc: update Makefile to allow for
>    spaces in the compiler path" patch: I had accidentally reverted that
>    change in a later patch in the series.

Yup.  BROKEN_PATH_FIX stuff appears only once now in the series ;-)

Will queue.  Again, thanks all.
