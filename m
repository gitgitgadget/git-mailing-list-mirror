Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E7E1207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 02:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S979933AbdDYCTZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 22:19:25 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34386 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S979877AbdDYCTX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 22:19:23 -0400
Received: by mail-it0-f65.google.com with SMTP id c26so12047690itd.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 19:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=x4hbV8yxJ8WC3V6qjQ/PprQlKU0hecNilMe0/odyPIs=;
        b=UTbcX+hHBz1Yaso9QmNCeLk2njnYEoUjpSP2K9F7QCA3nw97mwGu/YO2pUARKNhxEr
         2KGa3LwK9kUPC14smkmznaaaQTKg0mSqb7jzvA8qF7qwbr5ruZ4jfbjBFHPovmg3Zd7I
         18rNv8T7+Rq6zZsNEZ/f310Gv1AYr/m6L5JOLl6VRKjNOA9WzAaFjOCuFF9pWk9kLWVe
         Gh6u3cnCK75i9k+Kxqpq6oGIpRkmL/iTa0V5OBrYN8BDxy+1PansSJtqhiaecEn6Ay2U
         lCzqDH3m0/3Q81LsAEp5tBfhLzTMISUvRg2G0rNEW6KziqBngf6AtRgAQBfiwmFIy4Ey
         e1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=x4hbV8yxJ8WC3V6qjQ/PprQlKU0hecNilMe0/odyPIs=;
        b=Mf//3Pi7ysSiuGR2MsDqIIkKwjSlsXeN6X7jA4j0idGiWqhhSYWHGgiSHM25RZpDtE
         8DpjPdOdoytor7Cj68ucq3VH050cKUTX/oeTsWa2nqK5vrtgSWtbHlveeg0DJQzFwdi5
         9c3YQwz0mLzC+FLbeitDNiQvM/QwPgMLn9n4ykER+6gYEz0WOIwIdf2bR90ktfsbW2uK
         3zeU9QP1gc9/AnUIBMpYhRgEpCRBGidBxHyC6wYz9Xwtjk/0ueekmEsTvTtbgp92pY41
         gKOLIQgSNGfuDlOfQyqhYw3s7fCQe8WW42UXYu4yZ5HATJezPQbbtwPsv4RiCQT2Gu85
         BaRw==
X-Gm-Message-State: AN3rC/7ERGTqe/AVxaAB7Rkmccqf2Tbc5IKeEQWQ1bZtwnkhM6NI6L+a
        tSzZG5/FfMlGEQ==
X-Received: by 10.36.81.8 with SMTP id s8mr1277579ita.96.1493086762692;
        Mon, 24 Apr 2017 19:19:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:894:a17f:b6e3:25e8])
        by smtp.gmail.com with ESMTPSA id v23sm8856564ioi.61.2017.04.24.19.19.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 19:19:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: Re: [PATCH v6 1/8] pkt-line: add packet_read_line_gently()
References: <20170421172611.12152-1-benpeart@microsoft.com>
        <20170421172611.12152-2-benpeart@microsoft.com>
        <xmqqy3uqzb90.fsf@gitster.mtv.corp.google.com>
        <d6e8a63b-e95d-4194-5ad0-d68f557be083@gmail.com>
Date:   Mon, 24 Apr 2017 19:19:21 -0700
In-Reply-To: <d6e8a63b-e95d-4194-5ad0-d68f557be083@gmail.com> (Ben Peart's
        message of "Mon, 24 Apr 2017 16:33:27 -0400")
Message-ID: <xmqqbmrlxm8m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> On 4/24/2017 12:21 AM, Junio C Hamano wrote:
>> Ben Peart <peartben@gmail.com> writes:
>>
>>> Add packet_read_line_gently() to enable reading a line without dying on
>>> EOF.
>>>
>>> Signed-off-by: Ben Peart <benpeart@microsoft.com>
>>> ---
>>>   pkt-line.c | 14 +++++++++++++-
>>>   pkt-line.h | 10 ++++++++++
>>>   2 files changed, 23 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/pkt-line.c b/pkt-line.c
>>> index d4b6bfe076..bfdb177b34 100644
>>> --- a/pkt-line.c
>>> +++ b/pkt-line.c
>>> @@ -315,7 +315,7 @@ static char *packet_read_line_generic(int fd,
>>>   			      PACKET_READ_CHOMP_NEWLINE);
>>>   	if (dst_len)
>>>   		*dst_len = len;
>>> -	return len ? packet_buffer : NULL;
>>> +	return (len > 0) ? packet_buffer : NULL;
>>>   }
>> The log does not seem to explain what this change is about.
>
> This change was made as the result of a request in feedback from the
> previous version of the patch series which pointed out that the call
> to packet_read can return -1 in some error cases and to keep the code
> more consistent with packet_read_line_gently below.
>
> If len < 0 then the old code would have incorrectly returned a pointer
> to a buffer with garbage while the new code correctly returns NULL
> (fixes potential bug)
> if len == 0 then the code will return NULL before and after this
> change (no change in behavior)
> if len > 0 then the code will return packet_buffer before and after
> this change (no change in behavior)

TL;DR "Yes this is a preliminary fix and I'll split out into a
separate patch early in the series in the next reroll"?  Thanks.

>> Is this supposed to be a preliminary bugfix where this helper used
>> to return a non-NULL buffer when underlying packet_read() signaled
>> an error by returning a negative len?  If so, this should probably
>> be a separate patch early in the series.
>>
>> Should len==0 be considered an error?  Especially given that
>> PACKET_READ_CHOMP_NEWLINE is in use, I would expect that len==0
>> should be treated similarly to positive length, i.e. the otherside
>> gave us an empty line.
>>
>>> +{
>>> +	int len = packet_read(fd, NULL, NULL,
>>> +			      packet_buffer, sizeof(packet_buffer),
>>> +			      PACKET_READ_CHOMP_NEWLINE|PACKET_READ_GENTLE_ON_EOF);
>>> +	if (dst_len)
>>> +		*dst_len = len;
>>> +	if (dst_line)
>>> +		*dst_line = (len > 0) ? packet_buffer : NULL;
>> I have the same doubt as above for len == 0 case.
>
> packet_read() returns -1 when PACKET_READ_GENTLE_ON_EOF is passed and
> it hits truncated output from the remote process. 

I know, but that is irrelevant to my question, which is about
CHOMP_NEWLINE.  I didn't even ask "why a negative len treated
specially?"  My question is about the case where len == 0.  Your
patch treats len==0 just like len==-1, i.e. an error, but I do not
know if that is correct, hence my question.  We both know len < 0
is an error and you do not need to waste time elaborating on it.


