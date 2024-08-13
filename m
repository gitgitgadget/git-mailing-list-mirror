Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509A417F505
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541469; cv=none; b=exGF56CBSpqAZBci3R2bl5HvCQcWomsyGr84xZlxQDicrUf4Hko3RHov3aKw+Sgv/Fb63Xew3M2ZvWyBmUEoHAcNPS45z6bJmSw+NqpK4j+/tpcMiqOvIRfEJcW7AUXi+Ky8Thik0qt4fWTLe4iBAWZeGWWkovsGtLTJ4bIygVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541469; c=relaxed/simple;
	bh=wYhBB3KdO8P76c9K9f/wLa/oiJvSm0hV7PaDcbDudTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZ+xDKIjcY3JdOWMMauRLRKcte+zl7EvbWknfut0ODgcY5YP9/KiPAfu+nuJb1u7qXcHIEQkmOG35RqMYFNdmuS6XSWcSuRFnA6Rr4Oq8psoY+biSwEhxhPEdZot1rzd/7ZoMBC3o7ojaOjQX840HE3EA40HgQKck9PGLZKLGIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PwDa4Z9r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b8J8Euvu; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PwDa4Z9r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b8J8Euvu"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7A044114EA7D;
	Tue, 13 Aug 2024 05:31:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 13 Aug 2024 05:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541466; x=1723627866; bh=3+0xIf2Uci
	G8lhILif0htVMsMapvCyhs+MDjk57PER8=; b=PwDa4Z9rLP6d8Qj+NtORXz5UdZ
	S2AXSbWA1nNmp4ecQ0wEQbaG4cleFCHj7dmiOTzDJ/UYTYootg2UYRv5WH6OKhHL
	GON9yAGaUWJkkjEzdDXk8hKFg9GJ9XQNP5oDRCon5G7f+4pm4zordRZG+y19Irjr
	GO5Co72zgBLWM75homHiZ2WkJjcUKfZCk1GZawY3Tjfy3afw62riVnQrQ3M3te2r
	F5ZBZrAzOsrWQofjvofzA/9ww+ef6dliWI6bmCP8nUimGMLKa/qZP/R48UtSNVYa
	bxs077EhCax3B2VVXdRzywqRh91U3Q8nwKMkAVDD5X8nEJ3f/MzfWGT/khaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541466; x=1723627866; bh=3+0xIf2UciG8lhILif0htVMsMapv
	Cyhs+MDjk57PER8=; b=b8J8Euvu/ir1pAiegOy6H9XpHCxdudAcxO5fA/ZXhTgH
	LQrZ27R/6kBlT1diMtpnL0wm/hnbxhjUbz+jI+6sSCGoiV3X9IDfLMtENMdLJlhp
	yH/T0GD7ceR+ehq6gGpCCuLTENaIGHwYkGE49Z5j1MeoaFgAJ90oBhZpu0VsT3LN
	zdxD+322AahPyhgrSFblt4t7UF2Rq4uQia214tc8BtvQKrLwmZtnC1a67Ucsg0hi
	XzbSK/jZWoS1WFgm1mCEoHDuufDtR2Rf1puixs6VBEkIBSA7KRgWo6gk7zFTcL6l
	k6+dv3idUqz68Lm7AJC6beE9kJWS1fRNsnhwGYyP9w==
X-ME-Sender: <xms:2ie7ZlwGUTNXy9qUh3Gu4TFgt4HdsOmaPa4kMJAsUjPc3bQ4ZiGijA>
    <xme:2ie7ZlR5_JFigWBaQjCDbK3zcQSQa7jCMiPcVKiKbSI2KSByItzz_VlvwDC2RXhRL
    89zwsjDolElg37H2A>
X-ME-Received: <xmr:2ie7ZvV4UaZWrsUKY11jf-ejIS3ufyZfA43x68UgTRN-UqG12yHb6Fg_ntXGeCoWK90eMX2ClP0h8U8XaD8NsnkiAFxliBmCJsJYHt1QDG4h-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdr
    tghomhdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:2ie7ZngKHEDX-fqqBzqF_EHuuTJE4a8rchhxbAJlmaGwLTiuCulhtA>
    <xmx:2ie7ZnAJPHCtXTqZgUK4ulIJDrne3tWWHlFwvh6mNSqxsvs4lJs7Rw>
    <xmx:2ie7ZgJBMQ6Lwye7eXJWdMUXsttsAuWpaswNyFjzY7F-3MrvZRtTXg>
    <xmx:2ie7ZmAL1mf8c4q0pqTiQHWj2DL21gzyUk1s8p_xN-EWhtGIoTULVQ>
    <xmx:2ie7Zp26vLYzEp_Z2DeNmKwV_Wm_csyDEb1qe0hMIMmSMYz9ysqt6uoL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:31:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bf2778f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:30:47 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:31:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 00/22] Memory leak fixes (pt.4)
