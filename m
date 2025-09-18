Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D458221F13
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186052; cv=none; b=pkpNCAZmRoeBasyYv/TY1UGo7CCYARWS1cWwQftNnhv9NpSBXLKWKITcGnWHUy0XMaAJjpeNtCg1gGgHDVN6Fmfcht71dIeEFKW3JOpz4/T7AaFMPYvhPrFacwHLQtYPscawW8Zy8tT0LThJn35OKF31SGRW7L+HhXf+MJe894w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186052; c=relaxed/simple;
	bh=V2oZkY0AS7qi62E4u6F0UKRxFAa4Mh1yw3hwk4Ge2z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVv3alNXaks6S0RM+ftn/zwZ2IMS7xjIUpNkn4LMy/CeMQ3K5i8yEgH8LdMGa1PN9w5E/twF25bESNr+QYfb+KBiGwGrXKUXzZdT0nwdZk2qQRtrAUB2nEAxd7UKv1TMmVk+SO2DJivVtGpBoMOKA/68let20ZrVrwL0a6KdAnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CklpURsX; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CklpURsX"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ece1102998so349143f8f.2
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 02:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758186049; x=1758790849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y6lo6guKcu3gOT2WDQkofh19QFH/xNeJtVfJl0da8aI=;
        b=CklpURsXjUzh+9Ct8+PHUEKtUKIzrUVddnw+oYMbCNcLdKbH1/MQVrlP5+vBhj61Dr
         3AXADdEcb6JuRvqRbLprNVJkm8EdvJntZYnWv6+Q6j55Q55WOoR7ueQe0hQOrfOuc5zK
         6TqyMp5DNC+pNQKFM6LzOM4am4fwPzMDCNlargXy2fDiCkEXUYs8j/uVjxiYHivRyNlz
         D5WijdgN/JgFGjaMeU16QSFU809wESkY0Mp3AyKfl+/P6mybvdGuRvSAGHGEdW2iUogX
         puxce8AGVE9sqrGdD8tSsMz2kgy2KBVWhpjTjegiPdBd4aWxqX/IGwBwqlsBSzW7p0Vq
         /Kug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758186049; x=1758790849;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y6lo6guKcu3gOT2WDQkofh19QFH/xNeJtVfJl0da8aI=;
        b=ciG+mvwcdfs5x5XMIVrsYgUdPuyhcf2DZpsoxO619IFR1m0nobgJ7/cm6dZAOFW98o
         v2FOBukxRjt2QVFdMh1VpjQ9gONuyyRZuai2L3+FunDPmAbqtRyky9J8MnvDd+PFS46G
         jPkBGE0svNjwQ5XQfpupGp6ruX0zkl+MU4NwFue2er6o4szntUR5a9iCHmEqnxVIGnCR
         bgrvoRZMpux7eNOWCjZXwRSXG5OpGAE5UpAnZ/7N4Fe2f1Uxxh9EJeA0HR3nvVsgY3+h
         TmyVSk4niQUcXB7JfxddoI4alWFGuZVIZhEn8VcGmnWocmIJjbbQk3VYNfKuxmP7ppPi
         uY+Q==
X-Gm-Message-State: AOJu0YxREirfmad+WM9DpPLCn1y0nm0LQN57aJl2o9FqkcH2ib2DlWL6
	6c455z5+K43CGs0ZshN9N+E6dnjJ7/FDMBpwCFWtJv7GazNeHLKUTISlkN3vug==
X-Gm-Gg: ASbGncvmyl7Fxe1Svv9diVOPxPWXjdFotZtSo/xSullIZwN0MX16Qzc+Tr8kH/ufXB7
	XMr30CY4Qh2cvGOFsD4DCuvkDxOivRH0Ib3jgiGg5BllQQwhaTD+sN4q95ppy1E4gyFmewt/t+6
	pWoapoA0pRDd3bx2J5Or++Pri92p/coCG68jj6XmkCV+lkmgCe8u3Ni34ahBtvSa6S41bQoAsjp
	JQtCuFobFG06vWNWvV8V7ankzbTXCLJGlLKcZw0kbeqFVTgviVo/+tQe9vVZkLvEzwM3KmXsW7s
	kuk3gvaGUIXJQwrFc4pXGoAeWHRVXfjD8VWaUVy8O0dxTWx5yHe62fjUZPk1l6XIQT8yDLiMA1v
	SNmRTNFzAOCc+oa0YxKdlNaYlLmYFS4CjTz64+KC/DlFiKG32c/V6BWw=
