Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5331A3CF698
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 18:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648135; cv=none; b=aB9QRRucDnZAKUcduHRsrQY93P52nPqrpOKVThDTDd6PYNDRX7gyANYqlNMzc2pUeTvpGuKi93nqr1ASk1XBXFYahr26DPbBydfoRbK+Z5ZXjm6aEiecCBr+NybsXzOpSMjLPlgIsHe9OGBt4fb2ZxC06g3KwKKsNoWhc9sePx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648135; c=relaxed/simple;
	bh=dgzktmB3UZefBssaL2ZSgY5M3yNRYA/erR3TfVJjNYM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WZ61PSpx1hTBc1fG4E+Mcyy/q3oZxGEZcG05QdCGDBPqTKuM261YBgboTYbLuVg9mZWlrtE6CGLW97J3cz2PTsO/Bqto7CUpouZtZBk2WcL12a03/ZnF9E7GuB7iiV2ybIZ7aXGfwhezUl7MqGPLb4WvBvBC6gxD1yn4nYK4uJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vy7pKzkk; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vy7pKzkk"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1273349c56bso8764483c88.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 10:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772648131; x=1773252931; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yRyfUm958Q8U3QnlqMYhczOEnpYrJIU0IcFDG9fhFE=;
        b=Vy7pKzkk/aF0ZWTPUbg7NmxW51GXlAbgWl4IJ+QGHXQeCBkxrUeXAv5VGli4i24Ots
         H7toOyU8SUDnGe6kUk2Mg4ShQGa8Hog50setJFU7B2/Y23osvZMrAf+Y4l3doWtP6f2K
         I1V9/m2CQvIGZPB5hTrjtmsiD52mgVp8B6gOH1fTk+9vlo3LvL4/Z6Hz3imW0fzEtLSZ
         vB7uT00Y5RRKbhFqrxLOQ9Dpg6/YTBUka26nS0srnyhdHuiLJVUAA8Wfsqvnlj+SD/cU
         bwVT+Nla1e5bwmFqwAjFCdpR+Mab200NtCCvEoVUgwjSQlO7CH2fM4vymyOm286uylkm
         RNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648131; x=1773252931;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8yRyfUm958Q8U3QnlqMYhczOEnpYrJIU0IcFDG9fhFE=;
        b=Q75hew92n2gD4SL7L7nw/pLI0tnHSC5t8+PBv0snqEAfmk1zrzSHQ1qv8hIsJsyhN9
         zlxoXPIiV3t2FRlXj9ugX68FChCbz/lOL3f3BV9kh2UvYIPF5tav2pnzjvvULM1vAOj4
         J2bTa07oXq3sXLYmA+yc6Qu6EU8b/P2HCsd878Ud43LjOTllKGLZfd2kROKGmmc6VzAu
         4sv0vTQVOxoq1cuRMJHKItOm3CD99Eb0YlhUI8cNLsy26RmYfpLxIJcjGmeHNk+q2ERd
         wYwcv6uUzutOdlffUb/PqCWDNjmKj6D7D2Hnwro/tYhpu1Cmwncbh6FLWP1RP0dY9YdF
         USKQ==
X-Gm-Message-State: AOJu0Yw+HBvL8VESHUJwE37c/M1ImXCmov6o1j1TNSfIswRf31PKeG09
	uSMvcx7xIHVt1hItR3MVqbdRrbmtpzrevU5PoXy6F805oOb2ipxGw36Bjh7J4zyz
X-Gm-Gg: ATEYQzw3Lq+EZt/tRjJbH0ZqXVH03PvteiwiDsojJZFV+gDX02hgP8UE5c3A+Id/omM
	sHTfY1+mDh+8GYd53b1YKDLwvmsfFz8JhmoeabqOLTKUivldTugzKnpZx3HRDYhqU51CQCSYTHC
	TEwtXjyL0dqs00eh9zSD4z0pdAZYkKqWzIvWzD3QTyofBwUNfCcL4m4yzEYf/uIUbVqFlK+Rra+
	HHhUPfxR21uHg9dqG9XGWF/avMKOqDHUZ9V1MaecZUo9cjOShF2WVdXDWUK5BzUO92CIgs6B1ke
	oREXgwRVML4Wql6NBTFrtywBfIQyNJyOkRyCE4659HCqqmKY/tJRjb9/zeaJwd9R4seiQ737nMC
	h8Bj4ssLw55Rrzcl7Bv64Qc0XEouD/y46CCL2T8UExVxPq8ncbBQfylemDE5Bwif0UiJOgQW9WW
	HTkYH/cjKVcnH9XAo+7KQp7Rf5gWA+L4N/b0v4
X-Received: by 2002:a05:7022:6baa:b0:127:345c:43b2 with SMTP id a92af1059eb24-128b70d4a9bmr1058138c88.28.1772648130580;
        Wed, 04 Mar 2026 10:15:30 -0800 (PST)
Received: from [127.0.0.1] ([57.154.172.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a32dabsm22126896c88.11.2026.03.04.10.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:15:30 -0800 (PST)
Message-Id: <cb270120f0e27a34a58c856b7c80e78e2301c989.1772648125.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
References: <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
	<pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 18:15:15 +0000
Subject: [PATCH v8 02/12] fsmonitor: fix hashmap memory leak in
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
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The `state.cookies` hashmap is initialized during daemon startup but
never freed during cleanup in the `done:` label of
fsmonitor_run_daemon().  The cookie entries also have names allocated
via strbuf_detach() that must be freed individually.

Iterate the hashmap to free each cookie name, then call
hashmap_clear_and_free() to release the entries and table.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 builtin/fsmonitor--daemon.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index bc4571938c..d8d32b01ef 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1404,6 +1404,15 @@ static int fsmonitor_run_daemon(void)
 done:
 	pthread_cond_destroy(&state.cookies_cond);
 	pthread_mutex_destroy(&state.main_lock);
+	{
+		struct hashmap_iter iter;
+		struct fsmonitor_cookie_item *cookie;
+
+		hashmap_for_each_entry(&state.cookies, &iter, cookie, entry)
+			free(cookie->name);
+		hashmap_clear_and_free(&state.cookies,
+				       struct fsmonitor_cookie_item, entry);
+	}
 	fsm_listen__dtor(&state);
 	fsm_health__dtor(&state);
 
-- 
gitgitgadget

