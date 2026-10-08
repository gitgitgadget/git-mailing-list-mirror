Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117484218A4
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493652; cv=none; b=jTOTh8XqATywQ3uHGOLw+PUHIwMvVXrdXj4E+z830b9R4V9gN4g7rkWCr7lq60nm+Ia4nOzTf9JSrg5tzsWjvS0FHhwlTuTQf5bIkH4pidNpwIeVOUrX2nc8RtEyDQE1BaoxcaNhKWxM3UOpXNgTeXA1iNvuSZ2CQ7Nr0iZcmzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493652; c=relaxed/simple;
	bh=SePkRGEYMyks7nMEAnwKmjHlWxGdlBTSER/gPmjAgoQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EcPmgdobR20jTvY7J0oNxUwT8KX8+UQLzXgv7kA8zumievEj0E5OJzTMiNz3ugDWJF0iVuWXXumTWSbQUe4GO/xokI+FOMxsFDhgaoFrFV3cXlwV41jnZbQ/XogEKc6rLPmEe7yY+jJ+yd+7jh9O9ds1pEtFrsVBrbAxSBSgIEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiEXGgtx; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiEXGgtx"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-504ae5941faso807535b6e.3
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 14:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791493649; x=1792098449; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5B7EPEBX9VTV6d7kTAXexBfkM+vRxKoL1WDjjlZ7Yzs=;
        b=fiEXGgtxiaQX78JnJ5gEyWAmIwjaOM/BlJrtCbyYWNVovIEmHIi3ivk0ipZXpUGQwi
         7oGXF42Y77ULu8BSso+xlJ/B9elAH5OmMKA1KNNewyX97iADl02A0iVzVdqxQkNYiXQB
         pGK7DrSBULyJY/QDA/IXESaBrwS6bwqcWepYJMspkraH/+y+HmbpKICh/+dmmLJuV8eO
         w+FXcdQpSFstkG7r3ozk2u52Nof8KM43hqQf6KeUp6wiNBQBnHDzOpTofEk5I28oOxL6
         Q902R6anAlsC0cxRCzs/QSu179VWS/CwqChE8JddnU80SuHRKGJr9nR+gfjvEa8QUZ2b
         n/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791493649; x=1792098449;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5B7EPEBX9VTV6d7kTAXexBfkM+vRxKoL1WDjjlZ7Yzs=;
        b=btUVdfPiID7ypywb4aH+ezgAhBnacO83tHDJnBh0h+OzfKNPk3IjsjcgtAqLAkcdig
         BD97Ti/6b2n0iiBR0IyyakW/W9YHzqfD9bk26fbivrp8Jzh74BjxV8t+K6bilzCokFGB
         jDewXXKQOZ9m8zQnUK1/9zv3MLznv/SKpQvydC3JQmbu/JsJFoMKygQ6PeL5RStzxKXU
         q2o2ssVeDPP594luYEV06HxNqDp8en+/KU4j2VCVrtEHOMtPIr+VdViZ7VgKI0mJI15K
         ftgLrpuyrE5BUdd1oBWVj2UugkbmSx2yIfzjQ2/pWS95MVPmu3P+OZnjEfKHwvsO+6UB
         W88g==
X-Gm-Message-State: AFuF++kTGWBwDv1DZs8xdg6yUAPvKRuAQ1d5qjYkirjd6Xtn9u8uv2Ev
	m3SwoXQN6vjUhX871OCvhRNenxEfl0Se60lBH4mXa9GdNn2b2HTiUrxk2yJuAuLS
X-Gm-Gg: AYBFou260kgqyiVQDCgk8InhiK8teWDUqX365hI7EegCBTCafJY97Nt3k2jGL9b87FC
	+UXFu7Nm4vzc82wmfWuvV1+9VZgCt5MESgrs/iAtkKkK7Q53Y8mC6dxnRGzSNV+F3ssYr3HOVfa
	9FkWAt+DIVaDWbWVkj83FSqH+PhNIxaqFj74w7S8xRxwJM2fWaWqX/SXYUNHWMFatpcgbJTBprW
	h83fnbybjq3ik05SVkBgNGptNMJbzAUsR1US3VUNYNqjECzf1wEPND6xA6m/BFPTHGVGFlRuBEo
	Pf5pEFJ/pqhQtlG0W9yM/xQ0b+mtA/QeT60yQ28zdAC7s8vOAi5zl8JYBOnvKDbK9whb3RtLN58
	tuVqYEkbY7VmBqrOjD/H8Etiqmx8G0DEkYZPcf97Upd1Ws+eNtKGm+ShF03Esmvz7nhE/Aa9MfP
	XI+3VJ5fi7KrKxHZ+hGvkLENvNMqCA+NSpCO6hFb78jo/X4uDrg0f2J0DWaZD3RFCAAy2sF7T1g
	Q==
