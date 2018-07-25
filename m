Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25D401F597
	for <e@80x24.org>; Wed, 25 Jul 2018 20:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbeGYWKN (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 18:10:13 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:44520 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbeGYWKM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 18:10:12 -0400
Received: by mail-qk0-f194.google.com with SMTP id v17-v6so5820696qkb.11
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 13:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AEtJ5scpjc+Lxb+tNnSfcYIhOmW8bpE3BgI2XxlcNlY=;
        b=BXm7oZnlXcfNJivr7qcdI5RBZSfn/iHb29+JqAVdKMsdbEo/ErC7rzo9ooJ6TuvmG8
         zft+m8lfeIjNb2YM/ZMIB18tAsHsMXr3E+c664pnT3PRRjL5im3cjfpcM1ghkiqDrZBl
         3V5pN3i4U4grlR969h1TZxdtDGCHyv59RrE5RQptHRGK7/10cK/+oB8hU15d2LDI+Yx6
         Wm/pWuDy8uBnnzH/04P6BhIzl+5TGh0LStC0KkUGw63//qPKFWtf8a9/G1a1xC/KagOa
         rbblmOL0YlKfjspWUREaAS4slAlYZA7ylU39JfpILSci2Ji3RWHPvtB3CiAJNVQV+mgF
         epiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AEtJ5scpjc+Lxb+tNnSfcYIhOmW8bpE3BgI2XxlcNlY=;
        b=Pts7UaS60B6+YXFeCWsxLw6jxyCH5lZAi/aFRt4eIm5lpb1VEKGAe9lKf/cuHRyndj
         mTCcn4I9bptzDnb+qYNEGm1c5ISCRQhgHEwKv/7zlCZ/l8vjaxnvNwBMkrNkIHFoAWyy
         j1YyHskB7jMHETgk8tZXsJrf0emxdrQ+cEqhOw2kaaRybZHLvR73m/vHvGr9AqFGL4Uu
         Zti+OGLmlZusqKS5IazYQXRBL5J2wlpQAIypGUCMgIlDMLihmKrUayBwfuB6oWEl4GiR
         tpp3r9gbZuKYaFhmm89242gL2sUDdVt3q74sXJhJtWiTaEp4vuTSfWqGjUYZpAah0TCV
         TeHg==
X-Gm-Message-State: AOUpUlETs6YuFQvqmAlK2wT8aCk7NyjJKhk/jApCLd1AYBsIiAoZnJ7X
        TLznWAexxqJ3mHj80m62ij0=
X-Google-Smtp-Source: AAOMgpdWy6GscSQGDWM9TfyRmiIsA4oFEQEbEz+RDJUV5cgGFj4Ed8vlYsNKqjsgCWT20t6Ev7FisA==
X-Received: by 2002:a37:8c82:: with SMTP id o124-v6mr4587314qkd.84.1532552205908;
        Wed, 25 Jul 2018 13:56:45 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id t1-v6sm9806153qkf.16.2018.07.25.13.56.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 13:56:44 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH v1 0/3] [RFC] Speeding up checkout (and merge, rebase,
 etc)
To:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20180718204458.20936-1-benpeart@microsoft.com>
 <20180718213420.GA17291@sigill.intra.peff.net>
 <a2ad0044-f317-69f7-f2bb-488111c626fb@gmail.com>
 <CACsJy8D-3sSnoyQZKxeLK-2RmpJSGkziAp5Gf4QpUnxwnhchSQ@mail.gmail.com>
 <6ff6fbdc-d9cf-019f-317c-7fdba31105c6@gmail.com>
 <20180724042017.GA13248@sigill.intra.peff.net>
 <CACsJy8Du28jMyfdyhxpVxyw5+Xh+9eX==3x8YJSnmw6GAoRhTA@mail.gmail.com>
Message-ID: <0102d204-8be7-618a-69f4-9f924c4e6731@gmail.com>
Date:   Wed, 25 Jul 2018 16:56:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8Du28jMyfdyhxpVxyw5+Xh+9eX==3x8YJSnmw6GAoRhTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/24/2018 11:33 AM, Duy Nguyen wrote:
> On Tue, Jul 24, 2018 at 6:20 AM Jeff King <peff@peff.net> wrote:
>> At least that's my view of it. unpack_trees() has always been a
>> terrifying beast that I've avoided looking too closely at.
> 
> /me nods on the terrifying part.
> 
>>> After a quick look at the code, the only place I can find that tries to use
>>> cache_tree_matches_traversal() is in unpack_callback() and that only happens
>>> if n == 1 and in the "git checkout" case, n == 2. Am I missing something?
> 
> So we do not actually use cache-tree? Big optimization opportunity (if
> we can make it!).
> 

I agree!  Assuming we can figure out the technical issues around using 
the cache tree to optimize two way merges, another question I'm trying 
to answer is how we can enable this optimization without causing back 
compat issues?

We're discussing detecting that there are no changes for parts of the 
tree between two commits but that isn't the only thing that can trigger 
changes to be made to the index entries and working directory. Changes 
can come from other inputs as well.

One example I am aware of is sparse-checkout.  If you made changes to 
your sparse checkout settings or $GIT_DIR/info/sparse-checkout file, 
that could trigger the need to update index entries and files in the 
working directory.  Since that is a relatively rare occurrence, I can 
see detecting changes to those settings/file and bypassing the 
optimization if there have been changes.  But are there other cases of 
things that could cause unexpected changes in behavior?

