Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599B0126C01
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 21:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726262185; cv=none; b=bTN5xnmhL3vhOkmUcP2vhCMSMDAoBhcazpXb3xVRQzYLyNKtGIK1E5ugbphJ06Uy20i81Qypsg6qSsB+xNvmonLw7WDsom4WcqYIbsu3q0ROJf8cD++VDHEF8vrvwiS6wXEDoS12kvApcPgVQUR9Pi1fogKQvIfmVMTt4xz4ovE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726262185; c=relaxed/simple;
	bh=NWUUPUBBMgr/sOmjjgqZUsWiagG8js4Gq6/7wvluauI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SuaHAzkB2eTkYek/PKGiPo/bU8e+48uzk3sjHq92MiPmduZwTqojW43AkEuL9idna+dMTdC9w8w8q0cPwuRPviEyfuurLdaqI3K6mUzikwDi32x8eEiWypPi1F9jxO3o7e8CF/F1325hAlLQwGiSlwIbJnQjqpPWyw/hZCl/Hhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZLlG2d9; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZLlG2d9"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c251ba0d1cso2969397a12.3
        for <git@vger.kernel.org>; Fri, 13 Sep 2024 14:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726262181; x=1726866981; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBLS6tgfBG6EpUZ+2jQ0l/Qb+EhVoP9z0k9Mq/2A49c=;
        b=iZLlG2d9AmyMycWp7mojdP1NP9I3YICUHldETVJ9MNa4Yjlx/RMr+z6fdyQx+K1n7y
         dt486pntLF556IlLlITJN1kxr0CkeiRi3ghiEho0qeWzgmVqtYyjLWJe41BQ9nZm5l3S
         WzK/XqFDs5UOuE1FQUGweQhEZL6xb5mTfAUklTu0LVUJPaLTMgp0f/sxPJ1sBDilgW5i
         r2EyL253u9HLMRQ5QYalkb+YGUDmP06wmvz9twYPij6hqx+y6PH4+LqcyE6Eud0+/fPR
         ezoqAK/pf//kWyA/515I0BA0OLQwNUq3h089Ebw6Frh6qPa8zecCg48LWeYiKGgKvPLX
         vWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726262181; x=1726866981;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBLS6tgfBG6EpUZ+2jQ0l/Qb+EhVoP9z0k9Mq/2A49c=;
        b=pRfUcGpl1YkwffXdIWWUTIJFMlol/lpxCmUAgOfU4Q1SnzQkhy11gVtysDIuGCYt/Q
         IeYPBeFTjSHVF2ZQj6jyipihwslp2vsQklbw0mW8j97gXeNLLWugFSUf3mg8tWPgoAEe
         /EmYEiF8TZ2k/hSgKT6VNx1BNu+lUVnMlrblkmb9Y3o73gGvOnNUIQYNOxxGViZkI6Aq
         NsrWFYeHxqb+HB6/X7mS6P++WnkQyoi6A6I7HNZpT6pduTe85EUmCtVGAJheC1B8DpWn
         MJ41+Mfll5qgvhkzCi/Pqhs0GLfN25VYrSpGO68TZ9h1oDJzS5arZkP7+nftQcOKQvX7
         yJrQ==
X-Gm-Message-State: AOJu0YwrpjwTKjbVdWcK9lwypcGQRAj+EwN+YzZ8s0aAAeycGOcDUymx
	u2h0LyMsVvVLFAUQNI1vktbIonXccyC9iU6e2Hg2oTzN5kgi0JTtuMS8lg==
X-Google-Smtp-Source: AGHT+IH7SPh5pP9vrnJiMxv0Vjt3923iigcnv6VSgZPjUb5oHq5Rs/5hHy22skQyte4j3B5ieCL1WQ==
X-Received: by 2002:a17:907:c88d:b0:a80:f358:5d55 with SMTP id a640c23a62f3a-a90295a6a7cmr747730566b.33.1726262181049;
        Fri, 13 Sep 2024 14:16:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061331921sm710066b.223.2024.09.13.14.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 14:16:20 -0700 (PDT)
Message-Id: <pull.1778.v3.git.git.1726262177.gitgitgadget@gmail.com>
In-Reply-To: <pull.1778.v2.git.git.1726001960.gitgitgadget@gmail.com>
References: <pull.1778.v2.git.git.1726001960.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Sep 2024 21:16:13 +0000
Subject: [PATCH v3 0/4] Add repository parameter to builtins
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    John Cai <johncai86@gmail.com>

