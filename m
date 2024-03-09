Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C383FB9F
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709993404; cv=none; b=eu2N/tfw7PmFqOd/hZ8Tbp2w4l1bfmeVBTDyShzeoKMB6mJuwqgBuKPl1zHOFftLCBrFFSOvkOerhFHRiQtHpb+bhMs09Ee+sN1R9eBQAzbinKOdpUpLCDrSC4KQ5b6arJDAdbS6nIcpsvC1LNJ76Bu3qlwPm167PZsFmhZxxSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709993404; c=relaxed/simple;
	bh=AcC5u0CLkdWbvgPTiNVUVMXUJnVHgXaUCe3xSbA3aEU=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PScKp3hGHRStxdXysdVy/izBF9QElci4GTt0h6daHoJ9rkYbteAFaS5hHRNFFX7hxMKtB8ImNR/O6b/xJ0BdZcXNeCRPdD+2z9kaiL6jwO62baEQMUdXltDdoC1I83dtO5uS+dT1EtOEjqEFbmlCn/K+duTj7UoRrOIN6Kvg1Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJIveOdA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJIveOdA"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33e122c8598so1721595f8f.1
        for <git@vger.kernel.org>; Sat, 09 Mar 2024 06:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709993401; x=1710598201; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fr9R9PlfGVK0QEl+2r1YdUuMptAs1gVr7g+Y5rhvAyM=;
        b=DJIveOdAFB3islNLuUh+lzu7WIa/c9nqEStRStT8Bl/OqONJybg7U/UMJc2CI4dZQV
         BEZIRnqPhU+mMoQWBoGl/L8mKbX2ExR2JdHViEcr9JImVQWCsa3R+j5qzAQ6NTfDhA4u
         Y0zhcTsQbcuLACHzIPJbJH+jz0ZN12yjUXthUXVE0oNf24oPl5y5WmUOXKd+U6L/766k
         /6cRF+1RB+f0B8BrO/+wxrRYoWBolFbNz7rOFypm5Shin0TJaKf4xcGsoM4U3cUSnu64
         /EwXNGW23a3o9ZL+Qx8COtVOjb+SRsDAG/ZI4AKv57zHiS3+j39abI1+MQ/Gizk9lcqt
         yQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709993401; x=1710598201;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fr9R9PlfGVK0QEl+2r1YdUuMptAs1gVr7g+Y5rhvAyM=;
        b=TC/SLv+7vAGiXRCYg6vAQCuncD2r56xOhudH9OIct2SLuAGyjfqPotjE5ggg9nheN8
         sZPnrY+EH0BxkW0gQKb0k60aIAe5abIj1mjUCooEB1MhjRMCjMndvgCorrHITl0CS1Mv
         wA1kd01O3SNwFyLIp0pQidmTj6bvnPyIgh16TGK9AqmJ9isqLAMh9D6X3aLopWbHoKzd
         6V2NmFlMlepgp3EWGO+b9XU2FrbyPPIsEiCdujrIN5qWoPK6amNx8weztVkAK65zS22T
         mTQmcn9yCSFJvqGrNkZwH71Kz4BgkcvZI5mzoqUURe8uihmsqm6tCB4TUPS9iqMZEgx+
         p+Aw==
X-Gm-Message-State: AOJu0YxnI+lD+/ye7Mw+ri71Jtv4MqJ97qytyOpeNflGIBv8Pz4ejVm6
	otnahmLSPy4ejZB6EgXhiA9r5e4Grf9bWF0xxPb/qfS9hklPVsuGHPF1bXso
X-Google-Smtp-Source: AGHT+IFr7tpUFGiueebyZAx/Y+QIQm1MtunjSly9TGqQMvsm6wAD10hzXCY35PZQZ4YPUTY5SAWtvg==
X-Received: by 2002:a5d:584a:0:b0:33e:cc6:e6b5 with SMTP id i10-20020a5d584a000000b0033e0cc6e6b5mr1658085wrf.23.1709993401097;
        Sat, 09 Mar 2024 06:10:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c17-20020a5d5291000000b0033d2ae84fafsm1918914wrv.52.2024.03.09.06.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 06:10:00 -0800 (PST)
