Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3471833B6E1
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 23:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771458144; cv=none; b=lQ4aASBE+aRxyRhhd+BsAOCCle2fdvc37CvfGcBnJfoXmCRYD5xcrIkXKsqYtYmvrtP+kQtFJgOGGtZivagAYxJBBPCu99m7cXJxtCSXDdu/89dAcKDVD8qw8zCpOeM9c++EmIH5HdepbuQ4zM8iCRSy0iVQvpYXv0pyljEzPL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771458144; c=relaxed/simple;
	bh=5czYrJl+LMEMEayNWHcK40GoSOh2Mf3OeFLINqbWQII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCByxwDkoMYm/0ShFcgL6NHOBQRBqIG+Yvh4qU3F8Xc1wnktyZd1ElF0DWQHi4R0ihbXD1ZQN+EQaF5SnMDYoHP8zYuZwD/M/mSaFyCXzjteSargFE2bMuxYKep7aytO2eLRLPeDdFI3ImmA3vuTdg4kcHNwvPxouKgTfF0fmZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHPeBCo9; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHPeBCo9"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c6e23cb81f4so120811a12.2
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 15:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771458142; x=1772062942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YeEkNVawp9gCUPS0AqGH+wsrQlkb8+4uRQScQdiv10=;
        b=CHPeBCo9ckaPtp/67aA6Tow9T78f00B7aIHPEz9hl1agJ2VUOVec7GEelEy0ZWrHl7
         qvkC6RsGVY9E/A1O/csIcDjHGg+jA8E6UUcQFQU6KoRsNMlBIVihVlcul0SUKDc5BhKE
         0idcTUstTYCkf8BZT+7gV6S2VkXatdnB/E63tC6rw2Tjz1vG7wx4oLWWzgY7F8XYev+Z
         OmVZcVz2nv9zmjOqqBwdvr03MyUF4fD14sp0rmnTjYu/MSf3Uw1Uh6dWZcakIh3hZzwn
         xgG1mB7zBBh2RUCVDGOSu5o8VM7rgBG4KboqhMS/JDj57TbLi6w4gJ+l8op0sTxVLtQ1
         3dZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771458142; x=1772062942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/YeEkNVawp9gCUPS0AqGH+wsrQlkb8+4uRQScQdiv10=;
        b=IOPCC0FRP/khD6hfwifMtYvO5mAJG/hJ+drZ3tHs2gwPdZNRFqrrTMoGd3cZLlwKRw
         Mqeh2IXBJzLsGs0csFiQ6aTS4BMWI4A7hw6JBexpb01OlUq7KwOIGX3pKcaJDUaynjU6
         Y8Qu1g1q6uixX0gjroKjmZjY75uBG+ttpTOOto2xx4LB2RrNhL5ZXf7u8juIFS9dbO6I
         TonO32woxSq6yTSm3UT3+7VGEuT+73GsBRPlGA5jW2xz9nkIm2ZBYh5HoK4rmDLxUXXR
         XIZ5lPSZttjitK3xzX8TXtQO/Po09dv9W6pU1alV2aN0UWzDbKmhrGHXM6Jw++QulWtW
         YURg==
X-Gm-Message-State: AOJu0YzuKwvy5tjFSRn8m+LsNV24rx4Kl31p2Pquighg+ailmCDimzVh
	aU8fLgM22OYy3mfYz0gbyfAMmlA5KOFaUXA2/bvFpMmNtYrugj2XiB2IT8Xqkreb
X-Gm-Gg: AZuq6aLWLGbzfdvFRn3am5bGYAY5mX2x2ADt/5PeGqsevU094d1NbYM679ehgszhqip
	1TAtnwgXgOa9UqhIDeboKqXjOvTG/Pdf04HHO4phI5zNY9TeXYJ0otKb5pThPiynobHD/9uKaAB
	8uIMopfAnXC/luMHhtcjpC4rvu6JTY3gTypEBo1FFwsUEwDhwnI/sWcrdqydh8CUpU3XCDoCHOa
	yFRomyDzkOp4lNvkDKFSJuGW0aCh4nvj9wl8Sz7qKrCYWYkI348kVhTE1qt3V2UVxyOcYvVrvll
	3K2gPwd0F434OdZPxaU2mV1eh9YkRK/Xr8g4Tt8LosxLFxLUoxKTELaSRFCK642eMMnVxrgnNtJ
	Nkj0VTy16F4j49+xJRu0uEYz4ZArRFZaxI9zOms9YvC5ErHjSu6sAFcad0JamVCHTpEtNYHNFGo
	2mFKCn1xfkyOx2zb/KV/VVL6Bm/BZHqTgBSEDU2B8kfsLx1NKUkEFZ85pB
