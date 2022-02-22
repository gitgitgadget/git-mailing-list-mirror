Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2689AC433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 18:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbiBVSbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 13:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiBVSbW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 13:31:22 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D14EF79D
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 10:30:56 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p4so1946915wmg.1
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 10:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=as7TYxZ98q/bBVOXVCUPYmRlSOlBUCIoSgaKHQR6M7g=;
        b=KLcoBhbcQT9mAXmnmP/qCIE3YiHzJyJjMt6zhivsCV6lasZ6W/Mw1Raw94q7msoEAw
         AiatBPArHfOdm0JsfiLySuO9X2oNggdP2uRy2/JWASVBSPZsvJS1Ecqku7Oz4OeGE0pn
         C4/ym6KM0ux2pVVmg6HJh0KUZyyFI4affvrXNlVQUTtihjiGIbd230O/JrfBuUP3PUvj
         W+CkEUKyfHFYlSuLr6NBZeq1Q78E8KJKPgn/MumQjNKAU40Z5Ba6kipFXquNi6Wwr8Na
         A48beBFA/3MNOVYfPR/PYcAZBUZbzwO/NZbhyH2rT6LH2UFMAkVL4LJQC7YACflmWZiZ
         NvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=as7TYxZ98q/bBVOXVCUPYmRlSOlBUCIoSgaKHQR6M7g=;
        b=dWkqXIQqj0y9FG4wU6IImfAd30a847buKtnOxS+rPRYbsMTR08XBnKYneJu044lC++
         aEIkLdJfpe91EFk3uDzSUf5eyFQxZbUNqzNYDiUg+uHmouOwTXrxxC4uyzdEM7AuwiK3
         toCZSqn6yvqk6KPH1JD+GPwbWx6SU8uBDIiJexpa3dUqbUK5eJ4fl4MZF4CRCi47qtp0
         y+tZzU8gyINFSlsu6POz55Ctktig1PC3j2xMMlBJ4YZZMQGUwZ8/UwMwDkvXQ7MPaQW/
         PU/ZkqmjThBWjzFcTMBpDHu0lr+4E6cbhCkm+zkslVPWa2i54ruWB8ncKBVA455pM+JO
         MfQA==
X-Gm-Message-State: AOAM531jHK55mw3cdDW3NEiGyjQuRFFR6mzZ28zZ7QlWhOY1+O3Ui4G2
        KTWU0FX40J4M73Th3MgIg41nRupoCfw=
X-Google-Smtp-Source: ABdhPJyaKO3RflHOrqU6ch/7WV0yvVu6JD4wPhsSW5OLBt3r1Fy2mP188tLkHqFEK9BKOB0BXfcShg==
X-Received: by 2002:a05:600c:5105:b0:380:e4fc:3723 with SMTP id o5-20020a05600c510500b00380e4fc3723mr305158wms.72.1645554654242;
        Tue, 22 Feb 2022 10:30:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 3sm53965674wrz.86.2022.02.22.10.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:30:52 -0800 (PST)
Message-Id: <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
In-Reply-To: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 18:30:48 +0000
Subject: [PATCH v2 0/3] libify reflog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In [1], there was a discussion around a bug report of stash not recovering
in the middle of the process when killed with ctl-c. It turned out to not be
a bug we need to fix. However, out of that discussion came the idea of
libifying reflog. This can stand alone as a code improvement.

stash.c currently shells out to call reflog to delete reflogs. Libify reflog
delete and call it from both builtin/reflog.c and builtin/stash.c.

This patch has three parts:

 * add missing test coverage for git stash delete
 * libify reflog's delete functionality and move some of the helpers into a
   reflog.c library and call reflog_delete from builtin/reflog.c
 * call reflog_delete from builtin/stash.c

Updates since v1:

 * added missing test coverage
 * squashed 1/3 and 2/3 together
 * moved enum into reflog.c
 * updated object.h's flag allocation mapping

 1. https://lore.kernel.org/git/220126.86h79qe692.gmgdl@evledraar.gmail.com/

John Cai (3):
  stash: add test to ensure reflog --rewrite --updatref behavior
  reflog: libify delete reflog function and helpers
  stash: call reflog_delete() in reflog.c

 Makefile         |   1 +
 builtin/reflog.c | 451 +----------------------------------------------
 builtin/stash.c  |  18 +-
 object.h         |   2 +-
 reflog.c         | 435 +++++++++++++++++++++++++++++++++++++++++++++
 reflog.h         |  49 +++++
 t/t3903-stash.sh |  25 ++-
 7 files changed, 518 insertions(+), 463 deletions(-)
 create mode 100644 reflog.c
 create mode 100644 reflog.h


