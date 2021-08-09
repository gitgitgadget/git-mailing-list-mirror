Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14557C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 21:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E662660C3E
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 21:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbhHIVnm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 17:43:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62077 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbhHIVnm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 17:43:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EDECCD08F8;
        Mon,  9 Aug 2021 17:43:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tmN6Ajh6HxaFKLZCigCH3qCT9YZaiGddVfAddQ
        gN4ms=; b=kY+V2Yn820qqqLWmxFzwO1YXzqUOnsHmsw3MMDQ7SHuP+BRhcHSlT7
        Os824D+giQprsp2Tt7lUekAiFkGKmJLFMb8dhN/3G4tDF7Bb+QxOTEGip6qT+A/u
        d0xUw1P+1WIARqL+q782+R04+xAFITtpMYaDlL4qMLa49Rmla8WxQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4926D08F7;
        Mon,  9 Aug 2021 17:43:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D24BD08F5;
        Mon,  9 Aug 2021 17:43:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Kim Altintop <kim@eagain.st>, git@vger.kernel.org,
        jonathantanmy@google.com, bwilliams.eng@gmail.com
Subject: Re: [PATCH 1/3] t5730: introduce fetch command helper
References: <20210730135845.633234-1-kim@eagain.st>
        <20210731203415.618641-1-kim@eagain.st>
        <20210804203829.661565-1-kim@eagain.st>
        <20210804205951.668140-1-kim@eagain.st>
        <20210809175530.75326-1-kim@eagain.st>
        <20210809175530.75326-2-kim@eagain.st> <YRGEwFauT5QjMSNO@google.com>
Date:   Mon, 09 Aug 2021 14:43:18 -0700
In-Reply-To: <YRGEwFauT5QjMSNO@google.com> (Jonathan Nieder's message of "Mon,
        9 Aug 2021 12:40:48 -0700")
Message-ID: <xmqqtujye1l5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D06B2800-F95A-11EB-BC54-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Here the entirety of the input to "test-tool pkt-line pack" is the
> entirety of the output from write_fetch_command, which would suggest
> either
>
>  a. making write_fetch_command pipe its output to "test-tool pkt-line
>     pack", or
>
>  b. using a pipe instead of a command substitution, like
>     "write_fetch_command ... | test-tool pkt-line pack >in"
>
> (although as mentioned above, I think it's simpler to inline the
> write_fetch_command and even the write_command as well).

Yeah, write_command was not saving all that much to begin with.  I
was hoping that there were a lot more commonality that we can save
some typing.


