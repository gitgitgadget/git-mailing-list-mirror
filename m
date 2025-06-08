Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F95120E31B
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749373798; cv=none; b=Jj+sIgyXwRP9TmqNVaVaexTa9qLptn0FWMUNTAJGbeREbXjSxrpNBwRhs3LaD6eeiOnETYqFR8PVKj+pqaCPlXQPOqcIK2BKpOuYlHmWx48zmUHvQn/5wBdUEG/JwuBFND3U9aV/nCx9RZzolHQTTS2bw7Ugc/frl+07T3VreH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749373798; c=relaxed/simple;
	bh=sVtkgW4IuCU1RRsxeG4rYenIUVhr9/GlEdb5+klktQY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=pFodNNAwHNgrrGQyBwlPAF992p5bvSwndmg4DRS1zBSVyRTuj88/FYADzxxwyoMZVrudnNl1rAoAO9wx7xKNJ7r0M4sAy5/XQr7ftNtbASlNQxoMi2zDCAfluK1MSJusr365gCW75vt5WFgn9jjVFLlgb1w/dnWaHRDt6HsZYfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWgKrtfu; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWgKrtfu"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a51481a598so2000003f8f.3
        for <git@vger.kernel.org>; Sun, 08 Jun 2025 02:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749373795; x=1749978595; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnX9I5C8cILuDqN9nKqwp1+GsMoj2E4XgxwEMzagsRg=;
        b=iWgKrtfu+VuMDuTqXiFy0wtAEckqSXHvRDMPOkCzH+OaZVzmIWDKW8uk+uimNjcqlQ
         a3t4kH15EhcHQ93bAyIoOi+xzm4hnfXArxImxQJLHjqe2/Olwu2YEquJI0FBA4PQWjPg
         TDJO5Vf+4gf+Z9mpljFBYd32JkU/peTAG1hGZ/rGYXwvUtHRW+rs3wQr2ZzbuW1QOE4B
         OTQCXTKcn0Fap6znSjsD24y5IA88yG99zpwM7KtzIRu/j0Fcerll3HPxNIZj8cCHAy+y
         V9qEH/eoPmzP+4jiqvSyddQ+1vqaTqgypb4+ECS5lDw7Nu9TTzuEf5uF798bw7H4rztF
         jMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749373795; x=1749978595;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnX9I5C8cILuDqN9nKqwp1+GsMoj2E4XgxwEMzagsRg=;
        b=UEeDNtf6NQucAZKQC5VkOzhI98RJ2unpUlyC+f//TOx57t2P1WtTtentn8kM/WktfY
         XLx/b790J99lZGzCmIgTZWoUf+RndL93bF1MHiy7oRIcdTV4KQnqCExt2t01D/ws25CQ
         rTSwvEtYoVQR5JRMnpO3Gt5f6/uDLD8CW+TK/BVD8c6xGJ5IYdPCFEWqpZLdTPRjY0jg
         balLwyq52dm6Ov8ZsjuYAgOS9aCcB9hb1bTx0h6xl4DtkTawK39CSNelyJ7VhM9Ba6/2
         042o1BEe4YsXS3SCxw6QY1s3nMFb6raainxcMiooNs122LbGof8dR6XjA/Nisyl/dRMR
         3czQ==
X-Gm-Message-State: AOJu0YzMkbgdz2u2bc7qsezhmVdhsjW5+Y7gHQQ+RzouOgr7FKe5vfC9
	Ic+5FYFcpwuHkpzFJuHDV/JyccSXa5CCco4gqKubNSoP2qsKcWOMfZG2VXNLrA==
X-Gm-Gg: ASbGnct+47H37za7HhY4TBAHlvhcHBPYf3sel2SzHoSw51eex6u+4iDUADRa2y3se2o
	jUoKy0DNjF1sKFLr/+W1aF+7sotAbIDc0auKKtFT47sM6qAlK/SPwX6ROcnL0xeiOUur+AN/m3s
	xvbsTl6m+BNXn+GznY++argtSjdeTiTLVjh6lMHj4iWcKCDYcwT5uTre1FubI1uA3dxidH0gC/+
	XHRtdX1jJZMdvi4UkZjNHZKpEjzmUA1vbuMXT56F/PHBN731c8UMk1VICDTCiUcmckt4NDr/sMo
	XD02zvm1P3ga2/ciF1kJ9MTsDL11nzAYRCiFGwuo2uDP3QSdMXLM
