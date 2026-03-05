Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D846225A34
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 00:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772671940; cv=none; b=Bl/XrIQm1u+WjvWlCJMf2WMJ8wEXz0of57WigyzgtmI5QpAeah1PEvwUtjnLgaAQllE4tloyICho3+/AYBvyd4tJ3ExAhfWLVRvzmvjvk00iDCMFl8E2I52qpBa/6Z+2kdOvpA7t81htevZ65Bi912t0EsOwGlJkhsnd/GaIk78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772671940; c=relaxed/simple;
	bh=P5YPXkGxj2MEzkpiAmJYVU2XTrHyMf5718OjZANNUV4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=M/TKvYMOdcf1VVKWwlo84NK82NsSvOdDx5cFOOwioJTngl3og5ls9gfSj3RxCiIGVVd4UDwU3l5ON6sl5WEjWK/g3LOUfWVivSgcOW5FDCtFQMLZGP9ZKpG+ukEPsflTjNf6darqWWZOl5CSp6GnueiukAT4jlgk1+WeI5vbJR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1a4UErX; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1a4UErX"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12776bebe9fso5879307c88.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 16:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772671938; x=1773276738; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gdea4uvg99p+++RGap8S6WNukQGzyryxZcEfU/QG2h4=;
        b=H1a4UErX6f0lJRBHZ/Bbje/B0z65bPwIrJOlr/0Ggqu1OAIZAFndkM+folz3qX2t+c
         AtIrgZTtOl7AJJNIY4PH8dZ/8g+D0St7Xxs4ueupTHq0WtwYzDrJdwjHGXEqw4oyrJb/
         C6qf8gEC/E0O9tps51ZL9OP4NW17X6lLc+BFeCvt0Kcun/ccHtrHkD6l12gRs/tURINE
         SfPs5/J5xZIq/JdahnACg6i06naOKlA0RbjYFijtIHLiN6dpBhTGEpT+HPauhjYOYvnU
         3ecHQzAEPnahsh30IG7noer8tIoPkxzuD8rJsrn3jZdimtE0JY3rqg2KGR9S7MYN5c6C
         TSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772671938; x=1773276738;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gdea4uvg99p+++RGap8S6WNukQGzyryxZcEfU/QG2h4=;
        b=SQBteYk6ZpD0xYr4u0mUSy8pUMbsIwojHS4g5geiQEzM0SLpJWHC6FyKAeWntmrkZ/
         5fXCq9f04p10dqI9HnWSIFFK+JPzeCPF8CkR4RBptRwvvXXWr6BjZ5XwfsD+YimKuULV
         CdTyrlFnT6dnO+f7wcV+S83BZd10PUEikY2Qf/AyjDnosTLjLEL8OiQ4AtKT8/dlPgDv
         n2lacP2avY3giufTjJgCJKj7YfD+tMYy6zNGYS6oFCdiDZM6/hoblJQpMQVzTDr/9L/s
         JdxEsBTlGumIA2xiWHN3ncqXsL0VZUOvn0Q0e7/xSDFSIe9P6ZXsHiLgPLIDA7CDflK3
         aGhQ==
X-Gm-Message-State: AOJu0YwVV+qtscsPSTU47/lLnUJvsifeeA+/U+G1NQJppTeNrtmVtAI/
	21nbe4Kj7h9HzVsRVESKHW1+FpSVIGl/TeWF02o5vh1WXCml00XDJqWG5nWJFQ==
X-Gm-Gg: ATEYQzwIoIiQBzNINgzMSArvyEIcAjVwhTGMNJgQ0+Y7jB4HOW7mcrko1Vg/V95z0CP
	XMu+nNMilxvd/Lfc5VmDa+6PLFyvEJMuEwH7SUnNfF4i1AViBaO67NP1kLNLMh0kL8jU7WqDsSJ
	JnIrz9rUIkf7xRmRrjBhHLQY8qq7ks2BeA6GWaaiVBDQbSvi17p7tVNfioRzIUcrzCKkZxDCdVi
	So3aWc0LKSmJWWb0k/VFAXOjKkIuB9aCarJTb9FO9TEyfZTV8qFP2kHh30jbq7MniC6ypbe8BhJ
	4dV/a7j4bLjCmth3QIP16xreSGgpMZIN7oHUmpfIGG/5WTMrqLSbkzTm8b+r81pxqQx1j6MtoAg
	7ZzDzVND6LVU0GJRijwToeNGnDyV7yCtIkMZLVVm4b84gzkDSPDY+OzjHm7Y0YjmY43QU6jRmMn
	y5OLuRtnehC7dDzADI/frN7uwS
X-Received: by 2002:a05:7022:f102:b0:127:9b6b:2b08 with SMTP id a92af1059eb24-128b7072166mr2126086c88.6.1772671938021;
        Wed, 04 Mar 2026 16:52:18 -0800 (PST)
Received: from [127.0.0.1] ([68.220.62.148])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a43a18sm24955380c88.13.2026.03.04.16.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 16:52:17 -0800 (PST)
Message-Id: <ee3ee75c9418982ef365aa81e60116c4d2e4c266.1772671920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
References: <pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
	<pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 00:51:58 +0000
Subject: [PATCH v9 10/12] fsmonitor: add timeout to daemon stop command
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

