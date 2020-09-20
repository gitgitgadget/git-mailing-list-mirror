Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07425C43466
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 11:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B72AB20EDD
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 11:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7R/veKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgITLWi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 07:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgITLWi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 07:22:38 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18839C061755
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 04:22:38 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k8so6544984pfk.2
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 04:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gNgDVYv0KH47zU5JEKCuZgEyc4Pv0cWyOUxHzWFphv8=;
        b=h7R/veKeZXLCEklsYPe7uhYHKLlD0uwH2CdIySb2CUHGqO1aBaJTEQnxKBsZELS5xw
         AjVUiuLp5Me8gAwB/9IZU4lhTYSH+y3nX/zRkKzXj9nI7VRU+MIkPn+bQ5qcsMtpw5EJ
         ep2NJESgg9rlkTyXYKmPGzrkW8KiNy2DikVe7sia9fvpuIj7mO4tCH9dVLZwF/LziSf2
         AIPKz/HnYb5AV4k1bKIzA4KYi6kmHdJd2MYI9b4NaweN/gUz0eV16AlTXfB5QqrsUskB
         oBasx7MxpPlARW6pC8/lhTcW4StlRjnnnKN36u1EZJQOygYJHfMzHJsr4/cDhE/Cras0
         LVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNgDVYv0KH47zU5JEKCuZgEyc4Pv0cWyOUxHzWFphv8=;
        b=g8I2+/DkChWhAqUcBWyYibms0tCrzEyOgQQYpKs3z6k3Cksq5bwEmb8yu6j8TdK4Pf
         jdli/EOc24c5pxMFD+x9zh03MBA21Xn4sjvffXm/zDH6OWhsszu5nl7yNrYYiLjPimhB
         K//GxbLRldY58z8pNo32AtRhBuMVp4um7mX/MpFisWTytka/+Rc+6z+nDLGwP2J1Dksg
         hwAdyXYHOlospWmCjLf679Tv7lVE6Z7SIT0Teq/NN9pioHGWDH1bUUJack1B+kH3IF0w
         g4wwGk5LYxuRA+55x3XakVwVIFZmVHDE9ltS5Du48YDkbm/h530H/lUoVrqZV4OJ6JkB
         I/xQ==
X-Gm-Message-State: AOAM5331oihThjE8NY13K+3g3QprPXgoq56mZ3AGhBE22lbneMxDyj1L
        08uzBq1qv8Kcj32/IeW/zaXuCQ9AM4c=
X-Google-Smtp-Source: ABdhPJzOIZ0VvDFHiMtTvLk/zv646cE6pmii8hLvqIxbA3zv7RUv6/iu72d6HjN4O3rCxIsgDA3KIQ==
X-Received: by 2002:a62:ed06:0:b029:142:2501:35de with SMTP id u6-20020a62ed060000b0290142250135demr24155750pfh.62.1600600956071;
        Sun, 20 Sep 2020 04:22:36 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id y79sm9550737pfb.45.2020.09.20.04.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 04:22:35 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 00/10] builtin/diff: learn --merge-base
Date:   Sun, 20 Sep 2020 04:22:17 -0700
Message-Id: <cover.1600600823.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.760.g8d73e04208
In-Reply-To: <cover.1600328335.git.liu.denton@gmail.com>
References: <cover.1600328335.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The range-notation in `git diff` has been cited as a mistake since diff
compares two endpoints, not whole ranges.[0]  In fact, the ranges seem
to take on the opposite meanings when compared to range notation in
`git log`.

In an effort to reduce the use of range notation as much as possible,
introduce the `--merge-base` flag, slightly modified from a suggestion
by Jonathan Nieder.[1] This flag allows us to replace the first commit
given on the command-line with its merge base between the first and
second commits.

One additional bonus is that this flag allows the "after" side to be not
just constrained to a commit (like with `...` notation). It can now be
the working tree or the index as well.

The `--merge-base` name isn't very satisfying. If anyone has any better
suggestions, please let me know.

Changes since v1:

* Implement Junio's documentation suggestions

* Update git diff's usage to include this option

Changes since v2:

* Teach diff-index and diff-tree the --merge-base option as well

Changes since v3:

* Don't use bitfields directly; extract them to an intermediate variable

* Use explicit literals in diff_get_merge_base() for clarity

* Fix xstrdup() leak

* I misunderstood and thought we wanted to deprecate `...` notation;
  this is not the case so remove all references to "gentle deprecation"
  and don't remove usage text that references it

[0]: https://lore.kernel.org/git/xmqqy2v26hu0.fsf@gitster-ct.c.googlers.com/
[1]: https://lore.kernel.org/git/20191223215928.GB38316@google.com/