base-commit: e6ebfd0e8cbbd10878070c8a356b5ad1b3ca464e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1218%2Fjohn-cai%2Fjc-libify-reflog-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1218/john-cai/jc-libify-reflog-v2
Pull-Request: https://github.com/git/git/pull/1218

Range-diff vs v1:

 -:  ----------- > 1:  6e136b62ca4 stash: add test to ensure reflog --rewrite --updatref behavior
 1:  9e17ece8d89 ! 2:  e7c950218b1 reflog: libify delete reflog function and helpers
     @@ builtin/reflog.c: static int cmd_reflog_expire(int argc, const char **argv, cons
       static const char * reflog_delete_usage[] = {
       	N_("git reflog delete [--rewrite] [--updateref] "
       	   "[--dry-run | -n] [--verbose] <refs>..."),
     -@@ builtin/reflog.c: static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
     +@@ builtin/reflog.c: static const char * reflog_delete_usage[] = {
     + 
     + static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
     + {
     +-	struct cmd_reflog_expire_cb cmd = { 0 };
       	int i, status = 0;
       	unsigned int flags = 0;
       	int verbose = 0;
     +-	reflog_expiry_should_prune_fn *should_prune_fn = should_expire_reflog_ent;
      +
     - 	reflog_expiry_should_prune_fn *should_prune_fn = should_expire_reflog_ent;
       	const struct option options[] = {
       		OPT_BIT(0, "dry-run", &flags, N_("do not actually prune any entries"),
     + 			EXPIRE_REFLOGS_DRY_RUN),
     +@@ builtin/reflog.c: static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
     + 
     + 	argc = parse_options(argc, argv, prefix, options, reflog_delete_usage, 0);
     + 
     +-	if (verbose)
     +-		should_prune_fn = should_expire_reflog_ent_verbose;
     +-
     + 	if (argc < 1)
     + 		return error(_("no reflog specified to delete"));
     + 
     +-	for (i = 0; i < argc; i++) {
     +-		const char *spec = strstr(argv[i], "@{");
     +-		char *ep, *ref;
     +-		int recno;
     +-		struct expire_reflog_policy_cb cb = {
     +-			.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
     +-		};
     +-
     +-		if (!spec) {
     +-			status |= error(_("not a reflog: %s"), argv[i]);
     +-			continue;
     +-		}
     ++	for (i = 0; i < argc; i++)
     ++		status |= reflog_delete(argv[i], flags, verbose);
     + 
     +-		if (!dwim_log(argv[i], spec - argv[i], NULL, &ref)) {
     +-			status |= error(_("no reflog for '%s'"), argv[i]);
     +-			continue;
     +-		}
     +-
     +-		recno = strtoul(spec + 2, &ep, 10);
     +-		if (*ep == '}') {
     +-			cmd.recno = -recno;
     +-			for_each_reflog_ent(ref, count_reflog_ent, &cmd);
     +-		} else {
     +-			cmd.expire_total = approxidate(spec + 2);
     +-			for_each_reflog_ent(ref, count_reflog_ent, &cmd);
     +-			cmd.expire_total = 0;
     +-		}
     +-
     +-		cb.cmd = cmd;
     +-		status |= reflog_expire(ref, flags,
     +-					reflog_expiry_prepare,
     +-					should_prune_fn,
     +-					reflog_expiry_cleanup,
     +-					&cb);
     +-		free(ref);
     +-	}
     + 	return status;
     + }
     + 
     +
     + ## object.h ##
     +@@ object.h: struct object_array {
     +  * builtin/fsck.c:           0--3
     +  * builtin/gc.c:             0
     +  * builtin/index-pack.c:                                     2021
     +- * builtin/reflog.c:                   10--12
     ++ * reflog.c:                           10--12
     +  * builtin/show-branch.c:    0-------------------------------------------26
     +  * builtin/unpack-objects.c:                                 2021
     +  */
      
       ## reflog.c (new) ##
      @@
     @@ reflog.c (new)
      +#include "tree-walk.h"
      +#include "worktree.h"
      +
     ++/* Remember to update object flag allocation in object.h */
     ++#define INCOMPLETE	(1u<<10)
     ++#define STUDYING	(1u<<11)
     ++#define REACHABLE	(1u<<12)
     ++
      +static int tree_is_complete(const struct object_id *oid)
      +{
      +	struct tree_desc desc;
     @@ reflog.c (new)
      +	return 0;
      +}
      +
     -+int reflog_delete(const char *rev, int flags, int verbose)
     ++int reflog_delete(const char *rev, enum expire_reflog_flags flags, int verbose)
      +{
      +	struct cmd_reflog_expire_cb cmd = { 0 };
      +	int status = 0;
     @@ reflog.c (new)
      +	if (verbose)
      +		should_prune_fn = should_expire_reflog_ent_verbose;
      +
     -+	if (!spec) {
     -+		status |= error(_("not a reflog: %s"), rev);
     -+	}
     ++	if (!spec)
     ++		return error(_("not a reflog: %s"), rev);
      +
      +	if (!dwim_log(rev, spec - rev, NULL, &ref)) {
      +		status |= error(_("no reflog for '%s'"), rev);
     ++		goto cleanup;
      +	}
      +
     -+	if (status)
     -+		return status;
     -+
      +	recno = strtoul(spec + 2, &ep, 10);
      +	if (*ep == '}') {
      +		cmd.recno = -recno;
     @@ reflog.c (new)
      +				should_prune_fn,
      +				reflog_expiry_cleanup,
      +				&cb);
     -+	free(ref);
      +
     ++ cleanup:
     ++	free(ref);
      +	return status;
      +}
      
     @@ reflog.h (new)
      +#ifndef REFLOG_H
      +#define REFLOG_H
      +
     -+#include "cache.h"
     -+#include "commit.h"
     -+
     -+/* Remember to update object flag allocation in object.h */
     -+#define INCOMPLETE	(1u<<10)
     -+#define STUDYING	(1u<<11)
     -+#define REACHABLE	(1u<<12)
     ++#include "refs.h"
      +
      +struct cmd_reflog_expire_cb {
      +	int stalefix;
     @@ reflog.h (new)
      +	unsigned int dry_run:1;
      +};
      +
     -+int reflog_delete(const char*, int, int);
     -+void reflog_expiry_cleanup(void *);
     -+void reflog_expiry_prepare(const char*, const struct object_id*,
     -+			   void *);
     -+int should_expire_reflog_ent(struct object_id *, struct object_id*,
     -+				    const char *, timestamp_t, int,
     -+				    const char *, void *);
     ++int reflog_delete(const char *rev, enum expire_reflog_flags flags, int verbose);
     ++
     ++void reflog_expiry_cleanup(void *cb_data);
     ++
     ++void reflog_expiry_prepare(const char *refname, const struct object_id *oid,
     ++			   void *cb_data);
     ++
     ++int should_expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
     ++			     const char *email, timestamp_t timestamp, int tz,
     ++			     const char *message, void *cb_data);
     ++
      +int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
     -+		const char *email, timestamp_t timestamp, int tz,
     -+		const char *message, void *cb_data);
     -+int should_expire_reflog_ent_verbose(struct object_id *,
     -+				     struct object_id *,
     -+				     const char *,
     -+				     timestamp_t, int,
     -+				     const char *, void *);
     ++		     const char *email, timestamp_t timestamp, int tz,
     ++		     const char *message, void *cb_data);
     ++
     ++int should_expire_reflog_ent_verbose(struct object_id *ooid,
     ++				     struct object_id *noid,
     ++				     const char *email,
     ++				     timestamp_t timestamp, int tz,
     ++				     const char *message, void *cb_data);
     ++
      +#endif /* REFLOG_H */
 2:  e4c0047a17c < -:  ----------- reflog: call reflog_delete from reflog.c
 3:  bcc1eae0531 ! 3:  a023a70092b stash: call reflog_delete from reflog.c
     @@ Metadata
      Author: John Cai <johncai86@gmail.com>
      
       ## Commit message ##
     -    stash: call reflog_delete from reflog.c
     +    stash: call reflog_delete() in reflog.c
      
          Now that cmd_reflog_delete has been libified an exported it into a new
          reflog.c library so we can call it directly from builtin/stash.c. This
     @@ builtin/stash.c
       #define INCLUDE_ALL_FILES 2
       
      @@ builtin/stash.c: static int reflog_is_empty(const char *refname)
     + 
       static int do_drop_stash(struct stash_info *info, int quiet)
       {
     - 	int ret;
     +-	int ret;
      -	struct child_process cp_reflog = CHILD_PROCESS_INIT;
      -
      -	/*
     @@ builtin/stash.c: static int reflog_is_empty(const char *refname)
      -		     "--rewrite", NULL);
      -	strvec_push(&cp_reflog.args, info->revision.buf);
      -	ret = run_command(&cp_reflog);
     -+	ret = reflog_delete(info->revision.buf,
     -+			    EXPIRE_REFLOGS_REWRITE | EXPIRE_REFLOGS_REWRITE,
     -+			    0);
     - 	if (!ret) {
     +-	if (!ret) {
     ++	if (!reflog_delete(info->revision.buf,
     ++			   EXPIRE_REFLOGS_REWRITE | EXPIRE_REFLOGS_UPDATE_REF,
     ++			   0)) {
       		if (!quiet)
       			printf_ln(_("Dropped %s (%s)"), info->revision.buf,
     + 				  oid_to_hex(&info->w_commit));

-- 
gitgitgadget
