Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F4130AAB3
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 19:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770405389; cv=none; b=eOnO9oqoAPpJ8L/0k4E0PblBBR5a/NzQj0AjwIZsVaZYuJDgCQlYhOFmTp0tOiDJc0pFyRDL2TsaIK2UokBnwzeTEpCK8qNoXfv6EDMbilPZRjaHroE0k3HeOjT2wvGNBL1zCeNzXQbbbX4j1JaYrKJsu52vEK6pGvc80z6GQ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770405389; c=relaxed/simple;
	bh=Zb/DozarSfBOXIVRx/zRg7Wb8l3ZEEExejnpHwWh9EY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DqfvtN4z5jAiPvhJTDorGGP+a7WduMQk7Y1gOrFQKnuRAiub7J+P/IQ6H0aZBRxXqIKt8/sBQCEnHMOpB0jrPH5FEItG8Ogep8nig1FjaBsMom7nLGVLuM3fmY8UNBA7DpuHM9SWusBJk5kcl4rWlpVZAWaZfTtXcz7+c962Ptg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNXt9lQX; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNXt9lQX"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12336c0a8b6so462656c88.1
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 11:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770405388; x=1771010188; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGiMUTluyQoMxhUd4Xv12g9uPJpVkw7QhojodMoI6PA=;
        b=YNXt9lQXV9bHBMVf/9qOn3OFeJbQh4BvJi3qOdcTbwLCBmRcqbXnrKK3pR1XwduEKG
         1xqr3ct445WZ8vkWj/zMQ4EzCGHHkpJtjeH2V7kkFpmZjn++I1opVDTRSgdMTQ8MVPCT
         ad+Mg3fguJLAq3JUHkB4tBY+A4EtRcYECVfsfj4c/rqpOihlhZduu/JLGlN8CR5JU04l
         2UQf1AZ0aGSwtiEQvifcZgA4BSFzFTW1hdXO2YAIxKlItBopGKuAZ6VciXipvVpCsg0y
         OtGIAlfHzS5+LaVuORcMeN453INI5n2weyvbJBe5pfk00JSQohRxekVwwr1kNN5nimKc
         6LdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770405388; x=1771010188;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AGiMUTluyQoMxhUd4Xv12g9uPJpVkw7QhojodMoI6PA=;
        b=pyQaYV8nqfrXs+X86OspZFrCBimTHABb+wmNbPYPxPZww4zUNF91ds9vMr/B0CKlP2
         kGZP7KhKGFFNStN8vwg/McAkUxFzw7sKC802Em+kCjQ8B3uy0q2KRSNqmyGZlslh7UBm
         c6JqmsTWWe6Cdkz+dwOqFumtCnxl9h7Cwq1T880YOpSrhySUG15Ks2chtGJmUwkIi+Wq
         yxn+Ft9DqK47cotVnA8JP0WFBL1laHNL3TyskUnPGJSs5GEfRU9wwnURq0KoYEH2A7eJ
         NzZHBZ20ojUJ2P+k00Dey41mnrHq8+Su79N1a2C9mLxwCLhMKmNQjNWdUJHuopaJDSxT
         +wXA==
X-Gm-Message-State: AOJu0YwdyP1756A5p36J+rszyyhBrXKSp0lZbY7NqaIDobZwLzPSGA4e
	rCPWYdZMoEgEGDhNoLxVjP/uE5+qTk+dKpbv/068A7hESIWRms4Om0Ty5zBdjA==
X-Gm-Gg: AZuq6aK9HpX6uRmVoCSXXWhs/3zPzS0aVw5IzcCeJ2fYQqQWpPE6Wpg3S7YzKP2ySAS
	p71dUoPzwKHq+L9pkcQ+g2jV6n3qScDs6mNmG9CRBhV/kFcJXL+mMPrXqv69J8SnGWbU0KW31p0
	MbrVjd2YInLzoPZYO3yk3RFFblxGMg0eXKoY29iqD9J/G8umJSOj8bi0H0LGVW4GGnTvHonklnl
	FUarNiHsYYw4O9do8JIvBGrCXayJ5dDIt7/khN4qXqDTLxEfB/61LP4185Lge84cppxIfzvcA9b
	KqH9udmPss7IZFLN7vnaWI05688EVodgDpQ56sPFTi4WbAsN5WnRKymYZaZli1/ABATU+3SOF8B
	qdVetpvd4Tzu5OcaItgu5F8jt+zhISv6sCWwID1v0GWnmFQI0eeYSGgGV3aFkHq1V891sko1mMK
	kbmQWrNzjCA83m4Q==
X-Received: by 2002:a05:693c:2288:b0:2ae:5ffa:8da4 with SMTP id 5a478bee46e88-2b8563d93c7mr1777267eec.1.1770405386561;
        Fri, 06 Feb 2026 11:16:26 -0800 (PST)
Received: from [127.0.0.1] ([172.182.209.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855c63152sm2258673eec.25.2026.02.06.11.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 11:16:26 -0800 (PST)
Message-Id: <775d76df69c118e0dbf24522eb3e75f58d6e9240.1770405383.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2189.v2.git.git.1770405383.gitgitgadget@gmail.com>
References: <pull.2189.git.git.1770345124.gitgitgadget@gmail.com>
	<pull.2189.v2.git.git.1770405383.gitgitgadget@gmail.com>
From: "Sam Bostock via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Feb 2026 19:16:22 +0000
Subject: [PATCH v2 1/2] merge-ours: drop USE_THE_REPOSITORY_VARIABLE
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
    Sam Bostock <sam@sambostock.ca>,
    Sam Bostock <sam@sambostock.ca>

From: Sam Bostock <sam@sambostock.ca>

The merge-ours built-in uses the `the_repository` global to access
the repository. The project is moving away from this global in favor
of the `repo` parameter that is passed to each built-in command.
Since merge-ours is registered with RUN_SETUP, `repo` is guaranteed
to be non-NULL and can be used directly.

Drop the USE_THE_REPOSITORY_VARIABLE macro and use `repo` throughout.

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

