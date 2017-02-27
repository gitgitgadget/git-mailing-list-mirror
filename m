Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B4411F5FB
	for <e@80x24.org>; Tue, 28 Feb 2017 00:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbdB1Akp (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 19:40:45 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33818 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbdB1Ako (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 19:40:44 -0500
Received: by mail-pg0-f66.google.com with SMTP id s67so2693986pgb.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 16:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VbpTpLlYpKE4/Nxruljq8fTDwK46vB3ta8978tEPP+A=;
        b=vHd55dPblah1KXm8qoFPDA81Hm+PF4qTtlYhq+q3Zmr4mXq3NaRkFrmdImFNkZqgp6
         ZsMMCshNW88vMfrY9wwJmVefp3Qh7BUacr/57pstXbwjgDUnxvwo6bXYPume1F3nPHDb
         z9HilibBKPrOxXgyijBR73g71w3Rp9ju5vougNnF6Pu76B0ucQm4pQhIcfzl55hr4y15
         +CzlfagbOzkpLARgMNtnY+iQ78g5k9hQXPoiR6m9sc9V9xeS2un9AqSZDw1ZWyFxUj17
         5sNSW/F2dK2YKnQSnJZsbt/W1dobRnaHPJXjWvSOA+KcKZoNQYrbhDIMB9IWEq04Szlt
         DkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VbpTpLlYpKE4/Nxruljq8fTDwK46vB3ta8978tEPP+A=;
        b=PFCs5eSYJGgIoBGArsIYk5daSfre9pDJLa5hEnJmAs/Gyc37XD070CUYKCiCRt/dti
         Uxo+tY1+i/QWh5/L4UFF00ZaqUxUCMxBNhDt/KjMoUv8kkO/JL+axusF5I1GjPZhmGKK
         oruDgysWwGzjYV4jzAX7cbUHd443Qo5+QTf7wnj/yOj9UuKat0cUy7oEJMn3feCn8cx/
         CnS4Ar9oShglmNRVuTKj28m2xEOkKjmeV6dQcbO9Kjniiy7fbSPobD6475sLmTZ7VguK
         y4PQikkaXlD9z+9ZLDGDK85X4OfvRenjUejYRd+tcpTETp4sC0G1h5+XR8bbN9mwE+D3
         kqTw==
X-Gm-Message-State: AMke39kI3LZI2AyHgyrZAAnmW2/FfgccqDbxA5O9kTfv16A6OBQJViYXl0nhfOYXDHfmaQ==
X-Received: by 10.84.174.4 with SMTP id q4mr27017105plb.35.1488226644022;
        Mon, 27 Feb 2017 12:17:24 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:c953:ec42:862e:1e81])
        by smtp.gmail.com with ESMTPSA id s3sm32399898pgn.55.2017.02.27.12.17.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 12:17:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org, Mike Crowe <mac@mcrowe.com>
Subject: Re: git diff --quiet exits with 1 on clean tree with CRLF conversions
References: <20170217212633.GA24937@mcrowe.com>
        <xmqqr32wqxr6.fsf@gitster.mtv.corp.google.com>
        <20170217221958.GA12163@mcrowe.com> <20170220153322.GA8352@mcrowe.com>
        <xmqqlgt0imhe.fsf@gitster.mtv.corp.google.com>
        <20170225153230.GA30565@mcrowe.com>
Date:   Mon, 27 Feb 2017 12:17:22 -0800
In-Reply-To: <20170225153230.GA30565@mcrowe.com> (Mike Crowe's message of
        "Sat, 25 Feb 2017 15:32:30 +0000")
Message-ID: <xmqqefyjwfql.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten, you've been quite active in fixing various glitches around
the EOL conversion in the latter half of last year.  Have any
thoughts to share on this topic?

Thanks.

Mike Crowe <mac@mcrowe.com> writes:

