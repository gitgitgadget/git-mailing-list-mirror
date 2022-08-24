Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89CEC32796
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 18:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240495AbiHXSUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 14:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239596AbiHXSUc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 14:20:32 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032B43ED4E
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 11:20:31 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id c16-20020a17090aa61000b001fb3286d9f7so3881409pjq.1
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 11:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=DoApTJKUCjWMRRpIKeZl5kdXoh3tAzBJBOOMdi9MPhY=;
        b=Rh5OBf42vvHO6Qc5k93J1UDQgrSkx9KYBw6ukgxQPrwhQS2s2J0T7ECJIc7fhMGgmn
         AwvL8Bzr5o5bg1N32QxebSgX6xMI9NSWHyyhq6Rn3699uYYojUvjGWvNgRIzJ/IY4mtc
         bX5klXjK8gpon4RpaQ4LHI9aDPnk440RM+2bmqU0JWzj5pZqa3nnH8vHOskBAkQp4nhV
         hqXEbS+7AxPDGoD2Amf3WVwCO5XTEUiqhW1qnmqedfw1g118UxZbN/0FdwjatIjgFMsL
         NIQbzLlJ6jmAsngyTH6UO+ZEn7ByWoo7OdpN6PROyfv9avjovNmju+3dyB1jbMoK4GaW
         WJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=DoApTJKUCjWMRRpIKeZl5kdXoh3tAzBJBOOMdi9MPhY=;
        b=Z7Lyo6dTxiFNuPcNIEkvD2ucRQRfaUTaiyHJKHmB6t3jWEXq4pH8FnRaDoslnbckwf
         ETf4qv/YlxJr4vc1qcIgKicswz2ezv2IZcS3qY2yZdA+jlBnhjhZG27bnDDUSPC696+B
         OOAtbJ52887bjCFUcf468wdIfhVGggeG/hDZ8oTmHr9ZlHCiS87afoecL0MZEesMQc8G
         6FftHQOB2sNIDBwoF6s0bPqkNR8dwKrVZavknXTIG1A+rFt1JdBQfjGoxi2dCVqzh+W3
         LyVvqfPj9na7iYUPrVMljm+42MM5SI/An3kByfLUDnHCmEOn4cmqwAe2LrKomZW6w6l4
         VCnQ==
X-Gm-Message-State: ACgBeo1xQawrrcmQH5Njpb7kpD/2MjJxSqiieZxBX2mNyYzjxxTU0hWx
        dOz6xGXi+oIu/NzMI9PJiF3CIw0uWOg=
X-Google-Smtp-Source: AA6agR7Ih66cFX0Gx3MdIJSGObYDxgdAvidrb8pDg7Z9wEKJcYaejLhHPqdZyNhu2J42zxR5TIQNFA==
X-Received: by 2002:a17:90b:1e0a:b0:1f5:6554:d502 with SMTP id pg10-20020a17090b1e0a00b001f56554d502mr375574pjb.101.1661365230334;
        Wed, 24 Aug 2022 11:20:30 -0700 (PDT)
Received: from ?IPV6:2600:380:7721:3451:2462:b29e:17b0:e7cc? ([2600:380:7721:3451:2462:b29e:17b0:e7cc])
        by smtp.gmail.com with ESMTPSA id y3-20020aa793c3000000b00536562f4c03sm9631993pff.146.2022.08.24.11.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 11:20:29 -0700 (PDT)
Message-ID: <74ff1a97-fa98-7280-9d84-35dafaf3cb3d@gmail.com>
Date:   Thu, 25 Aug 2022 02:20:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 1/2] builtin/grep.c: add --sparse option
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Cc:     vdye@github.com
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220817075633.217934-2-shaoxuan.yuan02@gmail.com>
 <80f24382-1188-d450-d1e2-42f68c08e60b@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <80f24382-1188-d450-d1e2-42f68c08e60b@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi reviewrs,

I came back from busying with relocation :)

On 8/17/2022 10:12 PM, Derrick Stolee wrote:
 > On 8/17/2022 3:56 AM, Shaoxuan Yuan wrote:
 >> Add a --sparse option to `git-grep`. This option is mainly used to:
 >>
 >> If searching in the index (using --cached):
 >>
 >> With --sparse, proceed the action when the current cache_entry is
 >
 > This phrasing is awkward. It might be better to reframe to describe the
 > _why_ before the _what_
 >
 >   When the '--cached' option is used with the 'git grep' command, the
 >   search is limited to the blobs found in the index, not in the worktree.
 >   If the user has enabled sparse-checkout, this might present more 
