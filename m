Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 308131F404
	for <e@80x24.org>; Fri, 19 Jan 2018 22:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756610AbeASWZ7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 17:25:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56453 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756567AbeASWZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 17:25:58 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1B55CB7CB;
        Fri, 19 Jan 2018 17:25:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gDv6F6e1X7SKn5xA89L2NqHS+DY=; b=AYH8rs
        2m9f/3jHEcJnV7TTgU6bZUcHr4g7YsOF3omITMJ6xzw+YFr6I8zYwqkT3ByhANiU
        uJm4rg44DSN+zGk5X1RLG5fw28JS2rb4ZMyL0igdtnfFVPhfaJtG6Unp0+BXhSE9
        OOZQiWJ21y79ywtkpXkPDbMqVV3NRjfPgAYZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=L4RF32rs7mmCMIzmr5xLC58fOphlp0NQ
        p3rJhVuNuUU3+bC8OzkLPPh6EWzHv5RU1Nztd8e7EX1dmRbT25veg1Qa+j4/ewFB
        cOyLj5U/rax8lK+2oQ9oFqHbgRRLuAgEtrCV1TfMj0kyzoRuW2RxXGAIiMrrc7ZI
        qp0PNvLkaFo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A7DDFCB7CA;
        Fri, 19 Jan 2018 17:25:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1ECD4CB7C8;
        Fri, 19 Jan 2018 17:25:57 -0500 (EST)
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
        <CAPig+cRX2HpUPCnuf3aiZO71KmFgBR4JE_=NBA3UuwuRxrXR2Q@mail.gmail.com>
Date:   Fri, 19 Jan 2018 14:25:55 -0800
In-Reply-To: <CAPig+cRX2HpUPCnuf3aiZO71KmFgBR4JE_=NBA3UuwuRxrXR2Q@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 19 Jan 2018 16:48:47 -0500")
Message-ID: <xmqqshb1o58s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B82BEF74-FD67-11E7-AAAA-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Jan 19, 2018 at 2:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>> Now that we know (due to Duy's excellent detective work[1]) that the
>>> trigger is files with names differing only in case on case-insensitive
>>> filesystems, the commit message can be updated appropriately.
>>
>> Thanks.  Let me apply the following and do a 2.16.1, hopefully by
>> the end of day or mid tomorrow at the latest.  Test to protect the
>> fix can come as a separate follow-up patch.
>>
>> -- >8 --
>> Subject: [PATCH] repository: pre-initialize hash algo pointer
>> [...]
>> A "git clone" of a project that has two paths that differ only in
>> case suffers from this if it is run on a case insensitive platform.
>> When the command attempts to check out one of these two paths after
>> checking out the other one, the checkout codepath needs to see if
>> the version that is already on the filesystem (which should not
>> happen if the FS were case sensitive), and it needs to exercise the
>> hashing code.
>
> Thanks, the amended commit message makes the reason for the patch more
> concrete. There does seem to be a bit of a grammatical issue, however,
> which makes it difficult to parse. Namely, "already on the filesystem
> (...)" probably was meant to say "already on the filesystem (...) is
> {something}".

Indeed it is incomplete sentence.  The codepath wants to check if
the one on the filesystem is the same as the one that is being
checked out and exercises the hashing code at that point.

Thansk.
