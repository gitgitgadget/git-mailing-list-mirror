Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFA7C433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 19:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14D222074D
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 19:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HR/HTK3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgHXTHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:07:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50839 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgHXTHA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 15:07:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E182C77230;
        Mon, 24 Aug 2020 15:06:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hrHxeNrAqK1TfSq5cCJN9w6uWkM=; b=HR/HTK
        3yjfwXXBUIH0Zk5rS8TQXqpkJTJRfyd/wVZ11qWgs4PJYzVP8hbwHZk9V0zUgKhW
        BD8GZcMs4okWdTEYL83YD/dvzKXGnIEqvrknKx9XzC4meNwoq2XHOm1PMPb+6q/g
        dZa5Kqzc1j5HkXvIMgU6/5tPNE3K849ZM0p7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tPjMIeulSgXduKhwS4kuOLxg+mVPnrFL
        Bbfj2LtkR4+Rk5BBpWmkIBNGDNh2wQyzCMKQJESn8fWqLyBcNIDymQvaNyBnMnDQ
        qhtAjh64zm3S/2Ha8jNIHdtMopEx+oFac3oPnS83OJkvZbyuR0zG0j1MUuFD7vZm
        wOyzaHmhsLE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D9E7A7722F;
        Mon, 24 Aug 2020 15:06:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 58B1B7722E;
        Mon, 24 Aug 2020 15:06:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 3/3] ci: stop linking built-ins to the dashed versions
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>
        <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
        <ea23ba5e269305b660a1722254e2a933c14e5b57.1598283480.git.gitgitgadget@gmail.com>
Date:   Mon, 24 Aug 2020 12:06:56 -0700
In-Reply-To: <ea23ba5e269305b660a1722254e2a933c14e5b57.1598283480.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 24 Aug 2020
        15:38:00 +0000")
Message-ID: <xmqqimd750dr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB1F61A6-E63C-11EA-B570-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Originally, all of Git's subcommands were implemented in their own
> executable/script, using the naming scheme `git-<command-name>`. When
> more and more functionality was turned into built-in commands (i.e. the
> `git` executable could run them without spawning a separate process),
> for backwards-compatibility, we hard-link the `git` executable to
> `git-<built-in>` for every built-in.
>
> This backwards-compatibility was needed to support scripts that called
> the dashed form, even if we deprecated that a _long_ time ago.

This paragraph is irrelevant.  We are keeping the support for it and
this topic is not newly deprecating or removing anything.  We need
to argue for a need to test an installation that lacks these builtin
subcommands anywhere on disk under their own names, which you did
succinctly below (and there is no need for "For that reason,"
there).

> For that reason, we just introduced a Makefile knob to skip linking
> them. TO make sure that this keeps working, teach the CI

s/TO/To/

> (and PR) builds to skip generating those hard-links.

What is not justified enough is why we no longer test installations
with dashed builtins on disk.  If this topic is primarily about
Windows (as 2/3 said), perhaps we can do this only for Windows tasks
before we make a colletive decision to _DROP_ support for the on-disk
builtin subcommands?

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  ci/run-build-and-tests.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 6c27b886b8..1df9402c3b 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -10,7 +10,7 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
>  *) ln -s "$cache_dir/.prove" t/.prove;;
>  esac
>  
> -make
> +make SKIP_DASHED_BUILT_INS=YesPlease
>  case "$jobname" in
>  linux-gcc)
>  	make test
