Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 712521F454
	for <e@80x24.org>; Thu,  7 Nov 2019 05:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfKGFqs (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 00:46:48 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55206 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfKGFqs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 00:46:48 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F6CB3700B;
        Thu,  7 Nov 2019 00:46:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b2iPRuzkThPQjHuddzFA2wZtLPI=; b=ejypZt
        Hq5XJNOkDsdlkpc3KrnCx1v3WHsXIuLCS1p1UyKvKPK9RYZziW4mFJ+8pjU1ZZ6d
        IetZS1n0Ykn0URUd4fDACeiKd5pMttzito3RoDQZeFIU+aCREiLDxk3z7rCO+eDr
        5qnCDaLAKPsP9wTB3LoQGnRr67NFvP5e99Aik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nlPaCZuvQ0C+gyyFXgDxkDMUcVsDZiw8
        vyb4FBEN8qx0DVWz1zt4xm59hVJR1UucSe5ky+Z6NWlfyRUWDpNpoCHncTAy2FFC
        kyP0ie2PGRQCaV9BKxKditLWMnYDj5tBohGER2GbftdSfmVHQ7HOcETLMAG5rgGE
        tqJEo5hXygo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1652A3700A;
        Thu,  7 Nov 2019 00:46:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7824E37009;
        Thu,  7 Nov 2019 00:46:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/5] doc: reset: unify <pathspec> description
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
        <1740ac7a291cfc81418c2d437201c3373487fa26.1572895605.git.gitgitgadget@gmail.com>
        <xmqqh83hveiz.fsf@gitster-ct.c.googlers.com>
        <b7acd8d1-d17a-29bd-44d3-59d425842c10@syntevo.com>
Date:   Thu, 07 Nov 2019 14:46:44 +0900
In-Reply-To: <b7acd8d1-d17a-29bd-44d3-59d425842c10@syntevo.com> (Alexandr
        Miloslavskiy's message of "Wed, 6 Nov 2019 16:56:34 +0100")
Message-ID: <xmqqo8xoqlvf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB9BF9A6-0121-11EA-B90B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com> writes:

>> It is not quite the opposite of adding to the index from the working
>> tree.  In this sequence:
>>
>> 	$ edit newfile
>> 	$ git add newfile
>>
>> and then further
>>
>> 	$ edit newfile
>> 	$ git add newfile
>> 	$ git reset -- newfile
>>
>> we are taken back to the state _before_ any of the changes made to
>> newfile (in fact, since HEAD does not have newfile, the resulting
>> index would not know about it, either).
>
> I am a bit confused, is it correct that you don't expect me to change
> my patches?

I do not know if removal of the only-half-correct "This is the
opposite of add" should be part of this change, or it should be a
separate fix.  The half-wrong sentene was not introduced by this
patch, so leaving it as-is is OK.  It just leaves another thing for
us to think about later.

Thanks.
