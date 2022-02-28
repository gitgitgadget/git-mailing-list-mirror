Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6146AC433FE
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 18:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbiB1Sp4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 13:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236564AbiB1Spj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 13:45:39 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFE2403E2
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 10:44:53 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id o8so12299924pgf.9
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 10:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MUE62HbfulMxI8t9KFc5TosALN2C8S4p09ZGCWVgt4k=;
        b=OEm44ej7TM9WUj5DwVcWsd30xJW9Snb6hlktB5HQMZ1CHXeLKZpAsPPgV4ngplujiL
         z/7l7QHH/wBEYyasG0EVD48xBGmp07ajmGh+r6ah/CPAIOhzbE/kwimW+GQ5Xwtd4l1q
         et4C0oAZvdnU+QfuZkdmDd7mTw3E1Hap/25O46pqm4wzFsQ5yTO4kx+4V2R2XDlNJ6nJ
         XwPuUBi9bUCnXoZ06rNSfRvOua+30CSXOC7d8FFov6V+rR1UbijXsZZccUjGs52kZRND
         EO1Kkm1wb1j77lNEdLVaMWHbloPgCxXRzQ/XVN325/WtVs6sgew89KapFsFmmq3KTLgX
         PSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MUE62HbfulMxI8t9KFc5TosALN2C8S4p09ZGCWVgt4k=;
        b=2twGcTqbG/D+kkeFAD21KHV3QQsOh9SSlKRkcVtIgWNSV7BEFiq28c7sg7NKfJtgOy
         wntBmB7o9IG+S4D8BPNyzER05FKhKP73qcuNE8x+2hNNK9if0jGWJXiWVlegthkRotqe
         vulbAu1bqEXrhZV3aWkcgVtsivbc7NuSiet8wjOccu3gqcVLeBscQTvubmZa6RmTcq9/
         X440QbgCm96TLA+4r6HokowP8lHB1L2Cs4paH/mLhP5KcS8YgE+wEzlApvWUAB2U6OA2
         XCSFt0KRPdPB+UjXGR1NigLfEcKNXvchGza0YRVahu30J6T0GC2vfLUynPQ7PGPQt/Kd
         1Q0A==
X-Gm-Message-State: AOAM531iXij/kfrxikrR9TYxBVl3VsK5wpygeULp+v4BLqHZwJDAPTkc
        2hWrvCkOoWBRbM/gQOUJPL81
X-Google-Smtp-Source: ABdhPJybF0cT6isvIo/zCrGo4zND4Rw0XBju/J/Rt8PKLIPjzT9DTcTai9w6p+GqyAeF3UgavfHo2A==
X-Received: by 2002:a05:6a00:1a0b:b0:4cf:9a9:5c5f with SMTP id g11-20020a056a001a0b00b004cf09a95c5fmr23161661pfv.45.1646073893149;
        Mon, 28 Feb 2022 10:44:53 -0800 (PST)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id nv14-20020a17090b1b4e00b001bd36b55298sm85790pjb.39.2022.02.28.10.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 10:44:52 -0800 (PST)
Message-ID: <51bd953d-7a57-9643-f4d3-c0e7c0dc9bf6@github.com>
Date:   Mon, 28 Feb 2022 10:44:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v2 5/7] read-tree: narrow scope of index expansion for
 '--prefix'
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
 <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
 <4f05fa70209768fb20284bd4018a1364567cad5a.1645742073.git.gitgitgadget@gmail.com>
 <CABPp-BHx8gFh717bovO6wCo0RA058=YjNtHhRme+Rxh8GOnxbQ@mail.gmail.com>
 <686e9c8e-7c5b-7cbc-4772-92b9754caa07@github.com>
 <CABPp-BE6n2-v7-91b-aXOsMod6d3dA4zZE4nNyzxac+tVpaaCw@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CABPp-BE6n2-v7-91b-aXOsMod6d3dA4zZE4nNyzxac+tVpaaCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> Hi Victoria,
