Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B5C441037
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207345; cv=none; b=TC1kvLLRTbMdvMPRbbKE7C4VnNaBPQJduj/hs/ns2qSEiT3HQsC8RfqBhKgqoZYmA50BGavlpcohwc2VcTiVEB3aKnUVBj+jhR3JbUd3Vkccsnqh+elRLYADSVCZdadx9eQ3wzcUX8waPr7dAWXd6xvuguC9PQiSrD6nTm0Wl3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207345; c=relaxed/simple;
	bh=9dNV6hFMvyvuEgAXQGVAceK4FFDMsR0BQAi+YSKtb3c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=S5HQiX7oiNYkIh/lwsGut5NenHBxhEqrfblvr5N4sS3Mlh5tnSLddiU/r42ZvcUOBh14W8Yhke7Qzg0AHBWFGwywAGYvid7ubAgxA2OU5bKOIaSoFMtLwcDmTnzMJigREHC3ChC+o/+Bqrx1ZRR3qKXUzIAQuPMqg8GZ3bzto0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQngWBR4; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQngWBR4"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12732165d1eso2382272c88.1
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 07:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772207338; x=1772812138; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2cy6pW4qHDE64qChk6jMeSmLC3yVriN1Ux0ctWCPyk=;
        b=PQngWBR4w4AKW+BSBjTo0VfUiJKgN5AnUcBpDjaAlHePqr1yW9nR/UqBTPc3mrij+x
         a90j1su3INeUTn8nRBeQsn++X/hm3P8a2kmwaDlGJjRqTZ39eaFgPpHbaVSK69QZ5KfP
         alfsN0W+aYbP7kI7ZjMIOF/hUSd2rnMc6SjcsKana/2Khg4zRSvJG5hiSHCzz5GhRzQl
         dB3i/bu/xsDYcw9fx4o+/YJoASsGzO5MJnUTPP/sfdfKg48IQIzJJKexFuEUQeddMtqi
         GljxOeXavxOd68cpw3l9r0iGkpfFoPJ3wuz50oPiTJPAO7XSqcfEoNLb4/xcHbwI5fyG
         B9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772207338; x=1772812138;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O2cy6pW4qHDE64qChk6jMeSmLC3yVriN1Ux0ctWCPyk=;
        b=OZLajak65OsmOtGEmdSfpYDBxVICZykbHYo1NfKO6NRQ4vvVzSRdKYOJKAbkd2YpDi
         NxyfHR7DGbPuIJYu6SsljgIcotoa5YugijpQoiHcpbTWsG1keZcdJWAi8V6OsfeXlYbi
         4ZZRO1wJXJHQFfFPYMohsGe/KM617v1q2jJCOgoCEbTs0wi+ACYlQBZSv1lCDmmLIVGC
         TXHSKqrVeselGW+Vz+L7narOzefiaO3sW7PRQQ9zLOmdOjVrvJIvNUfpgQTZrBuv96gy
         RzhkRI+UNaegYz46rwfz+hEE2EKw8nG9yoU/d0jxN0HjaiVIkKK9s4AH0iYD6XNDYsK5
         VA4g==
X-Gm-Message-State: AOJu0YypofgVkNKVb2B8c2uYzfHVcYvHSg+FPYJTWUqCMS2LB49JBJ4W
	rTWM3CujAJ/ifj+2R9RRdirSWiYwa2yTispFSD90SrO1VlK0aCIqtk0bDwuGQw==
X-Gm-Gg: ATEYQzxfNkHyCVZtGRBYFPDePghMiUu7N7YczbTDQV4WpkVteFb8EOsPx5ARdmznOOT
	ol72UyN0//6mCXpSgDk/pYwTJiXKIKkZti7CNuh+59bMarcqvo3EUK2HwmIAoxLROz15BQdf+3y
	IiB94VDe7z7/HULS2s4L6npUHq1qigPLhos3GleY9nSzd7ju2cq8X//rRnv3BytFM3XfbjT9vf0
	7o+11QRH8EshMYu6NhPOQLvfR7u39Beq0H4/wimoDEBVVvVzuCnHnopGtcGOfJIysClOwfuwicy
	sOPWvmu2AgJb/z/0h/lI+vm4YGzDIcd05rvk0cLjh+NEGeCFlLCSsGj0bOSohaz5KMY9XUdX85I
	aCmJoWUBYe3I2GmOx2jujQI1bsN6w53Uc96VDq+a+79PoraN8PcItPGH1r2GVDi5CIWrO/IGqjm
	NN3V2U0WiD/pXHOjCK9vOhDvt7FKY=
