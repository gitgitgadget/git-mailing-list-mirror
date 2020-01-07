Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC97C282DD
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 21:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EBA2077B
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 21:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mY7RauBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbgAGVNL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:13:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64959 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730160AbgAGVNK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 16:13:10 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD3513457B;
        Tue,  7 Jan 2020 16:13:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uDfL4PkyWjhw0J86FMUEWFnjf4M=; b=mY7Rau
        BwR0o9ArHD5BRcBTExIHGDWqUoXwqBwVXafutLi0kzi//JgqLSxMXCp+C+szSXH6
        hJCKyEcpJvjPkCYJjt8ySQZj7bfHUfYOp5UGpOElYHY/s+cGE+dIsPYE9ngG2w6h
        kSENoqEjMIidnK8No3R24T5LIINIKn/dsQjZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lrTzctJ4ECKxqa0qJE/rcF43ZPjD0dFG
        cwUdtkg8rxK+XcS4NT2v4U05P7wA1YNZyeDh11cOj0CiN+eckEVWiCSo/GVkLNL9
        VUhM/WFcRt/EKdbfF5LjRVs6JVgb2/TZhvMJEFMAHDjtlyQBpII6O9Em+yMFDnc5
        8ZDBCc+xT68=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A389C3457A;
        Tue,  7 Jan 2020 16:13:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0283A34579;
        Tue,  7 Jan 2020 16:13:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH v4 0/3] t: rework tests for --pathspec-from-file
References: <pull.503.v3.git.1577786032.gitgitgadget@gmail.com>
        <pull.503.v4.git.1577787313.gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 13:13:05 -0800
In-Reply-To: <pull.503.v4.git.1577787313.gitgitgadget@gmail.com> (Alexandr
        Miloslavskiy via GitGitGadget's message of "Tue, 31 Dec 2019 10:15:10
        +0000")
Message-ID: <xmqqh8173r8e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7FFA015C-3192-11EA-9F6F-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This branch is a follow-up for [1] where part of branch was merged into `master` via [2].
>
> Previously in [3] there were some concerns on whether removing
> copy&pasted tests is good. I still think that yes, it 's a good thing,
> mostly because of high volume of potential 13*6=78 duplicate tests.
>
> Still, I separated this change as last patch, so that the remaining
> part of the branch can be taken without it.

With the third step the series won't merge cleanly with other topic
you have in 'next' (t7107 gets somewhat heavy merge conflicts).

I'll queue the first two for now but let's clean them up post 2.25
release.

Thanks.
