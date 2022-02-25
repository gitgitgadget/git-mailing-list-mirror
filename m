Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8C5C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 20:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbiBYUZk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 15:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbiBYUZi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 15:25:38 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD3B214F99
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 12:25:06 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id h17so162775plc.5
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 12:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9BmahDNH3REI5WFHAhNr/9R5HIbtrovWr11v1KpKMAE=;
        b=RGHi+5mqEQb+jRlNsOPdK61ZTPXpCjkAwikou+WgSHN/ez9n43LMSL2WBFk+wo2s+m
         991jhY+1edO7w4MU/u0TAmpQaBMXklfA5y2GD6AAumnCshnb5xN3JSGP/i/uN45q/kL8
         Glg93rJ4AEk55y4sKTvEGbMWQCGHRFE2biEywbdK1/Lj48nfqb5JIBqM37RY4lJn8/7S
         dL639Y7ZzldfQeLGEhj2iD94zc7VmS++xM10hq19QKEcbUCyn25dSIsj/EHSFV3cq2AI
         XRZxxzXtAt5na36X7G9CtCZwvwKL1DFEHEw+1ZSTlA0qBcfTbzJlkndGFWjlz+PPUFdR
         QfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9BmahDNH3REI5WFHAhNr/9R5HIbtrovWr11v1KpKMAE=;
        b=wH4cXNsEbrxFnHBIWU0gD+7c20bYOUQMzerkC6eKLNkZjRNpCtq9ctK+WczZOvsbUx
         qcS+ku5stpymzf1B5znNg3OOO7deBRTyV7Wf7rJQjBSHurB6M9taOkqrdNNKElheMcEr
         /bmfC0LfOVpCBbotH08zzsUN0TTdr9lzbZqC1gDzLLSGbLzulXkcktRELVxmxo5subj5
         AToFa++buZEqhcFqh4P/4wuWBwtWpbhuEW1LMHuPGe8kj5KvaHdH0r10dBQD7/df7Gn8
         MEQiyAzbRxoFs6moKe/DtcfxGT2b0QQ0sSuRSFpLkcAdFFj2GuPsRfETwlAvS3oVYmQf
         ULsw==
X-Gm-Message-State: AOAM531mb2IIOG+HGjIr0pHJX5vHZe0GHJFW2GHbnz1Oj9rhu616xI0b
        rN9P9bmGN2AYvxzQpWdtVrM/
X-Google-Smtp-Source: ABdhPJxnq2Zvpcho08WNWFBo+YO5YAPAXkcXWwaj40CgKTNgF/4klAEHhAUsAJvqxwThNJdgeWvvEw==
X-Received: by 2002:a17:902:82c5:b0:151:476b:c581 with SMTP id u5-20020a17090282c500b00151476bc581mr291190plz.158.1645820705806;
        Fri, 25 Feb 2022 12:25:05 -0800 (PST)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id e7-20020aa78c47000000b004de8f900716sm3925638pfd.127.2022.02.25.12.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 12:25:05 -0800 (PST)
Message-ID: <686e9c8e-7c5b-7cbc-4772-92b9754caa07@github.com>
Date:   Fri, 25 Feb 2022 12:25:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v2 5/7] read-tree: narrow scope of index expansion for
 '--prefix'
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
 <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
 <4f05fa70209768fb20284bd4018a1364567cad5a.1645742073.git.gitgitgadget@gmail.com>
 <CABPp-BHx8gFh717bovO6wCo0RA058=YjNtHhRme+Rxh8GOnxbQ@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CABPp-BHx8gFh717bovO6wCo0RA058=YjNtHhRme+Rxh8GOnxbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Thu, Feb 24, 2022 at 2:34 PM Victoria Dye via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Victoria Dye <vdye@github.com>
