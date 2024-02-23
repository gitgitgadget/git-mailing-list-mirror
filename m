Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A503A1AAB9
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 08:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708677274; cv=none; b=ll13hvkIcSrPkpzlmDo0wX2VGcXPUIXWpXkbQkeYioBoX74hf0mXLQQvAjh7ddt55f547s+WXkx25Zl4UnmZgiviXIBJe5HG8lJyb1Ir8XcO8AzvrtkDEVrySQHIodEDHjMjJOiXsT78O+Av2ZDPFIuCkglr8wrNBamvvscgWWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708677274; c=relaxed/simple;
	bh=C05rXEareOoDG82WPd99xJmYGLU1fbzABBWmtXJTWMY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WSr/KvjR5jwRypITNFXqlnNA6CrmFtfTqrZzEeprPyLCTSso3ffGQmz9whgn9iGd8JwmIMbzKSSEWxmSzxPkWoly+7eYpWKloGbGSnLp+RY0HNfxb1ybF3cPDCzwZWE3MrhmvAzW7scjpS35ZDP009oU+g+12GfLpjYztziVb1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeI/Jo0E; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeI/Jo0E"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d153254b7so454646f8f.0
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 00:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708677270; x=1709282070; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzXXrTR1654PTduFx3oEOukzzhnQP7ss3KpbX4fLdqU=;
        b=WeI/Jo0EdGacBST5/Go2gWxlPeXWr7HJNU4KFUwryhhIxLigF/CbDOwG7HzOuWO8Wr
         E7WRp/e3+6PorsNBzTjNWiMDJjL/SxoZHizs119V3nDwWiPfUBqkCdXVkWvSYHoyv9TB
         q9KuTZxAwqmrhtAO9hyfypmTnmq+ZNsCNrlTDiBMIPkNHt06cdXUpxDf2AbmovBeZl4x
         SWGZXSAuXJl9APoH14ZFIzjawWv5R4L6NzaJb3+G5sOtgd8d+hPC9Lkb1hc0abVaZBub
         igH8wDvvstjCGlDod54kLmrHaplNDUMTfzxsb1fcgKtS920Y4fVhtwra2OFhhRPxJ821
         exmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708677270; x=1709282070;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzXXrTR1654PTduFx3oEOukzzhnQP7ss3KpbX4fLdqU=;
        b=uZBlWgh2yfyaweEuLG5SrOYJgnmWYEeQG1ASMrxDDw7DFAz1M2GvI28jWoyK42J3gl
         b9xwNCy+EEivic45T4VSp6IW2a1AzHIy6hbCLzpfsDRR0gr1XJ/zn8BCzaVJYSaGHvT2
         UGVmZclPWbuZHw8FpzXTh2w5ioOYOnc8PsFaoAWPxc+aezDf+tcXDY1KV2rkPO+CnJNE
         +j9/LqCBOYHFTdVFCxwliB2V3u+30g5KNB7tOZCiSBv5b2O4CBBJnIYQHHYEgmBHIk2Q
         2z1IgyDMLnNmQRrZwcExuYjIKRsYe2Lk2x4t8h/hwY47K8MwY2yHax7ecXSyvyq1mjkh
         YOmQ==
X-Gm-Message-State: AOJu0YyXoVVDT+oh+FBTngvCxPM41oYmaWixL78XDbBXczrrWIW5fjnv
	Mf8kxGmkzq9DqM5nCUR8vnNPq2Yf0t7KFHXzkbVW3l8LRw8Gudjlh2OhJj3X
X-Google-Smtp-Source: AGHT+IG3mNVvJ6C5auHIwtGH4EX+ab4VvP6MPSj0CjCnfd1PEjp7NE27saWnPuCpLvspg+yFAEH4zA==
X-Received: by 2002:a5d:4589:0:b0:33d:545b:1794 with SMTP id p9-20020a5d4589000000b0033d545b1794mr952375wrq.9.1708677270152;
        Fri, 23 Feb 2024 00:34:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r9-20020adff709000000b0033d8ce120f2sm1882029wrp.95.2024.02.23.00.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 00:34:29 -0800 (PST)
Message-ID: <e82fdf7fbcbf12fffdf4a720927c2f4f006068f8.1708677266.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1651.v4.git.1708677266.gitgitgadget@gmail.com>
References: <pull.1651.v3.git.1708612605.gitgitgadget@gmail.com>
	<pull.1651.v4.git.1708677266.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 08:34:22 +0000
Subject: [PATCH v4 3/6] t4301: verify that merge-tree fails on missing blob
 objects
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
    Eric Sunshine <sunshine@sunshineco.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We just fixed a problem where `merge-tree` would not fail on missing
tree objects. Let's ensure that that problem does not occur with blob
objects (and won't, in the future, either).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t4301-merge-tree-write-tree.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 908c9b540c8..d4463a45706 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -962,4 +962,20 @@ test_expect_success 'error out on missing tree objects' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'error out on missing blob objects' '
+	echo 1 | git hash-object -w --stdin >blob1 &&
+	echo 2 | git hash-object -w --stdin >blob2 &&
+	echo 3 | git hash-object -w --stdin >blob3 &&
+	printf "100644 blob $(cat blob1)\tblob\n" | git mktree >tree1 &&
+	printf "100644 blob $(cat blob2)\tblob\n" | git mktree >tree2 &&
+	printf "100644 blob $(cat blob3)\tblob\n" | git mktree >tree3 &&
+	git init --bare missing-blob.git &&
+	cat blob1 blob3 tree1 tree2 tree3 |
+	git pack-objects missing-blob.git/objects/pack/side1-whatever-is-missing &&
+	test_must_fail git --git-dir=missing-blob.git >actual 2>err \
+		merge-tree --merge-base=$(cat tree1) $(cat tree2) $(cat tree3) &&
+	test_grep "unable to read blob object $(cat blob2)" err &&
+	test_must_be_empty actual
+'
+
 test_done
-- 
gitgitgadget

