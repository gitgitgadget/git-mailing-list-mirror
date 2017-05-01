Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D6321F78F
	for <e@80x24.org>; Mon,  1 May 2017 22:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750911AbdEAWgJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 18:36:09 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36302 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbdEAWgI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 18:36:08 -0400
Received: by mail-pg0-f44.google.com with SMTP id t7so50838170pgt.3
        for <git@vger.kernel.org>; Mon, 01 May 2017 15:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=f3y23krV3HwXGLGv+EwuJAGEsBh+e2KtI4SOJDiC6HQ=;
        b=h6QzjJIstHbQlrOVyEbaH3JaQdcplAfKLxteIG2BgTU2pqAy2r7+wwtDGkrrXydZjL
         4fJOyP/hEKgwftg1lv4KtexjQsU9eEH7YQtNlIns/Kly//HmQ22PAWOLA+ptPs2o+e/f
         m0P3vuUkpdNMDDo9U7Z1Zl0XtB6VgAghoTSisVxW4EFdjinrpYCC1R6KPlJBsribX9xm
         AJldi+5dzyMEHxk6vmIRkjjlALNB7xQ04DlqBh+nv9XPjHTdoAZufG+AXolLsKQAL+z1
         deAHaSem8gj7UkkpWEe8aEn7rCXaEhIwxfg5Yds7kNbRsdA4h5S3PWde93jyLx9u8wmY
         FFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=f3y23krV3HwXGLGv+EwuJAGEsBh+e2KtI4SOJDiC6HQ=;
        b=j64Wh/YmG8yHB4WtFdaSlCvlKW2telIChZkkfpM1Hv3k39z7YhYRFdG2OjvzolQZjY
         c2DXDF2b8DGc/XsHZ7R5hXsM6tqpXwG6TYNliWAQMq5fTW8+N5bYbN2EE6XRGyNrzxb5
         qS59vKpBGJ/PUWjO2zK101Uk4daVnxR67B5L/PY81L7c9hoazTS/7gaHNzcyaU+RzN3Y
         qzIPd3ILtJWNqX4wviv/14VHhq19tp1v1R/mwqQO2chqGZS2sPk0VQ1wzUgSXo8o5pRP
         4JNbbKwsBLafR+UGb8JtntltS9hoaQEWV3Mv6wy7tLRJvzIYvKnQ6J/Hv8zezDnFuze4
         BySA==
X-Gm-Message-State: AN3rC/5uPXrXFtDGO01rCvt9Ri+30CMkeirVu8FHSMpZt8bwfjI3GLZc
        aQcIjn7DyyOT3j7H
X-Received: by 10.84.174.197 with SMTP id r63mr36934827plb.67.1493678167643;
        Mon, 01 May 2017 15:36:07 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:a910:d570:c34e:20d9])
        by smtp.gmail.com with ESMTPSA id s10sm25973839pfe.28.2017.05.01.15.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 May 2017 15:36:06 -0700 (PDT)
Subject: Re: [PATCH v2 11/53] fast-import: convert to struct object_id
To:     Jeff King <peff@peff.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
 <20170501022946.258735-12-sandals@crustytoothpaste.net>
 <165f4108-267b-f522-d78d-36b0064ee48c@google.com>
 <20170501222758.fzhrwg4w3p3ayxhg@sigill.intra.peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <cc8ea2df-0679-cd52-a1be-cc49de4362bd@google.com>
Date:   Mon, 1 May 2017 15:36:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170501222758.fzhrwg4w3p3ayxhg@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/01/2017 03:27 PM, Jeff King wrote:
> On Mon, May 01, 2017 at 03:07:22PM -0700, Jonathan Tan wrote:
>
>>> @@ -2298,8 +2296,12 @@ static uintmax_t do_change_note_fanout(
>>>  static uintmax_t change_note_fanout(struct tree_entry *root,
>>>  		unsigned char fanout)
>>>  {
>>> -	char hex_sha1[40], path[60];
>>> -	return do_change_note_fanout(root, root, hex_sha1, 0, path, 0, fanout);
>>> +	/*
>>> +	 * The size of path is due to one slash between every two hex digits,
>>> +	 * plus the terminating NUL.
>>> +	 */
>>> +	char hex_oid[GIT_MAX_HEXSZ], path[GIT_MAX_HEXSZ * 3 / 2];
>>
>> If your comment is correct, shouldn't the size of path be 61 (that is, add
>> "+ 1")? I took a look at do_change_note_fanout() and your comment seems
>> correct.
>
> If you have 40 hex digits, then you have 20 hex pairs. But delimiting
> them all takes only 19 slashes, since they only go in between pairs[1].
>
> So the fully expanded formula is:
>
>   GIT_MAX_HEXSZ +               (1) actual hex bytes
>   (GIT_MAX_HEXSZ / 2) - 1 +     (2) internal slashes between pairs
>   1                             (3) NUL terminator

Ah...yes, you're right. (And I checked that do_change_note_fanout() does 
place the slashes only between characters, not before or after them.)

>
> which simplifies to 3/2 GIT_MAX_HEXSZ. It may be better to write it out
> (the compiler can simplify) or explain that in the comment, though. It
> took me a minute to figure out that it was correct, too.
>
> -Peff
>
> [1] This is sort of a reverse-fencepost error:
>     https://en.wikipedia.org/wiki/Off-by-one_error#Fencepost_error
>
