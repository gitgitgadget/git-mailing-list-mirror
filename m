Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D92D91F404
	for <e@80x24.org>; Fri, 23 Feb 2018 17:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbeBWR7D (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 12:59:03 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:37383 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbeBWR7D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 12:59:03 -0500
Received: by mail-qt0-f179.google.com with SMTP id r16so2600343qtm.4
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 09:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=AdwJNLtKXaqDP4jh6fU2c0gVEiKWlZzhtmJNDeL8SQ4=;
        b=feZhiyBgl2UiL92QbQBTy2dokyFWjQBLGSn28XODRzPn2gk5P3kCb12sazjo2MpzPW
         sLKrqUsq9CbbiR4cbq1UZuOqdLzrDkdGeckxc8TFhhmkZFDPzpSrSzTHbXO67ea2vaZn
         fR9KIC8z4OevYYPAlFVkclyV132MEjWRmkrxUzuZuT16GjohCL3OyJlKDDuiH7ZHnEPZ
         MKw2dGQBcJESMX34Qro4uSuJRdaK9O7fBsg03VBMWR5UyhFfU4iREMaCp8c72Rrd+8N7
         /Sau35nMIKr9L4I/Wukmsr0f59UThUkmCw9j0EmUr5ggvdDLsgld8ABX1KX63Iha8oV7
         qGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AdwJNLtKXaqDP4jh6fU2c0gVEiKWlZzhtmJNDeL8SQ4=;
        b=gCS1tTZuP37P5JmrQlc/hr5M5qvq4fUCpEbcDxcrWyj8zv6RILXNoekAHtvPELKHQu
         rVm2Bb/jBGX3bXQ2fUI7ovBbypLdaLE51yxUWMQ4AXvil0IkHwxDcLDVT7VcxzrBvW6B
         advvaXJizVVyGhpIxC5hE6PaHnTVOXzAtYUrtffPtiM/yiSxuXRyonA74ai1bNjMXXOZ
         Glgrey58qMg4P2aP3tVGWlR2CLaqvHTsqt5zQeBMZ7MuXvZ6lQ0pXn5LmavnvXup+9e1
         F3xGo2GF8Cb9Fv4sPxtdbhDSD9iQleOJG/grrrLKgK/VAfQSw1fwkiaVmW+hK+5nTnEn
         1vFQ==
X-Gm-Message-State: APf1xPBVr+co8TBkaUbzTkbjPtZqt0/muNZRHSyyDlk5nUQ8NJxsLy8A
        rfpjxabhZtkIu5tMoufhzY/QqjfsbWo=
X-Google-Smtp-Source: AG47ELtiBw3r3k0kHO6W4HNGR9uG782Bjq5fwSpvDZZR09Adhao2DFN4+Rcn3MusiX8rQpx7jL9CNg==
X-Received: by 10.200.47.212 with SMTP id m20mr3966745qta.170.1519408742100;
        Fri, 23 Feb 2018 09:59:02 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id 42sm1631375qte.13.2018.02.23.09.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Feb 2018 09:59:01 -0800 (PST)
Subject: Re: [PATCH v4 08/13] commit-graph: implement --delete-expired
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
 <1519066406-81663-9-git-send-email-dstolee@microsoft.com>
 <xmqqfu5sx3md.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <67871288-ea70-69d4-9c3d-5cc946d8dbe2@gmail.com>
Date:   Fri, 23 Feb 2018 12:59:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqfu5sx3md.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/22/2018 1:48 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> Teach git-commit-graph to delete the .graph files that are siblings of a
>> newly-written graph file, except for the file referenced by 'graph-latest'
>> at the beginning of the process and the newly-written file. If we fail to
>> delete a graph file, only report a warning because another git process may
>> be using that file. In a multi-process environment, we expect the previoius
>> graph file to be used by a concurrent process, so we do not delete it to
>> avoid race conditions.
> I do not understand the later part of the above.  On some operating
> systems, you actually can remove a file that is open by another
> process without any ill effect.  There are systems that do not allow
> removing a file that is in use, and an attempt to unlink it may
> fail.  The need to handle such a failure gracefully is not limited
> to the case of removing a commit graph file---we need to deal with
> it when removing file of _any_ type.

My thought is that we should _warn_ when we fail to delete a .graph file 
that we think should be safe to delete. However, if we are warning for a 
file that is currently being accessed (as is the case on Windows, at 
least), then we will add a lot of noise. This is especially true when 
using IDEs that run 'status' or 'fetch' in the background, frequently.

> Especially the last sentence "we do not delete it to avoid race
> conditions" I find problematic.  If a system does not allow removing
> a file in use and we detect a failure after an attempt to do so, it
> is not "we do not delete it" --- even if you do, you won't succeed
> anyway, so there is no point saying that.  And on systems that do
> allow safe removal of a file in use (i.e. they allow an open file to
> be used by processes that have open filehandles to it after its
> removal), there is no point refraining to delete it "to avoid race
> conditions", either---in fact it is unlikely that you would even know
> somebody else had it open and was using it.

The (unlikely, but possible) race condition involves two processes (P1 
and P2):

1. P1 reads from graph-latest to see commit graph file F1.
2. P2 updates graph-latest to point to F2 and deletes F1.
3. P1 tries to read F1 and fails.

I could explicitly mention this condition in the message, or we can just 
let P2 fail by deleting all files other than the one referenced by 
'graph-latest'. Thoughts?

> In any case, I do not think '--delete-expired' option that can be
> given only when you are writing makes much sense as an API.  An
> 'expire' command, just like 'set-latest' command, that is a separate
> command from 'write',  may make sense, though.

In another message, I proposed dropping the argument and assuming 
expires happen on every write.

Thanks,
-Stolee
