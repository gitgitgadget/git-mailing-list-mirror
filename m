Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284F0C43331
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 15:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDD920775
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 15:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNv4kNSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgCXPMz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:12:55 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45309 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbgCXPMz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 11:12:55 -0400
Received: by mail-oi1-f196.google.com with SMTP id l22so7970597oii.12
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 08:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5gGGcbf0eUE/Q6TgiigKMfjLnKNv4wPJykyWyc/C7eo=;
        b=MNv4kNSgcHOA30009TsnEGrIfLMLBki5vh5eFGALkLmY7/mrigqt9+67DmJBTUxCaP
         3hTnWJ83D3RG8keNSKM2WtwcbY4JH758F4nVfy3qP+H972J2T8J8W99ny6Csb5l+k/i3
         8kFLBTCkY+4zrg3knCE7SyoXAa8wqNKmzTcr0ZrkoMpqE/M6CJvKxZvH4LZkL65kLbi1
         5Z3DcRSwB/E8u1SLDm6LESQurEQoov+wGzWqkpgPQyB/O4alJrBTg5xzQ2pTxWlavHLM
         LyQOYnM+HmAlFUAPHKD4yk1xcr4EXkyIMbdd+Wyh2QGfQN5H+PPEDUrE+HIKye/hdpXi
         zN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5gGGcbf0eUE/Q6TgiigKMfjLnKNv4wPJykyWyc/C7eo=;
        b=sRaR38HwiNIeXffgHt6aTzO8nAwtIXQjC5I13zgLtsydWx6xUlTLDqoZyiwrVG9b6V
         IaXJ+CXkxF18TyHTA93mQcukGCs6vPi3Vy9tyGvraQdDNT4HIjILlqX+ieUc/+Xaud3U
         guPXT+t9qBirEbmmobu52H6dmx0HOYq585G9+2uSfK+vjyS3mWQGJPu+q0Mp3jNLNofA
         48OjaIMxMiyCCv4zB6viTOY0vRXq4/xxEeoa+MWRQ7Jc5PkuyaVYhk7w/zylXcUPvDvh
         EpYjHpJIjiDN7dZhcBk4uFm4jvRIL2qBygMPQ1Uhi9AK+ALYq1QwKQcGgJkv88lk0HYb
         8nbw==
X-Gm-Message-State: ANhLgQ3ZX5J1P2Sq5kcpPrwNhInUlPvzYNoBaxs1vxYsxQpj6K+bV+oo
        FQcilv0bnsU6vNf02R0gTayWcvMAn1g=
X-Google-Smtp-Source: ADFU+vu4NYU7PHyxd7DQbD4kkxr/eigpvln7DidADjXGJyEyrLYj1xkD3Sj9NjegxnCNo+KMyBEoQw==
X-Received: by 2002:aca:5194:: with SMTP id f142mr3872414oib.100.1585062773821;
        Tue, 24 Mar 2020 08:12:53 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 103sm6154043oty.36.2020.03.24.08.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 08:12:52 -0700 (PDT)
Subject: Re: [RFC PATCH 2/3] grep: honor sparse checkout patterns
To:     Elijah Newren <newren@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <stefanbeller@gmail.com>
References: <cover.1585027716.git.matheus.bernardino@usp.br>
 <0b9b4c4b414a571877163667694afa3053bf8890.1585027716.git.matheus.bernardino@usp.br>
 <CABPp-BHbrGGjV_22kwTERn19RaWk73_Y6tzWnjwO9u4isCRpVg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <59c04216-8dd9-cbbf-a869-a65ed8ca6e0a@gmail.com>
