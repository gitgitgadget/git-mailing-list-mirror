Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E43CC433EF
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 22:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhLaWVE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 17:21:04 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63276 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhLaWVE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 17:21:04 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B9F95186DD2;
        Fri, 31 Dec 2021 17:21:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jae0rMtQG0BUCF3VRBLY4HEGQp4Gesr98Wh2rg
        VQYew=; b=sjRAp488Y13XryARxnRDyywz7E7osaPGQR9BYEyc38AzJ/Z1GKfRRy
        14samSRDdoGohDYys4aZ5Jp5LdtOPQvzq9vR/Q1z8NdY8Dl10yPpc0a5ozTcyNKN
        bnJCUcx1fsyetqMVRVp1v5E1hwn0Nrz47qrcVtMYQyxydR1yQaJXk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B2399186DD1;
        Fri, 31 Dec 2021 17:21:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 19915186DCE;
        Fri, 31 Dec 2021 17:21:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        johannes.schindelin@gmail.com,
        Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH v2 1/2] sparse-checkout: custom tab completion tests
References: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
        <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
        <955fcab00528464b5450bd22b45c89ffc2283e39.1640892413.git.gitgitgadget@gmail.com>
        <CABPp-BGdr54XgCXw8k1xRCgkwBtDonyODS3O+_nS_QY3SOEFGQ@mail.gmail.com>
Date:   Fri, 31 Dec 2021 14:20:58 -0800
In-Reply-To: <CABPp-BGdr54XgCXw8k1xRCgkwBtDonyODS3O+_nS_QY3SOEFGQ@mail.gmail.com>
        (Elijah Newren's message of "Fri, 31 Dec 2021 12:03:04 -0800")
Message-ID: <xmqqy240l8l1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EECD7606-6A87-11EC-9D24-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Second, and this item is unrelated to your series but your comment
> made me realize it....sparse-checkout unfortunately ignores prefix and
> creates a bad .git/info/sparse-checkout file.  For example:
> ...
> I think the loss of the current working directory will be fixed by the
> en/keep-cwd directory (currently in next and marked for merging to
> master), but the fact that the wrong paths end up in the
> sparse-checkout file is unfortunate.  It basically means that the
> `set` and `add` subcommands of `sparse-checkout` can only be safely
> run from the toplevel directory.

You made it sound as if this is a fundamental limitation, but it
sounds more like a bug that needs to be fixed (outside the
completion series, of course) to me.