X-Received: by 2002:a05:7022:6986:b0:119:e56b:98ab with SMTP id a92af1059eb24-1278fc2096dmr1397856c88.18.1772207338063;
        Fri, 27 Feb 2026 07:48:58 -0800 (PST)
Received: from [127.0.0.1] ([172.184.209.165])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899ea1e5sm6390958c88.7.2026.02.27.07.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:48:57 -0800 (PST)
Message-Id: <0fbdf031cb9f054e023d44fd3eb3315732d527c0.1772207333.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2202.v2.git.git.1772207333.gitgitgadget@gmail.com>
References: <pull.2202.git.git.1771574833967.gitgitgadget@gmail.com>
	<pull.2202.v2.git.git.1772207333.gitgitgadget@gmail.com>
From: "VALERI Yoann via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Feb 2026 15:48:53 +0000
Subject: [PATCH v2 2/2] branch: add a no-prefix option
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
    Junio C Hamano <gitster@pobox.com>,
    Yoann Valeri <yoann.valeri@cea.fr>,
    Yoann Valeri <yoann.valeri@cea.fr>,
    VALERI Yoann <yoann.valeri@cea.fr>

From: VALERI Yoann <yoann.valeri@cea.fr>

This patch adds a '--no-prefix' option to 'git branch' to selectively
override the 'branch.addCurrentBranchAsPrefix' configuration parameter.
Signed-off-by: VALERI Yoann <yoann.valeri@cea.fr>
---
 builtin/branch.c  | 9 +++++++--
 t/t3200-branch.sh | 4 +++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 2fbf2d9722..701c2a3180 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -713,7 +713,8 @@ int cmd_branch(int argc,
 {
 	/* possible actions */
 	int delete = 0, rename = 0, copy = 0, list = 0,
-	    unset_upstream = 0, show_current = 0, edit_description = 0;
+	    unset_upstream = 0, show_current = 0, edit_description = 0,
+	    no_prefix = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -776,6 +777,7 @@ int cmd_branch(int argc,
 		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
 		OPT_BOOL(0, "recurse-submodules", &recurse_submodules_explicit, N_("recurse through submodules")),
 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
+		OPT_BOOL(0, "no-prefix", &no_prefix, N_("do not add a prefix to the branch being created")),
 		OPT_END(),
 	};
 
@@ -1004,7 +1006,10 @@ int cmd_branch(int argc,
 		if (track == BRANCH_TRACK_OVERRIDE)
 			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead"));
 
-		add_branch_prefix(start_name, branch_name, &new_branch_name);
+		if (!no_prefix)
+			add_branch_prefix(start_name, branch_name, &new_branch_name);
+		else
+			strbuf_addstr(&new_branch_name, branch_name);
 
 		if (recurse_submodules)
 			create_branches_recursively(the_repository, new_branch_name.buf,
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 496b034d0b..bc09abf725 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1725,9 +1725,11 @@ test_expect_success 'create branch with prefix' '
 	git branch branch-with-prefix &&
 	git checkout branch-with-prefix &&
 	git branch branch-with-prefix &&
+	git branch branch-with-no-prefix --no-prefix &&
 	test_ref_exists refs/heads/branch-with-prefix &&
 	test_ref_exists refs/heads/main-branch-with-prefix &&
-	test_ref_exists refs/heads/branch-with-prefix-branch-with-prefix
+	test_ref_exists refs/heads/branch-with-prefix-branch-with-prefix &&
+	test_ref_exists refs/heads/branch-with-no-prefix
 '
 
 test_done
-- 
gitgitgadget
