Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3121F1F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 02:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbfJHCTQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 22:19:16 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63349 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbfJHCTP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 22:19:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BE9F591405;
        Mon,  7 Oct 2019 22:19:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Nwq/0Jrs05cI5j54FKw/BkDSj7k=; b=IFhISU
        sh1DuER8rKD/OBh2y3NSphTs8m1LnRuugBM+ALqi6mB6NShy/fod1ZDZBQ8AFwM9
        Q/EDSV8X1MO2DW78VRS8ZOyJDb5CEgW552cho6lO1TLnStQuMZYl4vIok/iDGQwy
        CRJqc202LzMMs+H5zDGiVIaOkjHQfXMzDI+Ag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=No4Yd2/1R9UC1JDacGzeW9gdBtl9jmFr
        cainp9WmrtGlq4Z97l53YTBc9Q4Z/UwOdIvxiqcd25qxpDT00dVyhUSCovOql3OT
        eRe6feTxg24uEdOwm9urM+M2K6QqVp5qncCnPNxb7CipIuqS0j9P/lofNbXU3r+7
        JXtmplRVasY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A3C7491404;
        Mon,  7 Oct 2019 22:19:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BF47E91402;
        Mon,  7 Oct 2019 22:19:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v3 00/13] ci: include a Visual Studio build & test in our Azure Pipeline
References: <pull.288.v2.git.gitgitgadget@gmail.com>
        <pull.288.v3.git.gitgitgadget@gmail.com>
        <xmqqimp26808.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1910061157320.46@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1910062237440.46@tvgsbejvaqbjf.bet>
        <xmqq1rvp5pc0.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1910072350300.46@tvgsbejvaqbjf.bet>
Date:   Tue, 08 Oct 2019 11:19:08 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910072350300.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 7 Oct 2019 23:51:29 +0200 (CEST)")
Message-ID: <xmqqzhicnfmr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03A190CE-E972-11E9-B077-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I didn't quite understand this part, though.
>>
>>     The default creation factor is 60 (roughly speaking, it wants 60% of
>>     the lines to match between two patches, otherwise it considers the
>>     patches to be unrelated).
>>
>> Would the updated creation factor used which is 95 (roughly
>> speaking) want 95% of the lines to match between two patches?
>>
>> That would make the matching logic even pickier and reject more
>> paring, so I must be reading the statement wrong X-<.
>
> No, I must have written the opposite of what I tried to say, is all.

So, cfactor of 60 means at most 60% is allowed to differ and the
two patches are still considered to be related, while 95 means only
5% needs to be common?  That would make more sense to me.

Thanks.

