Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DAD5201A4
	for <e@80x24.org>; Mon, 15 May 2017 02:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755864AbdEOCMH (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 22:12:07 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36095 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbdEOCMG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 22:12:06 -0400
Received: by mail-pf0-f196.google.com with SMTP id n23so12813129pfb.3
        for <git@vger.kernel.org>; Sun, 14 May 2017 19:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tU/il+Kl+K3NDTPDaVqKGxbB0j3deo+qxhh2KWjo5Nc=;
        b=df3T1hQ6vnaxIZtYvCY9p/lxNTWdZW7c04UV0Ef0BNtffdkFi0vS5ibKFmPqOHz5JQ
         ivd3F0C/leijOMGjNPP1llDPN83QGVYlQQ/ic5ddhCdBZtwLz2FDvyNdr9WItI1N1BlV
         Mli3QdbBWVIqon68JPSwvCeNK5ckkD2rdQsTpk0VuBHOYs3TpET/SENYSsJncriw/YHq
         N6S6KYsP2SFLKgFGEFnwJttlkJnNDq6a0Ul+t5gnCgLV/uUw7aoyNN+KXnO53HM0H2QD
         ws+/XVErvdS08OcB8EUQXL0ezPJK4p/QtXuIDDU74ef5AQrBlYzPJbTc6Tuat6AABtBh
         N8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tU/il+Kl+K3NDTPDaVqKGxbB0j3deo+qxhh2KWjo5Nc=;
        b=dYnLe83uAEk2cP2x9jMnpR2Sxq1TYdLFQmZfkTHf6HlA8HSqlu3qV5NzRp05HaYEj5
         1jgO5pwcmh/pgY1ncP3DCAjNT7qjbOKNEeei27nKPDvkSlVz7bsiAf8xUE0w5nVbnkXX
         4RXV3kYqwbMEGzoyy0O2OT8y4l+ejYDJDy4hcLlQ9b7u63WnZKJ/o1sspMXKbgnYQ9Bg
         uwVYAFvHW8Qqhwl2+gtRIavCx2UHH0+I1mxTIHxrlDIfDFGhWbbMk9YE2hWI1XzVEx0B
         /4tWh3MX9q6bCwqVlwZdcr3WRgRev3u7kd8S9XBPfGBZnd/THsz3gSapUDgeSTj0eHwU
         biCw==
X-Gm-Message-State: AODbwcCOUu1KG9ulWndhoIQvdjOb+d7YNuctDhXgLZAJSCo8i/kTpzR6
        Zj5LZzY2wIuYMA==
X-Received: by 10.99.175.8 with SMTP id w8mr3746073pge.170.1494814325646;
        Sun, 14 May 2017 19:12:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b170:f9ed:5f25:7ab5])
        by smtp.gmail.com with ESMTPSA id n65sm17223882pga.8.2017.05.14.19.12.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 14 May 2017 19:12:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Brian Malehorn <bmalehorn@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] interpret-trailers: obey scissors lines
References: <20170512090032.coddhlsrs6s3zm2f@sigill.intra.peff.net>
        <20170514033923.12870-1-bmalehorn@gmail.com>
        <20170514033923.12870-2-bmalehorn@gmail.com>
        <20170514035652.rn5npxxflku6s5k4@sigill.intra.peff.net>
Date:   Mon, 15 May 2017 11:12:03 +0900
In-Reply-To: <20170514035652.rn5npxxflku6s5k4@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 13 May 2017 23:56:53 -0400")
Message-ID: <xmqqfug6yiks.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> If a commit message is being editted as "verbose", it will contain a
>> scissors string ("-- >8 --") and a diff:
>> 
>>     my subject
>> 
>>     # ------------------------ >8 ------------------------
>>     # Do not touch the line above.
>>     # Everything below will be removed.
>>     diff --git a/foo.txt b/foo.txt
>>     index 5716ca5..7601807 100644
>>     --- a/foo.txt
>>     +++ b/foo.txt
>>     @@ -1 +1 @@
>>     -bar
>>     +baz
>> 
>> interpret-trailers doesn't interpret the scissors and therefore places
>> trailer information after the diff. A simple reproduction is:
>> 
>>     git config commit.verbose true
>>     GIT_EDITOR='git interpret-trailers --in-place --trailer Acked-by:me' \
>>         git commit --amend

So, "git commit --amend --verbose" prepares something like the above
example and passes it to the GIT_EDITOR.  The problem description
indicates that because interpret-trailers (which happens to be used
as the GIT_EDITOR) treats the cut-line used by "git commit" just
like any other random line, it tries to find the trailer block way
below, in the patch text.  I agree that it is a problem.  But...

>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index 2de5f6cc6..2ce9c339d 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -1735,7 +1735,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>  
>>  	if (verbose || /* Truncate the message just before the diff, if any. */
>>  	    cleanup_mode == CLEANUP_SCISSORS)
>> -		wt_status_truncate_message_at_cut_line(&sb);
>> +		strbuf_setlen(&sb,
>> +			      wt_status_last_nonscissors_index(sb.buf, sb.len));
>
> This hunk surprised me at first (that we would need to touch commit.c at
> all), but the refactoring makes sense.

This still surprises me.  If the problem is in interpret-trailers,
why do we even need to touch cmd_commit()?  If GIT_EDITOR returns us

     my subject
 
     Acked-by: me
     # ------------------------ >8 ------------------------
     # Do not touch the line above.
     # Everything below will be removed.
     diff --git a/foo.txt b/foo.txt
     index 5716ca5..7601807 100644
     --- a/foo.txt
     +++ b/foo.txt
     @@ -1 +1 @@
     -bar
     +baz

after this patch fixes interpret-trailers, wouldn't the cmd_commit()
function work as expected without any change?

Puzzled.

The proposed log message calls the cut-line "scissors", but that is
probably a source of this confusion.  The cut-line and scissors do
not have much in commmon.  For one thing, scissors is a mechanism to
discard everything _ABOVE_ it.  The cut-line we see in this example,
on the other hand, is about discarding everything _BELOW_ it.
