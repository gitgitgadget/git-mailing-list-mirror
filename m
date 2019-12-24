Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255BEC2D0C3
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 18:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA0A2063A
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 18:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mS/LHIhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLXSXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 13:23:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54280 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfLXSXS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 13:23:18 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 94F4527D6E;
        Tue, 24 Dec 2019 13:23:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fEQ6njLs7kFjpawIUA0AXy2SXV8=; b=mS/LHI
        hOQZUGnimq2TKG1vuXpW4hdrhMGN+XkCyF1cWG677SDE+q/4it7dY/cugnkLmpux
        Exw1geFV2KEpkWJw6GvkOiJurhYlC4xW7zkOEbvxYKusJOkriHRNVgl/tYLccIh7
        E7b77hwlSqP1SjJYTTzkmWiSToVrCczgdRVIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cb61vGtBEfOtCNk6qkzpCb85+fr55bu3
        S/uv0h9Nanu0H6Ym0fV+nxuAX1wmQ2kpGkNucNBJsUXGcVzIvV7TokxOHRYJxOs8
        0v8hQpTNScWVNVCFE1ol90ZuoYjZ24DEp78QWG0lkKGV/pxGHjiLsTOMLVWHBy2S
        MLhuccd9laM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C31427D6C;
        Tue, 24 Dec 2019 13:23:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ECD3F27D6B;
        Tue, 24 Dec 2019 13:23:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/9] built-in add -p: add support for the same config settings as the Perl version
References: <pull.175.git.1576968120.gitgitgadget@gmail.com>
Date:   Tue, 24 Dec 2019 10:23:14 -0800
In-Reply-To: <pull.175.git.1576968120.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Sat, 21 Dec 2019 22:41:51
        +0000")
Message-ID: <xmqqpngd60rx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73DB795A-267A-11EA-9DB4-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> base-commit: 2d4b85ddc76af3e703e6e3a6a72319b5e79c2d8b

It is not generally helpful to those who reads this list to use a
commit that is not part of history leading to my 'pu' or 'next' as
the base.

I am guessing that it will build on top of the "use add -i/p from
more commands" series, so I'll try to apply these on top there, but
I wonder if it would help readers if we had some extra comments for
human consumption next to "base-commit:" line (similar to the other
stuff like Published-As added by GGG), perhaps in a format similar
to the one we use to refer to random commits, e.g.

    base-commit: 2d4b85ddc76af3e703e6e3a6a72319b5e79c2d8b
    # commit --interactive: make it work with the built-in `add -i`, 2019-12-17

perhaps?


