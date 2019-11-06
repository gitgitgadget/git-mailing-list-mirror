Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 888F81F454
	for <e@80x24.org>; Wed,  6 Nov 2019 01:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbfKFB7H (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 20:59:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58757 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730687AbfKFB7H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 20:59:07 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D0332AB4F;
        Tue,  5 Nov 2019 20:59:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qjdkvi6J6m/Oay26/qXklXfGSEI=; b=pfTZiB
        JMlOUza+7cZqr7Hp1CaB1x/RSJqdsgwVQRQt5rY/809o4Nbb7lx9oAuG0XN8emiH
        bofZD4IAx5l/5C/R4vTVmwm/fGFi33UQyhmCy224oKM89HRcVxW5oBmYTXPRFJkq
        yOUAz8OMfcpoaUR7CRW0W1EzLn1Y1sjxRGGwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uJw/hua/CCVYix3DjtAvF0NqQcEvKatp
        nIpdIc8REAUCGPIIrWvDke9QegBTg29Hrc8G1ubkOGTXtYMaCOoGsRlz+Ubc+Ccq
        XPzFgy9MWdX/nNd0bExZQr1RAWu7+VWJqCOtnH4WQQ05Lgp+tIw2L5k4JkVsA73C
        xVgg8EWcdCg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 14D2B2AB4E;
        Tue,  5 Nov 2019 20:59:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 495322AB4D;
        Tue,  5 Nov 2019 20:59:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Fix locking issues with git fetch --multiple --jobs=<n> and fetch.writeCommitGraph
References: <pull.443.git.1572740518.gitgitgadget@gmail.com>
        <20191104195928.GC20900@sigill.intra.peff.net>
Date:   Wed, 06 Nov 2019 10:59:03 +0900
In-Reply-To: <20191104195928.GC20900@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 4 Nov 2019 14:59:28 -0500")
Message-ID: <xmqqo8xpwys8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 027E63A6-0039-11EA-9FFF-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Thanks, the whole thing looks clearly explained and the patches
> themselves look good. And having "--[no-]write-commit-graph" is a good
> thing even independent of the problem you're fixing.
>
> I wondered if it was worth having a test in the second patch, but I
> think it would be inherently racy. So it's probably not worth the
> trouble.

Thanks, both.
