Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECAEE1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 03:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbfKFDaC (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 22:30:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56321 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfKFDaB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 22:30:01 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AFB102B5AC;
        Tue,  5 Nov 2019 22:29:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U8BXBd35fFM9KQ5MVhYtIXKZVmA=; b=sifXh2
        dO4bpqYSYM/RLuutO6sxZ3yNXmF/L0AsePnV4ukNpYIi+zas2hecVDnalNwsQefF
        4LsaiFyMvCXnKnUc9kcbDXMQXCeTmE2wGub6ME19b3dMiT0utE5Y/VJtUJ3URS5M
        pzVOIDOCPMaTEmv/s1i9aFBi7bo23Js0wglHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WZiAPFAQmGsl2ec3LVkq2kHYtYVuAyCC
        gaWw1MPMefMIfJko+lJse3CCTdkG5wCSxSEhu/BJN6e74Lk2obGK5lv4l17BcWWa
        WPs6r6y5EioYG8zF0a8+2tSAn2/tNpviocgCb7peb/Vogsktz/0AfVJwBXiYXV9V
        TPov1V4oQsM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A73942B5AB;
        Tue,  5 Nov 2019 22:29:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 202B52B5AA;
        Tue,  5 Nov 2019 22:29:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kevin Willford via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kevin Willford <Kevin.Willford@microsoft.com>
Subject: Re: [PATCH 0/1] fsmonitor: fix watchman integration
References: <pull.444.git.1572889841.gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 12:29:58 +0900
In-Reply-To: <pull.444.git.1572889841.gitgitgadget@gmail.com> (Kevin Willford
        via GitGitGadget's message of "Mon, 04 Nov 2019 17:50:40 +0000")
Message-ID: <xmqqlfstvg09.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5D2DDA4-0045-11EA-9B4D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kevin Willford via GitGitGadget" <gitgitgadget@gmail.com> writes:

> When running Git commands quickly -- such as in a shell script or the test
> suite -- the Git commands frequently complete and start again during the
> same second. The example fsmonitor hooks to integrate with Watchman truncate
> the nanosecond times to seconds. In principle, this is fine, as Watchman
> claims to use inclusive comparisons [1]. The result should only be an
> over-representation of the changed paths since the last Git command.
> ...

So, it doesn't seem to use "inclusive" and we need a workaround?

> Kevin Willford (1):
>   fsmonitor: fix watchman integration
>
>  t/t7519/fsmonitor-watchman                 | 13 ++++---------
>  templates/hooks--fsmonitor-watchman.sample | 13 ++++---------
>  2 files changed, 8 insertions(+), 18 deletions(-)

Thanks, will queue.
