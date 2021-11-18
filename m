Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30C8C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 00:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0EBC61549
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 00:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242030AbhKRA4n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 19:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhKRA4k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 19:56:40 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119D2C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 16:53:41 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id z19-20020aa79593000000b0049472f5e52dso2566293pfj.13
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 16:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OsAsUOBKltg9rmY2DdDfoGPLh6OvrJzafDUiQtOEdLc=;
        b=dSFg0JPjBYkpz+wWcEZgKlBTxQSP6z5KUs5AvknRm5Cw963gSehkT0TAeOSLten/hL
         shoMllumo1dEivt1jMx6UP5yQnAuTIgaRBuh2v04IAmZhaHW1mD4QwAthKBDEU/Rr1Aa
         3oHYgN8wBbhRpcWNOHuPOx+Y9pY74AyRI5lxsT6JwfQ+qNxHHdgtxo3bZMJS1+/huxkL
         RYkMMqYB0rVv/0jZzR5eRrOQhmQP/cgcvI0asdjrF4WJG5zmyfcfLHFt/UqSdEveZy7F
         Y0Zmg72u6h+3tMuTLAjxrMqrkl2y6Aq8dLq0PzXNn+j1SrK8EIfbVjhJWnlkJwP5VNOL
         VYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OsAsUOBKltg9rmY2DdDfoGPLh6OvrJzafDUiQtOEdLc=;
        b=JZioMfnlW7qjiv4qm4m6I+HddmurxLZJwrz5MsYvqqJK1nArvREswmkGpNrPX9EJHW
         47Lf5eLVbdCGGOkya/o/bYT2T67RAVyD1HKeC70ENGbthqgyLygAbIaZbVumM0w1ZaRx
         0S4AmcxunymgPNZRkGAzltZstg4cQiuzYlh/ywoEX0l414V4pwVWQWtN467vWxVIqh3g
         M9u59/TrtBah5gCDtHFpP9ZoQELCr+W99MwvMLuHcIuIY0wRzlEbUeKKF183INE4ILC8
         dmMmrmRcYChS8OGRt0yTwweph1tQqREZxbmmNmNmddGXjSL8Z+KYg72sZ5G+GeJ5/1jY
         UK9w==
X-Gm-Message-State: AOAM5313tfTGqEnjA5kMhiVim1uIeUdcgnyAiTMGTd29L/eSgLa1rd80
        Ocu34Pt6UqCO3DuG+AAehpxOWXSY6MiX2S/Xa5vqLSYwa5BQ1adQbK+lbTo2stIAb/aPaVeb0Fb
        YPrCYoEbTdKnjPdffSh5i8uSMszMKMwAUYvOovaBhqxtoVE+YsMKI55UyoGucN2Y=
X-Google-Smtp-Source: ABdhPJzLGdhEa+en5ShMBOwtL3U+eWHtdn9R6mJRBO4Fz8uc2BKgjOmd7zchp9uT+DEOePBnHn35swjPNSWRwA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4acd:: with SMTP id
 mh13mr5318757pjb.230.1637196820050; Wed, 17 Nov 2021 16:53:40 -0800 (PST)
Date:   Wed, 17 Nov 2021 16:53:20 -0800
In-Reply-To: <id:20211028183101.41013-1-chooglen@google.com>
Message-Id: <20211118005325.64971-1-chooglen@google.com>
Mime-Version: 1.0
References: <id:20211028183101.41013-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v5 0/5] remote: replace static variables with struct remote_state
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series aims to make the remotes subsystem work with non-the_repository,
which will allow submodule remotes to be accessed in-process, rather than
through child processes. This is accomplished by creating a struct remote_state
and adding it to struct repository.

Thanks for the kind review, Jonathan. I've incorporated most of the feedback
from v4, except squashing patches 2-4. My reasoning is that those changes are
mechanical and keeping them separate makes it more obvious whether or not each
step has been done correctly. However, I agree that they are just intermediate
steps that touch the same lines, so I am happy to squash them if other reviewers
prefer that.

Changes since v4:
* Fixed an incorrect description of 'git push' without explicit refspecs
* In patch 5, remove the branches array and keep the hashmap (note that I did
  not make a similar change to remotes)
* Drop patch 6 because it is untested in this series (will incorporate into a
  future series)

Changes since v3:
* Add a test case for pushing to a remote in detached HEAD. This test
  would have caught the segfault that resulted in this reroll.
* Remove the NEEDSWORK saying that init_remotes_hash() should be moved
  into remote_state_new() and just do it.
* Remove the backpointer to remote_state and add a remote_state
  parameter instead.
* In patch 4, add more remotes_* functions. These functions were not
  needed in v3 because of the backpointer.
* In patch 5, add a function that checks if a branch is in a repo. Add a
  branch hashmap that makes this operation fast.
* In patch 6, add more repo_* functions. These functions were not needed
  in v3 because of the backpointer.

Changes since v2:
* Add .remote_state to struct branch and struct remote, changing the
  implementation appropriately.
