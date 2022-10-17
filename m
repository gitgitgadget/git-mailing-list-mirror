Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549EEC4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 15:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiJQPXX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 11:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiJQPXU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 11:23:20 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC50651439
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 08:23:18 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8023F15C2F6;
        Mon, 17 Oct 2022 11:23:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vZw99RQeAF/g8avzMijZVmSo4SoGZpMnzIllQW
        wvI6k=; b=rCw+3wIzvXrJCg/oRCICTYqKWW7ZaKrvTrBEOHMDcW5vDCUUimbEsf
        nqeTPT9slkTUs9o3GStZNHGiP8io9EN3vTRFi1Hif+xaDwzv4nm5UvUsPUYBRLem
        PV0pMreqYf1Bcuni/VIBSj8G3GhL/REzEydElCCnRLoQ3qPG9FfcA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7705115C2F1;
        Mon, 17 Oct 2022 11:23:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6D4A15C2F0;
        Mon, 17 Oct 2022 11:23:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     Jerry Zhang via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 3/7] builtin: patch-id: fix patch-id with binary diffs
References: <pull.1359.v2.git.1663654859.gitgitgadget@gmail.com>
        <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
        <2164212892712930cb34223499bb3e03bf2c2392.1665737804.git.gitgitgadget@gmail.com>
        <xmqqmt9y6rem.fsf@gitster.g>
        <CAMKO5CvdDWEd6HPbkg7DP9bZMKNzcvmK+c1UPpuTk7vM1D8i9g@mail.gmail.com>
Date:   Mon, 17 Oct 2022 08:23:15 -0700
In-Reply-To: <CAMKO5CvdDWEd6HPbkg7DP9bZMKNzcvmK+c1UPpuTk7vM1D8i9g@mail.gmail.com>
        (Jerry Zhang's message of "Fri, 14 Oct 2022 15:34:05 -0700")
Message-ID: <xmqqk04y1nks.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FC024FA-4E2F-11ED-BFA7-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

>> I thought I saw that a previous step touched diff.c to change how
>> patch ID for a binary diff is computed to match what patch-id
>> command computes?  Now we also have to change patch-id?  In the end
>> output from both may match, but which one between diff and patch-id
>> have we standardised on?
> Er yeah let me see if I can simplify.
>
> Before:
> Internal patch-id w/ unstable + binary was correct
> Internal patch-id w/ stable + binary was broken
> builtin patch-id w/ binary was broken
>
> After:
> Internal patch-id w/ unstable + binary is correct
> Internal patch-id w/ stable + binary is now correct
> builtin patch-id w/ binary is now correct
>
> So the "standard" actually came from the one working case from
> "before", which was the diff.c logic + unstable.

OK.

The question was meant to help you improve the log message, as it is
something a future reader of "git log" would wonder after reading
them.  I think including something that makes it easy for readers to
arrive at the summary above themselves by reading the log message
would be a very much welcome change.

Thanks.