One thought I had was to put the optimization behind a config setting so 
that people had to opt-in to the difference in behavior.  I submitted a 
canary patch [1] to test out how receptive people would be to that idea. 
  Hopefully I can get some feedback on that aspect of the patch.

[1] 
https://public-inbox.org/git/ab8ee481-54fa-a014-69d9-8f621b136766@gmail.com/T/#m2a425a23df5e064a79b0a72537a5dd6ccba3b07b

>> Looks like it's trying to special-case "diff-index --cached". Which
>> kind-of makes sense. In the non-cached case, we're thinking not only
>> about the relationship between the index and the tree, but also whether
>> the on-disk files are up to date.
>>
>> And that would be the same for checkout. We want to know not only
>> whether there are changes to make to the index, but also whether the
>> on-disk files need to be updated from the index.
>>
>> But I assume in your case that we've just refreshed the index quickly
>> using fsmonitor. So I think in the long run what you want is:
>>
>>    1. fsmonitor tells us which index entries are not clean
>>
>>    2. based on the unclean list, we invalidate cache-tree entries for
>>       those paths
>>
>>    3. if we have a valid cache-tree entry, we should be able to skip
>>       digging into that tree; if not, then we walk the index and tree as
>>       normal, adding/deleting index entries and updating (or complaining
>>       about) modified on-disk files
> 
> If you tie this optimization to twoway_merge specifically (by checking
> "fn" field), then I think we can do it even better. Since
> cache_tree_matches_traversal() is one (hopefully not too costly)
> lookup, we can do it without checking with fsmonitor or whatever and
> only do so when we have found a cache tree.
> 
> Then if we write this new special code just for twoway_merge, we need
> to tighten the checks a bit. I think in this case twoway_merge() will
> be called with "oldtree" as same as "newtree" (and "current" may
> contains dirty stuff from the index). Then
> 
>   - o->df_conflict_entry should be NULL (because we handle it slightly
> differently in twoway_merge)
>   - "current" should not have CE_CONFLICTED
> 
> then I believe we will fall into case /* 20 or 21 */ where
> merged_entry() is suppoed to be called on all entries and it would
> change nothing in the index since newtree is the same as oldtree, and
> we could just jump over the whole tree in traverse_trees().
> 

I'm fine with tying specific optimizations to twoway_merge as that is a 
very common (if not the most common) merge.

I'm still very new to this part of the code so am trying to figure out 
what you're suggesting.  I've read your description a few times and what 
I'm getting out of it is that with some additional checks (ie verify 
it's a twoway_merge, df_conflict_entry, not CE_CONFLICTED) that we 
should be able to skip the whole tree similar to how Peff demonstrated 
below without having to invalidate the cache tree to reflect modified 
on-disk files.  Is that correct or am I missing something?

>> I think the "n" adds an extra layer of complexity. n==2 means we're
>> doing a "2-way" merge. Moving from tree X to tree Y, and dealing with
>> the index as we go. Naively I _think_ we'd be OK to just extend the rule
>> to "if both subtrees match each other _and_ match the valid cache-tree,
>> then we can skip".
>>
>> Again, I'm a little out of my area of expertise here, but cargo-culting
>> like this:
>>
>> diff --git a/sha1-file.c b/sha1-file.c
>> index de4839e634..c105af70ce 100644
>> --- a/sha1-file.c
>> +++ b/sha1-file.c
>> @@ -1375,6 +1375,7 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
>>
>>          if (oid_object_info_extended(the_repository, &oid, &oi, 0) < 0)
>>                  return NULL;
>> +       trace_printf("reading %s %s", type_name(*type), sha1_to_hex(sha1));
>>          return content;
>>   }
>>
>> diff --git a/unpack-trees.c b/unpack-trees.c
>> index 66741130ae..cfdad4133d 100644
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -1075,6 +1075,23 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
>>                                  o->cache_bottom += matches;
>>                                  return mask;
>>                          }
>> +               } else if (n == 2 && S_ISDIR(names->mode) &&
>> +                          names[0].mode == names[1].mode &&
>> +                          !strcmp(names[0].path, names[1].path) &&
>> +                          !oidcmp(names[0].oid, names[1].oid)
>> +                          /* && somehow account for modified on-disk files */) {
>> +                       int matches;
>> +
>> +                       /*
>> +                        * we know that the two trees have the same oid, so we
>> +                        * only need to look at one of them
>> +                        */
>> +                       matches = cache_tree_matches_traversal(o->src_index->cache_tree,
>> +                                                              names, info);
>> +                       if (matches) {
>> +                               o->cache_bottom += matches;
>> +                               return mask;
>> +                       }
>>                  }
>>
>>                  if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
>>
>> seems to avoid the tree reads when running "GIT_TRACE=1 git checkout".
>> It also totally empties the index. ;) So clearly we have to do a bit
>> more there. Probably rather than just bumping o->cache_bottom forward,
>> we'd need to actually move those entries into the new index. Or maybe
>> it's something else entirely (I did say cargo-culting, right?).
> 
> Ah this cache_bottom magic. I think this is Junio's alley ;-)
> 
>> -Peff
