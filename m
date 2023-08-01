Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0BFC04FE0
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 18:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjHAS3J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 14:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjHAS3G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 14:29:06 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F3B26A1
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 11:28:50 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FD3A1AF71C;
        Tue,  1 Aug 2023 14:28:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JmQ54TWm9/Tc2DAjh4Alxt42oYV7/JeRfZhPF5
        4ZRbk=; b=fHm/idL2hQTBlmMu+xafF8XGp7ge6Nsp7+OzgwrK9voMHXuYrwqSVh
        TiZDQ3xfWevF3MKUxPxdWyzbyW6UASWxpVn9WRTYEXhgch3Za/HPWNxugs1eT1MS
        nY2CGn8lwlEdZouym0QgrnWxW86KC8+34nfR3QXDIGkUCqlUlZJIA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38C571AF71B;
        Tue,  1 Aug 2023 14:28:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D32B1AF71A;
        Tue,  1 Aug 2023 14:28:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Namikaze Minato <LLoydsensei+git@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-switch history and checkout compatibility
References: <CACmJb3yoHagaU1wb4qRT-nZV4Wptao8boaUXCAYrFxfrxcmUYg@mail.gmail.com>
        <CACmJb3xWh+0BR_V6sxfMK7iMSdWfvY9d2rjt1hnZhFw70zWweA@mail.gmail.com>
        <xmqqa5wjee25.fsf@gitster.g>
        <CACmJb3wTsWdqDGrkYC0p+eB-XYBotVcFAKcXJF3ftYdiiRvEdw@mail.gmail.com>
Date:   Tue, 01 Aug 2023 11:28:47 -0700
In-Reply-To: <CACmJb3wTsWdqDGrkYC0p+eB-XYBotVcFAKcXJF3ftYdiiRvEdw@mail.gmail.com>
        (Namikaze Minato's message of "Tue, 1 Aug 2023 19:23:20 +0200")
Message-ID: <xmqqleeubork.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41927002-3099-11EE-8FF4-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Namikaze Minato <LLoydsensei+git@gmail.com> writes:

> Isn't checkout supposed to become deprecated at some point?

Deprecating "checkout" hurts those who are confused by what the
split "switch/restore" pair of commands do (cf. this very discussion
we are having), and folks who are happily using "checkout".  On the
other hand, those who are happy with "switch/restore" would not be
affected by the existence of "checkout".  So, no, I do not think it
is part of the map to deprecate the command.  At least not until the
split "switch/restore" pair of commands become less confusing and
lose their "experimental" state, that is.

> ... And as you said you were
> not among the primary advocates to add it, I guess we should wait for
> someone else to reply about this?

There are things "switch/restore" pair do differently relative to
"checkout".  Some of them (like "restore" allowing checking out
paths from tree only to the working tree files while not touching
the index, which is not possible with "checkout") are very much
welcome improvement, but some others (cf. this very discussion we
are having on "switch") may simply not make any sense.  Those who
advocated and pushed the split "switch/restore" pair should be able
to explain why they chose to do things differently much better than
I would be (some differences may simply be bugs waiting to be fixed
by them).
