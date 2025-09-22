Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477081922F6
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 01:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758505164; cv=none; b=ThH6U/ujVSCBVUX1C5iuxaxKxhyIRo/Py31ipSsSLgvMYMVN0uohkBt05jvS99lZ8YFENVYrOuBYnhlLPDS5aIa4HPHUzBIM9pzprFIUUGo89Z6qlYMsEQiLEwdFjq1hReiZ77GdMZWVznihR6tMlxisDt01v492DW3ZvLLqY1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758505164; c=relaxed/simple;
	bh=tjDm00X51D+soRcPSfusFfQ3kozU4ElPqn9bKZ9nIQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LI5nDc6qkBCrtYA5gw2dyCyO6EqXt2yby2mt3/e+5S28hzbJ59PiYOLEu/QBt9dfBuMZXm8Rv6e+bPXSy+nRh+O6OAZB2VQqi4UHiYxXaFomAhwHlx1Z0BzrYWscqMTq3xrhZqJqrZwSA40W2X9CZiliQWy4uvkingEGEKaVyWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdyID7u2; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdyID7u2"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-ea5d856ac28so2655923276.1
        for <git@vger.kernel.org>; Sun, 21 Sep 2025 18:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758505161; x=1759109961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Esk++tH1jEYsfXOsP1JttRh39Gshc8kyJov4m0nkA0o=;
        b=OdyID7u2XVnpr1HwTJsQIF7neOZ+vGvG+VO8RnhbOAEOqHvsOzVLTZZQTKdnYlrDXy
         D020NsPtaAZF0y+geybLvrozPBmZgEFEW1k7R5cTaEYPRXvj60+YN+4xivKth368koEN
         /GhLvqdb3hmhgTXr7rxvmGuZeGAPseq7d2GHqc4VVCYlrOobBc4A/kMm+Q1XWToMe/zY
         vGkGChNMM9Iopv/FzvicMSn3k7tkpOQnBKzfU1/v+py+EEViHxzF3JH/turG6zggNKlr
         pJF50tIc/QSy3339xXQRd6YhzQZflPdZErv+jnMeS1CBBobtURo3Ki6UN6SRPZ+Q5XXI
         FRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758505161; x=1759109961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Esk++tH1jEYsfXOsP1JttRh39Gshc8kyJov4m0nkA0o=;
        b=VS/TPUEuiIvRFEuUxhnl1vUVv6NkcF6pfYEveqVsmrfPeXMYRbZEBGs63a1kd7lDLb
         WwkybypNoivb1phqXYuDtJ6n2vvGxs98/naHK+xV02lAh61M9gd0MuOEr2WUobvepdW7
         AyVE63vkpD1aWpEN94icdvQU0WSZojOrYxx4uQiKIM2KLV7PvBRv6so1YLMBh1/7vxZL
         5RAfRBuLoPQDHvQjtoSR4f/sYRmqrnRTmzMRcmOIi5bK03H111/dRJrykqL6MJALQxxJ
         lm17aEP2epBM4uVuh43iG47JkPTXjf85o0I5WCLKjMp2+T/QBRL2BYukZaxs9rv40QjC
         f0XA==
X-Gm-Message-State: AOJu0Yx/k4bk8BTLHtxmq/5lJssBn1CSOjGAfpx6A+YTzQaN31f6fSOE
	+/PEY6r9hzswUXkbgFvJnYYFTemZkPoyEqQ6GgifuqSdwGL/twJj9EGiFcRuMQ==
X-Gm-Gg: ASbGncuxBOqtNlfFzmJKaYFWff7bsysxaDzvxaPQMxAgK4LgKVPbrp1aOJDkIYCjnDq
	AwPSLg6J7M1++AJDiCfeDgN8Tj0dkuzJMTSDpnRwqPoyrsO8mTSuw5F8XdbMzh32JRoxaOmMYiS
	kJFaNZqNoaZ3FQQeDlWzsD3zynKQsa8d0aKIZOhxXWIdBEA9ta8s8m6Qxce1bHWmCh2Kd5Jb9Mu
	rdAdVk3DsnK+Ugj+x5HjOdEVmjrOBToZ7U7wI0ffIOdbSrSMVutQmSyztS4mpRCQg00be7w3Nxl
	2MV5hcoFF91hYkvMUKAAu9EdC6wgtyr+j7AxdqFso7G6Xds/Uakc3/xvwtlPtuWXT4OnWyJV64M
	vQtCx3euim5r4B7PajSKDByEeU+hLeJyok/pfCG9CewDXMqcehg7wMWfbMHleZtjO3QLS2gqYT5
	xweQ==
X-Google-Smtp-Source: AGHT+IF/TyyIDkKWQBLGEFikMM+Qq3g37t++6vOqhcp/YDAqOt7hfyzKbUFGpjTG+3aXe8oVrRTKRg==
X-Received: by 2002:a05:690c:48c9:b0:730:67c0:eff8 with SMTP id 00721157ae682-73d0b595ac5mr101881507b3.0.1758505160894;
        Sun, 21 Sep 2025 18:39:20 -0700 (PDT)
Received: from localhost.localdomain (69-77-149-20.skybest.com. [69.77.149.20])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-633bcd05dd7sm3942069d50.7.2025.09.21.18.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 18:39:20 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Denton Liu <liu.denton@gmail.com>
Subject: [PATCH v3 2/4] t3905: remove unneeded blank line
Date: Sun, 21 Sep 2025 21:39:04 -0400
Message-ID: <8ac06ad62df581bb84ecdca0b0144c218daa0733.1758505011.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1758505011.git.ben.knoble+github@gmail.com>
References: <cover.1757982870.git.ben.knoble+github@gmail.com> <cover.1758505011.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is leftover from 787513027a (stash: Add --include-untracked option
to stash and remove all untracked files, 2011-06-24) when it was
converted in bbaa45c3aa (t3905: move all commands into test cases,
2021-02-08).

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 t/t3905-stash-include-untracked.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index 1289ae3e07..7704709054 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -87,7 +87,6 @@
 
 test_expect_success 'clean up untracked/untracked file to prepare for next tests' '
 	git clean --force --quiet
-
 '
 
 test_expect_success 'stash pop after save --include-untracked leaves files untracked again' '
-- 
2.48.1

