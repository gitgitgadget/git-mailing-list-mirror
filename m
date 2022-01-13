Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66002C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 23:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238153AbiAMXD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 18:03:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56481 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238121AbiAMXD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 18:03:58 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3286A109CD3;
        Thu, 13 Jan 2022 18:03:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T4FmltDaWbTXg6tkRK/2NHofaQTq/jeH5vY2VW
        KrkKQ=; b=PQqAK6H/r3KTNTs9C5+rViJpHP3tICDInNnG2ejBG0JkaFWNvA718+
        V6pUq7uOZH35p7y3STPr9MZ/HM0Piq5DjG4oPWqUrIAgwL49DWVbsTfiwZ3qm25l
        Y34ZbHdWkBfqm0/gERNZ22Hpg1cKXttyY7FsnBPVL3KaQtzhQdZVc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 28913109CD2;
        Thu, 13 Jan 2022 18:03:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 841D4109CD1;
        Thu, 13 Jan 2022 18:03:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: Re: [PATCH v2 00/21] git-p4: Various code tidy-ups
References: <20220113134728.23192-1-jholdsworth@nvidia.com>
Date:   Thu, 13 Jan 2022 15:03:55 -0800
In-Reply-To: <20220113134728.23192-1-jholdsworth@nvidia.com> (Joel
        Holdsworth's message of "Thu, 13 Jan 2022 13:47:07 +0000")
Message-ID: <xmqqwnj3fdb8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15DA8166-74C5-11EC-A1C4-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Doesn't this conflict with your own topics that are already cooking
in 'next'?  For example, I am seeing many conflicts like this one.

    def rebase(self):
        if os.system("git update-index --refresh") != 0:
<<<<<<< HEAD
            die("Some files in your working directory are modified and different than what is in your index. You can use git update-index <filename> to bring the index up to date or stash away all your changes with git stash.");
        if len(read_pipe(["git", "diff-index", "HEAD", "--"])) > 0:
            die("You have uncommitted changes. Please commit them before rebasing or stash them away with git stash.");
||||||| 1ffcbaa1a5
            die("Some files in your working directory are modified and different than what is in your index. You can use git update-index <filename> to bring the index up to date or stash away all your changes with git stash.");
        if len(read_pipe("git diff-index HEAD --")) > 0:
            die("You have uncommitted changes. Please commit them before rebasing or stash them away with git stash.");
=======
            die("Some files in your working directory are modified and different than what is in your index. You can use git update-index <filename> to bring the index up to date or stash away all your changes with git stash.")
        if len(read_pipe("git diff-index HEAD --")) > 0:
            die("You have uncommitted changes. Please commit them before rebasing or stash them away with git stash.")
>>>>>>> jh/p4-code-tidy-ups

As new things in 'next' that are not in 'master' are not moving
until the final release of this cycle, perhaps this needs to wait
until much later in the month (see tinyurl.com/gitCal).

Thanks.
