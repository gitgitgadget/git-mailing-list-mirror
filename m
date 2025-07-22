Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93B82D12F4
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753171967; cv=none; b=tf973/ofGJX6jtjAo71JPGndcKvgj+powQF49ch2vbFVk/tFepWSnELh9NQWRuhbuId2H/m2TQ8BpOxkVBNcjPbgtP7mDIO6w2J1aN7JtymBNaVwwwSxLiN/WZye9B/zMohGDebkenffqHRwl8x406kdbX1TKskyXiwbBiIpPSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753171967; c=relaxed/simple;
	bh=2vmQWl7Wto3To2iYYFlySeAcrXujAoH17S8TsvCJ1nk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k9shg1WZYL6vnx3iP3hG6Q1BsS3SVkgMBY0iw6ChRqOaL6GVQ8t96qRVaj83UnHrPXyg4M8PT2UVuEn4dxpwtVURbWd5TMJcPqE9R5a6YRlKFUqBuq+sTX6G/z47CYxNx0BfhNQ2F3VUJvVcMNzrlO4bViPPVPBZAaIulWczR3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQmgAjIl; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQmgAjIl"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-313154270bbso5087510a91.2
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 01:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753171965; x=1753776765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSBZA1DXkOqENfqiwCB5f0JP2C2bZpMnlVqJwj34kdM=;
        b=DQmgAjIlpukecNLY9JLBZDdlXijH8aiO2TBe2osTVyiRYCG/hjnqb177zXpHIw1Y8I
         YQLoG+fPBOn5dB6imSFd2RPq+DrcTfqNbPU/ENtl3yTDjhVprx4nqAXD+gE6g8qSa7J+
         dg6ONKcW/vik/Tq0mG1JW7tqIdeURRO4ttmo33r1i5ui2q5Qxr7DVsNsO2xPewqp4+AP
         fEFoIH1cHQ+rWmxvVxMQZ+8osbUIoggImTfK+rUHYabQJNkT4tL64UMIbZh+j6ZIGCgT
         Ak+Ynso6WqZa6osMJh2Pye7VqC0bbiUiQkiETu8PfUlEZyXRuQRaHEsBsZlekFwFUNwV
         kC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753171965; x=1753776765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSBZA1DXkOqENfqiwCB5f0JP2C2bZpMnlVqJwj34kdM=;
        b=erHEVtBIqzcjRQpqqO6aooWO9mmDY2nymH20FV8/ngApc/NW8Q2hjQy8BUOLcb3W06
         87drjXoG6Y0aqOZC+vK7BwNsfYvM6RFCwLfL5yZoix0/pG0MHVOSwi52BJhIUvCNaRC+
         qZdxYG+PILkal9edlJBVWD0lZgQYghdA77diAEOQt9HFJh+XGSvL8vBGZ16FDT3awM6r
         RVrapHHCVRl8uCzVMCryFU+TKADgZp5Q7c8O79umXjXm523cuM5RANRPm9jjUoV94Spo
         RBLiFie+c2frKaLaupbnYSeY0w7iGxCb8QdFGGfK8iKx03P/a/OVJcd4A48noGP5Qo8M
         CKRQ==
X-Gm-Message-State: AOJu0YwrPj7446KcP/kZ6O8RfPdW8LZahmaw0vmQKrm1pBhEchQ4IR/j
	l2AEQyMxQNezRf9BgSnRJ049lT4ht+k7kxQdWOwqdi9S19eKns7eslnQnjBKV3zz
X-Gm-Gg: ASbGncukXyfkhWIPhwD/J2cGyuQdN2BLlirkOB2EeSaRnu0fkspBiDBvKxKrXO7DmMU
	oUtEOhU5f+aYI5RycGK10AKbhrbfTzkxsPx+XJ1DF1PlWxqoQc2/F4Tbowra5U4xihrgcxSnlvQ
	lSKJ//uVhj0yGBPGTqNU/EXUeBm5OdaSz7khMyH/743Mm0cpph7DoYU30WFGVvCOMths3FYkhw+
	qYBimAn0QCkbkxLiZX3+FWw+1YwBtBrxlk4WnGgzQ83Jp1Bx1+r14evCBN9QlTI++zqOvXpff+b
	asMzkA04fVguGh1YQIGUxTYMXRBhK09cA6DECwokE/tyQMVyp8HpWBY3pr7Od5ivxG5BTFrnA7H
	k82EgsXEZfchFC9BafxHVFCEwMGdG2mE2dQYC2DJgqFKH
X-Google-Smtp-Source: AGHT+IH4fzAGqXFd8rrlSum1GkTpMR+lZD5ZJwwVmQzQKXHmRPP3aRDq0D+mf1mA4LOlkmLtXnvwrQ==
X-Received: by 2002:a17:90b:5385:b0:312:e51c:af67 with SMTP id 98e67ed59e1d1-31c9f3ef43cmr29091595a91.1.1753171964708;
        Tue, 22 Jul 2025 01:12:44 -0700 (PDT)
Received: from localhost.localdomain ([211.37.148.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1b8f89sm11584538a91.9.2025.07.22.01.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 01:12:44 -0700 (PDT)
From: Hoyoung Lee <lhywkd22@gmail.com>
To: git@vger.kernel.org
Cc: Hoyoung Lee <lhywkd22@gmail.com>
Subject: [PATCH v2 4/4] t/helper/test-delta: close fd if fstat() fails after second open()
Date: Tue, 22 Jul 2025 08:12:19 +0000
Message-Id: <20250722081219.1086866-5-lhywkd22@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722081219.1086866-1-lhywkd22@gmail.com>
References: <20250722081219.1086866-1-lhywkd22@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When opening argv[3], if open() succeeds but fstat() fails,
the file descriptor is not closed, resulting in a resource leak.
This patch ensures that the descriptor is closed on failure.

Signed-off-by: Hoyoung Lee <lhywkd22@gmail.com>
---
 builtin/archive.c     | 3 ++-
 t/helper/test-delta.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index c919a39f90..951fc2e444 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -13,9 +13,10 @@ static void create_output_file(const char *output_file)
 {
 	int output_fd = xopen(output_file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
 	if (output_fd != 1) {
-		if (dup2(output_fd, 1) < 0)
+		if (dup2(output_fd, 1) < 0) {
 			close(output_fd);
 			die_errno(_("could not redirect output"));
+		}
 		else
 			close(output_fd);
 	}
diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index 103bf7f3e9..ba2d897aa3 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -46,6 +46,8 @@ int cmd__delta(int argc, const char **argv)
 	fd = open(argv[3], O_RDONLY);
 	if (fd < 0 || fstat(fd, &st)) {
 		perror(argv[3]);
+		if (fd >= 0)
+			close(fd);
 		goto cleanup;
 	}
 	data_size = st.st_size;
-- 
2.34.1

