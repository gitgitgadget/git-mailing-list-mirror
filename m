Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B814C50275
	for <git@vger.kernel.org>; Mon, 20 May 2024 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208612; cv=none; b=GbGweKHS2jyK7xTZLK+Wa8Er2ojN1m1mgXIDx17k/NsDoCAi4kQxXv0AiOE5+00l9aRJXEXttdEXkfKvKeny+aGU/oeonmjHwE7uWFW0iW0sV7JcwLapjUgjYOFF1QgfBJzmY8rS0WjkQs8qOwKQ12wNwbX3U3kT7IzS24pVEow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208612; c=relaxed/simple;
	bh=XMITDlCHlVQ14MIbDV4uAtKCOe6+YrgnoxbyUfZ93ko=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=j+l3IY6RM1zsmb4QGtccWzoyI+LGIRzT71QIBnWhrcT/OBtaMwCJD3qGlwI9ybfib2/Xrjep3t2e7ijyEnl43eIiwr+b+vD3HQTWMhhJOYSCz+PdhowMd59t+Cgz8xJSz4Uem+3YocZFvcegf98KM6BUknt4EHOeBwEdcU5M424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2QjfpdS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2QjfpdS"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4200ee47de7so19362635e9.2
        for <git@vger.kernel.org>; Mon, 20 May 2024 05:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716208609; x=1716813409; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1qSNo4y3Hs/8MDAtledHuA/JWWs+Q+20cOQIVAq2e8=;
        b=l2QjfpdSb/fEb0vQJoxvLi2sIjcLYy31/uLFKx4huBzbXkAFx5q6WIhUKuQFiiu6KS
         B8WtBg3eqVfwmvYEecbq/cUI/MJ/tStVtRUScpeiJqnlWRLXMfqhEu4AfrG/NpjsrIp6
         0Iy2xlF65sfqfMIdRXRC5Xwb2ndXPb0/tySgvHVyW/MHRaIJTGJ0FZjZbv/yVT/Grb+n
         hQNbzwlahfynOJx9ie5kvAGrwDzP1R9lOVaDTAh7MSlcHPtSLPyi5XAyOARd91khUuWs
         kEL1h9X59bnd7NZxEssThX5s0p9FGbnhz31qdInWrAdzeTPdj3SPDkDwt60N59Dv8pgx
         p3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716208609; x=1716813409;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1qSNo4y3Hs/8MDAtledHuA/JWWs+Q+20cOQIVAq2e8=;
        b=fT+xAGE5UYiLWDSczEPmC3MYiBWi0UvqIc3iz81sXCiX8Na/L0NWhiwyZ9LSQy/DHC
         neO4/VXpR0pd+47w2afdhKoLX0K6BU5OYfuYTgpxbl+8YA5rja7OZJ0rDGlECxfQ32Kj
         v7LfK6JcTsKyu1f0aguyEc1V0kZFVNHyXSUjaxnFJKP/T+TYLXLBh+lM3YvYZg/DeK0G
         NjqhS4PI4zKvEoMYqdFBgtdKsSLC/c+brMQH5VNZzwsF9vpJFILzPzY4+FBMk4xNZnaq
         lZpJVAKtDyn+D7+BVqSwMuYeof1dVxcy7xEO6r13hs6pv41/sytgpDfhwESZss/YI7Gj
         EAEA==
X-Gm-Message-State: AOJu0YzZOYAVYADYEPfuM1/ks+1N9fKgIJYuw12pJGt5XfkmOrnkejaU
	Hh4FTyKBc11Q8cxigv/3Yn/8TeHoIsV43pgp/yNO8ooj8c2CY/U5zSOV4Q==
X-Google-Smtp-Source: AGHT+IF+MlQEQqmRF7Pia7lNwWwo5yKScrh+xxtQFE9RjWrU7Yasj4kTiXy1TASm4Hi4ShBRWM9IVg==
X-Received: by 2002:a05:600c:3b97:b0:418:5ed2:5aa6 with SMTP id 5b1f17b1804b1-41feac63341mr254306605e9.31.1716208608423;
        Mon, 20 May 2024 05:36:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce2580sm418010965e9.18.2024.05.20.05.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 05:36:47 -0700 (PDT)
Message-Id: <pull.1730.v2.git.1716208605926.gitgitgadget@gmail.com>
In-Reply-To: <pull.1730.git.1715742069966.gitgitgadget@gmail.com>
References: <pull.1730.git.1715742069966.gitgitgadget@gmail.com>
From: "blanet via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 May 2024 12:36:45 +0000
Subject: [PATCH v2] bundle-uri: verify oid before writing refs
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
Cc: blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

