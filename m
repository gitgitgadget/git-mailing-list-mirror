Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B002DFF04
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 04:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775710798; cv=none; b=ssaGrjETB4TjVDMCRcbDBjoOYzzfVMIsYFRMcoZHmSviG8TXv7ltzfX9mmA/9ouTyWUE9Ky4xjZjLA1fUfrM7w0c37Ed9ims4kzwtgzKtiNcIr2ebOwqeqnjS7WFF1E3+BHRv+8NjfpGgWoJnPLr2UCQjK9aVtt4ci59DZpELeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775710798; c=relaxed/simple;
	bh=wW4L5f2UPz5JB2XuHq37kfldUvOK8IUq2BxlaQwTYkw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sY7qu9uOymLYJZYSpUdamn3f37Bteq1+nIzFW/e41PH9lwKqE+HmiT2PTm8GCrkvDfVOgePBNhMWuf5+ojkED6NbWuUF61TSScvQVFBd8lsIl5aeSbwWzyrYO4dhY4DygfbUCfU08Lk58QQMZ6OSzKHODuQzX+lYbe/snFyjnX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gw+1kUk2; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gw+1kUk2"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cfc085395fso38567085a.2
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 21:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775710795; x=1776315595; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C83czoS95l3vv2klvVyic5XtiDMyrhb+y+/EC4Hbov4=;
        b=gw+1kUk2YnyXSLbg4rH+AqoQ57Wbv5BOSLKj+cURywR6l3Mze0TBKLmogFDU+cVo9u
         xPOsnoD6CUCtaadXYUmRs0fUEfsTjTdPuzJ+3sY1Pgkp56LKzFa6v9zM6wvjLdexqoDi
         m+gMRWf4i1WO54gNUCXyZWPBZsjYAH9ld7CtzMyn5Wi3IY2NIYnTE0sHq2CQkaDqWewe
         lI+sadsJsQXsKMPvC0xShQmap4GNuPK0akqoOXMrhv076NzYnUyy2jmNkUNVSSoOgSz3
         eS6bTgkCBWkQo3PacRqtoGcLCR13kigBqSVmFTM+nynP0QjTOC3rW2ADn5KKePBNYBx1
         pjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775710795; x=1776315595;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C83czoS95l3vv2klvVyic5XtiDMyrhb+y+/EC4Hbov4=;
        b=RStAhcICt9tsCR4836MR2/FYEhfsiz86FczjNzps+guAwvdo1Jsc+BDgWwSp6/D3mF
         csEbdIKzgaVPs8nx7KFvfkdH7M+n4lnsyYG8M2WQpY8Hafs0iiB0YC9VnoUNBp3RzDxm
         wavw9z3kqZIzy3tV8xuhffzwLDLEQS0t/5l5CHi+9BU8SzhLaq/Wi3PhR2KLgVyysdVg
         UzKI5m6S/iXwo39f2j7jG42oIHvsPGhWT0aAEyBnTSi6o8CWHA2cdI74cuPWTiloRqb1
         aIR5XPik888Dag/fXC//ucw2zYPmLCyfZEhC99HOnPntuxoOgk3Pifuo3D1Ur+38sDqT
         sFNw==
X-Gm-Message-State: AOJu0YwHn6CvnVImSemxaOxLBSJ5lIxbiSiYkxO/72pvQ+NQvbQP5q/9
	/+01Lls6KUUrzZ4z852Xg5m1vmHTBgHLowDtFZ443auitjEzsVH2c5tlLNXcaQ==
X-Gm-Gg: AeBDiessSeDuCCTXHJ/Oa3J7Ml0PUDGoaxKhHdYDdQj+Fto6U26HG9eIoTkl7rpTC/v
	ehmzdnYBt5QWQret9UOL3SFaUKyawPwmVqZZyttn5WzQ4ndy2BAvy/s+E9GkboFEnFB/Cw5SCzK
	3umS3IpsrusdAxZjD4RU/cIeBHUEzW2ib1GmF8Ot0kJTPZlNhcTF5DhBwKQtdizH+jrkHCiPUkz
	Py2jYjQZZ6WyIe5nwz2nh25piwO/kvSWz+zSV8AbTh7x+qyqEn44JWJtx9YZyTecSZD5yLasHXX
	yDvg1SVbcSu4ZuEHgyEu8CBiwX8Chm7ZjTsmn8z62IKXs8Q5kXPjDPJOPNSAuyaYTzKBfQeAJQE
	pHpAbuw1rbaIlhog+vV3uSqdiL6AasBUIQkQPJBlUhUwsQdseYHnGBN/G7ZDO/Q4KhyicmHsoVJ
	4bNx6xg466h+lxjGmZLdiEp7zZzkJU8lMYSVQHVw==
X-Received: by 2002:a05:620a:1710:b0:8cf:c1c2:90a with SMTP id af79cd13be357-8dc3b809496mr367523185a.17.1775710795576;
        Wed, 08 Apr 2026 21:59:55 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.153.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d40495cd32sm1490844085a.22.2026.04.08.21.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 21:59:54 -0700 (PDT)
Message-Id: <fd6bdc8c55cc1acc07586815f09925e4ad6796c3.1775710775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
References: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
	<pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 04:59:33 +0000
Subject: [PATCH v14 11/13] fsmonitor: add timeout to daemon stop command
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