> On Monday 20 February 2017 at 13:25:01 -0800, Junio C Hamano wrote:
>> This almost makes me suspect that the place that checks lengths of
>> one and two in order to refrain from running more expensive content
>> comparison you found earlier need to ask would_convert_to_git()
>> before taking the short-cut, something along the lines of this (for
>> illustration purposes only, not even compile-tested).  The "almost"
>> comes to me because I do not offhand know the performance implications
>> of making calls to would_convert_to_git() here.
>> 
>>  diff.c | 18 ++++++++++++++----
>>  1 file changed, 14 insertions(+), 4 deletions(-)
>> 
>> diff --git a/diff.c b/diff.c
>> index 051761be40..094d5913da 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -4921,9 +4921,10 @@ static int diff_filespec_check_stat_unmatch(struct diff_filepair *p)
>>  	 *    differences.
>>  	 *
>>  	 * 2. At this point, the file is known to be modified,
>> -	 *    with the same mode and size, and the object
>> -	 *    name of one side is unknown.  Need to inspect
>> -	 *    the identical contents.
>> +	 *    with the same mode and size, the object
>> +	 *    name of one side is unknown, or size comparison
>> +	 *    cannot be depended upon.  Need to inspect the 
>> +	 *    contents.
>>  	 */
>>  	if (!DIFF_FILE_VALID(p->one) || /* (1) */
>>  	    !DIFF_FILE_VALID(p->two) ||
>> @@ -4931,7 +4932,16 @@ static int diff_filespec_check_stat_unmatch(struct diff_filepair *p)
>>  	    (p->one->mode != p->two->mode) ||
>>  	    diff_populate_filespec(p->one, CHECK_SIZE_ONLY) ||
>>  	    diff_populate_filespec(p->two, CHECK_SIZE_ONLY) ||
>> -	    (p->one->size != p->two->size) ||
>> +
>> +	    /* 
>> +	     * only if eol and other conversions are not involved,
>> +	     * we can say that two contents of different sizes
>> +	     * cannot be the same without checking their contents.
>> +	     */
>> +	    (!would_convert_to_git(p->one->path) &&
>> +	     !would_convert_to_git(p->two->path) &&
>> +	     (p->one->size != p->two->size)) ||
>> +
>>  	    !diff_filespec_is_identical(p->one, p->two)) /* (2) */
>>  		p->skip_stat_unmatch_result = 1;
>>  	return p->skip_stat_unmatch_result;
>> 
>> 
>
> Thanks for investigating this. I think you are correct that I was misguided
> in my previous "fix". However, your change above does fix the problem for
> me.
>
> It looks like the main cost of convert_to_git is in convert_attrs which
> ends up doing various path operations in attr.c. After that, both
> apply_filter and crlf_to_git return straight away if there's nothing to do.
>
> I experimented several times with running "git diff -quiet" after touching
> every file in Git's own worktree and any difference in total time was lost
> in the noise.
>
> I've further improved my test case. Tests 3 and 4 fail without the above
> change but pass with it. Unfortunately I'm still unable to get those tests
> to fail without the above fix unless the sleeps are present. I've tried
> using the "touch -r .datetime" technique from racy-git.txt but it doesn't
> help. It seems that I'm unable to stop Git from using its cache without
> sleeping. :(
>
> diff --git a/t/t4063-diff-converted.sh b/t/t4063-diff-converted.sh
> new file mode 100755
> index 0000000..31a730d
> --- /dev/null
> +++ b/t/t4063-diff-converted.sh
> @@ -0,0 +1,44 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2017 Mike Crowe
> +#
> +# These tests ensure that files changing line endings in the presence
> +# of .gitattributes to indicate that line endings should be ignored
> +# don't cause 'git diff' or 'git diff --quiet' to think that they have
> +# been changed.
> +#
> +# The sleeps are necessary to reproduce the problem for reasons that I
> +# don't understand.
> +
> +test_description='git diff with files that require CRLF conversion'
> +
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +	echo "* text=auto" > .gitattributes &&
> +	printf "Hello\r\nWorld\r\n" > crlf.txt &&
> +	printf "Hello\nWorld\n" > lf.txt &&
> +	git add .gitattributes crlf.txt lf.txt &&
> +	git commit -m "initial" && echo three
> +'
> +test_expect_success 'noisy diff works on file that requires CRLF conversion' '
> +	git status >/dev/null &&
> +	git diff >/dev/null &&
> +	sleep 1 &&
> +	touch crlf.txt lf.txt &&
> +	git diff >/dev/null
> +'
> +test_expect_success 'quiet diff works on file that requires CRLF conversion with no changes' '
> +	git status &&
> +	git diff --quiet &&
> +	sleep 1 &&
> +	touch crlf.txt lf.txt &&
> +	git diff --quiet
> +'
> +
> +test_expect_success 'quiet diff works on file with line-ending change that has no effect on repository' '
> +	printf "Hello\nWorld\n" > crlf.txt &&
> +	printf "Hello\r\nWorld\r\n" > lf.txt &&
> +	git diff --quiet
> +'
> +test_done
>
>
> Mike.
