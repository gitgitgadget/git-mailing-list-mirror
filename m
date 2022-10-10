Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D7FC433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 17:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJJRC5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 13:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiJJRCr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 13:02:47 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734E7760F7
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 10:02:38 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 340FC15CEF3;
        Mon, 10 Oct 2022 13:02:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sxukeOcJVOdpHFkJUk+SnZiEDq4P7JFZrHxx1T
        9A6J8=; b=rmicPRzNu8InW2N7L/JGmCJ5pASRhhfWEHqdfqud8cg8jEVBVNWzpC
        yHUHWdFuFyBsfYQdiav+W6qz4rmDtM6APet1neCdhOZ2PMezbaU2nsF+BnEIRssJ
        8Zx/+zHtHNr/wlHxWhU1DuY3fSv4QgWkxILFIXz/IQxRWik1kJnLg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C31E15CEF2;
        Mon, 10 Oct 2022 13:02:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9442A15CEF1;
        Mon, 10 Oct 2022 13:02:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] t3435: remove redundant test case
References: <pull.1379.git.1665395106351.gitgitgadget@gmail.com>
Date:   Mon, 10 Oct 2022 10:02:34 -0700
In-Reply-To: <pull.1379.git.1665395106351.gitgitgadget@gmail.com> (Phillip
        Wood via GitGitGadget's message of "Mon, 10 Oct 2022 09:45:06 +0000")
Message-ID: <xmqqpmez4no5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 568954B8-48BD-11ED-B217-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> rebase --preserve-merges no longer exists so there is no point in
> carrying this failing test case.

Looks good.

I can imagine that you noticed that it was failing for a wrong
reason, perhaps as part of your test-todo topic?

> diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
> index 5f8ba2c7399..6aa2aeb628d 100755
> --- a/t/t3435-rebase-gpg-sign.sh
> +++ b/t/t3435-rebase-gpg-sign.sh
> @@ -64,14 +64,6 @@ test_rebase_gpg_sign ! true  -i --no-gpg-sign
>  test_rebase_gpg_sign ! true  -i --gpg-sign --no-gpg-sign
>  test_rebase_gpg_sign   false -i --no-gpg-sign --gpg-sign
>  
> -test_expect_failure 'rebase -p --no-gpg-sign override commit.gpgsign' '
> -	test_when_finished "git clean -f" &&
> -	git reset --hard merged &&
> -	git config commit.gpgsign true &&
> -	git rebase -p --no-gpg-sign --onto=one fork-point main &&
> -	test_must_fail git verify-commit HEAD
> -'
> -
>  test_expect_success 'rebase -r, merge strategy, --gpg-sign will sign commit' '
>  	git reset --hard merged &&
>  	test_unconfig commit.gpgsign &&
>
> base-commit: 3dcec76d9df911ed8321007b1d197c1a206dc164