results
 >   than they would like, since the files outside of the 
sparse-checkout are
 >   unlikely to be important to them.
 >
 >   Change the default behavior of 'git grep' to focus on the files within
 >   the sparse-checkout definition. To enable the previous behavior, add a
 >   '--sparse' option to 'git grep' that triggers the old behavior that
 >   inspects paths outside of the sparse-checkout definition when paired
 >   with the '--cached' option.

Good suggestion!

 > Or something like that. The documentation updates will also help clarify
 > what happens when '--cached' is not included. I assume '--sparse' is
 > ignored, but perhaps it _could_ allow looking at the cached files outside
 > the sparse-checkout definition, this could make the simpler invocation of
 > 'git grep --sparse <pattern>' be the way that users can search after 
their
 > attempt to search the worktree failed.

This simpler version was in my earlier local branch, but later I
decided not to go with it. I found the difference between these two
approaches, is that "--cached --sparse" is more correct in terms of
how Git actually works (because sparsity is a concept in the index);
and "--sparse" is more comfortable for the end user.

I found the former one better here, because it is more self-explanatory,
and thus more info for the user, i.e. "you are now looking at the
index, and Git will also consider files outside of sparse definition."

To be honest, I don't know which one is "better", but I think I'll
keep the current implementation unless something more convincing shows
up later.

 >> marked with SKIP_WORKTREE bit (the default is to skip this kind of
 >> entry). Before this patch, --cached itself can realize this action.
 >> Adding --sparse here grants the user finer control over sparse
 >> entries. If the user only wants to peak into the index without
 >
 > s/peak/peek/
 >
 >> caring about sparse entries, --cached should suffice; if the user
 >> wants to peak into the index _and_ cares about sparse entries,
 >> combining --sparse with --cached can address this need.
 >>
 >> Suggested-by: Victoria Dye <vdye@github.com>
 >> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
 >> ---
 >>  builtin/grep.c                  | 10 +++++++++-
 >>  t/t7817-grep-sparse-checkout.sh | 12 ++++++------
 >>  2 files changed, 15 insertions(+), 7 deletions(-)
 >
 > You mentioned in Slack that you missed the documentation of the --sparse
 > option. Just pointing it out here so we don't forget.

