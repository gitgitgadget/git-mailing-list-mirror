Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C46C2D0E4
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 18:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E12A522227
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 18:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZp+pYCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgKLSja (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 13:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgKLSja (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 13:39:30 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DDCC0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 10:39:30 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 79so6557682otc.7
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 10:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XRL1LEVRT44Tc+rllNRsaVIEEu39r+bBw6vspFWPkPc=;
        b=vZp+pYCWLiZPGvxaV/Y9Xb0bMcwnkVF490TBnJFYCqlvzTbxeDCoQ5F8129dSe3Yc1
         EaHP4uH03w7jBL07IQ6yY8yCvzhHVkI3cqZkAPvra+d8lhdTq8NQy9DEvfFB+uKfpKE+
         9DvYIff8kZlh+x/QE2b/uJZpXsuBa7u+hXq9qjjT/wu+gG6UTuMcZU3fD4ac+goXJz+9
         gsizvOssvbgGKbGXDe151DywVMDdBHgWHRebVV182rSrQs8anKMbv9O7gLFX0337x1qu
         vKKhH3oovVMXUon1wK6npSBjRHtemh39A46JAkVtP/iCuDcvVLopigL+o97Zsxav/5+J
         MTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XRL1LEVRT44Tc+rllNRsaVIEEu39r+bBw6vspFWPkPc=;
        b=JWZmQfcMMDSJwKG1m2DqvfNDW6s9wJYZuju/8CXMnlNWSaoYL9MD6uaXObSBObbUPA
         5dp/zNhEJcXFF4qvbNyaC6c/82VqKj1plS0Cdak+oVeEGeXl+/C5qgUEafcs4l5SFJmM
         sAVs64kUjuibJTbztVSVgLtlrd2RE8A7zqu5dG9zuzZPjXpH3qUr5TLcPPfi9RkiIog0
         /c6Iuo8sIw+Pnf6liVVeBunTMfbvkWucM/z/SSjZFvAIBKlk+GjIILwupNdNe6oJcn2H
         xTEQNlXDXbh8607NBTz5Pv9MEgpgJt2EVIxIOg+PQ3H9fMiV0oc5ASo6cPFLoIMobrf9
         P9ZQ==
X-Gm-Message-State: AOAM533U8uZl9VlxBBwIQ1BBe6wHd9FCoDVpJziCBw4LSHQ9HQ/TAaGk
        YU8+vTBW+UDXcaB5Qrik/t6CfZ3XkLqZrQ==
X-Google-Smtp-Source: ABdhPJzCAdfy2CeSIRR/+lfow/3N31lj5zrNtoCJ4ofs3Vae63OP08JpKVXI2HkIpPReN4Wt+IusOg==
X-Received: by 2002:a9d:e95:: with SMTP id 21mr422130otj.256.1605206368799;
        Thu, 12 Nov 2020 10:39:28 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:30c9:afaa:d787:e592? ([2600:1700:e72:80a0:30c9:afaa:d787:e592])
        by smtp.gmail.com with UTF8SMTPSA id x63sm1284650oif.37.2020.11.12.10.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 10:39:28 -0800 (PST)
Subject: Re: [PATCH v2 09/20] merge-ort: record stage and auxiliary info for
 every path
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20201102204344.342633-1-newren@gmail.com>
 <20201102204344.342633-10-newren@gmail.com>
 <94bf9b69-5d13-c914-fb1a-bce912018a63@gmail.com>
 <CABPp-BFRPuxLYz_n6jbr=j7Gu1GhsV95nKPE1=HxUcsvimrz0g@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <306958b5-030a-8653-a997-0bf6ad1d7d4b@gmail.com>
Date:   Thu, 12 Nov 2020 13:39:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFRPuxLYz_n6jbr=j7Gu1GhsV95nKPE1=HxUcsvimrz0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/11/2020 1:16 PM, Elijah Newren wrote:
> On Wed, Nov 11, 2020 at 7:26 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 11/2/2020 3:43 PM, Elijah Newren wrote:
>>> +static void setup_path_info(struct merge_options *opt,
>>> +                         struct string_list_item *result,
>>> +                         const char *current_dir_name,
>>> +                         int current_dir_name_len,
>>> +                         char *fullpath, /* we'll take over ownership */
>>> +                         struct name_entry *names,
>>> +                         struct name_entry *merged_version,
>>> +                         unsigned is_null,     /* boolean */
>>> +                         unsigned df_conflict, /* boolean */
>>> +                         unsigned filemask,
>>> +                         unsigned dirmask,
>>> +                         int resolved          /* boolean */)
>>> +{
>>> +     struct conflict_info *path_info;
>>
>> In addition to my concerns below about 'conflict_info' versus
>> 'merged_info', I was doubly confused that 'result' in the parameter
>> list is given a variable named 'pi' for "path info" and result->util
>> eventually is equal to this path_info. What if we renamed 'result'
>> to 'pi' for "path info" here, then operated on 'pi->util' in this
>> method?
> 
> result->util (or pi->util if you rename) is void *, making it hard to
> operate on; you'd have to typecast at every usage.  Since it is used a
> *lot*, it makes sense to have a typed pointer, and then just set
> result->util to a copy of that value at the end.  That is what
> path_info is for.

Good point. I need to be more careful thinking about types during
review.

>>
>>> +     path_info = xcalloc(1, resolved ? sizeof(struct merged_info) :
>>> +                                       sizeof(struct conflict_info));
>>
>> Hm. I'm happy to have a `struct merged_info *` pointing to a
>> `struct conflict_info`, but the opposite seems very dangerous.
> 
> Yeah, this is perhaps the scariest bit, and if it were a side data
> structure rather than the fundamental main one that was central to the
> algorithm, then safety would trump performance concerns.  But since it
> is the main data structure and likely the biggest (once you count the
> various copies for each relevant path), then it might be worth the
> extra care needed to shave off the extra memory.  Maybe we can still
> tweak things to get some safety back without killing performance so
> let me consider each of your suggestions/questions.
> 
> If I define it as a merged_info*, the compiler will only let me modify
> fields within the merged_info portion of the struct.  Should I
> typecast every line that touches the bits in the resolved==0 path
> where I need to set fields within the conflict_info portion?
> Alternatively, would a code flow like the following make you happier?
> 
>     struct conflict_info *ci = NULL;
>     struct merge_info *mi = xcalloc(...);
>     result->util = mi;
>     /* Operate on mi */
>     ...
>     if (resolved)
>       return;
>    ci = mi;
>    /* Operate on ci */
>    ...
> 
> In either case, the returned item has potentially different sizes, so
> the caller will still have to take care so I'm not sure how much extra
> this structure within setup_path_info() buys us.

There might be good reason to use this example. Specifically,
always first cast into a 'struct merge_info *mi' then check
'mi->clean' before casting into 'struct conflict_info *ci'. It
definitely helps that something within the smaller memory
footprint gives an indicator as to whether the larger struct
should exist.
 
>> Perhaps we should always use sizeof(struct conflict_info)?
> 
> We could do that; it'd certainly waste memory as I expect many entries
> to be unmodified (on one or both sides of history).  But I'd way
> rather go this route than splitting or re-arranging this data
> structure.

Yes, I agree exactly on this.

>> We can use path_info->merged.clean to detect whether the rest of
>> the data is worth looking at. (Or, in your case, whether or not
>> it is allocated.)
> 
> ci->merged.clean is used to determine whether to look at the rest of
> the data, yes -- and that's an enforced assumption throughout the code
> (as alluded to by the comment in the merge_options_internal data
> structure that "paths" maps pathanemes to merge_info and conflict_info
> types).  However, that is not quite the same as using the clean bit to
> determine if more data is allocated; something can be allocated as a
> conflict_info rather than a merged_info due to both sides making
> modifying the same path, but then a threeway content merge comes back
> clean and ci->merged.clean is updated from 0 to 1.  The extra data
> remains allocated, but nothing in the algorithm ever needs to use
> anything outside the merged bits for that path again.  (Actually, let
> me state that more forcefully: nothing is *allowed* to look outside
> the merged bits for that path once the clean bit is updated to 1).

Ok, so the two-stage casting (merge_info then conflict_info) would
still work even after the clean bit is enabled eventually. This assumes
that the threeway content merge data is cleaned up before losing
the conflict_info pointer.

>> I imagine that in a large repo we will need many of these structs,
>> but very few of them will actually need to be conflicts, so using
>> 'struct conflict_info' always will lead to memory bloat. But in
>> that case, would we not be better off with an array instead of a
>> scattering of data across the heap?
> 
> Not sure what you're trying to solve here.  Putting them in an array
> would mean copying every single one of them every time the array is
> resized.  It would also make insertion or deletion very expensive.
> And it'd prevent O(1) lookup.  It'd be a horrible data structure all
> around.  Maybe you're assuming you know exactly how many entries you
> need and what they are before the merge algorithm starts?  I don't.
> In fact, I can't even give a good magnitude approximation of how many
> it'll be before a merge starts.  (Even if you assume it's a case where
> you have an index loaded and that index is related to the merge being
> done, the number can be and often is much smaller than the number of
> entries in the index.  And just to cover the extremes, in unusual
> cases the number might be much larger than the number of index entries
> if the merge base and side being merged in has far more paths).

Yeah, I was mostly thinking about pooling allocations to reduce memory
fragmentation. But its likely that we don't need to do that, or rather
you are already doing some of that in the strmap structure.

> This was the whole point of the strmap API[1] I recently added --
> provide a hashmap specialized for the case where the key is a string.
> That way I get fast lookup, and relatively fast resize as the hash
> only contains pointers to the values, not a copy of the values.
> 
> Is your concern that allocating many small structs is more expensive
> than allocating a huge block of them?  If so, yes that matters, but
> see the mem_pool related patches of the strmap API[1].
> 
> [1] https://lore.kernel.org/git/pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com/

It appears that you already do some mempool stuff there [2], so I'm sure
you know more about how to optimize memory here. My initial reaction of
"that's a lot of calloc()s" could easily be punted to a later improvement
_if_ it is valuable at all.

[2] https://lore.kernel.org/git/3926c4c97bd08aac93d3f521273db9d76b4d5cd3.1605124942.git.gitgitgadget@gmail.com/

>> Perhaps 'struct conflict_info' shouldn't contain a 'struct merged_info'
>> and instead be just the "extra" data. Then we could have a contiguous
>> array of 'struct merged_info' values for most of the paths, but heap
>> pointers for 'struct conflict_info' as necessary.
>>
>> It's also true that I haven't fully formed a mental model for how these
>> are used in your algorithm, so I'll keep reading.
> 
> I don't understand how contiguous arrays are practical or desirable
> (I'm close to saying they're not possible, but one could employ some
> extremes to get them, as mentioned above).
> 
> I could possibly have two strmaps; one mapping paths to a merge_info,
> and another (with fewer entries) mapping paths to a conflict_info.
> Seems like a royal pain, and would make for some pretty ugly code (I
> have other places that had to use two strmaps and I've hated it every
> time -- but those were cases of strmaps that were used much, much less
> than the "paths" one).  Might also slightly hurt perf

I am convinced that the alternatives are harder to implement with no
clear benefit.

>>> +     path_info->merged.directory_name = current_dir_name;
>>> +     path_info->merged.basename_offset = current_dir_name_len;
>>> +     path_info->merged.clean = !!resolved;
>>> +     if (resolved) {
>>> +             path_info->merged.result.mode = merged_version->mode;
>>> +             oidcpy(&path_info->merged.result.oid, &merged_version->oid);
>>> +             path_info->merged.is_null = !!is_null;
>>> +     } else {
>>> +             int i;
>>> +
>>> +             for (i = 0; i < 3; i++) {
>>> +                     path_info->pathnames[i] = fullpath;
>>> +                     path_info->stages[i].mode = names[i].mode;
>>> +                     oidcpy(&path_info->stages[i].oid, &names[i].oid);
>>> +             }
>>> +             path_info->filemask = filemask;
>>> +             path_info->dirmask = dirmask;
>>> +             path_info->df_conflict = !!df_conflict;
>>> +     }
>>> +     strmap_put(&opt->priv->paths, fullpath, path_info);
>>> +     result->string = fullpath;
>>> +     result->util = path_info;
>>
>> This is set in all cases, so should we use it everywhere? Naturally,
>> there might be a cost to the extra pointer indirection, so maybe we
>> create a 'struct conflict_info *util' to operate on during this
>> method, but set 'result->util = util' right after allocating so we
>> know how it should behave?
> 
> result->util is void*, so it's not just an extra pointer indirection,
> it's also the need to cast it to the appropriate type every time you
> want to use it.  It's easier to have that done via another copy of the
> pointer with the correct type, which is the reason for path_info.  So,
> essentially, I did use util everywhere, it's just that I spelled it as
> "path_info".  If I had named "path_info" "util" as you suggest,
> wouldn't everyone be annoyed that I used a lame name that didn't name
> the variable's purpose?
> 
> Perhaps I should just add a comment saying that path_util is a typed
> alias/copy of result->util when I define it?

A comment wouldn't hurt.

>>> @@ -91,10 +136,12 @@ static int collect_merge_info_callback(int n,
>>>        */
>>>       struct merge_options *opt = info->data;
>>>       struct merge_options_internal *opti = opt->priv;
>>> -     struct conflict_info *ci;
>>> +     struct string_list_item pi;  /* Path Info */
>>> +     struct conflict_info *ci; /* pi.util when there's a conflict */
> 
> Perhaps here I should mention that ci is just a typed copy of pi.util
> (since pi.util is a void*).
> 
>> ...
>>
>>> +     setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
>>> +                     names, NULL, 0, df_conflict, filemask, dirmask, 0);
>>> +     ci = pi.util;
>>
>> Here is the use of 'pi' that I was talking about earlier.
> 
> ...although, to be fair, I don't actually have all that many uses of
> ci (at least not anymore) in this function.  So maybe typecasting
> pi.util each of the three-or-so times it is used isn't so bad?
 
While I usually use "three is many" for justifying extracting
duplicated code, for casting issues I usually think "two is
too many" is appropriate. Keep 'ci'.

Thanks,
-Stolee
