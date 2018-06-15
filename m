Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E22371F517
	for <e@80x24.org>; Fri, 15 Jun 2018 18:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756400AbeFOSXr (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 14:23:47 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:44881 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756214AbeFOSXq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 14:23:46 -0400
Received: by mail-qt0-f170.google.com with SMTP id l33-v6so9870795qta.11
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 11:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2nLjVi94vmNi0ysMB8ImiteF6wjHgghKmsBBHvB014w=;
        b=b3gac7xjWrtfKh+b/hriva4vqKkz2XAJ1oy6/ktBZnWyd4SrjCqVxM0hgD25EOH19o
         LkG6HbgTYp5Gg2wJyUiiUSmkx4v0UwzLH71txQUZsChUprE7YMqSdER041LWbwzZ6Ld9
         zVo36UK6DdbJjizdSzHHOEJ28up2oA0kJpY6qxYXHMmFWlxjaS1cWatmdR9ooi6HMpfj
         UX9qyZTsIqoFVuRSD0huAJmdozWFnC6Pm/122DFkr9nmtapDWPMHdGku9gms/zN0r0y0
         6jxMZLvIDhhxd3XzGZa4FoHJdb7ETIDqB3If3Ya6YE81N50dYrl9YnjBtDitMdrzx07N
         ZTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2nLjVi94vmNi0ysMB8ImiteF6wjHgghKmsBBHvB014w=;
        b=dUz6CIsPox0vntmxgFChKV3b0vGlnJz/m1guPlc1d3ffb3o6r0Q0qcZ+OsWSPEKQWh
         Md7Nqww56qrNn7N2LvliU1sHCzhMAqmZfLZ3B/kp+vqhPxYuo+SKgXAF+8wf93zC5QAk
         6BA2D6qD579nsnI0rRrTnmax5RqtDrucdM7WeJG6bop0+ctESsiF9KG5X8FmKZdnPWV1
         oquFWSjt0rZ91MIPzqahRG+wnKiyxz2dvqi+3iGopi0OMZ1QlsuIlhnRPpfEck+LpUrj
         5q/3RFXOywnmickGFNApHFgtkCuisTsuSe/TfnAisXLMut4FfKViCSfDoMtnxCKz41W7
         4pyQ==
X-Gm-Message-State: APt69E0jhId075/CUVS8ibM68KGiTANvODg8+fNeEskIRRgRN548oX/z
        fG7YxY+7dX50UUefM6Q5CiPHpHbD
X-Google-Smtp-Source: ADUXVKIIj9vdBnhb14ZSjctJtJqXqQclB9/7bmG1/L1y52b1fAl3csdPa3g1fsFu8X6TGhb8Hvkv4g==
X-Received: by 2002:a0c:8047:: with SMTP id 65-v6mr2423600qva.226.1529087025800;
        Fri, 15 Jun 2018 11:23:45 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:936:68f2:e294:88e9? ([2001:4898:8010:0:f26b:68f2:e294:88e9])
        by smtp.gmail.com with ESMTPSA id w25-v6sm6729751qtc.21.2018.06.15.11.23.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 11:23:45 -0700 (PDT)
Subject: Re: [PATCH 4/3] ewah: adjust callers of ewah_read_mmap()
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Luat Nguyen <root@l4w.io>, git@vger.kernel.org
References: <2067D731-C415-4D19-8CDA-90D7DC638397@l4w.io>
 <20180615032850.GA23241@sigill.intra.peff.net>
 <20180615034442.GA14422@sigill.intra.peff.net>
 <f6931351-df79-cb76-ee29-c57472a6a201@gmail.com>
 <xmqq1sd82e9h.fsf@gitster-ct.c.googlers.com>
 <20180615173155.GC3067@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1685a358-f033-64e0-2e12-df3a1c10af19@gmail.com>
Date:   Fri, 15 Jun 2018 14:23:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615173155.GC3067@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/15/2018 1:31 PM, Jeff King wrote:
> On Fri, Jun 15, 2018 at 09:41:46AM -0700, Junio C Hamano wrote:
>
>> Derrick Stolee <stolee@gmail.com> writes:
>>
>>> On 6/14/2018 11:44 PM, Jeff King wrote:
>>>> The return value of ewah_read_mmap() is now an ssize_t,
>>>> since we could (in theory) process up to 32GB of data. This
>>>> would never happen in practice, but a corrupt or malicious
>>>> .bitmap or index file could convince us to do so.
>>> Aside: Why a 32GB limit? Usually I see 32-bit issues limiting by 2
>>> (signed) or 4 GB (unsigned). Is there something specifically in the
>>> bitmap format that stops at this size?
>> The proposed log message for 1/3 has this bit
>>
>>    - check the size for integer overflow (this should be
>>      impossible on 64-bit, as the size is given as a 32-bit
>>      count of 8-byte words, but is possible on a 32-bit
>>      system)
>>
>> 4 Giga 8-byte words makes 32 Giga bytes, I'd guess.
> Yes, exactly. It's definitely an odd size. I think using the same
> varints we use in the packfile would be more efficient (and they're
> already variable-length records), though we tend to have few enough of
> these that it probably doesn't matter.
>
> I think a more useful change for the bitmap format would be some kind of
> index. IIRC, right now readers have to linearly scan the whole file in
> order to use a single bitmap.
>
> With Stolee's commit-metadata files, we could potentially move to
> storing reachability bitmaps as a data element there. But there are two
> complications:
>
>   - the bitmaps themselves are dependent on having an ordered list of
>     objects (one per bit) to talk about. And that's why they're
>     integrated with packfiles, since that provides a constrained universe
>     with a set ordering.
>
>   - the existing storage isn't entirely independent between bitmaps. Some
>     of them are basically "deltas" off of nearby bitmaps.

The VSTS reachability bitmap is different from the Git bitmap in a few ways.

1. It uses Roaring+Run bitmaps [1] instead of EWAH bitmap. This format 
is simpler (in my opinion) in several ways, especially in how it splits 
the bitmap into 16-bit address ranges and compresses each on its own. 
This makes set containment queries much faster, as we can navigate 
directly to the region that is important (and then binary search if that 
chunk is an "array" or "run" chunk). I say this is simpler because I can 
explain the entire compression format to you in five minutes and a 
whiteboard. The paper [2] is a simple enough read (start at the "Roaring 
Bitmap" section at the end of page 4).

2. Our file uses a chunk-based approach similar to the commit-graph 
file: one chunk is simply a list of the commits that have bitmaps. 
Another chunk is the raw binary data of all bitmaps concatenated 
together. The last chunk connects the other two chunks by a) providing 
an offset into the binary data for the bitmap at that commit, and b) the 
commit that provides a delta base for the bitmap.

If we are considering changing the reachability bitmap, then I'm very 
intrigued. I think the number one thing to consider is to use the 
multi-pack-index as a reference point (with a stable object order) so 
the objects can be repacked independently from the reachability bitmap 
computation. If we are changing the model at that level, then it is 
worth thinking about other questions, like how we index the file or how 
we compress the bitmaps.

Thanks,
-Stolee

[1] https://roaringbitmap.org/about/

[2] https://arxiv.org/abs/1603.06549
     Consistently faster and smaller compressed bitmaps with Roaring
