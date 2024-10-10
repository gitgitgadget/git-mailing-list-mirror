Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF961CBEA3
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573167; cv=none; b=LC1OFt7Kv08DJr+G77hFpVbQQO74k9EGVSABN6n4kZ08cfYtuehC02LzYx/i+xbQA37N10V96aljgBWjLisr/fPWs8ezKbWwvlB8kHcin1EnhNlC/0RHAr0fohMxdCm0z/A15p+/I6Z618DRL0MqQbTk9tNAHQ/dxdfpIq65kpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573167; c=relaxed/simple;
	bh=jcwjLmX8t7AnFmAHaiNW5LNEhsQfxO/Fc9qO3wjUG+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgoUwGR2PP91kC+/sDaACHQ5BG7LkGX4+3Ap8H4wplzOKAYsjbCJYPnUj3puUqspOkFgHzrwcvSx8bU0EU5CaxUCT6iA0rhUlImP5q3YErn9NXRYN2GsW2I1R6h64ZB4zxXelBM65i/u4VsrHwgAG5Mm8d+bV7FRgyJeZ3gluys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IR7kLYOd; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR7kLYOd"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a995f56ea2dso167315066b.1
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 08:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728573164; x=1729177964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPoZXWJ6E2DcUHGx96X9/W+5FixvmGOwANswQmVlMQY=;
        b=IR7kLYOd3XNw+ctIUVL3OOice0unSopiG1GmtDvLnQ0DFEhgm4lgxPPguF5F4egXsC
         tEvg+0dKHyJnvYZtpBl12kPUzeVplYzgwfS7pPgtqszTQr2pcZEm+VGh8N1h2qqI3zo7
         Q3uomw4aPDPxKh8l88FiOCN5ach0wm+EUtqVmJuz9EmVpDMrXllnbrxx2/Lz6pjtc3a+
         guVZRFkmvZeRMANeSzZteGx3toKlNnIC6jxwMcw5V4vp/mELKhf6h5n4oDQy6+wTD5P0
         fIEP8KQlHlZ8n++rIxUfCAwbDSyJ/81tR+qlGEg2lmDplcDkdgwL/b5WrHgwlSWJzAY3
         3ItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728573164; x=1729177964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPoZXWJ6E2DcUHGx96X9/W+5FixvmGOwANswQmVlMQY=;
        b=RFnfHczFex+CbEkCLE6/CWuFpStETnxvUHGsplnuzHG5Fs3kMvcHD4kv0pj9mn8C1Y
         WyXsFwXlIZhntZ3jR8sepiiUJ4lGgHsoSCl5mcoxizdBkCscNX1l4Gvo7CybNd3wZYSn
         7WbwV0pQDx1ch+acWsTR3a9FGivVnhnu3JaZvXncEH8RZHUUOsxyTa/MitV1nQEJIOC4
         WLUEaRb93qmuHaIKwFc4xJzI30Cl6TYtVl+i9GSBqbDmybeWaoz07D3JNp2fOuQiBvsH
         OW9GgGqI45pXQvkMtWxEJyTIfw/6TOtnc8p/dN7ZkQLThFf/JYkQ6iTiINgjvd2sQ6HA
         8aAA==
X-Gm-Message-State: AOJu0Yyi9FNLq9+8J3oF/j7IOjBq9dQALUNMDocruC+3rKCWLEIGxNRc
	PQUh1/aq+VzOJaj9AIavhjmWFPIJuKqx4J08GxZ5o0NhXVStxNkvWGmolGB5vEY=
X-Google-Smtp-Source: AGHT+IFAb764qamUc++ZCOOcNxc/66YYMrKs4QrW8njOhUy+wdWEewYgVgTrYBxWmq0LsBHU/dgQVw==
X-Received: by 2002:a17:906:c110:b0:a87:31c:c6c4 with SMTP id a640c23a62f3a-a998d19ea24mr614021066b.24.1728573164118;
        Thu, 10 Oct 2024 08:12:44 -0700 (PDT)
Received: from ip-172-26-2-149.eu-west-1.compute.internal ([2a05:d018:458:cf00:674c:b768:6d8:37d1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80ef8c1sm100840266b.195.2024.10.10.08.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 08:12:43 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH v2 3/7] git-gui: Fix typos
Date: Thu, 10 Oct 2024 18:11:21 +0300
Message-ID: <20241010151223.311719-4-algonell@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010151223.311719-1-algonell@gmail.com>
References: <20241010151223.311719-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 git-gui/lib/status_bar.tcl | 2 +-
 git-gui/lib/themed.tcl     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-gui/lib/status_bar.tcl b/git-gui/lib/status_bar.tcl
index d32b14142f..a680452524 100644
--- a/git-gui/lib/status_bar.tcl
+++ b/git-gui/lib/status_bar.tcl
@@ -216,7 +216,7 @@ method _delete {current} {
 # activity, with the context that there are a few situations where multiple
 # overlapping asynchronous operations might want to display status information
 # simultaneously. Instances of status_bar_operation are created by calling
-# start on the status_bar, and when the caller is done with its stauts bar
+# start on the status_bar, and when the caller is done with its status bar
 # operation, it calls stop on the operation.
 
 class status_bar_operation {
diff --git a/git-gui/lib/themed.tcl b/git-gui/lib/themed.tcl
index f43d84e54f..68c999a9be 100644
--- a/git-gui/lib/themed.tcl
+++ b/git-gui/lib/themed.tcl
@@ -4,7 +4,7 @@
 
 namespace eval color {
 	# Variable colors
-	# Preffered way to set widget colors is using add_option.
+	# Preferred way to set widget colors is using add_option.
 	# In some cases, like with tags in_diff/in_sel, we use these colors.
 	variable select_bg				lightgray
 	variable select_fg				black
-- 
2.43.0

