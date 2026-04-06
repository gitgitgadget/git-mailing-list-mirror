Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F857393DE8
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 17:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498118; cv=none; b=TtNnziXP82zgWbBPGT8a9HKYRLGVXYMtiB3Z1gjboFr8V9Ht8yxbcoQUfwXsXSkZ8UyTZYX9oVlwjSOwdiU++d9+Hk5aavbp9rVlqjzxG1VrhPtgy2M+3w35F6/Z5fLCjLEGbpgb6Nas+8cKFI8DncqytfvEZbvzSgfNp2GZm8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498118; c=relaxed/simple;
	bh=wW4L5f2UPz5JB2XuHq37kfldUvOK8IUq2BxlaQwTYkw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nFoasfcM1zC6/QSJTInGqg3aO6iAUoGOwRvDvZflwzWBf2OvhzDjp5fucZH7qMrhS5Ta95USIuzCnurv5CEhobj67/RM/fFhJ0PRcPJNRPMz8rUGaR4tyYrtrEYReiXyA8oTenie4H44yq9EBXAfhaHC4NEDRmvNncOeHHvMhko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fv9XfjU9; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fv9XfjU9"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2c56aa62931so9001287eec.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 10:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775498116; x=1776102916; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C83czoS95l3vv2klvVyic5XtiDMyrhb+y+/EC4Hbov4=;
        b=Fv9XfjU9wUe2KordSWK1L58CZkah8ZDx1o/17pNMoHWl/ONHPvXCIauVmTw7QX/stv
         h4XdfZIAON1b8y29LC2UzID+CPqunamkOFXymurZLesQBnI9ADHPPx8s9DM9S3iVihm5
         e3dXSagYw7CEqSUzQ4AvYSvi3Twrisit3lcSqf85BFhW90wVWLCmw6776VmawnPQdtpd
         +DAIZlcZwzFccNbnn0Og5nfkFiBlu9WWxuuGyxytbD/W/MgYPt8VNc95lXIahdOwRB4V
         ox3V8fsu74W4GVuvCxHLA9V2XY+/QsjBf8Ha6MpGt82S4NgvanrGRp3YgzZ3aLQ6dsPZ
         f5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775498116; x=1776102916;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C83czoS95l3vv2klvVyic5XtiDMyrhb+y+/EC4Hbov4=;
        b=Dyrtb2UO9Sk5X8U58ku78sZhrbUF0Aq80h1pBlhKsfZorAp7MdW7L9jzg1CEnCub5I
         wY1QNgI67RgKtidMo4OBri8HjRxQsadjnXlPqsgk6rC14hTZmGq6lnheOmFWvVYbJIDi
         ah7PLh9UdJu6QQXF6qtfj1d+Qv9C19OJ0MRYuKY7mfrjRdjF+tIYioCwnfgMfNGOtLmD
         n9PB7VAUVI1rWEh3xcguGsfAV47V/NEhW8SPMysvbDDclfurr8UvPNc4Q90U6yKq7H0P
         5rPxzcfgEAUpWKKaIG1bWSPl8vUeY6lbmqb9VeCxWHtY2MXJYbbypUeyBcye5rvGfL0x
         bYbA==
X-Gm-Message-State: AOJu0YxWXi4IvFXDXQ6ynvs0OQViHkdV6xOCelO4V+BmTbMqYV/setJZ
	MBDEi1+rEImD1/9HFGzEaZyOd/URz1MxDpqihgZ8kdGmpIpjyBJVLTGjQmrNTA==
X-Gm-Gg: AeBDietKjsE2/bNCLfY7lGwc9rkt6g9R9rG7wrWe3Yu7lSdRGryLm5mXNrP/mpmawjq
	32W5F8MpBmjjxmq9EdQ8lZahIYGcKzPffmfB0jIypnf4u4aB7f0UZSPo1UQAh9MVf3dTYfWXHGO
	OdexT1K/kVTLmWNLVIjCm970S3yVCeXlKnwRrQhYvKGT2YJqA9i319Xd9sRyOLjIWMZ5OVSamVi
	IEDoYPfg8tPhF8+eJS6hN6aK971IEPT8ZaMeSvfhuWQUSsbhDi12oFkKjeck5Az6BEGVt+v+tft
	VlciYSVDVMuxRBxf1OfSuA127xqapdRHOAVF7Bps5sBbN/cF9zNN7KDB345GIFiDlxmDSJU8jXt
	C17Vlg4GqbiF4ogfw4hgkWNBNfGyD9e5VLiaXNL2PzxRekacZiyFa1vyKomFg0J7f1tUOmIxST7
	B4tTl1dNU6WD27bdxzdUZlpmIaoX8Hh4a7+M/akg==
X-Received: by 2002:a05:7300:dc8b:b0:2c8:7172:3b86 with SMTP id 5a478bee46e88-2cbfba8eb13mr7162635eec.22.1775498116010;
        Mon, 06 Apr 2026 10:55:16 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c20c151sm14175790eec.19.2026.04.06.10.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 10:55:15 -0700 (PDT)
Message-Id: <cb4d511f21ef05941ce7a54ee45b88c72f6497a2.1775498098.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
References: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
	<pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Apr 2026 17:54:56 +0000
Subject: [PATCH v13 11/13] fsmonitor: add timeout to daemon stop command
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

