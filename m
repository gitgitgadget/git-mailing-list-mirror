Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BC4153828
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 21:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726262192; cv=none; b=KPQXn8twt3iFnmWMG5AGD/vLjRYeRF8RyfQLKdd6qL8kpx39mmtjM1snkw6TTTc+9aP+WhyoF+R4e4D0jBVGf7nJ06PEDC+yl8L2iSux8lcMESsx/U13gtZhoUYCfVAX1uwGbWMlyAN0YAzZOG/wNDzUEvhvL/F9nh/HMNS7TgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726262192; c=relaxed/simple;
	bh=lKW6G0MBSg1O+QNqQYXUoP7SdyVPC5jjBPTuCdDjsw0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sbdNOaNkH06f6kB5SyoZxFN4VaLJH9xhkEQ5i+mjUi7nRbgk38tlX5V53hLS+MSd+JONeOYLELccGHr1Y78QOMFs1Vc7aL7WrwC3fiKNo8ug2Lk9XqXR9IODBWBgW+oXFevEU7TS9o/n5pKdHJLwhnMrXmM5ViCnqB2aQ622v9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTQIOv0O; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTQIOv0O"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d43657255so171288366b.0
        for <git@vger.kernel.org>; Fri, 13 Sep 2024 14:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726262184; x=1726866984; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxgbhXG2tt32cSjGPOeLyUWA5cm5b1+CEUoaMPVNMFE=;
        b=NTQIOv0OqUoxSuTG8RIjnTK9VaMk0Tgg2Ao7NKtQUYuaEBCZu0EZVQXfa13IekGRty
         s94if0mSP31AqbDsc0Xlt8rZFkab0vosBNTSL3qyXWkXU7Ov7PAbC4EKiFZpMg38ochT
         lRWA2e6Mz4Et4rvpZ169V1RqbkYV1ow+kh8BJuud5cUsE6FeqTjpWTRiP55zZgS1sGoG
         ce3sxHR03tEVWgEtb+SzPsgi68w5VWWvvc77wDPQIVPaxvP6sFMn+xCuANKFgmHKC3fC
         +Ez2tKSBzdexxn9zCGcpFMxtwAGYbU1tBqXfbSdbZ4HTOY6n99HoiVLrPRJ3R/2Iz0uf
         BN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726262184; x=1726866984;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxgbhXG2tt32cSjGPOeLyUWA5cm5b1+CEUoaMPVNMFE=;
        b=NpDeci3snenwUhddNZlJcJoJpJHfjzmGU9KnfnrzyJtGlGEbP6v6eAq8hnb7koRpil
         tfCz1TiDk/kyt34YLOOt3RlFZp8wXIUGvBohmibg54Q7On8a3jZQe86/Wn/iNzHFdIHV
         SBxPwt5IsFHisQXcm2TgD5GILK6Jm2D4hHXYGb7yLY0B70W7CBTdXorSiNdmiYElhrNg
         nwKqbWF1Y51Qab7965zzN712NZgZ+QaYzCafIt8W3bGQdP84VelgBLWCtiOrWZBjgvLl
         8akmSXEZc8HRf93hnjpPSfCb6MQ7b2fQgyZzZ4feT+8nVheklA7Dz9suqNImmo8++7Pu
         GV5g==
X-Gm-Message-State: AOJu0YxjOKG6+6IPEF34ZoZpWlClnWaOa/PLkOjq/EgM4oKqf87i/QDb
	5K4NkR5DM19yR3eQIHw2Mf/A3Vc9EDcpBxXHtlsak5SrEXnMCqDZJZvh7A==
X-Google-Smtp-Source: AGHT+IF55anYEDzHyb4M3nfnaf9shLBjivPqeRPlur5tZPFxMztA76i45gnuccDsi9igPXj42lhK8A==
X-Received: by 2002:a17:907:980e:b0:a77:cca9:b212 with SMTP id a640c23a62f3a-a9048048388mr337611866b.45.1726262182714;
        Fri, 13 Sep 2024 14:16:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b828asm921166b.109.2024.09.13.14.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 14:16:21 -0700 (PDT)
Message-Id: <02a4466ecc9ac5b87f3487317c59345b12ab3f20.1726262177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1778.v3.git.git.1726262177.gitgitgadget@gmail.com>
References: <pull.1778.v2.git.git.1726001960.gitgitgadget@gmail.com>
	<pull.1778.v3.git.git.1726262177.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Sep 2024 21:16:14 +0000
Subject: [PATCH v3 1/4] builtin: add a repository parameter for builtin
 functions
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
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

In order to reduce the usage of the global the_repository, add a
parameter to builtin functions that will get passed a repository
variable.

This commit uses UNUSED on most of the builtin functions, as subsequent
commits will modify the actual builtins to pass the repository parameter
down.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin.h                          | 277 +++++++++++++++--------------
 builtin/add.c                      |  12 +-
 builtin/am.c                       |   5 +-
 builtin/annotate.c                 |   7 +-
 builtin/apply.c                    |   5 +-
 builtin/archive.c                  |   5 +-
 builtin/bisect.c                   |   5 +-
 builtin/blame.c                    |   5 +-
 builtin/branch.c                   |   5 +-
 builtin/bugreport.c                |   5 +-
 builtin/bundle.c                   |   5 +-
 builtin/cat-file.c                 |   7 +-
 builtin/check-attr.c               |   5 +-
 builtin/check-ignore.c             |   5 +-
 builtin/check-mailmap.c            |   5 +-
 builtin/check-ref-format.c         |   5 +-
 builtin/checkout--worker.c         |   5 +-
 builtin/checkout-index.c           |   5 +-
 builtin/checkout.c                 |  15 +-
 builtin/clean.c                    |   5 +-
 builtin/clone.c                    |   5 +-
 builtin/column.c                   |   5 +-
 builtin/commit-graph.c             |   5 +-
 builtin/commit-tree.c              |   5 +-
 builtin/commit.c                   |  10 +-
 builtin/config.c                   |   5 +-
 builtin/count-objects.c            |   5 +-
 builtin/credential-cache--daemon.c |  10 +-
 builtin/credential-cache.c         |   5 +-
 builtin/credential-store.c         |   5 +-
 builtin/credential.c               |   5 +-
 builtin/describe.c                 |   7 +-
 builtin/diagnose.c                 |   5 +-
 builtin/diff-files.c               |   5 +-
 builtin/diff-index.c               |   5 +-
 builtin/diff-tree.c                |   5 +-
 builtin/diff.c                     |   5 +-
 builtin/difftool.c                 |   5 +-
 builtin/fast-export.c              |   5 +-
 builtin/fast-import.c              |   5 +-
 builtin/fetch-pack.c               |   5 +-
 builtin/fetch.c                    |   5 +-
 builtin/fmt-merge-msg.c            |   5 +-
 builtin/for-each-ref.c             |   5 +-
 builtin/for-each-repo.c            |   5 +-
 builtin/fsck.c                     |   5 +-
 builtin/fsmonitor--daemon.c        |   7 +-
 builtin/gc.c                       |  10 +-
 builtin/get-tar-commit-id.c        |   5 +-
 builtin/grep.c                     |   5 +-
 builtin/hash-object.c              |   5 +-
 builtin/help.c                     |   5 +-
 builtin/hook.c                     |   5 +-
 builtin/index-pack.c               |   5 +-
 builtin/init-db.c                  |   5 +-
 builtin/interpret-trailers.c       |   5 +-
 builtin/log.c                      |  30 +++-
 builtin/ls-files.c                 |   5 +-
 builtin/ls-remote.c                |   5 +-
 builtin/ls-tree.c                  |   5 +-
 builtin/mailinfo.c                 |   5 +-
 builtin/mailsplit.c                |   5 +-
 builtin/merge-base.c               |   5 +-
 builtin/merge-file.c               |   5 +-
 builtin/merge-index.c              |   5 +-
 builtin/merge-ours.c               |   5 +-
 builtin/merge-recursive.c          |   5 +-
 builtin/merge-tree.c               |   5 +-
 builtin/merge.c                    |   9 +-
 builtin/mktag.c                    |   5 +-
 builtin/mktree.c                   |   6 +-
 builtin/multi-pack-index.c         |   6 +-
 builtin/mv.c                       |   5 +-
 builtin/name-rev.c                 |   5 +-
 builtin/notes.c                    |   5 +-
 builtin/pack-objects.c             |   5 +-
 builtin/pack-redundant.c           |   7 +-
 builtin/pack-refs.c                |   5 +-
 builtin/patch-id.c                 |   5 +-
 builtin/prune-packed.c             |   5 +-
 builtin/prune.c                    |   5 +-
 builtin/pull.c                     |   5 +-
 builtin/push.c                     |   5 +-
 builtin/range-diff.c               |   5 +-
 builtin/read-tree.c                |   5 +-
 builtin/rebase.c                   |   5 +-
 builtin/receive-pack.c             |   5 +-
 builtin/reflog.c                   |   9 +-
 builtin/refs.c                     |   5 +-
 builtin/remote-ext.c               |   5 +-
 builtin/remote-fd.c                |   5 +-
 builtin/remote.c                   |   5 +-
 builtin/repack.c                   |   5 +-
 builtin/replace.c                  |   5 +-
 builtin/replay.c                   |   5 +-
 builtin/rerere.c                   |   5 +-
 builtin/reset.c                    |   5 +-
 builtin/rev-list.c                 |   5 +-
 builtin/rev-parse.c                |   5 +-
 builtin/revert.c                   |  10 +-
 builtin/rm.c                       |   5 +-
 builtin/send-pack.c                |   5 +-
 builtin/shortlog.c                 |   5 +-
 builtin/show-branch.c              |   5 +-
 builtin/show-index.c               |   5 +-
 builtin/show-ref.c                 |   5 +-
 builtin/sparse-checkout.c          |   5 +-
 builtin/stash.c                    |   5 +-
 builtin/stripspace.c               |   5 +-
 builtin/submodule--helper.c        |   5 +-
 builtin/symbolic-ref.c             |   5 +-
 builtin/tag.c                      |   5 +-
 builtin/unpack-file.c              |   5 +-
 builtin/unpack-objects.c           |   5 +-
 builtin/update-index.c             |   5 +-
 builtin/update-ref.c               |   5 +-
 builtin/update-server-info.c       |   5 +-
 builtin/upload-archive.c           |  10 +-
 builtin/upload-pack.c              |   5 +-
 builtin/var.c                      |   5 +-
 builtin/verify-commit.c            |   5 +-
 builtin/verify-pack.c              |   5 +-
 builtin/verify-tag.c               |   5 +-
 builtin/worktree.c                 |   5 +-
 builtin/write-tree.c               |   5 +-
 git.c                              |  12 +-
 help.c                             |   3 +-
 127 files changed, 703 insertions(+), 296 deletions(-)

