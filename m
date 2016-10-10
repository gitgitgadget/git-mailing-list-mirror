Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9AB520989
	for <e@80x24.org>; Mon, 10 Oct 2016 23:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbcJJXIT (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 19:08:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62886 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752289AbcJJXIS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 19:08:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A6E0544A65;
        Mon, 10 Oct 2016 19:08:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y4h7sBvdksSOKWrGrlVFYcKYHtc=; b=Vie7dT
        X3x9sfE7F8qM2mxtXOjF6Ioxo1S/BBm0QG/ECWtIJMmqAxCKavVb6pU8JLc+d7Se
        nNVVXlnDy7By080DB6LlvtGkUQXp4vMBmukZDlfgW9LDOtvZewoKm/erJoE0a1dM
        6/vfpprht7pd4b8/0F/Wnjf5y7s8eP2MF0QR8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZbhXibnGlK71nI15EEUIfzaIV82Xw92H
        FHZNe2vY99FNV1Mv5mwko/ep53k24XI+6zPMkxT2OH/hQK2Qhml2FhdPOfcyCw5x
        iihtldfvGxuiY92RQQL0bXbslj+vcizRF4RycH0jpwU0ujxS+FL8ekF7OCZhgbnE
        M71UmiVuG3k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9FE7344A64;
        Mon, 10 Oct 2016 19:08:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1E21A44A63;
        Mon, 10 Oct 2016 19:08:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] Resurrect "diff-lib.c: adjust position of i-t-a entries in diff"
References: <20160928114348.1470-1-pclouds@gmail.com>
        <20160928114348.1470-2-pclouds@gmail.com>
        <xmqqzimrj03j.fsf@gitster.mtv.corp.google.com>
        <CACsJy8D28iq3r3O_uzjyyJT--KQunAySRgUthF3FMrb1VM6XKw@mail.gmail.com>
        <xmqqd1jgw0nx.fsf@gitster.mtv.corp.google.com>
        <CACsJy8D7c8Z_ugasn_scf391+C6GxJp1CYwHY4ndvVtLiJzxnQ@mail.gmail.com>
        <xmqqwphljnlj.fsf@gitster.mtv.corp.google.com>
        <CACsJy8DiGoaKZZ1je=3L3y4odVHB7wLvvKs9pccjiN=-UeqeVw@mail.gmail.com>
Date:   Mon, 10 Oct 2016 16:08:14 -0700
In-Reply-To: <CACsJy8DiGoaKZZ1je=3L3y4odVHB7wLvvKs9pccjiN=-UeqeVw@mail.gmail.com>
        (Duy Nguyen's message of "Fri, 7 Oct 2016 19:56:47 +0700")
Message-ID: <xmqqh98jby5d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6DA0C2C4-8F3E-11E6-8F13-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Off topic. This reminds me of an old patch about apply and ita [1] but
> that one is not the same here

... Yeah, and re-reading that one, I think that sort-of makes
sense.  I am hesitant to take it out of context, though.  I wonder
how it would interact with that broken mode of "git apply" where it
can take patches to the same path number of times...

> [1] https://public-inbox.org/git/1451181092-26054-4-git-send-email-pclouds@gmail.com/

>> ita entry in the index for symmetry, wouldn't it?  That by itself
>> can be seen as an improvement (we no longer would have to say that
>> "git apply patchfile && git commit -a" that is run in a clean state
>> will forget new files the patchfile creates), but it also means ...

Another downside is that "git reset --hard" after "git apply" will
suddenly start removing them.  Perhaps that can be seen a feature?
I dunno.

