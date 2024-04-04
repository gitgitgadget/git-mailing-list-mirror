Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9F3130A58
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255377; cv=none; b=LOlLZYX+QdLVMqbGxFyDfquKj2AaihpZDchrhHK3UewN1Fkh18DbVvwhNUyNLJgDpX2GxSyuvrUx+NhuVzlVdtGhIgeJxNLGK0zMW/OgzkNUA0ZOn73txqUgMCyA4Wh9MVoc6wIPxybbm9hJ+a0aO2PEVCLJtVtr/NH1ZcUsIek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255377; c=relaxed/simple;
	bh=SGRoB3Ls4NSX8DFUeyjq2hUNeDsu0sOmDj8QzzpWxtQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tiwG7KqG6sKAmQSI1wDcvSrkZGcel8tZxf3EsVto2ahlHkRn9M8hkuT1BFoWzb8oYsOeE3fogyCWueHNs9jWklVAxaTLCW8m3j+LTVbUN/63L3O5QwLrQ11VFtDc66pEk09mDKedA5sNW5RmI9pxp8I4sfTKZt/mE3GhUEX/Cdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wva7UqRZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wva7UqRZ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-415584360c0so9815155e9.1
        for <git@vger.kernel.org>; Thu, 04 Apr 2024 11:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712255374; x=1712860174; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXd5dyR56DSwC7VqXb+akUfx07s4BGr6g8LRyw/vigM=;
        b=Wva7UqRZCRyPjvpUm84vh/V7LsMjkMjccw8oKa+skEK77UiwmljgN7hRMhJMXGtQuy
         8F6XcR1IOh1OcPUlTn/PN3HGZxtIXSh3UOeRNScdmHa9Ly3gmZsstw/6pP3jUVYxvWTP
         tsmcmUMcgpQeM+4Cy/jjB0oMkis5GhAwhS21B+ZrOG4JVkj3YnkeERuEh6QDfzi4xi9v
         xEumg/W7a6ljuurGP8Y4culw3noolMnULS15RLBfRdtcle+Ye968VAfBwasd1khVwsoR
         h226SnMmEEuWvppIN9frnv3kv9G09/oEoHnz9ka/TH5am0s+9LihDuYQ9WNEQgnXPCEv
         k2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712255374; x=1712860174;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXd5dyR56DSwC7VqXb+akUfx07s4BGr6g8LRyw/vigM=;
        b=l2+/mDTCs/mG7kALmrItReAmZlHfk0RPnR4PdSnefQ7gZPHYm0qp4NMqsMpMs/6Eef
         vkseOdKDzdkT610k9bd78D1AZki9J6to0rzSBZaVOQ06RHjrnkS0ORqC1gmjus+aEizE
         y6gujUGZBu4/i306y7GTmztArVzv8XPwm97amoDwOV+9D8qMsx8NAW0MWRd9VMiPbjVh
         TXm4hCUq3NrxFWd/wFhUZBU3u9jUen9zw5XkPEvekkC/PHg9TrMqJF2wj7yl0/Slwin8
         HNI5v0FEDXFVXwwzsDBPOiIleq6CphfJ5MSoKQhV5mjndym/D/m2sbqQaTjyVnoEhAK9
         zaeA==
X-Gm-Message-State: AOJu0YyEFdP1iJXD7weJLXpOi7gJc2X+rkUsCxX/leZADC1zfsB2nnJm
	4zlgsW1vopPYfdH4xh/Ykl6hqp9blIxQ3cEC/OTUYrBVgEaGM0rHdkCvcQJg
X-Google-Smtp-Source: AGHT+IGecg1owiHQSqj6Tg1OGMRP1XUF/+FanQjM4gTCjpntS5woMy+F8t93TJlhOVNdwBFc/g2iLw==
X-Received: by 2002:adf:fac6:0:b0:343:68ea:c0a8 with SMTP id a6-20020adffac6000000b0034368eac0a8mr2493413wrs.34.1712255373756;
        Thu, 04 Apr 2024 11:29:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id dr20-20020a5d5f94000000b0033ea499c645sm27063wrb.4.2024.04.04.11.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 11:29:32 -0700 (PDT)
Message-Id: <7c4fe0e9ec597203ee37d2c2503be319e87ff5ee.1712255369.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1683.v5.git.1712255369.gitgitgadget@gmail.com>
References: <pull.1683.v4.git.1712103636.gitgitgadget@gmail.com>
	<pull.1683.v5.git.1712255369.gitgitgadget@gmail.com>
From: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Apr 2024 18:29:28 +0000
Subject: [PATCH v5 2/3] reftable/stack: add env to disable autocompaction
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
    Karthik Nayak <karthik.188@gmail.com>,
    Han-Wen Nienhuys <hanwenn@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Justin Tobler <jltobler@gmail.com>

From: Justin Tobler <jltobler@gmail.com>

In future tests it will be neccesary to create repositories with a set
number of tables. To make this easier, introduce the
`GIT_TEST_REFTABLE_AUTOCOMPACTION` environment variable that, when set
to false, disables autocompaction of reftables.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 refs/reftable-backend.c    |  4 ++++
 t/t0610-reftable-basics.sh | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 0bed6d2ab48..6b6191f89dd 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -18,6 +18,7 @@
 #include "../reftable/reftable-merged.h"
 #include "../setup.h"
 #include "../strmap.h"
+#include "parse.h"
 #include "refs-internal.h"
 
 /*
@@ -248,6 +249,9 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	refs->write_options.hash_id = repo->hash_algo->format_id;
 	refs->write_options.default_permissions = calc_shared_perm(0666 & ~mask);
 
+	if (!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1))
+		refs->write_options.disable_auto_compact = 1;
+
 	/*
 	 * Set up the main reftable stack that is hosted in GIT_COMMON_DIR.
 	 * This stack contains both the shared and the main worktree refs.
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 931d888bbbc..c9e10b34684 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -299,6 +299,27 @@ test_expect_success 'ref transaction: writes cause auto-compaction' '
 	test_line_count = 1 repo/.git/reftable/tables.list
 '
 
+test_expect_success 'ref transaction: env var disables compaction' '
+	test_when_finished "rm -rf repo" &&
+
+	git init repo &&
+	test_commit -C repo A &&
+
+	start=$(wc -l <repo/.git/reftable/tables.list) &&
+	iterations=5 &&
+	expected=$((start + iterations)) &&
+
+	for i in $(test_seq $iterations)
+	do
+		GIT_TEST_REFTABLE_AUTOCOMPACTION=false \
+		git -C repo update-ref branch-$i HEAD || return 1
+	done &&
+	test_line_count = $expected repo/.git/reftable/tables.list &&
+
+	git -C repo update-ref foo HEAD &&
+	test_line_count -lt $expected repo/.git/reftable/tables.list
+'
+
 check_fsync_events () {
 	local trace="$1" &&
 	shift &&
-- 
gitgitgadget