diff --git a/builtin.h b/builtin.h
index 14fa0171607..fc6fc8ffed8 100644
--- a/builtin.h
+++ b/builtin.h
@@ -10,6 +10,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
+#include "repository.h"
 
 /*
  * builtin API
@@ -122,143 +123,143 @@ int is_builtin(const char *s);
 		BUG("unexpected prefix in builtin: %s", (prefix)); \
 } while (0)
 
-int cmd_add(int argc, const char **argv, const char *prefix);
-int cmd_am(int argc, const char **argv, const char *prefix);
-int cmd_annotate(int argc, const char **argv, const char *prefix);
-int cmd_apply(int argc, const char **argv, const char *prefix);
-int cmd_archive(int argc, const char **argv, const char *prefix);
-int cmd_bisect(int argc, const char **argv, const char *prefix);
-int cmd_blame(int argc, const char **argv, const char *prefix);
-int cmd_branch(int argc, const char **argv, const char *prefix);
-int cmd_bugreport(int argc, const char **argv, const char *prefix);
-int cmd_bundle(int argc, const char **argv, const char *prefix);
-int cmd_cat_file(int argc, const char **argv, const char *prefix);
-int cmd_checkout(int argc, const char **argv, const char *prefix);
-int cmd_checkout__worker(int argc, const char **argv, const char *prefix);
-int cmd_checkout_index(int argc, const char **argv, const char *prefix);
-int cmd_check_attr(int argc, const char **argv, const char *prefix);
-int cmd_check_ignore(int argc, const char **argv, const char *prefix);
-int cmd_check_mailmap(int argc, const char **argv, const char *prefix);
-int cmd_check_ref_format(int argc, const char **argv, const char *prefix);
-int cmd_cherry(int argc, const char **argv, const char *prefix);
-int cmd_cherry_pick(int argc, const char **argv, const char *prefix);
-int cmd_clone(int argc, const char **argv, const char *prefix);
-int cmd_clean(int argc, const char **argv, const char *prefix);
-int cmd_column(int argc, const char **argv, const char *prefix);
-int cmd_commit(int argc, const char **argv, const char *prefix);
-int cmd_commit_graph(int argc, const char **argv, const char *prefix);
-int cmd_commit_tree(int argc, const char **argv, const char *prefix);
-int cmd_config(int argc, const char **argv, const char *prefix);
-int cmd_count_objects(int argc, const char **argv, const char *prefix);
-int cmd_credential(int argc, const char **argv, const char *prefix);
-int cmd_credential_cache(int argc, const char **argv, const char *prefix);
-int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix);
-int cmd_credential_store(int argc, const char **argv, const char *prefix);
-int cmd_describe(int argc, const char **argv, const char *prefix);
-int cmd_diagnose(int argc, const char **argv, const char *prefix);
-int cmd_diff_files(int argc, const char **argv, const char *prefix);
-int cmd_diff_index(int argc, const char **argv, const char *prefix);
-int cmd_diff(int argc, const char **argv, const char *prefix);
-int cmd_diff_tree(int argc, const char **argv, const char *prefix);
-int cmd_difftool(int argc, const char **argv, const char *prefix);
-int cmd_env__helper(int argc, const char **argv, const char *prefix);
-int cmd_fast_export(int argc, const char **argv, const char *prefix);
-int cmd_fast_import(int argc, const char **argv, const char *prefix);
-int cmd_fetch(int argc, const char **argv, const char *prefix);
-int cmd_fetch_pack(int argc, const char **argv, const char *prefix);
-int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix);
-int cmd_for_each_ref(int argc, const char **argv, const char *prefix);
-int cmd_for_each_repo(int argc, const char **argv, const char *prefix);
-int cmd_format_patch(int argc, const char **argv, const char *prefix);
-int cmd_fsck(int argc, const char **argv, const char *prefix);
-int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix);
-int cmd_gc(int argc, const char **argv, const char *prefix);
-int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
-int cmd_grep(int argc, const char **argv, const char *prefix);
-int cmd_hash_object(int argc, const char **argv, const char *prefix);
-int cmd_help(int argc, const char **argv, const char *prefix);
-int cmd_hook(int argc, const char **argv, const char *prefix);
-int cmd_index_pack(int argc, const char **argv, const char *prefix);
-int cmd_init_db(int argc, const char **argv, const char *prefix);
-int cmd_interpret_trailers(int argc, const char **argv, const char *prefix);
-int cmd_log(int argc, const char **argv, const char *prefix);
-int cmd_log_reflog(int argc, const char **argv, const char *prefix);
-int cmd_ls_files(int argc, const char **argv, const char *prefix);
-int cmd_ls_tree(int argc, const char **argv, const char *prefix);
-int cmd_ls_remote(int argc, const char **argv, const char *prefix);
-int cmd_mailinfo(int argc, const char **argv, const char *prefix);
-int cmd_mailsplit(int argc, const char **argv, const char *prefix);
-int cmd_maintenance(int argc, const char **argv, const char *prefix);
-int cmd_merge(int argc, const char **argv, const char *prefix);
-int cmd_merge_base(int argc, const char **argv, const char *prefix);
-int cmd_merge_index(int argc, const char **argv, const char *prefix);
-int cmd_merge_ours(int argc, const char **argv, const char *prefix);
-int cmd_merge_file(int argc, const char **argv, const char *prefix);
-int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
-int cmd_merge_tree(int argc, const char **argv, const char *prefix);
-int cmd_mktag(int argc, const char **argv, const char *prefix);
-int cmd_mktree(int argc, const char **argv, const char *prefix);
-int cmd_multi_pack_index(int argc, const char **argv, const char *prefix);
-int cmd_mv(int argc, const char **argv, const char *prefix);
-int cmd_name_rev(int argc, const char **argv, const char *prefix);
-int cmd_notes(int argc, const char **argv, const char *prefix);
-int cmd_pack_objects(int argc, const char **argv, const char *prefix);
-int cmd_pack_redundant(int argc, const char **argv, const char *prefix);
-int cmd_patch_id(int argc, const char **argv, const char *prefix);
-int cmd_prune(int argc, const char **argv, const char *prefix);
-int cmd_prune_packed(int argc, const char **argv, const char *prefix);
-int cmd_pull(int argc, const char **argv, const char *prefix);
-int cmd_push(int argc, const char **argv, const char *prefix);
-int cmd_range_diff(int argc, const char **argv, const char *prefix);
-int cmd_read_tree(int argc, const char **argv, const char *prefix);
-int cmd_rebase(int argc, const char **argv, const char *prefix);
-int cmd_rebase__interactive(int argc, const char **argv, const char *prefix);
-int cmd_receive_pack(int argc, const char **argv, const char *prefix);
-int cmd_reflog(int argc, const char **argv, const char *prefix);
-int cmd_refs(int argc, const char **argv, const char *prefix);
-int cmd_remote(int argc, const char **argv, const char *prefix);
-int cmd_remote_ext(int argc, const char **argv, const char *prefix);
-int cmd_remote_fd(int argc, const char **argv, const char *prefix);
-int cmd_repack(int argc, const char **argv, const char *prefix);
-int cmd_replay(int argc, const char **argv, const char *prefix);
-int cmd_rerere(int argc, const char **argv, const char *prefix);
-int cmd_reset(int argc, const char **argv, const char *prefix);
-int cmd_restore(int argc, const char **argv, const char *prefix);
-int cmd_rev_list(int argc, const char **argv, const char *prefix);
-int cmd_rev_parse(int argc, const char **argv, const char *prefix);
-int cmd_revert(int argc, const char **argv, const char *prefix);
-int cmd_rm(int argc, const char **argv, const char *prefix);
-int cmd_send_pack(int argc, const char **argv, const char *prefix);
-int cmd_shortlog(int argc, const char **argv, const char *prefix);
-int cmd_show(int argc, const char **argv, const char *prefix);
-int cmd_show_branch(int argc, const char **argv, const char *prefix);
-int cmd_show_index(int argc, const char **argv, const char *prefix);
-int cmd_sparse_checkout(int argc, const char **argv, const char *prefix);
-int cmd_status(int argc, const char **argv, const char *prefix);
-int cmd_stash(int argc, const char **argv, const char *prefix);
-int cmd_stripspace(int argc, const char **argv, const char *prefix);
-int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
-int cmd_switch(int argc, const char **argv, const char *prefix);
-int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
-int cmd_tag(int argc, const char **argv, const char *prefix);
-int cmd_unpack_file(int argc, const char **argv, const char *prefix);
-int cmd_unpack_objects(int argc, const char **argv, const char *prefix);
-int cmd_update_index(int argc, const char **argv, const char *prefix);
-int cmd_update_ref(int argc, const char **argv, const char *prefix);
-int cmd_update_server_info(int argc, const char **argv, const char *prefix);
-int cmd_upload_archive(int argc, const char **argv, const char *prefix);
-int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix);
-int cmd_upload_pack(int argc, const char **argv, const char *prefix);
-int cmd_var(int argc, const char **argv, const char *prefix);
-int cmd_verify_commit(int argc, const char **argv, const char *prefix);
-int cmd_verify_tag(int argc, const char **argv, const char *prefix);
-int cmd_version(int argc, const char **argv, const char *prefix);
-int cmd_whatchanged(int argc, const char **argv, const char *prefix);
-int cmd_worktree(int argc, const char **argv, const char *prefix);
-int cmd_write_tree(int argc, const char **argv, const char *prefix);
-int cmd_verify_pack(int argc, const char **argv, const char *prefix);
-int cmd_show_ref(int argc, const char **argv, const char *prefix);
-int cmd_pack_refs(int argc, const char **argv, const char *prefix);
-int cmd_replace(int argc, const char **argv, const char *prefix);
+int cmd_add(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_am(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_annotate(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_apply(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_archive(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_bisect(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_blame(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_branch(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_bugreport(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_bundle(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_cat_file(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_checkout(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_checkout__worker(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_checkout_index(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_check_attr(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_check_ignore(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_check_mailmap(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_check_ref_format(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_cherry(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_cherry_pick(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_clone(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_clean(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_column(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_commit(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_commit_graph(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_commit_tree(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_config(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_count_objects(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_credential(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_credential_cache(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_credential_store(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_describe(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_diagnose(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_diff_files(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_diff_index(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_diff(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_diff_tree(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_difftool(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_env__helper(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_fast_export(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_fast_import(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_fetch(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_fetch_pack(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_for_each_ref(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_for_each_repo(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_format_patch(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_fsck(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_gc(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_grep(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_hash_object(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_help(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_hook(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_index_pack(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_init_db(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_interpret_trailers(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_log_reflog(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_log(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_ls_files(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_ls_tree(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_ls_remote(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_mailinfo(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_mailsplit(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_maintenance(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_merge(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_merge_base(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_merge_index(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_merge_ours(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_merge_file(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_merge_recursive(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_merge_tree(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_mktag(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_mktree(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_multi_pack_index(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_mv(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_name_rev(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_notes(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_pack_objects(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_pack_redundant(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_patch_id(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_prune(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_prune_packed(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_pull(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_push(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_range_diff(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_read_tree(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_rebase(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_rebase__interactive(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_receive_pack(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_reflog(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_refs(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_remote(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_remote_ext(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_remote_fd(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_repack(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_replay(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_rerere(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_reset(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_restore(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_rev_list(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_rev_parse(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_revert(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_rm(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_send_pack(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_shortlog(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_show(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_show_branch(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_show_index(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_sparse_checkout(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_status(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_stash(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_stripspace(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_submodule__helper(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_switch(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_symbolic_ref(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_tag(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_unpack_file(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_unpack_objects(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_update_index(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_update_ref(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_update_server_info(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_upload_archive(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_upload_pack(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_var(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_verify_commit(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_verify_tag(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_version(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_whatchanged(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_worktree(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_write_tree(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_verify_pack(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_show_ref(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_pack_refs(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_replace(int argc, const char **argv, const char *prefix, struct repository *repo);
 
 #endif
diff --git a/builtin/add.c b/builtin/add.c
index 40b61ef90d9..ba331519cac 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -167,7 +167,10 @@ int interactive_add(const char **argv, const char *prefix, int patch)
 	return ret;
 }
 
-static int edit_patch(int argc, const char **argv, const char *prefix)
+static int edit_patch(int argc,
+		      const char **argv,
+		      const char *prefix,
+		      struct repository *repo UNUSED)
 {
 	char *file = git_pathdup("ADD_EDIT.patch");
 	struct child_process child = CHILD_PROCESS_INIT;
@@ -358,7 +361,10 @@ static int add_files(struct dir_struct *dir, int flags)
 	return exit_status;
 }
 
-int cmd_add(int argc, const char **argv, const char *prefix)
+int cmd_add(int argc,
+	    const char **argv,
+	    const char *prefix,
+	    struct repository *repo UNUSED)
 {
 	int exit_status = 0;
 	struct pathspec pathspec;
@@ -387,7 +393,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (edit_interactive) {
 		if (pathspec_from_file)
 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--edit");
-		return(edit_patch(argc, argv, prefix));
+		return(edit_patch(argc, argv, prefix, the_repository));
 	}
 	argc--;
 	argv++;
diff --git a/builtin/am.c b/builtin/am.c
index d8875ad4022..8c610eed3e6 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2298,7 +2298,10 @@ static int parse_opt_show_current_patch(const struct option *opt, const char *ar
 	return 0;
 }
 
-int cmd_am(int argc, const char **argv, const char *prefix)
+int cmd_am(int argc,
+	   const char **argv,
+	   const char *prefix,
+	   struct repository *repo UNUSED)
 {
 	struct am_state state;
 	int binary = -1;
diff --git a/builtin/annotate.c b/builtin/annotate.c
index 58ff977a231..0abf89ef186 100644
--- a/builtin/annotate.c
+++ b/builtin/annotate.c
@@ -7,7 +7,10 @@
 #include "builtin.h"
 #include "strvec.h"
 
-int cmd_annotate(int argc, const char **argv, const char *prefix)
+int cmd_annotate(int argc,
+		 const char **argv,
+		 const char *prefix,
+		 struct repository *repo UNUSED)
 {
 	struct strvec args = STRVEC_INIT;
 	int i;
@@ -18,5 +21,5 @@ int cmd_annotate(int argc, const char **argv, const char *prefix)
 		strvec_push(&args, argv[i]);
 	}
 
-	return cmd_blame(args.nr, args.v, prefix);
+	return cmd_blame(args.nr, args.v, prefix, the_repository);
 }
diff --git a/builtin/apply.c b/builtin/apply.c
index d623c52f78f..ca0bb97df40 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -9,7 +9,10 @@ static const char * const apply_usage[] = {
 	NULL
 };
 
-int cmd_apply(int argc, const char **argv, const char *prefix)
+int cmd_apply(int argc,
+	      const char **argv,
+	      const char *prefix,
+	      struct repository *repo UNUSED)
 {
 	int force_apply = 0;
 	int options = 0;
diff --git a/builtin/archive.c b/builtin/archive.c
index 63f02990d11..2b5dc5f43b0 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -76,7 +76,10 @@ static int run_remote_archiver(int argc, const char **argv,
 			     PARSE_OPT_KEEP_UNKNOWN_OPT |	\
 			     PARSE_OPT_NO_INTERNAL_HELP	)
 
-int cmd_archive(int argc, const char **argv, const char *prefix)
+int cmd_archive(int argc,
+		const char **argv,
+		const char *prefix,
+		struct repository *repo UNUSED)
 {
 	const char *exec = "git-upload-archive";
 	char *output = NULL;
diff --git a/builtin/bisect.c b/builtin/bisect.c
index c8aa92b19d5..bec5cc749af 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -1411,7 +1411,10 @@ static int cmd_bisect__run(int argc, const char **argv, const char *prefix UNUSE
 	return res;
 }
 
-int cmd_bisect(int argc, const char **argv, const char *prefix)
+int cmd_bisect(int argc,
+	       const char **argv,
+	       const char *prefix,
+	       struct repository *repo UNUSED)
 {
 	int res = 0;
 	parse_opt_subcommand_fn *fn = NULL;
diff --git a/builtin/blame.c b/builtin/blame.c
index 35e975fb132..728a62402b5 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -864,7 +864,10 @@ static void build_ignorelist(struct blame_scoreboard *sb,
 	}
 }
 
-int cmd_blame(int argc, const char **argv, const char *prefix)
+int cmd_blame(int argc,
+	      const char **argv,
+	      const char *prefix,
+	      struct repository *repo UNUSED)
 {
 	struct rev_info revs;
 	char *path = NULL;
diff --git a/builtin/branch.c b/builtin/branch.c
index 3f870741bfd..7980d2e83d6 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -704,7 +704,10 @@ static int edit_branch_description(const char *branch_name)
 	return 0;
 }
 
-int cmd_branch(int argc, const char **argv, const char *prefix)
+int cmd_branch(int argc,
+	       const char **argv,
+	       const char *prefix,
+	       struct repository *repo UNUSED)
 {
 	/* possible actions */
 	int delete = 0, rename = 0, copy = 0, list = 0,
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index bdfed3d8f18..aeab40c4902 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -98,7 +98,10 @@ static void get_header(struct strbuf *buf, const char *title)
 	strbuf_addf(buf, "\n\n[%s]\n", title);
 }
 
