Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D28B2AE8B
	for <git@vger.kernel.org>; Sat, 14 Jun 2025 05:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749877440; cv=none; b=BRebyLl0vle0+9MdxQYijnRf5a/N+d2kBYXAT0nKJTGs6r7+QABryGCZXI/NcA1JF2M1rzfvdY8RnPZKNMCjIHN/SVxYfIkny2ezqhimtS9SHA7n2v+10I8fxGIR3LhecKsiFeoPfS/lfUHlCzd/ofH4zN/tODEd1PZ9jD6iz8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749877440; c=relaxed/simple;
	bh=5GxNPTECA9sFpYsjC3dO20+67reVQfPGmZ+QYm42WTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2yRs3mtSPO64U9PUhjDTC1wrO6VO5ygdKwhQVBQmP8ZHcWrAzU8jZnbvD6fXRsVzWp3RbdJW5hcfXZVC+K+U5aJr+GnbqGFA17sJaMEJOmNU9fkuatr2/a+AOZxgKcyWO/xP/1mraS1h5gFRXqa3LzvcZwQzO1nLwJuw7FdmhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bp07MgfZ; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bp07MgfZ"
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-6fac1c60e19so40784266d6.1
        for <git@vger.kernel.org>; Fri, 13 Jun 2025 22:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749877437; x=1750482237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tNL8cFitV2o/wsP1caXsDhg5Pl3qetuLFNEj/NPedw=;
        b=bp07MgfZ0XbYlhHar7pC2/lv5AjFQbXsiRkOhA/ihK4vEqVY7ZNEm45Rzzgj2ojPvi
         505eeacmTr4Fl4b6haKteA6pWYJRqjPNXJEGb9TE6EoFSxN9ZeqKnvRH6gCTTK5HQkbl
         lSGXz67ilJQf7gSIGpeOGyQBlTWCOi7+eBZT3JTjDhleAzPP8cESF3gOU7+3f6Yz8ZJM
         6H8HE4nyT+m83rCZmNcrRVClfarb7Evy11ZaD3+yLmtarbBdrv+xvRCU69GIcEVEQcmS
         haB0dNsdy6uXP9yazz7q/IurTbGnZ1OtVb6QvYBYkAuoNbv8hx8UB/aaYY/6J0F+WWVH
         xlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749877437; x=1750482237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tNL8cFitV2o/wsP1caXsDhg5Pl3qetuLFNEj/NPedw=;
        b=TZ0moXITjz0YfL/BnUC1HCPardi9W0ndbra45qmbggaChF1RifpR9e/16E/SU2biNO
         EdttPyZpV8Nr5eDzv8btThig9IS9+1aDCbKRvNtbVOmxEkn1EPb9NozkibEgybmBDNoE
         Mb8B5ut01Vn/huez1YfF3gOXrRMMJ9u/XJwJ4wAH2+/aSX5IWuX1fmTlMlSLyetznQT6
         tZzvQQPh0hAA1A4vb3C7rV4907TO4n4/Gnt4ysujxzNJBjJPpB3hXQUpmRbluPg2cQTr
         ZwPRPdkT/gC5+317UbljpE5clj67KRGxvWVlqmhla0kPeojDLKVeG/NK44THGDhyP2ql
         PYlA==
X-Gm-Message-State: AOJu0YxCMToxwO+SL0TahFUlyq63Uw8OHbfEnFM8M6h0h6ghKdo5vBwy
	+6xKa6y3H9yDKmk0Ob0XfujH0DnvO04H/cy3YRcEfTXbOHMstpEJu4VF8gGZ46fk9979tddh
X-Gm-Gg: ASbGncsTYSD8XWkUVORc5AFTCrGMDNbQr0rqJMmKD+bb/E4uuD+CfVV4/RSGEEu6Kj4
	tWRPSOWI0UZQdFtrR/IkF7UXpM+UJVHetRA6n8X4myRnrMdWAPc0PXnKPJ43dyo86jdpgDLRyZw
	T0iQAQmhGgQXB6tZftMsOgf/2UdFE61PkqNZZDkgpt+q5tb/v9q8x0Jt9b6eYiSf0IrCwoXxwd4
	NH8/u1Sq1ZN8tle/d03XSNGxkH2mcEJjQN+yN8ugKsYfhq30imCHTIoxoFyUvi/cQMLkgMKKs0K
	7QlRB9xRUDy4awVLmh1eMKtjhNQzwTBeitS+47Yt/5UulyWdimjZwMAE8SkjibWBAHMM
X-Google-Smtp-Source: AGHT+IG6jb8D0ALyZOLlApLhRlPPST9vl1ErY+zlAtYa3yK2tkBkG1VuGFzHL+dq5gauJ6+2kDTz8A==
X-Received: by 2002:a05:6214:767:b0:6fa:ee98:65b6 with SMTP id 6a1803df08f44-6fb46d4cfeamr35460016d6.4.1749877436736;
        Fri, 13 Jun 2025 22:03:56 -0700 (PDT)
Received: from r760 ([188.253.126.204])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35b3dd9csm29136356d6.50.2025.06.13.22.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 22:03:56 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
X-Google-Original-From: Lidong Yan <502024330056@smail.nju.edu.cn>
To: git@vger.kernel.org
Cc: 502024330056@smail.nju.edu.cn,
	ayu.chandekar@gmail.com,
	christian.couder@gmail.com,
	gitster@pobox.com,
	shyamthakkar001@gmail.com
Subject: [PATCH v2] git.c: remove the_repository dependence in run_builtin()
Date: Sat, 14 Jun 2025 13:03:31 +0800
Message-ID: <20250614050331.304405-1-502024330056@smail.nju.edu.cn>
X-Mailer: git-send-email 2.50.0-rc2
In-Reply-To: <20250612045905.3023227-1-502024330056@smail.nju.edu.cn>
References: <20250612045905.3023227-1-502024330056@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

run_builtin() takes a repo parameter, so the use of the_repository
is no longer necessary. Removed the usage of the_repository.

The comment preceding trace_repo_setup() was originally introduced
in commit a9ca8a85. Since get_git_dir() modifies global variables
such as git_dir and git_objects_dir which only valid when inside a git
repository. The intention of the comment was to emphasize that
get_git_dir() should not be called before confirming that the current
directory is indeed part of a git repository. However, get_git_dir()
has since been renamed to repo_get_git_dir(), and repo_get_git_dir()
no longer modifies the global the_repository state. As a result,
the original comment is no longer relevant and can be safely removed.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 git.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index 77c4359522..429ad1c2fb 100644
--- a/git.c
+++ b/git.c
@@ -462,12 +462,11 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
 	precompose_argv_prefix(argc, argv, NULL);
 	if (use_pager == -1 && run_setup &&
 		!(p->option & DELAY_PAGER_CONFIG))
-		use_pager = check_pager_config(the_repository, p->cmd);
+		use_pager = check_pager_config(repo, p->cmd);
 	if (use_pager == -1 && p->option & USE_PAGER)
 		use_pager = 1;
 	if (run_setup && startup_info->have_repository)
-		/* get_git_dir() may set up repo, avoid that */
-		trace_repo_setup(the_repository);
+		trace_repo_setup(repo);
 	commit_pager_choice();
 
 	if (!help && p->option & NEED_WORK_TREE)
-- 
2.50.0-rc2

