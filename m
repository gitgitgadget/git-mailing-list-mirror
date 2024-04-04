Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10546130A7F
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255375; cv=none; b=uHcmICZiAsx/aVit+EhLN/0VniUWAtP4bGTCTZvcteGFY96plJ//wkZt0g9yQk9bJp+4m9wJf82hfrQE4Cqu/orP158igGKQ/GBJGa3V3e60ZLeBaLN5LDTUz/aypjDk5qDFR17HiUCWgR6jvY1c84Wc6rabTdGRMfcmJyerNjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255375; c=relaxed/simple;
	bh=JGqsUFE12FRAuaWh0fH5H4k0YMCieRrcwlWKjywL0Fc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=eo6BRveUXqR0i1CDNc+YDiv1ouk8By4Hnul92mOpzeuZOBiOYmGyS1eoJw7+WBg17gpFM5+6qzbUa1LpRZkR/g5urEk/Vawqc99BRkz9cFk80we1A0PrRZrT62rt6RNw47WbF+oMrIGk1Tgvz4V4AGJ8splI2nGvf3YjV3Mf0FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3Ukt49s; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3Ukt49s"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41627acfd03so8597575e9.3
        for <git@vger.kernel.org>; Thu, 04 Apr 2024 11:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712255371; x=1712860171; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4QYn9ufhin+sdpuOSjPdcc4JOidex9aa0STUNSDyLw=;
        b=j3Ukt49sjmthRxYA9zl9aiaZPpUb6NVs7yM6EDnEHZcUP/oYZ9PX6TtbPbOXwMn1Sj
         NZlTk5s+jO8TgfkLoMfiD/HTRkFUXO33DtYjliXF1SDd0y/U5fEH4nyi2iBPWzdTGKwh
         b6DZa2s1m4kpBtJ3d+XPhxDFOOeTL42OH1sZ8MKm/OkdGHayiMd2Xr5DB404ZqCNaMs4
         QgrOvyRdeHE972cFV916Ql5/7lYpdYbqfanxV2h5GVDW54p/BgcsaP+loKsq06PRMb6k
         g4ZcebxyU245gjlyBzJLb49d5PZFI63Uc9rt78f6Z9K1aGNhZTVOn1dbZc3WQ4iCF5+y
         J67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712255371; x=1712860171;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4QYn9ufhin+sdpuOSjPdcc4JOidex9aa0STUNSDyLw=;
        b=nzQPGCvjczmg0TIfV800VTiPFKKddSEZuOGOAMDhR1IULv0rKny045HPsI2DeLjc/e
         lL++49ByEN6mB/bGESdGi06Zv05mKbwCQqUx8aldtL97Uv3h3Y8ySoAYoDMbMb/MwFwo
         aAM6qfqt/Ic2m5S1nXzkedSP37x465YwB8+oRKpCekOvcDAFtMNTeD87ECcP9v+agCuD
         SAYnTNCaDmoX3keo8uo+Ujkj82y4aHub0Mi6pqTuglol37t3fZid6l4bzfsu3LE+rPbO
         3Fr4zr14Lnuucg+WyTWDzQcRTQdy4ZKoOJBprntjHYe4mODoreEcEoVpiZ09yiAYG4xN
         y0Mw==
X-Gm-Message-State: AOJu0Yy6CBfErqC8VP+ZySwL2FFU+94O2ZLa78GAFX70GWDwXkf/dOjL
	TRaKAe1qt4NfDj6+EnOFP2XFF1ZwsYkw9DOsbT5emnSubX3bvfh0BPJXEGdU
X-Google-Smtp-Source: AGHT+IFNrCpnbHHmE1EmSMrmmAYzr2196edSpaRkFZ8EHLlPoStBp+LktBkpeTZS6RbXKQ928SD30A==
X-Received: by 2002:a05:600c:68b:b0:416:2471:e102 with SMTP id a11-20020a05600c068b00b004162471e102mr2467648wmn.37.1712255371285;
        Thu, 04 Apr 2024 11:29:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c350700b004154399fbd9sm3602106wmq.45.2024.04.04.11.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 11:29:30 -0700 (PDT)
Message-Id: <pull.1683.v5.git.1712255369.gitgitgadget@gmail.com>
In-Reply-To: <pull.1683.v4.git.1712103636.gitgitgadget@gmail.com>
References: <pull.1683.v4.git.1712103636.gitgitgadget@gmail.com>
From: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Apr 2024 18:29:26 +0000
Subject: [PATCH v5 0/3] reftable/stack: use geometric table compaction
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Han-Wen Nienhuys <hanwenn@gmail.com>,
    Justin Tobler <jltobler@gmail.com>

Hello again,

This is the fifth version my patch series that refactors the reftable
compaction strategy to instead follow a geometric sequence. Changes compared
to v4:

 * To fix some failing tests and conflicts, this patch series now depends on
   the ps/pack-refs-auto series which is currently in next.
 * Lifted the GIT_TEST_REFTABLE_AUTOCOMPACTION env out of the reftable
   library and into the reftable backend code.

Thanks for taking a look!

-Justin

