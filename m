Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44CE91F461
	for <e@80x24.org>; Fri, 30 Aug 2019 17:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfH3RSt (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 13:18:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56483 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbfH3RSt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 13:18:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E22E06EBC5;
        Fri, 30 Aug 2019 13:18:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y3Vj6HirABhp6xC4wwps83iNNV4=; b=JBWHPw
        UekY6ZIrn7kdN3seVFPtRakaphmxITJCMjPRi8hlUsbyB9d1NqHVzQNIapjdbe5T
        M9FM0nLutS1R/8XRlrDm3DOgTHDHU8Z0Suz9W/+70cLJcXBSR6soR8ot8+kGCg0r
        T/GX+O29HGC6Tr1q5bYIINcdFY6bRF7LywogI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SL1DZlC/SQxGNIteIQwLAhRtXcdl7YNp
        Z6EGCJqoEA4a5glapDgjClm+1j3GKzFBECIBeB7B4NY/5J/jszZAQJccGMO9Ctr/
        1wZtSY8LKICR3/NHwgcvNvVxBV/53L0jhOveV6/FUOlLc7P+HEsafdZ6nG5G39ub
        PsF6cwCmrU4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DA2056EBC3;
        Fri, 30 Aug 2019 13:18:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 18F836EBC2;
        Fri, 30 Aug 2019 13:18:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] checkout: add simple check for 'git checkout -b'
References: <pull.325.git.gitgitgadget@gmail.com>
        <dcf5c60c69d8275a557ffe3d3ae30911d2140162.1567098090.git.gitgitgadget@gmail.com>
        <7e406b35-9ff6-348f-bdee-7540381f000e@gmail.com>
        <206819d0-8066-e8e8-8967-8a1db05eea26@gmail.com>
        <20190829203037.vzxuaxpsghbdc6vl@yadavpratyush.com>
        <20190829214014.vijdotp4g65a5mk3@yadavpratyush.com>
        <CABPp-BF_uBTKT_5YmoMNoToiujuMdQia-OfxOPAJPrhT6jPbdA@mail.gmail.com>
        <20190830004339.GA34082@syl.lan>
Date:   Fri, 30 Aug 2019 10:18:41 -0700
In-Reply-To: <20190830004339.GA34082@syl.lan> (Taylor Blau's message of "Thu,
        29 Aug 2019 20:43:39 -0400")
Message-ID: <xmqqzhjqy3ke.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3820B67C-CB4A-11E9-A1F9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I wholeheartedly agree with this, and pledge my $.02 towards it as well.
> Now with a combined total of $.04, I think that this patch is ready for
> queueing as-is.

;-)
