Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 755CE207E2
	for <e@80x24.org>; Tue, 25 Apr 2017 02:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S980041AbdDYChW (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 22:37:22 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33313 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S980012AbdDYChU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 22:37:20 -0400
Received: by mail-io0-f195.google.com with SMTP id k87so51975448ioi.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 19:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=40WZEBmLlWUgquhCrqbVBKOCq2YBT+oRtHYe6nm58IY=;
        b=k355hGeadkfZcvaQnIXnzYWKBAJm+6Nhe32YfpBKeC5QgiZLZPHTAwWcbnzYXRwIPD
         6OZCivkGYoxWc6VpR7+J1lnzU02vMXYNssHBDLszOA17X2tcm2EPWfqWjmBlR1Up3P+R
         UQbw/gzb7pu9Vqh/eMR2GlgDgA251xgUMDeKxBObgzJU/br85XthdWtc8cAx2b6oHK5p
         xp3j/WkOg7mGdawFbae1mDq1v//H1WuTjMb6HFnBC09xdESoNX0D0/Ex8fg2kSr3F+cM
         dYDwzJ+UYS9zGf6MDahWYpbN7OXqadUVB0fSRYWEbBdrOWEA3Y5GWUvyvzqIBoEDia/z
         UQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=40WZEBmLlWUgquhCrqbVBKOCq2YBT+oRtHYe6nm58IY=;
        b=smuWPMmYROOWJTOnTXnOKJWRyfJTcQrOXK8570v+h+6XsO5Hh3+ulsj0PbqPhmXq+A
         7HN5fIsOxxWp1oQEpPmlYwkViEnKEnB+6gz946jewqhKWaVvO5Ns41KUH3iveHfsooRV
         7eJ//LeQW4OSL09Sq7Sr9TTdIfdksERMlZvDxlmlEf0Z7KHUH7esX80gCRotn3QBxgFO
         0mE1/ToO8kDf23cCIyeqM67K1nzBNQQufdXrz+GJ6Eo3fM9unGZsRn7BVok7Cz3Rt9wc
         JS9fNZEYeu4suurg7+qnMqDGuyqKaWBg/JiY3Hyu0yJ8RwDI5vYsImRZ0Dv3hIuEf4ZR
         GUAQ==
X-Gm-Message-State: AN3rC/7yucY7FGG4Hc85ta4i6WmjVy/fpL8Rq5F11Qn+bRqZ3DwXPqk6
        9ZVCaj22nMaz+A==
X-Received: by 10.107.52.202 with SMTP id b193mr10844910ioa.150.1493087839924;
        Mon, 24 Apr 2017 19:37:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:894:a17f:b6e3:25e8])
        by smtp.gmail.com with ESMTPSA id b91sm828662itd.26.2017.04.24.19.37.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 19:37:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 7/9] Abort if the system time cannot handle one of our timestamps
References: <cover.1492721487.git.johannes.schindelin@gmx.de>
        <cover.1492771484.git.johannes.schindelin@gmx.de>
        <2b7f90c003a1f60ede39813530617edbbdf29607.1492771484.git.johannes.schindelin@gmx.de>
        <xmqqr30i1omp.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1704241228510.3480@virtualbox>
Date:   Mon, 24 Apr 2017 19:37:18 -0700
In-Reply-To: <alpine.DEB.2.20.1704241228510.3480@virtualbox> (Johannes
        Schindelin's message of "Mon, 24 Apr 2017 15:57:28 +0200 (CEST)")
Message-ID: <xmqqzif5w6u9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Sun, 23 Apr 2017, Junio C Hamano wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>> > diff --git a/date.c b/date.c
>> > index 92ab31aa441..75f6335cd09 100644
>> > --- a/date.c
>> > +++ b/date.c
>> > @@ -46,7 +46,10 @@ static time_t gm_time_t(timestamp_t time, int tz)
>> >  	minutes = tz < 0 ? -tz : tz;
>> >  	minutes = (minutes / 100)*60 + (minutes % 100);
>> >  	minutes = tz < 0 ? -minutes : minutes;
>> > -	return time + minutes * 60;
>> > +
>> > +	if (date_overflows(time + minutes * 60))
>> > +		die("Timestamp too large for this system: %"PRItime, time);
>> > +	return (time_t)time + minutes * 60;
>> >  }
>> 
>> All the other calls to date_overflows() take a variable that holds
>> timestamp_t and presumably they are checking for integer wraparound
>> when the values are computed, but this one is not.
>
> I was debating whether this extra check is necessary and had decided
> against it. Apparently I was wrong to do so.

Not so fast.  Apparently you had thought about it and I didn't think
about it as long as you did, hence I asked ...

>
>> Perhaps we want to make it a bit more careful here?  I wonder if
>> something like this is a good approach:

as a question, not a request to change things, and not a "do not
come back until you rewrite it this way" ;-).  Getting a question is
not a sign that you were wrong at all.

If you thought it was not needed, and if you can clearly explain to
future readers of "git log" why it is the case, then I am prefectly
fine without an extra check.

In a response to another message, you seem to indicate that existing
code does not do any range checking to make sure ulong (the current
type the existing code uses) does not wrap around and you kept that
"property" of the code in this series (i.e.  date_overflows() range
check was merely for downcasting timestamp_t to time_t before giving
the result to the system functions).  If that is the case, then NOT
checking for integer wraparound in "+ minutes*60" computation IS the
consistent thing to do within your series, I would think.
