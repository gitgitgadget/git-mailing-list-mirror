Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A0284D15
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 23:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711409163; cv=none; b=Kglav6pLEoxjGAfd86T8818TigM/xy5kxt8uKWqLe3CMTGfQbHJqTwiuQX/G7mcDovpD3m0AFrK8j/9ORsfFWDSHNv84g/QlwGj1zdaqvMVVPsz59pVH/uuKMK4Se0WRktxiVyrknOzL+ABxLGXyQYK4UWBaW1HCqG6E2v6PIF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711409163; c=relaxed/simple;
	bh=TZFacfxETRF9ZMTJO6qCzMwkA2Lny0XmS2CluN4EAaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGRnbt2Tj4E6CPVspiza1gYwDJLf5q+jXcpOIDAoTMrFjP1EW3O/Z/u6B6d5N4/RDGixsFJdWK3JOMB3WaCBFHKQD+8dmf1UZKz7Rb49um561oHuRRBVggqwy4FHtIBdOM/sDVxBySBeNMSpsoXyLZxfudqAZK4JE2OFIwe6teQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKVOcPbT; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKVOcPbT"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-221e1910c3bso2490561fac.1
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 16:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711409160; x=1712013960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkwUw8M2E2ZD4ut4a+KfdfB0yshmnU69j4ptyQi7344=;
        b=TKVOcPbT/EnfzVq4Ppjg1I3igFyFJcvR8xO+CusfecOnrf3OCiG056lTpfmKPv4LNj
         NLpWQUKwgKUE9DzhYwNpBS/bCfMQQrpbHcspss4+uck7HkeEIkqG/JdsRUTeBu6LCwOZ
         RL9co6E2aE1gRNC58o86nurCXHRcQnCjb9tx+SFqY/sKrv7U2cqJTzgtO/Xig6NceWGi
         /GUk8FbAc9BzcQi5Krjqf/rXX+G24asXtyN55eTJEF/fkA35H7qJGS8JsxnreSdVGTdJ
         C5Xfp5g8b5Ytp+Nw0xiQH/l6tK99pZii9hhvuWFEx+YaI992aoVfZJi0ZDhSs28jwc8V
         YQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711409160; x=1712013960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkwUw8M2E2ZD4ut4a+KfdfB0yshmnU69j4ptyQi7344=;
        b=LlHFz6J9ELrefIA24+tjVd/vrcs8ElgCgzgukpG2Fpd4Bq2Wf6egspbFoBdD4G6bj0
         D7Xd5uj3RBam9CPT2uV02dg/ZizwuEeRAm6hfdpBXCntHQn7UQrt6nqBZP4pt+P+CWfb
         p9biuHt0HnhfFxJtUSidcEQXlctVTi7yGIch9DNeswlQ2d4HPe+VQCwPFWAy9U9iNvlr
         6Zb1W+M0MGKaNaBIieAYHPRADlV3X94IivsQIoIlmAYnyVlTotoJCrkXBzr1ErRgys34
         anr5NMFK50ununaU08dzhP/yjqt7+/ngWu32PLLGOK6ANx/ymM3gZHVpOqQ6rxmcbp96
         yfQg==
X-Gm-Message-State: AOJu0YxC5ZlspOtgtPsL0vTBazVUAp+IW86qpmJR8DJMazPqZGIE75M+
	GLnELAGpHjYzPE1srYyqHxEFR+SFYMNu9i7GvZNPF9gMMdZK3qXwv0TBwgWGnUU=
X-Google-Smtp-Source: AGHT+IGmNcX01elAS/aP/EIMKoshms8ZQ5r5PoeaR8khfFIOQgNqbQWRxjvWcgXVQ7ly+BwfDDu9Aw==
X-Received: by 2002:a05:6870:a897:b0:229:f022:ef92 with SMTP id eb23-20020a056870a89700b00229f022ef92mr5794747oab.10.1711409160447;
        Mon, 25 Mar 2024 16:26:00 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id vp8-20020a056871a00800b0022a1d794bb8sm1454868oab.22.2024.03.25.16.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 16:26:00 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v5 6/7] cherry-pick: enforce `--keep-redundant-commits` incompatibility
Date: Mon, 25 Mar 2024 18:16:53 -0500
Message-ID: <20240325232451.963946-7-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When `--keep-redundant-commits` was added in  b27cfb0d8d
(git-cherry-pick: Add keep-redundant-commits option, 2012-04-20), it was
not marked as incompatible with the various operations needed to
continue or exit a cherry-pick (`--continue`, `--skip`, `--abort`, and
`--quit`).

Enforce this incompatibility via `verify_opt_compatible` like we do for
the other various options.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---
 builtin/revert.c             |  1 +
 t/t3505-cherry-pick-empty.sh | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/builtin/revert.c b/builtin/revert.c
index 89821bab95..a1936ef70e 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -167,6 +167,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 				"--ff", opts->allow_ff,
 				"--rerere-autoupdate", opts->allow_rerere_auto == RERERE_AUTOUPDATE,
 				"--no-rerere-autoupdate", opts->allow_rerere_auto == RERERE_NOAUTOUPDATE,
+				"--keep-redundant-commits", opts->keep_redundant_commits,
 				NULL);
 	}
 
diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index eba3c38d5a..61f91aaa0a 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -99,4 +99,18 @@ test_expect_success 'cherry-pick a no-op with --keep-redundant' '
 	test_cmp expect actual
 '
 
+test_expect_success '--keep-redundant-commits is incompatible with operations' '
+	test_must_fail git cherry-pick HEAD 2>output &&
+	test_grep "The previous cherry-pick is now empty" output &&
+	test_must_fail git cherry-pick --keep-redundant-commits --continue 2>output &&
+	test_grep "fatal: cherry-pick: --keep-redundant-commits cannot be used with --continue" output &&
+	test_must_fail git cherry-pick --keep-redundant-commits --skip 2>output &&
+	test_grep "fatal: cherry-pick: --keep-redundant-commits cannot be used with --skip" output &&
+	test_must_fail git cherry-pick --keep-redundant-commits --abort 2>output &&
+	test_grep "fatal: cherry-pick: --keep-redundant-commits cannot be used with --abort" output &&
+	test_must_fail git cherry-pick --keep-redundant-commits --quit 2>output &&
+	test_grep "fatal: cherry-pick: --keep-redundant-commits cannot be used with --quit" output &&
+	git cherry-pick --abort
+'
+
 test_done
-- 
2.43.2

