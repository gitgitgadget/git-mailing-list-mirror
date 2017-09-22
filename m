Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4357202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 01:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbdIVA7f (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 20:59:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64510 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751781AbdIVA7e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 20:59:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 97473A5708;
        Thu, 21 Sep 2017 20:59:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KxaC6v6juk/HnN/vtZbnSBmZH5o=; b=HbDAGE
        TXJQ/ZPAY2C+UhT3OiFkX7oCVVkFmtVddR6O8efXBPlTKYFSk2hM3eS3zTua8mt6
        8u8+yhz4R15fWu82S9Ow+5AscoEh0xmfH/QyjqoU4AfXV5r426b4ec/XvX6R2sgO
        9sI1e8h90yeumY8iCh5rfO6sbO16AuqNdl9Og=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QUeFxBNhuen6OtHWEfStbZhMHjgYFtFD
        FN15M4/QAXiGg1G9i7ieF1XIGQJHyNe4ch/eGvklA0YKdMN10xmoeU+yy9DCJU7r
        1PewumC8StRLXZ3KUMJl7YF+Bv2CXFRi2rdO4oQfTPXBxJHHLdDUYP/7ayJDqpFg
        iNzniu1V9C0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 80BE7A5707;
        Thu, 21 Sep 2017 20:59:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D0AC6A5706;
        Thu, 21 Sep 2017 20:59:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sahil Dua <sahildua2305@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Sep 2017, #03; Fri, 15)
References: <xmqq8thgy03t.fsf@gitster.mtv.corp.google.com>
        <CALiud+m1PAD8r0ygoUj3g4LzQjdoPu0CmjiejyG8pHOhr3Fk=Q@mail.gmail.com>
Date:   Fri, 22 Sep 2017 09:59:31 +0900
In-Reply-To: <CALiud+m1PAD8r0ygoUj3g4LzQjdoPu0CmjiejyG8pHOhr3Fk=Q@mail.gmail.com>
        (Sahil Dua's message of "Thu, 21 Sep 2017 23:14:54 +0200")
Message-ID: <xmqqpoajmtu4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B99F91C-9F31-11E7-B524-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sahil Dua <sahildua2305@gmail.com> writes:

>>
>> * sd/branch-copy (2017-06-18) 3 commits
>>  - branch: add a --copy (-c) option to go with --move (-m)
>>  - branch: add test for -m renaming multiple config sections
>>  - config: create a function to format section headers
>>
>>  "git branch" learned "-c/-C" to create and switch to a new branch
>>  by copying an existing one.
>>
>>  I personally do not think "branch --copy master backup" while on
>>  "master" that switches to "backup" is a good UI, and I *will* say
>>  "I told you so" when users complain after we merge this down to
>>  'master'.
>
> Junio, what's up with this one? It's been a long time for this being
> cooked in next. Do we have a plan/idea going forward or is it just
> waiting for more feedback?

Thanks for pinging.

I was (in a strange way) hoping that it was just me who felt that a
"copy" operation of the current branch that moves me to a new branch
is a design mistake, and I was planning to start merging this down
to 'next' based on that assumption, but IIRC it turned out that it
wasn't just me.  During the renewed discussion I somehow got an
impression that the concensus was for "copy" to just copy without
ever changing what HEAD says, and if an operation that switches to a
new branch based on the current branch is needed, the right place to
do so is to enhance/extend "checkout -b".

My understanding of the next step was for those who are interested
in moving this topic forward to update these patches in that
direction.


