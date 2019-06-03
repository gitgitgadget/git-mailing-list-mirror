Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 239521F462
	for <e@80x24.org>; Mon,  3 Jun 2019 18:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfFCSB1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 14:01:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54751 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFCSB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 14:01:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E14BC6B800;
        Mon,  3 Jun 2019 14:01:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l5aJ454AkEkh/zF5tomjHEdPN/U=; b=ZM+REz
        5NKfzEL3aXrA4pR6p1OULEH2+Og1SWAku3fxQaTAfrstBWTI7+94WCVdSwjVVmF1
        kSZ2Kfft7exxZVInBn38VnY+nmH/qWi0xOwgJFrlKR5HqWqVQEMmwQMUn3cSyV6I
        D9UV0yFhANAdBRlNb9gOPvizz8jxReNQi06d8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=myeMrJqNenGcSSZspyasnpKYLGZgeQ10
        dfhDYEuLfy02QV8/wupZbpkkT+Br96TU8miU1cAtbLcvtAbrjy7HLebzMuTChiDB
        1ryhPxyZmbwnlJVT8tk/C7wErTKt3St7BcczquQUzbmEEBXR24Aol/qSLNu3vQOM
        yjfMklkXc7Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C43396B7FF;
        Mon,  3 Jun 2019 14:01:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EA43F6B7FC;
        Mon,  3 Jun 2019 14:01:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@talktalk.net>
Cc:     "Dr. Adam Nielsen" <admin@in-ici.net>, git@vger.kernel.org
Subject: Re: [PATCH] make slash-rules more readable
References: <20190531074426.6810-1-admin@in-ici.net>
        <xmqqh89awprl.fsf@gitster-ct.c.googlers.com>
        <979f6497-5e26-4a93-c345-f61b31c736c6@talktalk.net>
Date:   Mon, 03 Jun 2019 11:01:19 -0700
In-Reply-To: <979f6497-5e26-4a93-c345-f61b31c736c6@talktalk.net> (Philip
        Oakley's message of "Sat, 1 Jun 2019 10:33:33 +0100")
Message-ID: <xmqqsgsqv98w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98602146-8629-11E9-A5CA-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@talktalk.net> writes:

> From a user perspective, implementation issues shouldn't be part of
> the description unless absolutely essential.
> Most user aren't aware of the implementation so don't grok/understand
> what the fuss is about and ignore it...

Oh, absolutely.  But unfortunately I do not see what that principle
has anything to do with the comments you made in your message.

>> Specifically, if you took my suggestion in an earlier review to
>> explicitly say that leading slash is merely a workaround for a
>> string without slash to anchor the pattern to the directory and
>> it should be treated as if it does not exist otherwise, then ...

Perhaps you thought "workaround" refers to some implementation
glitch?  That is not what the word means in that sentence.  It is a
technique to work around "you need a slash somewhere in the pattern
to anchor it to a specific directory" that is a very user visible
design.  The user absolutely need to be aware of it, if s/he wants
to anchor a pattern that does not have a slash (e.g. "I need a
pattern to name/match the README file at this level but not in any
of the subdirectories"), and an extra leading slash is a way to mark
such a pattern that otherwise does not have a slash as anchored.

The fact that the leading slash is such a syntactic marking of a
pattern *and* is not a part of the pattern itself, would not help
you understand the implementation, but you need to know it in order
to use that feature effectively.

>>> + - The pattern `doc/frotz` and `/doc/frotz` have the same effect
>>> +   in any `.gitignore` file. Both pattern contain a non-trailing
>>> +   slash and thus match relative to the location of the
>>> +   `.gitignore` file.
>> ... this paragraph wouldn't have been necessary.
> ...leading to that user mistake having to be explained in numerous Q&A
> threads - Why can't we an explicit explanation of this common user
> mistake?
> Arguably the issue is the special trailing slash rule getting
> users confused..

What common user mistake?  The above is about leading slash rule, by
the way, so perhaps you are getting confused?