Date:   Tue, 24 Mar 2020 11:12:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHbrGGjV_22kwTERn19RaWk73_Y6tzWnjwO9u4isCRpVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/24/2020 3:15 AM, Elijah Newren wrote:
> Hi Matheus,
> 
> On Mon, Mar 23, 2020 at 11:12 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
>>
>> One of the main uses for a sparse checkout is to allow users to focus on
>> the subset of files in a repository in which they are interested. But
>> git-grep currently ignores the sparsity patterns and report all matches
>> found outside this subset, which kind of goes in the oposity direction.
>> Let's fix that, making it honor the sparsity boundaries for every
>> grepping case:
>>
>> - git grep in worktree
>> - git grep --cached
>> - git grep $REVISION
> 
> Wahoo!  This is great.

I am also excited. Also thrilled to see the option to get the old
behavior in the next patch.

>> Something I'm not entirely sure in this patch is how we implement the
>> mechanism to honor sparsity for the `git grep <commit-ish>` case (which
>> is treated in the grep_tree() function). Currently, the patch looks for
>> an index entry that matches the path, and then checks its skip_worktree
> 
> As you discuss below, checking the index is both wrong _and_ costly.

I'm not sure why checking the index is _wrong_, but I agree about the
performance cost.

> You should use the sparsity patterns; Stolee did a lot of work to make
> those correspond to simple hashes you could check to determine whether
> to even walk into a subdirectory.  So, O(1).  Yeah, that's "only" cone
> mode but the non-cone sparsity patterns were a performance nightmare
> waiting to rear its ugly head.  We should just try to encourage
> everyone to move to cone mode, or accept the slowness they get without
> it.
> 
>> bit. But this operation is perfomed in O(log(N)); N being the number of
>> index entries. If there are many entries (and no so many sparsity
>> patterns), maybe a better approach would be to try matching the path
>> directly against the sparsity patterns. This would be O(M) in the number
>> of patterns, and it could be done, in builtin/grep.c, with a function
>> like the following:
>>
>> static struct pattern_list sparsity_patterns;
>> static int sparsity_patterns_initialized = 0;
>> static enum pattern_match_result path_matches_sparsity_patterns(
>>                                         const char *path, int pathlen,
>>                                         const char *basename,
>>                                         struct repository *repo)
>> {
>>         int dtype = DT_UNKNOWN;
>>
>>         if (!sparsity_patterns_initialized) {
>>                 char *sparse_file = git_pathdup("info/sparse-checkout");
>>                 int ret;
>>
>>                 memset(&sparsity_patterns, 0, sizeof(sparsity_patterns));
>>                 sparsity_patterns.use_cone_patterns = core_sparse_checkout_cone;
>>                 ret = add_patterns_from_file_to_list(sparse_file, "", 0,
>>                                                      &sparsity_patterns, NULL);
>>                 free(sparse_file);
>>
>>                 if (ret < 0)
>>                         die(_("failed to load sparse-checkout patterns"));
>>                 sparsity_patterns_initialized = 1;
>>         }
>>
>>         return path_matches_pattern_list(path, pathlen, basename, &dtype,
>>                                          &sparsity_patterns, repo->index);
>> }
>>
>> Also, if I understand correctly, the index doesn't hold paths to dirs,
>> right? So even if a complete dir is excluded from sparse checkout, we
>> still have to check all its subentries, only to discover that they
>> should all be skipped from the search. However, if we were to check
>> against the sparsity patterns directly (e.g. with the function above),
>> we could skip such directories together with all their entries.

When in cone mode, we can check if a directory is one of these three
modes:

1. Completely contained in the cone (recursive match)
2. Completely outside the cone
3. Neither. Keep matching subdirectories. (parent match)

The clear_ce_flags() code in dir.c includes the matching algorithms
for this. Hopefully you can re-use a lot of it. You may need to extract
some methods to use them from the grep code.