* In patch 2, properly consider the initialized state of remote_state.
  In v2, I forgot to convert a static inside read_config() into a
  private member of struct remote_state. Fix this.
* In a new patch 3, add helper methods that get a remote via
  remote_state and the remote name.
* Move read_config(repo) calls to the external facing-functions. This keeps
  "struct repository" away from the remote.c internals.

Changes since v1:
* In v1, we moved static variables into the_repository->remote_state in
  two steps: static variables > static remote_state >
  the_repository->remote_state. In v2, make this change in one step:
  static variables > the_repository->remote_state.
* Add more instances of repo_* that were missed.

Glen Choo (5):
  t5516: add test case for pushing remote refspecs
  remote: move static variables into per-repository struct
  remote: use remote_state parameter internally
  remote: remove the_repository->remote_state from static methods
  remote: die if branch is not found in repository

 remote.c              | 368 +++++++++++++++++++++++++++++-------------
 remote.h              |  35 ++++
 repository.c          |   8 +
 repository.h          |   4 +
 t/t5516-fetch-push.sh |   9 ++
 5 files changed, 311 insertions(+), 113 deletions(-)

Range-diff against v4:
1:  9b29ec27c6 ! 1:  7e60457e11 t5516: add test case for pushing remote refspecs
    @@ Metadata
      ## Commit message ##
         t5516: add test case for pushing remote refspecs
     
    -    In detached HEAD, "git push remote-name" should push the refspecs in
    -    remote.remote-name.push. Since there is no test case that checks this
    -    behavior, add one.
    +    "git push remote-name" (that is, with no refspec given on the command
    +    line) should push the refspecs in remote.remote-name.push. There is no
    +    test case that checks this behavior in detached HEAD, so add one.
     
         Signed-off-by: Glen Choo <chooglen@google.com>
     
    @@ t/t5516-fetch-push.sh: do
      
      done
      
    -+test_expect_success "push to remote with detached HEAD and config remote.*.push = src:dest" '
    ++test_expect_success "push to remote with no explicit refspec and config remote.*.push = src:dest" '
     +	mk_test testrepo heads/main &&
     +	git checkout $the_first_commit &&
     +	test_config remote.there.url testrepo &&
2:  ca9b5ab66a = 2:  ecc637ee74 remote: move static variables into per-repository struct
3:  5d6a245cae = 3:  a915155979 remote: use remote_state parameter internally
4:  53f2e31f72 = 4:  8ef43570e9 remote: remove the_repository->remote_state from static methods
5:  d3281c14eb ! 5:  8bb7bddda4 remote: die if branch is not found in repository
    @@ Commit message
     
         To prevent misuse, add a die_on_missing_branch() helper function that
         dies if a given branch is not from a given repository. Speed up the
    -    existence check by using a new branches_hash hashmap to remote_state,
    -    and use the hashmap to remove the branch array iteration in
    -    make_branch().
    +    existence check by replacing the branches list with a branches_hash
    +    hashmap.
     
         Like read_config(), die_on_missing_branch() is only called from
         non-static functions; static functions are less prone to misuse because
    @@ remote.c: static void add_merge(struct branch *branch, const char *name)
     +	if (ret)
     +		return ret;
      
    - 	ALLOC_GROW(remote_state->branches, remote_state->branches_nr + 1,
    - 		   remote_state->branches_alloc);
    -@@ remote.c: static struct branch *make_branch(struct remote_state *remote_state,
    +-	ALLOC_GROW(remote_state->branches, remote_state->branches_nr + 1,
    +-		   remote_state->branches_alloc);
    + 	CALLOC_ARRAY(ret, 1);
    +-	remote_state->branches[remote_state->branches_nr++] = ret;
      	ret->name = xstrndup(name, len);
      	ret->refname = xstrfmt("refs/heads/%s", ret->name);
      
    @@ remote.c: struct remote_state *remote_state_new(void)
      	return r;
      }
      
    +@@ remote.c: void remote_state_clear(struct remote_state *remote_state)
    + 	remote_state->remotes_nr = 0;
    + 
    + 	hashmap_clear_and_free(&remote_state->remotes_hash, struct remote, ent);
    +-
    +-	for (i = 0; i < remote_state->branches_nr; i++) {
    +-		FREE_AND_NULL(remote_state->branches[i]);
    +-	}
    +-	FREE_AND_NULL(remote_state->branches);
    +-	remote_state->branches_alloc = 0;
    +-	remote_state->branches_nr = 0;
    ++	hashmap_clear_and_free(&remote_state->branches_hash, struct remote, ent);
    + }
     
      ## remote.h ##
     @@ remote.h: struct remote_state {
    - 	struct branch **branches;
    - 	int branches_alloc;
    - 	int branches_nr;
    + 	int remotes_nr;
    + 	struct hashmap remotes_hash;
    + 
    +-	struct branch **branches;
    +-	int branches_alloc;
    +-	int branches_nr;
     +	struct hashmap branches_hash;
      
      	struct branch *current_branch;
6:  0974994cc6 < -:  ---------- remote: add struct repository parameter to external functions
-- 
2.33.GIT

