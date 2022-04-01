Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB19C433F5
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 15:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348532AbiDAPFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351410AbiDAPCU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 11:02:20 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03DB185963
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 07:49:28 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9so2075199ilu.9
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 07:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AaU25a8UfJb4Z/9D4FWuv4hK3ee4l67g85BxXopszWA=;
        b=eTxgkgwK0bLlOkd9+e7qYx7tA632PuRT7J6OaqZlt69MN8Zz06zvpElgXKHDkMWzwp
         RhUPNW1fgb+FkI3GkdxrE30iAq2FdTtZ0l8FIatxs1MGtsfmKeFRshLNBD8CbmVwOTxp
         2xKrwBflZvV/i20LJ6q5vgAtazeRkWPJ06SV7r3usXWGurM2KLdaKoV9oFk/NNPrclvr
         vyeUz6LQMK3ooW71wYvcbyr/+p+MgidPxlMqJ+Hr4RVRtWP9pS7dJTaIq+UTkpBm1b9K
         g6M+M3ZMZmZZuywsKaX9afTGE/hsqITJTwoIf9SghUhHSRnRUbnhCcdHyH+p0e3e7ojO
         vFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AaU25a8UfJb4Z/9D4FWuv4hK3ee4l67g85BxXopszWA=;
        b=aLVhj7jRIgY1YDKyMeNBy+G/qtecygqRNRQFhnty8mIQyB9I6Rq+05HSvQFpuSiqt+
         HLMlcqmEZ6EF9oBzJcdwmIAy/65sEebB6Q7qDFCOCdeNwVtIto3MnBWjhwNJQBBFHTda
         JYQXYfhQo8tTXOvMEFyvAtA9pOTjCr5h8jIAnz2xplrL5XluqeagMA4oyJA66ku/yOH9
         NltNvEbWJT8oxEAyFR+8T2SUIzyeLDADJghM7ZIWCtHfaNqRtPKjXDz19DNGCuuEq4Ej
         MT0Wpzv3BN1cSpZj4IFlME0JW79DY1sA4S9hwobxqrASC47OTyKynge6RdIzds2AZOwX
         ffIw==
X-Gm-Message-State: AOAM5337oRU3c3JzF6MzNXr7XSmL8VtRb8/AjjK+RRg1YCSsVOZnwVd/
        KkZEaL1AKElTfabYrLs88HXoCTEgbstF
X-Google-Smtp-Source: ABdhPJw2muUIr7KjWW4h3iPpOw+6ATFxfeXiEt0W3+agM5LKbEA8OQLVJMd58y7ka/HbcjeWHyeSEw==
X-Received: by 2002:a05:6e02:b24:b0:2c8:4fba:a5d8 with SMTP id e4-20020a056e020b2400b002c84fbaa5d8mr93797ilu.122.1648824567833;
        Fri, 01 Apr 2022 07:49:27 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id a2-20020a5d9ec2000000b00645ab33390dsm1588481ioe.9.2022.04.01.07.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 07:49:27 -0700 (PDT)
Message-ID: <22aadea2-9330-aa9e-7b6a-834585189144@github.com>
Date:   Fri, 1 Apr 2022 10:49:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [WIP v1 2/4] mv: add check_dir_in_index() and solve general dir
 check issue
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Victoria Dye <vdye@github.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220331091755.385961-3-shaoxuan.yuan02@gmail.com>
 <52784078-c748-a4a0-68b4-db3c133dfa80@github.com>
 <CAJyCBOQmUYe53ahpEXQZAWMoers0o7b1xuCYu_k-LrfvKTkV-g@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAJyCBOQmUYe53ahpEXQZAWMoers0o7b1xuCYu_k-LrfvKTkV-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2022 8:49 AM, Shaoxuan Yuan wrote:> On Fri, Apr 1, 2022 at 5:28 AM Victoria Dye <vdye@github.com> wrote:
