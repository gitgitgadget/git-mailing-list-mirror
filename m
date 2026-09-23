Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460933E639B
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 21:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199113; cv=none; b=WrU9SQi/pV9PM5O2VtP+QXhtHmon8G5Jr1NLdVcb62xwky3StR4MNuo9rGI3aLWKaj8Uxk1dUa8Wp/lDkewbBlhaIraVS3oSoyFymzcgOPMfYQS4AhVno/IT+NHdEP7Jznd9YuLOsrGiS39+pCKwbQ86MC167ne5s5r4+NF/DKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199113; c=relaxed/simple;
	bh=E1T9i9WYsME6sZYtxuHpz1j7Tlt0ZKZEEWmbMeQYMDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rVSokndTdhjDoHwubJziBc7IbvwpO13rUOuulnUNK/aCmrCiy5PxM2QnbfTSOa90T4sfc/32UCAxZqDi0U5E+KJMDnQeKiDNp2cnKR1gk/IB1PpU92f02DTXpuMyDMO2Ki1eMYYHFIX07NCntTy5rYRui43Y/4I1e9u+5YDsyF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQYFoWGl; arc=none smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQYFoWGl"
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e7b06acb8so5296595e9.1
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 14:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790199110; x=1790803910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DQOLeMSfnj1oJ5S7ovqMuHt1Tw+HGbctU91CWRqVWGM=;
        b=CQYFoWGlqQg6/LPTiRheL/p4y0m3cMC+r++fr+amOwDE31DrmyBa7Byzj1hRO7jYG0
         txu9df75dF9sL4meb3d5g6WXqC14fcHqSyqBc9CS4X9GJrc8CYIHvFtiHMPYvSSP2S9W
         CKSUZayPwJxiIhs3uAsIn0awsdinZlXOGfJmXOcnTAGttm4rnnsL/IO7gRB/1X7sOVKu
         N/tfDOMtfSTbuXzx5+PZbFbCvpwtENDzVw0h7Csn5BuFikuvfJO7YB0jfbs8kmfyA3IC
         qs8vIXr6KBaYI2JZgIXAXipF2qHCz0/clcWqtczfvNxQKSRxyy27TCFMGq2sEeRKO8N9
         x+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790199110; x=1790803910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DQOLeMSfnj1oJ5S7ovqMuHt1Tw+HGbctU91CWRqVWGM=;
        b=BjVYI1sCr9rfebjBZ12tepjXNm6TRrVRTvl0v/H6hbjioLsA7oL6TJ4/pRc9pXLjaT
         5iqH1oMqMJYyqVHkvCPzIcqeukLr4/deuTBRD40zFeVRmOOFTuvGhBwfaiOShh0LSTd2
         RdT9pTNJPZCI+GBkO4ZjIr5RSCKU12uCPB9sEYjvQLwfythpBh2YhVsIm47ymXnplirq
         iYSVNsaNQwIVmH9xKJ1TPKddutU+BWf72E/H8CVpL326wqiRFjvuRqVKdugASF9y/gmU
         kDVqc0fHgWlFqP+JfW5t97t5A2sof2+pTLIt42LcnMcTcknja7q5+kaAVSYlrzYCe+25
         6xAw==
X-Gm-Message-State: AFuF++kBN2VC+FpxCNcQ2l8b0ZkDe9Dqjjhj/tX0CBqTXxHOZsbg36DG
	qA4O5QFDJr11hrTmkIeDX6iP1BZ4Rik946rsO20Bcl+Q29rjnAiBZbnFKP+N78dypzzptw==
X-Gm-Gg: AYBFou331/BJ/Fhvk05NI4PIcnAfwlw1fMLkC1qOymAusIm1Ps0xBLpzuSIGr49MHTv
	7IDuN+zt3nVJ0VC6y2FrwEAKUPFQ09OvI6TmMxbKyNRbG8k5lP8eoTF/5Tjb71UotKcBDVUJos9
	OUeaKrN1K2ceZXGQby2CglzMevozN/e0t8E531yZ4bICq43dDI0b2V3e3avk7VlnYnAJJhpH4cA
	+YBXiL/qoQM0pjFYBE1RZXk/oEkyt6MEvEpvLWnRwiQbY/asU4nF/G2g7/PXYS8/7nlg2+UgF5d
	b7rOARDRtR6zO+jqyCEjFTpQNWyYLIOXbAvdiY9wS2UimDRgR6ui3hF0b/4gpdkO7FmzVxkh1eL
	MoGt3ZYG0balc/aSV2fhsRSqDXl6tvSeqw3zAU+RHE4LP24sjfq8/9xH1gsyhWdru2/1Cojyk3b
	Ob16hqdpGwhhkHURUupCBA2ZLpbxfCzOtTUpNXazbDlio9DJz+
X-Received: by 2002:a05:600c:350e:b0:49e:6c27:d093 with SMTP id 5b1f17b1804b1-49fe66d80c8mr7494035e9.15.1790199110406;
        Wed, 23 Sep 2026 14:31:50 -0700 (PDT)
Received: from DESKTOP-OI0N70R ([146.158.109.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5bb9891sm13546875e9.6.2026.09.23.14.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:31:50 -0700 (PDT)
From: parovozik <kaliugov@gmail.com>
To: git@vger.kernel.org
Cc: parovozik <kaliugov@gmail.com>
Subject: [PATCH] doc: remove unnecessary comma in git-rm documentation
Date: Thu, 24 Sep 2026 01:31:25 +0400
Message-ID: <20260923213125.1316-1-kaliugov@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: parovozik <kaliugov@gmail.com>
---
 Documentation/git-rm.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-rm.adoc b/Documentation/git-rm.adoc
index b5ead86796..67061e961f 100644
--- a/Documentation/git-rm.adoc
+++ b/Documentation/git-rm.adoc
@@ -61,7 +61,7 @@ For more details, see the _<pathspec>_ entry in linkgit:gitglossary[7].
 
 `--`::
 	This option can be used to separate command-line options from
-	the list of files, (useful when filenames might be mistaken
+	the list of files (useful when filenames might be mistaken
 	for command-line options).
 
 `--cached`::
-- 
2.52.0.windows.1

