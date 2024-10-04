Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A2014B061
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 23:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084145; cv=none; b=GR39Lo69+NcGiSxT5w8juV9V7eDjigqmkWr1V/BWEFt85By795gGdTYaVS2Aijak6hvOPQ1xhqBM0nJoq4cjbvqZ7Qst1qQONIX6lwkxG294GXGhfyHzap8idyUQboSFIKxXjb5yn+4DuHd3dg2IWqszc38H3Pob7D8lf2Ewoe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084145; c=relaxed/simple;
	bh=3alYQ5XxNJXnziRvAKXvpbJ8kpTCLg909f+8eg1N7b0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=jTbV32dNctl78DNoKFwa6WYZllF9PkTKLPMa+qIXMmcGIfmPujAWmwFyy41ap+zPwZvKTsXUm3RTvYHhe4+KKwUm5ZMAw/UOX1SjlJK3QDBN3lipu0UgLL92JRPbqDPVzdUJtAN90J1IrItNzk/WntG6pd7pBQrIjDw2ZbDjRHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSh7DhOQ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSh7DhOQ"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c42e7adbddso3057870a12.2
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 16:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728084142; x=1728688942; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6udl0Gedn2BjUkmXlfbyzMEYgVOthUFZ5NoBkYSLykE=;
        b=cSh7DhOQvM7ou6z8+YQHEgrZPsfS+gbegvq35GFaONLG9baHRCYETTXLAm8ttnujLf
         brdGXc3/bCGnO16gqpIb+ifmaaHU+hD6QyPxjiAk9Qtx+z3LJ8gTg3gZ0YqfhVR4sxWW
         oOxkI8vo1tzdK//PvGJXGRbTC1QRuMw2bFE8/D2yUu0Lm4NAn/pJo1UtbVJ3tu5/xK5p
         V3njpfA3wQ4r1aeBE/aA2DG97HwgxJubn8jFjLIVslmUXEWiBbdQ+1nkcQd6rBvEwGyO
         3lgJ+h7/WZHRmDsPIHhc0cZZN8KpTHlvsL7SJ0A9N2TVd2zrp5vqhEkOpMXXkMJbawcg
         Zv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728084142; x=1728688942;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6udl0Gedn2BjUkmXlfbyzMEYgVOthUFZ5NoBkYSLykE=;
        b=evPsvrWNkVxPeDTdkiEk+F3Jo4Xhwyh+Ptt8Fpuj/Yz5O3mjgRtODFNgYU+uMTbGmD
         5IEqeJzlTlyTx9rMpwvaYClDriswGXy6e6ZKDuLpSLbnHuHEKIuMpJyBISCdtxcAVUE5
         5nlBT4W00daeYSnmjWHPD1bMZ7EkFsnwW3Cpz6bX+jXpAXif8JS9XRwIJstqYeTAZB2l
         Lk7qZ8e8THmjip6unbWQNJGNDcCe+4vcuVdmqmwb4zmTFXnS33JOF5WKk2B5uZPvpGII
         +cF4P7GfG7JyC/nbbyYD0D3ol76Xg8/Yz34/9TVVQEaGsgS1y567WpqE30cK6KGhJs1L
         9j1w==
X-Gm-Message-State: AOJu0YxpvFmLFm8CPgmtMDcSB9Zi9CHp3DSj8s8AWycMdPym4CFeE2IU
	wyadlSqWQxuYzr9I3qcv4hShlnKdrfa1Dt8GDRbiaIsWtIC6J11KXHu/rQ==
X-Google-Smtp-Source: AGHT+IFwxVtxqh/YBJDpcRdTFo8HHpGcMeqw47nBCDJco4kS1I4s3mUXgBvHH8mXMij4HufUBNHcOA==
X-Received: by 2002:a17:907:961d:b0:a8d:3085:a7b1 with SMTP id a640c23a62f3a-a991bd989e0mr504646866b.38.1728084141727;
        Fri, 04 Oct 2024 16:22:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e78476csm52678666b.139.2024.10.04.16.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 16:22:21 -0700 (PDT)
Message-Id: <pull.1784.v2.git.git.1728084140.gitgitgadget@gmail.com>
In-Reply-To: <pull.1784.git.git.1726943880.gitgitgadget@gmail.com>
References: <pull.1784.git.git.1726943880.gitgitgadget@gmail.com>
From: "Nicolas Guichard via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 04 Oct 2024 23:22:17 +0000
Subject: [PATCH v2 0/3] rebase-merges: try and use branch names for labels
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Nicolas Guichard <nicolas@guichard.eu>

When interactively rebasing merge commits, the commit message is parsed to
extract a probably meaningful label name. For instance if the merge commit
is “Merge branch 'feature0'”, then the rebase script will have thes lines:

label feature0
merge -C $sha feature0 # “Merge branch 'feature0'


This heuristic fails in the case of octopus merges or when the merge commit
message is actually unrelated to the parent commits.

An example that combines both is:

*---.   967bfa4 (HEAD -> integration) Integration
|\ \ \
| | | * 2135be1 (feature2, feat2) Feature 2
| |_|/
|/| |
| | * c88b01a Feature 1
| |/
|/|
| * 75f3139 (feat0) Feature 0
|/
* `25c86d0` (main) Initial commit


