Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0FBC433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 03:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8C26611BE
	for <git@archiver.kernel.org>; Tue, 18 May 2021 03:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345610AbhERDoA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 23:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346294AbhERDnu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 23:43:50 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FE8C06175F
        for <git@vger.kernel.org>; Mon, 17 May 2021 20:42:33 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso7509871ote.1
        for <git@vger.kernel.org>; Mon, 17 May 2021 20:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBeKxEq7J8ufEy2Lv3C6U87R+zxQXBV0j5c3SoVJrYg=;
        b=vSdveMZqLV1Bf2PY2OklTMjnfOZbn0Mysc3Cn7jI0z9N5t/b/fJkaGjVhB4+HUHpQc
         n3BgSPXHV4yGKp6CHk2Qhui9DILbF2ADYWNRvZPlkZHMJ0/pRIUqpPHCWER0nc6eaIYH
         /6u9WjMBQFgRvs3aidQ0P2RLkSxLoRQHIqn6WlhEcZhoeeozViqsmQZVFp6uJCXK1mrs
         oshuYU7qyYoI6+0VZgdqBnaai/J9x19ddejBNP9So3ssWYZDVkefHkJTj2hMmheINq36
         n9UmcH0YQDmQnLDsti1mc+oyWZO71wHPNBM1Cf8MDhhWZDLYWQCqH/PGgZsjh+4n9bt1
         nbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBeKxEq7J8ufEy2Lv3C6U87R+zxQXBV0j5c3SoVJrYg=;
        b=DBfns3UeYPu24B7ocv5up7jRnAb0iDyFU6o9oH4augLLRZMBi3+7BL+BA1qjZi81Kq
         nXF9tgUTk/gaBbY4yCbbBYzz8wAF63tAH+Gi+ekhyjVvZpbV4Nqq+0/dIZhfJg7XU7qQ
         RxWEsGYkbwISjc360IYvG1hyqgmlTGF3RluhC0f7TsfJgdDSbC7hIJiIMfp9V5aFK+2b
         wpH8QkpoDQtZhvmzxsWAjtEjfFAG04UnBEnrY5EQxjMLejKB7iUifTqZatBO2Yzywrwo
         0PdCfDLe8FRgP9kCkl7OfsaTpim0QvOCsYI1ZpyvFxa5ikLM5fFKqY8mH9kN9Tnuv8R/
         W2OQ==
X-Gm-Message-State: AOAM533D7jm0iBSy7fKDExeG2BrCACAnoE6SeYxXOC5TZvt7zpAeqXkT
        U3wT3bDmkhfWMNZ2ffgO7gOnABHHAnQE2BYvXIU=
X-Google-Smtp-Source: ABdhPJwN51B5Jz9GPd1Td+1daHHzXNsyC0GJP6uVNYUjLu+HAtGA4EkAFyDQEaULyPP+VRwikcefw4Mp+6cQjITHPZ0=
X-Received: by 2002:a9d:6b8d:: with SMTP id b13mr2435445otq.316.1621309352499;
 Mon, 17 May 2021 20:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
 <pull.859.v2.git.1620094339.gitgitgadget@gmail.com> <887b151c26ff0f175f2da431d77cd377bd066990.1620094339.git.gitgitgadget@gmail.com>
 <30c23689-cdab-143e-159c-93e50c808430@gmail.com>
