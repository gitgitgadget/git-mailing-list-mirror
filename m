Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871E4214A8B
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917054; cv=none; b=KGs+69sIbtrdYgFEL81s/p9uby95Fv7NQwrKNPYySluKm58VEwBpCF7xrHORT0VCpVGt46X2kL4OA+W0tvVPCvqtZzFMeN9HKJ+DQvtwJRJKj+F7c1/ox8OIoawq20hfnHgghiW83OHvLG9SxDF9ZyA14fJ1I4RlTGktmlbBOpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917054; c=relaxed/simple;
	bh=5QoFbEamQQcp5AHczmQ3cs4pTv5rW9pFHWgt57HiSFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+5Rdrf92lRGrN/GuET6l7OGv75MjKVCbMUpBKw5Kiy3MskpFV4P4nEZJxhFYbrvwxMrsvL0TRNCrgSa05a5WQfBT/h/xDxSdOfmSmFGj6bMHsxRGpNU/CV6f9mgz5XW4bFiYTsys6hV26XHykdyZeEPJIbdsDhGL/TgeWnzO4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gla2xPDV; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gla2xPDV"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-352c3e74fe6so6434a91.3
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 09:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770917052; x=1771521852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tf8aNzxf978nW/zfdDk2pdE2BvlYm4ovrl+Be4WfXuA=;
        b=gla2xPDVuJC5pijo4Iq7A51A5lmE3toyDgq65KEzXGE4rZCrc5VrYdGszgsCeqC6xZ
         GrzMs6/IU+1JQ406hCMWXzyhpBDgTVo4JsJmrv+m2cKWVL7rcA2y1890ZvaTRhx3iykn
         5vuDPMNOOHoiEqeyu9M3wtfxaTx+mv1kYQg47LmGgkWxgXcaPPcOXQ1Hu5VRhoD5hImw
         P/LhXu0aY7jJBwAosax38Q0+hwhLDwAHZxkFZijXLFIozoJuSudnC4Fpy4S0Un6Olpgd
         qgGMFFRUofDxiSQOG7Mti7p+efoZNObMApDSJRM264QhJXP7LuiVgLO0Cd9l/QDTxUsx
         5OmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770917052; x=1771521852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tf8aNzxf978nW/zfdDk2pdE2BvlYm4ovrl+Be4WfXuA=;
        b=GDB/fRzwELpsuOhv9qfnPgqF3ytPlri/xKgwGMvguIfvhqgsfx75iFmcOIm/lTeqis
         3T3ryY9sooLS3UfVZ75z/k1qzP/MOywiMY8Vf0GfRzBVzUJionnmj+grtBirg9Axkxl1
         kVH3THPFzXKMRc5lzZ14ORFzqaUKYUOiGDXkzabeWr3GdqSr4nLD/3GXh2Ol14SDytss
         sStY+yKevNufX9mczVwr+5W+8DOS3RRVMNCBAAjcyCXXWARcWE9dPjh51sEy3sjLYS+N
         L0IjMtljJUW+xEIzExEExfKEA9U/1fujricW1mvOMqhKfkEKNoKSV5IRnJ76PowOynu/
         QRnQ==
X-Gm-Message-State: AOJu0YwIoDWiIxm4B2qr9LCGeEm68k8mK80AIuwdaJR4zZWZ2HykGpaB
	lvc2f5kM6f7F1MfKhwlr4JAZau1kIcnfSk65fBbNPniF0wRH46PW8ZH4ui7e/CO+
X-Gm-Gg: AZuq6aK0YAqsfbmIiznBfLgEHr223bquXag3Ecau7TenSmFT917A2JoWXs6N3/FXuML
	7jYWBH2uDOYJ/XEORgXUTW0ZtOdioSrKS5Ql/RlhX0N/W8S3fBbVOlJihMjk/HVmr7/KY0m/aqZ
	5BdrmYx5r4eqx70ezVOngEk9DkutT+XeDGU3225IdD+CzZP3TLGpTYMpwI+LS9tgePCRvdu9Ve2
	aR+4AHiTrXiIZlQR+aGejQhJqjnOyK8ToF2AO/eoCjxBeLtrenBp52+xCFrW4c7vpd5dkC3tMaT
	kB/ymAQU/kRntc+dlK68MjTPD+d1H4sMqmb1/EX+NqBwdC2Qb6FgckY3JFqfhDy10XSxv6ydL8Z
	Jlrptslt2u+75Wzt1Y8c8Xp+QrNXkucXokDwHueABoEifRGBPO4CbQf4gcW38E1wiWrJVFCcbO6
	it/9aaSjmjm0igdNp3YvYUZnDAmj1C0e5Chx5Zydg=
X-Received: by 2002:a17:90b:3f45:b0:340:bca2:cf82 with SMTP id 98e67ed59e1d1-3568f8aa4e9mr2669089a91.4.1770917052274;
        Thu, 12 Feb 2026 09:24:12 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662f6b678sm9456452a91.9.2026.02.12.09.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 09:24:11 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: [PATCH v2] setup: fail if .git is not a file or directory
Date: Fri, 13 Feb 2026 01:24:05 +0800
Message-ID: <20260212172405.48614-1-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260211182122.35352-1-a3205153416@gmail.com>
References: <20260211182122.35352-1-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, `setup_git_directory_gently_1()` checks if `.git` is a
regular file (handling submodules/worktrees) or a directory. If it is
neither (e.g., a FIFO), the code hits a NEEDSWORK comment and simply
ignores the entity, continuing the discovery process in the parent
directory.

Failing instead of ignoring here makes it easier for the users to notice
anomalies and take action, particularly if this non-file non-directory
entity was created by mistake or by file system corruption.

Resolve the NEEDSWORK by using `lstat()` to check the entity's mode. To
avoid performance penalties on the happy path, this check is only
performed after	`is_git_directory()` fails.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---
Change in v2:

- Moved the `lstat` check into an `else` block after `is_git_directory()`
to avoid any extra system call overhead on the normal happy path, as
suggested by Junio.

 setup.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index 3a6a048620..95658f2547 100644
--- a/setup.c
+++ b/setup.c
@@ -1580,11 +1580,23 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 						NULL : &error_code);
 		if (!gitdirenv) {
 			if (die_on_error ||
-			    error_code == READ_GITFILE_ERR_NOT_A_FILE) {
-				/* NEEDSWORK: fail if .git is not file nor dir */
-				if (is_git_directory(dir->buf)) {
+				error_code == READ_GITFILE_ERR_NOT_A_FILE) {
+				if (is_git_directory(dir->buf)){
 					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
 					gitdir_path = xstrdup(dir->buf);
+				} else {
+					/*
+					 * It is neither a gitfile nor a git directory.
+					 */
+					struct stat st;
+					if (!lstat(dir->buf, &st) &&
+						!S_ISREG(st.st_mode) &&
+						!S_ISDIR(st.st_mode)) {
+						if (die_on_error)
+							die(_("Invalid %s: not a regular file or directory"), dir->buf);
+						else
+							return GIT_DIR_INVALID_GITFILE;
+					}
 				}
 			} else if (error_code != READ_GITFILE_ERR_STAT_FAILED)
 				return GIT_DIR_INVALID_GITFILE;
-- 
2.43.0

