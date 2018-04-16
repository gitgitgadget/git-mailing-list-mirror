Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C0B21F404
	for <e@80x24.org>; Mon, 16 Apr 2018 21:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeDPVVL (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 17:21:11 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:46622 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbeDPVVK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 17:21:10 -0400
Received: by mail-ua0-f177.google.com with SMTP id a17so11083894uaf.13
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 14:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e1PLSy5xhEup54VbKLmnkmxZhlPvb4+tr0zOOErUncM=;
        b=oJCoi5lDGs4tQCdgaIPvHG9/dnQByJ8jtiCY1Za3lZqp2jZa2x9XOJtIGCdpy6ER2y
         L5Qc/TfS2Cj8F7cbrJ85swUNTWWsLo3zxYAhES/qA8WwmpXG1mRlNblAHKtlEEIBm1so
         I6tOzSb+seOFlBpDgX5J6V/Y7FHz/+9XSNFUJg68lWh+btIIa2aIiXJVwbkUJ+VRACIl
         fPGyKhacTQpvUIfGAC1KeIq4Gb66RSLZeHc9ZH3a4EANi2QpC+l3CkxXOXd2TO2bzEX1
         7u+/gyw46bev4XOuuB2bXsugqgoK9Y4QHw5oIig3nMQVx7RdY9zs0SRaI7Wmk2MEjdfV
         Kclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e1PLSy5xhEup54VbKLmnkmxZhlPvb4+tr0zOOErUncM=;
        b=ESDC6CHMPYS1sRqEmbWL+rCdJas0O3060WIkyX1vz7X0raKDVCFXGFcAKCXHix4ude
         i5NxknPlKyQXx1Qe2i6hS+WiN+EDF/HT5jBVXWa8WawEw2xFZNsRZQDFte1//OxJzXMG
         kayW8twLsvp69ZQOt2yl99y7ClJ/K6XRKXfb1D/d+f3GZ1+NxKOAZT7wsjmTUNV8lC2k
         Yo1U8xZPFY8foGijeZczvr4Kct3FwobuY5Go1CeOiI4rcrLSIWRi/mHMPA0ye4jRZDAS
         K4j5lfGhTc5VLNeMVpg0RP79f+CzEq0SpVXsQtfGbic5cjIncQAcdKqukbbTe1grPHPn
         uxdQ==
X-Gm-Message-State: ALQs6tCjJrVQBfwjlng+oQL2778UC23Ft6M7LrJa9koGCQCpf8D6MuWO
        Kef3njcrfAUtn2ujcppGXvzJ2MUDgfnd6JDtIUY=
X-Google-Smtp-Source: AIpwx4/IaAEtj8FnbgO1nKMfQc00z0aamiROXvSVmT34pMsXDUDP7m4sVgwE2F13pyczgXXp45gdvtIJ3rYJszMOxog=
X-Received: by 10.176.30.132 with SMTP id o4mr6035238uak.154.1523913668865;
 Mon, 16 Apr 2018 14:21:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.40.42 with HTTP; Mon, 16 Apr 2018 14:21:08 -0700 (PDT)
In-Reply-To: <xmqqo9ikyojz.fsf@gitster-ct.c.googlers.com>
References: <xmqqmuya43cs.fsf@gitster-ct.c.googlers.com> <20180413195607.18091-1-newren@gmail.com>
 <20180413195607.18091-4-newren@gmail.com> <xmqqo9ikyojz.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 16 Apr 2018 14:21:08 -0700
Message-ID: <CABPp-BFPTJsTUVoPxxN=2u5jEqn1ngdDvMNhp+VLZKTgZaUkvw@mail.gmail.com>
Subject: Re: [PATCH v9 29.75/30] merge-recursive: Fix was_tracked() to quit
 lying with some renamed paths
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 15, 2018 at 5:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> @@ -362,13 +363,17 @@ static int git_merge_trees(struct merge_options *o,
>>       init_tree_desc_from_tree(t+2, merge);
>>
>>       rc = unpack_trees(3, t, &o->unpack_opts);
>> +     cache_tree_free(&active_cache_tree);
>> +
>> +     o->orig_index = the_index;
>> +     the_index = tmp_index;
>> +
>>       /*
>> -      * unpack_trees NULLifies src_index, but it's used in verify_uptodate,
>> -      * so set to the new index which will usually have modification
>> -      * timestamp info copied over.
>> +      * src_index is used in verify_uptodate, but was NULLified in
>> +      * unpack_trees, so we need to set it back to the original index.
>>        */
>
> Was NULLified?  I thought that the point of src/dst distinction
> Linus introduced long time ago at 34110cd4 ("Make 'unpack_trees()'
> have a separate source and destination index", 2008-03-06) was that
> we can then keep the source side of the traversal unmodified.

That comment is messed up; maybe I edited and re-edited the comment
multiple times and then didn't notice the big problems when
re-reading?

Anyway, I should move the comment a few lines up, and make the code
instead read:

    /*
     * Update the_index to match the new results, AFTER saving a copy
     * in o->orig_index.  Update src_index to point to the saved copy.
     * (verify_uptodate() checks src_index, and the original index is
     * the one that had the necessary modification timestamps.)
     */
    o->orig_index = the_index;
    the_index = tmp_index;
    o->unpack_opts.src_index = &o->orig_index;

>>  static int would_lose_untracked(const char *path)
>>  {
>> -     return !was_tracked(path) && file_exists(path);
>> +     /*
>> +      * This may look like it can be simplified to:
>> +      *   return !was_tracked(o, path) && file_exists(path)
>> +      * but it can't.  This function needs to know whether path was
>> +      * in the working tree due to EITHER having been tracked in the
>> +      * index before the merge OR having been put into the working copy
>> +      * and index by unpack_trees().  Due to that either-or requirement,
>> +      * we check the current index instead of the original one.
>> +      */
>
> If this path was created by merge-recursive, not by unpack_trees(),
> what does this function want to say?  Say, we are looking at path P,
> the other branch we are merging moved some other path Q to P (while
> our side modified contents at path Q).  Then path P we are looking
> at has contents of Q at the merge base at stage #1, the contents of
> Q from our HEAD at stage #2 and the contents of P from the other
> branch at stage #3.  The code below says "path P is OK, we won't
> lose it" in such a case, but it is unclear if the above comment
> wants to also cover that case.

Oh, boy, here be dragons...

The comment as-is actually does cover your example case with Q and P:
unpack_trees(), which is unaware of renames, will see that P only
exists on one side of history and thus load it into the index at stage
0 rather than stage 3.

But your general comment about whether something else in
merge-recursive could create a path in the current index after
unpack_trees() is interesting...it touches on a pitfall that has bit
me multiple times.  There is a required ordering in merge-recursive.c
that for any given path, the working directory must be updated before
the index is -- otherwise, would_lose_untracked() will return faulty
information.  update_file_flags() has this ordering builtin,
update_stages() has a big obnoxious comment at the beginning about how
it should not be called until after update_file() is,
apply_directory_rename_modifications() has a big comment about this
~80% of the way through the function (look for
"would_lose_untracked"), and conflict_rename_rename_2to1() has a big
obnoxious comment near the end painstakingly pointing out that some
code that feels like it would make more sense being combined with a
previous function cannot be due to the
update-working-directory-before-index requirement.

I should probably add to this comment something about this annoying
(and error-prone) ordering restriction, since this function is the
source of those particular pains.  Your suggested ideal-world rewrite
(run unpack_trees() with unpack_opts.index_only=1, do merge in memory,
then update working tree), would make this whole problem go away.
