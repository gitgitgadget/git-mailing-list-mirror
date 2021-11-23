Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED087C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 18:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239365AbhKWSW3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 13:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbhKWSW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 13:22:29 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42A1C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 10:19:20 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id m17-20020a170902db1100b001421cb34857so9390052plx.15
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 10:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FrgZD5aWDWQdvl8X88DjDRYDBylXwekNznqFn2/NYEE=;
        b=EECtx0fvn/vxpSzbEPT4JFZ5OXxMdDZY52nzitU3x6tNZIDiDE7PDiMHRX/PpYVuaE
         leQ1It2UbMyLE6CZtEuzjI4SktCHwrj6EJA+9N0f8mcxdiWvGoB4CKL2Lv0aTBsaPoze
         gWx1z2Lu+NtR7Ajjal/0Bzqk131MbqazcBjCOIEWmvO9uBDYFBDOC8/VxxNxsitiBiAG
         YpefwS98I13qD4oS7+lY65NHzOzxC0nHHOzW3K5KKDrthFzUZBFg0pcRXc7HwgogOBIv
         C+KvKbgkmKESAZq6qAdHBFZuuGThRmGMHgE31sMLpRUqapC4O4Wv0WjYU8kaPLNbeG2K
         saJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FrgZD5aWDWQdvl8X88DjDRYDBylXwekNznqFn2/NYEE=;
        b=K60lkF050m0HDT4IVABpo8xAV+6q+hta/o4I1k+wqWhE71CXCGMJXBRtdCKDyES5yw
         efxabJqFJ5AF4/s7wo3eUSMKMuIbO05cWJUslLZR03iKd+FsNYRI/R133UOtfD+PoEAB
         tgMHda/0gcluNdaUi/Dd0OQcZPKkiUh7aguFn8iQa4PA4vgQ1DN7UmlpU5uOabMiB9Zf
         uqlxvbYsPDhzPq9WI4R/nWCCQCaHSbzIypKiN54YU33Zj7F0Tz74yAOHWauWR0iF0/kf
         MSgc9uun2TFH2a2DrmQZNKb30YwPkLkouS2aSs/z5EpvpsVjZdtLEfI9jRhSzPvbOkhf
         jH7A==
X-Gm-Message-State: AOAM533Wq0QlxBW/aV7QuvD2l71QEnWeRXiIM0paNjkOik/P2q6tHQTQ
        99/rDLB3qAlp8AmpvkYFg7fopVB6aHMSeQ==
X-Google-Smtp-Source: ABdhPJyZynO0SoySZlY0MBBYIzMjNJq/du72+kvAAfQUQeT9Rk8qEp+yvccscPXGj3T+1AuRSj9HvFHuwtvFQQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:6b47:b0:142:82e1:6c92 with SMTP
 id g7-20020a1709026b4700b0014282e16c92mr9656537plt.84.1637691560360; Tue, 23
 Nov 2021 10:19:20 -0800 (PST)
Date:   Tue, 23 Nov 2021 10:19:18 -0800
In-Reply-To: <CABPp-BE0Bcimwr1wwcnnh+6apx7r114Oqnu=QDgKEn6VAHAtFg@mail.gmail.com>
Message-Id: <kl6lmtluka55.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <a5528cbb14ddbbf26cde873e3f3e95744d59b950.1637455620.git.gitgitgadget@gmail.com>
 <20211123003958.3978-1-chooglen@google.com> <CABPp-BE0Bcimwr1wwcnnh+6apx7r114Oqnu=QDgKEn6VAHAtFg@mail.gmail.com>
Subject: Re: [PATCH 8/8] dir: avoid removing the current working directory
From:   Glen Choo <chooglen@google.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> I don't think it's appropriate to implement user-facing concern (don't remove
>> cwd because this will confuse users) in library functions like remove_path().
>> remove_path() has other callers e.g. midx.c, and possible future callers e.g.
>> we're working on adding a command to delete corrupted commit-graphs and this
>> library function would be extremely handy.
>
> I think we'd want this code change for those cases too.  Said another
> way, why wouldn't these callers want to avoid deleting the original
> current working directory of the git process (which is likely still
> the current working directory of the parent process)?  Deleting that
> directory causes problems regardless of whether it's a user-facing
> command (rm, merge, stash, etc.) or something more internal (midx or
> commit-graphs stuff being called by gc) that is doing the deleting.

I agree that most, possibly all, of our commands should prefer to die
than to remove the cwd, but that doesn't justify adding
application-level concerns to a general-purpose utility function. Even
if it sounds overly defensive, having an obviously correct utility
function makes it easier for future authors to know exactly what their
code is doing and why. And surely if we're imaginative enough, we can
definitely dream up some possible use cases for remove_path() that don't
want this dying behavior e.g. other applications that link to our
libraries, or some new merge strategy that may need to remove + restore
the cwd.

I'm not going to say that we'll *definitely* need remove_path()
in its current form, but mixing concerns like this is an invitation to
unexpected behavior. An (imperfect) example that demonstrates this
principle is https://lore.kernel.org/git/24bffdab139435173712101aaf72f7277298c99d.1632497954.git.gitgitgadget@gmail.com/,
where we made a change to a generic path matching function in order to
speed up unpack_trees(), but accidentally ended up breaking gitignore.

> Putting it in this helper function means we protect all current and
> future callers without developers having to remember which
> "remove_path()" variant they need and why.

Code comments sound like adequate protection to me. Fudging the names a
little..

  /*
   * Pretend we have utility function that generalizes
   * check-then-delete (though we probably won't need it).
   */
  static int remove_path_conditionally(const char *name, check_path_fn can_delete_path);

  /**
   * This is identical to remove_path(), except that it will die if
   * attempting to remove the_cwd. When writing Git commands, prefer
   * using this over remove_path() so that we don't delete the cwd and
   * leave the user in a confusing state.
   */
  int remove_path_except_cwd(const char *name)
  {
    return remove_path_conditionally(name, die_on_cwd);
  }

  /*
   * Tries to remove the path with empty directories along it, ignores
   * ENOENT. Unless you really need to remove the path unconditionally,
   * consider using remove_path_except_cwd() instead.
   */
  int remove_path(const char *name);

>> It seems more appropriate to check the_cwd from builtin/add.c and builtin/rm.c
>> instead.
>
> Not sure how you determined that those two paths are affected or that
> those are the only two.

Typo: s/add/apply.

I took the example from your test cases:

  diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
  index ff4e7cd89fa..4362e7b15e5 100755
  --- a/t/t2501-cwd-empty.sh
  +++ b/t/t2501-cwd-empty.sh
  @@ -191,7 +191,7 @@ test_expect_success 'revert fails if cwd needs to be removed' '
    test_path_is_dir dirORfile
   '
 
  -test_expect_failure 'rm does not remove cwd incidentally' '
  +test_expect_success 'rm does not remove cwd incidentally' '
    test_when_finished "git reset --hard" &&
    git checkout foo/bar/baz &&
 
  @@ -205,7 +205,7 @@ test_expect_failure 'rm does not remove cwd incidentally' '
    test_path_is_dir foo
   '
 
  -test_expect_failure 'apply does not remove cwd incidentally' '
  +test_expect_success 'apply does not remove cwd incidentally' '
    test_when_finished "git reset --hard" &&
    git checkout foo/bar/baz &&

I read this as "I made these changes in order to make these tests pass".
I really like the 'TDD-ish' approach you used in this series; as a
reader, it gave me a clear idea of the expected outcome of your changes.
From that perspective, the fact that there are certainly untested paths
which are affected takes away some of the benefits of this approach.
