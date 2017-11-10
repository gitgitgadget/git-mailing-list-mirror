Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 320BA201C8
	for <e@80x24.org>; Fri, 10 Nov 2017 01:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755572AbdKJBYU (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 20:24:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54993 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755255AbdKJBYS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 20:24:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 73C41B7AF1;
        Thu,  9 Nov 2017 20:24:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4YwjTDk98xPEvuRefIbrZ3Rz5xo=; b=aiKGBL
        mZHn61s1NLU0+O7TH1IjjSQ3IvcKwfe6xM1NoN2kr93eMgfUHtlHcDiQ+MX/tDN9
        Q7zFTQ7fIJ82Z2SgYTv45k1sIkaxI8lV9HMfk8V4dukmCUsTrT1KBQOx9gqSktnh
        li2XVeMoeWwgbMro1u3MOzKlkkxNVSwC/tkRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q+YJ/Sto5NZWdw+Sd5Gv94fOzHXbGH26
        lTdlje/un1wJKaC2iUES67fEa2U58WRPQyJm/ngWT96Kolatet1Z2mEq/zzsPbWL
        V3uoU2LKx8x4URATM+cNMJRSMSESxj58DMFXlSvJLgfQoF1ABIo4MqtQ7TQA9qCn
        QW73CfxQ7pY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5CCBAB7AF0;
        Thu,  9 Nov 2017 20:24:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AFE55B7AEF;
        Thu,  9 Nov 2017 20:24:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Stefan Beller" <sbeller@google.com>, "git" <git@vger.kernel.org>,
        "Kevin Daudt" <me@ikke.info>,
        "Jacob Keller" <jacob.keller@gmail.com>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] builtin/describe.c: describe a blob
References: <20171028004419.10139-1-sbeller@google.com>
        <20171031003351.22341-1-sbeller@google.com>
        <20171031003351.22341-7-sbeller@google.com>
        <xmqqinevzvel.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYO=4SWzfKY6bU8Spn5Ubw39ghOH6wanFhFEsKD8q9vrA@mail.gmail.com>
        <xmqq4lqewu2b.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYC4=rDSWC7WCGVL4n4OC8BpvMJFwxx+LV9GqoGnSHFSA@mail.gmail.com>
        <xmqqinetsayr.fsf@gitster.mtv.corp.google.com>
        <xmqq375xs3zr.fsf@gitster.mtv.corp.google.com>
        <BFE987312194406AAAEA8DAC7EC5BFF5@PhilipOakley>
        <xmqqlgjlkzmm.fsf@gitster.mtv.corp.google.com>
        <D199FB1260C4462ABFC1F0F77D26EF06@PhilipOakley>
        <CAGZ79kYRunzS9vDO=Zk1jQk1BvwJomN5+=1gQi0aDau_qbamew@mail.gmail.com>
        <54073F7B0C9E49C4BA55CA97A605A724@PhilipOakley>
Date:   Fri, 10 Nov 2017 10:24:15 +0900
In-Reply-To: <54073F7B0C9E49C4BA55CA97A605A724@PhilipOakley> (Philip Oakley's
        message of "Fri, 10 Nov 2017 00:25:27 -0000")
Message-ID: <xmqqo9obhqo0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE4BD438-C5B5-11E7-AEC2-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Stefan Beller" <sbeller@google.com>
>> Rereading this discussion, there is currently no urgent thing to address?
>
> True.
>
>> Then the state as announced by the last cooking email, to just cook
>> it, seems
>> about right and we'll wait for further feedback.

A shiny new toy that is not a fix for a grave bug is rarely urgent,
so with that criterion, we'd end up with hundreds of topics not in
'next' but in 'pu' waiting for the original contributor to get out
of his or her procrastination, which certainly is not what I want to
see, as I'd have to throw them into the Stalled bin and then
eventually discard them, while having to worry about possible
mismerges with remaining good topics caused by these topics
appearing and disappearing from 'pu'.

I'd rather see any topic that consumed reviewers' time to be
polished enough to get into 'next' while we all recall the issues
raised during previous reviews.  I consider the process to further
incrementally polish it after that happens a true "cooking".

For this topic, aside from "known issues" that we decided to punt
for now, my impression was that the code is in good enough shape,
and we need a bit of documentation polishes before I can mark it
as "Will merge to 'next'".

> Possibly only checking the documenation aspects, so folks don't fall
> into the same trap as me.. ;-)

Yup, so let's resolve that documentation thing while we remember
that the topic has that issue, and what part of the documentation
we find needs improvement.

I am not sure what "trap: you fell into, though.  Are you saying
that giving

	git describe [<option to describe a commit>...] <commit-ish>
	git describe [<option to describe a blob>...] <blob>

in the synopsis is not helpful, because the user may not know what
kind of object s/he has, and cannot decide from which set of options
to pick?  Then an alternative would be to list

	git describe [<option>...] <object>

in the synopsis, say upfront that most options are applicable only
when describing a commit-ish, and when describing a blob, we do
quite different thing and a separate set of options apply, perhaps?


