Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E471A1F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 00:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeK0LgZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 06:36:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65322 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbeK0LgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 06:36:25 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DB971166DE;
        Mon, 26 Nov 2018 19:40:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BeowzAUVBkGbV4zMMW+0RVlD6o0=; b=MHuk5C
        kXzJNy9VZbeLOusqTHNKIdz4XmdrMh+7H3L63tPvHD1Nur6lysIP6Y3ePi2WYY3v
        j2VCsKtBG4SdknP40ffKOAk4Ns+b1ZHaQRO57kgHIChfQxVnYabXZ1NZ5LJIvyNo
        wOak9ogvJLmSMuTYtN35fZSd/SgHwa+sy7RSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XqkpWQJw+s01BbXoO7VcwAvNiy8pUp8m
        l8Z/GGlK3Lk8Z6mPCkEfJ+TMobRYyQbfXU4vUh/giV9o3pA9bszF6+5RG9FORSoE
        aeAgVuj9ojtllCIPENr9b/alHTwku5J4W08lNxob7cVh+PQtbMRww5rHJQo7cFzi
        uqwr1ErjAmY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 76E6D1166DC;
        Mon, 26 Nov 2018 19:40:24 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E76BA1166DB;
        Mon, 26 Nov 2018 19:40:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [ANNOUNCE] Git v2.20.0-rc1
References: <xmqqmuq25ufc.fsf@gitster-ct.c.googlers.com>
        <xmqqd0qswau1.fsf@gitster-ct.c.googlers.com>
        <CABPp-BFY-BmfgphwJ6UrGL0+kS3soa_fM9ayMwPZXQ2zNULRyQ@mail.gmail.com>
Date:   Tue, 27 Nov 2018 09:40:22 +0900
In-Reply-To: <CABPp-BFY-BmfgphwJ6UrGL0+kS3soa_fM9ayMwPZXQ2zNULRyQ@mail.gmail.com>
        (Elijah Newren's message of "Mon, 26 Nov 2018 07:41:28 -0800")
Message-ID: <xmqqftvnuzd5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06D6F65E-F1DD-11E8-9304-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> If we don't set rebase.useBuiltin to false, then there is also a minor
> regression in the error message printed by the built-in rebase we may
> want to try to address.  I have a patch for it at
> <20181122044841.20993-2-newren@gmail.com>, but I don't know if that
> patch is acceptable as-is this close to a release since that'd not
> give translators much time to update.

For this particular one, I'd rather ship "rebase in C" with known
message glitch, with or without the "mark it experimental and make
it opt-in" last-time change.  Of course, turning it off by default
would let us worry about these message glitches even less, but at
this point, I'd be worried more about bugs that can affect the
actual operation and outcome recorded in the resulting history.
