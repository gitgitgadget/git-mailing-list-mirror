Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27DA01F407
	for <e@80x24.org>; Fri, 15 Dec 2017 19:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755593AbdLOTkb (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 14:40:31 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:37090 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755406AbdLOTkb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 14:40:31 -0500
Received: by mail-qt0-f179.google.com with SMTP id f2so13451592qtj.4
        for <git@vger.kernel.org>; Fri, 15 Dec 2017 11:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FYygtf+LM1gmzOrNk5K6xZfTYVcThoEZ80n16o4cFc4=;
        b=pqiDNRFuBbIIpF0RFL2HwVVdEAaQcQojRfm1spMwL4jLw7gPW5PvVbMiUbhCAm1yCM
         OllGXei7MQdCY6bjuYL2OdjEkoOsycVC8XEknJYHZXQXWg12Jo6bMoCfvWWX7Ytj41ri
         ATXWnCoxKcx7MHQRBAPVQkVFILK3uovMlviNl938eJ+XemhL4F1PD6/scLb2lDeY6RKo
         lUdpqBQfjWdMhiVfz+SgAGiiot+l3UaYStu0cBayemcbI7rLPqNGUq0DoWO45fGsmAuG
         mJLRkkD3kNj2L/cyO0xufABoViKmsXuT3nq/rnAbQ8i9NMwRtXgyB3WjGzXUmuLDUJwP
         LmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FYygtf+LM1gmzOrNk5K6xZfTYVcThoEZ80n16o4cFc4=;
        b=Hbx8YScfJzRHHx7TmYdCIjcx9DX4sorEXKoDEenSnm9/vvXvyYjsF56jmX7VwAb82r
         gpOVHps0GmTyZfZpfNvkMOPLuBPASCpIjblbSqs6ff32Hb1cR7wAV48Y1P091W5EQZWP
         QbsYX7CJwafZoEnvOG3yDNdlB/TL861dDxsH3P1yVVPsxkJEBk+UvsmSqKwYlUGkiV3Z
         44sJPo4s2B5PwBX8pBrRnC/BAZUnaAGRC7D28FwEBg2KjQoMSkUuCetiEi+VnQW/5cps
         yiGjR6GuIpehpRaoVzrWoDIDMzRnHBUypvJoMZ7opM9R6awKwkyUsez9kBGjvcMhWIFi
         Qbdw==
X-Gm-Message-State: AKGB3mKnyDMmHi+hTo1UAFKz+bwAOHKaGaffzBMkKsOia5ga2z1lgOTf
        9yK8qmcXTeugiGlS2FZHEPQ=
X-Google-Smtp-Source: ACJfBot/dVrS9dSnwwLOvURExT9dx95UgyZTx8SdJPzaHIiNG0rt13mimOmCbkTZh52CX8kVT9DWHg==
X-Received: by 10.200.4.44 with SMTP id v44mr24243023qtg.80.1513366830002;
        Fri, 15 Dec 2017 11:40:30 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id n73sm4413635qka.79.2017.12.15.11.40.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Dec 2017 11:40:29 -0800 (PST)
Subject: Re: Question about the ahead-behind computation and status
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <peartben@gmail.com>,
        Jameson Miller <jameson.miller81@gmail.com>
References: <030bf57c-7a23-3391-4fc0-93efee791543@jeffhostetler.com>
 <20171215100835.GC3567@sigill.intra.peff.net>
 <88175f57-082d-ad61-c2dd-53ae50540460@jeffhostetler.com>
 <d16339e0-54bd-073b-fa4a-7c3a84a025e9@gmail.com>
 <xmqqa7yjrghd.fsf@gitster.mtv.corp.google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5fd76b6f-15d0-b8ca-710b-d6289a63b9b4@gmail.com>
Date:   Fri, 15 Dec 2017 14:40:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqa7yjrghd.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/15/2017 1:30 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> The biggest reason for the 20 seconds is not just the number of
>> commits in the ahead/behind but how many commits are walked (including
>> common to both branches) before paint_down_to_common() breaks its
>> while loop due to queue_has_nonstale().
> Hmm, queue_has_nonstale() looks to see if any element is not STALE
> (where the definition of STALE is "known to be a common ancestor")
> by potentially checking all elements in the queue.  I wonder if we
> have an opportunity for a trivial optimization?  When the caller
> knows that it dug one level and added the parents that are not
> stale, it does not have to ask queue_has_nonstale() if there is any
> non stale element, for example.

I thought this, too, but my tracing did not show significant time spent 
in this method. 99% of the time is spent unzipping and parsing commits.

If this was taking too long, then we could track a minimum timestamp for 
a commit that entered the queue in a non-stale state, but this will 
delay the termination condition a bit since commits can be marked stale 
after they enter the queue.

> What do you exactly mean by "not just the number of commits in the
> ahead/behind"?  Aren't the number of these commits pretty much
> proportional to the number of commits we need to paint down to
> common ancestors?  Is the latter a lot larger than the former
> (i.e. are we somehow not stopping when we _could_ notice that we
> can with better information)?
>
>

With the wide history, there is actually a large set of commits that are 
in the common history but have newer commit times than the oldest commit 
in only one history. Consider the following ASCII art:

   A
   |
   1
   |
   2
   |
   3
   |\
   4 B
   |\|
   5 C
   |\|
   6 D
   |\|
    .
    .
    .
   |\|
   N Z
   |/
   0

Between A and B, A is ahead by commits {A,1,2,3,4,5,6,...,N}. Meanwhile, 
commits B,C,D,...,Z are in the common history, but still must be walked.

Now imagine these two sets are actually much MUCH wider (thousands of 
commits that are pairwise non-ancestors). This causes the number of 
walked commits to be larger than just the number of commits in the 
symmetric difference of the histories.

Unfortunately, generation numbers are not the only optimization needed 
to make this call be sub-100ms. A graph data structure that lists the 
edges between commits would prevent the time spent in zlib decompressing 
and parsing commits. I'm working on investigating how such a data 
structure (and corresponding file format) could integrate in the 
commit-walking code.

Thanks,
-Stolee