Justin Tobler (3):
  reftable/stack: allow disabling of auto-compaction
  reftable/stack: add env to disable autocompaction
  reftable/stack: use geometric table compaction

 refs/reftable-backend.c    |   4 ++
 reftable/reftable-writer.h |   3 +
 reftable/stack.c           | 125 +++++++++++++++++++------------------
 reftable/stack.h           |   4 --
 reftable/stack_test.c      |  77 ++++++-----------------
 t/t0610-reftable-basics.sh |  71 ++++++++++++++++-----
 6 files changed, 146 insertions(+), 138 deletions(-)


base-commit: 4b32163adf4863c6df3bb6b43540fa2ca3494e28
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1683%2Fjltobler%2Fjt%2Freftable-geometric-compaction-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1683/jltobler/jt/reftable-geometric-compaction-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1683

Range-diff vs v4:

 -:  ----------- > 1:  a7011dbc6aa reftable/stack: allow disabling of auto-compaction
 1:  2a0421e5f20 ! 2:  7c4fe0e9ec5 reftable/stack: add env to disable autocompaction
     @@ Commit message
      
          Signed-off-by: Justin Tobler <jltobler@gmail.com>
      
     - ## reftable/stack.c ##
     -@@ reftable/stack.c: int reftable_addition_commit(struct reftable_addition *add)
     - 	if (err)
     - 		goto done;
     - 
     --	if (!add->stack->disable_auto_compact)
     -+	if (!add->stack->disable_auto_compact &&
     -+	    git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1))
     - 		err = reftable_stack_auto_compact(add->stack);
     - 
     - done:
     -
     - ## reftable/system.h ##
     -@@ reftable/system.h: license that can be found in the LICENSE file or at
     - #include "tempfile.h"
     - #include "hash-ll.h" /* hash ID, sizes.*/
     - #include "dir.h" /* remove_dir_recursively, for tests.*/
     + ## refs/reftable-backend.c ##
     +@@
     + #include "../reftable/reftable-merged.h"
     + #include "../setup.h"
     + #include "../strmap.h"
      +#include "parse.h"
     + #include "refs-internal.h"
       
     - int hash_size(uint32_t id);
     + /*
     +@@ refs/reftable-backend.c: static struct ref_store *reftable_be_init(struct repository *repo,
     + 	refs->write_options.hash_id = repo->hash_algo->format_id;
     + 	refs->write_options.default_permissions = calc_shared_perm(0666 & ~mask);
       
     ++	if (!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1))
     ++		refs->write_options.disable_auto_compact = 1;
     ++
     + 	/*
     + 	 * Set up the main reftable stack that is hosted in GIT_COMMON_DIR.
     + 	 * This stack contains both the shared and the main worktree refs.
      
       ## t/t0610-reftable-basics.sh ##
      @@ t/t0610-reftable-basics.sh: test_expect_success 'ref transaction: writes cause auto-compaction' '
 2:  e0f4d0dbcc1 ! 3:  8f124acf0f8 reftable/stack: use geometric table compaction
     @@ reftable/stack_test.c: static void test_empty_add(void)
      +
       static void test_reftable_stack_auto_compaction(void)
       {
     - 	struct reftable_write_options cfg = { 0 };
     + 	struct reftable_write_options cfg = {
      @@ reftable/stack_test.c: static void test_reftable_stack_compaction_concurrent_clean(void)
       int stack_test_main(int argc, const char *argv[])
       {
     @@ t/t0610-reftable-basics.sh: test_expect_success 'ref transaction: writes are syn
       	EOF
       '
       
     +@@ t/t0610-reftable-basics.sh: test_expect_success 'ref transaction: fails gracefully when auto compaction fail
     + 			done ||
     + 			exit 1
     + 		done &&
     +-		test_line_count = 13 .git/reftable/tables.list
     ++		test_line_count = 10 .git/reftable/tables.list
     + 	)
     + '
     + 
      @@ t/t0610-reftable-basics.sh: test_expect_success 'pack-refs: compacts tables' '
       
       	test_commit -C repo A &&
     @@ t/t0610-reftable-basics.sh: test_expect_success 'pack-refs: compacts tables' '
       
       	git -C repo pack-refs &&
       	ls -1 repo/.git/reftable >table-files &&
     +@@ t/t0610-reftable-basics.sh: test_expect_success "$command: auto compaction" '
     + 		# The tables should have been auto-compacted, and thus auto
     + 		# compaction should not have to do anything.
     + 		ls -1 .git/reftable >tables-expect &&
     +-		test_line_count = 4 tables-expect &&
     ++		test_line_count = 3 tables-expect &&
     + 		git $command --auto &&
     + 		ls -1 .git/reftable >tables-actual &&
     + 		test_cmp tables-expect tables-actual &&
     +@@ t/t0610-reftable-basics.sh: test_expect_success "$command: auto compaction" '
     + 		git branch B &&
     + 		git branch C &&
     + 		rm .git/reftable/*.lock &&
     +-		test_line_count = 5 .git/reftable/tables.list &&
     ++		test_line_count = 4 .git/reftable/tables.list &&
     + 
     + 		git $command --auto &&
     + 		test_line_count = 1 .git/reftable/tables.list
      @@ t/t0610-reftable-basics.sh: do
       			umask $umask &&
       			git init --shared=true repo &&

-- 
gitgitgadget
