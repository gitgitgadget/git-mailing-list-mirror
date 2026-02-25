Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0A02EFDA2
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772050643; cv=none; b=d1ic5BoIaRdPtYmoCpmqhiivEJqy/rkvHEdPvOTh8njaRi1wpVd26n6UO0VIsfTUn6ePoVkYWbjSdu6hrp/446zHwsBsfPzjaQk6OrQhvgwdv17GVDRMJrmTab565mHaMM55BbCn4o0jwN66s3GRMeE1m4wZkhk2fMT3hGalq5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772050643; c=relaxed/simple;
	bh=JQgRoFMlV8NBf5Vaen1XUMPigYyWdXXVL1E9mgC5uBU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qzE9g3GtfxjNox8ZwbbBHUIDJVa/WkZYz/Ql9HIi0AY6Ue3gIuDpDy03eVecs0q2ivUM9hlh29aPuNhJ5oqlSeV+b4KDsxiDHQWHNN3zySzqH4MlYjS7e+OYq6xFQ+1gXy+zMhmqtUOlxcV140CgGtjhANSdPFgUa9GidS1omIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0TSu+9c; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0TSu+9c"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cb3a8494c5so1088985a.2
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 12:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772050640; x=1772655440; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mS1FLDvdtnW+ZbQt+E0ojudYwLzdg0U+4RO9oATf1+c=;
        b=K0TSu+9cG6vgITnEEOnb0k24eQtLhSsG1xFSjHcZzELXJPD9WhtdwnU8T7lA807vbK
         adDeSYlevSaKgUQ6b6lWtMcm0tVjmCDL0WUGhlIUjZK1VllO1C5nP5BIVCBuKbO6YIAv
         UCw99iqZH6GItnWskZaRW3vUrOwpaAEcKqXRk4VHbyfcS2MVS7DIj/IQnF3uzhx5ssqZ
         Jl46uUSstEyerjXj0mv2MclbN/Yp5hYVApYZgsuB9Mx1HXoltkLw3HmIe7CPL5yhXYz+
         dAGF7W1T+XL279V67wuxjEcUghfACt5uxNVtnA7gQ/5VoO8VgPKgnTjI8zm8CQvCmsVW
         /UzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772050640; x=1772655440;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mS1FLDvdtnW+ZbQt+E0ojudYwLzdg0U+4RO9oATf1+c=;
        b=fd2K9yn92NWTy75pft+a+SyQbJLa17yeOpUJeQWZZzXGe+/IR7jSyvx8JxpAKbgY8A
         DNYTkdJ/V7pr7LuApvaPBiGDYnyyxQih6DM4hxHgXSYJl71E4hEzH1VaOfPXddCPIdtD
         NZRA8P+MUvi2VHUpLhPmuK/ZKHyZ/QJcBBIcVHeTWTIHiqr2WzmGziB1W9vL0XEXmmsl
         B2WqIjHQT15Wx1E24eV3yub3XXkE2gkaqU2bB4r5MItMD62gB6zuyo/iH1a2Kg0mp2hc
         TrDGwKXYELZXTX6PjMaeIP8/E7U9RZylQk/OOdd3npXaMPtkMPOrrqK8n9rhf4YpYfqR
         imWA==
X-Gm-Message-State: AOJu0YxE+7VXXqrtKjEzqDBwCvhc/1+6zPmTzMFDZ/BAdeTMHGTv7GgB
	Ymdk3W3EZEt9Uua1e90GZ5qEfy4mfk8IXpeUaxjVU6VpRsl9PEPpddrDbS317Q==
X-Gm-Gg: ATEYQzyPa1s84XcLbJoMRBjoRSwMrBtvjK34e4yoR6mIifVZuOS9hXwaPd1FxUjgD7X
	HA5f2u/GbV/vLOpqy4J3D7p7IUEHVxrgflSFJwAt0ekZQllGXUxGRXq+XXKx1W+n7+K19KCo9tb
	qDxjkRXzDrwJST2RnagSSgS+vySSXRifkxELCYM3wm3Qxj67x9B5YvekP4+AB4CxnQLzLjI+1q2
	KgHKZMgZ6Cydt5PJ+DZh7sUYMCxwKiz6w7gBYC4cliSgWZKZIXDbllbLGCzx4qkwXTGJasP0a/U
	owA/38Qy/td+veekNG5i55VCrd741NBGtPjqLh3fXbR0rAkAFCC6fy3Hr3yt4DZNTsKm9LCvT9N
	Og0kaZYUEb2vhUsDwqIylY7WMcRnD2am9TXhS9ZvfG5Bncwi4VYI+nddUc/shyUlXw0T9aCLNwj
	QgRRSblel0bS/rN/lDZI2hCiH2Dw==
X-Received: by 2002:a05:622a:1485:b0:506:bdd1:798 with SMTP id d75a77b69052e-5070bca862fmr214967811cf.52.1772050640382;
        Wed, 25 Feb 2026 12:17:20 -0800 (PST)
Received: from [127.0.0.1] ([135.119.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744963073sm1554781cf.1.2026.02.25.12.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 12:17:19 -0800 (PST)
Message-Id: <d0bd3e32ca32b4150054ea91aa774a5b2db427e5.1772050636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
References: <pull.2147.v5.git.git.1771896704209.gitgitgadget@gmail.com>
	<pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Feb 2026 20:17:08 +0000
Subject: [PATCH v6 02/10] fsmonitor: fix hashmap memory leak in
 fsmonitor_run_daemon
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
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The `state.cookies` hashmap is initialized during daemon startup but
never freed during cleanup in the `done:` label of
fsmonitor_run_daemon().  Add a hashmap_clear() call to prevent this
memory leak.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 builtin/fsmonitor--daemon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index bc4571938c..4d52622e24 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1404,6 +1404,7 @@ static int fsmonitor_run_daemon(void)
 done:
 	pthread_cond_destroy(&state.cookies_cond);
 	pthread_mutex_destroy(&state.main_lock);
+	hashmap_clear(&state.cookies);
 	fsm_listen__dtor(&state);
 	fsm_health__dtor(&state);
 
-- 
gitgitgadget

