Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31E5C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 16:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238035AbiG2Q6R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 12:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiG2Q6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 12:58:16 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1180289A56
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 09:58:16 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A1EC91A41B9;
        Fri, 29 Jul 2022 12:58:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n83w4EWvP6PVSqmHb7xJDCwbdRByln8l8lqGna
        J8FeM=; b=AAXnKsADmbuPJPbYBcgm7nC4sqoHXQgzjME85BIibEMJvdYqUuV26B
        bfNAOcp+n4pRcJNMX6Ck2QAi8nmSOVnTShs9jnBsqUu+hDste8/dFjAqR+p/NQrA
        qO9azmNTYlr31kQpIybojlBrP/yO2MHoZ4V0KkZ18pOl5PeKxImPo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B4AF1A41B8;
        Fri, 29 Jul 2022 12:58:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4EB811A41B4;
        Fri, 29 Jul 2022 12:58:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] mingw: include the Python parts in the build
References: <pull.1306.git.1659016906707.gitgitgadget@gmail.com>
        <pull.1306.v2.git.1659109272.gitgitgadget@gmail.com>
        <rq6919s9-qspp-rn6o-n704-r0400q10747r@tzk.qr>
Date:   Fri, 29 Jul 2022 09:58:11 -0700
In-Reply-To: <rq6919s9-qspp-rn6o-n704-r0400q10747r@tzk.qr> (Johannes
        Schindelin's message of "Fri, 29 Jul 2022 17:56:18 +0200 (CEST)")
Message-ID: <xmqqsfmj7t5o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A173ACCC-0F5F-11ED-BDDE-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 29 Jul 2022, Johannes Schindelin via GitGitGadget wrote:
>
>> Range-diff vs v1:
>>
>>  -:  ----------- > 1:  5d9b087625a windows: include the Python bits when building Git for Windows
>>  -:  ----------- > 2:  019fb837d68 mingw: remove unneeded `NO_GETTEXT` directive
>>  1:  a5739b9cce8 ! 3:  7dc0a1a9aa8 mingw: include the Python parts in the build
> ...
> Oh, that's funny. This is actually the first time I personally see
> `range-diff` matching up a wrong patch pair (because it really looks for
> the minimal diff between the diffs). It is of course nonsense to match up
> the original patch with the `NO_CURL` patch.

It would depend on the creation-factor number, I suspect.  To me, it
does not seem to match anything at all, but with an unreasonably
high number like 9999, I see 1 corresponds to the old one, with the
other two follow-up patch as new.

As the maintainer, I mostly use range-diff to compare two iterations
of a single topic, and not "compare 'seen' from 24 hours ago with
'seen' I just rebuilt, so that I can match up everything in an
uncontrolled mess", so the optimum factor number would be different
for my usecase from the one used for general use (which is
documented to be 60).

The "maintainer" use case compares two iterations that are known and
expected to have corresponding patches (and no corresponding one
means either dropped or added), and come to think of it, the use
case for submitter to run "format-patch --range-diff" shares exactly
the same expectation.  It is very different from "pick corresponding
patches from two piles of many unrelated topics" use case, in which
"range-diff" proper can be used.

Perhaps the default used for "format-patch" should become different
and set a lot higher than the default for "range-diff" proper?

