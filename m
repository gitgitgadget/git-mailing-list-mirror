Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A851C4727C
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E2A523A65
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uvrO5aWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgIUWxU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 18:53:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57978 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgIUWxU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 18:53:20 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C575587469;
        Mon, 21 Sep 2020 18:53:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NBa1zMLJgSpSzl7A8jq6Wh0rwGs=; b=uvrO5a
        Wy3JDtE4toeu5KoRxEWFGi3ZnMu4DFztfyKyLZIRCsiprw1MXfYfwppzlR4b83ZR
        OFV5Pp8ajkMTAcYzcmkzmhIx6yWb809O/FSxLOtFtVK9Bx9Y22oJut/BXH2a0Fl6
        NUVvOcOWw/2FhZ/0BRLmtYsqSPuMYF0TjNshM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tBsa9/RcdEqefI3OmUl/PdFOupyP/q1A
        XBUMhvGuMCfXE8WMyha38izzAVmugv1uhvnBwttD5h5OBsSHKMmFEKE2JjJQX0ZT
        qLu2+UXVnAdftIaz86tKaIF4ZOOkQ0jGUvuBGrE4wTmq0TGFYNnobvDF42RhPBof
        UyC0Wx2h+/Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BCC1B87468;
        Mon, 21 Sep 2020 18:53:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 35DBE87465;
        Mon, 21 Sep 2020 18:53:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 3/3] ci: stop linking built-ins to the dashed versions
References: <pull.411.v3.git.1598443012.gitgitgadget@gmail.com>
        <pull.411.v4.git.1600727297.gitgitgadget@gmail.com>
        <1fdf24af368ccb263ade2af2e482221280a3eb06.1600727298.git.gitgitgadget@gmail.com>
Date:   Mon, 21 Sep 2020 15:53:16 -0700
In-Reply-To: <1fdf24af368ccb263ade2af2e482221280a3eb06.1600727298.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 21 Sep 2020
        22:28:17 +0000")
Message-ID: <xmqqmu1id9nn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CEAAED4-FC5D-11EA-B5BC-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Since e4597aae6590 (run test suite without dashed git-commands in PATH,
> 2009-12-02), we stopped running our tests with `git-foo` binaries found
> at the top-level directory of a freshly built source tree; instead we
> have placed only `git` and selected `git-foo` commands that must be on
> `$PATH` in `bin-wrappers/` and prepended that `bin-wrappers/` to the
> `PATH` used in the test suite. We did that to catch the tests and
> scripted Git commands that still try to use the dashed form.
>
> Since CI jobs will not install the built Git to anywhere, and the
> hardlinks we make at the top-level of the source tree for `git-add` and
> friends are not even used during tests, they are pure waste of resources
> these days.

Makes perfect sense, and I do not think readers will confused like
they were by the previous round's corresponding step.

> diff --git a/ci/lib.sh b/ci/lib.sh
> index 3eefec500d..821e3660d6 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -178,6 +178,7 @@ fi
>  export DEVELOPER=1
>  export DEFAULT_TEST_TARGET=prove
>  export GIT_TEST_CLONE_2GB=true
> +export SKIP_DASHED_BUILT_INS=YesPlease

OK.  This would hopefully cover all the CI targets; we know it
covers everybody who uses DEVELOPER=1, which is a good sign ;-)

Thanks.
