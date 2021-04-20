Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D10EC433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 22:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D61661411
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 22:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbhDTW6O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 18:58:14 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57142 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbhDTW6M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 18:58:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E3196137DA8;
        Tue, 20 Apr 2021 18:57:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3h6MFM9WebIV0A9dfqWkH33jIkM=; b=LBN4LS
        VD/7SmSZ8UI2MShT4HQ1sFcTkPZCf9f0zHUJQoatUZRIelFRs0h5PDWgmVw4nSWr
        v7Ufj9DkStJwEDtH66OOkMRk1HuZlT6z35WGu/3OsoA2Dg2Mx0HBbBzcoBC+Pzlp
        cds174cmAFHJexijAw4BcBESeBNjv36qbiKXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e5IE6TWmV8XexSaYk4fJlrZNgyJUVOzk
        AiY697JxSi5XqUGnt9nAE6BeieqjS4LkNvIFFXUedTIgXjE2T4S3Xt809ipjY4Kw
        WfPpIAMuMwre1K0UobA53UcYBVpH54SFIigAAKKwuIrfsKZwrTbR6fsIahpVUwdv
        Zx79eE7h76k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DC269137DA7;
        Tue, 20 Apr 2021 18:57:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1EA7F137DA6;
        Tue, 20 Apr 2021 18:57:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 10/18] test-lib: provide test prereq REFFILES
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
        <3d3b733c31273a004e80d5cbab8f746a2010e9ea.1618829583.git.gitgitgadget@gmail.com>
Date:   Tue, 20 Apr 2021 15:57:35 -0700
In-Reply-To: <3d3b733c31273a004e80d5cbab8f746a2010e9ea.1618829583.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 19 Apr 2021
        10:52:55 +0000")
Message-ID: <xmqqa6ps36ow.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CCFDA78C-A22B-11EB-8B88-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> REFFILES can be used to mark tests that are specific to the packed/loose ref
> storage format and its limitations. Marking such tests is a preparation for
> introducing the reftable storage backend.

We'd want a bit of documentation either here or in t/README to
explain things like how these two interact with each other, if both
can be active at the same time, etc.

>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/test-lib.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index d3f6af6a6545..ea7397c633db 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1481,6 +1481,8 @@ parisc* | hppa*)
>  	;;
>  esac
>  
> +test_set_prereq REFFILES
> +
>  ( COLUMNS=1 && test $COLUMNS = 1 ) && test_set_prereq COLUMNS_CAN_BE_1
>  test -z "$NO_PERL" && test_set_prereq PERL
>  test -z "$NO_PTHREADS" && test_set_prereq PTHREADS
