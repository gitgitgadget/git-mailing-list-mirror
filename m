Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996BFECAAA1
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 17:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiIORJA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 13:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiIORI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 13:08:59 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC2C74B8A
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 10:08:57 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A2AD1154D38;
        Thu, 15 Sep 2022 13:08:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cQF+AqlHRO0DdkhbGMrtqTephyfFjVTY0jY7m6
        y6RRU=; b=hi5zSEHZRWNT+gFvdTuuXl+ZxUHiDOlojtNbbzuUgwRn367sTxnMXC
        9hgDuZvN/gUnFLyL23nKaf2rjgaQal0WLWgeFwtNCoH67jF0Wewwi3IlxvwUlvMC
        scpQH14gxUKsvRbpfz03yUZW9R9qKiGxNKvwG00KUiYtskynVMyGw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A2E3154D37;
        Thu, 15 Sep 2022 13:08:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 04186154D35;
        Thu, 15 Sep 2022 13:08:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Stopak <jacob@initialcommit.io>, git@vger.kernel.org
Subject: Re: Newbie contribution idea for 'git log --children': input requested
References: <Yx5qjPhZ5AHkPHr7@MacBook-Pro-3.local>
        <xmqqillth1am.fsf@gitster.g>
        <YyKzOk5AQBz1pmAh@coredump.intra.peff.net>
Date:   Thu, 15 Sep 2022 10:08:54 -0700
In-Reply-To: <YyKzOk5AQBz1pmAh@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 15 Sep 2022 00:08:10 -0500")
Message-ID: <xmqqk064o995.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14F45CDA-3519-11ED-8A8A-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Just sketching out an implementation, I think it is kind of similar to
> the "decorate" mechanism, where we build the commit->metadata mapping
> ahead of time, and then add output to the commits that we show. So we'd
> probably want to load it around the same time we call
> load_ref_decorations().

Yup, and yuck.  I personaly doubt that the current --children is all
that useful to begin with, and as you later mention, it would not be
useful without some interactive "jump to" feature, either using the
pager over "log --graph --oneline" output or "tig".

Thanks.
