Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050F522ACEF
	for <git@vger.kernel.org>; Fri,  9 May 2025 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746807753; cv=none; b=cogTCjhGwa5HC13ND5oFsHWv3vC37odq2wGcGH7NhHnSbecGd915+97N+8DkGuHP/TO6ang0pwrgQKWnIlFr5qhXgJuopOM8r00fHmVtFSXWIxOc69Y9UhfF+YP8egLr4n4EWhJHsGU1RXvrRcSjzYLcEPUyb1uZLELPdP7ZR48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746807753; c=relaxed/simple;
	bh=3RJS5fl4GO9evsQmEqQAkP57CVPY9+dqY2PtApTJ2eI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qpgmCufkkdxx8WZzhmgPFXnEUftOlr63YSHFSDEqPnjpGiQq6Ue8JHDh8i9D+yrOpX2drOQWP4Qg97Pd07QBKYlzkyg0rJgXE5urMVWWZ7xRjsLXi/VYkVXRRsPGMF0nynIetznM7Cvv5ko2ERPwx2j1btqed0vfQwCGe8BZvpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxAdkahl; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxAdkahl"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a0b291093fso2140516f8f.0
        for <git@vger.kernel.org>; Fri, 09 May 2025 09:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746807750; x=1747412550; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mc46Q0TYX8QurKj58kOdDUrxrBtJJOdqWu/TbDg2574=;
        b=AxAdkahl2qC38v2BhQY0PUQV008hfH4yOpSRgtjFTwAsW9U6qHQje0b2rtiBxFYKa4
         +KYm6p/7qK7yN8M1ZNN3PpBptjdHI75dJGUcU4Xy4ec7sjnH/Yn7rVitUNEygWP659xo
         UOxjTtysjvD/wP9xNHgQlaBspg4cd5dizh36G1s6aCGx7AsOkZyIRs+ETdpiQuMuVBgb
         HzB7V6p4yrcTU/uQRVpVAi4uTIe3ycq+jXPAb2VXrIJEC5NkDMdQzNCx/DC1HBcdx70l
         imcWAXswAa6EvQDInie6129SmNEDPckzAXYXZf8XUm7MZj4/TIfJamLyBHFVajO5r4sz
         ZDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746807750; x=1747412550;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mc46Q0TYX8QurKj58kOdDUrxrBtJJOdqWu/TbDg2574=;
        b=IdMKQRK5uPAox9ApsRULbgVL88M20ygzZ48TOg6dFRrwtTU9CxQtq1iA8lKZTRoNSi
         l33uoZhS/V3a/35Y1Zd9JsERQP8ECZ6A0YLjkAFDhowkP7OL/7UikWv5X+E76z5puDtX
         qzCS/6/5fEAuhTnfQy6v87LvVvSOszb/fSTYrQ9B+XbjNm58WJEJb2gKsNFDL1UDMScR
         4rTknirgrNgXvaj6O0/D6rGM+bjTgpf/j1odIG8CUTa5Z4hk83FeOSoiD4Ahwhn/644u
         3m/+ZmrF3ydZvhLeYLt84BCbrIyZr5NLiswKXfuUCoZHsDTQrHplRg/YftopaE1zajJ+
         NWMQ==
X-Gm-Message-State: AOJu0Yz6A3JwLWr91WGgyj19Zjm5rOFQFoyp0TO6u3WdgHblUKppPRgP
	nZCIeP5Af8yZ4xmBKeJgaK9FrFLtnqCTf93KEe26Dw1Xkj0BnthT5GJuWQ==
X-Gm-Gg: ASbGncv4w8jIZAcX6UcJ+zDVCzFqvystzk5iasa4Kne5LbZqvqxZ1c/92KPyWyVhHre
	y+bAP1kERRFYxyUU0HHt8+rZxCAqCsQI2NqZIuP5WnDNexir45RxmHGWyR0lcmuoU+/YGqOSqRu
	BrdwsP+5Usv2KSLviWB3T8yknPPmrPFjldl9kj5SEmr7V57lCwjMcp2BVGiVzMVcHvUuNqx5Ils
	nopMBRMz0D33NMVu10LYRH4DCrUTM9HTMcT6HEtBCxByuEd9aULOGlowQmGRLWlBFouCm3aaAHL
	ur7BjmU7KzR3PZzQsprcOVEGg5kiSO5UDGWvNqmRtA==
