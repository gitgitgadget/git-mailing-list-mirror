Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF7921F406
	for <e@80x24.org>; Tue,  9 Jan 2018 19:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964997AbeAITbD (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 14:31:03 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33099 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933868AbeAITbC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 14:31:02 -0500
Received: by mail-qk0-f171.google.com with SMTP id i17so15602655qke.0
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 11:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jZtO710bv/k3KHku+ml0n6ogl2jCwC/M5BaXUQPxk94=;
        b=TVZkqMywC6epkJ8BFrmK04tHZ4sq7zccYr8//Llrht0DjrHqwOfQ6L+KAH0WC9kSvl
         sgqY7uLvv2tQOJBIZIVG2ZlI2RPGs8NuoEUzlpGAxz9CrNB74S1xf476lQpBjJi26/rW
         iCAqCdx/03EfY+bEG1xzMUdtQ7hNFhbVKZoz4NV8eGUypzNCw5k5yUJi8lItbUkmil0q
         SwuTJ2EcW+mjkvOzqSOWpmK0QyEaehzNNeR+sRHnDRUBf5tzChb260A4rsm2GiwSDzjH
         I+aGrPzZzRhyeajlhKQNDjBmzJigBaXbMl1CW4vG1Vi9EzAHrYqej0OZB27wEQzGXaep
         eJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jZtO710bv/k3KHku+ml0n6ogl2jCwC/M5BaXUQPxk94=;
        b=uP20xPDhgjwXonfD1HZs9OUlxVWvuR9bSY3bipvYyo6KOOe6anm9lNxPQ0jiJfK3U/
         Tz2be2HKwvoBNcA72B1AHDgoiVrIIWbzfmCIpuN6vnwCRuVNTGxZWI/o6QbUyy1AUgaT
         XN8MQmVpnAiE15awM+BNndMw4QRksN1QltmVLdtkhemdZk86IKPLGbXLNihfMAikUvSs
         Pk8RwOKdJOKgNRGpqOK2r1pqOZQCLovZ8VP+dGrfTyul+f7nBH7IpNy+M2Wh9mkSCrLl
         fD58cQVl3aUfZJjRHrzEPEV3bfeENvVKJYyNFAa7b089r7wyLA7OFQvr61NFCcV/r8NX
         g8Ug==
X-Gm-Message-State: AKwxytd/SWAz5co8RXP9eNAjeTqKWIHv/rkvBuo3iI8TSMRJMiiDviUZ
        cT2dg4iDE2j4xJHKNgHuse0=
X-Google-Smtp-Source: ACJfBovqihMPnvgUaqJcbL4U97f1FKrwWjslHj/dT4jG1+kLa816Byv7kSyGgqBqJobjn5YkzE5EyQ==
X-Received: by 10.55.20.234 with SMTP id 103mr20521282qku.274.1515526261266;
        Tue, 09 Jan 2018 11:31:01 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id o5sm4112397qkh.94.2018.01.09.11.31.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2018 11:31:00 -0800 (PST)
Subject: Re: merge-base --is-ancestor A B is unreasonably slow with unrelated
 history B
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Thomas Rast <tr@thomasrast.ch>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <87608bawoa.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2aa20617-6b1d-f5a4-d6e1-250a3ea8f5be@gmail.com>
Date:   Tue, 9 Jan 2018 14:30:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <87608bawoa.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/9/2018 10:17 AM, Ævar Arnfjörð Bjarmason wrote:
> This is a pathological case I don't have time to dig into right now:
>
>      git branch -D orphan;
>      git checkout --orphan orphan &&
>      git reset --hard &&
>      touch foo &&
>      git add foo &&
>      git commit -m"foo" &&
>      time git merge-base --is-ancestor master orphan
>
> This takes around 5 seconds on linux.git to return 1. Which is around
> the same time it takes to run current master against the first commit in
> linux.git:
>
>      git merge-base --is-ancestor 1da177e4c3f4 master
>
> This is obviously a pathological case, but maybe we should work slightly
> harder on the RHS of and discover that it itself is an orphan commit.
>
> I ran into this while writing a hook where we'd like to do:
>
>      git diff $master...topic
>
> Or not, depending on if the topic is an orphan or just something
> recently branched off, figured I could use --is-ancestor as on
> optimization, and then discovered it's not much of an optimization.

Ævar,

This is the same performance problem that we are trying to work around 
with Jeff's "Add --no-ahead-behind to status" patch [1]. For commits 
that are far apart, many commits need to be parsed. I think the right 
solution is to create a serialized commit graph that stores the 
adjacency information of the commits and can create commit structs 
quickly. This requires storing the commit id, commit date, parents, and 
root tree id to satisfy the needs of parse_commit_gently(). Once the 
framework for this data is constructed, it is simple to add generation 
numbers to that data and start consuming them in other algorithms (by 
adding the field to 'struct commit').

I'm working on such a patch right now, but it will be a few weeks before 
I'm ready.

Thanks,
-Stolee

[1] v5 of --no-ahead-behind 
https://public-inbox.org/git/20180109185018.69164-1-git@jeffhostetler.com/T/#t

[2] v4 of --no-ahead-behind 
https://public-inbox.org/git/nycvar.QRO.7.76.6.1801091744540.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz/T/#t