In-Reply-To: <30c23689-cdab-143e-159c-93e50c808430@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 May 2021 20:42:21 -0700
Message-ID: <CABPp-BHpLBjyxsb+BM+ssZVHRJnn+DjazSQi6bHRXHET1vqGhg@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] fast-rebase: write conflict state to working
 tree, index, and HEAD
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 17, 2021 at 6:32 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 5/3/21 10:12 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Previously, when fast-rebase hit a conflict, it simply aborted and left
> > HEAD, the index, and the working tree where they were before the
> > operation started.  While fast-rebase does not support restarting from a
> > conflicted state, write the conflicted state out anyway as it gives us a
> > way to see what the conflicts are and write tests that check for them.
> >
> > This will be important in the upcoming commits, because sequencer.c is
> > only superficially integrated with merge-ort.c; in particular, it calls
> > merge_switch_to_result() after EACH merge instead of only calling it at
> > the end of all the sequence of merges (or when a conflict is hit).  This
> > not only causes needless updates to the working copy and index, but also
> > causes all intermediate data to be freed and tossed, preventing caching
> > information from one merge to the next.  However, integrating
> > sequencer.c more deeply with merge-ort.c is a big task, and making this
> > small extension to fast-rebase.c provides us with a simple way to test
> > the edge and corner cases that we want to make sure continue working.
>
> This seems a noble goal. I'm worried about the ramifications of such
> a change, specifically about the state an automated process would be in
> after hitting a conflict.

Why would an automated process be using test-helper code?  Note that
this is code from t/helper/test-fast-rebase.c.

> If I understand correctly, then the old code would abort the rebase and
> go back to the previous HEAD location. The new code will pause the
> rebase at the previous commit and leave the conflict markers in the
> working directory.

Correct; it now behaves slightly more like a "normal" rebase, but it
still doesn't write state files necessary for resuming the rebase
operation.

> The critical change is here:
>
> > -     strbuf_addf(&reflog_msg, "finish rebase %s onto %s",
> > -                 oid_to_hex(&last_picked_commit->object.oid),
> > -                 oid_to_hex(&last_commit->object.oid));
> > -     if (update_ref(reflog_msg.buf, branch_name.buf,
> > -                    &last_commit->object.oid,
> > -                    &last_picked_commit->object.oid,
> > -                    REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
> > -             error(_("could not update %s"), argv[4]);
> > -             die("Failed to update %s", argv[4]);
> > +     if (result.clean) {
> > +             fprintf(stderr, "\nDone.\n");
> > +             strbuf_addf(&reflog_msg, "finish rebase %s onto %s",
> > +                         oid_to_hex(&last_picked_commit->object.oid),
> > +                         oid_to_hex(&last_commit->object.oid));
> > +             if (update_ref(reflog_msg.buf, branch_name.buf,
> > +                            &last_commit->object.oid,
> > +                            &last_picked_commit->object.oid,
> > +                            REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
> > +                     error(_("could not update %s"), argv[4]);
> > +                     die("Failed to update %s", argv[4]);
> > +             }
> > +             if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
> > +                     die(_("unable to update HEAD"));
> > +             strbuf_release(&reflog_msg);
> > +             strbuf_release(&branch_name);
> > +
> > +             prime_cache_tree(the_repository, the_repository->index,
> > +                              result.tree);
> > +     } else {
> > +             fprintf(stderr, "\nAborting: Hit a conflict.\n");
> > +             strbuf_addf(&reflog_msg, "rebase progress up to %s",
> > +                         oid_to_hex(&last_picked_commit->object.oid));
> > +             if (update_ref(reflog_msg.buf, "HEAD",
> > +                            &last_commit->object.oid,
> > +                            &head,
> > +                            REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
> > +                     error(_("could not update %s"), argv[4]);
> > +                     die("Failed to update %s", argv[4]);
> > +             }
> >       }
> > -     if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
> > -             die(_("unable to update HEAD"));
> > -     strbuf_release(&reflog_msg);
> > -     strbuf_release(&branch_name);
> > -
> > -     prime_cache_tree(the_repository, the_repository->index, result.tree);
>
> So perhaps this could use a test case to demonstrate the change in
> behavior? Such a test would want to be created before this commit, then
> the behavior change is provided as an edit to the test in this commit.
>
> But maybe I'm misunderstanding the change here and such a test is
> inappropriate.

If this weren't code under t/helper/, I'd agree whole-heartedly with
the suggestion.
