Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9BC2E339B
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758813043; cv=none; b=Y+UoAzfT0m4RL/e58CK0HusTcIcC1LBzNnxXcLtPofYUWWUAF80WpQ3Q47Kpw8S9DA8B+d4dzaFptfMFOI1bEfUg3WndwmxIm2T9rNtXFw8TXaEZQNuJRstU5xbYlGDeBLzZdwPFo588/icGOMSN+/k/CR70UNXNKgXqqwraM1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758813043; c=relaxed/simple;
	bh=lU1UTAs/66z5mVTiyDsCu9Q+e+W0ueCNzKGJdh+/N94=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=n9Ues5lOl1UEsXV6AasIYQcTG4JneO/D3R8rLZMcPO8Mf3pQVGk+YyRnorBMJHfAhIKITGIzx+RJrAw4WRSClusPVjOfrZyYnZ4UtEn4U51LQsO9Gpvcb+1Kg1CCg2GClTjyxSWre9EsYdwpI3UygdS/aCm6jCdoh7EzgdAe0Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXU1Y0Ym; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXU1Y0Ym"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-88703c873d5so48943539f.3
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 08:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758813040; x=1759417840; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjN0/4rgiwM+vBBPV67v6pCbPbp7D1nsAlajw0DN+n0=;
        b=WXU1Y0YmVcPm2WAj/bMTnwslN+8BF/3n4238TDfNybV9cBRWo25HzguleSIyPYO7qZ
         TzncaixC5KE6SnRD7/G3amo4i4eSMiVaodZ9o/rYQqfe3G7QG0bO0DWudhmtCcWS134V
         1GRx2BjkFKzSvl3HGErBrLSutaH7tRP1lru2uVkxj1A/sptcrILRxdLTMB8mgUB0W3EO
         5XFO88qGTeXgVwXCAP+nv48Yd/b+m3rpTDaNgIr2qENUctX+Pk6OyOxbLSMESvw5Jc2D
         X681Rjw19aTAPWSIGHmEw1+cH/tF9A2hGGtGLDO5gZ/HQXH4M3NRCbTmt/BXzzjYEOuD
         YP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758813040; x=1759417840;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjN0/4rgiwM+vBBPV67v6pCbPbp7D1nsAlajw0DN+n0=;
        b=UsB8d1yIh91K5dYhOpEHI6bhRUIu3tJGr2VQPT8tCeR2MTsEAi9Sr3xKBeWKi1YRTl
         pqao6LTkQzwzcUaQ1O/vjZciTzsmBvPitVyTbHgiZHtaEpcjyA+uAac504AQScRD2H/B
         /gDXMitl4j+IQh0jzI8+hoUPY/0XjuPsvPyD76s1LhJxTZ4FiQIBMEU8SWzJLOnf8smv
         9jgf2r3ToaSTNCHLSPyT1+BJCTmbaL1kt01KGut6R2OgM9K3IydDdOgEP2gQYd9EssHt
         Ac7VlP5OthMyslj7KBcggLiwQKVs4u5mHXKmW9KKnJLjUvNOT6m4XgchfwhUShJokTDp
         1u+A==
X-Gm-Message-State: AOJu0YyuJT0fvGQ2BYjGk6kEiNlXt0uBQH1pQil9z/SbCeEocUSYNLzG
	TSFfj8hZYBSnj16o/AtYlJL5Z5TrSG1IAT6iAZCaatdPbUGkjygUDQ8Z725Vkw==
X-Gm-Gg: ASbGncuICznWkoXkky/w6vp/bfyvIfAiFg9Gjky7ryDfGfF+YDDlAwmq3ytSR/Omjed
	7OvkJMTy/8Mu7w4uSeBiBkSSl1bZwwkuJ65DGOe2fmN4TmMP4rZINTdfvQx9PazxkycnA6cv7q1
	yCpMEeH+v24kP5QLpq//K+E/a90gINtPTCAtSTi5PAH9yYV9CAX5M9cCUIoVvZRa16xW/Ta57F0
	3LgXXGvA0tuCRQSNeY51KtHqbAuPA9bnwVD/u4NeUKPvvByElVrd4j4kKrKGzlBRkunts3C5d4y
	hELRseFsl47HzZ+eL+OrTPTFaRdLYGWH4Jp1SYkI6zVU6JYK5aCDJGDfIJKCXFJEybNVWVFQuD1
	LOarWuidaPXySLaezpTZ6oOr9PA==
X-Google-Smtp-Source: AGHT+IGbA17r5uKqqSU7LWXFeJigID/sE5O+woLE6AaHm9u0mcSJjFwWQfs7eBBY8pH+4Bq0wWFKZg==
X-Received: by 2002:a92:c9ca:0:b0:424:81fb:9248 with SMTP id e9e14a558f8ab-42595654e51mr45454455ab.30.1758813040126;
        Thu, 25 Sep 2025 08:10:40 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.124.180])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-425bff81253sm10573635ab.34.2025.09.25.08.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 08:10:39 -0700 (PDT)
Message-Id: <pull.1863.v3.git.1758813038.gitgitgadget@gmail.com>
In-Reply-To: <pull.1863.v2.git.1757950144.gitgitgadget@gmail.com>
References: <pull.1863.v2.git.1757950144.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 25 Sep 2025 15:10:36 +0000
Subject: [PATCH v3 0/2] add -p: a couple of hunk splitting fixes
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
Cc: Justin Tobler <jltobler@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

