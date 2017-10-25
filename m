Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43D39202DD
	for <e@80x24.org>; Wed, 25 Oct 2017 12:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbdJYM1w (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 08:27:52 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:28002 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbdJYM1u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 08:27:50 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20171025122749epoutp0381b1488a1c02c736c24f1cdbeab394a5~wz_e2usjH1480114801epoutp03i;
        Wed, 25 Oct 2017 12:27:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20171025122749epoutp0381b1488a1c02c736c24f1cdbeab394a5~wz_e2usjH1480114801epoutp03i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1508934469;
        bh=7MRkL1x1ra7ESvjtB5KrkS46hn6vjoygYpuG9HWODn4=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=RBwCz1wSsrbvtY0c2B4Lgq3lWeqcYcnKoWzAt/fdr96PIN/YQTkSQ6u+EAQ8ZNgeC
         PkNP3VslKphGx+mQozHDGjvc1fYOLeYcQUn201IVwLE71PLI+r/JJeXHJP4ZrlOOAy
         f4WRG5a1ablRZjqRRH8d+LK+L7N3KnmRUiqnv1AE=
Received: from epsmges1p2.samsung.com (unknown [182.195.42.54]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20171025122749epcas1p350b25355fd496754ec48f3fa43819834~wz_eqj4t01238912389epcas1p3g;
        Wed, 25 Oct 2017 12:27:49 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.4F.04153.44380F95; Wed, 25 Oct 2017 21:27:48 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20171025122748epcas1p2afcc2ea741ec70a8a4b88fe4ecba9483~wz_eB1P8R1440414404epcas1p2d;
        Wed, 25 Oct 2017 12:27:48 +0000 (GMT)
X-AuditID: b6c32a36-325ff70000001039-b4-59f08344e90b
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.9C.04095.44380F95; Wed, 25 Oct 2017 21:27:48 +0900 (KST)
Received: from [106.109.129.81] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0OYD003A9PA9YP70@mmp1.samsung.com>; Wed, 25 Oct 2017 21:27:48 +0900 (KST)
Subject: Re: [PATCH v2] merge-recursive: check GIT_MERGE_VERBOSITY only once
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>, vmiklos@frugalware.org
From:   Andrey Okoshkin <a.okoshkin@samsung.com>
Organization: Samsung RnD Institute Russia
Message-id: <84d89e54-4e72-9938-4d71-e24a0617fe82@samsung.com>
Date:   Wed, 25 Oct 2017 15:27:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.4.0
MIME-version: 1.0
In-reply-to: <CAPig+cRq1AEOgDoXeH-hDMvhEMnfiNK5CuSBbbio-mbHros=QQ@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7bCmrq5L84dIg197rCy6rnQzWTT0XmG2
        +Pumi9HiR0sPs8Xmze0sFmfeNDJaHGn/zOTA7vGkuYfFY+esu+weCzaVejzr3cPocfGSssfi
        B14enzfJBbBHcdmkpOZklqUW6dslcGW861nEXjBTqmLDs3UsDYwrRboYOTkkBEwkDvZ2M4HY
        QgI7GCU+7lHpYuQCsr8zSrxvnMQIU7TsySF2iMRuRonpO6+xQTj3GSXOvfkDViUs4CPxfMsr
        NhBbREBb4sOGTYwgRcwCLxgljhz9BLaDTUBP4vyvCewgNr+AlsTlH/OYQWxeATuJqZdPgMVZ
        BFQlDn76AjZIVCBC4vjh5YwQNYISPybfYwGxOQWCJZZM6AezmQU0JV58mQRli0scu3+TEcKW
        l9i85i0zyBESAs/ZJLrfb2CC+MdF4n9HAzOELSzx6vgWoMUcQLa0xKWjthDheonWjidsEL0d
        jBKfZy1lh0jYS2zp2s4GsYBP4t3XHlaIXl6JjjYhiBIPiQlPD0KtcpQ4suY8NLTOs0rMaz3P
        NIFRfhaSf2Yh+WEWkh9mIflhASPLKkax1ILi3PTUYsMCI73ixNzi0rx0veT83E2M4OSjZbaD
        cdE5n0OMAhyMSjy8AtPfRwqxJpYVV+YeYpTgYFYS4eUo/RApxJuSWFmVWpQfX1Sak1p8iFGa
        g0VJnFd0/bUIIYH0xJLU7NTUgtQimCwTB6dUAyOPdt43tuUNhzbtKfnF/enBuYdXqwrvXghd
        tHm6Rfh1h5vx63/Gv2D4Vjrp6kwJw/rDXayf00Sunlx0ZjFfXDuryj0dlQlX1Vx5eQ6cUX01
        +Z2tDFNgVwXTWvaSwAjJc5zPDfQ6DPZmZt4w8dpcbnXWZVfC54Vhnd+++sTo3YgR7tl33T5+
        k7USS3FGoqEWc1FxIgDMi+8MOgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsVy+t9jAV2X5g+RBjeXC1p0XelmsmjovcJs
        8fdNF6PFj5YeZovNm9tZLM68aWS0ONL+mcmB3eNJcw+Lx85Zd9k9Fmwq9XjWu4fR4+IlZY/F
        D7w8Pm+SC2CP4rJJSc3JLEst0rdL4Mp417OIvWCmVMWGZ+tYGhhXinQxcnJICJhILHtyiB3E
        FhLYySjx+qkchP2QUWL9FB8QW1jAR+L5lldsILaIgLbEhw2bGEFsZoEXjBInLkR0MXIB1V9k
        lVgy7SLYIDYBPYnzvyaA2fwCWhKXf8xjBrF5Bewkpl4+ARZnEVCVOPjpC9hQUYEIiefN71kh
        agQlfky+xwJicwoES3z89I6pi5EDaJm6xJQpuRB7xSWO3b8JdYO8xOY1b5knMArOQtI9C6Fj
        FpKOWUg6FjCyrGKUTC0ozk3PLTYqMMxLLdcrTswtLs1L10vOz93ECIyTbYe1+nYw3l8Sf4hR
        gINRiYc3Y+b7SCHWxLLiytxDjBIczEoivBylHyKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ897O
        OxYpJJCeWJKanZpakFoEk2Xi4JRqYOSa4xFw5N6CK46e9989XvdKzffbm5qDrfx3XpwX8rc9
        rrquelHD3j8XFQyFGi8JuqSbnVu5JDV12/zot7y7Ut6lxh07fsbv7U/upOYd3ZkmX/bnO845
        sfyw6OGSjbOuc1VZnFjtpvc3WHmjfMU0b7YQrr5LzTOK1uosdli/wPxvxdxNMi2f/fuUWIoz
        Eg21mIuKEwGbrICkjwIAAA==
X-CMS-MailID: 20171025122748epcas1p2afcc2ea741ec70a8a4b88fe4ecba9483
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5
X-RootMTR: 20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5
References: <CGME20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5@epcas2p4.samsung.com>
        <3aed764b-388c-d163-08fc-32b294c6b9d3@samsung.com>
        <CAGZ79kaSZG9WriqX0SLbTnEDRr-4YdFRuK17+9wnxyrftfnMmg@mail.gmail.com>
        <CAPig+cRTL2amjsgdp1=T3GMZLa=favugOfnQw9XjWzC+U=v5Sw@mail.gmail.com>
        <CAN0heSp7b_6n3y=s4++oWhkPUuM=s9L7LWVx5vn8o=5aH6DKKw@mail.gmail.com>
        <20171024195221.gqgtibwjaztgeel6@sigill.intra.peff.net>
        <xmqq8tg0j8vb.fsf@gitster.mtv.corp.google.com>
        <CAPig+cSjQd=p1CdizU5oUaz91z=j02UnWLtTguWzvkjS+v6ETA@mail.gmail.com>
        <20171025072717.7svdq4kqlfxlwszi@sigill.intra.peff.net>
        <38a80069-abdb-0646-a20c-eca39dd4f519@samsung.com>
        <CAPig+cRq1AEOgDoXeH-hDMvhEMnfiNK5CuSBbbio-mbHros=QQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Eric, indeed it's better to change the commit message.

25.10.2017 14:53, Eric Sunshine wrote:
> On Wed, Oct 25, 2017 at 7:39 AM, Andrey Okoshkin <a.okoshkin@samsung.com> wrote:
>> Check 'GIT_MERGE_VERBOSITY' environment variable only once in
>> init_merge_options().
>> Consequential call of getenv() may return NULL pointer.
> 
> It would be particularly nice to have a more detailed explanation in
> the commit message of the potential problem this patch is trying to
> solve. Given the amount of discussion, thus far, surrounding such a
> simple patch, this cryptic warning about getenv() returning NULL upon
> second invocation is insufficient to explain why this patch is
> desirable; it merely leads to a lot of head-scratching.
> 
>> However the stored pointer to the obtained getenv() result may be invalidated
>> by some other getenv() call as getenv() is not thread-safe.
> 
> This is even more cryptic, as it appears to be arguing for or against
> _something_ (it's not clear what) and it seems to be talking about a
> facet of the existing code, rather than explaining why the updated
> code consumes its 'merge_verbosity' value as early as possible after
> being assigned. Perhaps this part could be reworded something like
> this:
> 
>     Instead, call getenv() only once, storing its value and
>     consulting it as many times as needed. This update takes care
>     to consume the value returned by getenv() without any
>     intervening calls to getenv(), setenv(), unsetenv(), or
>     putenv(), any of which might invalidate the pointer returned
>     by the initial call.
> 
>> Signed-off-by: Andrey Okoshkin <a.okoshkin@samsung.com>
>> Reviewed-by: Stefan Beller <sbeller@google.com>
> 
> As this patch is semantically quite different from the original to
> which Stefan gave his Reviewed-by: (and which other people argued
> against), it might be better omit this footer and let him re-give it
> if he so desires.
> 
>> ---
>> Changes since the previous patch:
>> * no actions are taken between the merge_verbosity assignment and check.
>>  merge-recursive.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/merge-recursive.c b/merge-recursive.c
>> index 1494ffdb8..60084e3a0 100644
>> --- a/merge-recursive.c
>> +++ b/merge-recursive.c
>> @@ -2163,6 +2163,7 @@ static void merge_recursive_config(struct merge_options *o)
>>
>>  void init_merge_options(struct merge_options *o)
>>  {
>> +       const char *merge_verbosity;
>>         memset(o, 0, sizeof(struct merge_options));
>>         o->verbosity = 2;
>>         o->buffer_output = 1;
>> @@ -2171,9 +2172,9 @@ void init_merge_options(struct merge_options *o)
>>         o->renormalize = 0;
>>         o->detect_rename = 1;
>>         merge_recursive_config(o);
>> -       if (getenv("GIT_MERGE_VERBOSITY"))
>> -               o->verbosity =
>> -                       strtol(getenv("GIT_MERGE_VERBOSITY"), NULL, 10);
>> +       merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
>> +       if (merge_verbosity)
>> +               o->verbosity = strtol(merge_verbosity, NULL, 10);
>>         if (o->verbosity >= 5)
>>                 o->buffer_output = 0;
>>         strbuf_init(&o->obuf, 0);
>> --
>> 2.14.3
> 
> 
> 

-- 
Best regards,
Andrey Okoshkin
