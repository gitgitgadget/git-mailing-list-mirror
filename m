Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3219BC433E0
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 11:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F01FF22EBF
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 11:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbhAJLZe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 06:25:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57752 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbhAJLZd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 06:25:33 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B29C7A426D;
        Sun, 10 Jan 2021 06:24:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Ts4Lj3qM502Yi2tLdjcc8Y8lrm4=; b=RnTagR9gjhnJCHeZsNJ4
        pGwBX0HCIIONr2mk3CjIWonblCNtf15Kunmc94xeEZQ12oAxkrNEURtLXwDqfORl
        QT9HLzmIQQS5JVt5OOuq2sYkUZx6/dIOrhENorSp+i5HNJX77LSrQNVVXMGnoBYp
        6y2fRtzLKRK6KqZFfvQAz8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=kLZcwK3KpRVSA5DCXBLx2ifkC5T/b5X3lV+vLNp8g9C8cM
        FFUNfRsS/TCb+AoI7bwshUaAJWmGLQY/R0iIsTwrrTS+fbOwPpaLQ6z5EwOa2xtT
        s53CZxKTxQMZEssDdaOvS30rx2D/qkz7plJVeRsyuf4HVyhX1jlk8h2DNjHVw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A93B4A426C;
        Sun, 10 Jan 2021 06:24:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3414BA4269;
        Sun, 10 Jan 2021 06:24:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Seth House <seth@eseth.com>
Cc:     David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Re* [PATCH v2] fixup! mergetool: add automerge configuration
References: <X/onP6vFAHH8SUBo@camp.crustytoothpaste.net>
        <20210109224236.50363-1-davvid@gmail.com>
        <20210109225400.GA156779@ellen>
        <xmqqmtxhd1zx.fsf@gitster.c.googlers.com>
        <xmqqa6thcn1n.fsf_-_@gitster.c.googlers.com>
        <20210110072902.GA247325@ellen>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Sun, 10 Jan 2021 03:24:48 -0800
Message-ID: <xmqqh7np9gqn.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73477E6E-5336-11EB-9D54-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House <seth@eseth.com> writes:

> On Sat, Jan 09, 2021 at 10:40:20PM -0800, Junio C Hamano wrote:
>> An ugly workaround patch that caters only to difftool breakage is
>> attached at the end; I did not look if a similar treatment is
>> necessary for the mergetool side.
>
> That fixup does the trick on my machine too. Thank you.

Note that with t7800 fixed with the patch, non Windows jobs all seem
to pass, but t7610 seems to have problem(s) on Windows.

https://github.com/git/git/runs/1675932107?check_suite_focus=true#step:7:10373

> How wary are you of continuing with `initialize_merge_tool`? Do you see
> a better approach to get `automerge_enabled `into scope? While it is
> a nice feature to have, is it worth the risk vs. reward?

Hmph.  We need to have a way to define helper routines customized
for the tool, and in the codebase without this series, it is the job
for setup_tool.  It defines fallback implementations, allows tool
specific customizations.  

Your initialize_merge_tool is just a thin wrapper around setup_tool.
It calls setup_tool, and if the function exits with non-zero status,
returns with status==1 (and otherwise returns with status==0).  As I
expect all the callers of setup_tool or initialize_merge_tool would
either ignore the status or check if it succeeded (i.e. compare $?
against 0 and any non-zero values are treated equally), it does not
seem to do anything useful.

I think we may be able to get rid of initialize_merge_tool, but you
would need to call setup_tool in places initialize_merge_tool was
called in your patch, as you must have needed to make sure that the
tool specific customizations have been carried out before going
forward in these places.

So, no, I do not see a reason to be wary of initialize/setup.  

With or without the seemingly needless initialize wrapper, I think
calling setup before starting to do certain operations that need
tool specific customization is just necessary.  The same machanism
has been in use to give can_merge/can_diff to each tool and the way
it works ought to be fairly well understood.

It is a different story if it makes sense not to exit when you see
failure from initialize/setup, and instead _skip_ running helpers
like run_merge_tool.  It was just a mistake we all make every once
in a while (i.e. a bug), and I am reasonably sure that we will
introduce more of them but we will be capable of fixing all.

Thanks.
