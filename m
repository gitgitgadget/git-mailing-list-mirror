Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E6D12CD8B
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 03:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734493997; cv=none; b=kZcqJaPqYfMz7AojvE8Ii+oxBGQgnONQCDkAJ2z7SkFGOls8TnMoM5rSNqPZSxBe18oyHVSrh5demrwLMNOfjlKu5pj1LvsR5j6xObXk1m5nvWX9HATpjspKbi+YwYh1V9lnOyosoCmMk01mODfRHsq8OUmaixp/dpvNX5jpPi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734493997; c=relaxed/simple;
	bh=37s4NC9i4kEpi3gLYIyrTp4QdhnwqV7+Tyes/95u97A=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=lDOw9IVlQZNkmrTky8eDF4dIR5MI5uE7uLMSGcZqGuNZ2oGbdCP31wZZtairKLIWYQfKYWRwpYqNUzGTv26zZzaExnuYecc8mpYzdw9ujROA9QdHbHq1xvQ7VQlkwm+gVFKyEKwEg9Fn6BT8mYX6TGwvE0SoGK3CZ2p5JgdrfKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7LUbG+u; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7LUbG+u"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361f796586so66215295e9.3
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 19:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734493993; x=1735098793; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m8Fkp5bgBdgLNkahIl7ShgNGAYGF5rSGnQ6U9oNqpP8=;
        b=V7LUbG+uQmj8lu/iPdS652ADjOViMGdDYv/8KHeSJt0Dw33vakA6rkOHRUmgsUCSlO
         Ey922pvDNY6zf0Oer+kbqrNScdESG+lKP7yqymMY5eZS4OLegddxyIpVkssX754ahmkC
         6nC+QjQTAJTTicp5SJUiTKnUrT1F3iR6+bx5RIB7HLgXt66MilL4/r3UTqhOrszO/pj9
         4l1TVC7l8VrDf5yUNMtVS9BydBhKiNpnHwhFknaR7cMjQjpJ3xT5zBXrXXphG03x50gi
         Egp5fzSpN9rUNmrAr8aw9N5CV5n4Jyc45LTd/IiC3kqUNY7cSfD4ps5UPaSHoBjPDw0T
         Z5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734493993; x=1735098793;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m8Fkp5bgBdgLNkahIl7ShgNGAYGF5rSGnQ6U9oNqpP8=;
        b=Dhj7Yu4p4tElXGEFaOTp4dJBPFSVZoUSv5RMc6HVodLjlnE7S+3cSu7tZs6r/jihsa
         6oRrXGH8LHDEfGDEDYxk/afkG/IW6eCLqIUtJkiKj41cUKAwhUYSPYNDedMv4VjSvRYm
         Ygrzp9FyFEslge1NE1QOCPapmJ+M2J3xwKRZZHJk9vwuvg+p8GNqvcufMPcWOlS9BLNV
         m8hjqF+9z4DtcsSbydsXecH9o69f6YQIPtxERN4K/ra7CVkNz3SbSzV9NG52NedCm3LW
         KKW0Uo3V3zC8LzSou3fcrdcJOJoFpLwcnCMa9cv14eLwGOxzopIGuRmCR7FJLw58hOT6
         A0cw==
X-Gm-Message-State: AOJu0YzM3bcYHfrkIocPqlBHFsPwlIkGihF85sJZ0HKzcKd4rVfbZc7h
	aqcCDbEEH2fnMr4VwGUeh4nSXQL3DmbRT/I3IBUGaiGWYb/hS0SQxZPhkg==
X-Gm-Gg: ASbGnct7E8sVcsC/pdTTfTyzzZLhwyzFxCnRmSJ5GkrWCH3Z7x1ORhGWCSjiS2Gw60R
	wytolDaTM0UUgDABjZ4Kdm35Rd80NrvytC91ffuc2REWvG/fpxLl6fqe+h1sYDwWq/QNIiesH8v
	bOsjSdxQ/a+RC1PfS4HDmxxUzDcdtf2E2Y3zo90Pdl6UWHEJsXOyZNsZl3XmdXM94Pp5DyCQRMU
	122P+LVy61mrZcWQVhWRL5ejdTykqJYIlC3Uu+lk9kokQ0JHGeQUgmgMA==
X-Google-Smtp-Source: AGHT+IH2rYeFV6QSXBM0Ay3b/fM8fjkhJl+dDkSiTot7MJHzc+UTVQLctAAW3+uN7m82CclmG/twgg==
X-Received: by 2002:a05:600c:46c9:b0:434:a26c:8291 with SMTP id 5b1f17b1804b1-436553ed0a7mr7375985e9.24.1734493993338;
        Tue, 17 Dec 2024 19:53:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c804a2f9sm12980669f8f.77.2024.12.17.19.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 19:53:12 -0800 (PST)
Message-Id: <pull.1453.git.git.1734493992236.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 03:53:12 +0000
Subject: [PATCH] pathsec: make check for PATHSPEC_LITERAL more readable
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
Cc: AreaZR <gfunni234@gmail.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

This check is designed to die if global_magic
has the PATHSPEC_LITERAL and any other setting.

This can be written is a much more obvious way:
if global_magic has PATHSPEC_LITERAL, it can only
BE PATHSPEC_LITERAL, and if it isn't then there are
other settings.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    pathsec: make check for PATHSPEC_LITERAL more readable
    
    This check is designed to die if global_magic has the PATHSPEC_LITERAL
    and any other setting.
    
    This can be written is a much more obvious way: if global_magic has
    PATHSPEC_LITERAL, it can only BE PATHSPEC_LITERAL, and if it isn't then
    there are other settings.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1453%2FAreaZR%2Fredundant-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1453/AreaZR/redundant-v1
Pull-Request: https://github.com/git/git/pull/1453

 pathspec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pathspec.c b/pathspec.c
index 0fc6f84a6e6..0af953d055d 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -313,7 +313,7 @@ static int get_global_magic(int element_magic)
 		global_magic |= PATHSPEC_ICASE;
 
 	if ((global_magic & PATHSPEC_LITERAL) &&
-	    (global_magic & ~PATHSPEC_LITERAL))
+	    (global_magic != PATHSPEC_LITERAL))
 		die(_("global 'literal' pathspec setting is incompatible "
 		      "with all other global pathspec settings"));
 

base-commit: d882f382b3d939d90cfa58d17b17802338f05d66
-- 
gitgitgadget
