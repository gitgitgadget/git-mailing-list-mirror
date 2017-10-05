Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 626192036B
	for <e@80x24.org>; Thu,  5 Oct 2017 09:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751402AbdJEJuv (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 05:50:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63716 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751298AbdJEJuu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 05:50:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E1DD966A3;
        Thu,  5 Oct 2017 05:50:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lN5qm2vW5pPR0oauJ+Peck5gllM=; b=m7NYdf
        8MCccOAeSf0UPGgpi4rw5I+9nhE3rw734raeEpJ+51DacVZ6YmeXOUo2ni1WHxaX
        A9zqygcF5LInGXR/xDdsVA5MoJ39b8VvqiJBgsPkOQ5gBOB06QvS7hIH8EulXAI0
        850aRrRMlMJqtonlOc9A66oi7tKANqQJWKSqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HiqXAfSnEcSWqk2sEwIT7MRm/5JNdEXu
        DVLD6dcVoKIPjCZstjBn6LvBOiyrQung/NawFbl2kVlna+ixg14JJCsErfQ2rxan
        0+ibzyvUyxg9FIXkRFZmMRsieZr0rL0y67uJZVSEC7fFWWZeqa5p37KOomo3lD9s
        o4QZ8PzlWLk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 25A31966A2;
        Thu,  5 Oct 2017 05:50:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 539E4966A1;
        Thu,  5 Oct 2017 05:50:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        stolee@gmail.com, git@jeffhostetler.com, sbeller@google.com
Subject: Re: [PATCH v3 3/5] sha1_name: Unroll len loop in find_unique_abbrev_r
References: <20170925095452.66833-1-dstolee@microsoft.com>
        <20171002145651.204984-4-dstolee@microsoft.com>
        <xmqqtvzfcuoy.fsf@gitster.mtv.corp.google.com>
        <20171005091334.7oyjaco432l5p6ft@sigill.intra.peff.net>
Date:   Thu, 05 Oct 2017 18:50:47 +0900
In-Reply-To: <20171005091334.7oyjaco432l5p6ft@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 5 Oct 2017 05:13:34 -0400")
Message-ID: <xmqqr2uh7wjs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AAE1B44C-A9B2-11E7-8115-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So I think on the generating side we are better off creating a slightly
> longer abbreviation that is unambiguous no matter what context it is
> used in. I.e., I'd argue that it's actually more _correct_ to ignore
> the disambiguation code entirely on the generating side.

OK.  Thanks for sanity checking.
