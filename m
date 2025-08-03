Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FD82E36EB
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 02:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754186876; cv=none; b=S+jv6RzjzbhVI0UEOUHkE31gFEOzYUwpiNAPiquJ1wQHfBNPr6DfpToaxSup532nSLrMrCpXxqsjY9m7WDmV1E6j3Dd1vNtxqumG/t1y1VBk5Np5nCdLfjV8nni9KUIFqu0llEtsr0Rt0k1WECxSwC9wQDhDrx3uj8u3WaIUAtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754186876; c=relaxed/simple;
	bh=gw4fAzRBqrtBI0A5pjd0NpY5Yyhx5PKg54U3lCVqVQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuepgQmGVtYuOO/zeoRBP/8xpDvYS4YDUhdnJHXvU98Q4/m0/p+9+sZTpV3HimLsMN3bDAiM8FRYvfEBwk9l2r977iQQtSFTOSAdPse2uyVpyDtLENFG/FNrhApFkvJCqGVAAZftg1S3oR+MaoL6lP2flEBXQLWU+fWULGHBf60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIyN34Rr; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIyN34Rr"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76bc68cc9e4so2770074b3a.2
        for <git@vger.kernel.org>; Sat, 02 Aug 2025 19:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754186874; x=1754791674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AW8XK2E3rm2gDM4ORwq+1xeD9iq/zZUlZbhAjIlAN1k=;
        b=DIyN34RrEErSDoyZNq0hQw70mthu76SxFYL1h/9S7lsZuAjVwccpBtsjNArqE/nMnE
         yukDKMnBxAe3Cvn0i/9t23b5eAQHplgECy/WErQFkXYTsAlIIJVIGr534VUZdG5CS1r2
         JCCNUoNcOpa7bGe+IvNgA5fXC/GBw2BXEGOTqW5M6dCF7nS0nZnrvG8YdVdg8LfXUB2R
         IhlULcNRYc6JnpYeeuQBXFi+MZ7wxLThOwfebteg/F4iKqFFL1RXdC6chcoIJuL0TQF2
         sK2Ne9W7R0FvMajixySoWXhpB43ly8/PlNKCRYxQhB2McA4YszAbFlU45d8mSWeXuDSw
         GC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754186874; x=1754791674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AW8XK2E3rm2gDM4ORwq+1xeD9iq/zZUlZbhAjIlAN1k=;
        b=v4mas7iWctSaz++PG8Kh/641FnTly+ZjHgGoG7e8P0tZMLLNGlV+80hUrK/DQCi5Q/
         nDJSdJnx1P4gQPbZbcglsHMVwXM8uarf4Kf2bjLS5QNGFY2qP624p4BMA0Y0RWyStPRY
         LIRffpSoF0i01bd9vCn+Z9Z54vGVPtKwRnNNjmzx2Dakh0vBBZ8mzhFoeWRZjhuitiSM
         Bt4Ts8tOcyngsE8M2mvyVm8o/3HlL57LqmvBh+64cI+KjWA/KIlJpFbY6s5R8djr9Fkk
         JKlUhP/apJ8FcI5twE2yZiVgBeprRAdvOcxcYjIeqj4a4v+MyWvJ0XaTo5qpq/VgiLDq
         MMNg==
X-Forwarded-Encrypted: i=1; AJvYcCU4RxH/q39eU/owjZErdPUULve8Vcr6Upv17osxE71ANwTT0r1IQ7GNeojU5xvx3a48X5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY7eYZbDVEyLA/E5yMpIZVk3GlSiErcIxD1kkBlTx6It2wpnot
	hpxakqiS3UW4x0e4SbPPdBDAtZrMHQ/IXIvY94fEYHJx4G18PvgZf9VZ
