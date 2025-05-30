Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB4E176242
	for <git@vger.kernel.org>; Fri, 30 May 2025 01:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748569962; cv=none; b=Cuf41Ce634oCoT4vZ9Dm2vlJeHdy9svX9h15meSoiExr33P9q/h0MJUApVDFMLjv4eoapCC46DgMhaXg5FeFdRA1sH0K/9vBOqyqwRkSslmuVbx8jsrMysItGrpSjbXGTI4l5/FVBEI9pFFq5cKV4GGdT3XvCQkJ2j3yI9hOWmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748569962; c=relaxed/simple;
	bh=krYpRGeVvhTNZN2wj1NK8a9CRn511KIPCmsXtyPe6z0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MGNzjYEzkeqe3tACQL1KJqEij3yak18KG0awopT3bMLU1WdOH2ZQzXr94/5Y2Gi48Mdy6QJsbwtuC7ddqhsLsG5/rOba1GfRDHrDTOr0pUjJU0kcNLBUjpt+GgcOa0UMjX5Txig7UIH9CrqZCxMt3JHsMHySA0u9JdMIPV9u5dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIqxCMVo; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIqxCMVo"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a363d15c64so994254f8f.3
        for <git@vger.kernel.org>; Thu, 29 May 2025 18:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748569958; x=1749174758; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mL/DVZucnMQSkj3zXMJDKrwmBcUNx92KT/fxErBbAPk=;
        b=mIqxCMVoov1tJAlv660xRpxz+d3vEZH/ZsTzj2W2bW3OsBsdHEHg9Tww1aZEd8MOUG
         Rk04pNynMFM+NkW068uEWUQ4J3+jEskabGbgSSLMl5WOEEKMuj2xi5TU27RKfEN/mFz9
         Ue70yj7WVZwQsqkYgJmMKfjo/awB1Vaea5nHeudYtGhTuHcn6AkH9URGXFVSbHuBtF1Z
         04Pyn2ct0ISP8t8qNPaOQLeedc05nG36Gb+a2x6LXGtwaIJhxDXP81eZkVoWSloQUMIp
         1kdQdojq93epUX0nTJqb4bVPHtA2GQeNUlcQQ0fU2y02u+sj3ptQddYYrOOVybHLqMxL
         aKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748569958; x=1749174758;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mL/DVZucnMQSkj3zXMJDKrwmBcUNx92KT/fxErBbAPk=;
        b=sc9pUwgwxba4MzVOBeDEJcBjRpUPocBRR0A79NmPxz9F16ZA1ou4PskMFwPB72IwMm
         52NC0YyYYQPnGzGwuTpsQTD43s2XNeA3Tj4nsRfJhMDZe+miCsHjwoGbYTy6IDE+Yblu
         92Hu8On0mCuq6G0trA+mLmmeRoLHqRUAwU6OeqWR9d7iw9/FJl2AIdZjTSe0+8NA2MHp
         F1Ogv6F2QbYnNffkQLHQJ+i+hdTvaeQGLSpROmhz01hvAJ9rIhJ7u6ObZFGcvgVu+LPJ
         5VfY9eC45MLG0A/MhvBR44Cc13DMDJaNJrxP4zcmMj8YwFXurUh1S7bL0+FBIyBPX/c9
         i1gQ==
X-Gm-Message-State: AOJu0YwjPTEojBpKe3lMPkHjYtpao1FJ5Ofafeu2Fo/8Q6tQiDkQElAZ
	SXP8a46ctlp/ABquJEBYX45eQyWX/e1cxcLYk3WQL0YRSB9u/wvnfvBmuz7DKA==
X-Gm-Gg: ASbGncuiA0SofD8eUPPlpuweG+WFpaE1jNAz1sEuslGl0W7HjfSnaB0qidr9TxOBU/C
	CZPWP9AKlVlv6olxZYfKnINYSZk3yZxwpagH8vR8c6n0YTinrqN8MJoMI/5ppq6+jJ/qXXRPdBh
	8dH/BhQ96Udj2W3rwUX564hjiW+wcvmXZ7d+gZsncgSA5ufzKhEC0V3fWstvT79GKHB5bAO0rsL
	DzAOjcL0FxR1gk2Y2rPdYDd48MWFLHuJb5mMBFO7M0k1X9xBZOoQqahj3oyi1g6U+rqFjBd/cG7
	7mgMfGiMRklDH7PTQAfJe/280M56ukyHet+qmhQlCAzrbadzwCxy
X-Google-Smtp-Source: AGHT+IG54pZaiGKvbDw28T05/31RXYq2dfCpbM4MIP4xmXscyWqgonnM7PwOYxeMgIw4SH/ML1mGaQ==
X-Received: by 2002:a05:6000:26d0:b0:3a4:e6c6:b8b1 with SMTP id ffacd0b85a97d-3a4f7a1bfa4mr893723f8f.17.1748569958281;
        Thu, 29 May 2025 18:52:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe74072sm3581998f8f.52.2025.05.29.18.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 18:52:37 -0700 (PDT)
Message-Id: <e1f84c111f6b4b5d34201ee8858a8007ea898222.1748569955.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v3.git.git.1748569955.gitgitgadget@gmail.com>
References: <pull.1964.v2.git.git.1748168353204.gitgitgadget@gmail.com>
	<pull.1964.v3.git.git.1748569955.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 30 May 2025 01:52:35 +0000
Subject: [PATCH v3 2/2] BUG(): remove leading underscore of the format string
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
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

BUG() is not end-user facing but programmer facing, and we do not
use _("...") in them. I searched all `BUG(_` pattern and replace
them with `BUG(`

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 builtin/mktag.c     | 2 +-
 builtin/worktree.c  | 2 +-
 pack-bitmap-write.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index 7ac11c46d53f..1b1dc0263e18 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -41,7 +41,7 @@ static int mktag_fsck_error_func(struct fsck_options *o UNUSED,
 		fprintf_ln(stderr, _("error: tag input does not pass fsck: %s"), message);
 		return 1;
 	default:
-		BUG(_("%d (FSCK_IGNORE?) should never trigger this callback"),
+		BUG("%d (FSCK_IGNORE?) should never trigger this callback",
 		    msg_type);
 	}
 }
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 88a36ea9f867..2dceeeed8bd0 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -621,7 +621,7 @@ static void print_preparing_worktree_line(int detach,
 		else {
 			struct commit *commit = lookup_commit_reference_by_name(branch);
 			if (!commit)
-				BUG(_("unreachable: invalid reference: %s"), branch);
+				BUG("unreachable: invalid reference: %s", branch);
 			fprintf_ln(stderr, _("Preparing worktree (detached HEAD %s)"),
 				  repo_find_unique_abbrev(the_repository, &commit->object.oid, DEFAULT_ABBREV));
 		}
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 7f400ee01213..56960e6ad760 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -1087,7 +1087,7 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
 					 oid_access);
 
 		if (commit_pos < 0)
-			BUG(_("trying to write commit not in index"));
+			BUG("trying to write commit not in index");
 		stored->commit_pos = commit_pos + base_objects;
 	}
 
-- 
gitgitgadget
