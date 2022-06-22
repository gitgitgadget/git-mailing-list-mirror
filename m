Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50EFC433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 15:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359423AbiFVPox (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 11:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiFVPov (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 11:44:51 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75681D311
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 08:44:50 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C52A912A524;
        Wed, 22 Jun 2022 11:44:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4ZuBrEsH+R3ilFJpej09nb33JkK29QSJCaofDq
        cycVA=; b=p9oNNB7RDrCR2J1xkwzs5oJcKQ3uLFBuckUVwIVjN9hnbLhq5GkupG
        Z267e8WEkK9Pe75zFw+9knqivUO+9uhjxhdknBv4jYfRGyWtrFSqCao7EvEBuCZi
        B9X4kiwNH+VpitvkjBYSO9ueSqKabrE1AT6neXddA5gYCsSBByAHQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA62F12A523;
        Wed, 22 Jun 2022 11:44:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 236F312A522;
        Wed, 22 Jun 2022 11:44:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, rsbecker@nexbridge.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/10] fetch tests: fix needless and buggy re-quoting
References: <xmqqa6a5g0m3.fsf@gitster.g>
        <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
        <patch-10.10-54129b94a77-20220621T222854Z-avarab@gmail.com>
        <xmqqsfnx6xbh.fsf@gitster.g>
        <69256646-13b0-5619-3161-8d8e319fad50@github.com>
Date:   Wed, 22 Jun 2022 08:44:48 -0700
In-Reply-To: <69256646-13b0-5619-3161-8d8e319fad50@github.com> (Derrick
        Stolee's message of "Wed, 22 Jun 2022 07:25:05 -0400")
Message-ID: <xmqq1qvg7le7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3FAC2DC8-F242-11EC-8C9B-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> It seems like this isn't the last time we are going to have a
> problem with string replacement like this, and having a well-defined
> helper would go far.

I think the idea of [10/10] is to use shell itself as a well-defined
helper, with "string replacement" being "$variable_interpolation".

Which isn't a bad approach, I would say.

> The rest of the changes to the test script seem more complicated
> than necessary for what _should_ be a simple problem.

True.  I am not sure which parts are unnecessary "churn while at it,
burying the most interesting and beneficial one at the end as a
hostage", and which ones are absolutely needed to reach [10/10].
Perhaps all of them are the latter?  I dunno.


