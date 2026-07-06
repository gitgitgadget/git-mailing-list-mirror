Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6EF3BBFB5
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783365271; cv=none; b=WjQl7JXdnBS6hebVH6EwdI0rP7UJrksxN2338Iu/9roOq+Pr6yLc6lEw5/2gnDgpEJ4bjb1dKjOUnoIrkSmrijYJyhkMXhMupK0Wq67NOZQiDDEJw2kXECuJdbxYHdvmDwxDYOufFuo9tod7j2bAKW1XBZdQzBXNcCtT2bO+zmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783365271; c=relaxed/simple;
	bh=u/2QyYdB5UL57ehop+u+BlW9XRg+ZsH0aSsM6lAhBN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UFgRNzShgnnWyJe2U69QfKEcEDSuQBcOR7sB02Yvdr1dpcTBVinK98WcwFWCVLVrnI0Hy2COITVsq1bpKbEyFM0r7Era3evvJ7Sz4ZfvGmnfM3rx6cvQGd/vvomoKastKegO/w5MyCsz34/BxL64V/KXxNjVK1rBM4O9TOo06q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYLaq6tL; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYLaq6tL"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-c888c19b85dso457096a12.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 12:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783365269; x=1783970069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i5aufMPtnHNnqbXrVNg/fWNtn1ahCtxHshfJG9Di5h0=;
        b=fYLaq6tLrPyDB8P2MtG1g11S8J1XG6H+VCs5HTYw2K1NIKgMX/+E4oTnz0rvhWgpYP
         VlKPtuj2KVGMJyXAuMfcTrNW6raLZJODAiLGwh8xZ9YdaqdUC2gL5/FMUPeT9XTM4cr6
         PjdJL4BEpSBUnv+Rc4XcNNHDMfJldlYEoXQkUeg8Jqc65GhUDRGp3vVX5Zt+1Po3d9t/
         9HpeB1+IB+wI4ch7xt9Yg/0BcXqeuHIZ4aM/fno51E0pGXlnUXsDUHAD+NY511KsCJDX
         TR8Yd0H1eZIJl6L72Dm8YYY7urANdbm8ztTxkFzGC5hPkVQO51JXLUnxXrP/HPx9Db1o
         LvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783365269; x=1783970069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5aufMPtnHNnqbXrVNg/fWNtn1ahCtxHshfJG9Di5h0=;
        b=oqzD/lPLSOzJJKwUNvmyC1jMLZ20rUi+u/DKE/3TS6kbIisImT4PRXZwqOCuPZ8W1A
         WSPGYwJNGz8/Rwhl207GukGsYsyBJ0jjTgDWVvMNJkAakMoA0ys+wVM3eVIMyGnN1kr5
         D/WCCz6KriqPHCwsUCtmbd4avDEZfmZBFIeOHnwl1z6NsTqvbjWKV3xsMGbTckUnqUU2
         iT1nVJ1xNopOGf5o3hQZNESDEHQFbxxIazngf3JjEEYIAl4YCPqiZmvWqEm1A5TYySvu
         8FkPYapSWiVcTEaizrKAiE77VG/M/BdPfPGlpzCr63ta2Y+btJFLG7EEPHeo76Q33och
         ngbw==
X-Gm-Message-State: AOJu0YwYjUIkhdaYo0E3VGY4W3JIrC9Xr14zDndoeonCOZlFEDiEGmQk
	H1N7u1XhtC5vz/zT1aTvrIZxrUZ0dsDiDhEMXtrvPLejoUZNgFs1pBWPoiPiKltm650=
X-Gm-Gg: AfdE7ckVlTa6YB9GP512vILHjjWFSQhcBltgXoWgAWLa9U4fdkmWyUSD2FOJUenpPct
	sF8lvyxWvcMO5UDuPYbDBOncqu2aABUy+7+ukunQMknDQF6ABpRXHy5g6JG0DabmDIF4n7WUzdm
	kdyGuJXAkG7epxc6IMwWxg7jqccvz+QqUOAGHMEdDVU5Fnw+QIw+/gLT+NFB4K85iL3F+drqVjS
	rDZ/t/xYyZjR87N3+dQZz2zdkSDuOInHCW1wCfhDb1Qh1ZdjJYobS4YIu3qjz3BY/ivUVfmlfxN
	1qOgsBsZeMt5/PrJ0APXeyswREyYmRBU6xl0eSAyz/M3zObAypdA1INlniCBVvfebJwgOBvPmch
	1Y4uLZhS1Xeej5pl5nx/QxV/dEyNMY/AGFWGXAIiBHQByD1zcrwfEPltPgCP51xLwqyCAZ8ogkz
	xNzd2uVN3p2WAIJjfjGYsRRn60DRZtyRjkAGPCYkG2sPCXkWXLmkG4oLSaC5SaEqP2nMwn
X-Received: by 2002:a05:6a20:d490:b0:3bf:5539:f8f with SMTP id adf61e73a8af0-3c08ee6d060mr2227838637.37.1783365268939;
        Mon, 06 Jul 2026 12:14:28 -0700 (PDT)
Received: from localhost.localdomain ([45.117.66.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c85d4fesm51780365c88.11.2026.07.06.12.14.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jul 2026 12:14:28 -0700 (PDT)
From: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
To: git@vger.kernel.org
Cc: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Subject: [PATCH v2] setup.c: use die_errno() when chdir() system call fails
Date: Tue,  7 Jul 2026 00:44:21 +0530
Message-ID: <20260706191421.94453-1-gatlavishweshwarreddy26@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When chdir() fails, the errno value contains the reason for the
failure. Using die() instead of die_errno() loses this information,
making it harder to diagnose failures. Switch to die_errno() to
include the system error message in the output.

Signed-off-by: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
---
 setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index b4652651df..e2e98d1126 100644
--- a/setup.c
+++ b/setup.c
@@ -1954,13 +1954,13 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 		break;
 	case GIT_DIR_DISCOVERED:
 		if (dir.len < cwd.len && chdir(dir.buf))
-			die(_("cannot change to '%s'"), dir.buf);
+			die_errno(_("cannot change to '%s'"), dir.buf);
 		prefix = setup_discovered_git_dir(repo, gitdir.buf, &cwd, dir.len,
 						  &repo_fmt, nongit_ok);
 		break;
 	case GIT_DIR_BARE:
 		if (dir.len < cwd.len && chdir(dir.buf))
-			die(_("cannot change to '%s'"), dir.buf);
+			die_errno(_("cannot change to '%s'"), dir.buf);
 		prefix = setup_bare_git_dir(repo, &cwd, dir.len, &repo_fmt, nongit_ok);
 		break;
 	case GIT_DIR_HIT_CEILING:
-- 
2.54.0

