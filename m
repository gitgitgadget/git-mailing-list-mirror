Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE14C2B9F4
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 02:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1079C613FA
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 02:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhFOCp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 22:45:58 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65466 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhFOCpw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 22:45:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BF61A1250E4;
        Mon, 14 Jun 2021 22:38:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zeB2ZKRIaEH3lAi0FhInch/xwP8T7cZkn9LwHZ
        +Cf80=; b=qy0qfV+uK6qoddyVinooUYItjKHA/2i2DE0WdVLWQ9wksN8huYVAKS
        3M49VL9o0JmOm2efumVu2FKBVXrQL6SFiLvV5kvAWgjxRgxUP09TQnjTg4iSg/mW
        PRFwHlxWLjuPRNxvtYo8nlFPVV8GxHChbhl6BjUzAZbgd/rFhgQjM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B80631250E3;
        Mon, 14 Jun 2021 22:38:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0A19A1250E1;
        Mon, 14 Jun 2021 22:37:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Luke Shumaker <lukeshu@lukeshu.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] subtree: fix the GIT_EXEC_PATH sanity check to
 work on Windows
References: <pull.978.git.1623316412.gitgitgadget@gmail.com>
        <pull.978.v2.git.1623674513.gitgitgadget@gmail.com>
        <5f2d9434b4ebb66131ea2fb9fbb62d6338af1294.1623674513.git.gitgitgadget@gmail.com>
Date:   Tue, 15 Jun 2021 11:37:57 +0900
In-Reply-To: <5f2d9434b4ebb66131ea2fb9fbb62d6338af1294.1623674513.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 14 Jun 2021
        12:41:52 +0000")
Message-ID: <xmqqmtrryhru.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B29669CE-CD82-11EB-89E3-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Sadly, this construct is non-portable, according to
> https://pubs.opengroup.org/onlinepubs/009695399/utilities/test.html.
> However, it does not matter in practice because we still first look
> whether `$GIT_EXEC_PREFIX` is string-identical to the first component of
> `$PATH`. This will give us the expected result everywhere but in Git for
> Windows, and Git for Windows' own Bash _does_ handle the `-ef` operator.

OK.  That's somewhat subtle and possibly brittle, but let's see how
it goes.

Will queue.

Thanks.