Denton Liu (10):
  t4068: remove unnecessary >tmp
  git-diff-index.txt: make --cached description a proper sentence
  git-diff.txt: backtick quote command text
  contrib/completion: extract common diff/difftool options
  diff-lib: accept option flags in run_diff_index()
  diff-lib: define diff_get_merge_base()
  t4068: add --merge-base tests
  builtin/diff-index: learn --merge-base
  builtin/diff-tree: learn --merge-base
  contrib/completion: complete `git diff --merge-base`

 Documentation/git-diff-index.txt       |   9 +-
 Documentation/git-diff-tree.txt        |   7 +-
 Documentation/git-diff.txt             |  36 +++--
 builtin/diff-index.c                   |  10 +-
 builtin/diff-tree.c                    |  18 +++
 builtin/diff.c                         |  49 +++++--
 contrib/completion/git-completion.bash |  15 +-
 diff-lib.c                             |  63 +++++++-
 diff.h                                 |   7 +-
 t/t4068-diff-symmetric-merge-base.sh   | 193 +++++++++++++++++++++++++
 t/t4068-diff-symmetric.sh              |  91 ------------
 11 files changed, 358 insertions(+), 140 deletions(-)
 create mode 100755 t/t4068-diff-symmetric-merge-base.sh
 delete mode 100755 t/t4068-diff-symmetric.sh

