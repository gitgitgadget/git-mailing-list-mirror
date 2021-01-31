Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37689C433E0
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 00:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E985164E0F
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 00:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhAaAMD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 19:12:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62459 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhAaAMD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 19:12:03 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B90A4AAC7E;
        Sat, 30 Jan 2021 19:11:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q3FHqadgppc9m8fgoCUEO7mQydE=; b=rPnOZ+
        zlFiTHzYWm91qNIxhNpj5vQHmfj3N5VXE/NfFshXZ7TzwzofdeDBphrel1p2myz9
        UJdnWl7wh9vwDBgACfNif0vwz71Vo/trn+lV34kJt/e9f8w9UAgzgUkN42KxQqBr
        YYJci2f7R/1FP22kuolatoh7js4gyTHYd+r5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p0Z78puYJ6nGh30V6EQrC+DAOGXUCsLq
        8kU5Dzp7bkW5Wh28YdSO1Kq/uzPLYWxXvJLyr/2Y5f0bakuGmKfBByuPEIvtoeYk
        Qkkicp4928q+7jJgdE7uOXPAkY0EVcAa9giDyPNAAss4aEp3fvHgSLKULNvX3yj8
        WzOoIc460Ag=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B004DAAC7C;
        Sat, 30 Jan 2021 19:11:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3CB60AAC7B;
        Sat, 30 Jan 2021 19:11:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kyle J. McKay" <mackyle@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 1/2] t/t1417: test symbolic-ref effects on ref logs
References: <7c7e8679f2da7e1475606d698b2da8c@72481c9465c8b2c4aaff8b77ab5e23c>
        <fec7ef37962da584a89012234ae4a1a@72481c9465c8b2c4aaff8b77ab5e23c>
        <xmqqa6sqp827.fsf@gitster.c.googlers.com>
        <81AEEED6-26EC-4F32-AA65-B028435D812D@gmail.com>
Date:   Sat, 30 Jan 2021 16:11:19 -0800
In-Reply-To: <81AEEED6-26EC-4F32-AA65-B028435D812D@gmail.com> (Kyle J. McKay's
        message of "Sat, 30 Jan 2021 16:26:55 -0700")
Message-ID: <xmqqo8h6nexk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D854E904-6358-11EB-B610-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kyle J. McKay" <mackyle@gmail.com> writes:

> I'm having a bit of trouble parsing that into expectations.  A little
> help please.
> Are you suggesting that (1) just be omitted?  Or that it be modified
> so that it's an "expect success" patch?

Neither.

The result of applying the current 1/2 and 2/2 on top of, say
'master', would be the shape of the tree you would want to be in.

Our preference is just to have it as a single patch, not as "first
expect failure and then flip it to expect success while modifying
the code".  That approach makes the second step harder to review
than necessary, because the "git show" output and "format-patch"
output from the step would show only very little about the test
that changes behaviour.

Even with a single patch, if somebody wants a demonstration of what
used to be broken without the code modification, it is easy to apply
only the test part of the single patch without using the code change
to see how it breaks, so "I want to demonstrate the breakage" is not
a reason to have it as a separate step.

Thanks.
