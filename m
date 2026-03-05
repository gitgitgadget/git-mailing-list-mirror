Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0781312837
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772693739; cv=none; b=JvEAto2Z8me4tHw+U35KyWDeH6stBRUPaQFvwHn5zQv98vxUexuag7cr+GpkDKDezcFcdMvhfqqGjcZSzu20di1d9Gz5uTUjej3q7dqfADLiBxrRqVI4oHTH/AdIRRCzmYLofDquwTmOhnNfcfhNZbS5HHavW97GMc7/Ti5YB30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772693739; c=relaxed/simple;
	bh=wW4L5f2UPz5JB2XuHq37kfldUvOK8IUq2BxlaQwTYkw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qOneqjnZ9HYPTolg0iCEUr+G/TwDJ0PcTaaE7tHg4QlopCmfvGzMLL6KPskiq4b4hjDYlR4ZRcCF22EcDcvrfCK3NJFfXpWJZY3dlDwuhISQIN8fnT8qFrJLBrObF/xuFDeAVsp/ZM1pGkINFW86P9JsbkBeMr+JhMliT6yrG/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAPCU3QR; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAPCU3QR"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso4516516eec.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 22:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772693737; x=1773298537; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C83czoS95l3vv2klvVyic5XtiDMyrhb+y+/EC4Hbov4=;
        b=aAPCU3QRIEhlF2H4KZs+ayT5w51olrj7EOtok8e4KMZyHUdtHaIv1+PAaLW+qrTNaP
         /s+cEBpRMh7MnB2mRNaLFg3/amXYBurduv4BAwwm3g81US45e7I+PLBRGbEHsw9vniUK
         xyCHZC+m2pNT/0iln4SEb6inWf9jbKi5bOQKjCldApJfHVPE7Ct1D7UOjXjxy2Rklomi
         PGB5YOr+lslPM5qvsWyk0yj/QXEN0ivgZSF7BOJuSToZNZd7FGg+YgD6qCxwjLhAAIXz
         vAdIscjAfRPNFdXbohdn4pwa2eyv+vCPmWdXfblLq0M9JBy5okjGiPPipEJaaSasqGlo
         wFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772693737; x=1773298537;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C83czoS95l3vv2klvVyic5XtiDMyrhb+y+/EC4Hbov4=;
        b=sbqMOe8/qR5iyylmOK/zZ3/I97v8/F89er0R2mW9E3VxNMjONvmlRk6+1U9udC+MMI
         lOZdYf/O5pHepYdfjfs19leXm4D/kksQdJkgqnjK4uZDJyt+hiOAPJm3kEYCkyesjr14
         yAA0wUWP3CSGY1HhsQsoubFsw0f7wMw8N75cIZ8ICh7mgmQsJzvYYGF0T6Yd8dvIoFCt
         qVf3n3CPnAF+tuLellRRx4P89i4ni182uU7m6MwSpCQR6IXJYPlMLpbZPGUrmppBpJWb
         PckNuqmGGUiMUrOnt8OEsD+RBKcFtdYP8uHpLy8ya8VzfdpdJBM2/4MCxw8EAGqG2/6B
         dy7g==
X-Gm-Message-State: AOJu0YyghXvHz/GBGJfFFjycsw0nrMH6QDpqkDePUGdTF6Y/je3H6kna
	YJsghpeLfF6HMVtv1QwQOW4PXvwKVKxpmuurvi/T55/dqYHJX9mjYaaAW7UJAg==
X-Gm-Gg: ATEYQzx3xqmrw2sptnnXdWnixyo9v3cJaVH0Wk2rYivjAfhVkij+vgyUB+djgKjHu08
	oEuE8SeUuL+tjJsRC++LgpQnDGIJ9ypPP8No7OfzjAr4E56cs0Y4WDAH83dClqHUqqpRCjlCCry
	1YEtyiOAGh2mjni3REFxbF9zad3Wv02j6s65HbvsWctkM4KjVvYqUxf6egeBnHtqy93VQZVC1bk
	xbEPD7mP8qSLT2CoQRZcxNvVjka1LjMOgCFCRpQo2FPlBzAXw6xQMLyyXK3cYrMmiea3pkR4kSa
	0M5shnok1oyZm66RLFKBHIqCiAzU49T+EfAgo8G4eqllDgCApaw4Mq0j4xj6e2jWHz/SjjgTGuc
	/z7zYFtPPMSwYI9Syakzl2MUVDy6DHpEQkDXyaJ8mVYhlX5xCwzm69Gn5Cl3BKIogMCkhjqaev+
	Go4MOumC3NhexSK7smKQTyHaUnDBtJ51rKxx+w
X-Received: by 2002:a05:693c:4098:b0:2ba:76e1:39fe with SMTP id 5a478bee46e88-2be3e2a66e1mr350238eec.6.1772693737498;
        Wed, 04 Mar 2026 22:55:37 -0800 (PST)
Received: from [127.0.0.1] ([52.190.182.112])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be12805b93sm9924761eec.15.2026.03.04.22.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:55:36 -0800 (PST)
Message-Id: <e6bc3bfcb285b48bff804460943aef17f0e00b6d.1772693712.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
References: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
	<pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 06:55:10 +0000
Subject: [PATCH v11 10/12] fsmonitor: add timeout to daemon stop command
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

The "fsmonitor--daemon stop" command polls in a loop waiting for the
daemon to exit after sending a "quit" command over IPC.  If the daemon
fails to shut down (e.g. it is stuck or wedged), this loop spins
forever.

Add a 30-second timeout so the stop command returns an error instead
of blocking indefinitely.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 builtin/fsmonitor--daemon.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index b2a816dc3f..53d8ad1f0d 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -86,6 +86,8 @@ static int do_as_client__send_stop(void)
 {
 	struct strbuf answer = STRBUF_INIT;
 	int ret;
+	int max_wait_ms = 30000;
+	int elapsed_ms = 0;
 
 	ret = fsmonitor_ipc__send_command("quit", &answer);
 
@@ -96,8 +98,16 @@ static int do_as_client__send_stop(void)
 		return ret;
 
 	trace2_region_enter("fsm_client", "polling-for-daemon-exit", NULL);
-	while (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
+	while (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING) {
+		if (elapsed_ms >= max_wait_ms) {
+			trace2_region_leave("fsm_client",
+					    "polling-for-daemon-exit", NULL);
+			return error(_("daemon did not stop within %d seconds"),
+				     max_wait_ms / 1000);
+		}
 		sleep_millisec(50);
+		elapsed_ms += 50;
+	}
 	trace2_region_leave("fsm_client", "polling-for-daemon-exit", NULL);
 
 	return 0;
-- 
gitgitgadget