Will do.

 >>
 >> diff --git a/builtin/grep.c b/builtin/grep.c
 >> index e6bcdf860c..61402e8084 100644
 >> --- a/builtin/grep.c
 >> +++ b/builtin/grep.c
 >> @@ -96,6 +96,8 @@ static pthread_cond_t cond_result;
 >>
 >>  static int skip_first_line;
 >>
 >> +static int grep_sparse = 0;
 >> +
 >
 > I initially thought it might be good to not define an additional global,
 > but there are many defined in this file outside of the context and they
 > are spread out with extra whitespace like this.
 >
 >>  static void add_work(struct grep_opt *opt, struct grep_source *gs)
 >>  {
 >>      if (opt->binary != GREP_BINARY_TEXT)
 >> @@ -525,7 +527,11 @@ static int grep_cache(struct grep_opt *opt,
 >>      for (nr = 0; nr < repo->index->cache_nr; nr++) {
 >>          const struct cache_entry *ce = repo->index->cache[nr];
 >>
 >> -        if (!cached && ce_skip_worktree(ce))
 >
 > This logic would skip files marked with SKIP_WORKTREE _unless_ --cached
 > was provided.
 >
 >> +        /*
 >> +         * If ce is a SKIP_WORKTREE entry, look into it when both
 >> +         * --sparse and --cached are given.
 >> +         */
 >> +        if (!(grep_sparse && cached) && ce_skip_worktree(ce))
 >>              continue;
 >
 > The logic of this if statement is backwards from the comment because a
 > true statement means "skip the entry" _not_ "look into it".
 >
 >     /*
 >      * Skip entries with SKIP_WORKTREE unless both --sparse and
 >      * --cached are given.
 >      */

Got it.

 > But again, we might want to consider this alternative:
 >
 >     /*
 >      * Skip entries with SKIP_WORKTREE unless --sparse is given.
 >      */
 >     if (!grep_sparse && ce_skip_worktree(ce))
 >         continue;
 >
 > This will require further changes below, specifically this bit:
 >
 >             /*
 >              * If CE_VALID is on, we assume worktree file and its
 >              * cache entry are identical, even if worktree file has
 >              * been modified, so use cache version instead
 >              */
 >             if (cached || (ce->ce_flags & CE_VALID)) {
 >                 if (ce_stage(ce) || ce_intent_to_add(ce))
 >                     continue;
 >                 hit |= grep_oid(opt, &ce->oid, name.buf,
 >                          0, name.buf);
 >             } else {
 >
 > We need to activate this grep_oid() call also when ce_skip_worktree(c) is
 > true. That is, if we want 'git grep --sparse' to extend the search beyond
 > the worktree and into the sparse entries.
 >
 >>
 >>          strbuf_setlen(&name, name_base_len);
 >> @@ -963,6 +969,8 @@ int cmd_grep(int argc, const char **argv, const 
char *prefix)
 >>                 PARSE_OPT_NOCOMPLETE),
 >>          OPT_INTEGER('m', "max-count", &opt.max_count,
 >>              N_("maximum number of results per file")),
 >> +        OPT_BOOL(0, "sparse", &grep_sparse,
 >> +             N_("search sparse contents and expand sparse index")),
 >
 > This "and expand sparse index" is an internal implementation detail, 
not a
 > heplful item for the help text. Instead, perhaps:
 >
 >     "search the contents of files outside the sparse-checkout definition"

Sounds good!

 > (Also, while the sparse index is being expanded right now, I would expect
 > to not expand the sparse index by the end of the series.)
 >
 >> -test_expect_success 'grep --cached searches entries with the 
SKIP_WORKTREE bit' '
 >> +test_expect_success 'grep --cached and --sparse searches entries 
with the SKIP_WORKTREE bit' '
 >>      cat >expect <<-EOF &&
 >>      a:text
 >>      b:text
 >>      dir/c:text
 >>      EOF
 >> -    git grep --cached "text" >actual &&
 >> +    git grep --cached --sparse "text" >actual &&
 >>      test_cmp expect actual
 >>  '
 >
 > Please add a test that demonstrates the change of behavior when only 
--cached
 > is provided, not --sparse.

Sure!

 > (If you take my suggestion to allow 'git grep --sparse' to do something
 > different, then also add a test for that case.)
 >
 >>
 >> @@ -143,7 +143,7 @@ test_expect_success 'grep --recurse-submodules 
honors sparse checkout in submodu
 >>      test_cmp expect actual
 >>  '
 >>
 >> -test_expect_success 'grep --recurse-submodules --cached searches 
entries with the SKIP_WORKTREE bit' '
 >> +test_expect_success 'grep --recurse-submodules --cached and 
--sparse searches entries with the SKIP_WORKTREE bit' '
 >>      cat >expect <<-EOF &&
 >>      a:text
 >>      b:text
 >> @@ -152,7 +152,7 @@ test_expect_success 'grep --recurse-submodules 
--cached searches entries with th
 >>      sub/B/b:text
 >>      sub2/a:text
 >>      EOF
 >> -    git grep --recurse-submodules --cached "text" >actual &&
 >> +    git grep --recurse-submodules --cached --sparse "text" >actual &&
 >>      test_cmp expect actual
 >>  '
 >> @@ -166,7 +166,7 @@ test_expect_success 'working tree grep does not 
search the index with CE_VALID a
 >>      test_cmp expect actual
 >>  '
 >>
 >> -test_expect_success 'grep --cached searches index entries with both 
CE_VALID and SKIP_WORKTREE' '
 >> +test_expect_success 'grep --cached and --sparse searches index 
entries with both CE_VALID and SKIP_WORKTREE' '
 >>      cat >expect <<-EOF &&
 >>      a:text
 >>      b:text
 >> @@ -174,7 +174,7 @@ test_expect_success 'grep --cached searches 
index entries with both CE_VALID and
 >>      EOF
 >>      test_when_finished "git update-index --no-assume-unchanged b" &&
 >>      git update-index --assume-unchanged b &&
 >> -    git grep --cached text >actual &&
 >> +    git grep --cached --sparse text >actual &&
 >>      test_cmp expect actual
 >>  '
 >
 > Same with these two tests. Add additional commands that show the 
change of
 > behavior when only using '--cached'.

--
Thanks,
Shaoxuan

