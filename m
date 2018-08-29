Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 129071F404
	for <e@80x24.org>; Wed, 29 Aug 2018 21:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbeH3Blu (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 21:41:50 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:37129 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeH3Blt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 21:41:49 -0400
Received: by mail-qt0-f174.google.com with SMTP id n6-v6so7582739qtl.4
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 14:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0pk40eaGBIEGgIbtMOgrTQJrP3HWJSESjRk0CytYpQg=;
        b=GbvOSOz72d15YbIWXwBxKbiqrViIv/yoqp4XCOew25oB0AzLheQhX/A3TZk9gErb72
         aEFzAVfdGa7+WRvHDTLA9TeptqeLd2tRMJL1fSiy6zy5yoNWFiCVhSFqKVdI7fKavtUs
         RNpup5Zodt0BD9pX/J/oPvy2ldytndg0oyGrNW0MIyi7yFR+IDKi+jAu7VsCA2Qc9rJr
         nzRn5gR0Fb/qVAjAbA8jxGXyVBTUMXpDJeBJpV3d/XeBStjAO1fy36oL+RfbMGymCY9H
         ewo8m1x3/BZgYYhLAheKnIL1xfpXvTclX088LcegxvKYfMakMUnFJlyuAtPNo0t8g6Li
         kTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0pk40eaGBIEGgIbtMOgrTQJrP3HWJSESjRk0CytYpQg=;
        b=lRfcssF6x9OQiCS900712G/w6br8BGoKEc+L/nhD0teI6BH1MpBe7YZuWlq6zOP4/l
         9+BETBGxpTgkiNGG61pgHT6QTGcg4VSLQUmxUzUc9UI1i9DcckbgTYDQg77KO6KBBSSx
         G2cTqWn8One5GyZ189vF8qbj4FLIYqSO7SC7DkNgMq1xeSnEAvqMRGdNqNmfL1Samj+B
         V5Oe6bAvez9doUZZLIbfsa8+n80BYRirUyp59/jH1iz2ureH6SaIJ3VhnknKoB8QHP/1
         ffUy8h32UnirI+vnUC0pXoRx6eHlReflQxl5qH9u2bZVGZCJ28w+ph0gGNFji4OTBxbL
         d55g==
X-Gm-Message-State: APzg51CtMb5fg4juVLTm/VEjjN0hupMQSHxyhlyuppgjwQ8JjHC6SRNp
        3//XPrg2GCnvUEtMVBMYYF/GE9AV
X-Google-Smtp-Source: ANB0Vdag2VT3drXQTdOK79WI2JTP8cPl6ji8LANvvCsB3kKMHTXRjZLCnV6DL0gluWrNC3lg3arnpA==
X-Received: by 2002:a0c:e74c:: with SMTP id g12-v6mr8536383qvn.118.1535578978512;
        Wed, 29 Aug 2018 14:42:58 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id r7-v6sm3297902qkh.83.2018.08.29.14.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 14:42:57 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] read-cache: load cache extensions on worker thread
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180829152500.46640-1-benpeart@microsoft.com>
 <20180829152500.46640-3-benpeart@microsoft.com>
 <xmqqk1o9cd18.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <606bb7e9-0d58-ec86-6a3c-8a123679f9f4@gmail.com>
Date:   Wed, 29 Aug 2018 17:42:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqk1o9cd18.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/29/2018 1:12 PM, Junio C Hamano wrote:
> Ben Peart <Ben.Peart@microsoft.com> writes:
> 
>> This is possible because the current extensions don't access the cache
>> entries in the index_state structure so are OK that they don't all exist
>> yet.
>>
>> The CACHE_EXT_TREE, CACHE_EXT_RESOLVE_UNDO, and CACHE_EXT_UNTRACKED
>> extensions don't even get a pointer to the index so don't have access to the
>> cache entries.
>>
>> CACHE_EXT_LINK only uses the index_state to initialize the split index.
>> CACHE_EXT_FSMONITOR only uses the index_state to save the fsmonitor last
>> update and dirty flags.
> 
> Good to see such an analysis here.  Once we define an extension
> section, which requires us to have the cache entries before
> populating it, this scheme would falls down, of course, but the
> extension mechanism is all about protecting ourselves from the
> future changes, so we'd at least need a good feel for how we read an
> unknown extension from the future with the current code.  Perhaps
> just like the main cache entries were pre-scanned to apportion them
> to worker threads, we can pre-scan the sections and compare them
> with a white-list built into our binary before deciding that it is
> safe to read them in parallel (and otherwise, we ask the last thread
> for reading extensions to wait until the workers that read the main
> index all return)?
> 

Yes, when we add a new extension that requires the cache entries to 
exist and be parsed, we will need to add a mechanism to ensure that 
happens for that extension.  I agree a white list is probably the right 
way to deal with it.  Until we have that need, it would just add 
unnecessary complexity so I think we should wait till it is actually needed.

There isn't any change in behavior with unknown extensions and this 
patch.  If an unknown extension exists it will just get ignored and 
reported as an "unknown extension" or "die" if it is marked as "required."

I'll fix the rest of your suggestions - thanks for the close review.
