Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B9130F7EF
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 05:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772428563; cv=none; b=t/XPsGOWpT78ei+I295IQO37vmIwAUv6kOc+o6O+MwLLKPAzQl71014Z969Yims2T+Faq2AvNS3Q1ijDGjlxGLr7/vi8vU2R7iCNj7OYGOqkErFhW7zbF8Xbe6njAqDYvfBpgh/ghTKhKhVk/kyGPwpb8zXO3ubO158y/kQPvvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772428563; c=relaxed/simple;
	bh=vSlgu0tu7D65JYHPrNIY93aTEM5oNGx50wW5rObqgGo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=r+orm8DbiWVnCiHqgJl7fxaUJeHYZ94L2TXmEMJbCdAeFkl65MyuTWCsQPDQHkzD96DfVk+lOqK56+wsoOX8fK3iBauCt5dIK3JB2Zz4wvUO8pFf0AxrI+qZDqxMFfkHv4E442sTuuIdrg/H7WClB7McjdMI/oq7TopbUx7iwsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exwV+Cv0; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exwV+Cv0"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899fa9610bbso9861746d6.0
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 21:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772428561; x=1773033361; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFaoYwrzf+XUEuM49XxWQkgrDIYuMtnE8MhdyEh6BWM=;
        b=exwV+Cv04R0i+TRTb5QT6Mt6VCf5Qa7+Mo+gOJu0Zbr0BnZhorOlWdRAgWzpCZnEqT
         XHtgyAtGTw2nVywRXx+KvOurdofwKk+uCb6jV2oUhYC7g5RFSLp+sgFUTHHfUXD5mtpe
         wgDjwh1D8jOZ6gE70kJ7QW7XANfuiJ9zmP2k4ADpnCDjt6autnBMIork9YOBFsJuwZ5k
         CUtA25ueGbdY0rXU/FPlCVX9P90P/jpxk3TB4nbAqxJ6FbNMURg/yhpWDbgy3cuUwcfA
         M4S5rwQLhA93txRLqqCjS+JGWQ8ynOjx1vqg3PCxSZOplbRfThFeCH2ijbDgygV1jmSQ
         2HBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772428561; x=1773033361;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QFaoYwrzf+XUEuM49XxWQkgrDIYuMtnE8MhdyEh6BWM=;
        b=k206vdqDoeuscH+9u44LkvfaEPwTCrncSgvS6nSxdsaM4NdGJsgAp7PTCVykFFpLOX
         6m6dJ96Mq6g8kWwF59wMRCyuQTrEkOf5DBBZHQcQGj/zMWA/WQsU2bHWVKZ0JHdXs47F
         rJ5mriCDU3rs7NzW4U/u67eJN08gGhrTE8NSG/pNx4nL29+tPLdZIqSR5qJlC5/hOugz
         8E9wK8INSdZnPNX73F/tPS2YAM/kjFkqN1RIDup30MM1lhsI8F5sdaF+SU5cS4qcBBKg
         7FDkUwQUUpHYzsLWOQ6fdKPdep0Br51gRX7sKWHmfteuyZ1lKs4/wYOL9bX8JVnJjwaT
         M4ng==
X-Gm-Message-State: AOJu0YzYbOZXrr1LpPtOZAjiu0P6WTPAYHsOQEcj6XDR1ZnmtyfH8q2o
	/QcwNfIvluzeb99h37zc3PXcjhqWaP5yHygdVkrKPjv1a5cdeDlIEKMAuDr9vqFS
X-Gm-Gg: ATEYQzxaF5woOe6JsMMvAw2baBFz6LPqXscPMXv0ey0/y7SFRB2zICN+03PQCyiCwa7
	GGm4ZT8FhiCQOBuvm5P6or+DtSSEGQaKD07Zh/UDNpJyHoSnAD355d94KdNUjcsmaJf0aNj8Pxv
	FUhOHDX0O071TtLpTfnKlrZgUgLQEbiFFgvHuRZjVhzLqAEpRjHhS5UjQ9eq3CHTWo77OvpI4Y8
	qEc6xfQE8jNy7bTgHr+AE+pfJr0J9OtwjLR+SV+SvMfXG4SDRICpd4MlHrqbC3ZTC9D7q6FkdPS
	XlEMakDRFeo8wMX09TqbnfueAYOzDca7NAdqHuAHf2780y/+s2htWflQCynYp4c13eSPHcTOgkE
	OJX6HHdNEPfqmtaUqgo/7WbLcmuUHXVn8d1S48qwFa6FQzFDUITN1GFs9MG/myC3sgHGdey2pz2
	ws7kblcus7RVwsYGH6GF2zDGW+fQ==
