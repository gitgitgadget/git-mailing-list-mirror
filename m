Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB06AC4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 01:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiJTB3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 21:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiJTB3c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 21:29:32 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD051CB526
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 18:28:40 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4FD141C4530;
        Wed, 19 Oct 2022 21:21:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zuPmt0x8yufmjNeME/WSf8EluRbLE7Sacp4XCu
        JLRZ4=; b=pj1+HKnSTUbuBSVsCvcZkTvsHQtQiDWcXl+RyTTGQ6qWMKgtPaizsT
        lltTT65ISkIwhSrdR1N3YW2hbwv2DOnNsNvmPcJQsaxvQsK8Ul4G9HG25SxempTN
        pN9JhhlscQTB/DAhHDI58Fpvk//xLOnUT7cOF6OoOWohRn3vHrcm4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4817E1C452F;
        Wed, 19 Oct 2022 21:21:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7E10A1C452E;
        Wed, 19 Oct 2022 21:21:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heather Lapointe <alpha@alphaservcomputing.solutions>
Cc:     Heather Lapointe via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/9] archive: Add --recurse-submodules to git-archive
 command
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
        <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
        <xmqqo7u9t1zf.fsf@gitster.g>
        <CAFwvh9BwV=NEtF_gsh9Tr8gHz02=78m4MCBQbuXk5SzKCAm4RA@mail.gmail.com>
        <xmqqy1tbssa8.fsf@gitster.g> <xmqqwn8vpmr3.fsf@gitster.g>
Date:   Wed, 19 Oct 2022 18:21:41 -0700
In-Reply-To: <xmqqwn8vpmr3.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        19 Oct 2022 13:44:00 -0700")
Message-ID: <xmqqfsfjnvbu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E011E08-5015-11ED-85C3-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> I personally doubt it is generally a good idea, as it sets a bad
>> pattern that tempts unsuspecting users to blindly copy and paste it
>> to their $HOME/.gitconfig without realizing what its ramifications
>> are, but the easiest workaround may be to mimic what was done in
>> t/lib-submodule-update.sh that sets protocol.file.allow
>> configuration knob globally.
>
> I'll queue this at the tip of your topic when I rebuild 'seen' for
> today's integration run.
>
>  t/t1023-tree-read-tree-at.sh  | 4 +++-
>  t/t5005-archive-submodules.sh | 7 ++++---
>  2 files changed, 7 insertions(+), 4 deletions(-)

It seems to have cleared the "submodule tests no longer can use
submodules with file:// without tweaking the config" issue I saw
earlier.  It seems to give us a segfault in win+VS test, though.

https://github.com/git/git/actions/runs/3285647856/jobs/5413033844#step:5:245

Thanks.