Thanks to Junio for his comments on V2. I have removed the dependency on
WITH_BREAKING_CHANGES in favor of "lets change it and see if anyone screams"

Changes since V2: Remove dependency on WITH_BREAKING_CHANGES and change the
behavior unconditionally. This takes us back to V1 with (hopefully) better
commit messages and a style fix in the tests.

V2 Cover Letter: Thanks to Justin and Junio for their comments in V1. Sorry
for the long delay in re-rolling - I thought I'd sent these ages ago and
then discovered that they weren't upstream and realized I had not, in fact,
sent them after-all.

Changes since V1:

 * Patch 1: The new hunks created by splitting a hunk are now only marked as
   "undecided" when WITH_BREAKING_CHANGES is enabled.

 * Patch 2: Reworded commit message and added a space before a redirection
   in the test

V1 Cover Letter:

This series fixes a couple of infelicities when splitting hunks that have
already been selected or edited which I noticed a while ago when preparing
the test for 'pw/add-patch-with-suppress-blank-empty'.

Phillip Wood (2):
  add -p: mark split hunks as undecided
  add-patch: update hunk splitability after editing

 add-patch.c                | 15 +++++++++++++--
 t/t3701-add-interactive.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 2 deletions(-)


base-commit: 4975ec3473b4bc61bc8a3df1ef29d0b7e7959e87
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1863%2Fphillipwood%2Fadd-p-split-hunks-are-undecided-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1863/phillipwood/add-p-split-hunks-are-undecided-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1863

Range-diff vs v2:

 1:  3e2ec7b37f ! 1:  4935dde399 add -p: mark split hunks as undecided
     @@ Commit message
          the split hunks they will now have to do more work re-selecting the
          remaining split hunks. However, changing the selection of any of the
          other newly created hunks is now much simpler as the user no-longer has
     -    to navigate back to them in order to change their selected state. Due
     -    to concerns that users may be relying on the current behaviour [1]
     -    this change is guarded by WITH_BREAKING_CHANGES.
     -
     -    [1] https://lore.kernel.org/git/xmqqjz9b6xr1.fsf@gitster.g
     +    to navigate back to them in order to change their selected state.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     - ## Documentation/BreakingChanges.adoc ##
     -@@ Documentation/BreakingChanges.adoc: A prerequisite for this change is that the ecosystem is ready to support the
     - "reftable" format. Most importantly, alternative implementations of Git like
     - JGit, libgit2 and Gitoxide need to support it.
     - 
     -+* The behavior of "git add -p" has been changed so that splitting a
     -+  hunk that has already been marked as selected or unselected will now
     -+  prompt the user to select each of the new hunks created by the
     -+  split instead of them inheriting their state from the original hunk.
     -+
     - === Removals
     - 
     - * Support for grafting commits has long been superseded by git-replace(1).
     -
       ## add-patch.c ##
      @@ add-patch.c: static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
       			* sizeof(*hunk));
       	hunk = file_diff->hunk + hunk_index;
       	hunk->splittable_into = 1;
     -+#ifdef WITH_BREAKING_CHANGES
      +	hunk->use = UNDECIDED_HUNK;
     -+#endif
       	memset(hunk + 1, 0, (splittable_into - 1) * sizeof(*hunk));
       
       	header = &hunk->header;
     @@ add-patch.c: next_hunk_line:
       
       		hunk++;
       		hunk->splittable_into = 1;
     -+#ifdef WITH_BREAKING_CHANGES
     +-		hunk->use = hunk[-1].use;
      +		hunk->use = UNDECIDED_HUNK;
     -+#else
     - 		hunk->use = hunk[-1].use;
     -+#endif
       		header = &hunk->header;
       
       		header->old_count = header->new_count = context_line_count;
     @@ t/t3701-add-interactive.sh: do
       	'
       done
       
     -+test_expect_success WITH_BREAKING_CHANGES 'splitting previous hunk marks split hunks as undecided' '
     ++test_expect_success 'splitting previous hunk marks split hunks as undecided' '
      +	test_write_lines a " " b c d e f g h i j k >file &&
      +	git add file &&
      +	test_write_lines x " " b y d e f g h i j x >file &&
 2:  3a831b1a2d ! 2:  390686dbb3 add-patch: update hunk splitability after editing
     @@ add-patch.c: static ssize_t recount_edited_hunk(struct add_p_state *s, struct hu
       
      
       ## t/t3701-add-interactive.sh ##
     -@@ t/t3701-add-interactive.sh: test_expect_success WITH_BREAKING_CHANGES 'splitting previous hunk marks split h
     +@@ t/t3701-add-interactive.sh: test_expect_success 'splitting previous hunk marks split hunks as undecided' '
       	test_cmp expect actual
       '
       
     @@ t/t3701-add-interactive.sh: test_expect_success WITH_BREAKING_CHANGES 'splitting
      +	test_write_lines A b c d E f g h i j k l M n >file &&
      +	(
      +		test_set_editor "$(pwd)/fake-editor.sh" &&
     -+		if test_have_prereq WITH_BREAKING_CHANGES
     -+		then
     -+			test_write_lines e K s j y n y q
     -+		else
     -+			test_write_lines e K s n K n y q
     -+		fi | git add -p file
     ++		test_write_lines e K s j y n y q | git add -p file
      +	) &&
      +	git cat-file blob :file >actual &&
      +	test_write_lines a b d e f g h i j k l M n >expect &&

-- 
gitgitgadget