Message-ID: <cover.1723540931.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722933642.git.ps@pks.im>

Hi,

this is the third version of my fourth batch of patches that fix
various memory leaks.

Changes compared to v2:

  - Various typo fixes in commit messages.

  - Introduce `print_system_path()` as proposed by Taylor, which removes
    some of the repetition when printing system ptahs.

  - Micro-optimize one allocation for comment char strings away. Also,
    rename the variable to `comment_line_str_to_free` to better match
    how we call such variables in other places.

Thanks!

Patrick

Patrick Steinhardt (22):
  remote: plug memory leak when aliasing URLs
  git: fix leaking system paths
  object-file: fix memory leak when reading corrupted headers
  object-name: fix leaking symlink paths in object context
  bulk-checkin: fix leaking state TODO
  read-cache: fix leaking hashfile when writing index fails
  submodule-config: fix leaking name entry when traversing submodules
  config: fix leaking comment character config
  builtin/rebase: fix leaking `commit.gpgsign` value
  builtin/notes: fix leaking `struct notes_tree` when merging notes
  builtin/fast-import: plug trivial memory leaks
  builtin/fast-export: fix leaking diff options
  builtin/fast-export: plug leaking tag names
  merge-ort: unconditionally release attributes index
  sequencer: release todo list on error paths
  unpack-trees: clear index when not propagating it
  diff: fix leak when parsing invalid ignore regex option
  builtin/format-patch: fix various trivial memory leaks
  userdiff: fix leaking memory for configured diff drivers
  builtin/log: fix leak when showing converted blob contents
  diff: free state populated via options
  builtin/diff: free symmetric diff members

 builtin/commit.c                      |  7 +-
 builtin/diff.c                        | 10 ++-
 builtin/fast-export.c                 | 19 ++++--
 builtin/fast-import.c                 |  8 ++-
 builtin/log.c                         | 13 +++-
 builtin/notes.c                       |  9 ++-
 builtin/rebase.c                      |  1 +
 bulk-checkin.c                        |  2 +
 config.c                              |  3 +-
 csum-file.c                           |  2 +-
 csum-file.h                           | 10 +++
 diff.c                                | 16 ++++-
 environment.c                         |  1 +
 environment.h                         |  1 +
 git.c                                 | 13 +++-
 merge-ort.c                           |  3 +-
 object-file.c                         |  1 +
 object-name.c                         |  1 +
 range-diff.c                          |  6 +-
 read-cache.c                          | 97 ++++++++++++++++-----------
 remote.c                              |  2 +
 sequencer.c                           | 67 ++++++++++++------
 submodule-config.c                    | 18 +++--
 t/t0210-trace2-normal.sh              |  2 +-
 t/t1006-cat-file.sh                   |  1 +
 t/t1050-large.sh                      |  1 +
 t/t1450-fsck.sh                       |  1 +
 t/t1601-index-bogus.sh                |  2 +
 t/t2107-update-index-basic.sh         |  1 +
 t/t3310-notes-merge-manual-resolve.sh |  1 +
 t/t3311-notes-merge-fanout.sh         |  1 +
 t/t3404-rebase-interactive.sh         |  1 +
 t/t3435-rebase-gpg-sign.sh            |  1 +
 t/t3507-cherry-pick-conflict.sh       |  1 +
 t/t3510-cherry-pick-sequence.sh       |  1 +
 t/t3705-add-sparse-checkout.sh        |  1 +
 t/t4013-diff-various.sh               |  1 +
 t/t4014-format-patch.sh               |  1 +
 t/t4018-diff-funcname.sh              |  1 +
 t/t4030-diff-textconv.sh              |  2 +
 t/t4042-diff-textconv-caching.sh      |  2 +
 t/t4048-diff-combined-binary.sh       |  1 +
 t/t4064-diff-oidfind.sh               |  2 +
 t/t4065-diff-anchored.sh              |  1 +
 t/t4068-diff-symmetric-merge-base.sh  |  1 +
 t/t4069-remerge-diff.sh               |  1 +
 t/t4108-apply-threeway.sh             |  1 +
 t/t4209-log-pickaxe.sh                |  2 +
 t/t6421-merge-partial-clone.sh        |  1 +
 t/t6428-merge-conflicts-sparse.sh     |  1 +
 t/t7008-filter-branch-null-sha1.sh    |  1 +
 t/t7030-verify-tag.sh                 |  1 +
 t/t7817-grep-sparse-checkout.sh       |  1 +
 t/t9300-fast-import.sh                |  1 +
 t/t9304-fast-import-marks.sh          |  2 +
 t/t9351-fast-export-anonymize.sh      |  1 +
 unpack-trees.c                        |  2 +
 userdiff.c                            | 38 ++++++++---
 userdiff.h                            |  4 ++
 59 files changed, 288 insertions(+), 106 deletions(-)

