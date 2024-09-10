Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E8B1531E1
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935346; cv=none; b=kdBx9KoH9Nk87rQZPG/tkI6EbrGA3T9TVYLjnezZ7rvWjmEt2OuNuT+VWXrCokAjK+d//R6QK/sbi/AMgfAJ4RAt+qyDht1ZIpfAEt44aG3Vr1IDOdi5OeyU+RQhrBLWxUTe06JAOsIPmEDG3Avighlq+HVLY2g/hWGQR+Xz3ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935346; c=relaxed/simple;
	bh=6jdAjoeS1g0eJtXGhPwMcbbnb2WhAIL55DjeXfzWZUI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EQ3N4oUwV/j5Px12gwao7yC3M0KuBc5IV+DlJjjFhGsnMp/IQWLhKh53tbV1O1ILSdvcfrrSuMUKZ/+U+8xr61oy3/SydOWZPeetoQl9NhUMnW8PQEnDk+KXZx3wFGIAXyrAvJRcCjwOC5nMUefma6VyjbFz3+h/4f8pmK7uXCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxqAYncw; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxqAYncw"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d13b83511so361252866b.2
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935341; x=1726540141; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZI+0g2ezLXpeQ0lk1bb92N3OXLntYJyZ6dhDZcz5Ho=;
        b=cxqAYncwElgOofvcF3Bk9NW/cP1Scy8tfGnHF+IhFczN8xCAnd03CEnN7WYV4Cuc2b
         gWJMuIMjslK02WZ/zHja2wqkHAcMx7hu8DQLQhqfwdo3eQIVqeb+4JXJs3MtSOanK8eD
         xs4WaprByBahii64ycPdTZijl0AGV+QtH7ufk9TcIAsWAc8EADPRrzfW2jAGgIwfOhWK
         lGr9pSaOrJkhKoRugLZmqtBhGjGQZsJaYbrd2yir1bht8yn+NORmQkm8b7JTjaP1lXO/
         75H4BbthjBVirTkcR6upPcwIajhUV7aWO7nz7xid9YyG8uRfLLDfBj9s4zsmnrNAIEyq
         JV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935341; x=1726540141;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZI+0g2ezLXpeQ0lk1bb92N3OXLntYJyZ6dhDZcz5Ho=;
        b=lY3ASR6Yf7JI8MESPEjC6FqYct1nXVZgAwqUPqeOYfTTA0Q/mtE75QOvJfyg8gctbM
         /emkQj9q2cwpSSA4VJ1+ZM/iF3aIiYtPaAIocsiqXQgrbkbhOxfZSnNKGFMTEHP1E1h3
         l3uUp+wDdyv6pKoOnwLXnDk6u+pYbQLzgE5te00mCo/Cffkfk5wNYHaH12FNEdlYP+0g
         uckTreIsP4eLuhHXdCff7D4F6kf4XCek+nNAgnlyrVbiigvbfSlH59EnMxelqPeJoyZd
         Doob+7dpSjNjwGdzzo0cYIP+ctiwZkAy7Ju7/WWlLHhtXSXc9AkfL8Z1jjtu/rqjgKlB
         ehQg==
X-Gm-Message-State: AOJu0YwgCClJHA3p714pTiQ5J7eTcc1niM00BnxPW6Swe3o6ewsT/Eh4
	ZUTRCE8xXrqwR4gGyaaFEaXNGHm47dL8uppqz7CZkwBwQYolDjeJMLTm+w==
X-Google-Smtp-Source: AGHT+IGxr0CBidvuEC0u+sp5uemM4uof/QpZsat8rdeQKFwSo15jf8FqFUUe1glh5PlAmx8HJZyRvQ==
X-Received: by 2002:a17:907:920a:b0:a8a:18f9:269f with SMTP id a640c23a62f3a-a8a888710d9mr709934666b.60.1725935340759;
        Mon, 09 Sep 2024 19:29:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c60f0bsm415800066b.125.2024.09.09.19.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:00 -0700 (PDT)
Message-Id: <f904b02e08dda5af1620991418755176e0b731e0.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:29 +0000
Subject: [PATCH 04/30] backfill: add --batch-size=<n> option
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <derrickstolee@github.com>

From: Derrick Stolee <derrickstolee@github.com>

Users may want to specify a minimum batch size for their needs. This is only
a minimum: the path-walk API provides a list of OIDs that correspond to the
same path, and thus it is optimal to allow delta compression across those
objects in a single server request.

We could consider limiting the request to have a maximum batch size in the
future.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-backfill.txt | 10 +++++++++-
 builtin/backfill.c             |  4 +++-
 t/t5620-backfill.sh            | 18 ++++++++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-backfill.txt b/Documentation/git-backfill.txt
index 0e10f066fef..9b0bae04e9d 100644
--- a/Documentation/git-backfill.txt
+++ b/Documentation/git-backfill.txt
@@ -9,7 +9,7 @@ git-backfill - Download missing objects in a partial clone
 SYNOPSIS
 --------
 [verse]
-'git backfill' [<options>]
+'git backfill' [--batch-size=<n>]
 
 DESCRIPTION
 -----------
@@ -38,6 +38,14 @@ delta compression in the packfile sent by the server.
 By default, `git backfill` downloads all blobs reachable from the `HEAD`
 commit. This set can be restricted or expanded using various options.
 
+OPTIONS
+-------
+
+--batch-size=<n>::
+	Specify a minimum size for a batch of missing objects to request
+	from the server. This size may be exceeded by the last set of
+	blobs seen at a given path. Default batch size is 16,000.
+
 SEE ALSO
 --------
 linkgit:git-clone[1].
diff --git a/builtin/backfill.c b/builtin/backfill.c
index 23d40fc02a2..50006f15740 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -21,7 +21,7 @@
 #include "path-walk.h"
 
 static const char * const builtin_backfill_usage[] = {
-	N_("git backfill [<options>]"),
+	N_("git backfill [--batch-size=<n>]"),
 	NULL
 };
 
@@ -109,6 +109,8 @@ int cmd_backfill(int argc, const char **argv, const char *prefix)
 		.batch_size = 16000,
 	};
 	struct option options[] = {
+		OPT_INTEGER(0, "batch-size", &ctx.batch_size,
+			    N_("Minimun number of objects to request at a time")),
 		OPT_END(),
 	};
 
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index 43868a4a75f..2d81559d8e9 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -62,6 +62,24 @@ test_expect_success 'do partial clone 1, backfill gets all objects' '
 	test_line_count = 0 revs2
 '
 
+test_expect_success 'do partial clone 2, backfill batch size' '
+	git clone --no-checkout --filter=blob:none	\
+		--single-branch --branch=main 		\
+		"file://$(pwd)/srv.bare" backfill2 &&
+
+	GIT_TRACE2_EVENT="$(pwd)/batch-trace" git \
+		-C backfill2 backfill --batch-size=20 &&
+
+	# Batches were used
+	test_trace2_data promisor fetch_count 20 <batch-trace >matches &&
+	test_line_count = 2 matches &&
+	test_trace2_data promisor fetch_count 8 <batch-trace &&
+
+	# No more missing objects!
+	git -C backfill2 rev-list --quiet --objects --missing=print HEAD >revs2 &&
+	test_line_count = 0 revs2
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
gitgitgadget

