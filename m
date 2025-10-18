Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA7827F016
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 20:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760818049; cv=none; b=c7JVzuj/p1OxM408XJEz22tE+BvdEwxcRFnka9h7O8lC58G9ThZD23qeUkOJYI8q+8VD4egmTseE5BgyveqSfzcYj+H713tGDj2gVMgq42dpFmHds2g3zJm/XLtEsBRM52TBr0qZEq6kD1uopKII3+S9biKeGBuc9V/M6rilmfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760818049; c=relaxed/simple;
	bh=mIJztLhVe4ZCCxWlJ82w8Nl7T5pVWIPezAoZnGMvqK0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SVBpjx671p03S2ETTyObViclQtZaBIU1FoSqvP0qPfp6XdcTE/YxDmTidSgcg/rE0CBSeKIboKrB3LdjJwwgObLCiMpcOzI6UBHY4eBQ0GzwyYQFwFkNkCHn04BusyOgGkFGLEtsPF4lEFbjnO7N8ffjIt70sgGr63BVxjRApWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAumKOC2; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAumKOC2"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so2845263b3a.1
        for <git@vger.kernel.org>; Sat, 18 Oct 2025 13:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760818046; x=1761422846; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYisAHC+fBOMIEaxCA80yFB9nDd4wns0ZqM9ROHM4MM=;
        b=DAumKOC2pvGUHGpB2/obUtUQX8Uq/nxtPu+AVQV8sGYtT3kdEL8W7lUZo9skz+JVqH
         tp5UW1knjDcxzhdpfHk5Y/wUF/r5yh5yCyrScNOpFB5qASQlJmv7ALc+H4kz4KjaeydH
         Y5T1j7iZOTtrqTt0OZcubsQiFVbXaIiZSTLJirs+z4NJxKia/2dc0ir1ootNd32xZsSK
         qu5POqEXCquhmkDLxdsKT3MXnhNm06Muf0K+eTvzxgtpEQyHWQxGre+ipY77JE3jnjFK
         InHPMnfHZ/pg5q4CU1FnDkmaEDEwFRy00T5gqRfO+KFw5MVNqQhUrJpYyLf+ze3NuFTm
         PRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760818046; x=1761422846;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYisAHC+fBOMIEaxCA80yFB9nDd4wns0ZqM9ROHM4MM=;
        b=APnaG7GOQMoj8l5yZWjqYbu2yD6M0RUHX74yqFE2a66gbbhZMCw/wjeCCVK+48FaHv
         1TfP8dCDNTbLsFlJUDWUMX80hsN75w3UffqNMowQGNK1IwcI4OW5Bt9QDrdGk1PKcu8u
         +0ctRz5zSoaWM4yN5XSx5/TARpvqeWMsltq5qoG3cnJWzU8fPcsKqMjZkLmjZrPLtZTD
         jqLV6Ykf+6LExfTtlpzijVW9hpnZmDuyg5ALT1M85Y7fwfiWm+bQ8/pCOCLok85/p0rn
         W97WQACOga1PgbeKMMDyimgysI9wrfoxq4ilXPwX6a+27taPMqzIg2LrMrj//dMn0+8q
         gBZQ==
X-Gm-Message-State: AOJu0YzfuvoJ4C20670DPVXDdGJOQJiLixbdLZ4qR9AjhA+qjyymZo7o
	lYpYM7tGtGTUbWZ7bDYlQ5ZeCaw5VzgxybhVCsrCLKEmmOWosKVA6NrgRP3I7dfV
X-Gm-Gg: ASbGncvIv1Q/t83s0u9OUNPOnFayaogZD3vxWf3gy+nxdQOAOTc6ZuWnNKy7j34cVBs
	/CYfSiHVDGEOWUTLaNcn7kMEWV6qCDkeUq73v1hUenh7NgTbx5lBB6P8PDI7N75QVU4wZZ8mWnD
	J8UfRArekylBYb2pUifHmjv0tDASHRU+MKmJt2u8e9j/yi3CaAo4O62ia8TveaS3FqhRVYAoSy9
	s7DurNyafmYdFm7LiWRjFKfmpEe4RhJLn4lvjUTKBBRqeCVWeckR1nCxl/3xy68+g3iGsIdOC0L
	gxPK6dpNx3ytOCQNFIs1bBgL1kEr1Xw1tES76jJQgaV7LapyqCUlEClo7h0Ki55pxTJjkmwJXap
	e081DZruSDwHxHr5Y6gRX5o7ZfUowyAYJzWJuL3cGM779Dqm/OBDGVeP0TFFdznIUFRnV6QaGaa
	OaHckGVKc7X6kg2Q==
X-Google-Smtp-Source: AGHT+IHFUjJtJUSsg4So5sQnMooRDyzU5t2WQeKOJ5p1aD07VuLjY8xq9fHF+1driSyzvcIz3qDLIw==
X-Received: by 2002:a05:6a00:1491:b0:7a1:3b33:f7f9 with SMTP id d2e1a72fcca58-7a220aafeb1mr8373757b3a.26.1760818046481;
        Sat, 18 Oct 2025 13:07:26 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.85])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff34b8bsm3520490b3a.22.2025.10.18.13.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 13:07:26 -0700 (PDT)
Message-Id: <416695f439032e027a322c752df3e4215b8d233b.1760818039.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
References: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
From: "Claus Schneider(Eficode) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 18 Oct 2025 20:07:19 +0000
Subject: [PATCH 5/5] Documentation: update add --force and submodule
 ignore=all config
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
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Brandon Williams <bmwill@google.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

From: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

- The add --force doc: append additionel info about the submodule
functionality.
- The submodule config ignore=all now need --force in order to update
  the index.

Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
---
 Documentation/git-add.adoc    | 4 +++-
 Documentation/gitmodules.adoc | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index b7a735824d..2234b1e846 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -77,7 +77,9 @@ in linkgit:gitglossary[7].
 
 `-f`::
 `--force`::
-	Allow adding otherwise ignored files.
+	Allow adding otherwise ignored files. The option is also used
+	when updating submodules and `submodule.<name>.ignore=all`
+	is set. The `path` to the submodule must be explicitly specified.
 
 `--sparse`::
 	Allow updating index entries outside of the sparse-checkout cone.
diff --git a/Documentation/gitmodules.adoc b/Documentation/gitmodules.adoc
index d9bec8b187..3aa71170ee 100644
--- a/Documentation/gitmodules.adoc
+++ b/Documentation/gitmodules.adoc
@@ -70,7 +70,10 @@ submodule.<name>.ignore::
 --
 	all;; The submodule will never be considered modified (but will
 	    nonetheless show up in the output of status and commit when it has
-	    been staged).
+	    been staged). Add `(new commits)` can be overruled using the
+	    `git add --force <submodule.path>` similar to ignored files. The setting has effect
+	    for `status`, `update-index`, `diff` and `log`(due to underlaying
+	    `diff`)
 
 	dirty;; All changes to the submodule's work tree will be ignored, only
 	    committed differences between the `HEAD` of the submodule and its
-- 
gitgitgadget
