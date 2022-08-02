Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B439CC00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 21:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbiHBVLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 17:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbiHBVLm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 17:11:42 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C7B46D95
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 14:11:41 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10BE112DDAC;
        Tue,  2 Aug 2022 17:11:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HeGYMXeDZdTkBbZpAqKK6TL0vh71xLx0c41pBl
        OdTaI=; b=uJ06z1bSiNjPBBIRSGSVp7xXD02BZlw73wzsgtUTeJY9LjJZUxew0X
        i5HH53e+xWzp305ZJdhvjDSkKHUqGBm+79aRY5WIQG/mh1Mt0K4LKNauPAo/yPbS
        L94abbNBFqDk8lrnRIVEvmq7tWcJf/t3ZozcLTbYz/dmLVgPy21fw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 07A6012DDAB;
        Tue,  2 Aug 2022 17:11:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E6E712DDAA;
        Tue,  2 Aug 2022 17:11:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com, Johannes.Schindelin@gmx.de,
        avarab@gmail.com
Subject: Re: [PATCH v7] submodule merge: update conflict error message
References: <20220726210020.3397249-1-calvinwan@google.com>
        <20220728211221.2913928-1-calvinwan@google.com>
        <xmqqpmhjjwo9.fsf@gitster.g>
        <CAFySSZCEWX22h1FBX65=eofNm+WU97DtL7P+11WFie72DQLDkg@mail.gmail.com>
Date:   Tue, 02 Aug 2022 14:11:38 -0700
In-Reply-To: <CAFySSZCEWX22h1FBX65=eofNm+WU97DtL7P+11WFie72DQLDkg@mail.gmail.com>
        (Calvin Wan's message of "Tue, 2 Aug 2022 14:03:07 -0700")
Message-ID: <xmqqo7x2fj05.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3DB2084-12A7-11ED-B321-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> I'm thinking something like this:
>
> "go to submodule ('sub' : 'a'), and either merge commit 'b'\n"
> "go to submodule ('sub', 'a'), and either merge commit 'b'\n"
> "go to submodule 'sub', commit 'a', and either merge commit 'b'\n"

In the first two, I suspect that it may not be quite clear what 'a'
means to the user.  In the third one, the first "commit" might be
mistaken as a verb.  I am tempted to say

    cd to <sub>, run "checkout --detach <a>" then "merge <b>"

but that may be a bit too prescriptive.  I dunno.