-int cmd_bugreport(int argc, const char **argv, const char *prefix)
+int cmd_bugreport(int argc,
+		  const char **argv,
+		  const char *prefix,
+		  struct repository *repo UNUSED)
 {
 	struct strbuf buffer = STRBUF_INIT;
 	struct strbuf report_path = STRBUF_INIT;
diff --git a/builtin/bundle.c b/builtin/bundle.c
index b858552ee6c..3fdd9195fd7 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -228,7 +228,10 @@ cleanup:
 	return ret;
 }
 
-int cmd_bundle(int argc, const char **argv, const char *prefix)
+int cmd_bundle(int argc,
+	       const char **argv,
+	       const char *prefix,
+	       struct repository *repo UNUSED)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1afdfb5cbae..b0ce49c9640 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -191,7 +191,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			const char *ls_args[3] = { NULL };
 			ls_args[0] =  "ls-tree";
 			ls_args[1] =  obj_name;
-			ret = cmd_ls_tree(2, ls_args, NULL);
+			ret = cmd_ls_tree(2, ls_args, NULL, the_repository);
 			goto cleanup;
 		}
 
@@ -923,7 +923,10 @@ static int batch_option_callback(const struct option *opt,
 	return 0;
 }
 
-int cmd_cat_file(int argc, const char **argv, const char *prefix)
+int cmd_cat_file(int argc,
+		 const char **argv,
+		 const char *prefix,
+		 struct repository *repo UNUSED)
 {
 	int opt = 0;
 	int opt_cw = 0;
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 93768107100..ffd1067558d 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -107,7 +107,10 @@ static NORETURN void error_with_usage(const char *msg)
 	usage_with_options(check_attr_usage, check_attr_options);
 }
 
-int cmd_check_attr(int argc, const char **argv, const char *prefix)
+int cmd_check_attr(int argc,
+		   const char **argv,
+		   const char *prefix,
+		   struct repository *repo UNUSED)
 {
 	struct attr_check *check;
 	struct object_id initialized_oid;
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 2bda6a1d462..70565b9f892 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -151,7 +151,10 @@ static int check_ignore_stdin_paths(struct dir_struct *dir, const char *prefix)
 	return num_ignored;
 }
 
-int cmd_check_ignore(int argc, const char **argv, const char *prefix)
+int cmd_check_ignore(int argc,
+		     const char **argv,
+		     const char *prefix,
+		     struct repository *repo UNUSED)
 {
 	int num_ignored;
 	struct dir_struct dir = DIR_INIT;
diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
index 2334b572227..422b6938788 100644
--- a/builtin/check-mailmap.c
+++ b/builtin/check-mailmap.c
@@ -47,7 +47,10 @@ static void check_mailmap(struct string_list *mailmap, const char *contact)
 	printf("<%.*s>\n", (int)maillen, mail);
 }
 
-int cmd_check_mailmap(int argc, const char **argv, const char *prefix)
+int cmd_check_mailmap(int argc,
+		      const char **argv,
+		      const char *prefix,
+		      struct repository *repo UNUSED)
 {
 	int i;
 	struct string_list mailmap = STRING_LIST_INIT_NODUP;
diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index 5eb6bdc3f69..6874edb4f41 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -51,7 +51,10 @@ static int check_ref_format_branch(const char *arg)
 	return 0;
 }
 