X-Google-Smtp-Source: AGHT+IHh8hyCMfAktHmIBu74qZbsInzn3vxhNQkHgiXZ4jgqXTdjbetXQqxoxSMha8F0eyyosMWjUQ==
X-Received: by 2002:a05:6000:2484:b0:3a5:266f:e6fb with SMTP id ffacd0b85a97d-3a5319a791amr7557959f8f.44.1749373794927;
        Sun, 08 Jun 2025 02:09:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5324621a4sm6599550f8f.88.2025.06.08.02.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 02:09:54 -0700 (PDT)
Message-Id: <9f9ce432bd6e50b9bbf1e16e2f55dbd730f72514.1749373787.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
References: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 08 Jun 2025 09:09:45 +0000
Subject: [PATCH 8/9] doc: git-log: convert diff options to new doc format
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.
- In description lists, put each option on its own line, to make them more
searchable and enable automatic translation of the options.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/diff-options.adoc | 40 +++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
index 640eb6e7db58..f3a35d81411f 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -37,32 +37,32 @@ endif::git-diff[]
 endif::git-format-patch[]
 
 ifdef::git-log[]
--m::
+`-m`::
 	Show diffs for merge commits in the default format. This is
 	similar to `--diff-merges=on`, except `-m` will
 	produce no output unless `-p` is given as well.
 
--c::
+`-c`::
 	Produce combined diff output for merge commits.
 	Shortcut for `--diff-merges=combined -p`.
 
---cc::
+`--cc`::
 	Produce dense combined diff output for merge commits.
 	Shortcut for `--diff-merges=dense-combined -p`.
 
---dd::
+`--dd`::
 	Produce diff with respect to first parent for both merge and
 	regular commits.
 	Shortcut for `--diff-merges=first-parent -p`.
 
---remerge-diff::
+`--remerge-diff`::
 	Produce remerge-diff output for merge commits.
 	Shortcut for `--diff-merges=remerge -p`.
 
---no-diff-merges::
+`--no-diff-merges`::
 	Synonym for `--diff-merges=off`.
 
---diff-merges=<format>::
+`--diff-merges=<format>`::
 	Specify diff format to be used for merge commits. Default is
 	{diff-merges-default} unless `--first-parent` is in use, in
 	which case `first-parent` is the default.
@@ -70,48 +70,54 @@ ifdef::git-log[]
 The following formats are supported:
 +
 --
-off, none::
+`off`::
+`none`::
 	Disable output of diffs for merge commits. Useful to override
 	implied value.
 
-on, m::
+`on`::
+`m`::
 	Make diff output for merge commits to be shown in the default
 	format. The default format can be changed using
 	`log.diffMerges` configuration variable, whose default value
 	is `separate`.
 
-first-parent, 1::
+`first-parent`::
+`1`::
 	Show full diff with respect to first parent. This is the same
 	format as `--patch` produces for non-merge commits.
 
-separate::
+`separate`::
 	Show full diff with respect to each of parents.
 	Separate log entry and diff is generated for each parent.
 
-combined, c::
+`combined`::
+`c`::
 	Show differences from each of the parents to the merge
 	result simultaneously instead of showing pairwise diff between
 	a parent and the result one at a time. Furthermore, it lists
 	only files which were modified from all parents.
 
-dense-combined, cc::
+`dense-combined`::
+`cc`::
 	Further compress output produced by `--diff-merges=combined`
 	by omitting uninteresting hunks whose contents in the parents
 	have only two variants and the merge result picks one of them
 	without modification.
 
-remerge, r::
-	Remerge two-parent merge commits to create a temporary tree
+`remerge`::
+`r`:: Remerge two-parent merge commits to create a temporary tree
 	object--potentially containing files with conflict markers
 	and such.  A diff is then shown between that temporary tree
 	and the actual merge commit.
+--
 +
 The output emitted when this option is used is subject to change, and
 so is its interaction with other options (unless explicitly
 documented).
---
 
---combined-all-paths::
+
+`--combined-all-paths`::
 	Cause combined diffs (used for merge commits) to
 	list the name of the file from all parents.  It thus only has
 	effect when `--diff-merges=[dense-]combined` is in use, and
-- 
gitgitgadget