>>
>> When 'git read-tree' is provided with a prefix, expand the index only if the
>> prefix is equivalent to a sparse directory or contained within one. If the
>> index is not expanded in these cases, 'ce_in_traverse_path' will indicate
>> that the relevant sparse directory is not in the prefix/traverse path,
>> skipping past it and not unpacking the appropriate tree(s).
>>
>> If the prefix is in-cone, its sparse subdirectories (if any) will be
>> traversed correctly without index expansion.
>>
>> Signed-off-by: Victoria Dye <vdye@github.com>
>> ---
>>  builtin/read-tree.c                      |  3 +--
>>  t/t1092-sparse-checkout-compatibility.sh |  8 ++++++-
>>  unpack-trees.c                           | 30 ++++++++++++++++++++++++
>>  3 files changed, 38 insertions(+), 3 deletions(-)
>>
>> diff --git a/builtin/read-tree.c b/builtin/read-tree.c
>> index c2fdbc2657f..a7b7f822281 100644
>> --- a/builtin/read-tree.c
>> +++ b/builtin/read-tree.c
>> @@ -213,8 +213,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
>>         if (opts.merge && !opts.index_only)
>>                 setup_work_tree();
>>
>> -       /* TODO: audit sparse index behavior in unpack_trees */
>> -       if (opts.skip_sparse_checkout || opts.prefix)
>> +       if (opts.skip_sparse_checkout)
>>                 ensure_full_index(&the_index);
>>
>>         if (opts.merge) {
>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>> index ae44451a0a9..a404be0a10f 100755
>> --- a/t/t1092-sparse-checkout-compatibility.sh
>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>> @@ -1415,7 +1415,13 @@ test_expect_success 'sparse index is not expanded: read-tree' '
>>         do
>>                 ensure_not_expanded read-tree -mu $MERGE_TREES &&
>>                 ensure_not_expanded reset --hard HEAD || return 1
>> -       done
>> +       done &&
>> +
>> +       rm -rf sparse-index/deep/deeper2 &&
>> +       ensure_not_expanded add . &&
>> +       ensure_not_expanded commit -m "test" &&
>> +
>> +       ensure_not_expanded read-tree --prefix=deep/deeper2 -u deepest
>>  '
>>
>>  test_expect_success 'ls-files' '
>> diff --git a/unpack-trees.c b/unpack-trees.c
>> index 360844bda3a..dba122a02bb 100644
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -1739,6 +1739,36 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>>                 setup_standard_excludes(o->dir);
>>         }
>>
>> +       /*
>> +        * If the prefix is equal to or contained within a sparse directory, the
>> +        * index needs to be expanded to traverse with the specified prefix.
>> +        */
>> +       if (o->prefix && o->src_index->sparse_index) {
>> +               int prefix_len = strlen(o->prefix);
>> +
>> +               while (prefix_len > 0 && o->prefix[prefix_len - 1] == '/')
>> +                       prefix_len--;
>> +
>> +               if (prefix_len > 0) {
> 
> Is this condition check necessary?  If we want some safety check here,
> could it instead be something like
> 
>    if (prefix_len <= 0)
>        BUG("Broken prefix passed to unpack_trees");
> 

This condition was intended to skip unnecessary computation for the
(probably unlikely, but still technically valid) case where the prefix is
the repo root (e.g., '--prefix=/') - because the repo root is represented
with only directory separator(s), `prefix_len` would be 0 after removing
trailing '/'. In that scenario, the index won't need to be expanded, so we
don't need to go looking in the index for that path. 

None of that is particularly clear from reading the patch, though, so I'll
add a comment & test covering it explicitly.

> and then dedent the following code?  (Or are callers allowed to not
> sanitize their input before passing to unpack_trees(), meaning that we
> should use a die() rather than a BUG()?)
> 
> To test this idea, near the top of unpack_trees(), I added:
>     if (o->prefix)
>         assert(*o->prefix && *o->prefix != '/');
> and reran all tests.  They all ran without hitting that assertion.  FWIW.
> 
>> +                       struct strbuf ce_prefix = STRBUF_INIT;
>> +                       strbuf_grow(&ce_prefix, prefix_len + 1);
>> +                       strbuf_add(&ce_prefix, o->prefix, prefix_len);
>> +                       strbuf_addch(&ce_prefix, '/');
>> +
>> +                       /*
>> +                        * If the prefix is not inside the sparse cone, then the
>> +                        * index is explicitly expanded if it is found as a sparse
>> +                        * directory, or implicitly expanded (by 'index_name_pos')
>> +                        * if the path is inside a sparse directory.
>> +                        */
>> +                       if (!path_in_cone_mode_sparse_checkout(ce_prefix.buf, o->src_index) &&
>> +                           index_name_pos(o->src_index, ce_prefix.buf, ce_prefix.len) >= 0)
> 
> style nit: Can you rewrap both the comments and the code at 80 characters?
> 

I couldn't think of a way to wrap the condition that wouldn't make it more
difficult to read. The best I could come up with was:

			if (!path_in_cone_mode_sparse_checkout(ce_prefix.buf, 
							       o->src_index) &&
			    index_name_pos(o->src_index, 
					   ce_prefix.buf, 
					   ce_prefix.len) >= 0)
				ensure_full_index(o->src_index);


which, to me, is a bit hard to parse. Alternatively, though, I can move the
prefix-checking logic into its own function (kind of like
'pathspec_needs_expanded_index(...)' in [1]), in which case I won't need to
change the current wrapping to keep it under 80 characters.

[1] https://lore.kernel.org/git/822d7344587f698e73abba1ca726c3a905f7b403.1638201164.git.gitgitgadget@gmail.com/

> It took me a bit of playing and testing to understand these two lines.
> The comment helps, but it's still a bit dense to unpack; somehow I
> didn't understand that the comment was referring to index_name_pos()'s
> call to ensure_full_index().  Once I understood that, it all looks
> good.
> 

Sorry about that, I'll revise to make that clearer.

> 
>> +                               ensure_full_index(o->src_index);
>> +
>> +                       strbuf_release(&ce_prefix);
>> +               }
>> +       }
>> +
>>         if (!core_apply_sparse_checkout || !o->update)
>>                 o->skip_sparse_checkout = 1;
>>         if (!o->skip_sparse_checkout && !o->pl) {
>> --
>> gitgitgadget

