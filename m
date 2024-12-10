Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA812153E0
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830603; cv=none; b=X0+3r1VTi9yWICS7xiZo/zfXq09M8yNsQ6RGs7IllWfXolsuBiHtcZFu357d4nb/Oz6sXELSqdjSOTHdt9iMAm3BLTTQBnjR4m4RyZhpaDZEvi/MzfwzWm9WmvEvLeWy6nKDdmJCOW++OdLMse5O/Jy7ymbKvP6EOKdJx0xLzOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830603; c=relaxed/simple;
	bh=4AJjp5NEYD57d6mXZJ3ghfxSl83DBakKzl/Ap9JPveg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o4obctEQ+9SNBG2n/tOySlpMt8Pb03w6YOrfbrDexXWYkaRojkGhdmseBmQ8hzm3i33CrXgOeELkjPfs8KoHzs/GGd6vdyj7ZyyhxwMB/ELUI9pOFRgy77vDLUdqMAFFsYy0FJsaLccU3F1oMSQMLT6odlWXSM99goCajdHD8QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IujrVA09; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IujrVA09"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-725c0dd1fbcso4078203b3a.0
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 03:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733830601; x=1734435401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pe7ZyQBCVv0j0c8ENPnGXLTKP0BIlSrKVTnOl5E3xN8=;
        b=IujrVA09+/zrxv/dQ8GcKaCPDrbYLRbVfgHQuA1Ck5lZlapqZgYXFBK2TJhYPFdRL2
         1AzPDE7Yx7MsjdbnvnphHqVEVJVBVRqcpp2tcIMyXEmUiJUAAIMiVhlNaSTLUOimBHcN
         Qjw9hVNSIk/0PgrD10w1IQNtkUai4gaF913UthEI321qUh67Q3szVbNq0XjMEy1eb0wX
         NTCHzBPogIphxLydzCkovWionGIwvFKQ9tWwrFqv09LQTKNJIwmETKgZmEG2Bafmrp9i
         NO6Ctqr2kpSWhl3bdC0Jsv/J8RbhzjKxKdE1CRQhutuko+u8MQw0qmISd/m1d2snZ1op
         i9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733830601; x=1734435401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pe7ZyQBCVv0j0c8ENPnGXLTKP0BIlSrKVTnOl5E3xN8=;
        b=YOExP3DYFKtuM6EWrVMT4bmYNUNdKWwoyRiSuaz2i7Qlik3EkF0XnChAFSOnmhKaWI
         OL9n6ZCIiocPeZkyAWYeIsTJvWJ9v/S2zHuHCP4pZ6uMeUkfG1gs0EhEgaRxDTlSlXBn
         2rqOuxcH5J+7Th4P33SFvmrUzCy5E1Y0qg5MnnKAWWxaEAWWNfrReEKj9tOGRPBfNWl3
         8y5HoUrEBiDY2Wvkv9CK7clS7YyV0o9PnuAhrUM334WKIqtMYh3KHRnyc8WoBlHhIrJe
         PhUBJSjZDfhdA+p/HVVI2Y9RjKAtZUXNrgO84O3K4xRRdecbCHXFxqEFpNRagSS4dNy3
         UohQ==
X-Gm-Message-State: AOJu0Yw9S3qcVrY9hcn8PhzM/FO9hGyA0T3g5G99ya28h7NkDEcpTBah
	+iC+/YShcPQscpseJU+DS3wm1gCG6d81o4h/4hYj667MA8/fX6s7WQ4jDQ==
X-Gm-Gg: ASbGncs0geVZBPkwZNeU/XUx7UHdZKocqF/c1NN7Ckdtbwx7bdJwMXxVtRyr1kJRyPA
	wRtxZ8QMNbfCn+74YMr3Pv5Q0a5oxvfYRwf+QsfphOGWmo0OtDN9oSFETEUsbAmNTQnaw5pGMEB
	cVWivwTXNRgUo6y08GqNfonULwa/ST3XguU1TQXsdcWyXH9sqmHZOnwkSFb5u7nUhvFS3UWLgIT
	SWkLBTlXdgeMbkuNHsQMsLycfX8b2Y4brSt6y2EfQU5l1xXqCqygA2vHj1ZEO/ryhqJCLHQAIvD
	kN/QrChtSK65CDoKC8yJyv0OWW/WGkztA5qP5B0wtQ1X/w==
