Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88AC41F406
	for <e@80x24.org>; Sat, 12 May 2018 12:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750842AbeELMJu (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 08:09:50 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:42520 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbeELMJt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 08:09:49 -0400
Received: by mail-ot0-f193.google.com with SMTP id l13-v6so9263439otk.9
        for <git@vger.kernel.org>; Sat, 12 May 2018 05:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZcV5kv+auilRdCwf4jwN++4rGEHcI940MEuKt945SZg=;
        b=vVtEXQSY5wUh0symap+5wIBTSfW6o+R1C8lfkmmH3scAZX5STqgZsLcD6XkblsSQE2
         GOa+AV6HLV8uUtLvO6cwb6f51Ei35iYffeFP1spx+PjBVee3SRXiFlyAaSaO4oWPBk6v
         uv9iVNd9FYJs7cRHc0sEvtfenIvb/PsRON0i8Y6IOIKADOOl48GQwa5DMInKZ73RXtfY
         PHiHD3f8XxgUyxmcYSTegE4tAffaOi59Zyv5Rogf/H0oQdBNY3rmhM0PEg93iYcuciYZ
         MzBfToEvHym1suhomNRD3Tz75BLPWsGWT1GF0zEAwGwhMfH6oQd5sYuJJHdV8/bgbdie
         xvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZcV5kv+auilRdCwf4jwN++4rGEHcI940MEuKt945SZg=;
        b=uL/IVOwXZT3OeEOpTVTsjQDE/AzAv12xJxdtKnnAByIsoJ68ISB4iXjRWKq1Jd6p4H
         CgH9sA9lBPqUzo5+VPDSuDB0IZK01pJl5408KXy7crVIhH7fmiW4OFB7e8fEm0fMA1Xi
         h4C8Sz/vy8IYmJ++uGXd/rNmYS3XteFIwjkwXg8kD6ECBJWR1uRcDRGPtphB1ZU83Ris
         Ikcf+hSqKUA344FGr4nxJoHaW6HXKv15ztZW54+70FA5RAvEPp0zo4u9mATVN57M9WUp
         uQLT6nZ4sqIIC8JN3GhlbVbThz5YkEJ0DP3Y66WAErBm4fBRJSGoB+WDOTeZ3wQXQDU7
         Ldkw==
X-Gm-Message-State: ALKqPwc1uRSKWXKjoIwyG6TxWSAz8eDN6Z3XjTGY1Un1ucl7hIJYtbO5
        WO+PXtTtfMXoZ4RRcYDg1JurzIOv0p+0NIRw8m4=
X-Google-Smtp-Source: AB8JxZruSUO2aQwUsfZne4og8fxMQMy4oMZukHoHYAo5B8rSGj4SOh8f3ucAJ4sqw+lRBXgqREBBlrRLC6AAHwuGoVw=
X-Received: by 2002:a9d:4197:: with SMTP id p23-v6mr1473250ote.75.1526126988849;
 Sat, 12 May 2018 05:09:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Sat, 12 May 2018 05:09:18 -0700 (PDT)
In-Reply-To: <20180512091809.GC28279@sigill.intra.peff.net>
References: <20180512080028.29611-1-pclouds@gmail.com> <20180512080028.29611-4-pclouds@gmail.com>
 <20180512090748.GB28279@sigill.intra.peff.net> <20180512091809.GC28279@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 12 May 2018 14:09:18 +0200
Message-ID: <CACsJy8ByKPSGR=Y+6y+bLBxq97M2EiZERMwZ9BGmJHYj7R0d3Q@mail.gmail.com>
Subject: Re: [PATCH 03/12] shallow.c: use commit-slab for commit depth instead
 of commit->util
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 12, 2018 at 11:18 AM, Jeff King <peff@peff.net> wrote:
> On Sat, May 12, 2018 at 05:07:48AM -0400, Jeff King wrote:
>
>> So no, it wouldn't work to directly store depths with the code as
>> written.  I'm not sure if the depth can ever be 0. If not, then it would
>> be a suitable sentinel as:
>>
>>   int *slot = commit_depth_at(&depths, p->item);
>>   if (!*slot || cur_depth < *slot)
>>       *slot = cur_depth;
>>
>> But somebody would have to dig into the possible values of cur_depth
>> there (which would make sense to do as a separate patch anyway, since
>> the point of this is to be a direct conversion).
>
> By the way, one other approach if xcalloc() doesn't produce a good
> sentinel is to use a data type that does. ;) E.g., something like this
> should work:
>
>   struct depth {
>         unsigned valid:1;
>         int value;
>   };
>   define_commit_slab(commit_depth, struct depth);
>
>   ...
>
>   struct depth *slot = commit_depth_at(&depths, p->item);
>   if (!slot->valid || cur_depth < slot->value) {
>         slot->value = cur_depth;
>         slot->valid = 1;
>   }
>
> That wastes an extra 4 bytes per slot over storing an int directly, but
> it's the same as storing an 8-byte pointer, plus you avoid the storage
> and runtime overhead of malloc.

Or we could have a way to let the user decide initial values. If the
initial value here is -1 (which can't possibly be used in the current
code), it could be the sentinel value.

Did you notice the for loop in the end to free "int *"? I don't like
peeking inside a slab that way and would prefer passing a "free"
function pointer to clear_commit_depth(), or just assign a "free"
function to some new field in struct commit_depth and
clear_commit_depth() will call it. If we have a new field for "free"
callback in the struct, it makes sense to have an "init" callback to
do extra initialization on top of xcalloc.

> I actually wonder if we could wrap commit_slab with a variant that
> stores the sentinel data itself, to make this pattern easier. I.e.,
> something like:
>
>   #define define_commit_slab_sentinel(name, type) \
>         struct name##_value { \
>                 unsigned valid:1; \
>                 type value; \
>         }; \
>         define_commit_slab(name, struct name##_value)
>
> and some matching "peek" and "at" functions to manipulate value
> directly.

If you keep this valid bit in a separate slab, you can pack these bits
very tight and not worry about wasting memory. Lookup in commit-slab
is cheap enough that doing double lookups (one for valid field, one
for value) is not a problem, I think.

> I think the end result would be nicer, but it's turning into a little
> bit of a rabbit hole. So I don't mind going with your direct conversion
> here for now.

Yeah I think I will stick with a faithful conversion for now. The
conversion shows room for improvement which could be the next
microproject (I thought of adding this removing 'util' task as a 2019
microproject but it was too tricky for newcomers to do).
-- 
Duy
