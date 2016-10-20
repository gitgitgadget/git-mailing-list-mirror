Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AEA51F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 17:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754793AbcJTRjL (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 13:39:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54296 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752366AbcJTRjK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 13:39:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A28AA46CF4;
        Thu, 20 Oct 2016 13:39:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=QosJf1B4NiaVC9zdskn7FKalMDs=; b=rSXyAC
        5GWROyzToKf14nlKvvUR+GRjA0mTca5Mn90GZpzeRlxXd9gntxr6gECHFfBx74L/
        K83IJ+3pUh6Q1E8pI5D/HCg3d46hb8l2aGB6kbFMbIu5ezJsJieTwUpnU46Kthip
        RouyZGdgK6dfph9A0WAedfpZgKxCr6uPBKoYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Pb30Mr9tRkScBioeY/77rtyLYEp2Y65e
        f3c0vtAbmhSF/Grat/OVRNNHKsq/oioDUtAoMRwMKOCdLF2ijZFImXyU4+ar5R95
        N2vWLXKWPIZBxtEslGOHPrVYtU2njIVK368v7OvdLDKavr4A2e4oJ0Tz6IZo9wgP
        ur8jSVnUdvo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 968D946CF3;
        Thu, 20 Oct 2016 13:39:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0269346CEF;
        Thu, 20 Oct 2016 13:39:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>
Subject: Re: tools for easily "uncommitting" parts of a patch I just commited?
In-Reply-To: <CA+P7+xq25LcdmtzmBNChiGhGratcdp7m0EOsQuEh68=gJQ9HNQ@mail.gmail.com>
        (Jacob Keller's message of "Thu, 20 Oct 2016 10:27:58 -0700")
References: <CA+P7+xqFOn4NSfZ2zpa_y1za3uHZrGGG3ktEtuOcvJLCrAYUhQ@mail.gmail.com>
        <20161019224211.k4anavgqrhmunz6p@sigill.intra.peff.net>
        <CA+P7+xprKV1Y7VShLR9uNgcpVdZk39xoTfkwiin1bVQYTe_TAA@mail.gmail.com>
        <20161020021323.tav5glu7xy4u7mtj@sigill.intra.peff.net>
        <xmqqa8dzhtki.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xq25LcdmtzmBNChiGhGratcdp7m0EOsQuEh68=gJQ9HNQ@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
Date:   Thu, 20 Oct 2016 10:39:07 -0700
Message-ID: <xmqqwph2hqdg.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1AF796E6-96EC-11E6-BB2D-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> I still think we're misunderstanding. I want git commit to complain
> *only* under the following circumstance:
>
> I run "git add -p" and put a partial change into the index in <file>.
> There are still other parts which were not added to the index yet.
> Thus, the index version of the file and the actual file differ.
>
> Then, I (accidentally) run "git commit <file>"

I agree that this case is different.

Again, users are different, and I also often do

    $ edit file; think; decide it is a good enough first cut
    $ git add file
    $ edit file; think; decide it is getting better
    $ git add file
    $ edit file; think; decide it is now perfect
    $ git commit file

Because I do not think you can differentiate the above workflow from
the case where "git add -p" was used earlier, I think your updated
"git commit" needs to complain at this point.

I am not sure if that is OK.  I think it is less not-OK than the use
case I mentioned in my earlier message, in that this is not a case
that "please don't do it" breaks.  It however is an inconvenience
that the user has to say "git add file" before the "git commit" (or
"git commit file") to conclude the sequence.

So I dunno.