When using the bundle-uri mechanism with a bundle list containing
multiple interrelated bundles, we encountered a bug where tips from
downloaded bundles were not discovered, thus resulting in rather slow
clones. This was particularly problematic when employing the heuristic
`creationTokens`.

And this is easy to reproduce. Suppose we have a repository with a
single branch `main` pointing to commit `A`, firstly we create a base
bundle with

  git bundle create base.bundle main

Then let's add a new commit `B` on top of `A`, so that an incremental
bundle for `main` can be created with

  git bundle create incr.bundle A..main

Now we can generate a bundle list with the following content:

  [bundle]
      version = 1
      mode = all
      heuristic = creationToken

  [bundle "base"]
      uri = base.bundle
      creationToken = 1

  [bundle "incr"]
      uri = incr.bundle
      creationToken = 2

A fresh clone with the bundle list above would give the expected
`refs/bundles/main` pointing at `B` in new repository, in other words we
already had everything locally from the bundles, but git would still
download everything from server as if we got nothing.

So why the `refs/bundles/main` is not discovered? After some digging I
found that:

1. Bundles in bundle list are downloaded to local files via
   `download_bundle_list` or via `fetch_bundles_by_token` for the
   creationToken heuristic case.
2. Then it tries to unbundle each bundle via `unbundle_from_file`, which
   is called by `unbundle_all_bundles` or called within
   `fetch_bundles_by_token` for the creationToken heuristic case.
3. Here, we first read the bundle header to get all the prerequisites
   for the bundle, this is done in `read_bundle_header`.
4. Then we call `unbundle`, which calls `verify_bundle` to ensure that
   the repository does indeed contain the prerequisites mentioned in the
   bundle.
