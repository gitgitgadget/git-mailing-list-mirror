Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADE92673AA
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 02:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770345128; cv=none; b=OaUsPolCm7ukqt5l7yka3AKuTwv1HTYu8cqCuko14e5D9n1HSSwE1bKD4POkT/992V07pQxaRI7IMI/oB9K+DRAip8L4MnxIat7WzYXx+9pNT3ifU8/nc+ojSdh4tfKBak9NNDirDg+4szbQe8tF20CzGNDPPyQjjQaF4N0C5WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770345128; c=relaxed/simple;
	bh=KoA6+UtHngIjx4EUDm3qqUEtdJczte7ep3zXpj5db0s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=merZqsHsqI47zQzgvTf9CqipIw6EQP2ebRZi9LxBiVCOciSh74vYZ8BDjDg/k7t4i9XrcNs2CTHvAeBGoZXWDUUATg/LNxF+j2Wi/3+cmOkDIFE3X8/YVYz71ybpDJuTab70xs4QHpR8setGaJFckEjXjvKS+u2QmdV7xdhAsVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/SdImze; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/SdImze"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b785801c93so644257eec.0
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 18:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770345127; x=1770949927; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Jvh9KsioJ9wPweAdU3pfAswUCRZKcZ6z2a4xdIIhZA=;
        b=V/SdImze3SJFRpckvdGgDvo65vfPJ/T/iLbP0BOIrZaQBecvtYYZeWoo+zF0ngBdZO
         OqlDZ57IFW/JaGNaoNEHZaZ6imIlh4XLA0itOK4OcRUij6kfYE2C90fEq/Nzg/K+p3ez
         nFRKCDi0zaMcernuf5dQVsvPORFMPxmBbK4i1BvsLg9/X64tZg6HoTIYaJ/h1QV4m2gH
         imJRSelOJkiTm3GZudl4H9fTpul/2gL6zjAt/1TJ86SQ7hAEsBLyJjS5H5mP1b2oLaiD
         F58BpFQjUfuVAVAt533SW7ULRls2BToT+49Owb/BR7o9n7RxguFSmhm2OIcaenR1Q/k9
         DGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770345127; x=1770949927;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Jvh9KsioJ9wPweAdU3pfAswUCRZKcZ6z2a4xdIIhZA=;
        b=MoA4f0BEBDidO0YElKPnYymZhUqweX/tG/f3v1+Ch+O98xzshxiRjUHJr/j/2qik2S
         5HkBYA7PXeZrp/2ua+1VGPtaTPzdhTuCtJMFCy95A4R6m8pvTlKE8bT2T2tfF0nzNcW0
         lzVdZKu3C148T2E+k1YbnvjWbz7e7IgGdfqwKnY7+E3fZjfULWbJ2P1FU44UdPcFzjPe
         LLQdCsiyImBrWevLJBhqen9Zz9nz1yKSLeoTHBRqVX8bL0HQhRX4YJcEofKLCd2Id7il
         Djc3+0YTAiZMsw1Vl4eZLnGRi/KldWTO6hBvVB+P3o+sFegvivnHj7oEOk/a/mQWrYYx
         31Jw==
X-Gm-Message-State: AOJu0YxTu3RW2S3ruKkOTk3edjLdXwNrF/M3YZDQoS78Kd3YEPpOV2KJ
	JZFPeNbmWR3+tYi+8NTSnd25GtwyfkA8us5+BnnizdkkXtOsyxWqGI/bQCMCDpR+
X-Gm-Gg: AZuq6aKhxaRKPa93Q8i3QUTRiO/zfLC2qRYUOO0A5PFWGVawhatrfvyWrLsG7+o9rSC
	8V1ZIwj7o/6kpyiA2kXzaWItPO22a7UESzR7ZHG/qdTvjCiW+ArnHrf4btxf66NZD3MjALlj8VP
	BZ2nGhTALF5m8AOztdEa/ilPQb0rstaA+RQ3yqO6K9FBZFZrzoUXv+8OM2m8XyWV05yqzE795KI
	oKD+Hm1PmjzK1lx625Hjnffe/ow2Xt4eV8Fv5uC4uXkwmNmmx2e2FjtKGRNW9RJVfBZM8iBOgr+
	PZ+rvgX/IoLNrm5i6y0Pyw5RU9NAgWc3zJPrt1J5ySt+GX0yfMWj1bIvfJKn8w+w1IPGAlvByTh
	nXolFlVCV/hXGx7ccJT5DCicx/TJr2XnCfz/tueKxyjglMqf4+5sMewci+b+CJCPax8iw6UE9PA
	0ZQ+qF/4X5F2KEgcH3k+I+
X-Received: by 2002:a05:693c:37c7:b0:2b7:97a:75fb with SMTP id 5a478bee46e88-2b856484a62mr529951eec.11.1770345127010;
        Thu, 05 Feb 2026 18:32:07 -0800 (PST)
Received: from [127.0.0.1] ([20.163.4.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855c89695sm820279eec.31.2026.02.05.18.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 18:32:06 -0800 (PST)
Message-Id: <6cb970e512c02f0db11b8aae247aaa1675b31ef0.1770345124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2189.git.git.1770345124.gitgitgadget@gmail.com>
References: <pull.2189.git.git.1770345124.gitgitgadget@gmail.com>
From: "Sam Bostock via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Feb 2026 02:32:03 +0000
Subject: [PATCH 1/2] merge-ours: drop USE_THE_REPOSITORY_VARIABLE
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
Cc: Sam Bostock <sam@sambostock.ca>,
    Sam Bostock <sam@sambostock.ca>

From: Sam Bostock <sam@sambostock.ca>

Use the `repo` parameter passed to cmd_merge_ours() instead of
`the_repository`, and drop the USE_THE_REPOSITORY_VARIABLE macro that
is no longer needed.

While at it, remove a stray double blank line between the #include
block and the usage string.

Signed-off-by: Sam Bostock <sam@sambostock.ca>
---
 builtin/merge-ours.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index 97b8a792c7..2312e58ab3 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -8,20 +8,17 @@
  * Pretend we resolved the heads, but declare our tree trumps everybody else.
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "builtin.h"
 #include "diff.h"
 
-
 static const char builtin_merge_ours_usage[] =
 	"git merge-ours <base>... -- HEAD <remote>...";
 
 int cmd_merge_ours(int argc,
 		   const char **argv,
 		   const char *prefix UNUSED,
-		   struct repository *repo UNUSED)
+		   struct repository *repo)
 {
 	show_usage_if_asked(argc, argv, builtin_merge_ours_usage);
 
@@ -30,9 +27,9 @@ int cmd_merge_ours(int argc,
 	 * commit.  The index must match HEAD, or this merge cannot go
 	 * through.
 	 */
-	if (repo_read_index(the_repository) < 0)
+	if (repo_read_index(repo) < 0)
 		die_errno("read_cache failed");
-	if (index_differs_from(the_repository, "HEAD", NULL, 0))
+	if (index_differs_from(repo, "HEAD", NULL, 0))
 		return 2;
 	return 0;
 }
-- 
gitgitgadget