Message-ID: <50fe1a26515c06afec5ac7fb723727e1365a14fc.1709993397.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1686.git.1709993397.gitgitgadget@gmail.com>
References: <pull.1686.git.1709993397.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 09 Mar 2024 14:09:57 +0000
Subject: [PATCH 2/2] merge-ort/merge-recursive: do report errors in
 `merge_submodule()`
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
    Dirk Gouders <dirk@gouders.net>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 24876ebf68b (commit-reach(repo_in_merge_bases_many): report missing
commits, 2024-02-28), I taught `merge_submodule()` to handle errors
reported by `repo_in_merge_bases_many()`.

However, those errors were not passed through to the callers. That was
unintentional, and this commit remedies that.

Note that `find_first_merges()` can now also return -1 (because it
passes through that return value from `repo_in_merge_bases()`), and this
commit also adds the forgotten handling for that scenario.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-ort.c       | 5 +++++
 merge-recursive.c | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 033c4348e2d..5d36c04f509 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1819,6 +1819,7 @@ static int merge_submodule(struct merge_options *opt,
 			 _("Failed to merge submodule %s "
 			   "(repository corrupt)"),
 			 path);
+		ret = -1;
 		goto cleanup;
 	}
 	if (ret2 > 0)
@@ -1829,6 +1830,7 @@ static int merge_submodule(struct merge_options *opt,
 			 _("Failed to merge submodule %s "
 			   "(repository corrupt)"),
 			 path);
+		ret = -1;
 		goto cleanup;
 	}
 	if (!ret2) {
@@ -1848,6 +1850,7 @@ static int merge_submodule(struct merge_options *opt,
 			 _("Failed to merge submodule %s "
 			   "(repository corrupt)"),
 			 path);
+		ret = -1;
 		goto cleanup;
 	}
 	if (ret2 > 0) {
@@ -1866,6 +1869,7 @@ static int merge_submodule(struct merge_options *opt,
 			 _("Failed to merge submodule %s "
 			   "(repository corrupt)"),
 			 path);
+		ret = -1;
 		goto cleanup;
 	}
 	if (ret2 > 0) {
@@ -1899,6 +1903,7 @@ static int merge_submodule(struct merge_options *opt,
 			 _("Failed to merge submodule %s "
 			   "(repository corrupt)"),
 			 path);
+		ret = -1;
 		break;
 	case 0:
 		path_msg(opt, CONFLICT_SUBMODULE_FAILED_TO_MERGE, 0,
diff --git a/merge-recursive.c b/merge-recursive.c
index f3132a9ecae..fc772c2b113 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1246,12 +1246,14 @@ static int merge_submodule(struct merge_options *opt,
 	ret2 = repo_in_merge_bases(&subrepo, commit_base, commit_a);
 	if (ret2 < 0) {
 		output(opt, 1, _("Failed to merge submodule %s (repository corrupt)"), path);
+		ret = -1;
 		goto cleanup;
 	}
 	if (ret2 > 0)
 		ret2 = repo_in_merge_bases(&subrepo, commit_base, commit_b);
 	if (ret2 < 0) {
 		output(opt, 1, _("Failed to merge submodule %s (repository corrupt)"), path);
+		ret = -1;
 		goto cleanup;
 	}
 	if (!ret2) {
@@ -1263,6 +1265,7 @@ static int merge_submodule(struct merge_options *opt,
 	ret2 = repo_in_merge_bases(&subrepo, commit_a, commit_b);
 	if (ret2 < 0) {
 		output(opt, 1, _("Failed to merge submodule %s (repository corrupt)"), path);
+		ret = -1;
 		goto cleanup;
 	}
 	if (ret2) {
@@ -1281,6 +1284,7 @@ static int merge_submodule(struct merge_options *opt,
 	ret2 = repo_in_merge_bases(&subrepo, commit_b, commit_a);
 	if (ret2 < 0) {
 		output(opt, 1, _("Failed to merge submodule %s (repository corrupt)"), path);
+		ret = -1;
 		goto cleanup;
 	}
 	if (ret2) {
@@ -1312,6 +1316,10 @@ static int merge_submodule(struct merge_options *opt,
 	parent_count = find_first_merges(&subrepo, &merges, path,
 					 commit_a, commit_b);
 	switch (parent_count) {
+	case -1:
+		output(opt, 1,_("Failed to merge submodule %s (repository corrupt)"), path);
+		ret = -1;
+		break;
 	case 0:
 		output(opt, 1, _("Failed to merge submodule %s (merge following commits not found)"), path);
 		break;
-- 
gitgitgadget
