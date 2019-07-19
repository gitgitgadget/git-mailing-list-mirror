Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3D341F461
	for <e@80x24.org>; Fri, 19 Jul 2019 19:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfGSTvf (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 15:51:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51769 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfGSTvf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 15:51:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BFE4152908;
        Fri, 19 Jul 2019 15:51:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L1w03vLJF1KBkQuGXFY2pZ+AVvM=; b=ZAXdko
        GU4pMtEQCFFL3qdxj47IhcHQ//QG3wLawHzA67wAHSJKmlG1veaDqZsexA5vlFTo
        kn0s/csIBuUH7rob5aFXhyE7yp4DzO8LPmEAR/v0dZgHt35aDG2zj5eY8gTCgXlH
        nIcSBgE88vwE7JJgSZFMgFGFpRNAYEbBusPrs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NF16+4zZsmAR2KNruOHk8Xzb6+UeH5Ln
        TZnu4pWubnWOETtgqG+VfiMFRDqWwxacdP1b19ABadup0DeMFxGcLMTOsqSvkrRE
        nXdf7YgNzsbeTVHmLbOpG3ANjEkBduKqqrvzYTWJIMR0ZTJQQW59/AAoWiIdDsUN
        wV585FQaL7E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 63147152905;
        Fri, 19 Jul 2019 15:51:31 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AF0B9152903;
        Fri, 19 Jul 2019 15:51:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 1/9] t3404: demonstrate that --edit-todo does not check for dropped commits
References: <20190717143918.7406-1-alban.gruin@gmail.com>
        <20190717143918.7406-2-alban.gruin@gmail.com>
        <xmqqwogfxkhx.fsf@gitster-ct.c.googlers.com>
        <2836634.HGSAIcGHtf@andromeda>
Date:   Fri, 19 Jul 2019 12:51:29 -0700
In-Reply-To: <2836634.HGSAIcGHtf@andromeda> (Alban Gruin's message of "Fri, 19
        Jul 2019 20:12:27 +0200")
Message-ID: <xmqqimrxvm4e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A810ACC-AA5E-11E9-8B73-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

>> > +	test_i18ncmp expect.2 actual &&
>> > +	cp .git/rebase-merge/git-rebase-todo.backup \
>> > +		.git/rebase-merge/git-rebase-todo &&
>> 
>> Why?  Who uses this copy?
>> 
>
> The same technique is used in "rebase -i respects rebase.missingCommitsCheck = 
> error".

Ah, I misread the code.  I thought you were making a copy in .backup
that nobody looks at after the copy is made.
