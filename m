Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E9BC001DF
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 16:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjGQQwB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jul 2023 12:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjGQQvy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 12:51:54 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645921709
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 09:51:47 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C920D1D503;
        Mon, 17 Jul 2023 12:51:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XwoHXd/l/VsTpvd+EWomXOCyBW/6avZnab0eFq
        NBVVw=; b=FOnx55jFA/YeLp0vsIiwogRDAcpX4NlehK7TwdMPa6WiDOsW1F9zsl
        bnWIVW/ai6bjwaNIUdiexdKIlniaKrsgFgrQ7JZhwUzQNMb7JPD4m2yX5UHNZliy
        oekGkAv6GscovWaHmnswoLJ/LwLRQe6chUGYwJRjoWKy+rE/dvwmQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C1A0E1D502;
        Mon, 17 Jul 2023 12:51:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 454FC1D501;
        Mon, 17 Jul 2023 12:51:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "AtariDreams via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH] Prefer fgetc over fgets where possible
References: <pull.1550.git.git.1689608291732.gitgitgadget@gmail.com>
Date:   Mon, 17 Jul 2023 09:51:42 -0700
In-Reply-To: <pull.1550.git.git.1689608291732.gitgitgadget@gmail.com>
        (AtariDreams via GitGitGadget's message of "Mon, 17 Jul 2023 15:38:11
        +0000")
Message-ID: <xmqq7cqyiiqp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3562D8D6-24C2-11EE-AE8F-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"AtariDreams via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Seija Kijin <doremylover123@gmail.com>
>
> fputc is meant for single characters,
> fputs is for strings. We are better off
> inserting sole \n characters as
> characters, not whole strings.

I do not see if these short lines are deliberate; are they meant to
follow some sort of poetry styles?

In any case, while the above is correct, I do not see the patch
noise is worth it in this particular case.  Yes, if we are writing
code snippets shown with the context in these hunks afresh, please
carefully choose between fputs() and fputc().  But once the code is
written and it is in, it is not worth to go back and fix it, unless
we are fixing surrounding area and doing the clean-up as a "while at
it" change.

By the way, because my mail program warned against an address that
apparently refuses to receive any replies, I had to manually remove
"AtariDreams <83477269+AtariDreams@users.noreply.github.com>" while
composing this message.  I'd appreciate it if you arrange to ensure
that your next patch will not have such addresses on your CC: line.

Thanks.

