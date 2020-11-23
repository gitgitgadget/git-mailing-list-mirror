Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29E6C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E30620706
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rSCKgnq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbgKWTde (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 14:33:34 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59295 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbgKWTdd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 14:33:33 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BD70DEFD47;
        Mon, 23 Nov 2020 14:33:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b1cPHzkblWFQ1+mdNeLiAXkV5Ko=; b=rSCKgn
        q6jOi+qyF/XKE/O74rKiyhz4Rdjg/eSicFfu0NXL6H66WC0tqCM9ReempBP4yfhQ
        Gm+WdpW6+Xbj0RDKu6XFbFjYXMeExNz2khmfNI9XmPlB8VDcTlHXDClIr9VB36UD
        UlION6YmOInhhr6Ov/14FQimy2aTqSGC6bETI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FJG2m08Wkr2H0DugHN4rB7+p2t+bFdVL
        bEIDBUKsqjAzcz4ERPDLHadpqvBcXXxn6w9XP6neKFyIINTEmlY1urr65E499SoM
        VbgugmsGo4bnEICcdB8PBYMNqYB/2QVf6yCwZDOiNMuWcHcRP7gmpMUpuL4TffqL
        7zaQ0RDSQXc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B5328EFD46;
        Mon, 23 Nov 2020 14:33:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 01D5AEFD44;
        Mon, 23 Nov 2020 14:33:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/7] config: add --fixed-value option
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
        <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
Date:   Mon, 23 Nov 2020 11:33:28 -0800
In-Reply-To: <pull.796.v2.git.1606147507.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Mon, 23 Nov 2020 16:05:00
        +0000")
Message-ID: <xmqq8sarool3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C401515C-2DC2-11EB-84E7-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  * Updated the test structure for the new tests in t1300-config.sh

Patches [1/7] and [2/7] got much less scary with this change.

Nice.

Thanks, will replace (but with other topics depend on this series,
it may take a bit more time than usual).
