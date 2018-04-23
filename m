Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B61431F424
	for <e@80x24.org>; Mon, 23 Apr 2018 14:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755443AbeDWOyK (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 10:54:10 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:46589 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755419AbeDWOyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 10:54:09 -0400
Received: by mail-qt0-f171.google.com with SMTP id h4-v6so17941917qtn.13
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 07:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=OXkA+zPO9ieXYeK7ue0w58dK13E+jqXw72LJz4AZ5ds=;
        b=UqkiqTpKbmt4684hdU1occn2CdRNYETpJDB1dJawo6gTx1FQt/qjQJtMC2n43JIODr
         Uzcb+dj4Kpvahr/gQKj3CuqsPObzBuV/1HikDbT7hUHBuz2tsG2TPzifY4dkE1Roci0Y
         CspaC7pdv8H/w5xaangdEi0TGHO0/PeJ8O2s4j0Eto6z3whMFRKlNZSpVl69oU3n7FS/
         NYjhWawgypXyhOaaPwV1LeS1aQJuja9quZ+vS4B1lohuInVjfGydZke8IchGYPkQmcRl
         Wsd5z3sSWQVNLTb6SmDKxnXUhnLWFaDgeShCFWZ1rvUdwl/wMphabUKMnBrINDuRJlSu
         v00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OXkA+zPO9ieXYeK7ue0w58dK13E+jqXw72LJz4AZ5ds=;
        b=NhHQNgbDp6A1HXmW9/1WlwflgrGcUTnfaIdJ3fymNNJBxGzvy1hjO+RmwgMy7P3ICv
         9TSkJLr3j6Df3+yZ3vtSA/XqCtFtieVisH47ucCWF8P8wCfICqc6+5qc3C4lCMDRg7y0
         xMnGv77kWuChUusLY2AHvw1gcf1ZlcIZ3kK6TJMpEoUAjHXR12fliGuacntNjP+RYDY0
         dv+mcXIxIZ7sYxCQb6M2PxopmCNAa69xjpgVcdQC2VJPFjSY+mQsWEh5N9tdtJSeYU9S
         z1g13HJGj1Aonm16+XzwhupIVljzcq5bscZSTHzNL/SfLD4oehrNzdNgY6Ynkf8MRARt
         VFwA==
X-Gm-Message-State: ALQs6tAnIt8SktQli7VuvhBh1vMf5pIz9iB+N89sn0dM5g7ycrD+u3W1
        i33B41F2xFJEfrEgvQh97fZGFDl0gG0=
X-Google-Smtp-Source: AB8JxZpBYQB8dazR6k9fVTmd1kPkeV5+cvJXZ2X6BxN2uXLQYn/3QXGIcqbgnrzHu3TY+7CO6KBTKg==
X-Received: by 10.12.233.204 with SMTP id q12mr1860528qvo.105.1524495248486;
        Mon, 23 Apr 2018 07:54:08 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id h6-v6sm11310321qtb.69.2018.04.23.07.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 07:54:07 -0700 (PDT)
Subject: Re: [PATCH v3 0/9] Compute and consume generation numbers
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>
References: <20180409164131.37312-1-dstolee@microsoft.com>
 <20180417170001.138464-1-dstolee@microsoft.com> <86y3hkf4d9.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f4d3bfcc-514e-f4ab-922a-c5214b327c0d@gmail.com>
Date:   Mon, 23 Apr 2018 10:54:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <86y3hkf4d9.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/18/2018 8:04 PM, Jakub Narebski wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> -- >8 --
>>
>> This is the one of several "small" patches that follow the serialized
>> Git commit graph patch (ds/commit-graph) and lazy-loading trees
>> (ds/lazy-load-trees).
>>
>> As described in Documentation/technical/commit-graph.txt, the generation
>> number of a commit is one more than the maximum generation number among
>> its parents (trivially, a commit with no parents has generation number
>> one). This section is expanded to describe the interaction with special
>> generation numbers GENERATION_NUMBER_INFINITY (commits not in the commit-graph
>> file) and *_ZERO (commits in a commit-graph file written before generation
>> numbers were implemented).
>>
>> This series makes the computation of generation numbers part of the
>> commit-graph write process.
>>
>> Finally, generation numbers are used to order commits in the priority
>> queue in paint_down_to_common(). This allows a short-circuit mechanism
>> to improve performance of `git branch --contains`.
>>
>> Further, use generation numbers for 'git tag --contains', providing a
>> significant speedup (at least 95% for some cases).
>>
>> A more substantial refactoring of revision.c is required before making
>> 'git log --graph' use generation numbers effectively.
>>
>> This patch series is build on ds/lazy-load-trees.
>>
>> Derrick Stolee (9):
>>    commit: add generation number to struct commmit
> Nice and short patch. Looks good to me.
>
>>    commit-graph: compute generation numbers
> Another quite easy to understand patch. LGTM.
>
>>    commit: use generations in paint_down_to_common()
> Nice and short patch; minor typo in comment in code.
> Otherwise it looks good to me.
>
>>    commit-graph.txt: update design document
> I see that diagram got removed in this version; maybe it could be
> replaced with relationship table?
>
> Anyway, it looks good to me.

The diagrams and tables seemed to cause more confusion than clarity. I 
think the reader should create their own mental model from the 
definitions and description and we should avoid trying to make a summary.

>
>>    ref-filter: use generation number for --contains
> A question: how performance looks like after the change if commit-graph
> is not available?

The performance issue is minor, but will be fixed in v4.

>
>>    commit: use generation numbers for in_merge_bases()
> Possible typo in the commit message, and stylistic inconsistence in
> in_merge_bases() - though actually more clear than existing code.
>
> Short, simple, and gives good performance improvenebts.
>
>>    commit: add short-circuit to paint_down_to_common()
> Looks good to me; ignore [mostly] what I have written in response to the
> patch in question.
>
>>    commit-graph: always load commit-graph information
> Looks all right; question: parameter or one more global variable.

I responded to say that the global variable approach is incorrect. 
Parameter is important to functionality and performance.

>
>>    merge: check config before loading commits
> This looks good to me.
>
>>   Documentation/technical/commit-graph.txt | 30 +++++--
>>   alloc.c                                  |  1 +
>>   builtin/merge.c                          |  5 +-
>>   commit-graph.c                           | 99 +++++++++++++++++++-----
>>   commit-graph.h                           |  8 ++
>>   commit.c                                 | 54 +++++++++++--
>>   commit.h                                 |  7 +-
>>   object.c                                 |  2 +-
>>   ref-filter.c                             | 23 +++++-
>>   sha1_file.c                              |  2 +-
>>   t/t5318-commit-graph.sh                  |  9 +++
>>   11 files changed, 199 insertions(+), 41 deletions(-)
>>
>>
>> base-commit: 7b8a21dba1bce44d64bd86427d3d92437adc4707

