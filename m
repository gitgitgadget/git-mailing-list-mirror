Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0196547CC87
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 17:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772559124; cv=none; b=sRqj6YjnEULh1WJTjYkEAmWs/y+vnJcrjyb0857Klph6ZupAsJVypwr7gSn/o/cKd7BNQSrfREoKZMP741A1XdIt/t52AGRoZZ7Z36EGbjWSaF8BkHRVtGZdTwwT7sKnfrZG4yWb+9BxhHW7I8lPLapPt9D8jT/q7hKzG2JlVvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772559124; c=relaxed/simple;
	bh=S3/E4rqLHluwhrZH0NSYN2jqVQFSDS0OZ6qHovXcOqY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=X66j2Ayl6uRmq4+4JKzScgLOKkq3wAbaXyoii/vHumrzYVuZ/T6yLnx9c+ghptLrON/BQ7oy4TEuxGfzePesqb1Hpmu+TIVGoF00PNkgzQOj8u6GWjHN/FQ6RxT19pjTflQsTGJm0F251UWPv3wH+P9qXWoxsERMFcdj04bqOv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8QH5jx4; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8QH5jx4"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899c97c5afeso45918376d6.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 09:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772559122; x=1773163922; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IW5LN16XP1gooA9EYuB7e0byPdObF5288vZ2xOrIU1g=;
        b=A8QH5jx4MfC26cMpqtaFJIXnEaWQ631kbgUyrsGTUyFliybx5CRDQzWgERFBbn3w/P
         +aQG/R2v7PTFPwH423aSi1v6E4N7fVyLGMPu7PVp99eRqeRSIrP7Ezqx30hgr4+/mg8K
         OWMeFialv/n/7pOdcDOJPXJt5CnHjXg3zlNwg0hsLEprB09CQtKhY8KWogRrvK30lNWM
         ELhMFMQ1uMgstkfx31mhVqJicXQSY70n8UGfCkDFgISSdjNE93nKYY+hdzJZAd7UmRMI
         fdCR1Mv85PCPc3F7Iy7vJ/DVp59YbJk9KN+reASomggy/HujWxapr7PPrgB+nlwkFuf6
         G1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772559122; x=1773163922;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IW5LN16XP1gooA9EYuB7e0byPdObF5288vZ2xOrIU1g=;
        b=ZDb1qVSSpOL5yHzcdPHm9eXphxKZr5G+2eesAbSlZG8h9T2L5O1utVIsB/0KNShWcG
         Fo2VHx2g08vbEdslRZ5awncR/CqaHS02OrrUt5frhCBoRbs5QhdF18kjHuiooz1KHa9h
         NLdB9d3HzPQTT7nMnjVemPwAY5UWt9qz0LFpjQv9DjJwJak4zVBTHPCOlEoe8ddv5dkA
         dhURO97cbrx/Z1mqPEZjqt+f9gtacYmRiT7Ciw+QtHmpn7uOcJusMHOtA+fNawGAGIdw
         vHAaFZgowwMKPSG79VV57CnhuyL8xMJzxSydAlHqfd1TScfkGL/6DZapHUWoaBNeGOPg
         tepA==
X-Gm-Message-State: AOJu0YwM9hgYPfvqsI3jEFingw2lwG/nHQZHFTCi+yS7RBzz/syRWzsT
	RoWnZ9x98YJifxkIlu+1AfKh8GoUBA2mNUtFK8X/ASiRLPK3d5CIXlU0pZ/PBg==
X-Gm-Gg: ATEYQzwtQbO5PqBPELvknlpdv031K9z20+TaAEB13jmcwPkI0/G1EwvgqAVHcbWpK/F
	dy+CyU/onOo+0xpLlhXROjWO2b7Uy4j1Lnmub7Dg+ZjNV8nZ7qgN9zBNPnrHlVkmVnBB8cb2LiE
	9btID/sP1DA7HDXhLNlGNsxAwHwHfnKDEDf5CF+f5HgFeQnk3z5ebLxvIZfk2HeJBbN6UIWVogw
	c9KAhTjWwIMhv1qunDvkRE4exajuFqC3zbDScyVVt65cYvaHevJrpIFUT6OJ9qwz/VNihDqzYDA
	DRl4C/b0phpCYHxgnssGiwwgeaTvVNYebpcrZPRlpFktv8KvDpiCA8HHwFMOe/JpT+L8NbXdNgO
	V4FTQ8SGtpNNQI50uOKCv4K93WWzP2+xxPz1/G1KL2dYyJz8FfPVdC6ckHnabK/XiIYiVIpx3Fe
	awuKXjCREptwTHHLNwrhIUl1Dh
X-Received: by 2002:a05:6214:ac7:b0:899:f5a4:8110 with SMTP id 6a1803df08f44-899f5a48831mr130551836d6.56.1772559121575;
        Tue, 03 Mar 2026 09:32:01 -0800 (PST)
Received: from [127.0.0.1] ([20.161.28.103])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899f8f4c165sm54674086d6.39.2026.03.03.09.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 09:32:00 -0800 (PST)
Message-Id: <8b1f083da1c91c3b3dff8a3af4fc0d57c1cb5ab9.1772559114.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2056.v4.git.1772559114.gitgitgadget@gmail.com>
References: <pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
	<pull.2056.v4.git.1772559114.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Mar 2026 17:31:54 +0000
Subject: [PATCH v4 4/4] for-each-repo: simplify passing of parameters
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
Cc: gitster@pobox.com,
    fastcat@gmail.com,
    Eric Sunshine <sunshine@sunshineco.com>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

This change simplifies the code somewhat from its original
implementation.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/for-each-repo.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 82727c4aa2..927d3d92da 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -14,9 +14,8 @@ static const char * const for_each_repo_usage[] = {
 	NULL
 };
 
-static int run_command_on_repo(const char *path, int argc, const char ** argv)
+static int run_command_on_repo(const char *path, const char **argv)
 {
-	int i;
 	struct child_process child = CHILD_PROCESS_INIT;
 	char *abspath = interpolate_path(path, 0);
 
@@ -24,9 +23,7 @@ static int run_command_on_repo(const char *path, int argc, const char ** argv)
 
 	child.git_cmd = 1;
 	strvec_pushl(&child.args, "-C", abspath, NULL);
-
-	for (i = 0; i < argc; i++)
-		strvec_push(&child.args, argv[i]);
+	strvec_pushv(&child.args, argv);
 
 	free(abspath);
 
@@ -66,7 +63,7 @@ int cmd_for_each_repo(int argc,
 		return 0;
 
 	for (size_t i = 0; i < values->nr; i++) {
-		int ret = run_command_on_repo(values->items[i].string, argc, argv);
+		int ret = run_command_on_repo(values->items[i].string, argv);
 		if (ret) {
 			if (!keep_going)
 					return ret;
-- 
gitgitgadget
