Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096F827F01B
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 04:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763354115; cv=none; b=P8QgPCA3g2gQZbuntrpX27omXsHSuKB3VOAWfk2CkGn5elfh+dVVMoj3XkkTUzt/EeTdyeF6K1HW3buIGMyZmpDjPSlmJwwYPVTZDvULKjEwIIiW7xpn5X4nCO5JCL8jOv/ByRtmOr87mB+0zEahCh8lBNWI1F+xNR0jxBS/YWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763354115; c=relaxed/simple;
	bh=YQ6VgwhjUWmbMUc/WkDfiQROBlyxVr5TXdC62kYaPeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNuuB8uTZ0upYx9ZG2CZmtc5v7tezyAVGDaey5xg8FidumTIwU5eOlOlY/qk99n9rseW6zhwD/RbQPGMCvlVvpiGOWhVKM3L3YKR2i+RQz+fAqDncTyYcbtCKQDVFSIXg6m3edECgqNoQtdOgMYF8sheEx7bfbIIJbSvl3zRkwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzt/uB9c; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzt/uB9c"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42bb288c17bso798115f8f.2
        for <git@vger.kernel.org>; Sun, 16 Nov 2025 20:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763354112; x=1763958912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiGToah1Pzc+gZGukoWLD/qI9OfcPAVNXPfowMMgkPg=;
        b=jzt/uB9cbv7M2GEcTR0teiUwNaRPrUyz8OljkpjfMwAnF82dHLI3w6DqUm0Ku99HgB
         FOUgsz1pO8Zr8hsZvpJ7gMX+q7KrJrX2TGQowVHuQpNRxg9H6Kz+4lcairWSJzX7i3jl
         epWcPaLtUBvK7pQHOU3zKqMierRLXZPj0C4hSFlhfibk/9xz7ZRpBqHUQOQbegnckQNF
         OjGN5b7pHwcBXwTDXo4SrLuWcLHztTdthscqpl7g/2M1vQj3ybLVJOjI2/6IixaEedLo
         IJ9muf/emAlBwe/zX+57cr9qafTnZtnsB5fPhcms+O6l5ogXkBiLBjzXHIbtWm6+jSBr
         Q+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763354112; x=1763958912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uiGToah1Pzc+gZGukoWLD/qI9OfcPAVNXPfowMMgkPg=;
        b=GGCN76wHow9/OYnFlx2Tq+ho5SvrBZxZ8r4TsO9ccD5WXydswoqPc4b0iJusWyMGbi
         r7eGavBgYu4mNcF2Q/bDtFQic6Mqg20vvpDZ/Pm6R+eXMasp65o/+bGROA2ry6uJGMTM
         vFBFHt41Jq7pqzxRATn5R7P2+WqN0fjopsftoDvAbnLS+Ot4lRzTKnM6w7FVCI50XPqH
         Olt8dcaYAvNHp5Wnx4KnuPmVcHzdrFxxGpUypuqIrQ8Yrs7hPUdaGqEjgMDcJZmNPGf/
         Eu0+Xa8vbF+Wn2Z+Q3PG3COWmyXU3iXdCjuyI3+Z4BNjn5xe6KhkxbJH/a7JhnlBtu2n
         VWGA==
X-Gm-Message-State: AOJu0YzTfAIn1so07voQsCqqQRJ8mGZ2HfuYy9Fo1D3ZQBfDJE/lZKcx
	Owob9Op2I92MJyYKy5cGCsbF302T3OdKyuzfkWD3y8WRxNda034NZ0gEs8rclQ==
X-Gm-Gg: ASbGncvY4VWbCZMUQFNlRtDI7SMziY5ArUdy0YQfosso6lMFy1hG5dwXC1hniR2dLb/
	s+aAXhOZJn0zQp0d6aJJnYHUaudrUN82Z+M+9E55/X51M/z1WgvLWmqymrRpjEVrCBYINzN8Smc
	4mcp4p2IBfrhane6WUnnDQpXFHq6A1ZxpEkPMzsA88cIe6SjZBn9GQuJM/5Qhi60YBYxnoCdkEz
	Axq+eCeUDlY0hFC388+xuQcu7gryoouUevgTFN2Tf90AxXZgy45klTw7+QQ8BLq8t27u5Ql0IwG
	40Wo0ySi/CPcrE+uQv1ulWykemDCspePMSOLTLpUpWTIXyuByy4/q5fXTc0vovFxMCxRifhVKGb
	TgVtgr+ld8EwM4UebR6X3Oo8gHRIvOKDjkwvoPkJN6nmx5XBaKqNB0mkgAh44V25t9rdD4aaejy
	m1xhA6dHzi6xS2XquWca8xmIBWEXU=
X-Google-Smtp-Source: AGHT+IFOsbY5s6ELpfEn0YHfJQkUIsNLe07T2aX22MNKSrSfriS/JxW88JFYdpg0TW+BNXWJAC9mlw==
X-Received: by 2002:a05:6000:228a:b0:42b:4223:e63c with SMTP id ffacd0b85a97d-42b5932346amr10729179f8f.11.1763354111812;
        Sun, 16 Nov 2025 20:35:11 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85627sm25115284f8f.16.2025.11.16.20.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 20:35:11 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/3] fast-import: refactor finalize_commit_buffer()
Date: Mon, 17 Nov 2025 05:34:48 +0100
Message-ID: <20251117043450.322644-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.52.0.rc2.6.g1f299c9613
In-Reply-To: <20251117043450.322644-1-christian.couder@gmail.com>
References: <20251105061918.3688870-1-christian.couder@gmail.com>
 <20251117043450.322644-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a following commit we are going to finalize commit buffers with or
without signatures in order to check the signatures and possibly drop
them.

To do so easily and without duplication, let's refactor the current
code that finalizes commit buffers into a new finalize_commit_buffer()
function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fast-import.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 7c194e71cb..cb0d2f635e 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2815,6 +2815,18 @@ static void import_one_signature(struct signature_data *sig_sha1,
 		die(_("parse_one_signature() returned unknown hash algo"));
 }
 
+static void finalize_commit_buffer(struct strbuf *new_data,
+				   struct signature_data *sig_sha1,
+				   struct signature_data *sig_sha256,
+				   struct strbuf *msg)
+{
+	add_gpgsig_to_commit(new_data, "gpgsig ", sig_sha1);
+	add_gpgsig_to_commit(new_data, "gpgsig-sha256 ", sig_sha256);
+
+	strbuf_addch(new_data, '\n');
+	strbuf_addbuf(new_data, msg);
+}
+
 static void parse_new_commit(const char *arg)
 {
 	static struct strbuf msg = STRBUF_INIT;
@@ -2950,11 +2962,8 @@ static void parse_new_commit(const char *arg)
 			"encoding %s\n",
 			encoding);
 
-	add_gpgsig_to_commit(&new_data, "gpgsig ", &sig_sha1);
-	add_gpgsig_to_commit(&new_data, "gpgsig-sha256 ", &sig_sha256);
+	finalize_commit_buffer(&new_data, &sig_sha1, &sig_sha256, &msg);
 
-	strbuf_addch(&new_data, '\n');
-	strbuf_addbuf(&new_data, &msg);
 	free(author);
 	free(committer);
 	free(encoding);
-- 
2.52.0.rc2.6.g1f299c9613

