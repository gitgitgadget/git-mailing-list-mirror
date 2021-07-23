Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED79C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADF4B60C51
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhGWQ4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:56:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50057 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhGWQ4u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 12:56:50 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 65D75D46EC;
        Fri, 23 Jul 2021 13:37:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HcMdeciRrjzkeUrP3fJmA6eK98pMaub/vqZ0BM
        AflVM=; b=EnTMbmwv+Ol4I4I9s8Zy39X7cQY85P0Ujm1jxlpvzBwybsJBblkW24
        5T31jaQpPEUc6c2yfK1Yqna62MP1HaccdjpO1704MsmpbPVaNbnyeeVJym7R3LOY
        Qp+rIcURAbHNgM/gCZ2XkutETcWgeei35iS5ZRcoIlaSAqjl1u8QQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DBD5D46EB;
        Fri, 23 Jul 2021 13:37:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D1E05D46EA;
        Fri, 23 Jul 2021 13:37:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 09/11] t7064: use update-ref -d to remove upstream
 branch
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
        <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
        <3685ba90f60ef95892a22c8549c9a3c0717d6662.1626989327.git.gitgitgadget@gmail.com>
Date:   Fri, 23 Jul 2021 10:37:22 -0700
In-Reply-To: <3685ba90f60ef95892a22c8549c9a3c0717d6662.1626989327.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Thu, 22 Jul 2021
        21:28:45 +0000")
Message-ID: <xmqqk0lhnd7x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A33A7D76-EBDC-11EB-8E69-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  		## Test upstream-gone case. Fake this by pointing
>  		## origin/initial-branch at a non-existing commit.
> -		OLD=$(git rev-parse origin/initial-branch) &&
> -		NEW=$ZERO_OID &&
> -		mv .git/packed-refs .git/old-packed-refs &&
> -		sed "s/$OLD/$NEW/g" <.git/old-packed-refs >.git/packed-refs &&
> +		git update-ref -d refs/remotes/origin/initial-branch &&

OK, so we now "fake" upstream-gone by making the upstream actually
gone ;-)  OK.

>  
>  		HUF=$(git rev-parse HEAD) &&