Range-diff against v3:
 1:  80e9066a59 =  1:  80e9066a59 t4068: remove unnecessary >tmp
 2:  21b20281e6 =  2:  21b20281e6 git-diff-index.txt: make --cached description a proper sentence
 3:  ca9568c2ea =  3:  ca9568c2ea git-diff.txt: backtick quote command text
 4:  1ac8459541 =  4:  1ac8459541 contrib/completion: extract common diff/difftool options
 5:  496908ac10 !  5:  99d8b51585 diff-lib: accept option flags in run_diff_index()
    @@ diff-lib.c: static int diff_cache(struct rev_info *revs,
     +int run_diff_index(struct rev_info *revs, unsigned int option)
      {
      	struct object_array_entry *ent;
    ++	int cached = !!(option & DIFF_INDEX_CACHED);
      
    -@@ diff-lib.c: int run_diff_index(struct rev_info *revs, int cached)
    - 
    - 	trace_performance_enter();
    - 	ent = revs->pending.objects;
    --	if (diff_cache(revs, &ent->item->oid, ent->name, cached))
    -+	if (diff_cache(revs, &ent->item->oid, ent->name, !!(option & DIFF_INDEX_CACHED)))
    - 		exit(128);
    - 
    --	diff_set_mnemonic_prefix(&revs->diffopt, "c/", cached ? "i/" : "w/");
    -+	diff_set_mnemonic_prefix(&revs->diffopt, "c/", (option & DIFF_INDEX_CACHED) ? "i/" : "w/");
    - 	diffcore_fix_diff_index();
    - 	diffcore_std(&revs->diffopt);
    - 	diff_flush(&revs->diffopt);
    + 	if (revs->pending.nr != 1)
    + 		BUG("run_diff_index must be passed exactly one tree");
     
      ## diff.h ##
     @@ diff.h: const char *diff_aligned_abbrev(const struct object_id *sha1, int);
    @@ diff.h: const char *diff_aligned_abbrev(const struct object_id *sha1, int);
      #define DIFF_RACY_IS_MODIFIED 02
      int run_diff_files(struct rev_info *revs, unsigned int option);
     -int run_diff_index(struct rev_info *revs, int cached);
    ++
     +#define DIFF_INDEX_CACHED 01
     +int run_diff_index(struct rev_info *revs, unsigned int option);
      
 6:  6aac57ca02 !  6:  3287e649f1 diff-lib: define diff_get_merge_base()
    @@ diff-lib.c: static int diff_cache(struct rev_info *revs,
     +	 * ranges produce three pending commits, resulting in a
     +	 * misleading error message.
     +	 */
    -+	if (revs->pending.nr > ARRAY_SIZE(mb_child))
    -+		die(_("--merge-base does not work with more than two commits"));
    ++	if (revs->pending.nr < 1 || revs->pending.nr > 2)
    ++		BUG("unexpected revs->pending.nr: %d", revs->pending.nr);
     +
     +	for (i = 0; i < revs->pending.nr; i++)
     +		mb_child[i] = lookup_commit_reference(the_repository, &revs->pending.objects[i].item->oid);
    -+	if (revs->pending.nr < ARRAY_SIZE(mb_child)) {
    ++	if (revs->pending.nr == 1) {
     +		struct object_id oid;
     +
    -+		if (revs->pending.nr != 1)
    -+			BUG("unexpected revs->pending.nr: %d", revs->pending.nr);
    -+
     +		if (get_oid("HEAD", &oid))
     +			die(_("unable to get HEAD"));
     +
 7:  c9225a0440 =  7:  27930d4476 t4068: add --merge-base tests
 8:  1e4f805e57 !  8:  f54baa4ecd builtin/diff-index: learn --merge-base
    @@ builtin/diff.c: static int builtin_diff_index(struct rev_info *revs,
      		argv++; argc--;
     
      ## diff-lib.c ##
    -@@ diff-lib.c: void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb)
    - int run_diff_index(struct rev_info *revs, unsigned int option)
    +@@ diff-lib.c: int run_diff_index(struct rev_info *revs, unsigned int option)
      {
      	struct object_array_entry *ent;
    + 	int cached = !!(option & DIFF_INDEX_CACHED);
    ++	int merge_base = !!(option & DIFF_INDEX_MERGE_BASE);
     +	struct object_id oid;
     +	const char *name;
    ++	char merge_base_hex[GIT_MAX_HEXSZ + 1];
      
      	if (revs->pending.nr != 1)
      		BUG("run_diff_index must be passed exactly one tree");
      
      	trace_performance_enter();
      	ent = revs->pending.objects;
    --	if (diff_cache(revs, &ent->item->oid, ent->name, !!(option & DIFF_INDEX_CACHED)))
    +-	if (diff_cache(revs, &ent->item->oid, ent->name, cached))
     +
    -+	if (option & DIFF_INDEX_MERGE_BASE) {
    ++	if (merge_base) {
     +		diff_get_merge_base(revs, &oid);
    -+		name = xstrdup(oid_to_hex(&oid));
    ++		name = oid_to_hex_r(merge_base_hex, &oid);
     +	} else {
     +		oidcpy(&oid, &ent->item->oid);
     +		name = ent->name;
     +	}
     +
    -+	if (diff_cache(revs, &oid, name, !!(option & DIFF_INDEX_CACHED)))
    ++	if (diff_cache(revs, &oid, name, cached))
      		exit(128);
      
    - 	diff_set_mnemonic_prefix(&revs->diffopt, "c/", (option & DIFF_INDEX_CACHED) ? "i/" : "w/");
    + 	diff_set_mnemonic_prefix(&revs->diffopt, "c/", cached ? "i/" : "w/");
     
      ## diff.h ##
     @@ diff.h: void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb);
    - #define DIFF_RACY_IS_MODIFIED 02
      int run_diff_files(struct rev_info *revs, unsigned int option);
    + 
      #define DIFF_INDEX_CACHED 01
     +#define DIFF_INDEX_MERGE_BASE 02
      int run_diff_index(struct rev_info *revs, unsigned int option);
 9:  c0d27b125e !  9:  4880d21119 builtin/diff-tree: learn --merge-base
    @@ Metadata
      ## Commit message ##
         builtin/diff-tree: learn --merge-base
     
    -    In order to get the diff between a commit and its merge base, the
    -    currently preferred method is to use `git diff A...B`. However, the
    -    range-notation with diff has, time and time again, been noted as a point
    -    of confusion and thus, it should be avoided. Although we have a
    -    substitute for the double-dot notation, we don't have any replacement
    -    for the triple-dot notation.
    +    The previous commit introduced ---merge-base a way to take the diff
    +    between the working tree or index and the merge base between an arbitrary
    +    commit and HEAD. It makes sense to extend this option to support the
    +    case where two commits are given too and behave in a manner identical to
    +    `git diff A...B`.
     
    -    Introduce the --merge-base flag as a replacement for triple-dot
    +    Introduce the --merge-base flag as an alternative to triple-dot
         notation. Thus, we would be able to write the above as
    -    `git diff --merge-base A B`, allowing us to gently deprecate
    -    range-notation completely.
    +    `git diff --merge-base A B`.
     
      ## Documentation/git-diff-tree.txt ##
     @@ Documentation/git-diff-tree.txt: SYNOPSIS
    @@ Documentation/git-diff.txt: SYNOPSIS
      'git diff' [<options>] [<commit>] [--] [<path>...]
      'git diff' [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]
     -'git diff' [<options>] <commit> [<commit>...] <commit> [--] [<path>...]
    --'git diff' [<options>] <commit>...<commit> [--] [<path>...]
     +'git diff' [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]
    + 'git diff' [<options>] <commit>...<commit> [--] [<path>...]
      'git diff' [<options>] <blob> <blob>
      'git diff' [<options>] --no-index [--] <path> <path>
    - 
     @@ Documentation/git-diff.txt: of <commit> and HEAD.  `git diff --merge-base A` is equivalent to
      	branch name to compare with the tip of a different
      	branch.
    @@ builtin/diff.c
      "git diff [<options>] [<commit>] [--] [<path>...]\n"
      "   or: git diff [<options>] --cached [<commit>] [--] [<path>...]\n"
     -"   or: git diff [<options>] <commit> [<commit>...] <commit> [--] [<path>...]\n"
    --"   or: git diff [<options>] <commit>...<commit>] [--] [<path>...]\n"
     +"   or: git diff [<options>] <commit> [--merge-base] [<commit>...] <commit> [--] [<path>...]\n"
    + "   or: git diff [<options>] <commit>...<commit>] [--] [<path>...]\n"
      "   or: git diff [<options>] <blob> <blob>]\n"
      "   or: git diff [<options>] --no-index [--] <path> <path>]\n"
    - COMMON_DIFF_OPTIONS_HELP;
     @@ builtin/diff.c: static int builtin_diff_tree(struct rev_info *revs,
      			     struct object_array_entry *ent1)
      {
10:  42a8c9b665 = 10:  32e3e52b5f contrib/completion: complete `git diff --merge-base`
-- 
2.28.0.760.g8d73e04208