X-Received: by 2002:a17:903:320e:b0:2a9:5c0b:e5f4 with SMTP id d9443c01a7336-2ab505c0e87mr157476255ad.28.1771458142238;
        Wed, 18 Feb 2026 15:42:22 -0800 (PST)
Received: from localhost ([2409:40e3:308b:f961:2424:da5b:f01:e777])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1aaddc46sm144403295ad.73.2026.02.18.15.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 15:42:21 -0800 (PST)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	newren@gmail.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk,
	karthik.188@gmail.com,
	johannes.schindelin@gmx.de,
	toon@iotcl.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v3 0/2] replay: add --revert mode to reverse commit changes
Date: Thu, 19 Feb 2026 05:12:13 +0530
Message-ID: <20260218234215.89326-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251202201611.22137-1-siddharthasthana31@gmail.com>
References: <20251202201611.22137-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `git replay` command performs server-side history rewriting without
requiring a working tree. While it currently supports cherry-picking
commits (--advance) and rebasing (--onto), it lacks the ability to
revert them.

At GitLab, we use replay in Gitaly for efficient server-side operations
on bare repositories. Adding revert functionality enables us to reverse
problematic commits directly on the server, eliminating client-side
roundtrips and reducing network overhead.

The implementation follows the same approach as sequencer.c where
cherry-pick and revert are the same merge operation but with swapped
arguments. For cherry-pick we merge(ancestor=parent, ours=current,
theirs=commit), while for revert we merge(ancestor=commit, ours=current,
theirs=parent). By swapping the base and pickme trees when calling
merge_incore_nonrecursive(), we effectively reverse the diff direction.

The series is structured as follows:

Patch 1 extracts the revert message formatting logic into a shared
sequencer_format_revert_header() function, eliminating code duplication
between sequencer.c and the upcoming replay code. This follows Junio's
suggestion to split the changes.

Patch 2 adds the --revert <branch> mode to git replay. Following the
architectural pattern suggested by Elijah and Phillip, --revert is a
standalone mode (like --onto and --advance) that takes a branch argument
and updates that branch with the revert commits.

The series is based on top of 864f55e190 (The second batch, 2026-02-07).

CI: https://gitlab.com/gitlab-org/git/-/pipelines/2329880894
The Windows CI failures (t4041, t4059, t4060, t4205, t6006) are
pre-existing infrastructure issues (missing iconv, submodule pathspec
errors) unrelated to this series.

Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
Changes in v3:
- Rebased on top of the latest upstream which refactored replay into
  a library (replay.c / replay.h). The --revert logic now lives in
  replay.c alongside the existing pick logic, while builtin/replay.c
  is a thin CLI wrapper.
- sequencer_format_revert_header() now takes an optional oid parameter
  so it can handle the full commit reference internally, per Patrick's
  suggestion about refer_to_commit()
- Removed now-unused `orig_subject` variable in do_pick_commit()
- Switched to die_for_incompatible_opt3() for --onto/--advance/--revert
  mutual exclusivity, per Patrick
- --contained now just checks "die(_("--contained requires --onto"))"
  instead of going through die_for_incompatible_opt2, per Phillip
- Added BUG() guards for unhandled replay_mode values, per Patrick
- Merged the separate advance/revert ref update blocks into one
- author is set to NULL for revert commits so commit_tree_extended()
  picks up the current user, per Phillip
- Factored out common --advance/--revert branch validation into a
  set_up_branch_mode() helper, per Phillip
- Doc wording fixes: "reverted commits", "they are prefixed",
  "hash" instead of "SHA", per Phillip
- Tests now reuse topic4 instead of creating new branches, use heredoc
  for test_commit_message, and the reflog check is folded into the
  main revert test
- Added tests for bare repo revert, error cases (argument validation,
  multiple sources)
- Link to v2: https://public-inbox.org/git/20251202201611.22137-1-siddharthasthana31@gmail.com/t/#u
- Link to v1: https://public-inbox.org/git/20251125170056.34489-1-siddharthasthana31@gmail.com/t/#u