which yields the labels Integration, Integration-2 and Integration-3.

Fix this by using a branch name for each merge commit's parent that is the
tip of at least one branch, and falling back to a label derived from the
merge commit message otherwise. In the example above, the labels become
feat0, Integration and feature2.

Changes since v1:

 * moved load_branch_decorations to re-use the decoration_loaded guard and
   avoid pointlessly appending "refs/heads/" to a static string_list, as
   pointed out by Junio C Hamano (thanks!)
 * fixed a leak in load_branch_decorations found by making the filter
   string_lists non-static

Nicolas Guichard (3):
  load_branch_decorations: fix memory leak with non-static filters
  rebase-update-refs: extract load_branch_decorations
  rebase-merges: try and use branch names as labels

 log-tree.c                    | 26 +++++++++++++++++++++++++
 log-tree.h                    |  1 +
 sequencer.c                   | 36 +++++++++++++++++------------------
 t/t3404-rebase-interactive.sh |  4 ++--
 t/t3430-rebase-merges.sh      | 12 ++++++------
 5 files changed, 53 insertions(+), 26 deletions(-)


base-commit: 8895aca99693e22ec4856744d5b2c25b8736a111
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1784%2Fnicolas-guichard%2Fuse-branch-names-for-rebase-merges-labels-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1784/nicolas-guichard/use-branch-names-for-rebase-merges-labels-v2
Pull-Request: https://github.com/git/git/pull/1784

Range-diff vs v1:

 -:  ----------- > 1:  6250a7f6d6c load_branch_decorations: fix memory leak with non-static filters
 1:  7f3d5e5da35 ! 2:  167418d10d1 sequencer.c: extract load_branch_decorations
     @@ Metadata
      Author: Nicolas Guichard <nicolas@guichard.eu>
      
       ## Commit message ##
     -    sequencer.c: extract load_branch_decorations
     +    rebase-update-refs: extract load_branch_decorations
      
          Extract load_branch_decorations from todo_list_add_update_ref_commands so
          it can be re-used in make_script_with_merges.
      
     +    Since it can now be called multiple times, use non-static lists and place
     +    it next to load_ref_decorations to re-use the decoration_loaded guard.
     +
          Signed-off-by: Nicolas Guichard <nicolas@guichard.eu>
      
     - ## sequencer.c ##
     -@@ sequencer.c: static const char *label_oid(struct object_id *oid, const char *label,
     - 	return string_entry->string;
     + ## log-tree.c ##
     +@@ log-tree.c: void load_ref_decorations(struct decoration_filter *filter, int flags)
     + 	}
       }
       
     -+static void load_branch_decorations(void)
     ++void load_branch_decorations(void)
      +{
     -+	static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
     -+	static struct string_list decorate_refs_exclude_config = STRING_LIST_INIT_NODUP;
     -+	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
     -+	struct decoration_filter decoration_filter = {
     -+		.include_ref_pattern = &decorate_refs_include,
     -+		.exclude_ref_pattern = &decorate_refs_exclude,
     -+		.exclude_ref_config_pattern = &decorate_refs_exclude_config,
     -+	};
     -+	string_list_append(&decorate_refs_include, "refs/heads/");
     -+	load_ref_decorations(&decoration_filter, 0);
     ++	if (!decoration_loaded) {
     ++		struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
     ++		struct string_list decorate_refs_exclude_config = STRING_LIST_INIT_NODUP;
     ++		struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
     ++		struct decoration_filter decoration_filter = {
     ++			.include_ref_pattern = &decorate_refs_include,
     ++			.exclude_ref_pattern = &decorate_refs_exclude,
     ++			.exclude_ref_config_pattern = &decorate_refs_exclude_config,
     ++		};
     ++
     ++		string_list_append(&decorate_refs_include, "refs/heads/");
     ++		load_ref_decorations(&decoration_filter, 0);
     ++
     ++		string_list_clear(&decorate_refs_exclude, false);
     ++		string_list_clear(&decorate_refs_exclude_config, false);
     ++		string_list_clear(&decorate_refs_include, false);
     ++	}
      +}
      +
     - static int make_script_with_merges(struct pretty_print_context *pp,
     - 				   struct rev_info *revs, struct strbuf *out,
     - 				   unsigned flags)
     + static void show_parents(struct commit *commit, int abbrev, FILE *file)
     + {
     + 	struct commit_list *p;
     +
     + ## log-tree.h ##
     +@@ log-tree.h: void log_write_email_headers(struct rev_info *opt, struct commit *commit,
     + 			     int *need_8bit_cte_p,
     + 			     int maybe_multipart);
     + void load_ref_decorations(struct decoration_filter *filter, int flags);
     ++void load_branch_decorations(void);
     + 
     + void fmt_output_commit(struct strbuf *, struct commit *, struct rev_info *);
     + void fmt_output_subject(struct strbuf *, const char *subject, struct rev_info *);
     +
     + ## sequencer.c ##
      @@ sequencer.c: static int add_decorations_to_list(const struct commit *commit,
       static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
       {
 2:  9afe428927d = 3:  dfa1f0a7648 rebase-merges: try and use branch names as labels

-- 
gitgitgadget
