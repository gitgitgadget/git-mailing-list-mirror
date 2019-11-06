Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A87A1F4C3
	for <e@80x24.org>; Wed,  6 Nov 2019 04:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbfKFEgg (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 23:36:36 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41309 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfKFEgf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 23:36:35 -0500
Received: by mail-ed1-f65.google.com with SMTP id a21so18185191edj.8
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 20:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YFSVFtretXJcAuEMBkWq6CGsnEAeQNKAXhRUrzefoCI=;
        b=ODuTj00FcyfA4j64IlbQEdb8P+jZdi4IuqnNS9KeSGKXT51ok1rdjIlYcIkdjHXTmY
         zkcZduJGMscyYbIMBzWjqdMPYObQTB1O9hlKZ295ENsXsrXQUbP6gcRKf28hry87Mg9G
         Ci6OE97KIsw72C2zumgjUFgzs5RZVr4p9CukY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YFSVFtretXJcAuEMBkWq6CGsnEAeQNKAXhRUrzefoCI=;
        b=TzH/KzhpsGioTn0rM1M1ORR11ehmtumU+mCoxnGw1A66rhgIDMdknILAIj1pAhsLwN
         mWmFCy9fvnFRS+H2DGN32kBN5AqDsUuxjhgAKtRhh4vHHok5hAR80Jwc9ojIbmXAPwAr
         OpZvCCVMdaj87ykREtaD/GhXTOoktuCFnFI163DF7xhDp+7b3ppC9HssWLUniU2g1JoH
         BdKOySRI/HFco503GooT82gefHe2bsb6C6ZjEhMYY2Sa61UvFAhkacjrLNxJDkj7dU2g
         LbxYZw+p5Zckm6QSeLnnNeHcNFAFKFUj3EtQEPqsc9+R45zTE0/qYYKRPd5svI8b2Fdk
         Kkhw==
X-Gm-Message-State: APjAAAVPzdBupk0RuL882L4o8FfjVqneveqv9WrsEX5+uJvfIN5Q1J4G
        qLrn8BAXy6EEgNJxheWRE4Z1DqCLzjyJKWEGzdv9NQvicCON7Q==
X-Google-Smtp-Source: APXvYqxSbngnAZ+HbDzt3vv6FZFuNRVwIyuzKgRUGQ9oXU3+FdtoV8mCNvvspGwqloCNgmQOKW/hBEqmuCgbNLM8zD0=
X-Received: by 2002:aa7:c303:: with SMTP id l3mr480137edq.89.1573014991959;
 Tue, 05 Nov 2019 20:36:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.424.git.1572017008.gitgitgadget@gmail.com>
 <pull.424.v2.git.1572967644.gitgitgadget@gmail.com> <f76ba554ed25fb9877a223ef6481834f1831c8ca.1572967644.git.gitgitgadget@gmail.com>
 <BN6PR21MB07869D880E1D0111F1A80E42917E0@BN6PR21MB0786.namprd21.prod.outlook.com>
In-Reply-To: <BN6PR21MB07869D880E1D0111F1A80E42917E0@BN6PR21MB0786.namprd21.prod.outlook.com>
From:   Utsav Shah <utsav@dropbox.com>
Date:   Tue, 5 Nov 2019 20:36:21 -0800
Message-ID: <CAPYzU3PLVhGWcautao1oenbKbgcOB_99PoyVEcK1hnUk5XErKg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] unpack-trees: skip stat on fsmonitor-valid files
To:     Kevin Willford <Kevin.Willford@microsoft.com>
Cc:     Utsav Shah via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Utsav Shah <ukshah2@illinois.edu>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 5, 2019 at 1:40 PM Kevin Willford
<Kevin.Willford@microsoft.com> wrote:
>
> > Sent: Tuesday, November 5, 2019 8:27 AM
> > From: Utsav Shah <utsav@dropbox.com>
> >
> > diff --git a/t/t7113-post-index-change-hook.sh b/t/t7113-post-index-change-
> > hook.sh
> > index f011ad7eec..5ca2279d0d 100755
> > --- a/t/t7113-post-index-change-hook.sh
> > +++ b/t/t7113-post-index-change-hook.sh
> > @@ -50,9 +50,6 @@ test_expect_success 'test status, add, commit, others
> > trigger hook without flags
> >       git checkout -- dir1/file1.txt &&
> >       test_path_is_file testsuccess && rm -f testsuccess &&
> >       test_path_is_missing testfailure &&
> > -     git update-index &&
> > -     test_path_is_missing testsuccess &&
> > -     test_path_is_missing testfailure &&
> >       git reset --soft &&
> >       test_path_is_missing testsuccess &&
> >       test_path_is_missing testfailure
>
> Looking into this change and I wonder if instead we should be updating
> refresh_fsmonitor to only update istate->cache_changed if there was an
> entry where CE_FSMONITOR_VALID was turned off.
>
> The reason I bring this up is because with this change, the post-index-change
> hook will behave differently depending on fsmonitor.  It will pass if
> GIT_TEST_FSMONITOR is unset or set to fsmonitor-watchman. But when set
> to fsmonitor-all it will fail because it is going down the code path that
> invalidates all the entries and sets istate->cache_changed.