As part of the effort to remove global state of the_repository, add a
repository parameter to builtins so that a repository variable can be passed
down. The patches are ordered as follows:

 1. Changes the signature of builtins and passes the_repository down in
    git.c to be called by all builtins.
 2. Remove USE_THE_REPOSITORY_VARIABLE from builtin.h, and instead add it to
    each individual builtin. This paves the way for a migration process
    whereby each builtin can be migrated away from using the_repository.
 3. Remove USE_THE_REPOSITORY_VARIABLE from bulitins that do not use
    the_repository.
 4. As an example, migrate builtin/add.c to get rid of the_repository by
    instead passing the repository argument down into helper functions.

Changes since V2:

 * Add USE_THE_REPOSITORY_VARIABLE to all builtins under builtin/ that
   contain builtin.h, and subsequently add a patch that removes it from
   builtins that do not use the_repository.
 * removed random generated file

Changes since V1:

 * Removed USE_THE_REPOSITORY_VARIABLE from add.c
 * removed changes that conflict with existing topics in seen
 * Fixed overly long lines formatting issues

John Cai (4):
  builtin: add a repository parameter for builtin functions
  builtin: remove USE_THE_REPOSITORY_VARIABLE from builtin.h
  builtin: remove USE_THE_REPOSITORY for those without the_repository
  add: pass in repo variable instead of global the_repository

 builtin.h                          | 285 ++++++++++++++---------------
 builtin/add.c                      | 119 ++++++------
 builtin/am.c                       |   7 +-
 builtin/annotate.c                 |   9 +-
 builtin/apply.c                    |   7 +-
 builtin/archive.c                  |   7 +-
 builtin/bisect.c                   |   6 +-
 builtin/blame.c                    |   8 +-
 builtin/branch.c                   |   7 +-
 builtin/bugreport.c                |   6 +-
 builtin/bundle.c                   |   7 +-
 builtin/cat-file.c                 |   9 +-
 builtin/check-attr.c               |   7 +-
 builtin/check-ignore.c             |   7 +-
 builtin/check-mailmap.c            |   6 +-
 builtin/check-ref-format.c         |   6 +-
 builtin/checkout--worker.c         |   6 +-
 builtin/checkout-index.c           |   8 +-
 builtin/checkout.c                 |  16 +-
 builtin/clean.c                    |   8 +-
 builtin/clone.c                    |   8 +-
 builtin/column.c                   |   6 +-
 builtin/commit-graph.c             |   7 +-
 builtin/commit-tree.c              |   8 +-
 builtin/commit.c                   |  14 +-
 builtin/config.c                   |   7 +-
 builtin/count-objects.c            |   8 +-
 builtin/credential-cache--daemon.c |  11 +-
 builtin/credential-cache.c         |   5 +-
 builtin/credential-store.c         |   6 +-
 builtin/credential.c               |   7 +-
 builtin/describe.c                 |   8 +-
 builtin/diagnose.c                 |   5 +-
 builtin/diff-files.c               |   7 +-
 builtin/diff-index.c               |   7 +-
 builtin/diff-tree.c                |   7 +-
 builtin/diff.c                     |   7 +-
 builtin/difftool.c                 |   8 +-
 builtin/fast-export.c              |   6 +-
 builtin/fast-import.c              |   7 +-
 builtin/fetch-pack.c               |   6 +-
 builtin/fetch.c                    |   7 +-
 builtin/fmt-merge-msg.c            |   6 +-
 builtin/for-each-ref.c             |   6 +-
 builtin/for-each-repo.c            |   7 +-
 builtin/fsck.c                     |   7 +-
 builtin/fsmonitor--daemon.c        |  10 +-
 builtin/gc.c                       |  13 +-
 builtin/get-tar-commit-id.c        |   5 +-
 builtin/grep.c                     |   7 +-
 builtin/hash-object.c              |   6 +-
 builtin/help.c                     |   7 +-
 builtin/hook.c                     |   6 +-
 builtin/index-pack.c               |   6 +-
 builtin/init-db.c                  |   7 +-
 builtin/interpret-trailers.c       |   7 +-
 builtin/log.c                      |  33 +++-
 builtin/ls-files.c                 |   7 +-
 builtin/ls-remote.c                |   6 +-
 builtin/ls-tree.c                  |   7 +-
 builtin/mailinfo.c                 |   6 +-
 builtin/mailsplit.c                |   5 +-
 builtin/merge-base.c               |   7 +-
 builtin/merge-file.c               |   6 +-
 builtin/merge-index.c              |   7 +-
 builtin/merge-ours.c               |   8 +-
 builtin/merge-recursive.c          |   7 +-
 builtin/merge-tree.c               |   7 +-
 builtin/merge.c                    |  12 +-
 builtin/mktag.c                    |   6 +-
 builtin/mktree.c                   |   7 +-
 builtin/multi-pack-index.c         |   7 +-
 builtin/mv.c                       |   8 +-
 builtin/name-rev.c                 |   7 +-
 builtin/notes.c                    |   9 +-
 builtin/pack-objects.c             |   7 +-
 builtin/pack-redundant.c           |  10 +-
 builtin/pack-refs.c                |   7 +-
 builtin/patch-id.c                 |   6 +-
 builtin/prune-packed.c             |   5 +-
 builtin/prune.c                    |   6 +-
 builtin/pull.c                     |   6 +-
 builtin/push.c                     |   7 +-
 builtin/range-diff.c               |   8 +-
 builtin/read-tree.c                |   8 +-
 builtin/rebase.c                   |   8 +-
 builtin/receive-pack.c             |   8 +-
 builtin/reflog.c                   |  11 +-
 builtin/refs.c                     |   7 +-
 builtin/remote-ext.c               |   5 +-
 builtin/remote-fd.c                |   5 +-
 builtin/remote.c                   |   6 +-
 builtin/repack.c                   |   6 +-
 builtin/replace.c                  |   8 +-
 builtin/replay.c                   |   6 +-
 builtin/rerere.c                   |   8 +-
 builtin/reset.c                    |   7 +-
 builtin/rev-list.c                 |   6 +-
 builtin/rev-parse.c                |   8 +-
 builtin/revert.c                   |  12 +-
 builtin/rm.c                       |   9 +-
 builtin/send-pack.c                |   6 +-
 builtin/shortlog.c                 |   7 +-
 builtin/show-branch.c              |   8 +-
 builtin/show-index.c               |   7 +-
 builtin/show-ref.c                 |   6 +-
 builtin/sparse-checkout.c          |   7 +-
 builtin/stash.c                    |   6 +-
 builtin/stripspace.c               |   6 +-
 builtin/submodule--helper.c        |   8 +-
 builtin/symbolic-ref.c             |   6 +-
 builtin/tag.c                      |   7 +-
 builtin/unpack-file.c              |   6 +-
 builtin/unpack-objects.c           |   6 +-
 builtin/update-index.c             |   8 +-
 builtin/update-ref.c               |   7 +-
 builtin/update-server-info.c       |   6 +-
 builtin/upload-archive.c           |  12 +-
 builtin/upload-pack.c              |   5 +-
 builtin/var.c                      |   7 +-
 builtin/verify-commit.c            |   7 +-
 builtin/verify-pack.c              |   6 +-
 builtin/verify-tag.c               |   6 +-
 builtin/worktree.c                 |   7 +-
 builtin/write-tree.c               |   8 +-
 commit.h                           |   5 +-
 git.c                              |  12 +-
 help.c                             |   3 +-
 128 files changed, 903 insertions(+), 437 deletions(-)