X-Google-Smtp-Source: AGHT+IFPKA5MckoIbPqpNPmTRuYHxMRm7WTw31DBZAcX4C6QYzpG8VBCkB0zzUOjINzOz/R7/CMOsQ==
X-Received: by 2002:a05:6a20:a11e:b0:1e1:aba4:209c with SMTP id adf61e73a8af0-1e1b00953d3mr7572731637.29.1733830601248;
        Tue, 10 Dec 2024 03:36:41 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd54aa2399sm2554532a12.39.2024.12.10.03.36.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2024 03:36:40 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 8/8] send-pack: gracefully close the connection for atomic push
Date: Tue, 10 Dec 2024 19:36:28 +0800
Message-Id: <9f49278ef108f08d512ee13128ed8277e12c002d.1733830410.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1733830410.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1731603991.git.zhiyou.jx@alibaba-inc.com> <cover.1733830410.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Patrick reported an issue that the exit code of git-receive-pack(1) is
ignored during atomic push with "--porcelain" flag, and added new test
cases in t5543.

This issue originated from commit 7dcbeaa0df (send-pack: fix
inconsistent porcelain output, 2020-04-17). At that time, I chose to
ignore the exit code of "finish_connect()" without investigating the
root cause of the abnormal termination of git-receive-pack. That was an
incorrect solution.

The root cause is that an atomic push operation terminates early without
sending a flush packet to git-receive-pack. As a result,
git-receive-pack continues waiting for commands without exiting. By
sending a flush packet at the appropriate location in "send_pack()", we
ensure that the git-receive-pack process closes properly, avoiding an
erroneous exit code for git-push. At the same time, revert the changes
to the "transport.c" file made in commit 7dcbeaa0df.

Reported-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 send-pack.c            |  1 +
 t/t5543-atomic-push.sh |  4 ++--
 transport.c            | 10 +---------
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index f1556dd53c..439b249c79 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -631,6 +631,7 @@ int send_pack(struct send_pack_args *args,
 				error("atomic push failed for ref %s. status: %d",
 				      ref->name, ref->status);
 				ret = ERROR_SEND_PACK_BAD_REF_STATUS;
+				packet_flush(out);
 				goto out;
 			}
 			/* else fallthrough */
diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
index 32181b9afb..3a700b0676 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -280,7 +280,7 @@ test_expect_success 'atomic push reports (reject by non-ff)' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'atomic push reports exit code failure' '
+test_expect_success 'atomic push reports exit code failure' '
 	write_script receive-pack-wrapper <<-\EOF &&
 	git-receive-pack "$@"
 	exit 1
@@ -296,7 +296,7 @@ test_expect_failure 'atomic push reports exit code failure' '
 	test_cmp expect err
 '
 
-test_expect_failure 'atomic push reports exit code failure with porcelain' '
+test_expect_success 'atomic push reports exit code failure with porcelain' '
 	write_script receive-pack-wrapper <<-\EOF &&
 	git-receive-pack "$@"
 	exit 1
diff --git a/transport.c b/transport.c
index 454d7f21a9..afcbca293b 100644
--- a/transport.c
+++ b/transport.c
@@ -928,15 +928,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 
 	close(data->fd[1]);
 	close(data->fd[0]);
-	/*
-	 * Atomic push may abort the connection early and close the pipe,
-	 * which may cause an error for `finish_connect()`. Ignore this error
-	 * for atomic git-push.
-	 */
-	if (ret || args.atomic)
-		finish_connect(data->conn);
-	else
-		ret = finish_connect(data->conn);
+	ret |= finish_connect(data->conn);
 	data->conn = NULL;
 	data->finished_handshake = 0;
 
-- 
2.47.0.rc1.21.g81e7bd6151

