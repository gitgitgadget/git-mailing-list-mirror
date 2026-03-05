Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6936623D7E3
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 01:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673399; cv=none; b=miYOc8uzeW4s4o73nqax0LtY2uqtfjYFzbyQDG0L70Cfm+ykGm1yXjXYkeek/xcmnwbuyJLAuqlKrYlc0CLSzVWCtRjJbLaC8DaettcQugvP9KWpDA5EFtAHXbQ9EBGGr+O7DGgio3DjDJGIhwtDxtKr2IIVTZMAeWv3TXmtlEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673399; c=relaxed/simple;
	bh=P5YPXkGxj2MEzkpiAmJYVU2XTrHyMf5718OjZANNUV4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fJcs2CgnkQzJkUZDrUQ+Elei2PspBtKVCVlRUZddsS8r0dv6i33SjxdlDvrzpw5++hY6oRYBHKCGeoo7eVjulypEvp1x/y9KCjBtWwD/V1gt5LYb5eXw6JRsTQwWRVUnE0qYcXll5YKOqj44vRzLCSEuae3uPuRLbZ++xZDQWk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeGULghk; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeGULghk"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cb4136d865so987286685a.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 17:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772673397; x=1773278197; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gdea4uvg99p+++RGap8S6WNukQGzyryxZcEfU/QG2h4=;
        b=UeGULghkI0kYqeylEmU/PwlboWa2596n4acEGmuiP5gXAP3UrCnt8Yin04wNXou/Cu
         Ne+nnCf8cHmzwYVvVcVfLx38MBF+fXPsYRogpI9g7SSQwUIEyFo2yOxS3qjDXJ+Y7W2I
         gze+vU07cU06mpVbeFEOa8koc72UTiYjYDmuB9hMAHcieF2rlzXbjw/YSW5VSi6MI2NU
         LOQss4/yI0UZWkQMNysyFf1EWqQcCm2UFHrAENhUjgDfpfbte3v8mH23Zzerit/bMA4O
         b/I0LBP+KtTzRmSduEtURpXYsBkNGGv/VUEcxE2X0OBE1q5MsUqqcpcvwhT8owXke4dW
         gKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772673397; x=1773278197;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gdea4uvg99p+++RGap8S6WNukQGzyryxZcEfU/QG2h4=;
        b=jYbb/YmJh2BQq5DY6ndsIma2as3STOjR3FgkVrr/Ny5ZuRNmVxBMULC5N81eX6VJCR
         Jw47F34ppDzF46kHCeGB+AO5UHGrarGzE3cJPbfoeLLybcNiW3+kxulWLT6oqFoYBvyN
         SDkU1JKJzpVO4bnKlp3/qpG3NV+GLL8D5+4GCIibsjxZNorTDpbEQNtSZDlNnZlJaFfg
         cgVI1rc1Hjn+KZ3NyaF9Pn3owORtkmkdqwzagr4Tf3Ofm61FuF11w1RlSSPIMx7rNxxa
         vJXKTKlsNUpqV7ckmM/WznvxQCbVpz8QfkVDYuRlNgvKHUXVLa/ejz3WQDkUqKbgJPRr
         btNQ==
X-Gm-Message-State: AOJu0YwK5uT9IbT8YmZByS/Q+F1pI8LiW3NYsAdl+3KLaWZCYgZtS5Wm
	VMw3+dxNumYWSMf1sRouhybC/W2jo+u9zeqS9dLHiS/J5wTFb5qeizhMBoLIwQJU
X-Gm-Gg: ATEYQzyQB9GW6iZLIpz4k2c9gGdsiWJCzzw9QklZP9VWrZ+LgNiiFYiSKeSf8vJq55B
	IMy32nFqrO3X9Dhml8vn07SpN0acqZc4u3VBMXhZtwQOL/bLb+19npMzcxfp6hKL6roWouW4IZz
	DABwMuUS0s1Xwm2LisKfUQZqWI10JsIfsDunvBeTckKqi13A4GkuTl2S2H4fexvCRsweZG+Ctme
	iIqgfK4/if0cwzMxNNAy7qcozJB+H7If+ghRPDFe6O+Wu+YvU7XfYcVVWaoCl5L466bxzRW++0z
	zt++9WG6gGtBljxOHEHRU8x+34bzGT7Ou0PjTsFQIrkIlcf+xYtIOXL6AyHAI82VY/wPVEygujA
	Fbn1UwUKGZXym8BQPuf6f5k9W763WJSoYBc5vIfv1AMaOg+XitT9XXy25j7ilq9U2csJwNaddNy
	We7ZVv/iEFnMFRF82PI3djhp8=
X-Received: by 2002:a05:620a:1aa1:b0:8c5:c9a0:ac28 with SMTP id af79cd13be357-8cd5aef69ccmr519367185a.21.1772673397150;
        Wed, 04 Mar 2026 17:16:37 -0800 (PST)
Received: from [127.0.0.1] ([51.8.152.229])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf652bb6sm1889463285a.4.2026.03.04.17.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 17:16:36 -0800 (PST)
Message-Id: <8a9a6ba4fad9dd21844ef12a9cf24c0f26c1bc53.1772673378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
References: <pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
	<pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 01:16:16 +0000
Subject: [PATCH v10 10/12] fsmonitor: add timeout to daemon stop command
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
index d2f250bd06..299de2e4e2 100644
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

