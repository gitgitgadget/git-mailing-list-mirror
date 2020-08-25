Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ED8C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 15:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE592076C
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 15:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uw3ud4S9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgHYPqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:46:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57402 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgHYPqR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 11:46:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 72E807F02A;
        Tue, 25 Aug 2020 11:46:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R2d/Q1xKLf+V/cEy6DWdUWaWhP8=; b=uw3ud4
        S9Hd1II93Um01i1ebHK5lUN+ZYroLjIY8PhSBNYwPbxxJJsnLQwkL9tdnjEyiEzA
        BJecAVDgVlGq6hgc/G0KEUy+Dcvihxow0JMdjn2hSppWm/wg7wpM6wDliFTl1//q
        vSz/FD499xBr9ckNP8pUpY0ksPaQ7o4iaX9ZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vcytuJAoZlsqzM6te8vVyvlK8/dFIa0Y
        rKrY5v7EjnxPZ2I3w4ps9OEB4UXyVOfINwji+1wRn2Zc3TpPia/prv1lUEOljleP
        Xz+kot3QoULowgCh6je+4FjE2A04e66/Bx6Y5sBgcVrgxN3mb5AqI0S47VRvqxCt
        VYY0YWUxJtE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B1107F029;
        Tue, 25 Aug 2020 11:46:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EB56B7F028;
        Tue, 25 Aug 2020 11:46:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: pw/add-p-allowed-options-fix, was Re: What's cooking in git.git (Aug 2020, #06; Mon, 24)
References: <xmqq7dtn3785.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2008251056290.56@tvgsbejvaqbjf.bet>
Date:   Tue, 25 Aug 2020 08:46:14 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2008251056290.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 25 Aug 2020 10:58:03 +0200 (CEST)")
Message-ID: <xmqqy2m220ft.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1BB5272C-E6EA-11EA-A13A-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 24 Aug 2020, Junio C Hamano wrote:
>
>> * pw/add-p-allowed-options-fix (2020-08-17) 2 commits
>>  - add -p: fix checking of user input
>>  - add -p: use ALLOC_GROW_BY instead of ALLOW_GROW
>>
>>  "git add -p" update.
>>
>>  Will merge to 'next'.
>
> I thought the consensus was to untangle the refactoring in the second
> patch by first fixing the `e` case, and _then_ refactoring?

Not really.  My take on it is that everybody would agree that the
split would be to "fix 'e' without introducing the code structure
change" then to "change the code structure to make the bug
impossible", _IF_ we were to split the "fix" part into two.  I do
not think anybody agreed to anything beyond that, and I am leaning
toward keeping the "let's change the code structure to make such a
bug impossible to introduce---oops, as a side effect we already
fixed the 'e' bug", which, as you say, is more than good enough.

> With Phillip being offline for a couple days, however, I think we can just
> go forward with the patches as-are. They are in "good enough" a shape.

Thanks.
