Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690BA6167A
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 20:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857551; cv=none; b=kB6LFvtf1zAKCKByFWPi15j0caDbnnCk0oKK+EJU7Ljf3PG0Zvkpl8zptA+vLhMwgsK3yiM2erps7FXNitx+o9j6216Id/3hwCkHbHSG9TROq+7k1Z4gJeVIotkINg8bLP77Xeykc/pgPpKrG3uq0KckNDltnqClvAVoeL25JF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857551; c=relaxed/simple;
	bh=bi2xudFPH1xU2Ku1xgwGbJ29eP0POJlfpO7PAAL3koQ=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZrLJcOxm6zt6AazBrn+mypu7lWsEUmiyk+WmBo7UKKPz9niBaKoDIb7Mltxp1v7RS5Q54tkbpuCA1tK4rING5e8q/469KHE8JjVIYFnxoOKX2zeiUs6ENhisQfigycj21gSUB6Cbio2oQr8+j6/nMF7/U5IBvaujoZG+zdC+ukE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BD7kXLOS; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BD7kXLOS"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33cddf4b4b5so631044f8f.0
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 12:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707857547; x=1708462347; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6klzPN9QiZfeeLoJvk9reIAEWsNTdN1aOH6ZB4dLCpk=;
        b=BD7kXLOSieysQXPVOuY9A2EtODhexJaP7/ExfMXQUMoUHxquBTL9Bha/S+7ot1tLHa
         TLLYF6OVFxi7Kf7oouZxYpgdkL98u/82F90DobTW9MEs8XrvzFEH6Ijp1E+e0M+St0ee
         hw71CUZfeX3bqNcxVWftPtOGchFiQVNyfqfx5C1Z0rCrk8cMSRe8qOG33N66LIpboIbS
         zj4JhMBg6tLh48KPRDkGUEK/yp5NozfChQ95hGIU1wD/TqjFUQpUOXyu9choryG2KkUi
         afG0m9UVpHxCZnksGmN9hj6LlyDXE3421yIAgjVAYfrXfpX1J6uKwhfseaGGMsmUdbCJ
         D83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707857547; x=1708462347;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6klzPN9QiZfeeLoJvk9reIAEWsNTdN1aOH6ZB4dLCpk=;
        b=ZHCpVlI4yzlwiXOEL96tQWEfXT+mXrHNNmC1sJyi0Elg01sYW+0Vq9XI0chiYEbbg8
         JbO2jH1EqL/wPQquW2JP8AEB30vpt9ArnXGkJoqyXjF79Syz9HqLW0D5o26rEd6duMu+
         o12pHDYFlbXJeYRiCzz3S1bwgw6fJp6mT4y4WkQmBhkN5EiT8/zaU1PU11Vvc/y6Ry1B
         r908rG1rXfmUVZOAAXBuu28aHx2j8mLTiNeQxrL3nCAVFODr8EI/wr+pWPibxet6HY2H
         mp29cQxaRS9dPf/R1rx9JmzRaAv/sBog7wUrRoTxjuUszflNVcDfLx4M4ROWl9705qw1
         y8EA==
X-Gm-Message-State: AOJu0YzT1kgttsoG5Segi8BJxl/xebetcFEGH3wIBYmb3j42sf5uaH9z
	NHoGnFiGFyUNttqTQTihMKG/EisPOnPS1FkzR4kQc7Y5E6CzPlt7Elo0G2N9
X-Google-Smtp-Source: AGHT+IHaPniENavKJbFbp4uasKWQM8asn4y9yjsKStVtVKiP/jHMCEzO7pUkcI+MZSmBxbleJ/lT5Q==
X-Received: by 2002:a5d:5143:0:b0:33b:457c:9b06 with SMTP id u3-20020a5d5143000000b0033b457c9b06mr340545wrt.28.1707857547391;
        Tue, 13 Feb 2024 12:52:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c470500b0040fdf5e6d40sm12950237wmo.20.2024.02.13.12.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 12:52:26 -0800 (PST)
Message-ID: <0896d4af907d71df29b0c4f5a27d24ea80b3c0e1.1707857541.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 20:52:14 +0000
Subject: [PATCH 05/12] fsmonitor: refactor refresh callback for non-directory
 events
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
Cc: Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 fsmonitor.c | 66 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index b1ef01bf3cd..614270fa5e8 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -183,6 +183,42 @@ static int query_fsmonitor_hook(struct repository *r,
 	return result;
 }
 
+static void fsmonitor_refresh_callback_unqualified(
+	struct index_state *istate, const char *name, int len, int pos)
+{
+	int i;
+
+	if (pos >= 0) {
+		/*
+		 * We have an exact match for this path and can just
+		 * invalidate it.
+		 */
+		istate->cache[pos]->ce_flags &= ~CE_FSMONITOR_VALID;
+	} else {
+		/*
+		 * The path is not a tracked file -or- it is a
+		 * directory event on a platform that cannot
+		 * distinguish between file and directory events in
+		 * the event handler, such as Windows.
+		 *
+		 * Scan as if it is a directory and invalidate the
+		 * cone under it.  (But remember to ignore items
+		 * between "name" and "name/", such as "name-" and
+		 * "name.".
+		 */
+		pos = -pos - 1;
+
+		for (i = pos; i < istate->cache_nr; i++) {
+			if (!starts_with(istate->cache[i]->name, name))
+				break;
+			if ((unsigned char)istate->cache[i]->name[len] > '/')
+				break;
+			if (istate->cache[i]->name[len] == '/')
+				istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
+		}
+	}
+}
+
 static void fsmonitor_refresh_callback_slash(
 	struct index_state *istate, const char *name, int len, int pos)
 {
@@ -214,7 +250,7 @@ static void fsmonitor_refresh_callback_slash(
 
 static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 {
-	int i, len = strlen(name);
+	int len = strlen(name);
 	int pos = index_name_pos(istate, name, len);
 
 	trace_printf_key(&trace_fsmonitor,
@@ -229,34 +265,8 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 		 * for the untracked cache.
 		 */
 		name[len - 1] = '\0';
-	} else if (pos >= 0) {
-		/*
-		 * We have an exact match for this path and can just
-		 * invalidate it.
-		 */
-		istate->cache[pos]->ce_flags &= ~CE_FSMONITOR_VALID;
 	} else {
-		/*
-		 * The path is not a tracked file -or- it is a
-		 * directory event on a platform that cannot
-		 * distinguish between file and directory events in
-		 * the event handler, such as Windows.
-		 *
-		 * Scan as if it is a directory and invalidate the
-		 * cone under it.  (But remember to ignore items
-		 * between "name" and "name/", such as "name-" and
-		 * "name.".
-		 */
-		pos = -pos - 1;
-
-		for (i = pos; i < istate->cache_nr; i++) {
-			if (!starts_with(istate->cache[i]->name, name))
-				break;
-			if ((unsigned char)istate->cache[i]->name[len] > '/')
-				break;
-			if (istate->cache[i]->name[len] == '/')
-				istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
-		}
+		fsmonitor_refresh_callback_unqualified(istate, name, len, pos);
 	}
 
 	/*
-- 
gitgitgadget

