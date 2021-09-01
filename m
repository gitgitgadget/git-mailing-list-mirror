Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD9BC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 21:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C3160F90
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 21:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245294AbhIAVI7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 17:08:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57615 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244841AbhIAVI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 17:08:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A96D914A452;
        Wed,  1 Sep 2021 17:08:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M2ZAJvqQvf/kU7rGj8NjwJvKMWTigWK7wY0H1v
        +C3ns=; b=dA8Zi0wTvuZfyy6F/AyN0Fd5pFznjqfg85pHQgm7/bJSJj5mg77UAt
        3wOy9GolIUHnkHxPNFwnhSHOgpdcrhr60cqGT6+itx8vJui5aT4AhcdGqRqIUJVp
        nprzIzxd6/58tRSZjGmub1p0JBaCiBNekJ/amGDXrW7p0SS8Nwo/8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7F92814A451;
        Wed,  1 Sep 2021 17:08:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C1FAE14A450;
        Wed,  1 Sep 2021 17:07:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/7] Add a new --remerge-diff capability to show & log
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
Date:   Wed, 01 Sep 2021 14:07:56 -0700
In-Reply-To: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Tue, 31 Aug 2021 02:26:33
        +0000")
Message-ID: <xmqqy28gngwj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AEC2BC0C-0B68-11EC-B182-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Here are some patches to add a --remerge-diff capability to show & log,

One sad omission from the maintainer usecase is that we do not seem
to know "git diff --remerge-diff" yet during a conflicted merge.

"git diff [-- <path>]" before recording the resolution for the path
with "git add <path>" shows combined patch to give a final sanity
check before committing it to the rerere database.  I am wondering
if viewing it in the --remrege-diff format instead would help this
step even more.



