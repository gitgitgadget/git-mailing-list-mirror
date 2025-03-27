Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D45214237
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743079435; cv=none; b=DMCD0x8stFfqP+C6QMfzj6CiZjgqT3Thj9xndZp7U4kyqoZ8iiFZ3yelCy6tz0m8YbTnobEISdDF1EwY72OFnmnsVib4PmYtEnxlU8E7ObaLBscMtU5shiw6ctGoDhR8zvbUm+i8KOpWckPcIPyB90W86a+syZg5b1VvHxCuwQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743079435; c=relaxed/simple;
	bh=Kg5guTj7z3k0Sk8f/D7d8YF9DG+QJlE1rLnkUJVH0uQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GWpHBHsJQTlQ5CwdSxVW8lx+Z1XNAYHiA5vtLsn8JDZ0jz+NyOWgZx8YhEVIHBaeDSPu2cFmPAPxhvmspQCQ65p4xG3Lr1lAU+4bnieNTOhpN362dpIArvdC0XA8+QxVH+puakRqytq/RkNIK9QMpxuj0OgMm53IpKVxVub9ZdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQt2U0OH; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQt2U0OH"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso736517f8f.0
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 05:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743079432; x=1743684232; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdOT8riMmqjRURfNW6rleSdr9eyCDsduvKrjayluV9A=;
        b=DQt2U0OHOFQbbJkY127ghIZtMfLnh2RM7FtK+N0wFprR98MnD4s02UCmwczVZbWz8G
         aCtJ+jeP434zne4ahlHj1z7xPBzHZ0l//UxAtQ6IcQGiWleiaFr2WOYm1DSrjTYl8fGC
         +p7+49WYtYJFDDrBxqRt/KiDaTSvl0SrOMK5QROeYdm9fXcemdC6y9JwYcEvXn+nQnSH
         HeXhNXAluFGw6B89KVkJ0cgJp/OcbtsoQNOheLHSk8sslrJJ2tdie/7jqFBby1pd+plx
         E+K380h1NJmjS0N13MYA5z3cMHI80dm/zZiEEqFttHldrASwiN5KMRTDUapikfrtxHMP
         6hbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743079432; x=1743684232;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdOT8riMmqjRURfNW6rleSdr9eyCDsduvKrjayluV9A=;
        b=PF7tq1TtjcPgQVbflvfTMaqBMqxAoUPann7sahRigkgtBhiPMR15OcfYfA+iRemqrC
         b+Ic420D7vw/RxNbRknRkRFCATt7v436/bOYUsS5vczZ1zEPkEIHxekSaBsu8xHpyPGj
         uRKgdNBBbE+ae6WqrWqBpdMMV+gq5EPQTWY9rVLFmY4ZV6qaBAjQy6+eUOUZNoLCAGvA
         PjH+hxF2S1cikAsyB9gBcSxgiv96U7oKusXBTK/+1ebBX5gRZ/I9eOKiGiPOX1BU2nsV
         0ExsXqYD9jmWoQXSZ55rWcKBwZMIYekMrXEJRQdft/HRtIoqIxTDCwMPbhxUZvGB3vQS
         6j4w==
X-Gm-Message-State: AOJu0YxRMbko7UzoFk43lH1BKRk91l+C0LRzYEQksduNRYjBSS+ntAPc
	++eZ3pxW3gcyQgE375DnKQNq+2HCMgwlriHy9TGRGWxCH5TRlxA6YJANMw==
X-Gm-Gg: ASbGncu8aIV9wcwKqK6UWybg21nyF/69UYWl0TJEmIahTROloIL8eZveefVBZ/qhErF
	HgNL/S/SILAi0TlG0JMLVKnY277bz//4mJd+jY4z3aZED8jUMHS1fVFN+wBpB4VNNnmQT/Tr4bc
	Ze6sRJc/CqtTb+j370rdEq5BqDCSLU9PUVIzvu75fDGNMQL2SUtLN621Q19nhf08vigOQxuwVlQ
	uvhOhRQ0sJNWzze/ysyulereFncxmD3WepxoOwjwTuVCXSyRRd5++oAucTSdytSmr/YwRcw/P76
	Qi9mLu+sBs0/+A/tUiJGbZdU42IJ9jYt1Can5jIkGn89JA==
X-Google-Smtp-Source: AGHT+IEiRMq7yHlUKBtuXUM3tGTkeuN6eYbnAbmtVrhAlqEiLeIQTUeNgiyMYkpWYp9y9kQba9oUlw==
X-Received: by 2002:a5d:59a8:0:b0:391:268:64a1 with SMTP id ffacd0b85a97d-39ad1773ab0mr3408260f8f.48.1743079432131;
        Thu, 27 Mar 2025 05:43:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3af8sm20085658f8f.31.2025.03.27.05.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 05:43:51 -0700 (PDT)
Message-Id: <575b4b2c2b8a5e800bb65b99f1fcdd6aaae63f94.1743079429.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1888.git.1743079429.gitgitgadget@gmail.com>
References: <pull.1888.git.1743079429.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Mar 2025 12:43:47 +0000
Subject: [PATCH 2/4] fsck: avoid using an uninitialized variable
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

In `fsck_commit()`, after counting the authors of a commit, we set the
`err` variable either when there was no author, or when there were more
than two authors recorded. Then we access the `err` variable to figure
out whether we should return early. But if there was exactly one author,
that variable is still uninitialized.

Let's just initialize the variable.

This issue was pointed out by CodeQL.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index 9fc4c25ffd5..ad04b24ff13 100644
--- a/fsck.c
+++ b/fsck.c
@@ -925,7 +925,7 @@ static int fsck_commit(const struct object_id *oid,
 {
 	struct object_id tree_oid, parent_oid;
 	unsigned author_count;
-	int err;
+	int err = 0;
 	const char *buffer_begin = buffer;
 	const char *buffer_end = buffer + size;
 	const char *p;
-- 
gitgitgadget

