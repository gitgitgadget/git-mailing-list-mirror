Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C79BC20705
	for <e@80x24.org>; Tue,  6 Sep 2016 02:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754196AbcIFCJc (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 22:09:32 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:38475 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754086AbcIFCJb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 22:09:31 -0400
Received: by mail-it0-f53.google.com with SMTP id c198so170904201ith.1
        for <git@vger.kernel.org>; Mon, 05 Sep 2016 19:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tLwYugbNYJRta8MlkOooptnTkWwR1GiqzbZaSovZ6Rs=;
        b=hxFi4UJbWOn3YNOtog31Jb7dw85g5++6GzCLswdWjR3k31SwCmc1EZAF8WC+Xsdiga
         ZAO8Lb/ufhpbg+5AQnB50bNYO38vUHD+Vay5KMao8/6HzUKXTbT3ktpi+pJK6hisRfbT
         1rfynF0+yiqvGN64ChP7A+qcP3dCdjsrVfWQ9R7EUzwP6Orzvkukc9QIQCfPQZLqPZX1
         QuH4+XKcifsSd9DtwZfX5dpnrVVVv8xBuE/6aabpqjmPBeUmQHjx869TnE1G32Ma4E4F
         27CnMbqDhn3E8hueEtXlQQtLr0sjDGROzWJxB3OhvepcTcUqN10Q1Qy1P6fOjlG7ukxM
         VH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tLwYugbNYJRta8MlkOooptnTkWwR1GiqzbZaSovZ6Rs=;
        b=GTCF+NUDT4nuiUx9eWst0CfeLw8+9QGqQboCi8dvBG5DH1wYUQswm8KGP08lsZYOWL
         715jQVEE7uOd5Nvbg3svYHZ1kbrRTKEujbpV2LvzYum0sP2ShXpR2zjdVAi1kpMvv27+
         w5oLVnhK6KzGIG543103juxsDta/4MA1noMm4epGlLUVCgZjeY5iaqdM08yoK9cZdeqx
         qJAwnIE9PLEniXa/x/HAhRLwFW6Y7zhiMeIiZLZM5FzPqDP58/hMN30WJLJ0q0GmNi+Y
         bNk7wrL68MoNGJPZVwt/YaW64XMdpT+/RG4o4wwBVD5hcnii8EhYKvdUwoXiKWxgec9U
         2QXw==
X-Gm-Message-State: AE9vXwNDhLwJhc6QAgnI1C3LvJ01O4WDsRd4Q9a2xH9rxzh3u4zJ2SUN9XbqZcTTXU96KLeHiVl7JbQNWum6E227
X-Received: by 10.107.164.76 with SMTP id n73mr2112871ioe.165.1473127770911;
 Mon, 05 Sep 2016 19:09:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Mon, 5 Sep 2016 19:09:30 -0700 (PDT)
In-Reply-To: <CA+P7+xqx4PHHoKT_PK5s5eOtZMG9QJTSHED_=+BHZ=U330AQtw@mail.gmail.com>
References: <20160904191435.14144-1-stefanbeller@gmail.com>
 <xmqq1t0yqinr.fsf@gitster.mtv.corp.google.com> <CA+P7+xqx4PHHoKT_PK5s5eOtZMG9QJTSHED_=+BHZ=U330AQtw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Sep 2016 19:09:30 -0700
Message-ID: <CAGZ79kYPtvJ7iF8G5ihUCa5NwvDFa_Rzh+N7ar9QA2x74p2Z9g@mail.gmail.com>
Subject: Re: [WIP PATCH v2] diff.c: emit moved lines with a different color
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 5, 2016 at 6:09 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Mon, Sep 5, 2016 at 11:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <stefanbeller@gmail.com> writes:
>>
>>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>>> index 0bcb679..f4f51c2 100644
>>> --- a/Documentation/config.txt
>>> +++ b/Documentation/config.txt
>>> @@ -980,8 +980,9 @@ color.diff.<slot>::
>>>       of `context` (context text - `plain` is a historical synonym),
>>>       `meta` (metainformation), `frag`
>>>       (hunk header), 'func' (function in hunk header), `old` (removed lines),
>>> -     `new` (added lines), `commit` (commit headers), or `whitespace`
>>> -     (highlighting whitespace errors).
>>> +     `new` (added lines), `commit` (commit headers), `whitespace`
>>> +     (highlighting whitespace errors), `moved-old` (removed lines that
>>> +     reappear), `moved-new` (added lines that were removed elsewhere).
>>
>> Could we have a config to disable this rather costly new feature,
>> too?
>
> That seems entirely reasonable, though we *do* have a configuration
> for disabling color altogether.. is there any numbers on how much more
> this costs to compute?

This new coloring is linear to the size of the patch, i.e. O(number of
added/removed lines) in memory and for computational efforts I'd
think it is O(n log n) as inserting into the hashmap is an amortized
log n.

>
>>> +static struct hashmap *duplicates_added;
>>> +static struct hashmap *duplicates_removed;
>>> +static int hash_previous_line_added;
>>> +static int hash_previous_line_removed;
>>
>> I think these should be added as new fields to diff_options
>> structure.
>
> Agreed, those seem like good choices for diff_options.

yup.