X-Gm-Gg: ASbGncu39s9DI6wvsnmhdALdJyxOrueOfXpDulhbsVoY8iuE1P6NLJGg7ORj921LTR7
	D1Qm2/Df00XH4bGyvFs4QpEIDQKNMt/YutwKWe/6MxB9zSGHMJrvBuY08nzhFnSx/RBaMZNhknd
	oPhy9RHX2FWTutEokW3D/N5EeBCUGvGraWNEPk2htuztIW66t4GR87N1LbpA/uJ0+ipKzjCUFn+
	gEesK/duYStYWx9suPrmhv58tbd7UKGfXgHRS7IGiOw8t3pIk66lNCtJ6jV29WeBsKenPVWltX0
	YTtcmWyULXwx1rtPcS64G7wf3Ai5HfOIPsamIvese9a5hTN2tkD4mA3KTlYKThsOSC2Ly9yPOyW
	n6Bc83jXvdXYqjmebdrpIfZjZXDb7QYc5gzgR/1lHBiPB+j5o7TQ=
X-Google-Smtp-Source: AGHT+IEBTBqf+gzHKt9J89A2AVxJcT5o+ff9a5saET9vzIeHXLb+EpQkDj2DhTXPQNoGvVTG52ktXg==
X-Received: by 2002:a05:6a21:3297:b0:23d:dad9:50d1 with SMTP id adf61e73a8af0-23df8f94a3cmr7391002637.7.1754186874290;
        Sat, 02 Aug 2025 19:07:54 -0700 (PDT)
Received: from archlinux.tail6959dd.ts.net ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b77f530sm6466535a12.1.2025.08.02.19.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 19:07:53 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: ben.knoble@gmail.com,
	git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	ps@pks.im,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: [PATCH V5 1/3] t/t1517: automate `git subcmd -h` tests outside a repository
Date: Sun,  3 Aug 2025 07:37:42 +0530
Message-ID: <20250803020744.1037392-2-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250803020744.1037392-1-usmanakinyemi202@gmail.com>
References: <20250721115519.140361-1-usmanakinyemi202@gmail.com>
 <20250803020744.1037392-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual `-h` tests with a loop over all subcommands using
`git --list-cmds=main`. This ensures consistent coverage of `-h`
behavior outside a repo and future-proofs the test by covering
new commands automatically.

Known exceptions are skipped or marked as expected failures.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: D. Ben Knoble <ben.knoble+github@gmail.com>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t1517-outside-repo.sh | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 8f59b867f2..4a827b96f0 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -109,8 +109,6 @@ test_expect_success LIBCURL 'remote-http outside repository' '
 
 test_expect_success 'update-server-info does not crash with -h' '
 	test_expect_code 129 git update-server-info -h >usage &&
-	test_grep "[Uu]sage: git update-server-info " usage &&
-	test_expect_code 129 nongit git update-server-info -h >usage &&
 	test_grep "[Uu]sage: git update-server-info " usage
 '
 
@@ -120,5 +118,26 @@ test_expect_success 'prune does not crash with -h' '
 	test_expect_code 129 nongit git prune -h >usage &&
 	test_grep "[Uu]sage: git prune " usage
 '
+for cmd in $(git --list-cmds=main)
+do
+	cmd=${cmd%.*} # strip .sh, .perl, etc.
+	case "$cmd" in
+	archimport | cvsexportcommit | cvsimport | cvsserver | daemon | \
+	difftool--helper | filter-branch | fsck-objects | get-tar-commit-id | \
+	http-backend | http-fetch | http-push | init-db | \
+	merge-octopus | merge-one-file | merge-resolve | mergetool | \
+	mktag | p4 | p4.py | pickaxe | remote-ftp | remote-ftps | \
+	remote-http | remote-https | replay | send-email | \
+	sh-i18n--envsubst | shell | show | stage | submodule | svn | \
+	upload-archive--writer | upload-pack | web--browse | whatchanged)
+		expect_outcome=expect_failure ;;
+	*)
+		expect_outcome=expect_success ;;
+	esac
+	test_$expect_outcome "'git $cmd -h' outside a repository" '
+		test_expect_code 129 nongit git $cmd -h >usage &&
+		test_grep "[Uu]sage: git $cmd " usage
+	'
+done
 
 test_done
-- 
2.50.1