> 
> On Fri, Feb 25, 2022 at 12:25 PM Victoria Dye <vdye@github.com> wrote:
>>
>> Elijah Newren wrote:
>>> On Thu, Feb 24, 2022 at 2:34 PM Victoria Dye via GitGitGadget
>>> <gitgitgadget@gmail.com> wrote:
>>>>
>>>> From: Victoria Dye <vdye@github.com>
>>>>
>>>> When 'git read-tree' is provided with a prefix, expand the index only if the
>>>> prefix is equivalent to a sparse directory or contained within one. If the
>>>> index is not expanded in these cases, 'ce_in_traverse_path' will indicate
>>>> that the relevant sparse directory is not in the prefix/traverse path,
>>>> skipping past it and not unpacking the appropriate tree(s).
>>>>
>>>> If the prefix is in-cone, its sparse subdirectories (if any) will be
>>>> traversed correctly without index expansion.
>>>>
>>>> Signed-off-by: Victoria Dye <vdye@github.com>
>>>> ---
>>>>  builtin/read-tree.c                      |  3 +--
>>>>  t/t1092-sparse-checkout-compatibility.sh |  8 ++++++-
>>>>  unpack-trees.c                           | 30 ++++++++++++++++++++++++
>>>>  3 files changed, 38 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/builtin/read-tree.c b/builtin/read-tree.c
>>>> index c2fdbc2657f..a7b7f822281 100644
>>>> --- a/builtin/read-tree.c
>>>> +++ b/builtin/read-tree.c
>>>> @@ -213,8 +213,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
>>>>         if (opts.merge && !opts.index_only)
>>>>                 setup_work_tree();
>>>>
>>>> -       /* TODO: audit sparse index behavior in unpack_trees */
>>>> -       if (opts.skip_sparse_checkout || opts.prefix)
>>>> +       if (opts.skip_sparse_checkout)
>>>>                 ensure_full_index(&the_index);
>>>>
>>>>         if (opts.merge) {
>>>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>>>> index ae44451a0a9..a404be0a10f 100755
>>>> --- a/t/t1092-sparse-checkout-compatibility.sh
>>>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>>>> @@ -1415,7 +1415,13 @@ test_expect_success 'sparse index is not expanded: read-tree' '
>>>>         do
>>>>                 ensure_not_expanded read-tree -mu $MERGE_TREES &&
>>>>                 ensure_not_expanded reset --hard HEAD || return 1
>>>> -       done
>>>> +       done &&
>>>> +
>>>> +       rm -rf sparse-index/deep/deeper2 &&
>>>> +       ensure_not_expanded add . &&
>>>> +       ensure_not_expanded commit -m "test" &&
>>>> +
>>>> +       ensure_not_expanded read-tree --prefix=deep/deeper2 -u deepest
>>>>  '
>>>>
>>>>  test_expect_success 'ls-files' '
>>>> diff --git a/unpack-trees.c b/unpack-trees.c
>>>> index 360844bda3a..dba122a02bb 100644
>>>> --- a/unpack-trees.c
>>>> +++ b/unpack-trees.c
>>>> @@ -1739,6 +1739,36 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>>>>                 setup_standard_excludes(o->dir);
>>>>         }
>>>>
>>>> +       /*
>>>> +        * If the prefix is equal to or contained within a sparse directory, the
>>>> +        * index needs to be expanded to traverse with the specified prefix.
>>>> +        */
>>>> +       if (o->prefix && o->src_index->sparse_index) {
>>>> +               int prefix_len = strlen(o->prefix);
>>>> +
>>>> +               while (prefix_len > 0 && o->prefix[prefix_len - 1] == '/')
>>>> +                       prefix_len--;
>>>> +
>>>> +               if (prefix_len > 0) {
>>>
>>> Is this condition check necessary?  If we want some safety check here,
>>> could it instead be something like
>>>
>>>    if (prefix_len <= 0)
>>>        BUG("Broken prefix passed to unpack_trees");
>>>
>>
>> This condition was intended to skip unnecessary computation for the
>> (probably unlikely, but still technically valid) case where the prefix is
>> the repo root (e.g., '--prefix=/') - because the repo root is represented
>> with only directory separator(s), `prefix_len` would be 0 after removing
>> trailing '/'. In that scenario, the index won't need to be expanded, so we
>> don't need to go looking in the index for that path.
> 
> Wow, that doesn't result in an error?!?  That surprises me.  I never
> even thought to test such a thing.  Clearly, the following related
> command does give an error:
> 
>   git read-tree --prefix=/toplevel/ $TREE
> 
> (namely, "error: invalid path '/toplevel/subpath'")
> 
> whereas, the reason a single slash is accepted it because git is
> trying to be forgiving and treat the following two commands the same:
> 
>   git read-tree --prefix=subdir/ $TREE
>   git read-tree --prefix=subdir $TREE
> 
> i.e. it tries to allow the trailing slash to be optional.  And, by
> implementation quirk, making a trailing slash be optional turns out to
> mean that --prefix=/ is treated the same as no prefix at all, because
> empty string prefix just happens to give the same behavior as NULL
> prefix.
> 

If by "NULL prefix" you mean "the --prefix option isn't specified", the
behavior isn't *quite* the same as with an empty prefix, since `git
read-tree $TREE` will completely overwrite the index without regard for
what's already there, whereas `git read-tree --prefix= $TREE` "merges"
`$TREE` into the current index (failing if any entries in `$TREE` already
exist in the index). I still think it's an extremely niche usage, but can
also imagine a couple instances where it might be useful (e.g., reading from
an orphan branch).

> I think we should just throw an error if prefix starts with '/'.
> unpack_trees() can make it be a BUG() (and at the beginning of the
> function rather than down at this point and only inside some
> conditional). builtin/read-tree.c, the only thing that ever sets
> prefix in unpack_trees_options, should die() if it's passed something
> that starts with a '/'.  Having paths start with a '/' is antithetical
> to how "prefix" is used throughout the codebase, though I guess I can
> see people making that mistake if they are used to gitignore-style
> patterns instead.
> 

I think this makes sense (especially because it doesn't cause a loss of
functionality - a user can still specify '--prefix=' for the repo root if
they really want to). I'll include a patch for it in my next re-roll.

>> None of that is particularly clear from reading the patch, though, so I'll
>> add a comment & test covering it explicitly.
>>
>>> and then dedent the following code?  (Or are callers allowed to not
>>> sanitize their input before passing to unpack_trees(), meaning that we
>>> should use a die() rather than a BUG()?)
>>>
>>> To test this idea, near the top of unpack_trees(), I added:
>>>     if (o->prefix)
>>>         assert(*o->prefix && *o->prefix != '/');
>>> and reran all tests.  They all ran without hitting that assertion.  FWIW.
>>>
>>>> +                       struct strbuf ce_prefix = STRBUF_INIT;
>>>> +                       strbuf_grow(&ce_prefix, prefix_len + 1);
>>>> +                       strbuf_add(&ce_prefix, o->prefix, prefix_len);
>>>> +                       strbuf_addch(&ce_prefix, '/');
>>>> +
>>>> +                       /*
>>>> +                        * If the prefix is not inside the sparse cone, then the
>>>> +                        * index is explicitly expanded if it is found as a sparse
>>>> +                        * directory, or implicitly expanded (by 'index_name_pos')
>>>> +                        * if the path is inside a sparse directory.
>>>> +                        */
>>>> +                       if (!path_in_cone_mode_sparse_checkout(ce_prefix.buf, o->src_index) &&
>>>> +                           index_name_pos(o->src_index, ce_prefix.buf, ce_prefix.len) >= 0)
>>>
>>> style nit: Can you rewrap both the comments and the code at 80 characters?
>>>
>>
>> I couldn't think of a way to wrap the condition that wouldn't make it more
>> difficult to read. The best I could come up with was:
>>
>>                         if (!path_in_cone_mode_sparse_checkout(ce_prefix.buf,
>>                                                                o->src_index) &&
>>                             index_name_pos(o->src_index,
>>                                            ce_prefix.buf,
>>                                            ce_prefix.len) >= 0)
>>                                 ensure_full_index(o->src_index);
>>
>>
>> which, to me, is a bit hard to parse. Alternatively, though, I can move the
>> prefix-checking logic into its own function (kind of like
>> 'pathspec_needs_expanded_index(...)' in [1]), in which case I won't need to
>> change the current wrapping to keep it under 80 characters.
>>
>> [1] https://lore.kernel.org/git/822d7344587f698e73abba1ca726c3a905f7b403.1638201164.git.gitgitgadget@gmail.com/
>>
>>> It took me a bit of playing and testing to understand these two lines.
>>> The comment helps, but it's still a bit dense to unpack; somehow I
>>> didn't understand that the comment was referring to index_name_pos()'s
>>> call to ensure_full_index().  Once I understood that, it all looks
>>> good.
>>>
>>
>> Sorry about that, I'll revise to make that clearer.
> 
> Thanks.  :-)
> 
>>>
>>>> +                               ensure_full_index(o->src_index);
>>>> +
>>>> +                       strbuf_release(&ce_prefix);
>>>> +               }
>>>> +       }
>>>> +
>>>>         if (!core_apply_sparse_checkout || !o->update)
>>>>                 o->skip_sparse_checkout = 1;
>>>>         if (!o->skip_sparse_checkout && !o->pl) {
>>>> --
>>>> gitgitgadget