Range-diff against v2:
 1:  2afa51f9ff !  1:  02f6da020f remote: plug memory leak when aliasing URLs
    @@ Commit message
         each of their URLs. The actual aliasing logic is then contained in
         `alias_url()`, which returns an allocated string that contains the new
         URL. This URL replaces the old URL that we have in the strvec that
    -    contanis all remote URLs.
    +    contains all remote URLs.
     
         We replace the remote URLs via `strvec_replace()`, which does not hand
         over ownership of the new string to the vector. Still, we didn't free
 2:  324140e4fd !  2:  f36d895948 git: fix leaking system paths
    @@ Commit message
         memory leaks looming exposed by that test suite and it thus does not yet
         pass with the memory leak checker enabled.
     
    +    Helped-by: Taylor Blau <me@ttaylorr.com>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## git.c ##
    +@@ git.c: void setup_auto_pager(const char *cmd, int def)
    + 	commit_pager_choice();
    + }
    + 
    ++static void print_system_path(const char *path)
    ++{
    ++	char *s_path = system_path(path);
    ++	puts(s_path);
    ++	free(s_path);
    ++}
    ++
    + static int handle_options(const char ***argv, int *argc, int *envchanged)
    + {
    + 	const char **orig_argv = *argv;
     @@ git.c: static int handle_options(const char ***argv, int *argc, int *envchanged)
      				exit(0);
      			}
      		} else if (!strcmp(cmd, "--html-path")) {
     -			puts(system_path(GIT_HTML_PATH));
    -+			char *path = system_path(GIT_HTML_PATH);
    -+			puts(path);
    -+			free(path);
    ++			print_system_path(GIT_HTML_PATH);
      			trace2_cmd_name("_query_");
      			exit(0);
      		} else if (!strcmp(cmd, "--man-path")) {
     -			puts(system_path(GIT_MAN_PATH));
    -+			char *path = system_path(GIT_MAN_PATH);
    -+			puts(path);
    -+			free(path);
    ++			print_system_path(GIT_MAN_PATH);
      			trace2_cmd_name("_query_");
      			exit(0);
      		} else if (!strcmp(cmd, "--info-path")) {
     -			puts(system_path(GIT_INFO_PATH));
    -+			char *path = system_path(GIT_INFO_PATH);
    -+			puts(path);
    -+			free(path);
    ++			print_system_path(GIT_INFO_PATH);
      			trace2_cmd_name("_query_");
      			exit(0);
      		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
 3:  43a38a2281 !  3:  0415ac986d object-file: fix memory leak when reading corrupted headers
    @@ Metadata
      ## Commit message ##
         object-file: fix memory leak when reading corrupted headers
     
    -    When reading corrupt object headers in `read_loose_object()`, then we
    -    bail out immediately. This causes a memory leak though because we would
    -    have already initialized the zstream in `unpack_loose_header()`, and it
    -    is the callers responsibility to finish the zstream even on error. While
    +    When reading corrupt object headers in `read_loose_object()`, we bail
    +    out immediately. This causes a memory leak though because we would have
    +    already initialized the zstream in `unpack_loose_header()`, and it is
    +    the callers responsibility to finish the zstream even on error. While
         this feels weird, other callsites do it correctly already.
     
         Fix this leak by ending the zstream even on errors. We may want to
 4:  9d3dc145e8 =  4:  e5130e50a9 object-name: fix leaking symlink paths in object context
 5:  454139e7a4 =  5:  276c828ad1 bulk-checkin: fix leaking state TODO
 6:  f8b7195796 =  6:  ed0608e705 read-cache: fix leaking hashfile when writing index fails
 7:  762fb5aa73 !  7:  b7a7f88c7d submodule-config: fix leaking name enrty when traversing submodules
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    submodule-config: fix leaking name enrty when traversing submodules
    +    submodule-config: fix leaking name entry when traversing submodules
     
         We traverse through submodules in the tree via `tree_entry()`, passing
         to it a `struct name_entry` that it is supposed to populate with the
 8:  8fbd72a100 !  8:  9054a459a1 config: fix leaking comment character config
    @@ Commit message
         value in the first place because it may contain a string constant.
     
         Refactor the code such that we track allocated comment character strings
    -    via a separate non-constant variable `comment_line_str_allocated`. Adapt
    +    via a separate non-constant variable `comment_line_str_to_free`. Adapt
         sites that set `comment_line_str` to set both and free the old value
    -    that was stored in `comment_line_str_allocated`.
    +    that was stored in `comment_line_str_to_free`.
     
         This memory leak is being hit in t3404. As there are still other memory
         leaks in that file we cannot yet mark it as passing with leak checking
    @@ builtin/commit.c: static void adjust_comment_line_char(const struct strbuf *sb)
      
      	if (!memchr(sb->buf, candidates[0], sb->len)) {
     -		comment_line_str = xstrfmt("%c", candidates[0]);
    -+		free(comment_line_str_allocated);
    -+		comment_line_str = comment_line_str_allocated =
    ++		free(comment_line_str_to_free);
    ++		comment_line_str = comment_line_str_to_free =
     +			xstrfmt("%c", candidates[0]);
      		return;
      	}
    @@ builtin/commit.c: static void adjust_comment_line_char(const struct strbuf *sb)
      		die(_("unable to select a comment character that is not used\n"
      		      "in the current commit message"));
     -	comment_line_str = xstrfmt("%c", *p);
    -+	free(comment_line_str_allocated);
    -+	comment_line_str = comment_line_str_allocated = xstrfmt("%c", *p);
    ++	free(comment_line_str_to_free);
    ++	comment_line_str = comment_line_str_to_free = xstrfmt("%c", *p);
      }
      
      static void prepare_amend_commit(struct commit *commit, struct strbuf *sb,
    @@ config.c: static int git_default_core_config(const char *var, const char *value,
      			if (strchr(value, '\n'))
      				return error(_("%s cannot contain newline"), var);
     -			comment_line_str = xstrdup(value);
    -+			free(comment_line_str_allocated);
    -+			comment_line_str = comment_line_str_allocated =
    -+				xstrdup(value);
    ++			comment_line_str = value;
    ++			FREE_AND_NULL(comment_line_str_to_free);
      			auto_comment_line_char = 0;
      		} else
      			return error(_("%s must have at least one character"), var);
    @@ environment.c: int protect_ntfs = PROTECT_NTFS_DEFAULT;
       * that is subject to stripspace.
       */
      const char *comment_line_str = "#";
    -+char *comment_line_str_allocated;
    ++char *comment_line_str_to_free;
      int auto_comment_line_char;
      
      /* Parallel index stat data preload? */
    @@ environment.h: struct strvec;
       * that is subject to stripspace.
       */
      extern const char *comment_line_str;
    -+extern char *comment_line_str_allocated;
    ++extern char *comment_line_str_to_free;
      extern int auto_comment_line_char;
      
      /*
 9:  e497b76e9c =  9:  1d3957a5eb builtin/rebase: fix leaking `commit.gpgsign` value
10:  c886b666f7 = 10:  0af1bab5a1 builtin/notes: fix leaking `struct notes_tree` when merging notes
11:  d1c757157b = 11:  30d4e9ed43 builtin/fast-import: plug trivial memory leaks
12:  fa2d5c5d6b ! 12:  9591fb7b5e builtin/fast-export: fix leaking diff options
    @@ Metadata
      ## Commit message ##
         builtin/fast-export: fix leaking diff options
     
    -    Before caling `handle_commit()` in a loop, we set `diffopt.no_free` such
    -    that its contents aren't getting freed inside of `handle_commit()`. We
    -    never unset that flag though, which means that it'll ultimately leak
    +    Before calling `handle_commit()` in a loop, we set `diffopt.no_free`
    +    such that its contents aren't getting freed inside of `handle_commit()`.
    +    We never unset that flag though, which means that it'll ultimately leak
         when calling `release_revisions()`.
     
         Fix this by unsetting the flag after the loop.
13:  d9dd860d2a = 13:  254bbb7f6f builtin/fast-export: plug leaking tag names
14:  8f6860485e = 14:  334c4ed71a merge-ort: unconditionally release attributes index
15:  ea6a350f31 = 15:  9f08a859fb sequencer: release todo list on error paths
16:  2755023742 = 16:  5d4934b1a9 unpack-trees: clear index when not propagating it
17:  edf6f148cd = 17:  e1b6a24fbe diff: fix leak when parsing invalid ignore regex option
18:  343e3bd4df = 18:  c048b54a2c builtin/format-patch: fix various trivial memory leaks
19:  be2c5b0bca = 19:  39b2921e3e userdiff: fix leaking memory for configured diff drivers
20:  7888203833 = 20:  50dea1c98a builtin/log: fix leak when showing converted blob contents
21:  245fc30afb = 21:  d5cb4ad580 diff: free state populated via options
22:  343ddcd17b ! 22:  31e38ba4e1 builtin/diff: free symmetric diff members
    @@ Commit message
     
         We populate a `struct symdiff` in case the user has requested a
         symmetric diff. Part of this is to populate a `skip` bitmap that
    -    indicates whihc commits shall be ignored in the diff. But while this
    +    indicates which commits shall be ignored in the diff. But while this
         bitmap is dynamically allocated, we never free it.
     
         Fix this by introducing and calling a new `symdiff_release()` function
-- 
2.46.0.46.g406f326d27.dirty

