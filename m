Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5EAE95A8D
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 23:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378992AbjJIXuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 19:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377918AbjJIXuw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 19:50:52 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACD39D
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 16:50:50 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 715BB2C49D;
        Mon,  9 Oct 2023 19:50:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Mcw2UA4aXbZHIttZ0r860FakIp4KFUULyjvSrQ
        lbZDM=; b=iwjpvdxMsIWFUO14pwfonqAMtS0bnJbHrgW6fsb08083K5P1sm5ZUu
        KXXu8vyujmXzMD6WKzyBxYjWjQxDM2BK9WKFOByohGZndlg9cjb7ocvI0fJAJ+sD
        6+zSq8qUhT1Kk4ji1U1ExOx6qtc/ux8yEQtA4uIo/MWpUb+B9OVkQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 69B602C49C;
        Mon,  9 Oct 2023 19:50:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 491C32C49A;
        Mon,  9 Oct 2023 19:50:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com, linusa@google.com,
        calvinwan@google.com, rsbecker@nexbridge.com
Subject: Re: [PATCH v8 0/3] Add unit test framework and project plan
In-Reply-To: <cover.1696889529.git.steadmon@google.com> (Josh Steadmon's
        message of "Mon, 9 Oct 2023 15:21:19 -0700")
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
        <cover.1696889529.git.steadmon@google.com>
Date:   Mon, 09 Oct 2023 16:50:43 -0700
Message-ID: <xmqqh6mzwe24.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9E55C82-66FE-11EE-A192-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Changes in v8:
> - Flipped return values for TEST, TEST_TODO, and check_* macros &
>   functions. This makes it easier to reason about control flow for
>   patterns like:
>     if (check(some_condition)) { ... }
> - Moved unit test binaries to t/unit-tests/bin to simplify .gitignore
>   patterns.
> - Removed testing of some strbuf implementation details in t-strbuf.c
>
>
> Josh Steadmon (2):
>   unit tests: Add a project plan document
>   ci: run unit tests in CI
>
> Phillip Wood (1):
>   unit tests: add TAP unit test framework

Thank you, all.

The other topic to adjust for cmake by Dscho builds on this topic,
and it needs to be rebased on this updated round.  I think I did so
correctly, but because I use neither cmake or Windows, the result is
not even compile tested.  Sanity checking the result is very much
appreciated when I push out the result of today's integration cycle.

$ git log --oneline --first-parent --decorate master..js/doc-unit-tests-with-cmake
d0773c1331 (js/doc-unit-tests-with-cmake) cmake: handle also unit tests
192de6de57 cmake: use test names instead of full paths
e1d97bc4df cmake: fix typo in variable name
e07499b8a7 artifacts-tar: when including `.dll` files, don't forget the unit-tests
11264f8f42 unit-tests: do show relative file paths
6c76c5b32d unit-tests: do not mistake `.pdb` files for being executable
295af2ef26 cmake: also build unit tests
31c2361349 (js/doc-unit-tests) ci: run unit tests in CI
3a47942530 unit tests: add TAP unit test framework
eeea7d763a unit tests: add a project plan document

