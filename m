Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837B112C803
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212990; cv=none; b=j8tbdjPypzVPm51UXqgbxlJIAH5LwxhkWUDPo7tmRYt+VB/H1KsTqDX4VvNoLTaF7rVtQpcZnoyz01hSDTVMEYDMHJkJHEBGNMu0JJMxrdLi4j7DMeI4Hvq5peIy9RFFOxMrwN8e145m2c4QT6aAYL8dYI7nTDN2c9JVLvZpmq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212990; c=relaxed/simple;
	bh=Og36+Y9Y1mkcIZf7hhF7LpKF7o/BSNCJBY9g3T1XPOw=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hhMJ9BOYHJD4bA1gv7p8JL41mD6fv45pFz8+vcxJDWxNh2t+5/8M3G+PTEa66FO1ix7yQOnKGmY5pvpcwUL8hd64flpakaWnCE+i1jjGn7llGwRXb+ffEZLV+RXmfEcYylcmb+lQMMXAIT1lKoF5FUoE0Be6gK/MnlYbFedeMcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQRi/vhM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQRi/vhM"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40fe6c66c3fso2191515e9.2
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 01:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707212985; x=1707817785; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDg6C0kp0tIphGPIcDJqqlIdDG7TgaRDGAT8tV9t48Y=;
        b=EQRi/vhMybjBqjcHKaxJW+XWGTHuDchwBo8kVbSp+g958TgGO+Q7xqow+yfjwpFaNc
         vtN+EeZrAGdS5AssX7glIeaKdnLEijMo62IoqxOgqp14Ks9rxJxY9eAMRts8fZHYIXG0
         JI7tIv4nbJJfjmMyGdkQ1Da8sl+xcbAPQ02fpmfXMygJQkM2DNvVGfTk7l/CYXsE+sxM
         XsHqNmr2dOoVs8tptKBvLnRoEwgocK+2b+76c47PiAwnezZiH3IbFZT69So+0O1VemYd
         nrze8MJ6U0Ti7iQVc3fNhM3KI+KP39pGAUAP2VhT8cqqoJJsmfXbVVSvacCqadiQYb9B
         Kevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707212985; x=1707817785;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDg6C0kp0tIphGPIcDJqqlIdDG7TgaRDGAT8tV9t48Y=;
        b=J7wZY8TQut/akUoajB7PX3+23TZES3xhyPkMnKolv316XayYGuOhYn5UmM0b+JEQUQ
         +I2hbViGeMgwL8syWazaZKe2jgGhweMHBgZB2DSPNeYeHOKMGc4sjms2/xoMggBovXwP
         mceZyM2DxyOU4HwH9bvDX+sUREG72IOBYKhY2EAlLhASLlP3145/nzC5N5Yqcafse555
         FSA2CrBbXdlLNdYtB9rvAF7KXR/2Ej6L6IljTvInWcNcK2JqB6lj9SMGttnv7rt2aUFi
         91WtaR+aT8US6EfD970iSBPFpFPkqiKnN3EvlcdcoXm51v48aNEwzEDXP0Kw9QIk6yTL
         /kbg==
X-Gm-Message-State: AOJu0Yxr7ceGFR08ddzNL8bdnChqj+njix5FhpxVx5hH+EIXY9/debmE
	VTAOiWpzMCfnmhJFRjDyUbGHJBAri/no6VaH6iTU+OK2tYla9HLMtp5z6fcx
X-Google-Smtp-Source: AGHT+IHQ9gQ8zKo/h+jnQbD3a6ob5gk06mil8JYPtGPhEyMKIXayKCAcqQ2Gt19Gjpywssbi3Qyd8g==
X-Received: by 2002:adf:edd0:0:b0:33b:179d:d9aa with SMTP id v16-20020adfedd0000000b0033b179dd9aamr727898wro.26.1707212985121;
        Tue, 06 Feb 2024 01:49:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d6dad000000b0033b1b01e4fcsm1659035wrs.96.2024.02.06.01.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 01:49:44 -0800 (PST)
Message-ID: <85d3e6728714606c3eac42a561ae89b61457647b.1707212981.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1651.git.1707212981.gitgitgadget@gmail.com>
References: <pull.1651.git.1707212981.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 09:49:40 +0000
Subject: [PATCH 3/4] t4301: verify that merge-tree fails on missing blob
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We just fixed a problem where `merge-tree` would not fail on missing
tree objects. Let's ensure that that problem does not occur with blob
objects (and won't, in the future, either).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t4301-merge-tree-write-tree.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 4ea1b74445d..86807a57d4d 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -961,4 +961,18 @@ test_expect_success 'error out on missing tree objects' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'error out on missing blob objects' '
+	seq1=$(test_seq 1 10 | git hash-object -w --stdin) &&
+	seq2=$(test_seq 1 11 | git hash-object -w --stdin) &&
+	seq3=$(test_seq 0 10 | git hash-object -w --stdin) &&
+	tree1=$(printf "100644 blob %s\tsequence" $seq1 | git mktree) &&
+	tree2=$(printf "100644 blob %s\tsequence" $seq2 | git mktree) &&
+	tree3=$(printf "100644 blob %s\tsequence" $seq3 | git mktree) &&
+	git init --bare missing-blob.git &&
+	test_write_lines $seq1 $seq3 $tree1 $tree2 $tree3 |
+	git pack-objects missing-blob.git/objects/pack/side1-whatever-is-missing &&
+	test_must_fail git --git-dir=missing-blob.git merge-tree --merge-base=$tree1 $tree2 $tree3 >actual &&
+	test_must_be_empty actual
+'
+
 test_done
-- 
gitgitgadget

