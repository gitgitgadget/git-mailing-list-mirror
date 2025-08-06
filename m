Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1BC1FFC41
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 23:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754522130; cv=none; b=mYlW9VPHL5Twe1c/JmsnbCXKul7ivKeee92+c03i+foYVIqbvjg1mt+KmmRUk26SODuoW+tmRmVI/pXUIjPHxzhO3XbeE5+BspjkB9pxf/XTkY5u3rH1vLwxfxIHj1P+XAW7gSM54/aU1Z5dqZWdc+OUjydravq45i6/yc5Wz28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754522130; c=relaxed/simple;
	bh=h28Zpuwr2aT+L8LcCx9BgrFwS268exxoyRg3EOF7lUQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YvlI1wL7g7pPvH53L263wwN7uN4Af8h1VzEn/NEQOc1r4OcYCeeBpr6lk6WNov7bDMO7XTsVf+kWdBZUdkwtrBlhoMIJ8PsZuM7gXFcx8OalFLEpWisJF6NsLVtHNLteeGwCipGjTFb1o+BV+7bD4XkX76SymriLuzzjenkGNgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIraBHKU; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIraBHKU"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b790dbb112so182215f8f.3
        for <git@vger.kernel.org>; Wed, 06 Aug 2025 16:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754522126; x=1755126926; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/A+51K2ywUduDL8AQtkLj2uWNhMnEXOkSFhqSgNP78=;
        b=WIraBHKUZbF2xKR5YX6E7IYCz8iKeevv/jXLPk+U5w1VncA8JFnLQBHvkew0NB/8OY
         ZpN8zfJp3coYS26d0dBQ80fF4ALOvPSySrI+VXf82P1lMFhj/LnRkWG4BUPsyAMHkl8L
         bDe9Fztb9pBMvDPb4apgACKYJttjAo3CGcHFDL7NOmQRfOFQbGx/b0wH6A8lxRI9wAvA
         9jspzLFzTyyKnfo6IRF0dlW9Um7mktfrcGCZjfBXBfcSqPCeqvYxhnBze+jN8Jdmngah
         r4A+t9uI7UhrzKTwq3AoK6eFZo1gxgxKoE/RbfFavr2xllVjod0G2WL2WNxNdIjMy/Lr
         ZRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754522126; x=1755126926;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/A+51K2ywUduDL8AQtkLj2uWNhMnEXOkSFhqSgNP78=;
        b=fvHOCubGvXF7RpcMl4tauHJVgKh2MQFJ5zYVYBtiCa+OT3GEBUMvCMNIRWgGRyXnMj
         q89h+cVY6KvVdF36EXkZoqzPx2DVMsPj+d9Mub7CoLyfMVPbmlYsj+TSzvAZ1pcxDrU/
         /x14NmyU5ejotdE9d8IS1XAcpulsqUv5Fb5yrmLfqSgaAA/GVH3bbiYbXtxbu5FGHcl6
         qAtvNSv/DR2JoIrJNrv3z3YOXZP37/xYD+DQcrb22gtENCvwhPtyUwmpGH7NJox/XVYY
         ya9dfeR1+d1Z+IkqlXCfdkx/ANI6/kZiOUMLCJoBXFkgIKXoWlEBrONObHKjdznJRQMg
         VaaA==
X-Gm-Message-State: AOJu0YxYsXUN/yutuELu6bvXP8qlbnOWvcNrRIYm7msKeGaKgPF/VHMd
	bMHc5wT+NysYmZulI2XrdQieMDMIR+M5/ki0cCnO4aOQcto3BJ+Nb8dcKyWWBw==
X-Gm-Gg: ASbGncs+bi736FNy/7vYEpv4nurW//VcPntmUvR5rl5c93NLaA2P0fO3PL0jSOmZyXa
	YUWT77/QMOiTev+9yTArpoYzzLXT6YqGoDGECx1/4yKjz3+2ABYzjvYj1dvcdUMj8o/7DGS4UwV
	m3Hbb7thmwGYF4C2yHrTZlO7AY6PTsCv67XQmctK3vo9voN/ZgbyVzboRquAYigTKpWrXFs8vbs
	Ahixk55dGLaabCZ+elFgSk1Q1c49y7wYuLhwpvFZMUGzHUQ1STwNePbTN/6XhwKFW1PAO+NfAYP
	flpURx7D2dnXXiunhy+9A/ZSDRlaJUWLBJecG+vBcEJGz2XrX2oz9DCU7bu+3x6+Qc4AgbAjsvP
	qvLBzE9xNH/11mnjp8vHqk2ivybpY+3y5X9Oj8ZbtmZw5
X-Google-Smtp-Source: AGHT+IFkiyDcIktNQVKELnFLL3bWt6A4OCMi9qFd/iww9oyZ49CMLOoCtKE2elTymg8IyYzssUDr6g==
X-Received: by 2002:a05:6000:25c7:b0:3b7:95dd:e535 with SMTP id ffacd0b85a97d-3b8f41ce09amr3753064f8f.42.1754522126242;
        Wed, 06 Aug 2025 16:15:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e054036bsm14902082f8f.31.2025.08.06.16.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 16:15:25 -0700 (PDT)
Message-Id: <58df0710efc042b014a0c8282ce1d7fa62fbb760.1754522123.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1943.v3.git.1754522122.gitgitgadget@gmail.com>
References: <pull.1943.v2.git.1754422546.gitgitgadget@gmail.com>
	<pull.1943.v3.git.1754522122.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 06 Aug 2025 23:15:17 +0000
Subject: [PATCH v3 2/7] merge-ort: drop unnecessary temporary in
 check_for_directory_rename()
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
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

check_for_directory_rename() had a weirdly coded check for whether a
strmap contained a certain key.  Replace the temporary variable and call
to strmap_get_entry() with the more natural strmap_contains() call.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index d87ba6dd42bf..9b9d82ed10f7 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2580,7 +2580,6 @@ static char *check_for_directory_rename(struct merge_options *opt,
 {
 	char *new_path;
 	struct strmap_entry *rename_info;
-	struct strmap_entry *otherinfo;
 	const char *new_dir;
 	int other_side = 3 - side_index;
 
@@ -2615,14 +2614,13 @@ static char *check_for_directory_rename(struct merge_options *opt,
 	 * to not let Side1 do the rename to dumbdir, since we know that is
 	 * the source of one of our directory renames.
 	 *
-	 * That's why otherinfo and dir_rename_exclusions is here.
+	 * That's why dir_rename_exclusions is here.
 	 *
 	 * As it turns out, this also prevents N-way transient rename
 	 * confusion; See testcases 9c and 9d of t6423.
 	 */
 	new_dir = rename_info->value; /* old_dir = rename_info->key; */
-	otherinfo = strmap_get_entry(dir_rename_exclusions, new_dir);
-	if (otherinfo) {
+	if (strmap_contains(dir_rename_exclusions, new_dir)) {
 		path_msg(opt, INFO_DIR_RENAME_SKIPPED_DUE_TO_RERENAME, 1,
 			 rename_info->key, path, new_dir, NULL,
 			 _("WARNING: Avoiding applying %s -> %s rename "
-- 
gitgitgadget

