Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352C8286AF
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707551375; cv=none; b=MRqOb6V/6eUWdxX0VPEvwqDwLEh5QbzmXCWW7pcTGHgsNfo2B6W3f1Isw2tLG5qYxk1GgIXxxajshxxDxlLHHTC9imI+j2ygbu30OMZxgYKaf+aoVgXwce+jkxy3arvEPKBVA9TSCk+glfb+PhodX5SxtvlEHw95WvpKMn3oBEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707551375; c=relaxed/simple;
	bh=ujTGDYih/03CZRxTMsRZ7F9LzdE5m+7l3CMhkTOCXGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejY4o9dzkHaIiv42U6WCDYteGUlexzyVOAsbTht7PuyaTXnIMVKh7B3xI32/Z67/O28z4BEi/J0Y72Eq13rZbdFCtanIhRw/g/wk/D3XusZKKmndv4aLPfv1Bsyz69Qt2gcJnaRP9Ar93lrrOvGJ9uDbq+bSmhyLdSw2gDBuP7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgEzO3qr; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgEzO3qr"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-210c535a19bso921161fac.1
        for <git@vger.kernel.org>; Fri, 09 Feb 2024 23:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707551372; x=1708156172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91q/SGLVtd8ou0Ur2o2ietf5IY4I9k5bFZpq2/vRJXg=;
        b=UgEzO3qr6JFEQfRyt8yeL+6ZHXE/VapRhp9VMnn5c3SJIE9cNIVhzFgu04il8j1Q63
         w6VA7zPiox1n5IQWBgpBTI7cOcIs8mD+mXjze5kYxFPjWlqwdb6Yx+9UGFgO62nN84Hm
         gvbnCscuWkR8uvkb8vwJBB6SnTlltU9m8g9TsBVezEYuBI19EvgGCvRD9XoPHUtqRlnZ
         gkTDsYE1evcLvpNZPpcSylwOwcw2D4lWKH1VUTZG3sLzWaNGEAa/+RqIboRP8S7SfibK
         gs5dw5JCtPGBP8iQgScnLNJ6dW6AWtWQWUOsJCTAfuqDkfx50/sn5om3ptczdixqx+bI
         sXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707551372; x=1708156172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91q/SGLVtd8ou0Ur2o2ietf5IY4I9k5bFZpq2/vRJXg=;
        b=MLSYS4qoUiaiP0ZHb3DLDYJvWFOjWu3zInwH79Axi5Pv1nCt5A094cOz3IMRfW1n17
         sO9MqGsGV7GTlHfIwUgmvTCq9QGqKwFev3o8M2R7oY7F8OPN+JPPCi7/JlPinZx9/YtJ
         XMnTh6K7Mg41/D9OKd+T2xpYI31CCUjzulNEUKgazeIGYqODNeMFLbsgrZkjNnAWipRx
         qNUqtpG3V3cVBt2GaTAE9456dDWlH4H5aogZDqY0X1ly4gSaPt3rTgs6NL8r1fRiynAL
         /DhRjxDlJL7gRNHSSlOMK3YJcQ1PWcjbCdSPfotimkwDL1dPPOPquU1f0cUNtmK0LWHf
         lq8A==
X-Gm-Message-State: AOJu0YzR6tpNzj5piwi8IoajPBBA0f3QABg3giXuPqbJaDZZFGtbhCac
	iA8IRbSNmWLxpsUTvY8kTqSENGP47/O4eA8eBGULeGQYdEC+sk8tusvNYaPSaqE=
X-Google-Smtp-Source: AGHT+IHVTU7McvJ85KmcWmjy6ta+rkCpw9snNjU15YlCEeX8O6q2OfYR5PA6q2Us0XwcbAuZQ8/lCw==
X-Received: by 2002:a05:6870:b150:b0:219:7e20:2bea with SMTP id a16-20020a056870b15000b002197e202beamr1616090oal.45.1707551372145;
        Fri, 09 Feb 2024 23:49:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVTZBzrq/atnPgkMQAurxU+xAUqBl32ss1fnQ2EGAWgQlqKEil87+ZswdbjNpnuvXaIIwxaaQZ9rAW4NONka9bn6Ja/ExBu3EFgheKGtIVw91ZMZpF+XPuamTIeLag6R2PuLVUKcyt2u0nNeXMHyrduniPj/Akc58ekK5vdHcNwQQol6czZyric2qn3jshgrC8mKoF8KdFnhUXQQg==
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id v19-20020a056870955300b00219fd9e3194sm310028oal.7.2024.02.09.23.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 23:49:31 -0800 (PST)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 1/8] docs: address inaccurate `--empty` default with `--exec`
Date: Sat, 10 Feb 2024 01:43:49 -0600
Message-ID: <20240210074859.552497-2-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation for git-rebase(1) indicates that using the `--exec`
option will use `--empty=drop`. This is inaccurate: when `--interactive`
is not explicitly provided, `--exec` results in `--empty=keep`
behaviors.

Correctly indicate the behavior of `--exec` using `--empty=keep` when
`--interactive` is not specified.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
Reported-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

This commit was not present in v1. It is a fix to some existing
documentation that Phillip noticed was incorrect.


 Documentation/git-rebase.txt | 10 +++++-----
 t/t3424-rebase-empty.sh      | 38 ++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 150734fb39..9d7397b696 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -295,11 +295,11 @@ See also INCOMPATIBLE OPTIONS below.
 	empty after rebasing (because they contain a subset of already
 	upstream changes).  With drop (the default), commits that
 	become empty are dropped.  With keep, such commits are kept.
-	With ask (implied by `--interactive`), the rebase will halt when
-	an empty commit is applied allowing you to choose whether to
-	drop it, edit files more, or just commit the empty changes.
-	Other options, like `--exec`, will use the default of drop unless
-	`-i`/`--interactive` is explicitly specified.
+	With ask, the rebase will halt when an empty commit is applied
+	allowing you to choose whether to drop it, edit files more, or just
+	commit the empty changes.
+	When the `-i`/`--interactive` option is used, the default becomes ask.
+	Otherwise, when the `--exec` option is used, the default becomes keep.
 +
 Note that commits which start empty are kept (unless `--no-keep-empty`
 is specified), and commits which are clean cherry-picks (as determined
diff --git a/t/t3424-rebase-empty.sh b/t/t3424-rebase-empty.sh
index 5e1045a0af..73ff35ced2 100755
--- a/t/t3424-rebase-empty.sh
+++ b/t/t3424-rebase-empty.sh
@@ -167,4 +167,42 @@ test_expect_success 'rebase --merge does not leave state laying around' '
 	test_path_is_missing .git/MERGE_MSG
 '

+test_expect_success 'rebase --exec --empty=drop' '
+	git checkout -B testing localmods &&
+	git rebase --exec "true" --empty=drop upstream &&
+
+	test_write_lines D C B A >expect &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase --exec --empty=keep' '
+	git checkout -B testing localmods &&
+	git rebase --exec "true" --empty=keep upstream &&
+
+	test_write_lines D C2 C B A >expect &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase --exec uses default of --empty=keep' '
+	git checkout -B testing localmods &&
+	git rebase --exec "true" upstream &&
+
+	test_write_lines D C2 C B A >expect &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase --exec --empty=ask' '
+	git checkout -B testing localmods &&
+	test_must_fail git rebase --exec "true" --empty=ask upstream &&
+
+	git rebase --skip &&
+
+	test_write_lines D C B A >expect &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.43.0

