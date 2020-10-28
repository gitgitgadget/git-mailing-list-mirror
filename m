Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9AAC388F7
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6303720878
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="s2df88dt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388211AbgJ2CEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 22:04:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55282 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbgJ1VjO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 17:39:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2859273779;
        Wed, 28 Oct 2020 16:00:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YoPSmpYtY/NF539FkCOG837fGB0=; b=s2df88
        dtE4XyNzpnaSIvKe9CXqZVtLPFYbZch027VVisv6suvsJcr7ZMkUAR0h4xp3lf3+
        N11E/6zjmSP/hLhrNpeFsEtbifIukPWowRvs8TaNrte/mquE3sX5LumsYVa7mFnL
        HNTfSrDCvOqFBTo35h/jhenRQeSjurjBQfVjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iUg2xXl9QkyXiCZSDoeuNALiPOvoUUeB
        MJXnl/V24zY9PeSAz+a+zWae9cE1Fr5ax4jXVW8DXdmFgrCFp6i2yYjdKhJLWuE1
        OiNujuC89B4+Vw/t+r/zIDlazfe2D8Em22ag/7aMui8rH+GT+u8EQFh+dMpGTnVT
        XqfPJnko6So=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1ED8573778;
        Wed, 28 Oct 2020 16:00:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8A17973777;
        Wed, 28 Oct 2020 16:00:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/4] t5411: start using the default branch name "main"
References: <pull.760.git.1603839487.gitgitgadget@gmail.com>
        <f997166db4c29d971a2343f70c9d9a0505a8cc4b.1603839487.git.gitgitgadget@gmail.com>
Date:   Wed, 28 Oct 2020 13:00:48 -0700
In-Reply-To: <f997166db4c29d971a2343f70c9d9a0505a8cc4b.1603839487.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 27 Oct 2020
        22:58:04 +0000")
Message-ID: <xmqqa6w69l3j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4684964A-1958-11EB-8B2B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This is a straight-forward search-and-replace in the test script;
> However, this is not yet complete because it requires many more
> replacements in `t/t5411/`, too many for a single patch (the Git mailing
> list rejects mails larger than 100kB). For that reason, we disable this
> test script temporarily via the `PREPARE_FOR_MAIN_BRANCH` prereq.

I do not think it matters too much, as it will become correct at the
end anyway, but ... 

> +test_have_prereq PREPARE_FOR_MAIN_BRANCH || {
> +	test_skip="In transit for the default branch name 'main'"
> +	test_done
> +}
> +

... the way I read the introductory paragraph in the proposed log
message is that the point of adding a protection here (done in order
to work around a transient failure caused by having to artificially
split this topic into four patches) is to avoid an inevitable
failure due to some parts of tests adjusted for 'main' while other
parts still expect 'master'.  Until files in t/5411/* gets adjusted
for 'main', nothing is expected to pass whether the default branch
is 'master' or 'main'.  Or with only 1/4 applied, is this test
expected to pass if GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME is set to
'main' (i.e. PREPARE_FOR_MAIN_BRANCH prerequisite is satisfied)?

IOW, I do not see the point in _conditionally_ skipping the rest of
the test in this step.  I'd however understand it if we always skip
the rest in 1/4 and then enable the rest only when testing with
'main' as the default in 4/4, when all the necessary pieces in
t/t5411 have been converted.

The "straight-forward search-and-replace" part looks obviously good,
of course.

Thanks.

>  . "$TEST_DIRECTORY"/t5411/common-functions.sh
>  
>  setup_upstream_and_workbench () {
> -	# Refs of upstream : master(A)
> -	# Refs of workbench: master(A)  tags/v123
> +	# Refs of upstream : main(A)
> +	# Refs of workbench: main(A)  tags/v123
>  	test_expect_success "setup upstream and workbench" '
>  		rm -rf upstream.git &&
>  		rm -rf workbench &&
> @@ -25,10 +30,10 @@ setup_upstream_and_workbench () {
>  			git config core.abbrev 7 &&
>  			git tag -m "v123" v123 $A &&
>  			git remote add origin ../upstream.git &&
> -			git push origin master &&
> -			git update-ref refs/heads/master $A $B &&
> +			git push origin main &&
> +			git update-ref refs/heads/main $A $B &&
>  			git -C ../upstream.git update-ref \
> -				refs/heads/master $A $B
> +				refs/heads/main $A $B
>  		) &&
>  		TAG=$(git -C workbench rev-parse v123) &&
>  
> @@ -99,8 +104,8 @@ start_httpd
>  # Re-initialize the upstream repository and local workbench.
>  setup_upstream_and_workbench
>  
> -# Refs of upstream : master(A)
> -# Refs of workbench: master(A)  tags/v123
> +# Refs of upstream : main(A)
> +# Refs of workbench: main(A)  tags/v123
>  test_expect_success "setup for HTTP protocol" '
>  	git -C upstream.git config http.receivepack true &&
>  	upstream="$HTTPD_DOCUMENT_ROOT_PATH/upstream.git" &&
