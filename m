Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0232C36A36C
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783239881; cv=none; b=APP8BMRfr6Ox02Mh62s3iaNPBCFnKkli3oNM7ay+gG4W9X0ZQbkcXC5E4OCfVKqP0ZZPgmGD5UCBCztQRZzCEUhT7G61r7Xo4/dRKMp7JE7hIQonOCBNa2GmsdNQWdLDNrVklE3xeiYrmdg8nkCDzlrxdb0p2D42ccJO8lZKxJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783239881; c=relaxed/simple;
	bh=5KReHGpE+c4QY7zYNf2a8IJTKKag/hrylxzoxvOKc1c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KV3T7oo8WVPifY4AmPqWoADcwZLMjduok6BXyD3EluilEfr2cIpbJk/xMch33lmZaim3z2VJVUOAZudKSE/EdYVqwiOg3vzE6T2bQMtmD6xh267P9dAcQ1ShwfROkGCla4cBvVX8uCY4t258mmmiqwHL9FOJifXaQWag93wKaDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQhv5yrC; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQhv5yrC"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8f18d92172aso27146876d6.2
        for <git@vger.kernel.org>; Sun, 05 Jul 2026 01:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783239879; x=1783844679; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n/IH11gAP6j2Weua/ktmxnkdLoweIr3ul0MME6AKzD4=;
        b=jQhv5yrCNwIsbV6VFv5yvWDEnL0enZs6s5WLRPPabxE+bDvzPutv8biJsOEepb+u5Q
         x98s3PDQdFm30CSbGIDru8n26skq7EaCnfNRNy2hzIpzU5YyeWmdhc7b6hZZVLLNtLNN
         k2EpYFVep0xUSjrI9PQJkdAiJrj3NDwjppTk1Lcs4PTOd/zVCUwSzN7Pgz6Ke90Ccs7i
         4vEvdPYUFZtLY5jfJFoQTFNKFBXPXo9+ick9fh9fqWM6TaepIoIIWRFb3ZWP/WjujU5D
         RfZ7XUcKUteR/6nA8BKCiaYc2FRtpWVV1t3Da3t1UV9pjgQZpc1XWY3AdtRTxj/euyZ2
         998A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783239879; x=1783844679;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n/IH11gAP6j2Weua/ktmxnkdLoweIr3ul0MME6AKzD4=;
        b=Si5WNruDtU3mlLAgd3FlY8F8d3GVJ4/22sw2n0i5fhWPYO4AD0VjhaBWac3z2zLeBb
         Ry5d/WGqAMSFnX2y+oqep3+CiJA8IyNM7PaqG3dp5BcOR+6pGhVUb6pHyQ9Vy8Ss556U
         I2PJ62WHbvpn6zt4fkJ6C/ruPrizRXGU0Ht9lnqxoabTqQHbUTLjq0MJ1L4zmbJ/65Kc
         7DJ6bV5PW/y7XIiXNdxRKFJxpvopnXSRFIMaHCPt9tMj4XNXOcOZ9ltucvmS4H1hzfu0
         gO8Ozy2vpAOZki4fpw4djlSJ7gI10IicqYg5FSYC3KraEgzY0jMrvHqFarbkjNnM2zYs
         57dQ==
X-Gm-Message-State: AOJu0YylkOYX2xdmmziV7KubfzwgQ/U9amzfyPvdMwb33XYA3Lxd5cyr
	wiwb0+uNkQegPxCti3ZAdCt7UbAtcruHOPrqJmC0fDAUkWaw6hMg1MVlULI/lg==
X-Gm-Gg: AfdE7cmYFlvIuh1ecTBQuCdEYCRhjvqLbhMwK/9BbxWSSqHbxZwHAGlREZydigEVyHh
	yqjdGDCXwPgei4sIuKBjSRfI4dwpqpCw9bO6KqS5yXZuJ8ZvZubVjKKNyvQXDJFH4U4+SyAUPcf
	WeZ997kELAki5hZStp43kkIqZGBVTHY2hMaAzhseeuayK0tja4ED0j2NJaIZQO9CtQNYUD4ecBu
	fNaexuWn3Et+cgOsOMMh0oY3uC+rNOdHF0jTEZUeusEe+ubozKkmnr94XaV+gHDNpH8s48LymbL
	6dOrXlLmxDTawWVoOjVeyy65hzpU2Prb/GYer6eHklShhCiomo9erhnwSULhZBr/1d/IThrwnbm
	z9sD6f7XCpyxypNvHYWJ3wFlyI2CQQjtPIH+L4LSf3ppkDXWMFgbXr4J6l6pK84dGCwTIPTgj81
	1npL5LU9Xp2KYrs9a8sA==
X-Received: by 2002:a05:6214:e6a:b0:8db:3c35:e2b2 with SMTP id 6a1803df08f44-8f74baa5a2emr83146736d6.26.1783239878852;
        Sun, 05 Jul 2026 01:24:38 -0700 (PDT)
Received: from [127.0.0.1] ([135.237.130.145])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4722ca4c6sm102405356d6.39.2026.07.05.01.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:24:37 -0700 (PDT)
Message-Id: <0360016d91bfca251c914e46700ba190798e1911.1783239870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
	<pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 05 Jul 2026 08:24:21 +0000
Subject: [PATCH v2 04/12] run-command: avoid `close(-1)` in `start_command()`
 error paths
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When `start_command()` fails to set up a pipe partway through, it rolls
back by closing the pipe ends it has already opened. For descriptors
supplied by the caller rather than allocated locally, that rollback
tested `if (cmd->in)` / `if (cmd->out)` before calling close(). The
CHILD_PROCESS_INIT default of -1 ("no descriptor") is non-zero and so
passes the test, meaning a caller that sets cmd->no_stdin or
cmd->no_stdout without supplying a real fd ends up triggering close(-1)
on the error path.

The stdin-pipe failure branch a few lines above already uses the right
idiom, `if (cmd->out > 0)`, which rejects both the -1 sentinel and 0
(the parent's own standard streams). Apply it to the three remaining
rollback sites.

Reported by Coverity as CID 1049722 ("Argument cannot be negative").

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 run-command.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/run-command.c b/run-command.c
index e70a8a387b..ce84db8782 100644
--- a/run-command.c
+++ b/run-command.c
@@ -706,7 +706,7 @@ int start_command(struct child_process *cmd)
 			failed_errno = errno;
 			if (need_in)
 				close_pair(fdin);
-			else if (cmd->in)
+			else if (cmd->in > 0)
 				close(cmd->in);
 			str = "standard output";
 			goto fail_pipe;
@@ -720,11 +720,11 @@ int start_command(struct child_process *cmd)
 			failed_errno = errno;
 			if (need_in)
 				close_pair(fdin);
-			else if (cmd->in)
+			else if (cmd->in > 0)
 				close(cmd->in);
 			if (need_out)
 				close_pair(fdout);
-			else if (cmd->out)
+			else if (cmd->out > 0)
 				close(cmd->out);
 			str = "standard error";
 fail_pipe:
-- 
gitgitgadget