X-Google-Smtp-Source: AGHT+IEz4xlSY2hjT9cLiewe/UVoZn1q+YOWMvoO1/SxbJWKwbHtiATo4UkoYktVIRS2ngvKXrgplQ==
X-Received: by 2002:a05:6000:2283:b0:3ea:6680:8f97 with SMTP id ffacd0b85a97d-3ecdf9b19e8mr4592651f8f.2.1758186049357;
        Thu, 18 Sep 2025 02:00:49 -0700 (PDT)
Received: from berwick ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7284sm2703082f8f.33.2025.09.18.02.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:00:48 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Simon Cheng <cyqsimon@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 2/2] sequencer: remove VERBATIM_MSG flag
Date: Thu, 18 Sep 2025 10:00:39 +0100
Message-ID: <9c7f4e39c93a4ae09c291296cdc37d2d235b1ac3.1758186038.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.51.0.595.g259a2096d9c
In-Reply-To: <cover.1758186038.git.phillip.wood@dunelm.org.uk>
References: <cover.1758186038.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

As the last commit deleted the only user of VERBATIM_MSG remove
it. This reverts remaining parts of commit f7d42ceec52 (rebase -i:
do leave commit message intact in fixup! chains, 2021-01-28) that
were not deleted by the last commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 47c57c2ea3c..6d29a938aa5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1087,7 +1087,6 @@ N_("you have staged changes in your working tree\n"
 #define CLEANUP_MSG (1<<3)
 #define VERIFY_MSG  (1<<4)
 #define CREATE_ROOT_COMMIT (1<<5)
-#define VERBATIM_MSG (1<<6)
 
 static int run_command_silent_on_success(struct child_process *cmd)
 {
@@ -1125,9 +1124,6 @@ static int run_git_commit(const char *defmsg,
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
-	if ((flags & CLEANUP_MSG) && (flags & VERBATIM_MSG))
-		BUG("CLEANUP_MSG and VERBATIM_MSG are mutually exclusive");
-
 	cmd.git_cmd = 1;
 
 	if (is_rebase_i(opts) &&
@@ -1166,8 +1162,6 @@ static int run_git_commit(const char *defmsg,
 		strvec_pushl(&cmd.args, "-C", "HEAD", NULL);
 	if ((flags & CLEANUP_MSG))
 		strvec_push(&cmd.args, "--cleanup=strip");
-	if ((flags & VERBATIM_MSG))
-		strvec_push(&cmd.args, "--cleanup=verbatim");
 	if ((flags & EDIT_MSG))
 		strvec_push(&cmd.args, "-e");
 	else if (!(flags & CLEANUP_MSG) &&
@@ -1540,9 +1534,6 @@ static int try_to_commit(struct repository *r,
 	enum commit_msg_cleanup_mode cleanup;
 	int res = 0;
 
-	if ((flags & CLEANUP_MSG) && (flags & VERBATIM_MSG))
-		BUG("CLEANUP_MSG and VERBATIM_MSG are mutually exclusive");
-
 	if (parse_head(r, &current_head))
 		return -1;
 
@@ -1618,8 +1609,6 @@ static int try_to_commit(struct repository *r,
 
 	if (flags & CLEANUP_MSG)
 		cleanup = COMMIT_MSG_CLEANUP_ALL;
-	else if (flags & VERBATIM_MSG)
-		cleanup = COMMIT_MSG_CLEANUP_NONE;
 	else if ((opts->signoff || opts->record_origin) &&
 		 !opts->explicit_cleanup)
 		cleanup = COMMIT_MSG_CLEANUP_SPACE;
-- 
2.51.0.595.g259a2096d9c