>>
>> Shaoxuan Yuan wrote:
>>> Originally, moving a <source> directory which is not on-disk due
>>> to its existence outside of sparse-checkout cone, "giv mv" command
>>> errors out with "bad source".
>>>
>>> Add a helper check_dir_in_index() function to see if a directory
>>> name exists in the index. Also add a SPARSE_DIRECTORY bit to mark
>>> such directories.
>>>
>>
>> Hmm, I think this patch would fit better in your eventual "sparse index
>> integration" series than this "prerequisite fixes to sparse-checkout"
>> series. Sparse directories *only* appear when you're using a sparse index
>> so, theoretically, this shouldn't ever come up (and thus isn't testable)
>> until you're using a sparse index.
> 
> After reading your feedback, I realized that I totally misused
> the phrase "sparse directory". Clearly, this patch series does not
> deal with sparse-
> index yet, as "sparse directory" is a cache entry that points to a
> tree, if sparse-index
> is enabled. Silly me ;)
> 
> What I was *actually* trying to say is: I want to change the checking
> logic of moving
> a "directory that exists outside of sparse-checkout cone", and I
> apparently misused
> "sparse directory" to reference such a thing.

In the case of a full index (or an expanded sparse index, which is
currently always the case for `git mv`), you detect a sparse directory
by looking for the directory in the index, _not_ finding it, and then
seeing if the cache entry at the position where the directory _would_
exist is marked with the SKIP_WORKTREE bit.

This works in cone mode and the old mode because I assume you've already
checked for the existence of the directory, so if there _was_ any
non-SKIP_WORKTREE cache entry within the directory, then the directory
would exist in the worktree.

(These are good details to include in the commit message.)