X-Received: by 2002:ac8:5d15:0:b0:4ee:1563:2829 with SMTP id d75a77b69052e-507528f45ccmr121747461cf.72.1772428561129;
        Sun, 01 Mar 2026 21:16:01 -0800 (PST)
Received: from [127.0.0.1] ([172.183.95.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507451cda23sm108416351cf.18.2026.03.01.21.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 21:16:00 -0800 (PST)
Message-Id: <b98490a4a453c91da503644a4e1b5dfab0834a14.1772428548.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v6.git.git.1772428548.gitgitgadget@gmail.com>
References: <pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
	<pull.2208.v6.git.git.1772428548.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Mar 2026 05:15:48 +0000
Subject: [PATCH v6 6/6] docs: describe repo info path keys
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
    eslam reda <eslam.reda.div@gmail.com>,
    Eslam reda ragheb <eslam.reda.div@gmail.com>

From: Eslam reda ragheb <eslam.reda.div@gmail.com>

Document repo info category requests, path.* keys, and
--path-format behavior.

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 Documentation/git-repo.adoc | 58 ++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 319d30bd86..086ab922ad 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -8,7 +8,7 @@ git-repo - Retrieve information about the repository
 SYNOPSIS
 --------
 [synopsis]
-git repo info [--format=(lines|nul) | -z] [--all | <key>...]
+git repo info [--format=(lines|nul) | -z] [--path-format=(absolute|relative)] [--all | <key>...]
 git repo info --keys [--format=(lines|nul) | -z]
 git repo structure [--format=(table|lines|nul) | -z]
 
@@ -56,6 +56,11 @@ supported:
 `nul`:::
 	Similar to `lines`, but using a _NUL_ character after each value.
 
+`--path-format=(absolute|relative)`:::
+	Controls formatting for keys in the `path` category. The default is
+	`absolute`. This option may be specified multiple times; the last one
+	specified takes effect.
+
 `structure [--format=(table|lines|nul) | -z]`::
 	Retrieve statistics about the current repository structure. The
 	following kinds of information are reported:
@@ -64,6 +69,12 @@ supported:
 * Reachable object counts categorized by type
 * Total inflated size of reachable objects by type
 * Total disk size of reachable objects by type
+* Largest inflated reachable object size by type
+* Largest disk size of a reachable object by type
+* Largest parent count among reachable commits
+* Largest entry count among reachable trees
+* Longest and deepest path among reachable blobs
+* Deepest annotated tag chain
 +
 The output format can be chosen through the flag `--format`. Three formats are
 supported:
@@ -76,6 +87,7 @@ supported:
 `lines`:::
 	Each line of output contains a key-value pair for a repository stat.
 	The '=' character is used to delimit between the key and the value.
+	Both aggregate metrics and per-type metrics are included.
 	Values containing "unusual" characters are quoted as explained for the
 	configuration variable `core.quotePath` (see linkgit:git-config[1]).
 
@@ -90,9 +102,11 @@ supported:
 
 INFO KEYS
 ---------
-In order to obtain a set of values from `git repo info`, you should provide
-the keys that identify them. Here's a list of the available keys and the
-values that they return:
+In order to obtain values from `git repo info`, provide either individual keys
+or category names. A category returns all keys within that category. For
+example, `layout` returns both `layout.bare` and `layout.shallow`.
+
+Here's a list of the available keys and the values that they return:
 
 `layout.bare`::
 	`true` if this is a bare repository, otherwise `false`.
@@ -103,6 +117,42 @@ values that they return:
 `object.format`::
 	The object format (hash algorithm) used in the repository.
 
+`path.common-dir`::
+	The path to the common git directory.
+
+`path.config-file`::
+	The path to the `config` file in the git directory.
+
+`path.git-dir`::
+	The path to the git directory.
+
+`path.prefix`::
+	The path of the current working directory relative to the top-level
+	directory.
+
+`path.grafts-file`::
+	The path to the `info/grafts` file.
+
+`path.hooks-directory`::
+	The path to the `hooks` directory.
+
+`path.index-file`::
+	The path to the index file.
+
+`path.objects-directory`::
+	The path to the objects directory.
+
+`path.superproject-working-tree`::
+	The path to the superproject's working tree root, or an empty string
+	when the repository is not used as a submodule.
+
+`path.toplevel`::
+	The path to the top-level working tree directory, or an empty string
+	for bare repositories.
+
+`path.working-tree`::
+	Alias for `path.toplevel`.
+
 `references.format`::
 	The reference storage format. The valid values are:
 +
-- 
gitgitgadget
