Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF2233A9F3
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 20:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774728192; cv=none; b=rqXKkloGuytZh/MDhp2MKUynvjzS6oxCXf0ulmyTnp4dGEgC7qANHb1GkyL0AytranJfftk5mslEJY4m2l8m0Q5Fyzf/eBomTSEou2z9foXPDTISO53hb1F43pOnoCiRbJWDiKLBcNW66T5xUG8NHRObJ6FABpdQsfk9pHJAnSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774728192; c=relaxed/simple;
	bh=8rMFd/2kjqRuqX+Ju1ng7XXd3SeOLM6Y8QV9JqqlMDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1I25REFWujj1mO2u/PfeBYyXC9zqtdArL1wk5ZD4kKv3U1zhSaaZ6xKh1fmdHacjIVhBcuI3/07en/7jr6SWIvsFIysaqHHru8SAu70PUMB9sVqO8YRoW+5TgyQ9MDOIehOSFG2MNms81j6hB2A5YuQm7kuAkWczfkFEF5Y0m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duP7ngJZ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duP7ngJZ"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c74f0c3fc16so1147693a12.2
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 13:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774728190; x=1775332990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pd8wrd1PCL3Vh7VCavHBFGptsDQ/vRy1jCjsLvtMGwM=;
        b=duP7ngJZSy13vIoya5hCOTPrzxiddQD2G8OvOq7a1PJUxGOVSouoPbx7z5eFJCbypx
         Dw0XFwx7KJaUyY4TQTPdqQyUUfZyRC2CW759+guiWu8Uc6rGabseefX6bMV+yH8Dpu3y
         pmxkgtXAn3WS4EXnsM9mxc4CYIhegQ60Tt3hjuVDV8n7ECEeriqygKn2D9D6DOBCC0qy
         wjTJQ00iInR5TZt8kM8osLtNZ/CQfhYpTHfIFr3flp+g+toCmbO/efMOz16FolZy9JXj
         Z5/qRASxvPPttUuR9s2YObNPlm+P3iTjT9cPE9IgYdlxf14BycdL0hpPMgCEYi1O8WrS
         hXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774728190; x=1775332990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pd8wrd1PCL3Vh7VCavHBFGptsDQ/vRy1jCjsLvtMGwM=;
        b=dHKQKhUAgdTWHm2v4nJNiA7Lx/KjZNmWXTSLiVVXvHh1bfdjkppQS42sQ0jGZIYEDc
         1leWF4xP1LjHhEq44nsyL8SCsSJ5EJEsLPxSS/6xFwJGvkMu7ALdsEe70DFltDNHqg1W
         7z97OR+3qhLFi9H/nCYyp723KIIgMjn/7c61K8duv7ZEUZg9HgMfU3vS8awugmA1AfbV
         iJbVjuhuMw3dmkSMr+Sbt2iaIjqCTD/0qlOOsJ4g/GjY1z4enJzD72OP0OyFJRTmQY3p
         0z1R0p4VI6XiCxN3GCC+Q8yFwiMmg9olIK1V/6cLdvL8S7o50CoAdojfPbEi4fn0A0v4
         8PCQ==
X-Gm-Message-State: AOJu0YzMgnJDPSN+l7ijPxUcbGe+sroGAycmPLOpbe5P5Zgfg8owF8iH
	oXMqXpOKRGEdyZ2XexhxYhl4QHIoW8haXLjVEfpiZyPgBGy/d6R6fR1IIVouwaU7
X-Gm-Gg: ATEYQzwl6mkhEHoCofQrDg+4Dm46PO6bfEdKEHzqXUwt0H5GiW5qGMBpzjRn2cpnX79
	CPyptZSo2YZghpEQd2fpAQCrF5CgmevTfjDokKpKAySPxY01UaiIULRTydlmyDlTrG/acwYnrzi
	6jtC6dAjaaFEPgJ0yNTje/fIIaV1TxdlH63BL8WCZnJTdJlwdXLbr2YJcv+xpMnPvZK0cUwEcDa
	FOYrHH969xZleleECkX6vo+XXxPt4oeElJUVj6PZeVMo9TR2dROTxkB0XuIG4TxCZfK1GXKLvV+
	+PVQvkU3AtazPgkTtHmYFDk8d3MbfE6umkcuLHAeDylu2JJiSppPz9ol+zlMZbIpnkrYHJ7Oq22
	XZapxzrzzRapk69IjROav0nG46B8xoomRaMK2Uo7Bq5gdQCn/33nyF48XVgyQ41WWTExz77YcTD
	VShgCDHxUfL82WSSj9UxgNfcdwFfBu+FPXv3wDQbpcelg+lcilbPgo5Gf7yrDOYMoNk9ZfhrqyW
	AtDTNjHFg==
X-Received: by 2002:a05:6a20:918c:b0:398:7949:6302 with SMTP id adf61e73a8af0-39c8780b4c7mr7567880637.6.1774728189747;
        Sat, 28 Mar 2026 13:03:09 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917bb31asm2359786a12.23.2026.03.28.13.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 13:03:09 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH 02/16] t6423: avoid suppressing git's exit code
Date: Sun, 29 Mar 2026 05:02:41 +0900
Message-ID: <20260328200255.247759-3-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328200255.247759-1-vikingtc4@gmail.com>
References: <20260328200255.247759-1-vikingtc4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update t6423-merge-rename-directories.sh to redirect git-cmds
output to a temporary file instead of piping it directly to
not hide the exit code of git commands behind pipes, as a crash
in git might go unnoticed.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 53535a8ebf..52665cedcd 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -2273,7 +2273,8 @@ test_expect_success '8c: modify/delete or rename+modify/delete' '
 		test_cmp expect actual &&
 
 		test_must_fail git rev-parse :2:z/d &&
-		git ls-files -s z/d | grep ^100755 &&
+		git ls-files -s z/d >actual &&
+		test_grep "^100755" actual &&
 		test_path_is_file z/d &&
 		test_path_is_missing y/d
 	)
-- 
2.43.0

