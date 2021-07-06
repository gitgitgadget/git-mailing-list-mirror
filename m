Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65AEC07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 19:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AAD461C91
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 19:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhGFTW2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 15:22:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50959 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbhGFTW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 15:22:28 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 53C93148C77;
        Tue,  6 Jul 2021 15:19:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cGv2k02NnPZ0fk37ONXYBb0M0QftqSOZoCqvT2
        1wqHU=; b=EIoS/61BnxnmYzIgp5CWDfYM/5D6S9F9RZJV1VyFFFmbEjUTihJbBe
        FMQJZLnL5/L3AdzOKF4O8x/8il0wVWlh/upkbjhP0f5msD4gOZzx5O45tkNsZLBE
        0Dra6lqrUTo5cN2XwS6KiM4xlqQ9g1FksfwMqGa56etgRbrWyTL1w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4BD4E148C76;
        Tue,  6 Jul 2021 15:19:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C2577148C75;
        Tue,  6 Jul 2021 15:19:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Dennis Ameling via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Dennis Ameling <dennis@dennisameling.com>
Subject: Re: [PATCH v3 6/7] ci(vs-build): build with NO_GETTEXT
References: <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
        <pull.878.v3.git.1625439315.gitgitgadget@gmail.com>
        <2c4cd9dd1c8d966c8df0349bb820449ae1290793.1625439315.git.gitgitgadget@gmail.com>
Date:   Tue, 06 Jul 2021 12:19:45 -0700
In-Reply-To: <2c4cd9dd1c8d966c8df0349bb820449ae1290793.1625439315.git.gitgitgadget@gmail.com>
        (Dennis Ameling via GitGitGadget's message of "Sun, 04 Jul 2021
        22:55:13 +0000")
Message-ID: <xmqqsg0rjlm6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2046A1E2-DE8F-11EB-B786-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Dennis Ameling via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Dennis Ameling <dennis@dennisameling.com>
>
> We already build Git for Windows with `NO_GETTEXT` when compiling with
> GCC. Let's do the same with Visual C, too.
>
> Note that we do not technically _need_ to pass `NO_GETTEXT` explicitly
> in that `make artifacts-tar` invocation because we do this while `MSVC`
> is set (which will set `uname_S := Windows`, which in turn will set
> `NO_GETTEXT = YesPlease`). But it is definitely nicer to be explicit
> here.

In other words, is this a no-op but makes the recipe more readable?
