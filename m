Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E4851F576
	for <e@80x24.org>; Sat, 20 Jan 2018 07:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751061AbeATHBk (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 02:01:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57526 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeATHBi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 02:01:38 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 51BDAC5CCF;
        Sat, 20 Jan 2018 02:01:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HNZynII9v139pv0jnAG67VyczJQ=; b=c+jRvj
        dv3a5ELxgWNMmdAKJn9NfsvgpzIVCIEO+fL2rgFfTsXnWYC3Wyqmo3d4++sKDdP1
        LC1Q5I0H6bjtKRVMxyin/NW6LbsAB8R3MEdD3kZ+3+oFmgK1x+4FVxKJ6wundRSy
        VXJ8KB8Y/+bIAzstmR33+JSJwGVfQ976ck0MM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v1HkCF/KxbKJJ6Idia9r0YxNOv4061f4
        nnV/mIoF3KWBL9Rs1fDtI3J1jQ6yC+MxB0MWI7L7kMV9+oTDJ+K+IXFMnVbaBDU9
        axfcRuQuFM7z2wCuIqJYnfUNcnCeG4HGJTb9HswI9MBESPEJc7CwS4rh/4dKjiWD
        Udwr/MIJU/M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 41811C5CCE;
        Sat, 20 Jan 2018 02:01:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A6EF2C5CCD;
        Sat, 20 Jan 2018 02:01:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
        <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw?=
         =?utf-8?B?0LXQsg==?= <aleks.bulaev@gmail.com>
Subject: Re: [PATCH] repository: pre-initialize hash algo pointer
References: <CAPig+cSbbzKV0GttLjHCyY3CNcJO0bdP3Mp4pT+3waUTMAQ8kg@mail.gmail.com>
        <20180119041825.727904-1-sandals@crustytoothpaste.net>
        <CAPig+cTOw5NsSmLHYcBEidDzNyiidJ0Dw1dF227KWDL9JrASvw@mail.gmail.com>
        <xmqqr2qlps7r.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 19 Jan 2018 23:01:36 -0800
In-Reply-To: <xmqqr2qlps7r.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 19 Jan 2018 11:24:24 -0800")
Message-ID: <xmqqo9lpnhdb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C22E4538-FDAF-11E7-8E88-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>> I'm still quite mystified as to why this is working on Linux and not
>>> macOS, but I can only guess that compilers are just very advanced and
>>> have somehow concluded that we would clearly never dereference a NULL
>>> pointer, so they picked the only non-NULL value.
>>
>> Now that we know (due to Duy's excellent detective work[1]) that the
>> trigger is files with names differing only in case on case-insensitive
>> filesystems, the commit message can be updated appropriately.
>
> Thanks.  Let me apply the following and do a 2.16.1, hopefully by
> the end of day or mid tomorrow at the latest.  Test to protect the
> fix can come as a separate follow-up patch.

I actually changed my mind and decided not to rush 2.16.1 with just
this change.  After all, even though it is better not to crash in
such a problematic case, a "successful" clone of such a project on
such a filesystem cannot be sanely used *anyway*, so in that sense
the "fix" would stop "clone" from segfaulting but the resulting
repository would still be "wrong" (e.g. "git status" immediately
after clone would likely to say that the working tree is already
dirty and missing one of the two paths, or something silly like
that).

