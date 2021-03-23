Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E6CC433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 06:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 626F0619B6
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 06:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhCWGnA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 02:43:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57212 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhCWGma (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 02:42:30 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2AB2E11C946;
        Tue, 23 Mar 2021 02:42:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DshO2J+hFj3kALGgmQiL+0XgCcY=; b=DX9SkT
        9qzwq5AjOBuaSTO9SeYJ79/GSmO0ly2iDR9+unWnwG8GB3ksWK5QdqNTKlO93jX5
        8270+2MF41ML/PETJkw5CkLHWUlBkpdMBySZsOiJIEAe64+7pKKEkZUxmQJifGPL
        spRCHxASQksn3rwb/q4LkvzRleD6l3AwcDnzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IyWfGPn8c4MFqN6HlV9M3MAZn6YJ3Giy
        h0w9xv07r0Qx6y0Cl/SmSbMHR6XLgVaGkHnJEnlibHdoH9jAEbMYinCGZx24G4CO
        59hZCmNudWJbGxu1ZXrfr8QxlbvYBoDL1CCAblZzfRkfGPvSTqcFG5yacko+K9jT
        oB9IPiep4aI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1396011C945;
        Tue, 23 Mar 2021 02:42:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4AB1511C944;
        Tue, 23 Mar 2021 02:42:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v9] format-patch: allow a non-integral version numbers
References: <pull.885.v8.git.1616252178414.gitgitgadget@gmail.com>
        <pull.885.v9.git.1616317225769.gitgitgadget@gmail.com>
        <CAPig+cQ5jBc-fz69ygpWUP7uCVNAT8GT_01y6GnxDEa6XDNZ=g@mail.gmail.com>
Date:   Mon, 22 Mar 2021 23:42:25 -0700
In-Reply-To: <CAPig+cQ5jBc-fz69ygpWUP7uCVNAT8GT_01y6GnxDEa6XDNZ=g@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 23 Mar 2021 01:31:07 -0400")
Message-ID: <xmqqmtuu4bhq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EEDB6870-8BA2-11EB-BB7F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Mar 21, 2021 at 5:00 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> [...]
>> Allow `format-patch` to take such a non-integral iteration
>> number.
>> [...]
>> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
>
> Just a few nits below; nothing very important (except perhaps the
> final comment about the potential for people to get confused while
> reading the tests). Junio already has this marked as ready to merge to
> "next", so these nits may not be worth a re-roll.

Oh, we just rebuilt 'next' and anything not in 'next' is not too
late to reroll.  Your comments on the test part were all sensible.

Thanks.