Thanks, this observation was correct. v3 of this patch will check if
the index actually needs to mark its cache as changed, and this test
passes without modification.

>
> > diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh index
> > d8df990972..9cac3d3d8e 100755
> > --- a/t/t7519-status-fsmonitor.sh
> > +++ b/t/t7519-status-fsmonitor.sh
> > @@ -106,6 +106,8 @@ EOF
> >
> >  # test that "update-index --fsmonitor-valid" sets the fsmonitor valid bit
> > test_expect_success 'update-index --fsmonitor-valid" sets the fsmonitor
> > valid bit' '
> > +     write_script .git/hooks/fsmonitor-test<<-\EOF &&
> > +     EOF
> >       git update-index --fsmonitor &&
> >       git update-index --fsmonitor-valid dir1/modified &&
> >       git update-index --fsmonitor-valid dir2/modified && @@ -164,6
> > +166,8 @@ EOF
> >
> >  # test that newly added files are marked valid  test_expect_success 'newly
> > added files are marked valid' '
> > +     write_script .git/hooks/fsmonitor-test<<-\EOF &&
> > +     EOF
> >       git add new &&
> >       git add dir1/new &&
> >       git add dir2/new &&
> > @@ -218,11 +222,12 @@ test_expect_success '*only* files returned by the
> > integration script get flagged  # Ensure commands that call refresh_index() to
> > move the index back in time  # properly invalidate the fsmonitor cache
> > test_expect_success 'refresh_index() invalidates fsmonitor cache' '
> > -     write_script .git/hooks/fsmonitor-test<<-\EOF &&
> > -     EOF
> >       clean_repo &&
> > +     write_integration_script &&
> >       dirty_repo &&
> >       git add . &&
> > +     write_script .git/hooks/fsmonitor-test<<-\EOF &&
> > +     EOF
> >       git commit -m "to reset" &&
> >       git reset HEAD~1 &&
> >       git status >actual &&
>
> We need to take a close look at all the tests in
> t7519-status-fsmonitor.sh and see if we are doing the right thing with
> these changes because before most commands that read the
> index would only apply the bits from the fsmonitor bitmap to
> the cache entries.  Whereas now, it does that but also applies what the
> fsmonitor hooks returns so the content of .git/hooks/fsmonitor-test is
> now affecting tests and commands where it was not before.
>
> So if .git/hooks/fsmonitor-test has paths even git ls-files gets those
> paths marked dirty and that command is being used to validate the state of
> the CE_FSMONITOR_VALID.  So I think in most cases for these tests we
> want the .git/hooks/fsmonitor-test to be empty before calling git ls-files
> so that doesn't change the index state.

I audited these tests very closely, and to the best of my knowledge,
the modifications made are valid.

For test failures of

test_expect_success 'update-index --fsmonitor-valid sets the fsmonitor
valid bit'
test_expect_success 'newly added files are marked valid'

It's relatively straightforward that our patch now runs the fsmonitor
hook so we need to make sure the hook doesn't return anything.

The trickiest case was "refresh_index()" test, and I've made a slight
change to make it clearer why that test was failing.

@@ -218,11 +222,12 @@ test_expect_success '*only* files returned by
the integration script get flagged
 # Ensure commands that call refresh_index() to move the index back in time
 # properly invalidate the fsmonitor cache
 test_expect_success 'refresh_index() invalidates fsmonitor cache' '
-       write_script .git/hooks/fsmonitor-test<<-\EOF &&
-       EOF
        clean_repo &&
        dirty_repo &&
+       write_integration_script &&
        git add . &&
+       write_script .git/hooks/fsmonitor-test<<-\EOF &&
+       EOF
        git commit -m "to reset" &&
        git reset HEAD~1 &&
        git status >actual &&

With patch v2, git add was failing to add all files, since it now
consults the fsmonitor hook which wrongly implied that no files were
modified. This was rectified by the write_integration_script. After
that, we immediately ensure that the test fsmonitor doesn't return any
files, and the test passes.


>
> >
> >       if (old && same(old, a)) {
> >               int update = 0;
> > -             if (o->reset && o->update && !ce_uptodate(old) &&
> > !ce_skip_worktree(old)) {
> > +             if (o->reset && o->update && !ce_uptodate(old) &&
> > !ce_skip_worktree(old) &&
> > +                     !(old->ce_flags & CE_FSMONITOR_VALID)) {
> >                       struct stat st;
> >                       if (lstat(old->name, &st) ||
> >                           ie_match_stat(o->src_index, old, &st,
> > CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE))
>
> FYI I have been testing with the ce_uptodate macro checking the
> CE_FSMONITOR_VALID flag instead and only have failures when using
> the fsmonitor-watchman script which I'm not sure if all the tests were
> ever passing using it.
>

Yeah, I see the same results.

The one part that I don't fully understand if safe is copying over the
o->src_index->fsmonitor_last_update to the result index in
unpack-trees. I don't understand the implications of that, and if
that's the only field worth copying over, or if we should be copying
over other fields like the bitmap as well.
