Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9EAC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 21:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D3B160F4B
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 21:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhHBVcj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 17:32:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59206 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbhHBVcj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 17:32:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 12A3513F5D2;
        Mon,  2 Aug 2021 17:32:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K7sWyP9GH7RdNULOyc/TjkgSwTvZn+3OJ/DDlc
        dUqFg=; b=q29MDjNvsAoZu2DohYzjj5zcY3bQaYYWab8gVa8fauNvHwLPKF+OXs
        nhG6gTldyd9WxjmF2XCdHOHK2cg1tDd4Pcjg8Y6vVaQtTUqtqZ6zY2ghtY3tne2A
        tVpwFbAtlVeeQHYu2uAY9oyy3twpdcpyNiROYVo6SMnjkGiJxGaNw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0BC4213F5D1;
        Mon,  2 Aug 2021 17:32:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 562B313F5CF;
        Mon,  2 Aug 2021 17:32:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v3 00/11] Fix direct filesystem access in various test
 files.
References: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
        <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com>
        <xmqqsfzrvcex.fsf@gitster.g>
Date:   Mon, 02 Aug 2021 14:32:24 -0700
In-Reply-To: <xmqqsfzrvcex.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        02 Aug 2021 13:07:02 -0700")
Message-ID: <xmqqo8afv8gn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21B1B30A-F3D9-11EB-96F1-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> This fixes a few test failures in the reftable series.
>>
>> Han-Wen Nienhuys (11):
>>   t6050: use git-update-ref rather than filesystem access
>>   t1503: mark symlink test as REFFILES
>>   t6120: use git-update-ref rather than filesystem access
>>   t3320: use git-symbolic-ref rather than filesystem access
>>   t2402: use ref-store test helper to create broken symlink
>>   t1405: use 'git reflog exists' to check reflog existence
>>   t1405: mark test for 'git pack-refs' as REFFILES
>>   t1410: mark test as REFFILES
>>   t7064: use update-ref -d to remove upstream branch
>>   t6500: use "ls -1" to snapshot ref database state
>>   t6001: avoid direct file system access
>
> Thanks.
>
> Unfortunately all of these are already in 'next', so I'll revert the
> merge(s) to eliminate what has been in 'next' and queue this round
> to 'seen', hoping that we can merge the new one back to 'next'
> soonish.

Sorry, but I changed my mind.  On the day for -rc0, I do not have
time to deal with this right now, so I'll keep a bookmark on this
round for now, but will keep what has been on 'next' there for now.

Will revisit this new round of patches later.

Thanks.
