Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8070DC433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 22:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 465B96140F
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 22:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbhDTW7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 18:59:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54889 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbhDTW7n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 18:59:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 57A60B9F9A;
        Tue, 20 Apr 2021 18:59:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SkYyie96EXlDdQdEEkHBU9Acb/g=; b=s1P69C
        9cHlQtqEnS23acNQ7+Yv0JWEXmREsfh3fiTDQhgRuHPvtqwmfsM9Y5Hn2H4vifVy
        ZUNqol1/0QRWSOLcUN3m3FKPd36oQ3fsDVThl7C17Mz8xntWn7jrZkWqh0BSh9n1
        JGPUByV4BZJS6gHn2Wo2rPBAelwJA5t30bxEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KKg7g3hE3BAHYUKM8Y3xUXDv5P/qdbJB
        jy69R/a7ai5pCMsyZ9+bDs1I1KVPVLeR//bfo4ZWYeYRfVNe2/6wv5JAK18G3hYW
        RzGWbkeVPz1MS+XL/wzHqYl5RsptL/plJXbpt9Z4OKdCY19Y09QInppNOIXrnK0p
        g4P02yjSFyM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4EE05B9F99;
        Tue, 20 Apr 2021 18:59:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CCBD6B9F98;
        Tue, 20 Apr 2021 18:59:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 16/18] t7003: check reflog existence only for REFFILES
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
        <a5b9439192db3ad3c01db0e67cc1f60bad9109e8.1618829583.git.gitgitgadget@gmail.com>
Date:   Tue, 20 Apr 2021 15:59:10 -0700
In-Reply-To: <a5b9439192db3ad3c01db0e67cc1f60bad9109e8.1618829583.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 19 Apr 2021
        10:53:01 +0000")
Message-ID: <xmqq5z0g36m9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04D96D58-A22C-11EB-9A5E-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t7003-filter-branch.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
> index cf30055c88dd..380bdf934317 100755
> --- a/t/t7003-filter-branch.sh
> +++ b/t/t7003-filter-branch.sh
> @@ -396,7 +396,9 @@ test_expect_success '--prune-empty is able to prune entire branch' '
>  	git branch prune-entire B &&
>  	git filter-branch -f --prune-empty --index-filter "git update-index --remove A.t B.t" prune-entire &&
>  	test_must_fail git rev-parse refs/heads/prune-entire &&
> -	test_must_fail git reflog exists refs/heads/prune-entire
> +	if test_have_prereq REFFILES ; then
> +		test_must_fail git reflog exists refs/heads/prune-entire
> +	fi

Style.  Replace " ; " with a LF and necessary number of tabs.


>  '
>  
>  test_expect_success '--remap-to-ancestor with filename filters' '
