Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB4EC433E7
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 20:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5216A22269
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 20:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DmKQCb5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgJRUL5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 16:11:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59879 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgJRUL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 16:11:56 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C65071C69;
        Sun, 18 Oct 2020 16:11:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uZjNbrX5W0ePefNAaUeSLHJErDM=; b=DmKQCb
        5EsGfoZBT/Dch/3STQcplCHUD3uTO+eMNhhgZKJ4i1GTy8NXCu9wYeMPxCNLypGg
        nt4x3meqwyFBop72t61vBl6rdNWSyjQfdX588zLwitrOPA9hFcFsKUap52fx88Ak
        hq//ObXrnvrL1FXDBVK6SnIf+urTa7oZo1tOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n9Ca1PW6hgeT8qFpf1j4EdB0RrwqjT56
        /jXFCJ1u4RXnc5To4hsl2yMjWuazmq4l8hjAWuNKmJqgx1zJjF1DY/2bqZHCIQ1R
        izB9Iq1GoHD0ATmGKsHAteLmC/H5IFiiLe1cIhu1lNhYX2WY52tsUzg8l3dKcqyr
        s+HTY1zCFZs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E0CD71C68;
        Sun, 18 Oct 2020 16:11:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6AD571C67;
        Sun, 18 Oct 2020 16:11:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Caleb Tillman <caleb.tillman@gmail.com>, git@vger.kernel.org
Subject: Re: [Outreachy-Microproject][PATCH 1/1] t0000: replace an instant
 of test -f with test_path_is_file functions.
References: <20201018005522.217397-1-caleb.tillman@gmail.com>
        <20201018035547.GA2262492@nand.local>
Date:   Sun, 18 Oct 2020 13:11:53 -0700
In-Reply-To: <20201018035547.GA2262492@nand.local> (Taylor Blau's message of
        "Sat, 17 Oct 2020 23:55:47 -0400")
Message-ID: <xmqqk0vn70qe.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A62C248-117E-11EB-98D9-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Hi Caleb,
>
> On Sun, Oct 18, 2020 at 12:55:22AM +0000, Caleb Tillman wrote:
>> The test_path_is* functions provide debug-friendly messages upon failure.
>
> The body looks fine to me. Your subject is getting a little long,
> however. Typical guidance would be somewhere around 50 (at least in my
> opinion, I thought we had something in Documentation/CodingGuidelines,
> but I couldn't find anything).
>
> Maybe something instead like:
>
>   t0000: replace 'test -f' with helpers
>
> or:
>
>   t0000: modernize test style
>
> If you're looking for inspiration, you can use `git log`'s `-S` flag to
> look for anything that mentions 'test_path_is_file' to see how similar
> patches have been written in the past. (When I was recommending
> alternatives, I ran "git log --oneline -Stest_path_is_file -- t").

Thanks for a great educational input.

>> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
>> index 923281af93..eb99892a87 100755
>> --- a/t/t0000-basic.sh
>> +++ b/t/t0000-basic.sh
>> @@ -1191,7 +1191,7 @@ test_expect_success 'writing this tree with --missing-ok' '
>>  test_expect_success 'git read-tree followed by write-tree should be idempotent' '
>>  	rm -f .git/index &&
>>  	git read-tree $tree &&
>> -	test -f .git/index &&
>> +	test_path_is_file .git/index &&
>
> This looks totally correct to me.

By nature of "microproject" exchange, it is almost trivial to get
the patch text right after an exchange.  The problems are typically
so easy that there is only one way to write the code part correctly.

Polishing proposed log message is much harder ;-)

Thanks.
