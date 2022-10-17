Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AFAC433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 15:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiJQPTG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 11:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbiJQPTC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 11:19:02 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992BA52457
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 08:19:01 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AD5E71CB935;
        Mon, 17 Oct 2022 11:19:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ef/XDysvHNsDtZKg7D/mgcP28Fkos2UGq0A57/
        +GOHk=; b=euMdYoC3Ee7Iex8yp+2RhBfqv+x8pEWqcVdRt0VXHRe3a57UbnzA7G
        wn4/nAwr/qeapDWOaWraJyymFUcAb+62TrYxeXjjIfqjYsX8Y+FcytZPGoYeDb8d
        Wd568ryqZcucJrqLUxQHKgAzs1NgZC+QPIok6mCxD1A0EXyNnZ4Sk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A58381CB934;
        Mon, 17 Oct 2022 11:19:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A32A11CB930;
        Mon, 17 Oct 2022 11:18:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jerry Zhang <jerry@skydio.com>
Subject: Re: [PATCH v3 7/7] documentation: format-patch: clarify
 requirements for patch-ids to match
References: <pull.1359.v2.git.1663654859.gitgitgadget@gmail.com>
        <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
        <69440797f302729d59f19c0994916e193c9dbf58.1665737804.git.gitgitgadget@gmail.com>
Date:   Mon, 17 Oct 2022 08:18:56 -0700
In-Reply-To: <69440797f302729d59f19c0994916e193c9dbf58.1665737804.git.gitgitgadget@gmail.com>
        (Jerry Zhang via GitGitGadget's message of "Fri, 14 Oct 2022 08:56:44
        +0000")
Message-ID: <xmqqo7ua1nrz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 053F584C-4E2F-11ED-8322-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  The 'base commit' is shown as "base-commit: " followed by the 40-hex of
>  the commit object name.  A 'prerequisite patch' is shown as
>  "prerequisite-patch-id: " followed by the 40-hex 'patch id', which can
> -be obtained by passing the patch through the `git patch-id --stable`
> -command.
> +be obtained by passing the patch (generated with -U3 --full-index) through
> +the `git patch-id --stable` command.

This is not incorrect per-se, but I wonder how much it would help or
mislead people in practice.

I understand that the update means well to help those who complain
"'patch-id' produces wrong result when I feed the output of 'git
diff -U1'" by making them suspect that their -U1 may be the culprit.
But the new description does not cover everything that can affect
the resulting patch ID (the choice of --diff-algorithm affects how
common lines are matched up between the preimage and the postimage,
for example).

So, I dunno.
