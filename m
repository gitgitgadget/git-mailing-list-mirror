Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B21CC433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 19:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57DE72083B
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 19:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LVAwz+xc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgIBTVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:21:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53626 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgIBTVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 15:21:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9E1D2E2FDE;
        Wed,  2 Sep 2020 15:21:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MPYdD9VuGILXZLL9rzrBfxElXFM=; b=LVAwz+
        xcIuAea3GABvT7S58HtWecuHq0nMZyP7V9RsWeVa1jB+frhY/t0FTvng4Vo964AL
        ryzUrKHQV9/5a9Kob9ceI6GvcfPWpiq7PHoIFkRGr5L2SU+0B+6PiofIuN0FGhyy
        3QHXfhOR2VtZtb/aahdYlQ0k/OxnJci6elvqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UjUuoRjT/L9aA7AM+/VT5NMFBT5Vy5L9
        zdvQ4qp1r281DM4sV2smaVt0IiM3X5LvvWZbkIm0qqP+vMXbW9uB6mIJniFvjXuO
        cpRjn5C5DcN7z7iJpJ7PcHL3qbFJuusLoMgLJnn/5nCRHZf1mEz4gx/pnpu18JtY
        wl9vNvv22d8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 97729E2FDD;
        Wed,  2 Sep 2020 15:21:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 80F3AE2FD8;
        Wed,  2 Sep 2020 15:21:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] ci: avoid ugly "failure" annotation in the GitHub workflow
References: <pull.719.git.1598991568.gitgitgadget@gmail.com>
Date:   Wed, 02 Sep 2020 12:21:01 -0700
In-Reply-To: <pull.719.git.1598991568.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Tue, 01 Sep 2020 20:19:25
        +0000")
Message-ID: <xmqqk0xcaste.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71315FF0-ED51-11EA-9A8E-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Whenever the GitHub workflow runs in a fork that does not contain the
> special-purpose ci-config branch, a big fat failure annotation greets the
> casual reader. See e.g. 
> https://github.com/gitgitgadget/git/actions/runs/233438295
>
> This is caused by the (non-fatal) failure to clone said branch. Let's avoid
> that. It's distracting.

Thanks.  Anything that reduces the CI noise is very much welcomed.