>>> +static int check_dir_in_index(const char *dir)
>>> +{
>>
>> This function can be made a lot simpler - you can use `cache_name_pos()` to
>> find the index entry - if it's found, the directory exists as a sparse
>> directory. And, because 'add_slash()' enforces the trailing slash later on,
>> you don't need to worry about adjusting the name before you look for the
>> entry.
> 
> Yes, if I correctly used the phrase "sparse directory", but I did not...
> I think I can use 'cache_name_pos()' to
> check a directory *iff* it is a legit sparse directory when using sparse-index?
> 
> In my case, I just want to check a regular directory that is not in
> the worktree,
> since the cone pattern excludes it. And in a non-sparse index, cache
> entry points only
> to blobs, not trees, and that's the reason I wrote this weird function
> to look into the
> index. I understand that sounds not compatible with how git manages
> index, but all
> I want to know is "does this directory exist in the index?" (this
> question is also quasi-correct).
> 
> I tried to find an existing API for this job, but I failed to find
> any. Though I have a hunch
> that there must be something to do it...

You can still use cache_name_pos() and if the resulting value is negative,
then you can "flip it" (pos = -1 - pos) to get the array index where the
directory _would_ be inserted.

For example, here is a case in unpack-trees.c (that uses the synonym
index_name_pos()):

static int locate_in_src_index(const struct cache_entry *ce,
			       struct unpack_trees_options *o)
{
	struct index_state *index = o->src_index;
	int len = ce_namelen(ce);
	int pos = index_name_pos(index, ce->name, len);
	if (pos < 0)
		pos = -1 - pos;
	return pos;
}

This uses a binary search inside the method, so it will be much faster
than the loop you wrote here.

If you have this helper, then you can integrate with the sparse index later
by checking for a sparse directory entry when pos is non-negative. But that
can wait for the next series.

>>>                       /* only error if existence is expected. */
>>>                       else if (modes[i] != SPARSE)
>>>                               bad = _("bad source");
>>> @@ -219,7 +246,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>>>                               && lstat(dst, &st) == 0)
>>>                       bad = _("cannot move directory over file");
>>>               else if (src_is_dir) {
>>> -                     int first = cache_name_pos(src, length), last;
>>> +                     int first, last;
>>> +dir_check:
>>> +                     first = cache_name_pos(src, length);
>>>
>>>                       if (first >= 0)
>>>                               prepare_move_submodule(src, first,
>>> @@ -230,7 +259,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>>>                       else { /* last - first >= 1 */
>>>                               int j, dst_len, n;
>>>
>>> -                             modes[i] = WORKING_DIRECTORY;
>>> +                             if (!modes[i])
>>> +                                     modes[i] = WORKING_DIRECTORY;

This is curious that we could get here with an existing mode. I wonder if
it would be worthwhile to make the enum using a "flags" mode (each state
is a different bit in the word) so instead of

	modes[i] = WORKING_DIRECTORY;

we would write

	modes[i] |= WORKING_DIRECTORY;

>>>                               n = argc + last - first;
>>>                               REALLOC_ARRAY(source, n);
>>>                               REALLOC_ARRAY(destination, n);
>>> @@ -332,7 +362,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>>>                       printf(_("Renaming %s to %s\n"), src, dst);
>>>               if (show_only)
>>>                       continue;
>>> -             if (mode != INDEX && mode != SPARSE && rename(src, dst) < 0) {
>>> +             if (mode != INDEX && mode != SPARSE && mode != SPARSE_DIRECTORY &&

And here we would write something like

	if (!(mode & (INDEX | SPARSE | SPARSE_DIRECTORY)) &&

>>> +              rename(src, dst) < 0) {
>>>                       if (ignore_errors)
>>>                               continue;
>>>                       die_errno(_("renaming '%s' failed"), src);
>>> @@ -346,7 +377,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>>>                                                             1);
>>>               }
>>>
>>> -             if (mode == WORKING_DIRECTORY)
>>> +             if (mode == WORKING_DIRECTORY || mode == SPARSE_DIRECTORY)

and here:

	if (mode & (WORKING_DIRECTORY | SPARSE_DIRECTORY))

This requires changing your enum definition. It got lost in the previous
quoting, it seems, but here it is again:

>>> @@ -129,7 +148,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>>>  		OPT_END(),
>>>  	};
>>>  	const char **source, **destination, **dest_path, **submodule_gitfile;
>>> -	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX, SPARSE } *modes;
>>> +	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX, SPARSE,
>>> +	SPARSE_DIRECTORY } *modes;
>>>  	struct stat st;
>>>  	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
>>>  	struct lock_file lock_file = LOCK_INIT;

I think it is time to split out "enum update_mode" to the top of the file
instead of defining it inline here. Here is what it could look like:

enum update_mode {
	BOTH = 0,
	WORKING_DIRECTORY = (1 << 1),
	INDEX = (1 << 2),
	SPARSE = (1 << 3),
};

(This is how it would look before adding your new value.)

I can imagine making a new commit that does the following:

* Move update_mode to the top and set the values to be independent bits.
* Change "mode[i] =" to "mode[i] |="
* Change "mode ==" checks to "mode &" checks.

Think about it.

>> I'm a bit confused - doesn't this mean the sparse dir move will be skipped?
>> In your commit description, you mention that this 'mv' succeeds with the
>> '--sparse' option, but I don't see any place where the sparse directory
>> would be moved.
> 
> Well, you know the drill, I did not use "sparse directory" correctly, let alone
> 'SPARSE_DIRECTORY' enum bit in this hunk. I think it makes some sense
> if you apply my actual meaning of 'SPARSE_DIRECTORY' here (it should be
> something like OUT_OF_CONE_WORKING_DIRECTORY)? Because such
> directory is not on disk, it cannot be "rename()"d, and should also skip the
> "rename_cache_entry_at()" function. If all the files under the directory are
> moved/renamed, then (in my opinion) the directory is both moved to the
> destination,
> both in the worktree and in the index.

Perhaps a better name would be SKIP_WORKTREE_DIR.

But yes, we need to make sure that all cache entries under the directory
have their SKIP_WORKTREE bits re-checked and any that lose the bit need to
be written to the worktree.

I wonder if it is as simple as marking a boolean that says "I moved at
least one sparse entry" and then calling update_sparsity() at the end of
cmd_mv() if that boolean is true.

Thanks,
-Stolee
