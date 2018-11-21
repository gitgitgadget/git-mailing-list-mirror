Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 929261F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 15:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbeKVC0Q (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 21:26:16 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:59867 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbeKVC0P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 21:26:15 -0500
Received: from [192.168.2.240] ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id PUlJgDljYVlGZPUlJgkkuh; Wed, 21 Nov 2018 15:50:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1542815452;
        bh=9clP6NGqJJgURXrG3ryRvVdvQPL3NoODSC/MDBmYrns=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XMmh1XvTSuwxF3nI7+Ad6Y58q5gPr9bELmO+fqxl95D3uGYn4mCFwKKb59L9LY/Me
         FGIZw2ehfO4yTgftqgmqdi+UT5fQIhierulnrT2htRCAp3nrvC0VXeys5w0CEXw7eh
         N1NGnVc9jQ9idPvi77MwYNwe8dBMnzEznhIFI9nU=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=299revIyKBDuXsupKVkA:9 a=3PYLWqrpnDGNrlSg:21
 a=Te6qA4tG7lURTuCR:21 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v1 9/9] diff --color-moved-ws: handle blank lines
To:     Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git <git@vger.kernel.org>
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20181116110356.12311-1-phillip.wood@talktalk.net>
 <20181116110356.12311-10-phillip.wood@talktalk.net>
 <CAGZ79kYm-uNWi-3=0fG=PfA3HbT7tKwER=r8fm6UFiy3P=JEmA@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <ef49bb0e-cf03-a707-f562-595564bd70d8@talktalk.net>
Date:   Wed, 21 Nov 2018 15:49:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYm-uNWi-3=0fG=PfA3HbT7tKwER=r8fm6UFiy3P=JEmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBIf64PI2lidv7O4wcZb18DkcCZ+nZjY30nzJJXaMStMYpWtX0Wi8OA6GtlHA3P7lnvkWPpSsj78ShTertopR3KDhjXGEMemDoz2NI3ScFX3gmBR2sdh
 vDa+i+yADf/va3hqOXYuYlE1zRVxQdYUXAa0BOvn2tOqMB6ctSkooWPR97STvrOdbd9zk4LoUwIQtP85Ge34Fbu8OpA4+ZvLxRONqmGt2Nj69/TQMGqoxi+m
 hicYhWpGKH/2WmD6nUfyIw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/11/2018 18:05, Stefan Beller wrote:
> On Fri, Nov 16, 2018 at 3:04 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> When using --color-moved-ws=allow-indentation-change allow lines with
>> the same indentation change to be grouped across blank lines. For now
>> this only works if the blank lines have been moved as well, not for
>> blocks that have just had their indentation changed.
>>
>> This completes the changes to the implementation of
>> --color-moved=allow-indentation-change. Running
>>
>>    git diff --color-moved=allow-indentation-change v2.18.0 v2.19.0
>>
>> now takes 5.0s. This is a saving of 41% from 8.5s for the optimized
>> version of the previous implementation and 66% from the original which
>> took 14.6s.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>
>> Notes:
>>      Changes since rfc:
>>       - Split these changes into a separate commit.
>>       - Detect blank lines when processing the indentation rather than
>>         parsing each line twice.
>>       - Tweaked the test to make it harder as suggested by Stefan.
>>       - Added timing data to the commit message.
>>
>>   diff.c                     | 34 ++++++++++++++++++++++++++++---
>>   t/t4015-diff-whitespace.sh | 41 ++++++++++++++++++++++++++++++++++----
>>   2 files changed, 68 insertions(+), 7 deletions(-)
>>
>> diff --git a/diff.c b/diff.c
>> index 89559293e7..072b5bced6 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -792,9 +792,11 @@ static void moved_block_clear(struct moved_block *b)
>>          memset(b, 0, sizeof(*b));
>>   }
>>
>> +#define INDENT_BLANKLINE INT_MIN
> 
> Answering my question from the previous patch:
> This is why we need to keep the indents signed.
> 
> This patch looks quite nice to read along.
> 
> The whole series looks good to me.

Thanks

> Do we need to update the docs in any way?

I'm not sure, at the moment it does not make any promises about the 
exact behavior of --color-moved-ws=allow-indentation-change, we could 
change it to be more explicit but I'm not sure it's worth it.

Thanks for looking over these patches, I'll post a reroll soon based on 
your comments.

Phillip

> Thanks,
> Stefan
> 

