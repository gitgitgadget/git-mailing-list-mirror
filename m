Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B9BC433F5
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 23:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbiCMXwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 19:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiCMXwB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 19:52:01 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0136311
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 16:50:53 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 813D6170BBE;
        Sun, 13 Mar 2022 19:50:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0rDQAErg952muKU7XusTZHK/4Yq4JNKFNpvh2Z
        XH3zs=; b=sp3I233cW0KZ7sGncvoXOGuKA23MadPObQOzo5GfPCvU0LDFTMLiFO
        +N5u8I8xGRcx4xiijD+uj9sSCF8y0BX3/7aT3QSq4/kTFopCajXlcAXKF2Qg/OeA
        mjcva6mg2BV5iSawzXsc0wFM+NgIf6i9rs99cqvh0yUxYzcRNTu5w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 79267170BBD;
        Sun, 13 Mar 2022 19:50:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 06A70170BBB;
        Sun, 13 Mar 2022 19:50:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com, bagasdotme@gmail.com,
        newren@gmail.com, avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v6 0/6] A design for future-proofing fsync() configuration
References: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
        <pull.1093.v6.git.1646952204.gitgitgadget@gmail.com>
        <xmqqmthxbcv2.fsf@gitster.g>
Date:   Sun, 13 Mar 2022 23:50:49 +0000
In-Reply-To: <xmqqmthxbcv2.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        10 Mar 2022 15:34:57 -0800")
Message-ID: <xmqqpmmptns6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6930878E-A328-11EC-A3E4-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Hmph, this seems to make one test fail.
>
> t5801-remote-helpers.sh (Wstat: 256 Tests: 31 Failed: 4)
>   Failed tests:  14-16, 31
>     Non-zero exit status: 1
> Files=1, Tests=31,  2 wallclock secs ( 0.04 usr  0.00 sys + 1.40 cusr  1.62 csys =  3.06 CPU)
> Result: FAIL

False alarm.  This byitself, or merged to 'seen' with other random
topics, no longer seem to break these tests.