X-Received: by 2002:a05:6808:178d:b0:4ef:e154:41fb with SMTP id 5614622812f47-4fc4249bb26mr6469548b6e.1.1791493648545;
        Thu, 08 Oct 2026 14:07:28 -0700 (PDT)
Received: from [127.0.0.1] ([40.80.213.169])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2a84a1482sm80866fac.6.2026.10.08.14.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 14:07:25 -0700 (PDT)
Message-Id: <pull.2224.v2.git.1791493644.gitgitgadget@gmail.com>
In-Reply-To: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 08 Oct 2026 21:07:22 +0000
Subject: [PATCH v2 0/2] blame: ignore revs in HEAD:.git-blame-ignore-revs by default
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Abhijeetsingh Meena <abhijeet040403@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Ravi Mistry <rmistry@google.com>

This series teaches git-blame(1) and git-annotate(1) to automatically use
the HEAD:.git-blame-ignore-revs blob by default if it exists, so local runs
match hosting platforms without requiring manual blame.ignoreRevsFile
configuration in every clone. This restarts the stalled attempt in PR
https://github.com/gitgitgadget/git/pull/1809
(https://lore.kernel.org/git/pull.1809.v2.git.1728707867.gitgitgadget@gmail.com/)
and addresses https://github.com/gitgitgadget/git/issues/1494.

Changes since v1:

 * Split the series into two commits.
 * Patch 1/2 hardens oidset_parse_file_carefully() in oidset.c and
   peel_to_commit_oid() in builtin/blame.c before exposing them to
   upstream-controlled content at a well-known path:
   * Reject lines containing embedded NUL bytes via memchr() so trailing
     bytes after a NUL cannot be silently ignored.
   * Pass OBJECT_INFO_LOOKUP_REPLACE | OBJECT_INFO_SKIP_FETCH_OBJECT |
     OBJECT_INFO_QUICK to odb_read_object_info_extended() and peel tags one
     layer per iteration so missing OIDs or tag targets do not trigger lazy
     promisor fetches or pack directory rescans in partial clones, and
     verify that each peeled target matches the tag's declared type.
 * Patch 2/2 reads the committed HEAD:.git-blame-ignore-revs blob (in both
   bare and non-bare repositories) instead of reading a file from the
   working tree, matching hosting platforms even when an untracked file is
   present or a tracked one has local modifications. The tree entry is
   checked with S_ISREG() so non-regular entries (such as committed
   symlinks) are skipped, parsed in memory via
   oidset_parse_buffer_carefully(), and bypassed without reading if cleared
   via blame.ignoreRevsFile="" or --no-ignore-revs-file.

Ravi Mistry (2):
  blame: harden ignore-revs parser and tag peeling
  blame: ignore revs in HEAD:.git-blame-ignore-revs

 Documentation/blame-options.adoc |   8 +-
 Documentation/config/blame.adoc  |   9 +-
 builtin/blame.c                  |  65 ++++++++-
 oidset.c                         |  81 ++++++++----
 oidset.h                         |   9 ++
 t/t8013-blame-ignore-revs.sh     | 220 +++++++++++++++++++++++++++++++
 6 files changed, 357 insertions(+), 35 deletions(-)


base-commit: fa7f9290efe2bd22dd736689597b474b93798e11
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2224%2Frmistry%2Fblame-default-ignore-revs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2224/rmistry/blame-default-ignore-revs-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2224

Range-diff vs v1:

 -:  ---------- > 1:  2e12486c0d blame: harden ignore-revs parser and tag peeling
 1:  22a100d00d ! 2:  35e303d65b blame: default to ignoring revisions in .git-blame-ignore-revs
     @@ Metadata
      Author: Ravi Mistry <rmistry@google.com>
      
       ## Commit message ##
     -    blame: default to ignoring revisions in .git-blame-ignore-revs
     +    blame: ignore revs in HEAD:.git-blame-ignore-revs
      
          git-blame(1) can ignore a list of commits specified via
          --ignore-revs-file or the blame.ignoreRevsFile configuration option.
     @@ Commit message
          git-annotate(1) runs do not, unless each user manually configures
          blame.ignoreRevsFile for every local checkout.
      
     -    Teach git-blame(1) and git-annotate(1) to automatically check for a
     -    regular .git-blame-ignore-revs file at the root of the working tree when
     -    operating in a non-bare repository.
     +    Teach git-blame(1) and git-annotate(1) to automatically add the
     +    HEAD:.git-blame-ignore-revs blob, if it exists, as the initial element
     +    in the list of ignore-revs files in both bare and non-bare
     +    repositories. Reading the committed blob from HEAD rather than the
     +    working tree ensures that local runs match hosting platforms even when
     +    an untracked .git-blame-ignore-revs file is present or a tracked one
     +    has uncommitted local changes.
      
     -    To ensure consistent precedence, security, and override semantics:
     -    - Loading the default file occurs before reading configuration and CLI
     -      options, preserving user and repository config overrides.
     -    - Path resolution is anchored to repo_get_work_tree() and verified via
     -      lstat() to ensure it is a regular file. Symbolic links, directories,
     -      FIFOs, and sockets are safely skipped, preventing local information
     -      disclosure and denial-of-service hangs.
     -    - In build_ignorelist(), ignore-rev files are parsed starting after the
     -      last empty string entry. This ensures setting blame.ignoreRevsFile to
     -      "" or passing --ignore-revs-file "" or --no-ignore-revs-file cleanly
     -      discards the default file without attempting to open or parse it,
     -      allowing users to bypass corrupted default files.
     -    - Duplicate parsing is prevented by tracking seen files in a strset.
     +    To ensure consistent precedence and override semantics:
     +    - The default HEAD:.git-blame-ignore-revs entry is added before reading
     +      configuration and CLI options, preserving user and repository config
     +      overrides.
     +    - In git_blame_config(), blame.ignoreRevsFile entries are appended via
     +      string_list_append() rather than inserted in sorted order via
     +      string_list_insert() so that configuration entries preserve their
     +      order relative to the initial default entry.
     +    - The HEAD:.git-blame-ignore-revs tree entry is resolved quietly via
     +      get_oid_with_context(). Its mode is checked with S_ISREG() before
     +      reading the object so that non-regular tree entries (such as a
     +      committed symbolic link whose blob stores a target path rather than
     +      revision IDs, a subdirectory, or a gitlink) are skipped instead of
     +      being read and rejected as malformed object names. The blob is parsed
     +      in memory via a new oidset_parse_buffer_carefully() helper in
     +      oidset.c that shares line parsing with oidset_parse_file_carefully().
     +    - In build_ignorelist(), ignore-revs entries are processed starting
     +      after the last empty string entry. This ensures setting
     +      blame.ignoreRevsFile to "" or passing --ignore-revs-file "" or
     +      --no-ignore-revs-file cleanly discards the default blob without
     +      attempting to read or parse it, allowing users to bypass a malformed
     +      default blob.
      
          Update documentation in blame-options.adoc and config/blame.adoc, and
     -    add comprehensive test coverage in t8013 for the default file lookup,
     -    subdirectory invocations, CLI and config overrides, symlink rejection,
     -    comments and whitespace handling, and bare repositories.
     +    add comprehensive test coverage in t8013 for the default blob lookup,
     +    subdirectory invocations, bare repositories, uncommitted and untracked
     +    working-tree files, CLI and config overrides, committed symlink
     +    entries, and comments and whitespace handling.
      
          Based-on-patch-by: Abhijeetsingh Meena <abhijeet040403@gmail.com>
          Helped-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     @@ Commit message
      
       ## Documentation/blame-options.adoc ##
      @@ Documentation/blame-options.adoc: take effect.
     + `--ignore-revs-file <file>`::
       	Ignore revisions listed in _<file>_, which must be in the same format as an
       	`fsck.skipList`.  This option may be repeated, and these files will be
     - 	processed after any files specified with the `blame.ignoreRevsFile` config
     +-	processed after any files specified with the `blame.ignoreRevsFile` config
      -	option.  An empty file name, `""`, will clear the list of revs from
      -	previously processed files.
     -+	option or the default `.git-blame-ignore-revs` file.  An empty file name,
     -+	`""`, will clear the list of revs from previously processed files.
     -+	`--no-ignore-revs-file` will clear all previously specified ignore revs
     -+	files, including the default `.git-blame-ignore-revs` file.
     ++	processed after the default `HEAD:.git-blame-ignore-revs` blob (if it
     ++	exists) and any files specified with the `blame.ignoreRevsFile` config
     ++	option.  An empty file name, `""`, or `--no-ignore-revs-file` will clear
     ++	the list of revs from previously processed files, including the default
     ++	`HEAD:.git-blame-ignore-revs` blob.
       
       `--color-lines`::
       	Color line annotations in the default format differently if they come from
     @@ Documentation/config/blame.adoc: blame.showRoot::
      -	`#` are ignored.  This option may be repeated multiple times.  Empty
      -	file names will reset the list of ignored revisions.  This option will
      -	be handled before the command line option `--ignore-revs-file`.
     -+	`#` are ignored.  If `.git-blame-ignore-revs` exists at the root of the
     -+	working tree in a non-bare repository, it is used by default.  This option
     -+	may be repeated multiple times; files specified here are processed after
     -+	the default file.  An empty file name will reset the list of ignored
     -+	revisions from previously processed files and disable the default file.
     -+	This option is handled before the command-line option `--ignore-revs-file`.
     ++	`#` are ignored.  If the `HEAD:.git-blame-ignore-revs` blob exists, it
     ++	is added as the initial element in the list of ignore-revs files.
     ++	Other files listed in the configuration are also used, but an empty
     ++	element makes all elements that appeared before in the list forgotten.
     ++	This option will be handled before the command line option
     ++	`--ignore-revs-file`.
       
       blame.markUnblamableLines::
       	Mark lines that were changed by an ignored revision that we could not
      
       ## builtin/blame.c ##
     -@@
     - #include "hex.h"
     - #include "commit.h"
     - #include "diff.h"
     -+#include "path.h"
     - #include "revision.h"
     - #include "quote.h"
     - #include "string-list.h"
     -+#include "strmap.h"
     - #include "mailmap.h"
     - #include "parse-options.h"
     - #include "prio-queue.h"
      @@ builtin/blame.c: static int git_blame_config(const char *var, const char *value,
     - 		ret = git_config_pathname(&str, var, value);
       		if (ret)
       			return ret;
     --		if (str)
     + 		if (str)
      -			string_list_insert(&ignore_revs_file_list, str);
     -+		if (str) {
     -+			if (!*str)
     -+				string_list_clear(&ignore_revs_file_list, 0);
     -+			else
     -+				string_list_append(&ignore_revs_file_list, str);
     -+		}
     ++			string_list_append(&ignore_revs_file_list, str);
       		free(str);
       		return 0;
       	}
     -@@ builtin/blame.c: static void build_ignorelist(struct blame_scoreboard *sb,
     +@@ builtin/blame.c: static int peel_to_commit_oid(struct object_id *oid_ret, void *cbdata)
     + 	}
     + }
     + 
     ++static void parse_default_ignore_revs_blob(struct blame_scoreboard *sb,
     ++					   const char *name)
     ++{
     ++	struct object_context oc;
     ++	struct object_id oid;
     ++	enum object_type type;
     ++	size_t size;
     ++	char *buf;
     ++
     ++	if (get_oid_with_context(the_repository, name, GET_OID_QUIETLY,
     ++				 &oid, &oc))
     ++		goto out;
     ++	if (!S_ISREG(oc.mode))
     ++		goto out;
     ++
     ++	buf = odb_read_object(the_repository->objects, &oid, &type, &size);
     ++	if (!buf)
     ++		goto out;
     ++	if (type == OBJ_BLOB)
     ++		oidset_parse_buffer_carefully(&sb->ignore_list, buf, size,
     ++					      the_repository->hash_algo,
     ++					      peel_to_commit_oid, sb);
     ++	free(buf);
     ++
     ++out:
     ++	object_context_release(&oc);
     ++}
     ++
     + static void build_ignorelist(struct blame_scoreboard *sb,
     + 			     struct string_list *ignore_revs_file_list,
     + 			     struct string_list *ignore_rev_list)
       {
       	struct string_list_item *i;
       	struct object_id oid;
     -+	struct strset seen_files = STRSET_INIT;
      +	size_t start_idx = 0, idx;
      +
      +	for (idx = 0; idx < ignore_revs_file_list->nr; idx++) {
     @@ builtin/blame.c: static void build_ignorelist(struct blame_scoreboard *sb,
      -	for_each_string_list_item(i, ignore_revs_file_list) {
      -		if (!strcmp(i->string, ""))
      -			oidset_clear(&sb->ignore_list);
     --		else
     --			oidset_parse_file_carefully(&sb->ignore_list, i->string,
      +	for (idx = start_idx; idx < ignore_revs_file_list->nr; idx++) {
     -+		const char *path = ignore_revs_file_list->items[idx].string;
     -+
     -+		if (strset_add(&seen_files, path))
     -+			oidset_parse_file_carefully(&sb->ignore_list, path,
     ++		i = &ignore_revs_file_list->items[idx];
     ++		if (i->util)
     ++			parse_default_ignore_revs_blob(sb, i->string);
     + 		else
     + 			oidset_parse_file_carefully(&sb->ignore_list, i->string,
       						    the_repository->hash_algo,
     - 						    peel_to_commit_oid, sb);
     - 	}
     -+	strset_clear(&seen_files);
     - 	for_each_string_list_item(i, ignore_rev_list) {
     - 		if (repo_get_oid_committish(the_repository, i->string, &oid) ||
     - 		    peel_to_commit_oid(&oid, sb))
      @@ builtin/blame.c: int cmd_blame(int argc,
       	const char *const *opt_usage = cmd_is_annotate ? annotate_opt_usage : blame_opt_usage;
       
       	setup_default_color_by_age();
     -+	{
     -+		const char *work_tree = repo_get_work_tree(the_repository);
     -+
     -+		if (work_tree) {
     -+			char *default_file = mkpathdup("%s/%s", work_tree,
     -+						       ".git-blame-ignore-revs");
     -+			struct stat st;
     -+
     -+			if (!lstat(default_file, &st) && S_ISREG(st.st_mode) &&
     -+			    !access(default_file, R_OK))
     -+				string_list_append(&ignore_revs_file_list, default_file);
     -+			free(default_file);
     -+		}
     -+	}
     ++	string_list_append(&ignore_revs_file_list,
     ++			   "HEAD:.git-blame-ignore-revs")->util = &sb;
       	repo_config(the_repository, git_blame_config, &output_option);
       	repo_init_revisions(the_repository, &revs, NULL);
       	revs.date_mode = blame_date_mode;
      
     + ## oidset.c ##
     +@@ oidset.c: void oidset_parse_file(struct oidset *set, const char *path,
     + 	oidset_parse_file_carefully(set, path, algop, NULL, NULL);
     + }
     + 
     ++static void parse_oidset_line(struct oidset *set, struct strbuf *sb,
     ++			      const struct git_hash_algo *algop,
     ++			      oidset_parse_tweak_fn fn, void *cbdata)
     ++{
     ++	const char *p;
     ++	const char *name;
     ++	struct object_id oid;
     ++
     ++	if (memchr(sb->buf, '\0', sb->len))
     ++		die("invalid object name: %s", sb->buf);
     ++
     ++	/*
     ++	 * Allow trailing comments, leading whitespace
     ++	 * (including before commits), and empty or whitespace
     ++	 * only lines.
     ++	 */
     ++	name = strchr(sb->buf, '#');
     ++	if (name)
     ++		strbuf_setlen(sb, name - sb->buf);
     ++	strbuf_trim(sb);
     ++	if (!sb->len)
     ++		return;
     ++
     ++	if (parse_oid_hex_algop(sb->buf, &oid, &p, algop) || *p != '\0')
     ++		die("invalid object name: %s", sb->buf);
     ++	if (fn && fn(&oid, cbdata))
     ++		return;
     ++	oidset_insert(set, &oid);
     ++}
     ++
     + void oidset_parse_file_carefully(struct oidset *set, const char *path,
     + 				 const struct git_hash_algo *algop,
     + 				 oidset_parse_tweak_fn fn, void *cbdata)
     + {
     + 	FILE *fp;
     + 	struct strbuf sb = STRBUF_INIT;
     +-	struct object_id oid;
     + 
     + 	fp = fopen(path, "r");
     + 	if (!fp)
     + 		die("could not open object name list: %s", path);
     +-	while (!strbuf_getline(&sb, fp)) {
     +-		const char *p;
     +-		const char *name;
     +-
     +-		if (memchr(sb.buf, '\0', sb.len))
     +-			die("invalid object name: %s", sb.buf);
     +-
     +-		/*
     +-		 * Allow trailing comments, leading whitespace
     +-		 * (including before commits), and empty or whitespace
     +-		 * only lines.
     +-		 */
     +-		name = strchr(sb.buf, '#');
     +-		if (name)
     +-			strbuf_setlen(&sb, name - sb.buf);
     +-		strbuf_trim(&sb);
     +-		if (!sb.len)
     +-			continue;
     +-
     +-		if (parse_oid_hex_algop(sb.buf, &oid, &p, algop) || *p != '\0')
     +-			die("invalid object name: %s", sb.buf);
     +-		if (fn && fn(&oid, cbdata))
     +-			continue;
     +-		oidset_insert(set, &oid);
     +-	}
     ++	while (!strbuf_getline(&sb, fp))
     ++		parse_oidset_line(set, &sb, algop, fn, cbdata);
     + 	if (ferror(fp))
     + 		die_errno("Could not read '%s'", path);
     + 	fclose(fp);
     + 	strbuf_release(&sb);
     + }
     ++
     ++void oidset_parse_buffer_carefully(struct oidset *set, const char *buf,
     ++				   size_t size,
     ++				   const struct git_hash_algo *algop,
     ++				   oidset_parse_tweak_fn fn, void *cbdata)
     ++{
     ++	struct strbuf sb = STRBUF_INIT;
     ++	const char *p = buf, *end;
     ++
     ++	if (!size)
     ++		return;
     ++	end = buf + size;
     ++
     ++	while (p < end) {
     ++		const char *nl = memchr(p, '\n', end - p);
     ++		size_t len = (nl ? nl : end) - p;
     ++
     ++		strbuf_reset(&sb);
     ++		if (len && p[len - 1] == '\r')
     ++			len--;
     ++		strbuf_add(&sb, p, len);
     ++		parse_oidset_line(set, &sb, algop, fn, cbdata);
     ++		p = nl ? nl + 1 : end;
     ++	}
     ++	strbuf_release(&sb);
     ++}
     +
     + ## oidset.h ##
     +@@ oidset.h: void oidset_parse_file_carefully(struct oidset *set, const char *path,
     + 				 const struct git_hash_algo *algop,
     + 				 oidset_parse_tweak_fn fn, void *cbdata);
     + 
     ++/*
     ++ * Similar to oidset_parse_file_carefully(), but parses lines from an
     ++ * in-memory buffer of 'size' bytes.
     ++ */
     ++void oidset_parse_buffer_carefully(struct oidset *set, const char *buf,
     ++				   size_t size,
     ++				   const struct git_hash_algo *algop,
     ++				   oidset_parse_tweak_fn fn, void *cbdata);
     ++
     + struct oidset_iter {
     + 	const kh_oid_set_t *set;
     + 	khiter_t iter;
     +
       ## t/t8013-blame-ignore-revs.sh ##
     -@@ t/t8013-blame-ignore-revs.sh: test_expect_success ignore_merge '
     +@@ t/t8013-blame-ignore-revs.sh: test_expect_success 'ignore-revs-file peels chained tags and skips missing tag t
       	test_cmp expect actual
       '
       
     -+# Tests for default .git-blame-ignore-revs file
     -+test_expect_success 'setup default .git-blame-ignore-revs' '
     ++# Tests for default HEAD:.git-blame-ignore-revs blob
     ++test_expect_success 'setup default HEAD:.git-blame-ignore-revs' '
      +	git checkout -b default-file-branch &&
      +	test_write_lines line1 line2 >def-file &&
      +	git add def-file &&
     @@ t/t8013-blame-ignore-revs.sh: test_expect_success ignore_merge '
      +	git commit -m "default mod" &&
      +	git tag DEF_B &&
      +
     -+	git rev-parse DEF_B >.git-blame-ignore-revs
     ++	git rev-parse DEF_B >.git-blame-ignore-revs &&
     ++	git add .git-blame-ignore-revs &&
     ++	test_tick &&
     ++	git commit -m "add .git-blame-ignore-revs"
      +'
      +
     -+test_expect_success 'default .git-blame-ignore-revs is used by default' '
     ++test_expect_success 'default HEAD:.git-blame-ignore-revs is used by default' '
      +	git blame --line-porcelain def-file >blame_raw &&
      +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
      +	git rev-parse DEF_A >expect &&
     @@ t/t8013-blame-ignore-revs.sh: test_expect_success ignore_merge '
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'default .git-blame-ignore-revs respected by git annotate' '
     ++test_expect_success 'default HEAD:.git-blame-ignore-revs respected by git annotate' '
      +	git rev-parse --short DEF_A >expect_sha &&
      +	git annotate def-file >actual &&
      +	test_grep "^$(cat expect_sha)" actual
      +'
      +
     -+test_expect_success 'default .git-blame-ignore-revs works from subdirectory' '
     ++test_expect_success 'default HEAD:.git-blame-ignore-revs works from subdirectory' '
      +	mkdir -p sub &&
      +	(
      +		cd sub &&
     @@ t/t8013-blame-ignore-revs.sh: test_expect_success ignore_merge '
      +	)
      +'
      +
     -+test_expect_success 'disable default .git-blame-ignore-revs with --no-ignore-revs-file' '
     ++test_expect_success 'default HEAD:.git-blame-ignore-revs respected in bare repo' '
     ++	test_when_finished "rm -rf bare.git" &&
     ++	git clone --bare . bare.git &&
     ++	git -C bare.git blame --line-porcelain def-file >blame_raw &&
     ++	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
     ++	git rev-parse DEF_A >expect &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'uncommitted .git-blame-ignore-revs changes in working tree are ignored' '
     ++	test_when_finished "git checkout -- .git-blame-ignore-revs" &&
     ++	echo "invalid-oid-value" >.git-blame-ignore-revs &&
     ++	git blame --line-porcelain def-file >blame_raw &&
     ++	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
     ++	git rev-parse DEF_A >expect &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'disable default HEAD:.git-blame-ignore-revs with --no-ignore-revs-file' '
      +	git blame --line-porcelain --no-ignore-revs-file def-file >blame_raw &&
      +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
      +	git rev-parse DEF_B >expect &&
     @@ t/t8013-blame-ignore-revs.sh: test_expect_success ignore_merge '
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'disable default .git-blame-ignore-revs with --ignore-revs-file ""' '
     ++test_expect_success 'disable default HEAD:.git-blame-ignore-revs with --ignore-revs-file ""' '
      +	git blame --line-porcelain --ignore-revs-file "" def-file >blame_raw &&
      +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
      +	git rev-parse DEF_B >expect &&
     @@ t/t8013-blame-ignore-revs.sh: test_expect_success ignore_merge '
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'disable default .git-blame-ignore-revs with blame.ignoreRevsFile=""' '
     ++test_expect_success 'disable default HEAD:.git-blame-ignore-revs with blame.ignoreRevsFile=""' '
      +	test_config blame.ignoreRevsFile "" &&
      +	git blame --line-porcelain def-file >blame_raw &&
      +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
     @@ t/t8013-blame-ignore-revs.sh: test_expect_success ignore_merge '
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'default .git-blame-ignore-revs handles comments and whitespace' '
     -+	test_when_finished "git rev-parse DEF_B >.git-blame-ignore-revs" &&
     ++test_expect_success 'default HEAD:.git-blame-ignore-revs handles comments and whitespace' '
     ++	rev_def_b=$(git rev-parse DEF_B) &&
      +	{
      +		echo "# Leading comment" &&
      +		echo "" &&
     -+		echo "   $(git rev-parse DEF_B)   " &&
     ++		echo "   $rev_def_b   # inline comment" &&
      +		echo "# Trailing comment"
      +	} >.git-blame-ignore-revs &&
     ++	git add .git-blame-ignore-revs &&
     ++	test_tick &&
     ++	git commit -m "comments and whitespace in .git-blame-ignore-revs" &&
      +	git blame --line-porcelain def-file >blame_raw &&
      +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
      +	git rev-parse DEF_A >expect &&
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'empty default .git-blame-ignore-revs is harmless' '
     -+	test_when_finished "git rev-parse DEF_B >.git-blame-ignore-revs" &&
     ++test_expect_success 'empty default HEAD:.git-blame-ignore-revs is harmless' '
      +	: >.git-blame-ignore-revs &&
     -+	git blame def-file
     ++	git add .git-blame-ignore-revs &&
     ++	test_tick &&
     ++	git commit -m "empty .git-blame-ignore-revs" &&
     ++	git blame --line-porcelain def-file >blame_raw &&
     ++	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
     ++	git rev-parse DEF_B >expect &&
     ++	test_cmp expect actual
      +'
      +
     -+test_expect_success SYMLINKS 'symlink .git-blame-ignore-revs is ignored' '
     -+	test_when_finished "rm -f target_file .git-blame-ignore-revs && git rev-parse DEF_B >.git-blame-ignore-revs" &&
     ++test_expect_success 'committed symlink .git-blame-ignore-revs in HEAD is ignored' '
     ++	git rm -f .git-blame-ignore-revs &&
      +	git rev-parse DEF_B >target_file &&
     -+	ln -sf target_file .git-blame-ignore-revs &&
     ++	test_ln_s_add target_file .git-blame-ignore-revs &&
     ++	test_tick &&
     ++	git commit -m "symlink .git-blame-ignore-revs" &&
      +	git blame --line-porcelain def-file >blame_raw &&
      +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
      +	git rev-parse DEF_B >expect &&
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'malformed default .git-blame-ignore-revs fails but can be bypassed' '
     -+	test_when_finished "git rev-parse DEF_B >.git-blame-ignore-revs" &&
     ++test_expect_success 'malformed default HEAD:.git-blame-ignore-revs fails but can be bypassed' '
     ++	git rm -f .git-blame-ignore-revs &&
      +	echo "invalid-oid-value" >.git-blame-ignore-revs &&
     ++	git add .git-blame-ignore-revs &&
     ++	test_tick &&
     ++	git commit -m "malformed .git-blame-ignore-revs" &&
      +	test_must_fail git blame def-file &&
      +	git blame --no-ignore-revs-file def-file &&
     -+	git blame --ignore-revs-file "" def-file
     -+'
     ++	git blame --ignore-revs-file "" def-file &&
     ++	git -c blame.ignoreRevsFile="" blame def-file &&
      +
     -+test_expect_success 'default .git-blame-ignore-revs deduplicated when also set in config' '
     -+	test_config blame.ignoreRevsFile .git-blame-ignore-revs &&
     -+	git blame --line-porcelain def-file >blame_raw &&
     -+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
     -+	git rev-parse DEF_A >expect &&
     -+	test_cmp expect actual
     ++	rev_def_b=$(git rev-parse DEF_B) &&
     ++	printf "%sQgarbage\n" "$rev_def_b" | q_to_nul >.git-blame-ignore-revs &&
     ++	git add .git-blame-ignore-revs &&
     ++	test_tick &&
     ++	git commit -m "NUL in .git-blame-ignore-revs" &&
     ++	test_must_fail git blame def-file 2>err &&
     ++	test_grep "invalid object name:" err
      +'
      +
     -+test_expect_success 'default .git-blame-ignore-revs combined with config blame.ignoreRevsFile' '
     ++test_expect_success 'default HEAD:.git-blame-ignore-revs combined with config blame.ignoreRevsFile' '
     ++	git rev-parse DEF_B >.git-blame-ignore-revs &&
      +	test_write_lines line1-modified line2-c >def-file &&
     -+	git add def-file &&
     ++	git add .git-blame-ignore-revs def-file &&
      +	test_tick &&
      +	git commit -m C &&
      +	git tag DEF_C &&
     @@ t/t8013-blame-ignore-revs.sh: test_expect_success ignore_merge '
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'default .git-blame-ignore-revs ignored in bare repo' '
     -+	git clone --bare . bare.git &&
     -+	git -C bare.git blame --line-porcelain def-file >blame_raw &&
     -+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
     -+	git rev-parse DEF_C >expect &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'blame works when .git-blame-ignore-revs does not exist' '
     -+	rm -f .git-blame-ignore-revs &&
     ++test_expect_success 'blame works when HEAD:.git-blame-ignore-revs does not exist and ignores untracked file' '
     ++	git rm -f .git-blame-ignore-revs &&
     ++	test_tick &&
     ++	git commit -m "remove .git-blame-ignore-revs" &&
     ++	git rev-parse DEF_B >.git-blame-ignore-revs &&
      +	git blame --line-porcelain def-file >blame_raw &&
      +	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
      +	git rev-parse DEF_B >expect &&

-- 
gitgitgadget