-int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
+int cmd_check_ref_format(int argc,
+			 const char **argv,
+			 const char *prefix,
+			 struct repository *repo UNUSED)
 {
 	int i;
 	int normalize = 0;
diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
index 6b62b5375bd..f53e1082690 100644
--- a/builtin/checkout--worker.c
+++ b/builtin/checkout--worker.c
@@ -113,7 +113,10 @@ static const char * const checkout_worker_usage[] = {
 	NULL
 };
 
-int cmd_checkout__worker(int argc, const char **argv, const char *prefix)
+int cmd_checkout__worker(int argc,
+			 const char **argv,
+			 const char *prefix,
+			 struct repository *repo UNUSED)
 {
 	struct checkout state = CHECKOUT_INIT;
 	struct option checkout_worker_options[] = {
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 29e744d11be..98247ff8236 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -208,7 +208,10 @@ static int option_parse_stage(const struct option *opt,
 	return 0;
 }
 
-int cmd_checkout_index(int argc, const char **argv, const char *prefix)
+int cmd_checkout_index(int argc,
+		       const char **argv,
+		       const char *prefix,
+		       struct repository *repo UNUSED)
 {
 	int i;
 	struct lock_file lock_file = LOCK_INIT;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4cfe6fab505..d3bc48684f9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1953,7 +1953,10 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	return ret;
 }
 
-int cmd_checkout(int argc, const char **argv, const char *prefix)
+int cmd_checkout(int argc,
+		 const char **argv,
+		 const char *prefix,
+		 struct repository *repo UNUSED)
 {
 	struct checkout_opts opts = CHECKOUT_OPTS_INIT;
 	struct option *options;
@@ -2000,7 +2003,10 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			     checkout_usage);
 }
 
-int cmd_switch(int argc, const char **argv, const char *prefix)
+int cmd_switch(int argc,
+	       const char **argv,
+	       const char *prefix,
+	       struct repository *repo UNUSED)
 {
 	struct checkout_opts opts = CHECKOUT_OPTS_INIT;
 	struct option *options = NULL;
@@ -2036,7 +2042,10 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 			     switch_branch_usage);
 }
 
-int cmd_restore(int argc, const char **argv, const char *prefix)
+int cmd_restore(int argc,
+		const char **argv,
+		const char *prefix,
+		struct repository *repo UNUSED)
 {
 	struct checkout_opts opts = CHECKOUT_OPTS_INIT;
 	struct option *options;
diff --git a/builtin/clean.c b/builtin/clean.c
index ded5a91534c..b5887f877e0 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -915,7 +915,10 @@ static void correct_untracked_entries(struct dir_struct *dir)
 	dir->nr = dst;
 }
 
-int cmd_clean(int argc, const char **argv, const char *prefix)
+int cmd_clean(int argc,
+	      const char **argv,
+	      const char *prefix,
+	      struct repository *repo UNUSED)
 {
 	int i, res;
 	int dry_run = 0, remove_directories = 0, quiet = 0, ignored = 0;
diff --git a/builtin/clone.c b/builtin/clone.c
index 269b6e18a4e..1b82310ac5b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -956,7 +956,10 @@ static int path_exists(const char *path)
 	return !stat(path, &sb);
 }
 
-int cmd_clone(int argc, const char **argv, const char *prefix)
+int cmd_clone(int argc,
+	      const char **argv,
+	      const char *prefix,
+	      struct repository *repository UNUSED)
 {
 	int is_bundle = 0, is_local;
 	int reject_shallow = 0;
diff --git a/builtin/column.c b/builtin/column.c
index 10ff7e01668..93f84beeee7 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -18,7 +18,10 @@ static int column_config(const char *var, const char *value,
 	return git_column_config(var, value, cb, &colopts);
 }
 
-int cmd_column(int argc, const char **argv, const char *prefix)
+int cmd_column(int argc,
+	       const char **argv,
+	       const char *prefix,
+	       struct repository *repo UNUSED)
 {
 	struct string_list list = STRING_LIST_INIT_DUP;
 	struct strbuf sb = STRBUF_INIT;
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 7102ee90a00..65ce98d4675 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -331,7 +331,10 @@ cleanup:
 	return result;
 }
 
-int cmd_commit_graph(int argc, const char **argv, const char *prefix)
+int cmd_commit_graph(int argc,
+		     const char **argv,
+		     const char *prefix,
+		     struct repository *repo UNUSED)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option builtin_commit_graph_options[] = {
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 84bb4502229..bd8bf3296ed 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -90,7 +90,10 @@ static int parse_file_arg_callback(const struct option *opt,
 	return 0;
 }
 
-int cmd_commit_tree(int argc, const char **argv, const char *prefix)
+int cmd_commit_tree(int argc,
+		    const char **argv,
+		    const char *prefix,
+		    struct repository *repo UNUSED)
 {
 	static struct strbuf buffer = STRBUF_INIT;
 	struct commit_list *parents = NULL;
diff --git a/builtin/commit.c b/builtin/commit.c
index b2033c48877..768d76ac461 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1502,7 +1502,10 @@ static int git_status_config(const char *k, const char *v,
 	return git_diff_ui_config(k, v, ctx, NULL);
 }
 
-int cmd_status(int argc, const char **argv, const char *prefix)
+int cmd_status(int argc,
+const char **argv,
+const char *prefix,
+struct repository *repo UNUSED)
 {
 	static int no_renames = -1;
 	static const char *rename_score_arg = (const char *)-1;
@@ -1641,7 +1644,10 @@ static int git_commit_config(const char *k, const char *v,
 	return git_status_config(k, v, ctx, s);
 }
 
-int cmd_commit(int argc, const char **argv, const char *prefix)
+int cmd_commit(int argc,
+	       const char **argv,
+	       const char *prefix,
+	       struct repository *repo UNUSED)
 {
 	static struct wt_status s;
 	static struct option builtin_commit_options[] = {
diff --git a/builtin/config.c b/builtin/config.c
index 95c8a009154..c64baebb1ec 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -1392,7 +1392,10 @@ out:
 	return ret;
 }
 
-int cmd_config(int argc, const char **argv, const char *prefix)
+int cmd_config(int argc,
+	       const char **argv,
+	       const char *prefix,
+	       struct repository *repo UNUSED)
 {
 	parse_opt_subcommand_fn *subcommand = NULL;
 	struct option subcommand_opts[] = {
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index ec6098a149d..6b905da3c3d 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -95,7 +95,10 @@ static char const * const count_objects_usage[] = {
 	NULL
 };
 
-int cmd_count_objects(int argc, const char **argv, const char *prefix)
+int cmd_count_objects(int argc,
+		      const char **argv,
+		      const char *prefix,
+		      struct repository *repo UNUSED)
 {
 	int human_readable = 0;
 	struct option opts[] = {
diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 4952b225477..4caaf38b841 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -287,7 +287,10 @@ static void init_socket_directory(const char *path)
 	free(path_copy);
 }
 
-int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
+int cmd_credential_cache_daemon(int argc,
+				const char **argv,
+				const char *prefix,
+				struct repository *repo UNUSED)
 {
 	struct tempfile *socket_file;
 	const char *socket_path;
@@ -330,7 +333,10 @@ int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
 
 #else
 
-int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
+int cmd_credential_cache_daemon(int argc,
+const char **argv,
+const char *prefix,
+struct repository *repo UNUSED)
 {
 	const char * const usage[] = {
 		"git credential-cache--daemon [--debug] <socket-path>",
diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index aaf2f8438b4..5de8b9123bf 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -137,7 +137,10 @@ static void announce_capabilities(void)
 	credential_announce_capabilities(&c, stdout);
 }
 
-int cmd_credential_cache(int argc, const char **argv, const char *prefix)
+int cmd_credential_cache(int argc,
+			 const char **argv,
+			 const char *prefix,
+			 struct repository *repo UNUSED)
 {
 	const char *socket_path_arg = NULL;
 	char *socket_path;
diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index 97968bfa1c2..128704078e9 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -170,7 +170,10 @@ static void lookup_credential(const struct string_list *fns, struct credential *
 			return; /* Found credential */
 }
 
-int cmd_credential_store(int argc, const char **argv, const char *prefix)
+int cmd_credential_store(int argc,
+			 const char **argv,
+			 const char *prefix,
+			 struct repository *repo UNUSED)
 {
 	const char * const usage[] = {
 		"git credential-store [<options>] <action>",
diff --git a/builtin/credential.c b/builtin/credential.c
index b72e76dd9a6..796422c6fe7 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -6,7 +6,10 @@
 static const char usage_msg[] =
 	"git credential (fill|approve|reject)";
 
-int cmd_credential(int argc, const char **argv, const char *prefix UNUSED)
+int cmd_credential(int argc,
+		   const char **argv,
+		   const char *prefix UNUSED,
+		   struct repository *repo UNUSED)
 {
 	const char *op;
 	struct credential c = CREDENTIAL_INIT;
diff --git a/builtin/describe.c b/builtin/describe.c
index b43093c099f..1c1c250fe0c 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -571,7 +571,10 @@ static int option_parse_exact_match(const struct option *opt, const char *arg,
 	return 0;
 }
 
-int cmd_describe(int argc, const char **argv, const char *prefix)
+int cmd_describe(int argc,
+		 const char **argv,
+		 const char *prefix,
+		 struct repository *repo UNUSED )
 {
 	int contains = 0;
 	struct option options[] = {
@@ -650,7 +653,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			argv_copy[i] = args.v[i];
 		argv_copy[args.nr] = NULL;
 
-		ret = cmd_name_rev(args.nr, argv_copy, prefix);
+		ret = cmd_name_rev(args.nr, argv_copy, prefix, the_repository);
 
 		strvec_clear(&args);
 		free(argv_copy);
diff --git a/builtin/diagnose.c b/builtin/diagnose.c
index 4857a4395ba..66a22d918e6 100644
--- a/builtin/diagnose.c
+++ b/builtin/diagnose.c
@@ -11,7 +11,10 @@ static const char * const diagnose_usage[] = {
 	NULL
 };
 
-int cmd_diagnose(int argc, const char **argv, const char *prefix)
+int cmd_diagnose(int argc,
+		 const char **argv,
+		 const char *prefix,
+		 struct repository *repo UNUSED)
 {
 	struct strbuf zip_path = STRBUF_INIT;
 	time_t now = time(NULL);
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 018011f29ea..7f4f9bcb3eb 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -17,7 +17,10 @@ static const char diff_files_usage[] =
 "\n"
 COMMON_DIFF_OPTIONS_HELP;
 
-int cmd_diff_files(int argc, const char **argv, const char *prefix)
+int cmd_diff_files(int argc,
+		   const char **argv,
+		   const char *prefix,
+		   struct repository *repo UNUSED)
 {
 	struct rev_info rev;
 	int result;
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 685b60284fd..8abec38592f 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -14,7 +14,10 @@ static const char diff_cache_usage[] =
 "\n"
 COMMON_DIFF_OPTIONS_HELP;
 
-int cmd_diff_index(int argc, const char **argv, const char *prefix)
+int cmd_diff_index(int argc,
+		   const char **argv,
+		   const char *prefix,
+		   struct repository *repo UNUSED)
 {
 	struct rev_info rev;
 	unsigned int option = 0;
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index b8df1d4b79b..841448b023f 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -108,7 +108,10 @@ static void diff_tree_tweak_rev(struct rev_info *rev)
 	}
 }
 
-int cmd_diff_tree(int argc, const char **argv, const char *prefix)
+int cmd_diff_tree(int argc,
+		  const char **argv,
+		  const char *prefix,
+		  struct repository *repo UNUSED)
 {
 	char line[1000];
 	struct object *tree1, *tree2;
diff --git a/builtin/diff.c b/builtin/diff.c
index 6eac445579b..499b7872dd4 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -393,7 +393,10 @@ static void symdiff_release(struct symdiff *sdiff)
 	bitmap_free(sdiff->skip);
 }
 
-int cmd_diff(int argc, const char **argv, const char *prefix)
+int cmd_diff(int argc,
+	     const char **argv,
+	     const char *prefix,
+	     struct repository *repo UNUSED)
 {
 	int i;
 	struct rev_info rev;
diff --git a/builtin/difftool.c b/builtin/difftool.c
index dcc68e190c2..c8700d67f4d 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -690,7 +690,10 @@ static int run_file_diff(int prompt, const char *prefix,
 	return run_command(child);
 }
 
-int cmd_difftool(int argc, const char **argv, const char *prefix)
+int cmd_difftool(int argc,
+		 const char **argv,
+		 const char *prefix,
+		 struct repository *repo UNUSED)
 {
 	int use_gui_tool = -1, dir_diff = 0, prompt = -1, symlinks = 0,
 	    tool_help = 0, no_index = 0;
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index f253b79322a..1bd5949dd24 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1180,7 +1180,10 @@ static int parse_opt_anonymize_map(const struct option *opt,
 	return 0;
 }
 
-int cmd_fast_export(int argc, const char **argv, const char *prefix)
+int cmd_fast_export(int argc,
+		    const char **argv,
+		    const char *prefix,
+		    struct repository *repo UNUSED)
 {
 	struct rev_info revs;
 	struct commit *commit;
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 2214c105f17..4b9e341aa44 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3537,7 +3537,10 @@ static void parse_argv(void)
 	build_mark_map(&sub_marks_from, &sub_marks_to);
 }
 
-int cmd_fast_import(int argc, const char **argv, const char *prefix)
+int cmd_fast_import(int argc,
+		    const char **argv,
+		    const char *prefix,
+		    struct repository *repo UNUSED)
 {
 	unsigned int i;
 
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index fe404d1305b..f12daa93498 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -43,7 +43,10 @@ static void add_sought_entry(struct ref ***sought, int *nr, int *alloc,
 	(*sought)[*nr - 1] = ref;
 }
 
-int cmd_fetch_pack(int argc, const char **argv, const char *prefix UNUSED)
+int cmd_fetch_pack(int argc,
+		   const char **argv,
+		   const char *prefix UNUSED,
+		   struct repository *repo UNUSED)
 {
 	int i, ret;
 	struct ref *fetched_refs = NULL, *remote_refs = NULL;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 55f97134aa8..2385ea4952e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2138,7 +2138,10 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 	return exit_code;
 }
 
-int cmd_fetch(int argc, const char **argv, const char *prefix)
+int cmd_fetch(int argc,
+	      const char **argv,
+	      const char *prefix,
+	      struct repository *repo UNUSED)
 {
 	struct fetch_config config = {
 		.display_format = DISPLAY_FORMAT_FULL,
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 957786d1b3a..1fba4cf5590 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -9,7 +9,10 @@ static const char * const fmt_merge_msg_usage[] = {
 	NULL
 };
 
-int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
+int cmd_fmt_merge_msg(int argc,
+		      const char **argv,
+		      const char *prefix,
+		      struct repository *repo UNUSED)
 {
 	char *inpath = NULL;
 	const char *message = NULL;
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 5517a4a1c08..b1187587135 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -16,7 +16,10 @@ static char const * const for_each_ref_usage[] = {
 	NULL
 };
 
-int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
+int cmd_for_each_ref(int argc,
+		     const char **argv,
+		     const char *prefix,
+		     struct repository *repo UNUSED)
 {
 	struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index c4fa41fda9f..93d82b952e9 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -29,7 +29,10 @@ static int run_command_on_repo(const char *path, int argc, const char ** argv)
 	return run_command(&child);
 }
 
-int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
+int cmd_for_each_repo(int argc,
+		      const char **argv,
+		      const char *prefix,
+		      struct repository *repo UNUSED)
 {
 	static const char *config_key = NULL;
 	int keep_going = 0;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 60f4e6fad97..87068cee09d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -925,7 +925,10 @@ static struct option fsck_opts[] = {
 	OPT_END(),
 };
 
-int cmd_fsck(int argc, const char **argv, const char *prefix)
+int cmd_fsck(int argc,
+	     const char **argv,
+	     const char *prefix,
+	     struct repository *repo UNUSED)
 {
 	int i;
 	struct object_directory *odb;
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 1593713f4cb..73a4b885661 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1521,7 +1521,10 @@ static int try_to_start_background_daemon(void)
 	}
 }
 
-int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
+int cmd_fsmonitor__daemon(int argc,
+			  const char **argv,
+			  const char *prefix,
+			  struct repository *repo UNUSED)
 {
 	const char *subcmd;
 	enum fsmonitor_reason reason;
@@ -1584,7 +1587,7 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 }
 
 #else
-int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix UNUSED)
+int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix UNUSED, struct repository *repo UNUSED)
 {
 	struct option options[] = {
 		OPT_END()
diff --git a/builtin/gc.c b/builtin/gc.c
index 7dac9714054..4469c058a02 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -657,7 +657,10 @@ static void gc_before_repack(struct maintenance_run_opts *opts,
 	}
 }
 
-int cmd_gc(int argc, const char **argv, const char *prefix)
+int cmd_gc(int argc,
+const char **argv,
+const char *prefix,
+struct repository *repo UNUSED)
 {
 	int aggressive = 0;
 	int quiet = 0;
@@ -2890,7 +2893,10 @@ static const char * const builtin_maintenance_usage[] = {
 	NULL,
 };
 
-int cmd_maintenance(int argc, const char **argv, const char *prefix)
+int cmd_maintenance(int argc,
+		    const char **argv,
+		    const char *prefix,
+		    struct repository *repo UNUSED)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option builtin_maintenance_options[] = {
diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index 7195a072edc..6bec0d1854c 100644
--- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -12,7 +12,10 @@ static const char builtin_get_tar_commit_id_usage[] =
 #define RECORDSIZE	(512)
 #define HEADERSIZE (2 * RECORDSIZE)
 
-int cmd_get_tar_commit_id(int argc, const char **argv UNUSED, const char *prefix)
+int cmd_get_tar_commit_id(int argc,
+			  const char **argv UNUSED,
+			  const char *prefix,
+			  struct repository *repo UNUSED)
 {
 	char buffer[HEADERSIZE];
 	struct ustar_header *header = (struct ustar_header *)buffer;
diff --git a/builtin/grep.c b/builtin/grep.c
index dfc3c3e8bd2..da11879c637 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -888,7 +888,10 @@ static int pattern_callback(const struct option *opt, const char *arg,
 	return 0;
 }
 
-int cmd_grep(int argc, const char **argv, const char *prefix)
+int cmd_grep(int argc,
+	     const char **argv,
+	     const char *prefix,
+	     struct repository *repo UNUSED)
 {
 	int hit = 0;
 	int cached = 0, untracked = 0, opt_exclude = -1;
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index c767414a0cc..090daea5cd8 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -84,7 +84,10 @@ static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
 	strbuf_release(&unquoted);
 }
 
-int cmd_hash_object(int argc, const char **argv, const char *prefix)
+int cmd_hash_object(int argc,
+		    const char **argv,
+		    const char *prefix,
+		    struct repository *repo UNUSED)
 {
 	static const char * const hash_object_usage[] = {
 		N_("git hash-object [-t <type>] [-w] [--path=<file> | --no-filters]\n"
diff --git a/builtin/help.c b/builtin/help.c
index dc1fbe2b986..f7723bdf5c8 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -631,7 +631,10 @@ static void opt_mode_usage(int argc, const char *opt_mode,
 	no_help_format(opt_mode, fmt);
 }
 
-int cmd_help(int argc, const char **argv, const char *prefix)
+int cmd_help(int argc,
+	     const char **argv,
+	     const char *prefix,
+	     struct repository *repo UNUSED)
 {
 	int nongit;
 	enum help_format parsed_help_format;
diff --git a/builtin/hook.c b/builtin/hook.c
index cc37438fdee..f02e2421ac0 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -66,7 +66,10 @@ usage:
 	usage_with_options(builtin_hook_run_usage, run_options);
 }
 
-int cmd_hook(int argc, const char **argv, const char *prefix)
+int cmd_hook(int argc,
+	     const char **argv,
+	     const char *prefix,
+	     struct repository *repo UNUSED)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option builtin_hook_options[] = {
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 763b01372aa..ece4648d047 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1718,7 +1718,10 @@ static void show_pack_info(int stat_only)
 	free(chain_histogram);
 }
 
-int cmd_index_pack(int argc, const char **argv, const char *prefix)
+int cmd_index_pack(int argc,
+		   const char **argv,
+		   const char *prefix,
+		   struct repository *repo UNUSED)
 {
 	int i, fix_thin_pack = 0, verify = 0, stat_only = 0, rev_index;
 	const char *curr_index;
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 582dcf20f86..94bd6075095 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -70,7 +70,10 @@ static const char *const init_db_usage[] = {
  * On the other hand, it might just make lookup slower and messier. You
  * be the judge.  The default case is to have one DB per managed directory.
  */
-int cmd_init_db(int argc, const char **argv, const char *prefix)
+int cmd_init_db(int argc,
+		const char **argv,
+		const char *prefix,
+		struct repository *repo UNUSED)
 {
 	const char *git_dir;
 	const char *real_git_dir = NULL;
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 1d969494cf5..fb93e54e5ea 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -188,7 +188,10 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	strbuf_release(&sb);
 }
 
-int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
+int cmd_interpret_trailers(int argc,
+			   const char **argv,
+			   const char *prefix,
+			   struct repository *repo UNUSED)
 {
 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
 	LIST_HEAD(trailers);
diff --git a/builtin/log.c b/builtin/log.c
index 36769bab3b6..67140575f4b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -637,7 +637,10 @@ static int git_log_config(const char *var, const char *value,
 	return git_diff_ui_config(var, value, ctx, cb);
 }
 
-int cmd_whatchanged(int argc, const char **argv, const char *prefix)
+int cmd_whatchanged(int argc,
+		    const char **argv,
+		    const char *prefix,
+		    struct repository *repo UNUSED)
 {
 	struct log_config cfg;
 	struct rev_info rev;
@@ -758,7 +761,10 @@ static void show_setup_revisions_tweak(struct rev_info *rev)
 		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
 }
 
-int cmd_show(int argc, const char **argv, const char *prefix)
+int cmd_show(int argc,
+	     const char **argv,
+	     const char *prefix,
+	     struct repository *repo UNUSED)
 {
 	struct log_config cfg;
 	struct rev_info rev;
@@ -874,7 +880,10 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 /*
  * This is equivalent to "git log -g --abbrev-commit --pretty=oneline"
  */
-int cmd_log_reflog(int argc, const char **argv, const char *prefix)
+int cmd_log_reflog(int argc,
+		   const char **argv,
+		   const char *prefix,
+		   struct repository *repo UNUSED)
 {
 	struct log_config cfg;
 	struct rev_info rev;
@@ -916,7 +925,10 @@ static void log_setup_revisions_tweak(struct rev_info *rev)
 		diff_merges_default_to_first_parent(rev);
 }
 
-int cmd_log(int argc, const char **argv, const char *prefix)
+int cmd_log(int argc,
+	    const char **argv,
+	    const char *prefix,
+	    struct repository *repo UNUSED)
 {
 	struct log_config cfg;
 	struct rev_info rev;
@@ -1986,7 +1998,10 @@ static void infer_range_diff_ranges(struct strbuf *r1,
 	}
 }
 
-int cmd_format_patch(int argc, const char **argv, const char *prefix)
+int cmd_format_patch(int argc,
+		     const char **argv,
+		     const char *prefix,
+		     struct repository *repo UNUSED)
 {
 	struct format_config cfg;
 	struct commit *commit;
@@ -2619,7 +2634,10 @@ static void print_commit(char sign, struct commit *commit, int verbose,
 	}
 }
 
-int cmd_cherry(int argc, const char **argv, const char *prefix)
+int cmd_cherry(int argc,
+	       const char **argv,
+	       const char *prefix,
+	       struct repository *repo UNUSED)
 {
 	struct rev_info revs;
 	struct patch_ids ids;
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 6eeb5cba783..7f45cb62cf6 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -561,7 +561,10 @@ static int option_parse_exclude_standard(const struct option *opt,
 	return 0;
 }
 
-int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
+int cmd_ls_files(int argc,
+		 const char **argv,
+		 const char *cmd_prefix,
+		 struct repository *repo UNUSED)
 {
 	int require_work_tree = 0, show_tag = 0, i;
 	char *max_prefix;
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 0a491595ca8..f2c2854d0c3 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -37,7 +37,10 @@ static int tail_match(const struct strvec *pattern, const char *path)
 	return 0;
 }
 
-int cmd_ls_remote(int argc, const char **argv, const char *prefix)
+int cmd_ls_remote(int argc,
+		  const char **argv,
+		  const char *prefix,
+		  struct repository *repo UNUSED)
 {
 	const char *dest = NULL;
 	unsigned flags = 0;
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index bf372c67d77..363cb948d92 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -329,7 +329,10 @@ static struct ls_tree_cmdmode_to_fmt ls_tree_cmdmode_format[] = {
 	},
 };
 
-int cmd_ls_tree(int argc, const char **argv, const char *prefix)
+int cmd_ls_tree(int argc,
+		const char **argv,
+		const char *prefix,
+		struct repository *repo UNUSED)
 {
 	struct object_id oid;
 	struct tree *tree;
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 53a22645da5..00bfcd1afa0 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -48,7 +48,10 @@ static int parse_opt_quoted_cr(const struct option *opt, const char *arg, int un
 	return 0;
 }
 
-int cmd_mailinfo(int argc, const char **argv, const char *prefix)
+int cmd_mailinfo(int argc,
+		 const char **argv,
+		 const char *prefix,
+		 struct repository *repo UNUSED)
 {
 	struct metainfo_charset meta_charset;
 	struct mailinfo mi;
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index fe6dbc5d053..b8f7150ce9a 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -269,7 +269,10 @@ out:
 	return ret;
 }
 
-int cmd_mailsplit(int argc, const char **argv, const char *prefix)
+int cmd_mailsplit(int argc,
+		  const char **argv,
+		  const char *prefix,
+		  struct repository *repo UNUSED)
 {
 	int nr = 0, nr_prec = 4, num = 0;
 	int allow_bare = 0;
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 5a8e7295029..afeae8d8346 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -143,7 +143,10 @@ static int handle_fork_point(int argc, const char **argv)
 	return 0;
 }
 
-int cmd_merge_base(int argc, const char **argv, const char *prefix)
+int cmd_merge_base(int argc,
+		   const char **argv,
+		   const char *prefix,
+		   struct repository *repo UNUSED)
 {
 	struct commit **rev;
 	int rev_nr = 0;
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 1f987334a31..f785813ddae 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -53,7 +53,10 @@ static int diff_algorithm_cb(const struct option *opt,
 	return 0;
 }
 
-int cmd_merge_file(int argc, const char **argv, const char *prefix)
+int cmd_merge_file(int argc,
+		   const char **argv,
+		   const char *prefix,
+		   struct repository *repo UNUSED)
 {
 	const char *names[3] = { 0 };
 	mmfile_t mmfs[3] = { 0 };
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 0fabe3f6bb2..1309a8ff471 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -73,7 +73,10 @@ static void merge_all(void)
 	}
 }
 
-int cmd_merge_index(int argc, const char **argv, const char *prefix UNUSED)
+int cmd_merge_index(int argc,
+		    const char **argv,
+		    const char *prefix UNUSED,
+		    struct repository *repo UNUSED)
 {
 	int i, force_file = 0;
 
diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index 932924e5d0e..62267f12dd8 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -15,7 +15,10 @@
 static const char builtin_merge_ours_usage[] =
 	"git merge-ours <base>... -- HEAD <remote>...";
 
-int cmd_merge_ours(int argc, const char **argv, const char *prefix UNUSED)
+int cmd_merge_ours(int argc,
+		   const char **argv,
+		   const char *prefix UNUSED,
+		   struct repository *repo UNUSED)
 {
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(builtin_merge_ours_usage);
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index e951b09805d..2bd3fb0e553 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -21,7 +21,10 @@ static char *better_branch_name(const char *branch)
 	return xstrdup(name ? name : branch);
 }
 
-int cmd_merge_recursive(int argc, const char **argv, const char *prefix UNUSED)
+int cmd_merge_recursive(int argc,
+			const char **argv,
+			const char *prefix UNUSED,
+			struct repository *repo UNUSED)
 {
 	struct object_id bases[21];
 	unsigned bases_count = 0;
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index c00469ed3db..aeaec9d99f3 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -526,7 +526,10 @@ static int real_merge(struct merge_tree_options *o,
 	return !result.clean; /* result.clean < 0 handled above */
 }
 
-int cmd_merge_tree(int argc, const char **argv, const char *prefix)
+int cmd_merge_tree(int argc,
+		   const char **argv,
+		   const char *prefix,
+		   struct repository *repo UNUSED)
 {
 	struct merge_tree_options o = { .show_messages = -1 };
 	struct strvec xopts = STRVEC_INIT;
diff --git a/builtin/merge.c b/builtin/merge.c
index 662a49a0e8c..fd6dc00d6c0 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1275,7 +1275,10 @@ static int merging_a_throwaway_tag(struct commit *commit)
 	return is_throwaway_tag;
 }
 
-int cmd_merge(int argc, const char **argv, const char *prefix)
+int cmd_merge(int argc,
+	      const char **argv,
+	      const char *prefix,
+	      struct repository *repo UNUSED)
 {
 	struct object_id result_tree, stash, head_oid;
 	struct commit *head_commit;
@@ -1347,7 +1350,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 					REF_NO_DEREF);
 
 		/* Invoke 'git reset --merge' */
-		ret = cmd_reset(nargc, nargv, prefix);
+		ret = cmd_reset(nargc, nargv, prefix, the_repository);
 
 		if (!is_null_oid(&stash_oid)) {
 			oid_to_hex_r(stash_oid_hex, &stash_oid);
@@ -1379,7 +1382,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			die(_("There is no merge in progress (MERGE_HEAD missing)."));
 
 		/* Invoke 'git commit' */
-		ret = cmd_commit(nargc, nargv, prefix);
+		ret = cmd_commit(nargc, nargv, prefix, the_repository);
 		goto done;
 	}
 
diff --git a/builtin/mktag.c b/builtin/mktag.c
index c6b644219fb..5cd8a3e6fa0 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -71,7 +71,10 @@ static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
 	return ret;
 }
 
-int cmd_mktag(int argc, const char **argv, const char *prefix)
+int cmd_mktag(int argc,
+	      const char **argv,
+	      const char *prefix,
+	      struct repository *repo UNUSED)
 {
 	static struct option builtin_mktag_options[] = {
 		OPT_BOOL(0, "strict", &option_strict,
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 9a22d4e2773..72a1af1bca5 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -150,7 +150,10 @@ static void mktree_line(char *buf, int nul_term_line, int allow_missing)
 	free(to_free);
 }
 
-int cmd_mktree(int ac, const char **av, const char *prefix)
+int cmd_mktree(int ac,
+	       const char **av,
+	       const char *prefix,
+	       struct repository *repo UNUSED)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct object_id oid;
@@ -199,5 +202,6 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 		used=0; /* reset tree entry buffer for re-use in batch mode */
 	}
 	strbuf_release(&sb);
+
 	return 0;
 }
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 8805cbbeb3b..154fc77075f 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -267,8 +267,10 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv,
 			   (size_t)opts.batch_size, opts.flags);
 }
 
-int cmd_multi_pack_index(int argc, const char **argv,
-			 const char *prefix)
+int cmd_multi_pack_index(int argc,
+			 const char **argv,
+			 const char *prefix,
+			 struct repository *repo UNUSED)
 {
 	int res;
 	parse_opt_subcommand_fn *fn = NULL;
diff --git a/builtin/mv.c b/builtin/mv.c
index 6c69033c5f5..6e2eb9cf4b8 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -178,7 +178,10 @@ static void remove_empty_src_dirs(const char **src_dir, size_t src_dir_nr)
 	strbuf_release(&a_src_dir);
 }
 
-int cmd_mv(int argc, const char **argv, const char *prefix)
+int cmd_mv(int argc,
+	   const char **argv,
+	   const char *prefix,
+	   struct repository *repo UNUSED)
 {
 	int i, flags, gitmodules_modified = 0;
 	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0, ignore_sparse = 0;
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index a468ef84c37..19d92fb382d 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -558,7 +558,10 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 	strbuf_release(&buf);
 }
 
-int cmd_name_rev(int argc, const char **argv, const char *prefix)
+int cmd_name_rev(int argc,
+		 const char **argv,
+		 const char *prefix,
+		 struct repository *repo UNUSED)
 {
 	struct mem_pool string_pool;
 	struct object_array revs = OBJECT_ARRAY_INIT;
diff --git a/builtin/notes.c b/builtin/notes.c
index 04f9dfb7fbd..49d8364af60 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -1096,7 +1096,10 @@ static int get_ref(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-int cmd_notes(int argc, const char **argv, const char *prefix)
+int cmd_notes(int argc,
+	      const char **argv,
+	      const char *prefix,
+	      struct repository *repo UNUSED)
 {
 	const char *override_notes_ref = NULL;
 	parse_opt_subcommand_fn *fn = NULL;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c6e2852d3ca..0260a9886aa 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4312,7 +4312,10 @@ static int option_parse_cruft_expiration(const struct option *opt UNUSED,
 	return 0;
 }
 
-int cmd_pack_objects(int argc, const char **argv, const char *prefix)
+int cmd_pack_objects(int argc,
+		     const char **argv,
+		     const char *prefix,
+		     struct repository *repo UNUSED)
 {
 	int use_internal_rev_list = 0;
 	int shallow = 0;
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index dd9bf35f5b8..84f0d83affb 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -561,11 +561,8 @@ static void load_all(void)
 	}
 }
 
-int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED)
-{
-	int i;
-	int i_still_use_this = 0;
-	struct pack_list *min = NULL, *red, *pl;
+int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, struct repository *repo UNUSED) {
+	int i; int i_still_use_this = 0; struct pack_list *min = NULL, *red, *pl;
 	struct llist *ignore;
 	struct object_id *oid;
 	char buf[GIT_MAX_HEXSZ + 2]; /* hex hash + \n + \0 */
diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index db408256663..67dabb39756 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -11,7 +11,10 @@ static char const * const pack_refs_usage[] = {
 	NULL
 };
 
-int cmd_pack_refs(int argc, const char **argv, const char *prefix)
+int cmd_pack_refs(int argc,
+		  const char **argv,
+		  const char *prefix,
+		  struct repository *repo UNUSED)
 {
 	struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
 	struct string_list included_refs = STRING_LIST_INIT_NODUP;
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 35c1179f7e9..fa31a1b7a60 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -260,7 +260,10 @@ static int git_patch_id_config(const char *var, const char *value,
 	return git_default_config(var, value, ctx, cb);
 }
 
-int cmd_patch_id(int argc, const char **argv, const char *prefix)
+int cmd_patch_id(int argc,
+		 const char **argv,
+		 const char *prefix,
+		 struct repository *repo UNUSED)
 {
 	/* if nothing is set, default to unstable */
 	struct patch_id_opts config = {0, 0};
diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index ca3578e1588..4d63f26b0a1 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -8,7 +8,10 @@ static const char * const prune_packed_usage[] = {
 	NULL
 };
 
-int cmd_prune_packed(int argc, const char **argv, const char *prefix)
+int cmd_prune_packed(int argc,
+		     const char **argv,
+		     const char *prefix,
+		     struct repository *repo UNUSED)
 {
 	int opts = isatty(2) ? PRUNE_PACKED_VERBOSE : 0;
 	const struct option prune_packed_options[] = {
diff --git a/builtin/prune.c b/builtin/prune.c
index 57fe31467fe..cbd4c38fa0a 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -147,7 +147,10 @@ static void remove_temporary_files(const char *path)
 	closedir(dir);
 }
 
-int cmd_prune(int argc, const char **argv, const char *prefix)
+int cmd_prune(int argc,
+	      const char **argv,
+	      const char *prefix,
+	      struct repository *repo UNUSED)
 {
 	struct rev_info revs;
 	int exclude_promisor_objects = 0;
diff --git a/builtin/pull.c b/builtin/pull.c
index 4c54d8196fa..1a926f0b0d7 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -977,7 +977,10 @@ static void show_advice_pull_non_ff(void)
 		 "invocation.\n"));
 }
 
-int cmd_pull(int argc, const char **argv, const char *prefix)
+int cmd_pull(int argc,
+	     const char **argv,
+	     const char *prefix,
+	     struct repository *repository UNUSED)
 {
 	const char *repo, **refspecs;
 	struct oid_array merge_heads = OID_ARRAY_INIT;
diff --git a/builtin/push.c b/builtin/push.c
index 7a67398124f..9636ad52f4d 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -546,7 +546,10 @@ static int git_push_config(const char *k, const char *v,
 	return git_default_config(k, v, ctx, NULL);
 }
 
-int cmd_push(int argc, const char **argv, const char *prefix)
+int cmd_push(int argc,
+	     const char **argv,
+	     const char *prefix,
+	     struct repository *repository UNUSED)
 {
 	int flags = 0;
 	int tags = 0;
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index f02cbac087d..3e67259aecc 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -13,7 +13,10 @@ N_("git range-diff [<options>] <base> <old-tip> <new-tip>"),
 NULL
 };
 
-int cmd_range_diff(int argc, const char **argv, const char *prefix)
+int cmd_range_diff(int argc,
+		   const char **argv,
+		   const char *prefix,
+		   struct repository *repo UNUSED)
 {
 	struct diff_options diffopt = { NULL };
 	struct strvec other_arg = STRVEC_INIT;
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index a8cf8504b8a..89410db6a7a 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -108,7 +108,10 @@ static int git_read_tree_config(const char *var, const char *value,
 	return git_default_config(var, value, ctx, cb);
 }
 
-int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
+int cmd_read_tree(int argc,
+		  const char **argv,
+		  const char *cmd_prefix,
+		  struct repository *repo UNUSED)
 {
 	int i, stage = 0;
 	struct object_id oid;
diff --git a/builtin/rebase.c b/builtin/rebase.c
index a2c96c080e1..727d9df847f 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1063,7 +1063,10 @@ static int check_exec_cmd(const char *cmd)
 	return 0;
 }
 
-int cmd_rebase(int argc, const char **argv, const char *prefix)
+int cmd_rebase(int argc,
+	       const char **argv,
+	       const char *prefix,
+	       struct repository *repo UNUSED)
 {
 	struct rebase_options options = REBASE_OPTIONS_INIT;
 	const char *branch_name;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 3f35140e489..36a6229c2a4 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2480,7 +2480,10 @@ static int delete_only(struct command *commands)
 	return 1;
 }
 
-int cmd_receive_pack(int argc, const char **argv, const char *prefix)
+int cmd_receive_pack(int argc,
+		     const char **argv,
+		     const char *prefix,
+		     struct repository *repo UNUSED)
 {
 	int advertise_refs = 0;
 	struct command *commands;
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 0d2ff95c6e7..6250f5ad49f 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -244,7 +244,7 @@ static int cmd_reflog_show(int argc, const char **argv, const char *prefix)
 		      PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0 |
 		      PARSE_OPT_KEEP_UNKNOWN_OPT);
 
-	return cmd_log_reflog(argc, argv, prefix);
+	return cmd_log_reflog(argc, argv, prefix, the_repository);
 }
 
 static int show_reflog(const char *refname, void *cb_data UNUSED)
@@ -447,7 +447,10 @@ static int cmd_reflog_exists(int argc, const char **argv, const char *prefix)
  * main "reflog"
  */
 
-int cmd_reflog(int argc, const char **argv, const char *prefix)
+int cmd_reflog(int argc,
+	       const char **argv,
+	       const char *prefix,
+	       struct repository *repository)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
@@ -466,5 +469,5 @@ int cmd_reflog(int argc, const char **argv, const char *prefix)
 	if (fn)
 		return fn(argc - 1, argv + 1, prefix);
 	else
-		return cmd_log_reflog(argc, argv, prefix);
+		return cmd_log_reflog(argc, argv, prefix, repository);
 }
diff --git a/builtin/refs.c b/builtin/refs.c
index 131f98be986..70bca724d2a 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -90,7 +90,10 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-int cmd_refs(int argc, const char **argv, const char *prefix)
+int cmd_refs(int argc,
+	     const char **argv,
+	     const char *prefix,
+	     struct repository *repo UNUSED)
 {
 	const char * const refs_usage[] = {
 		REFS_MIGRATE_USAGE,
diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index 282782eccdd..33c8ae0fc7d 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -195,7 +195,10 @@ static int command_loop(const char *child)
 	}
 }
 
-int cmd_remote_ext(int argc, const char **argv, const char *prefix)
+int cmd_remote_ext(int argc,
+		   const char **argv,
+		   const char *prefix,
+		   struct repository *repo UNUSED)
 {
 	BUG_ON_NON_EMPTY_PREFIX(prefix);
 
diff --git a/builtin/remote-fd.c b/builtin/remote-fd.c
index 9020fab9c58..ae896eda57b 100644
--- a/builtin/remote-fd.c
+++ b/builtin/remote-fd.c
@@ -53,7 +53,10 @@ static void command_loop(int input_fd, int output_fd)
 	}
 }
 
-int cmd_remote_fd(int argc, const char **argv, const char *prefix)
+int cmd_remote_fd(int argc,
+		  const char **argv,
+		  const char *prefix,
+		  struct repository *repo UNUSED)
 {
 	int input_fd = -1;
 	int output_fd = -1;
diff --git a/builtin/remote.c b/builtin/remote.c
index 0acc547d691..a73eea9ae4c 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1761,7 +1761,10 @@ out:
 	return 0;
 }
 
-int cmd_remote(int argc, const char **argv, const char *prefix)
+int cmd_remote(int argc,
+	       const char **argv,
+	       const char *prefix,
+	       struct repository *repo UNUSED)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
diff --git a/builtin/repack.c b/builtin/repack.c
index 8bb875532b4..b0c7dd14338 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1134,7 +1134,10 @@ static const char *find_pack_prefix(const char *packdir, const char *packtmp)
 	return pack_prefix;
 }
 
-int cmd_repack(int argc, const char **argv, const char *prefix)
+int cmd_repack(int argc,
+	       const char **argv,
+	       const char *prefix,
+	       struct repository *repo UNUSED)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list_item *item;
diff --git a/builtin/replace.c b/builtin/replace.c
index 34cc4672bc1..293ae6d327f 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -545,7 +545,10 @@ static int convert_graft_file(int force)
 	return -1;
 }
 
-int cmd_replace(int argc, const char **argv, const char *prefix)
+int cmd_replace(int argc,
+		const char **argv,
+		const char *prefix,
+		struct repository *repo UNUSED)
 {
 	int force = 0;
 	int raw = 0;
diff --git a/builtin/replay.c b/builtin/replay.c
index 138198ce9ca..c8e9098fc12 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -274,7 +274,10 @@ static struct commit *pick_regular_commit(struct commit *pickme,
 	return create_commit(result->tree, pickme, replayed_base);
 }
 
-int cmd_replay(int argc, const char **argv, const char *prefix)
+int cmd_replay(int argc,
+	       const char **argv,
+	       const char *prefix,
+	       struct repository *repo UNUSED)
 {
 	const char *advance_name_opt = NULL;
 	char *advance_name = NULL;
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 81b65ffa39c..ae345155834 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -48,7 +48,10 @@ static int diff_two(const char *file1, const char *label1,
 	return ret;
 }
 
-int cmd_rerere(int argc, const char **argv, const char *prefix)
+int cmd_rerere(int argc,
+	       const char **argv,
+	       const char *prefix,
+	       struct repository *repo UNUSED)
 {
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 	int i, autoupdate = -1, flags = 0;
diff --git a/builtin/reset.c b/builtin/reset.c
index 5f941fb3a29..75529072606 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -330,7 +330,10 @@ static int git_reset_config(const char *var, const char *value,
 	return git_default_config(var, value, ctx, cb);
 }
 
-int cmd_reset(int argc, const char **argv, const char *prefix)
+int cmd_reset(int argc,
+	      const char **argv,
+	      const char *prefix,
+	      struct repository *repo UNUSED)
 {
 	int reset_type = NONE, update_ref_status = 0, quiet = 0;
 	int no_refresh = 0;
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 97d077a9943..a4186d47ce3 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -513,7 +513,10 @@ static int try_bitmap_disk_usage(struct rev_info *revs,
 	return 0;
 }
 
-int cmd_rev_list(int argc, const char **argv, const char *prefix)
+int cmd_rev_list(int argc,
+		 const char **argv,
+		 const char *prefix,
+		 struct repository *repo UNUSED)
 {
 	struct rev_info revs;
 	struct rev_list_info info;
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 4285dc34a7b..26190aaa3ed 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -688,7 +688,10 @@ static void print_path(const char *path, const char *prefix, enum format_type fo
 	free(cwd);
 }
 
-int cmd_rev_parse(int argc, const char **argv, const char *prefix)
+int cmd_rev_parse(int argc,
+		  const char **argv,
+		  const char *prefix,
+		  struct repository *repo UNUSED)
 {
 	int i, as_is = 0, verify = 0, quiet = 0, revs_count = 0, type = 0;
 	const struct git_hash_algo *output_algo = NULL;
diff --git a/builtin/revert.c b/builtin/revert.c
index 7bf2b4e11d6..5f2ec3ade73 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -261,7 +261,10 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 	return sequencer_pick_revisions(the_repository, opts);
 }
 
-int cmd_revert(int argc, const char **argv, const char *prefix)
+int cmd_revert(int argc,
+	       const char **argv,
+	       const char *prefix,
+	       struct repository *repo UNUSED)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	int res;
@@ -275,7 +278,10 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	return res;
 }
 
-int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
+int cmd_cherry_pick(int argc,
+const char **argv,
+const char *prefix,
+struct repository *repo UNUSED)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	int res;
diff --git a/builtin/rm.c b/builtin/rm.c
index 0e79cbab62b..59077efa4b4 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -261,7 +261,10 @@ static struct option builtin_rm_options[] = {
 	OPT_END(),
 };
 
-int cmd_rm(int argc, const char **argv, const char *prefix)
+int cmd_rm(int argc,
+	   const char **argv,
+	   const char *prefix,
+	   struct repository *repo UNUSED)
 {
 	struct lock_file lock_file = LOCK_INIT;
 	int i, ret = 0;
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index ef0df808249..522c2f4d133 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -147,7 +147,10 @@ static int send_pack_config(const char *k, const char *v,
 	return git_default_config(k, v, ctx, cb);
 }
 
-int cmd_send_pack(int argc, const char **argv, const char *prefix)
+int cmd_send_pack(int argc,
+		  const char **argv,
+		  const char *prefix,
+		  struct repository *repo UNUSED)
 {
 	struct refspec rs = REFSPEC_INIT_PUSH;
 	const char *remote_name = NULL;
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index b529608c923..70eb7890334 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -378,7 +378,10 @@ void shortlog_finish_setup(struct shortlog *log)
 	string_list_sort(&log->trailers);
 }
 
-int cmd_shortlog(int argc, const char **argv, const char *prefix)
+int cmd_shortlog(int argc,
+		 const char **argv,
+		 const char *prefix,
+		 struct repository *repo UNUSED)
 {
 	struct shortlog log = { STRING_LIST_INIT_NODUP };
 	struct rev_info rev;
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 29237f653d8..05c10628df9 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -632,7 +632,10 @@ static int parse_reflog_param(const struct option *opt, const char *arg,
 	return 0;
 }
 
-int cmd_show_branch(int ac, const char **av, const char *prefix)
+int cmd_show_branch(int ac,
+		const char **av,
+		const char *prefix,
+		struct repository *repo UNUSED)
 {
 	struct commit *rev[MAX_REVS], *commit;
 	char *reflog_msg[MAX_REVS] = {0};
diff --git a/builtin/show-index.c b/builtin/show-index.c
index 540dc3dad1c..9e1f7ac9ca5 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -11,7 +11,10 @@ static const char *const show_index_usage[] = {
 	NULL
 };
 
-int cmd_show_index(int argc, const char **argv, const char *prefix)
+int cmd_show_index(int argc,
+		   const char **argv,
+		   const char *prefix,
+		   struct repository *repo UNUSED)
 {
 	int i;
 	unsigned nr;
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index f5899ce9ff7..6ee05f09a69 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -287,7 +287,10 @@ static int exclude_existing_callback(const struct option *opt, const char *arg,
 	return 0;
 }
 
-int cmd_show_ref(int argc, const char **argv, const char *prefix)
+int cmd_show_ref(int argc,
+const char **argv,
+const char *prefix,
+struct repository *repo UNUSED)
 {
 	struct exclude_existing_options exclude_existing_opts = {0};
 	struct patterns_options patterns_opts = {0};
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 2604ab04df5..23f1548fe54 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -1030,7 +1030,10 @@ static int sparse_checkout_check_rules(int argc, const char **argv, const char *
 	return ret;
 }
 
-int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
+int cmd_sparse_checkout(int argc,
+			const char **argv,
+			const char *prefix,
+			struct repository *repo UNUSED)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option builtin_sparse_checkout_options[] = {
diff --git a/builtin/stash.c b/builtin/stash.c
index be842258d06..b10d41e1f2b 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1871,7 +1871,10 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-int cmd_stash(int argc, const char **argv, const char *prefix)
+int cmd_stash(int argc,
+	      const char **argv,
+	      const char *prefix,
+	      struct repository *repo UNUSED)
 {
 	pid_t pid = getpid();
 	const char *index_file;
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index e5626e51266..674ef939769 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -29,7 +29,10 @@ enum stripspace_mode {
 	COMMENT_LINES
 };
 
-int cmd_stripspace(int argc, const char **argv, const char *prefix)
+int cmd_stripspace(int argc,
+		   const char **argv,
+		   const char *prefix,
+		   struct repository *repo UNUSED)
 {
 	struct strbuf buf = STRBUF_INIT;
 	enum stripspace_mode mode = STRIP_DEFAULT;
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a46ffd49b34..cc07ab46a33 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3528,7 +3528,10 @@ cleanup:
 	return ret;
 }
 
-int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
+int cmd_submodule__helper(int argc,
+			  const char **argv,
+			  const char *prefix,
+			  struct repository *repo UNUSED)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	const char *const usage[] = {
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 81abdd170fe..9bc70229468 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -41,7 +41,10 @@ static int check_symref(const char *HEAD, int quiet, int shorten, int recurse, i
 	return 0;
 }
 
-int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
+int cmd_symbolic_ref(int argc,
+		     const char **argv,
+		     const char *prefix,
+		     struct repository *repo UNUSED)
 {
 	int quiet = 0, delete = 0, shorten = 0, recurse = 1, ret = 0;
 	const char *msg = NULL;
diff --git a/builtin/tag.c b/builtin/tag.c
index a1fb218512c..a80838eb8e0 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -457,7 +457,10 @@ static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
 	return check_refname_format(sb->buf, 0);
 }
 
-int cmd_tag(int argc, const char **argv, const char *prefix)
+int cmd_tag(int argc,
+	    const char **argv,
+	    const char *prefix,
+	    struct repository *repo UNUSED)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf ref = STRBUF_INIT;
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index c129e2bb6cb..97886840f8d 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -25,7 +25,10 @@ static char *create_temp_file(struct object_id *oid)
 	return path;
 }
 
-int cmd_unpack_file(int argc, const char **argv, const char *prefix UNUSED)
+int cmd_unpack_file(int argc,
+		    const char **argv,
+		    const char *prefix UNUSED,
+		    struct repository *repo UNUSED)
 {
 	struct object_id oid;
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 08fa2a7a743..3bcdaaeb5fa 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -601,7 +601,10 @@ static void unpack_all(void)
 		die("unresolved deltas left after unpacking");
 }
 
-int cmd_unpack_objects(int argc, const char **argv, const char *prefix UNUSED)
+int cmd_unpack_objects(int argc,
+		       const char **argv,
+		       const char *prefix UNUSED,
+		       struct repository *repo UNUSED)
 {
 	int i;
 	struct object_id oid;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 35a1f957adc..1d1d87d08e3 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -917,7 +917,10 @@ static enum parse_opt_result reupdate_callback(
 	return 0;
 }
 
-int cmd_update_index(int argc, const char **argv, const char *prefix)
+int cmd_update_index(int argc,
+		     const char **argv,
+		     const char *prefix,
+		     struct repository *repo UNUSED)
 {
 	int newfd, entries, has_errors = 0, nul_term_line = 0;
 	enum uc_mode untracked_cache = UC_UNSPECIFIED;
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 8f31da9a4b7..06826a90515 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -713,7 +713,10 @@ static void update_refs_stdin(void)
 	strbuf_release(&input);
 }
 
-int cmd_update_ref(int argc, const char **argv, const char *prefix)
+int cmd_update_ref(int argc,
+		   const char **argv,
+		   const char *prefix,
+		   struct repository *repo UNUSED)
 {
 	const char *refname, *oldval;
 	struct object_id oid, oldoid;
diff --git a/builtin/update-server-info.c b/builtin/update-server-info.c
index 1dc3971edeb..a5b7d86727c 100644
--- a/builtin/update-server-info.c
+++ b/builtin/update-server-info.c
@@ -9,7 +9,10 @@ static const char * const update_server_info_usage[] = {
 	NULL
 };
 
-int cmd_update_server_info(int argc, const char **argv, const char *prefix)
+int cmd_update_server_info(int argc,
+			   const char **argv,
+			   const char *prefix,
+			   struct repository *repo UNUSED)
 {
 	int force = 0;
 	struct option options[] = {
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 313a8dfa81c..dd84c83f137 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -18,7 +18,10 @@ static const char deadchild[] =
 
 #define MAX_ARGS (64)
 
-int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
+int cmd_upload_archive_writer(int argc,
+			      const char **argv,
+			      const char *prefix,
+			      struct repository *repo UNUSED)
 {
 	struct strvec sent_argv = STRVEC_INIT;
 	const char *arg_cmd = "argument ";
@@ -80,7 +83,10 @@ static ssize_t process_input(int child_fd, int band)
 	return sz;
 }
 
-int cmd_upload_archive(int argc, const char **argv, const char *prefix)
+int cmd_upload_archive(int argc,
+const char **argv,
+const char *prefix,
+struct repository *repo UNUSED)
 {
 	struct child_process writer = CHILD_PROCESS_INIT;
 
diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index 46d93278d9a..3b6c83fbce3 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -17,7 +17,10 @@ static const char * const upload_pack_usage[] = {
 	NULL
 };
 
-int cmd_upload_pack(int argc, const char **argv, const char *prefix)
+int cmd_upload_pack(int argc,
+		    const char **argv,
+		    const char *prefix,
+		    struct repository *repo UNUSED)
 {
 	const char *dir;
 	int strict = 0;
diff --git a/builtin/var.c b/builtin/var.c
index e30ff45be1c..4a5c2649d6f 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -210,7 +210,10 @@ static int show_config(const char *var, const char *value,
 	return git_default_config(var, value, ctx, cb);
 }
 
-int cmd_var(int argc, const char **argv, const char *prefix UNUSED)
+int cmd_var(int argc,
+	    const char **argv,
+	    const char *prefix UNUSED,
+	    struct repository *repo UNUSED)
 {
 	const struct git_var *git_var;
 	char *val;
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 0d2b9aea2ae..c5859e5b2b4 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -51,7 +51,10 @@ static int verify_commit(const char *name, unsigned flags)
 	return run_gpg_verify((struct commit *)obj, flags);
 }
 
-int cmd_verify_commit(int argc, const char **argv, const char *prefix)
+int cmd_verify_commit(int argc,
+		      const char **argv,
+		      const char *prefix,
+		      struct repository *repo UNUSED)
 {
 	int i = 1, verbose = 0, had_error = 0;
 	unsigned flags = 0;
diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index 011dddd2dc3..7ad456649d2 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -61,7 +61,10 @@ static const char * const verify_pack_usage[] = {
 	NULL
 };
 
-int cmd_verify_pack(int argc, const char **argv, const char *prefix)
+int cmd_verify_pack(int argc,
+		    const char **argv,
+		    const char *prefix,
+		    struct repository *repo UNUSED)
 {
 	int err = 0;
 	unsigned int flags = 0;
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index c731e2f87b4..a7bef524191 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -19,7 +19,10 @@ static const char * const verify_tag_usage[] = {
 		NULL
 };
 
-int cmd_verify_tag(int argc, const char **argv, const char *prefix)
+int cmd_verify_tag(int argc,
+		   const char **argv,
+		   const char *prefix,
+		   struct repository *repo UNUSED)
 {
 	int i = 1, verbose = 0, had_error = 0;
 	unsigned flags = 0;
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 41e7f6a3271..3b47f9832fa 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1392,7 +1392,10 @@ static int repair(int ac, const char **av, const char *prefix)
 	return rc;
 }
 
-int cmd_worktree(int ac, const char **av, const char *prefix)
+int cmd_worktree(int ac,
+		 const char **av,
+		 const char *prefix,
+		 struct repository *repo UNUSED)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index 8c75b4609b5..1b467d6ed23 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -19,7 +19,10 @@ static const char * const write_tree_usage[] = {
 	NULL
 };
 
-int cmd_write_tree(int argc, const char **argv, const char *cmd_prefix)
+int cmd_write_tree(int argc,
+		   const char **argv,
+		   const char *cmd_prefix,
+		   struct repository *repo UNUSED)
 {
 	int flags = 0, ret;
 	const char *tree_prefix = NULL;
diff --git a/git.c b/git.c
index 9a618a2740f..2fbea24ec92 100644
--- a/git.c
+++ b/git.c
@@ -31,7 +31,7 @@
 
 struct cmd_struct {
 	const char *cmd;
-	int (*fn)(int, const char **, const char *);
+	int (*fn)(int, const char **, const char *, struct repository *);
 	unsigned int option;
 };
 
@@ -441,7 +441,7 @@ static int handle_alias(int *argcp, const char ***argv)
 	return ret;
 }
 
-static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
+static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct repository *repo)
 {
 	int status, help;
 	struct stat st;
@@ -479,9 +479,9 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	trace_argv_printf(argv, "trace: built-in: git");
 	trace2_cmd_name(p->cmd);
 
-	validate_cache_entries(the_repository->index);
-	status = p->fn(argc, argv, prefix);
-	validate_cache_entries(the_repository->index);
+	validate_cache_entries(repo->index);
+	status = p->fn(argc, argv, prefix, (p->option & RUN_SETUP)? repo : NULL);
+	validate_cache_entries(repo->index);
 
 	if (status)
 		return status;
@@ -736,7 +736,7 @@ static void handle_builtin(int argc, const char **argv)
 
 	builtin = get_builtin(cmd);
 	if (builtin)
-		exit(run_builtin(builtin, argc, argv));
+		exit(run_builtin(builtin, argc, argv, the_repository));
 	strvec_clear(&args);
 }
 
diff --git a/help.c b/help.c
index c03863f2265..e7cdfab6432 100644
--- a/help.c
+++ b/help.c
@@ -16,6 +16,7 @@
 #include "parse-options.h"
 #include "prompt.h"
 #include "fsmonitor-ipc.h"
+#include "repository.h"
 
 #ifndef NO_CURL
 #include "git-curl-compat.h" /* For LIBCURL_VERSION only */
@@ -775,7 +776,7 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 	}
 }
 
-int cmd_version(int argc, const char **argv, const char *prefix)
+int cmd_version(int argc, const char **argv, const char *prefix, struct repository *repository UNUSED)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int build_options = 0;
-- 
gitgitgadget

