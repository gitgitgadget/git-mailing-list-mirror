Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C4A91F461
	for <e@80x24.org>; Fri,  6 Sep 2019 18:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404454AbfIFSYR (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 14:24:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51196 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404380AbfIFSYR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 14:24:17 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 540E73321A;
        Fri,  6 Sep 2019 14:24:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6LftfBisLCalGgKlustABPaYNqg=; b=cG+fiU
        DJ/yJCpxANzFvGNg0F6jNBE+RPlChGYx0MOLMBcSK4SLDLphv/RpTdvhJ2e2C5Vt
        PyE+21w+ziLPzijkVLzNEpQup2Ug0wSBtyh7EztOaGZZV5EFUOZVMwq7J9FRO7X6
        7DmBEofdYbzZnxcwMIHsClOP/DtlCwUurUcFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ojySl8eC1W9ZRqzXsPQGn+NYVGuC3Km7
        VT9BBE0Sp52/T4sVtQNKOS78LW2tNyT+fFLARC3amoXLbQexcnBH1MdNeHZBQaQq
        1vh87/jrfxTD0l2oPFp/JMmXCitGKKrt1MPTAWiykly77dizQHl8IUt+yJ/yFTWw
        ESqlwnYGvJA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 42CD733219;
        Fri,  6 Sep 2019 14:24:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8279033218;
        Fri,  6 Sep 2019 14:24:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, avarab@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] fetch: add fetch.writeCommitGraph config setting
References: <pull.328.git.gitgitgadget@gmail.com>
        <49f877c85ca2be5bb76d9082ee4aa26e26111a14.1567477320.git.gitgitgadget@gmail.com>
        <20190904030829.GB28836@sigill.intra.peff.net>
        <xmqqa7bipjil.fsf@gitster-ct.c.googlers.com>
        <a697c4de-e269-c330-ece2-8ac7007e6c55@gmail.com>
        <20190906175628.GH23181@sigill.intra.peff.net>
Date:   Fri, 06 Sep 2019 11:24:12 -0700
In-Reply-To: <20190906175628.GH23181@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 6 Sep 2019 13:56:28 -0400")
Message-ID: <xmqq1rwtnv03.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87BEA408-D0D3-11E9-85A4-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Sure, but wouldn't that similarly apply to fetching? What is it that
> makes bursts of pushes more likely than bursts of fetches?

Because people tend to use a repository as a gathering point?  You
may periodically fetch from and push to a repository, and you may
even do so at the same interval, but simply because there are more
"other" people than you alone as a single developer in the project,
your fetch tends to grab work from more people than yoru push that
publish your work alone?