base-commit: 57974d46a4d5a079471c4f7eaa5933b1922299e4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1778%2Fjohn-cai%2Fjc%2Fadd-the-repository-to-builtin-signature-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1778/john-cai/jc/add-the-repository-to-builtin-signature-v3
Pull-Request: https://github.com/git/git/pull/1778

Range-diff vs v2:

 1:  9aaf9662544 ! 1:  02a4466ecc9 builtin: add a repository parameter for builtin functions
     @@ builtin/fetch-pack.c: static void add_sought_entry(struct ref ***sought, int *nr
      +		   struct repository *repo UNUSED)
       {
       	int i, ret;
     - 	struct ref *ref = NULL;
     + 	struct ref *fetched_refs = NULL, *remote_refs = NULL;
      
       ## builtin/fetch.c ##
      @@ builtin/fetch.c: static int fetch_one(struct remote *remote, int argc, const char **argv,
     @@ help.c: void get_version_info(struct strbuf *buf, int show_build_options)
       {
       	struct strbuf buf = STRBUF_INIT;
       	int build_options = 0;
     -
     - ## stkOs5Qh (new) ##
     - Binary files /dev/null and stkOs5Qh differ
 2:  434c8babbb1 ! 2:  7becd3751fc builtin: remove USE_THE_REPOSITORY_VARIABLE from builtin.h
     @@ builtin/check-mailmap.c
       #include "config.h"
       #include "gettext.h"
      
     + ## builtin/check-ref-format.c ##
     +@@
     + /*
     +  * GIT - The information manager from hell
     +  */
     +-
     ++#define USE_THE_REPOSITORY_VARIABLE
     + #include "builtin.h"
     + #include "refs.h"
     + #include "setup.h"
     +
       ## builtin/checkout--worker.c ##
      @@
      +#define USE_THE_REPOSITORY_VARIABLE
     @@ builtin/credential-cache--daemon.c
       #include "abspath.h"
       #include "gettext.h"
      
     + ## builtin/credential-cache.c ##
     +@@
     ++#define USE_THE_REPOSITORY_VARIABLE
     + #include "builtin.h"
     + #include "credential.h"
     + #include "gettext.h"
     +
       ## builtin/credential-store.c ##
      @@
      +#define USE_THE_REPOSITORY_VARIABLE
     @@ builtin/describe.c
       #include "config.h"
       #include "environment.h"
      
     + ## builtin/diagnose.c ##
     +@@
     ++#define USE_THE_REPOSITORY_VARIABLE
     + #include "builtin.h"
     + #include "abspath.h"
     + #include "gettext.h"
     +
       ## builtin/diff-files.c ##
      @@
        *
     @@ builtin/gc.c
       #include "tempfile.h"
       #include "lockfile.h"
      
     + ## builtin/get-tar-commit-id.c ##
     +@@
     + /*
     +  * Copyright (c) 2005, 2006 Rene Scharfe
     +  */
     ++#define USE_THE_REPOSITORY_VARIABLE
     + #include "builtin.h"
     + #include "commit.h"
     + #include "tar.h"
     +
       ## builtin/grep.c ##
      @@
        *
     @@ builtin/mailinfo.c
       #include "abspath.h"
       #include "environment.h"
      
     + ## builtin/mailsplit.c ##
     +@@
     +  * It just splits a mbox into a list of files: "0001" "0002" ..
     +  * so you can process them further from there.
     +  */
     ++#define USE_THE_REPOSITORY_VARIABLE
     + #include "builtin.h"
     + #include "gettext.h"
     + #include "string-list.h"
     +
       ## builtin/merge-base.c ##
      @@
      +#define USE_THE_REPOSITORY_VARIABLE
     @@ builtin/patch-id.c
       #include "config.h"
       #include "diff.h"
      
     + ## builtin/prune-packed.c ##
     +@@
     ++#define USE_THE_REPOSITORY_VARIABLE
     + #include "builtin.h"
     + #include "gettext.h"
     + #include "parse-options.h"
     +
       ## builtin/prune.c ##
      @@
      +#define USE_THE_REPOSITORY_VARIABLE
     @@ builtin/refs.c
       
       #define REFS_MIGRATE_USAGE \
      
     + ## builtin/remote-ext.c ##
     +@@
     ++#define USE_THE_REPOSITORY_VARIABLE
     + #include "builtin.h"
     + #include "transport.h"
     + #include "run-command.h"
     +
     + ## builtin/remote-fd.c ##
     +@@
     ++#define USE_THE_REPOSITORY_VARIABLE
     + #include "builtin.h"
     + #include "transport.h"
     + 
     +
       ## builtin/remote.c ##
      @@
      +#define USE_THE_REPOSITORY_VARIABLE
     @@ builtin/upload-archive.c
       #include "strvec.h"
       
      
     + ## builtin/upload-pack.c ##
     +@@
     ++#define USE_THE_REPOSITORY_VARIABLE
     + #include "builtin.h"
     + #include "exec-cmd.h"
     + #include "gettext.h"
     +
       ## builtin/var.c ##
      @@
        *
 -:  ----------- > 3:  004283a1e5b builtin: remove USE_THE_REPOSITORY for those without the_repository
 3:  6956d3fe897 = 4:  d32f8ade1e0 add: pass in repo variable instead of global the_repository

-- 
gitgitgadget
