Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F145C4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 17:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1AC722254
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 17:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x2KPP0SJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754103AbgJWR7r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 13:59:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52352 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754099AbgJWR7q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 13:59:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 76FFF8B65A;
        Fri, 23 Oct 2020 13:59:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MeKAqbEbjSrlQuYGkB6OzPlK3kg=; b=x2KPP0
        SJkY2jc2tx66ogry4NATGjy7w9Dbv5hJLp1QHOHzp5r6fPTS7V6Wwvs4hhG2QVIj
        6UTDbB7VQk15XfoUoDGEcBPzd31dQTN4XonbcLEuV+DoU02RNjZd6SPLUSnGkdjd
        25OgxM1hA3Yw9lndMd8LKGSpI1Ofp9ATz/UmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yVwlbcZ70+Bl1m4K8aDbhjnqWJj2CVFW
        u9rmrHjKw3bqHwi29Es6DAHXojbcKwkbaj/lLYcqSUdfR99bRpdt0Qn3sZYf0D/C
        Z09BJqNBSVXqxGgLCaGEzNWJvAlT3K+s4eripfGOsQmndTjUhplLX/uXaR0++nml
        vRjCPFocj5I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E6FE8B659;
        Fri, 23 Oct 2020 13:59:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB83F8B658;
        Fri, 23 Oct 2020 13:59:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Jeff King <peff@peff.net>, VenomVendor <info@venomvendor.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: committer-date-is-author-date flag removes email in "Commit"
References: <e08df0d5792ab70a9158be32cfa28696@venomvendor.com>
        <20201023070747.GA2198273@coredump.intra.peff.net>
        <xmqqmu0dhsoz.fsf@gitster.c.googlers.com>
        <58e83ad2-14a2-5ace-c1fd-8224625a0f97@gmail.com>
Date:   Fri, 23 Oct 2020 10:59:43 -0700
In-Reply-To: <58e83ad2-14a2-5ace-c1fd-8224625a0f97@gmail.com> (Phillip Wood's
        message of "Fri, 23 Oct 2020 18:32:51 +0100")
Message-ID: <xmqqh7qkhlgw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87D0DAE4-1559-11EB-840A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> I wonder if we even needed to do the original change to begin with
>> (stopping to export means not giving information to the hooks), but
>> that is a separate matter.
>
> I think the main motivation was to stop polluting the environment of
> exec commands

As long as the information that used to be exported can be learned
by the hook script when/if it wants to (how?  read the original
commit object with "git show -s --format=..."?  How would it know
which one is the original commit?), it is fine.

If not, a script that does not want the exported environment
variable can easily ignore it (just "unset" it) but to a script that
wanted to learn the information that used to be in the environment
variable, it's not "stop polluting" but "lose information", and that
is where my earlier "I wonder" comes from.


