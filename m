Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3B7E1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 16:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757981AbdCXQpf (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 12:45:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61470 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751818AbdCXQpd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 12:45:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9A3974793;
        Fri, 24 Mar 2017 12:45:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hmMaqH+kzVHBPtHselMgNalRkoE=; b=CQYYBp
        9BY8Hk2pX7ZxfUnHLAKBJ0ZwA7rn3LC7l8TakUzFeYEtHmnYrkIOOWPU7B2eXdAt
        glay04N2LruDwvnb68516T35oAABM0krt0EQwLjbU+TdQj7ZeSiFxrVLKGTnYbJi
        aUEZ6WG00vrGIj/nODgnEQjb7MgGIU1slUx/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v2oPAIcQkbERBDGPq/LY2kHSc2C3ufQW
        FQmFPD8BSBZ1KOldYt8WgQ4CHHldXpfiQbbLVHhS5xN3zxAXJCXOnfFZ2IGQftnf
        TAn5nIHLl4G+FLTD6xVAreBr4nGrNoef4m8466haA8PmoIZLyKNvZZWvFme+7d4R
        JDCQICY7kgM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C1C1A74792;
        Fri, 24 Mar 2017 12:45:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 345587478E;
        Fri, 24 Mar 2017 12:45:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        Jan Palus <jan.palus@gmail.com>
Subject: Re: [PATCH 3/3] t7004, t7030: fix here-doc syntax errors
References: <20170322200805.23837-1-gitster@pobox.com>
        <20170322200805.23837-4-gitster@pobox.com>
        <20170322211003.b52cql3iwig2xqcd@sigill.intra.peff.net>
        <xmqq8tnxhssv.fsf@gitster.mtv.corp.google.com>
        <20170322221556.j7uj4vvgbcubcr3b@LykOS.localdomain>
        <20170322222230.yqqv6x4gokvb4jbz@sigill.intra.peff.net>
        <20170322223441.w32y464jqbnxnzna@LykOS.localdomain>
        <20170322224124.u3eax4ui3y4saxks@sigill.intra.peff.net>
        <20170322225108.wub4bmr63hk2sp33@LykOS.localdomain>
        <xmqqfui3ac2f.fsf@gitster.mtv.corp.google.com>
        <20170323234922.ot2vqblcnljacdtn@sigill.intra.peff.net>
Date:   Fri, 24 Mar 2017 09:45:30 -0700
In-Reply-To: <20170323234922.ot2vqblcnljacdtn@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 23 Mar 2017 19:49:22 -0400")
Message-ID: <xmqqlgru8vyt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B09D396-10B1-11E7-AE89-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Mar 23, 2017 at 03:00:08PM -0700, Junio C Hamano wrote:
>
>> Santiago Torres <santiago@nyu.edu> writes:
>> 
>> > This sounds like a helpful addition to implement. We could update/add
>> > tests for compliance on this once the feature is addded and fix the
>> > ambiguous behavior in the tests now.
>> 
>> OK, so has everybody agreed what the next step would be?  Is the
>> patch below a good first step (I still need to get it signed off)?
>
> Yeah, I think this is the right fix.
>
>> -- >8 --
>> Subject: t7004, t7030: fix here-doc syntax errors
>> From: Santiago Torres <santiago@nyu.edu>
>> 
>> Jan Palus noticed that some here-doc are spelled incorrectly,
>> resulting the entire remainder of the test as if it were data
>> slurped into the "expect" file, e.g. in this sequence
>
> I had trouble parsing this. Perhaps:
>
>   resulting in the entire remainder of the test snippet being slurped
>   into the "expect" file as if it were data

Thanks.  Will rephrase.

I actually think this uncovers another class of breakage.  t7030
tests should be protected with GPG prereq and 'fourth-signed' that
is made only with the prereq in the first test will not be found.
t7004 probably has the same issue.



