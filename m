Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5192CC433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 18:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBCE421527
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 18:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sGBkSVLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389109AbgJOSlk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 14:41:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52039 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731154AbgJOSlj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 14:41:39 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FA44892CF;
        Thu, 15 Oct 2020 14:41:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kbZOTi6cNElDqiNl86+CuRABbFI=; b=sGBkSV
        LFX6mBiew5f/ulR7gMVfgZl7ukxXwEV0UmDsy00bZ7eNF/OnlzbRm/xjOYLLI6rl
        L75cBznBbFoyiUCoNfXCwpDC4KokPsICcy9/RkuVviRlsviQmCVRdfHM02qpKPqv
        IOjGZ86xo/bqZuz7wq6p37F7EJoQpZRGEZ4Lg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DQyZsRIPsUEilIItAI0QDlOm4gJtaUDL
        GxoQ7i4D0PbCRMW6chHTL/+D1caS0yHi+XP0x9klbaTVZhSpMEeAsm9/2DaplXoX
        jAnfTCOqAHJtAr3HDN3MeOj4ois0+xSqW0ItD0duFL+gD8OO5Dx3rbaumXJmtU3G
        duDDEDSI4fI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 97A17892CE;
        Thu, 15 Oct 2020 14:41:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1C760892CD;
        Thu, 15 Oct 2020 14:41:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nipunn Koorapati <nipunn1313@gmail.com>,
        Alex Vandiver <alexmv@dropbox.com>
Subject: Re: [PATCH] dir.c: fix comments to agree with argument name
References: <pull.757.git.1602766160815.gitgitgadget@gmail.com>
        <20201015160725.GA1104947@coredump.intra.peff.net>
Date:   Thu, 15 Oct 2020 11:41:36 -0700
In-Reply-To: <20201015160725.GA1104947@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 15 Oct 2020 12:07:25 -0400")
Message-ID: <xmqqk0vrfi1r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E771C24-0F16-11EB-BAA4-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> - * If "ss" is not NULL, compute SHA-1 of the exclude file and fill
>> + * If "oid_stat" is not NULL, compute SHA-1 of the exclude file and fill
>
> Makes sense. This changed as part of 4b33e60201 (dir: convert struct
> sha1_stat to use object_id, 2018-01-28). Perhaps it would likewise make
> sense to stop saying "SHA-1" here, and just say "hash" (or even "object
> id", though TBH I think the fact that the hash is the same as an
> object-id is largely an implementation detail).

I do not quite get your "though TBH", though.  I do agree with you
that it is an implementation detail that an object is named after
the hash of its contents, so saying "compute object name" probably
makes sense in more context than "compute hash" outside the narrow
parts of the code that actually implements how object names are
computed.  So I would have expected "because TBH", not "though TBH".

Anyway.  Nipunn, can you fix both of them in the same commit, as
they are addressing a problem from the same cause (i.e. we are no
longer SHA-1 centric).

Thanks.