X-Google-Smtp-Source: AGHT+IETyDDj1gw4NExTdl4SeElQMUyeIQOc9nX+yKppxrFWuawhqHrwVJ9D2N/Ezunqc9fqyE4fDg==
X-Received: by 2002:a05:6000:2909:b0:3a0:b941:94fe with SMTP id ffacd0b85a97d-3a1f6a0fbffmr3391161f8f.5.1746807749610;
        Fri, 09 May 2025 09:22:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c5b9sm3727470f8f.91.2025.05.09.09.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 09:22:29 -0700 (PDT)
Message-Id: <fa5442cb805793adfe1f0b26ec79a75388317d2b.1746807747.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1919.git.1746807747.gitgitgadget@gmail.com>
References: <pull.1919.git.1746807747.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 May 2025 16:22:26 +0000
Subject: [PATCH 1/2] sequencer: move reflog message functions
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
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Jeff King <peff@peff.net>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

In the next commit these functions will be called from pick_one_commit()
so move them above that function to avoid a forward declaration.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 66 ++++++++++++++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 9ea678364d4f..bb4667190db1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2226,6 +2226,39 @@ static void refer_to_commit(struct replay_opts *opts,
 	}
 }
 
+static const char *sequencer_reflog_action(struct replay_opts *opts)
+{
+	if (!opts->reflog_action) {
+		opts->reflog_action = getenv(GIT_REFLOG_ACTION);
+		opts->reflog_action =
+			xstrdup(opts->reflog_action ? opts->reflog_action
+						    : action_name(opts));
+	}
+
+	return opts->reflog_action;
+}
+
+__attribute__((format (printf, 3, 4)))
+static const char *reflog_message(struct replay_opts *opts,
+	const char *sub_action, const char *fmt, ...)
+{
+	va_list ap;
+	static struct strbuf buf = STRBUF_INIT;
+
+	va_start(ap, fmt);
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, sequencer_reflog_action(opts));
+	if (sub_action)
+		strbuf_addf(&buf, " (%s)", sub_action);
+	if (fmt) {
+		strbuf_addstr(&buf, ": ");
+		strbuf_vaddf(&buf, fmt, ap);
+	}
+	va_end(ap);
+
+	return buf.buf;
+}
+
 static int do_pick_commit(struct repository *r,
 			  struct todo_item *item,
 			  struct replay_opts *opts,
@@ -3919,39 +3952,6 @@ static int do_label(struct repository *r, const char *name, int len)
 	return ret;
 }
 
-static const char *sequencer_reflog_action(struct replay_opts *opts)
-{
-	if (!opts->reflog_action) {
-		opts->reflog_action = getenv(GIT_REFLOG_ACTION);
-		opts->reflog_action =
-			xstrdup(opts->reflog_action ? opts->reflog_action
-						    : action_name(opts));
-	}
-
-	return opts->reflog_action;
-}
-
-__attribute__((format (printf, 3, 4)))
-static const char *reflog_message(struct replay_opts *opts,
-	const char *sub_action, const char *fmt, ...)
-{
-	va_list ap;
-	static struct strbuf buf = STRBUF_INIT;
-
-	va_start(ap, fmt);
-	strbuf_reset(&buf);
-	strbuf_addstr(&buf, sequencer_reflog_action(opts));
-	if (sub_action)
-		strbuf_addf(&buf, " (%s)", sub_action);
-	if (fmt) {
-		strbuf_addstr(&buf, ": ");
-		strbuf_vaddf(&buf, fmt, ap);
-	}
-	va_end(ap);
-
-	return buf.buf;
-}
-
 static struct commit *lookup_label(struct repository *r, const char *label,
 				   int len, struct strbuf *buf)
 {
-- 
gitgitgadget