5. The `verify_bundle` will call `parse_object`, within which the
   `prepare_packed_git` or `reprepare_packed_git` is eventually called,
   which means that the `raw_object_store->packed_git` data gets filled
   in and ``packed_git_initialized` is set. This also means consecutive
   calls to `prepare_packed_git` doesn't re-initiate
   `raw_object_store->packed_git` since `packed_git_initialized` already
   is set.
6. If `unbundle` succeeds, it writes some refs via `refs_update_ref`
   with `REF_SKIP_OID_VERIFICATION` set. So the bundle refs which can
   target arbitrary objects are written to the repository.
7. Finally in `do_fetch_pack_v2`, `mark_complete_and_common_ref` and
   `mark_tips` are called with `OBJECT_INFO_QUICK` set to find local
   tips. Here it won't call `reprepare_packed_git` anymore so it would
   fail to parse oids that only reside in the last bundle.

Back to the example above, when unbunding `incr.bundle`, `base.pack` is
enlisted to `packed_git` bacause of the prerequisites to verify. While
we can not find `B` for negotiation at a latter time because `B` exists
in `incr.pack` which is not enlisted in `packed_git`.

This commit fixes this bug by dropping the `REF_SKIP_OID_VERIFICATION`
flag when writing bundle refs, so we can:

1. Ensure that the bundle refs we are writing are pointing to valid
   objects.
2. Ensure all the tips from bundle refs can be correctly parsed.

And a set of negotiation related tests for bundle-uri are added.

Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
    bundle-uri: refresh packed_git if unbundle succeed
    
    cc: Patrick Steinhardt ps@pks.im cc: Karthik Nayak karthik.188@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1730%2Fblanet%2Fxx%2Fbundle-uri-bug-using-bundle-list-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1730/blanet/xx/bundle-uri-bug-using-bundle-list-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1730

Range-diff vs v1:

 1:  d4841eea556 ! 1:  8bdeacf1360 bundle-uri: refresh packed_git if unbundle succeed
     @@ Metadata
      Author: Xing Xin <xingxin.xx@bytedance.com>
      
       ## Commit message ##
     -    bundle-uri: refresh packed_git if unbundle succeed
     +    bundle-uri: verify oid before writing refs
      
          When using the bundle-uri mechanism with a bundle list containing
          multiple interrelated bundles, we encountered a bug where tips from
     -    downloaded bundles were not being discovered, resulting in rather slow
     +    downloaded bundles were not discovered, thus resulting in rather slow
          clones. This was particularly problematic when employing the heuristic
          `creationTokens`.
      
     @@ Commit message
          So why the `refs/bundles/main` is not discovered? After some digging I
          found that:
      
     -    1. when unbundling a downloaded bundle, a `verify_bundle` is called to
     -       check its prerequisites if any. The verify procedure would find oids
     -       so `packed_git` is initialized.
     -
     -    2. after unbundled all bundles, we would enter `do_fetch_pack_v2`,
     -       during which `mark_complete_and_common_ref` and `mark_tips` would
     -       find oids with `OBJECT_INFO_QUICK` flag set, so no new packs would be
     -       enlisted if `packed_git` has already initialized in 1.
     +    1. Bundles in bundle list are downloaded to local files via
     +       `download_bundle_list` or via `fetch_bundles_by_token` for the
     +       creationToken heuristic case.
     +    2. Then it tries to unbundle each bundle via `unbundle_from_file`, which
     +       is called by `unbundle_all_bundles` or called within
     +       `fetch_bundles_by_token` for the creationToken heuristic case.
     +    3. Here, we first read the bundle header to get all the prerequisites
     +       for the bundle, this is done in `read_bundle_header`.
     +    4. Then we call `unbundle`, which calls `verify_bundle` to ensure that
     +       the repository does indeed contain the prerequisites mentioned in the
     +       bundle.
     +    5. The `verify_bundle` will call `parse_object`, within which the
     +       `prepare_packed_git` or `reprepare_packed_git` is eventually called,
     +       which means that the `raw_object_store->packed_git` data gets filled
     +       in and ``packed_git_initialized` is set. This also means consecutive
     +       calls to `prepare_packed_git` doesn't re-initiate
     +       `raw_object_store->packed_git` since `packed_git_initialized` already
     +       is set.
     +    6. If `unbundle` succeeds, it writes some refs via `refs_update_ref`
     +       with `REF_SKIP_OID_VERIFICATION` set. So the bundle refs which can
     +       target arbitrary objects are written to the repository.
     +    7. Finally in `do_fetch_pack_v2`, `mark_complete_and_common_ref` and
     +       `mark_tips` are called with `OBJECT_INFO_QUICK` set to find local
     +       tips. Here it won't call `reprepare_packed_git` anymore so it would
     +       fail to parse oids that only reside in the last bundle.
      
          Back to the example above, when unbunding `incr.bundle`, `base.pack` is
     -    enlisted to `packed_git` bacause of the prerequisites to verify. Then we
     -    can not find `B` for negotiation at a latter time bacause `B` exists in
     -    `incr.pack` which is not enlisted in `packed_git`.
     +    enlisted to `packed_git` bacause of the prerequisites to verify. While
     +    we can not find `B` for negotiation at a latter time because `B` exists
     +    in `incr.pack` which is not enlisted in `packed_git`.
     +
     +    This commit fixes this bug by dropping the `REF_SKIP_OID_VERIFICATION`
     +    flag when writing bundle refs, so we can:
      
     -    This commit fixes this by adding a `reprepare_packed_git` call for every
     -    successfully unbundled bundle, which ensures to enlist all generated
     -    packs from bundle uri. And a set of negotiation related tests are added.
     +    1. Ensure that the bundle refs we are writing are pointing to valid
     +       objects.
     +    2. Ensure all the tips from bundle refs can be correctly parsed.
     +
     +    And a set of negotiation related tests for bundle-uri are added.
      
          Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
      
       ## bundle-uri.c ##
     -@@
     - #include "refs.h"
     - #include "run-command.h"
     - #include "hashmap.h"
     -+#include "packfile.h"
     - #include "pkt-line.h"
     - #include "config.h"
     - #include "remote.h"
      @@ bundle-uri.c: static int unbundle_from_file(struct repository *r, const char *file)
     - 			       VERIFY_BUNDLE_QUIET)))
     - 		return 1;
     + 		refs_update_ref(get_main_ref_store(the_repository),
     + 				"fetched bundle", bundle_ref.buf, oid,
     + 				has_old ? &old_oid : NULL,
     +-				REF_SKIP_OID_VERIFICATION,
     +-				UPDATE_REFS_MSG_ON_ERR);
     ++				0, UPDATE_REFS_MSG_ON_ERR);
     + 	}
       
     -+	reprepare_packed_git(r);
     -+
     - 	/*
     - 	 * Convert all refs/heads/ from the bundle into refs/bundles/
     - 	 * in the local repository.
     + 	bundle_header_release(&header);
      
       ## t/t5558-clone-bundle-uri.sh ##
      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'fail to clone from non-bundle file' '


 bundle-uri.c                |   3 +-
 t/t5558-clone-bundle-uri.sh | 129 ++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 91b3319a5c1..65666a11d9c 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -400,8 +400,7 @@ static int unbundle_from_file(struct repository *r, const char *file)
 		refs_update_ref(get_main_ref_store(the_repository),
 				"fetched bundle", bundle_ref.buf, oid,
 				has_old ? &old_oid : NULL,
-				REF_SKIP_OID_VERIFICATION,
-				UPDATE_REFS_MSG_ON_ERR);
+				0, UPDATE_REFS_MSG_ON_ERR);
 	}
 
 	bundle_header_release(&header);
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 1ca5f745e73..a5b04d6f187 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -20,7 +20,10 @@ test_expect_success 'fail to clone from non-bundle file' '
 test_expect_success 'create bundle' '
 	git init clone-from &&
 	git -C clone-from checkout -b topic &&
+
 	test_commit -C clone-from A &&
+	git -C clone-from bundle create A.bundle topic &&
+
 	test_commit -C clone-from B &&
 	git -C clone-from bundle create B.bundle topic
 '
@@ -259,6 +262,132 @@ test_expect_success 'clone bundle list (file, any mode, all failures)' '
 	! grep "refs/bundles/" refs
 '
 
+#########################################################################
+# Clone negotiation related tests begin here
+
+test_expect_success 'negotiation: bundle with part of wanted commits' '
+	test_when_finished rm -rf trace*.txt &&
+	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
+	git clone --no-local --bundle-uri="clone-from/A.bundle" \
+		clone-from nego-bundle-part &&
+	git -C nego-bundle-part for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/topic
+	EOF
+	test_cmp expect actual &&
+	# Ensure that refs/bundles/topic are sent as "have".
+	grep "clone> have $(git -C clone-from rev-parse A)" trace-packet.txt
+'
+
+test_expect_success 'negotiation: bundle with all wanted commits' '
+	test_when_finished rm -rf trace*.txt &&
+	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
+	git clone --no-local --single-branch --branch=topic --no-tags \
+		--bundle-uri="clone-from/B.bundle" \
+		clone-from nego-bundle-all &&
+	git -C nego-bundle-all for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/topic
+	EOF
+	test_cmp expect actual &&
+	# We already have all needed commits so no "want" needed.
+	! grep "clone> want " trace-packet.txt
+'
+
+test_expect_success 'negotiation: bundle list (no heuristic)' '
+	test_when_finished rm -f trace*.txt &&
+	cat >bundle-list <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+
+	[bundle "bundle-1"]
+		uri = file://$(pwd)/clone-from/bundle-1.bundle
+
+	[bundle "bundle-2"]
+		uri = file://$(pwd)/clone-from/bundle-2.bundle
+	EOF
+
+	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
+	git clone --no-local --bundle-uri="file://$(pwd)/bundle-list" \
+		clone-from nego-bundle-list-no-heuristic &&
+
+	git -C nego-bundle-list-no-heuristic for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/base
+	refs/bundles/left
+	EOF
+	test_cmp expect actual &&
+	grep "clone> have $(git -C nego-bundle-list-no-heuristic rev-parse refs/bundles/left)" trace-packet.txt
+'
+
+test_expect_success 'negotiation: bundle list (creationToken)' '
+	test_when_finished rm -f trace*.txt &&
+	cat >bundle-list <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+		heuristic = creationToken
+
+	[bundle "bundle-1"]
+		uri = file://$(pwd)/clone-from/bundle-1.bundle
+		creationToken = 1
+
+	[bundle "bundle-2"]
+		uri = file://$(pwd)/clone-from/bundle-2.bundle
+		creationToken = 2
+	EOF
+
+	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
+	git clone --no-local --bundle-uri="file://$(pwd)/bundle-list" \
+		clone-from nego-bundle-list-heuristic &&
+
+	git -C nego-bundle-list-heuristic for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/base
+	refs/bundles/left
+	EOF
+	test_cmp expect actual &&
+	grep "clone> have $(git -C nego-bundle-list-heuristic rev-parse refs/bundles/left)" trace-packet.txt
+'
+
+test_expect_success 'negotiation: bundle list with all wanted commits' '
+	test_when_finished rm -f trace*.txt &&
+	cat >bundle-list <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+		heuristic = creationToken
+
+	[bundle "bundle-1"]
+		uri = file://$(pwd)/clone-from/bundle-1.bundle
+		creationToken = 1
+
+	[bundle "bundle-2"]
+		uri = file://$(pwd)/clone-from/bundle-2.bundle
+		creationToken = 2
+	EOF
+
+	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
+	git clone --no-local --single-branch --branch=left --no-tags \
+		--bundle-uri="file://$(pwd)/bundle-list" \
+		clone-from nego-bundle-list-all &&
+
+	git -C nego-bundle-list-all for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/base
+	refs/bundles/left
+	EOF
+	test_cmp expect actual &&
+	# We already have all needed commits so no "want" needed.
+	! grep "clone> want " trace-packet.txt
+'
+
 #########################################################################
 # HTTP tests begin here
 

base-commit: d8ab1d464d07baa30e5a180eb33b3f9aa5c93adf
-- 
gitgitgadget