---
 Documentation/git-replay.adoc |  37 +++++++-
 builtin/replay.c              |  25 ++++--
 replay.c                      | 162 ++++++++++++++++++++++++----------
 replay.h                      |  11 ++-
 sequencer.c                   |  47 ++++++----
 sequencer.h                   |  11 +++
 t/t3650-replay-basics.sh      | 107 ++++++++++++++++++++--
 7 files changed, 319 insertions(+), 81 deletions(-)

Siddharth Asthana (2):
  sequencer: extract revert message formatting into shared function
  replay: add --revert mode to reverse commit changes

Range-diff versus v2:

1:  bfd75484b4 ! 1:  9d686bcdfe sequencer: extract revert message formatting into shared function
    @@ Commit message
         Extract this logic into a new sequencer_format_revert_header() function
         that can be shared. The function handles both regular reverts ("Revert
         "<subject>"") and revert-of-revert cases ("Reapply "<subject>"").
    +    When an oid is provided, the function appends the full commit hash and
    +    period; otherwise the caller should append the commit reference.
    +
         Update do_pick_commit() to use the new helper, eliminating code
         duplication while preserving the special handling for commit_use_reference.
     
         Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
     
      ## sequencer.c ##
    +@@ sequencer.c: static int do_pick_commit(struct repository *r,
    + 	 */
    + 
    + 	if (command == TODO_REVERT) {
    +-		const char *orig_subject;
    +-
    + 		base = commit;
    + 		base_label = msg.label;
    + 		next = parent;
     @@ sequencer.c: static int do_pick_commit(struct repository *r,
      		if (opts->commit_use_reference) {
      			strbuf_commented_addf(&ctx->message, comment_line_str,
     @@ sequencer.c: static int do_pick_commit(struct repository *r,
     -			strbuf_addstr(&ctx->message, "Revert \"");
     -			strbuf_addstr(&ctx->message, msg.subject);
     -			strbuf_addstr(&ctx->message, "\"\n");
    -+			sequencer_format_revert_header(&ctx->message, msg.subject);
    ++			sequencer_format_revert_header(&ctx->message, msg.subject, NULL);
      		}
     -		strbuf_addstr(&ctx->message, "\nThis reverts commit ");
      		refer_to_commit(opts, &ctx->message, commit);
    @@ sequencer.c: int sequencer_pick_revisions(struct repository *r,
      	return res;
      }
      
    -+void sequencer_format_revert_header(struct strbuf *out, const char *orig_subject)
    ++void sequencer_format_revert_header(struct strbuf *out,
    ++				    const char *orig_subject,
    ++				    const struct object_id *oid)
     +{
     +	const char *revert_subject;
     +
    @@ sequencer.c: int sequencer_pick_revisions(struct repository *r,
     +	}
     +
     +	strbuf_addstr(out, "\nThis reverts commit ");
    ++	if (oid) {
    ++		strbuf_addstr(out, oid_to_hex(oid));
    ++		strbuf_addstr(out, ".\n");
    ++	}
     +}
     +
      void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
    @@ sequencer.h: int sequencer_determine_whence(struct repository *r, enum commit_wh
      int sequencer_get_update_refs_state(const char *wt_dir, struct string_list *refs);
      
     +/*
    -+ * Formats a revert commit message header following standard Git conventions.
    ++ * Formats a revert commit message following standard Git conventions.
     + * Handles both regular reverts ("Revert \"<subject>\"") and revert of revert
    -+ * cases ("Reapply \"<subject>\""). Adds "This reverts commit " at the end.
    -+ * The caller should append the commit OID after calling this function.
    ++ * cases ("Reapply \"<subject>\""). Adds "This reverts commit <oid>." if oid
    ++ * is provided, otherwise just adds "This reverts commit " and the caller
    ++ * should append the commit reference.
     + */
    -+void sequencer_format_revert_header(struct strbuf *out, const char *orig_subject);
    ++void sequencer_format_revert_header(struct strbuf *out,
    ++				    const char *orig_subject,
    ++				    const struct object_id *oid);
     +
      #endif /* SEQUENCER_H */
2:  a2f99bc8c2 < -:  ---------- replay: add --revert mode to reverse commit changes
-:  ---------- > 2:  a8eae7b802 replay: add --revert mode to reverse commit changes


base-commit: 864f55e1906897b630333675a52874c0fec2a45c

Thanks
- Siddharth
