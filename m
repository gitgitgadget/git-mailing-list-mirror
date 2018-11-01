Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F1DD1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 19:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbeKBEG0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 00:06:26 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33621 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725722AbeKBEGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 00:06:25 -0400
Received: by mail-qk1-f193.google.com with SMTP id o89so12975939qko.0
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 12:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QlECycFRNhIJqceoEumRze180Pdj/a8HkDJMiE6OYz4=;
        b=N6P05sXKjbAaYgESO3ZdegYR8cLp1N1oAENi7doW++yUJiGCloYIGxn71rj0S0YCVi
         TpVS8cbkNteJ9r+DrM5uRv27n3mmBxheDPUkMMJYxWIIUcBTSfDiqfmRmuxqBwEtVIej
         KlNE84Vh0lAqAcLIY1t0RpH1CXkWWegqIIdxcRC+U5FviZWT0BdkRYSulytftug0vZPZ
         ld5Gr+RG6lIHKkaESKRtqgIiI/CCIe8gSqqdlU/nxswRVQIDZI5R52xcXMrIciEA+/5F
         tNq3c7Eln5MOHOFfTwjZBVAx2yROIyDCMm7Fup7V7udjVGSVy/65xNFOHHFJrsEQpDVH
         DAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QlECycFRNhIJqceoEumRze180Pdj/a8HkDJMiE6OYz4=;
        b=gCEd7TuFaiTc8TVV+uJ8gsJfEPIgkgh+Y8ZFC/xBHiKXFTaNqen8H5DX9lwDJ9yG4s
         inC1U1te6VyQV3RrT5zXTUtgNHNpkxtwwd4vbrJ7V6lwnnWzjrCjKuy9buiF0insRjIj
         WerBASAQkXE+qY8mbWlpkXCHhvpAzcyf/w9IpGMaZ94ZdYrs961P7Ze7HCTQhOZSOh4x
         Q5wLER1XkWSQR7NsRKGb4rOo21Bfde4P0lkdrS5LE8SDsdhq8roEBnawdkUgncJCPsqV
         ewBsCZpHlAQ5glq+vE86Qteew/1ORw6TaBYJ/AuZKvZ4CcYVa3pMptjxFV7DMGpLdLUS
         +15A==
X-Gm-Message-State: AGRZ1gKQ3C6tWNc4Z8ux0/0WfL34OrAHFF7BSNuUm6WMaaRk54uou53j
        U+rCWzJo6PZzZrznBgZ73pM=
X-Google-Smtp-Source: AJdET5fceXsNChgnYbC9EHJ/IWKB1m5nHm7ZQ2PGy6yszU3DKRLJSDxsN7419MQUiVBxDO3moz01MA==
X-Received: by 2002:ac8:27d0:: with SMTP id x16-v6mr7753330qtx.61.1541098931290;
        Thu, 01 Nov 2018 12:02:11 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:eddc:3ff3:d342:de1b? ([2001:4898:8010:0:d712:3ff3:d342:de1b])
        by smtp.gmail.com with ESMTPSA id e5-v6sm15254463qtr.17.2018.11.01.12.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 12:02:10 -0700 (PDT)
Subject: Re: [PATCH 0/3] Make add_missing_tags() linear
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
References: <CABPp-BFzwphzaMjCWrNxU2V+YeYvRiBOzSV--b13wa7r16dvMQ@mail.gmail.com>
 <20181031120505.237235-1-dstolee@microsoft.com>
 <CABPp-BHHG9K0869=4CYkqjN6rwLCzRBiF_Z94KFevSo3_FvYAw@mail.gmail.com>
 <ad4ab388-6244-1811-ec1b-6f8143df620e@gmail.com>
 <CABPp-BG6+3F+FY0JP2mj0OCLjp17xQXTe54mBCN+RifQd4Aj2A@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3aadf261-9ed7-6ded-4482-ab01d74802aa@gmail.com>
Date:   Thu, 1 Nov 2018 15:02:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BG6+3F+FY0JP2mj0OCLjp17xQXTe54mBCN+RifQd4Aj2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/1/2018 2:57 PM, Elijah Newren wrote:
> On Thu, Nov 1, 2018 at 5:32 AM Derrick Stolee <stolee@gmail.com> wrote:
>> No rush. I'd just like to understand how removing the commit-graph file
>> can make the new algorithm faster. Putting a similar count in the old
>> algorithm would involve giving a count for every call to
>> in_merge_bases_many(), which would be very noisy.
> $ time git push --dry-run --follow-tags /home/newren/repo-mirror
> count: 92912
> To /home/newren/repo-mirror
>   * [new branch]              test5 -> test5
>
> real    0m3.024s
> user    0m2.752s
> sys    0m0.320s

Is the above test with or without the commit-graph file? Can you run it 
in the other mode, too? I'd like to see if the "count" value changes 
when the only difference is the presence of a commit-graph file.

Thanks,
-Stolee