>> Oh, and there is also the case of a commit whose tree paths are not in
>> the index (maybe manually created objects?). For such commits, with the
>> index lookup approach, we would have to fall back on ignoring the
>> sparsity rules. I'm not sure if that would be OK, though.
>>
>> Any thoughts on these two approaches (looking up the skip_worktree bit
>> in the index or directly matching against sparsity patterns), will be
>> highly appreciated. (Note that it only concerns the `git grep
>> <commit-ish>` case. The other cases already iterate thought the index, so
>> there is no O(log(N)) extra complexity).
>>
>>  builtin/grep.c                   | 29 ++++++++---
>>  t/t7011-skip-worktree-reading.sh |  9 ----
>>  t/t7817-grep-sparse-checkout.sh  | 88 ++++++++++++++++++++++++++++++++
>>  3 files changed, 111 insertions(+), 15 deletions(-)
>>  create mode 100755 t/t7817-grep-sparse-checkout.sh
>>
>> diff --git a/builtin/grep.c b/builtin/grep.c
>> index 99e2685090..52ec72a036 100644
>> --- a/builtin/grep.c
>> +++ b/builtin/grep.c
>> @@ -388,7 +388,7 @@ static int grep_cache(struct grep_opt *opt,
>>                       const struct pathspec *pathspec, int cached);
>>  static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
>>                      struct tree_desc *tree, struct strbuf *base, int tn_len,
>> -                    int check_attr);
>> +                    int from_commit);
> 
> I'm not familiar with grep.c and have to admit I don't know what
> "check_attr" means.  Slightly surprised to see you replace it, but
> maybe reading the rest will explain...
> 
>>
>>  static int grep_submodule(struct grep_opt *opt,
>>                           const struct pathspec *pathspec,
>> @@ -486,6 +486,10 @@ static int grep_cache(struct grep_opt *opt,
>>
>>         for (nr = 0; nr < repo->index->cache_nr; nr++) {
>>                 const struct cache_entry *ce = repo->index->cache[nr];
>> +
>> +               if (ce_skip_worktree(ce))
>> +                       continue;
>> +
> 
> Looks good for the case where we are grepping through what's cached.
> 
>>                 strbuf_setlen(&name, name_base_len);
>>                 strbuf_addstr(&name, ce->name);
>>
>> @@ -498,8 +502,7 @@ static int grep_cache(struct grep_opt *opt,
>>                          * cache entry are identical, even if worktree file has
>>                          * been modified, so use cache version instead
>>                          */
>> -                       if (cached || (ce->ce_flags & CE_VALID) ||
>> -                           ce_skip_worktree(ce)) {
>> +                       if (cached || (ce->ce_flags & CE_VALID)) {
> 
> I had the same change when I was trying to hack something like this
> patch into place but only handled the worktree case before realized it
> was a bit bigger job.
> 
>>                                 if (ce_stage(ce) || ce_intent_to_add(ce))
>>                                         continue;
>>                                 hit |= grep_oid(opt, &ce->oid, name.buf,
>> @@ -532,7 +535,7 @@ static int grep_cache(struct grep_opt *opt,
>>
>>  static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
>>                      struct tree_desc *tree, struct strbuf *base, int tn_len,
>> -                    int check_attr)
>> +                    int from_commit)
>>  {
>>         struct repository *repo = opt->repo;
>>         int hit = 0;
>> @@ -546,6 +549,9 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
>>                 name_base_len = name.len;
>>         }
>>
>> +       if (from_commit && repo_read_index(repo) < 0)
>> +               die(_("index file corrupt"));
>> +
> 
> As above, I don't think we should need to read the index.  We should
> compare to sparsity patterns, which in the important case (cone mode)
> simplifies to a hash lookup as we walk directories.
> 
>>         while (tree_entry(tree, &entry)) {
>>                 int te_len = tree_entry_len(&entry);
>>
>> @@ -564,9 +570,20 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
>>
>>                 strbuf_add(base, entry.path, te_len);
>>
>> +               if (from_commit) {
>> +                       int pos = index_name_pos(repo->index,
>> +                                                base->buf + tn_len,
>> +                                                base->len - tn_len);
>> +                       if (pos >= 0 &&
>> +                           ce_skip_worktree(repo->index->cache[pos])) {
>> +                               strbuf_setlen(base, old_baselen);
>> +                               continue;
>> +                       }
>> +               }
>> +
>>                 if (S_ISREG(entry.mode)) {
>>                         hit |= grep_oid(opt, &entry.oid, base->buf, tn_len,
>> -                                        check_attr ? base->buf + tn_len : NULL);
>> +                                       from_commit ? base->buf + tn_len : NULL);
> 
> Sadly, this doesn't help me understand check_attr or from_commit.
> Could you clue me in a bit?

Yeah, Elijah and I know the sparse-checkout code quite well, but are
unfamiliar with grep. Let's all expand our knowledge!

>>                 } else if (S_ISDIR(entry.mode)) {
>>                         enum object_type type;
>>                         struct tree_desc sub;
>> @@ -581,7 +598,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
>>                         strbuf_addch(base, '/');
>>                         init_tree_desc(&sub, data, size);
>>                         hit |= grep_tree(opt, pathspec, &sub, base, tn_len,
>> -                                        check_attr);
>> +                                        from_commit);
> 
> Same.
> 
>>                         free(data);
>>                 } else if (recurse_submodules && S_ISGITLINK(entry.mode)) {
>>                         hit |= grep_submodule(opt, pathspec, &entry.oid,
>> diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-reading.sh
>> index 37525cae3a..26852586ac 100755
>> --- a/t/t7011-skip-worktree-reading.sh
>> +++ b/t/t7011-skip-worktree-reading.sh
>> @@ -109,15 +109,6 @@ test_expect_success 'ls-files --modified' '
>>         test -z "$(git ls-files -m)"
>>  '
>>
>> -test_expect_success 'grep with skip-worktree file' '
>> -       git update-index --no-skip-worktree 1 &&
>> -       echo test > 1 &&
>> -       git update-index 1 &&
>> -       git update-index --skip-worktree 1 &&
>> -       rm 1 &&
>> -       test "$(git grep --no-ext-grep test)" = "1:test"
>> -'
>> -
>>  echo ":000000 100644 $ZERO_OID $EMPTY_BLOB A   1" > expected
>>  test_expect_success 'diff-index does not examine skip-worktree absent entries' '
>>         setup_absent &&
>> diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
>> new file mode 100755
>> index 0000000000..fccf44e829
>> --- /dev/null
>> +++ b/t/t7817-grep-sparse-checkout.sh
>> @@ -0,0 +1,88 @@
>> +#!/bin/sh
>> +
>> +test_description='grep in sparse checkout
>> +
>> +This test creates the following dir structure:
>> +.
>> +| - a
>> +| - b
>> +| - dir
>> +    | - c
>> +
>> +Only "a" should be present due to the sparse checkout patterns:
>> +"/*", "!/b" and "!/dir".
>> +'
>> +
>> +. ./test-lib.sh
>> +
>> +test_expect_success 'setup' '
>> +       echo "text" >a &&
>> +       echo "text" >b &&
>> +       mkdir dir &&
>> +       echo "text" >dir/c &&
>> +       git add a b dir &&
>> +       git commit -m "initial commit" &&
>> +       git tag -am t-commit t-commit HEAD &&
>> +       tree=$(git rev-parse HEAD^{tree}) &&
>> +       git tag -am t-tree t-tree $tree &&
>> +       cat >.git/info/sparse-checkout <<-EOF &&
>> +       /*
>> +       !/b
>> +       !/dir
>> +       EOF
>> +       git sparse-checkout init &&
> 
> Using `git sparse-checkout init` but then manually writing to
> .git/info/sparse-checkout?  Seems like it'd make more sense to use
> `git sparse-checkout set` than writing the patterns directly yourself.
> Also, would prefer to have the examples use cone mode (even if you
> have to add subdirectories), as it makes the testcase a bit easier to
> read and more performant, though neither is a big deal.

I agree that we should use the builtin so your test script is less
brittle to potential back-end changes to sparse-checkout (none planned).

I do recommend having at least one test with non-cone mode patterns,
especially if you are checking the pattern-matching yourself instead of
relying on the index.

Thanks,
-Stolee
