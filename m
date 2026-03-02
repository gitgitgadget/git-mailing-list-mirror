Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50028410D26
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465816; cv=none; b=ASz0XR8b8xq3TpOFwwnCAyDJ6WJKmt1N5IU5HfkqwokO0whIBJ8zpB6IZ6pPY75NeLALe8+fnnZZ70fDIRc7aIPGqt65tOCWRTyxfpeXDFE66J0VhW6jjA05VVRWwASvt+Qg4EPyx6AAIP/SpprJ+TuU7g4xoHiQMiOLOgU3vqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465816; c=relaxed/simple;
	bh=5po/mKqknicKl7ZeJlNsLRUNtfk8aVUqc1vdgFjU9+8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WMps2FZnGGUAE+IwuxH2giO9J5VpO1j/enoMnwnCqOrSKMZNNEEEjdiD9dWVvJs4lgHLPtVPfVIvNi0ekIMM+9apa39jk9Zm26P2sVFut3to9ZvspV84tD/kiivViiGV1ZXoqKgnjWmYviArgzvgIJYM5DiRKPKBFacSgujZC+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyfHVhBT; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyfHVhBT"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2be06a2be90so2260657eec.0
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 07:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772465814; x=1773070614; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lla3EHhLIuq26dpSSZmc8KWrhgt6cGJPjby+w5yhHuU=;
        b=EyfHVhBT1E8O4Dd/YEsqKsB+diCWsB8BKwe9wV+CJ2q7uudJwRdaCje+OHuNSmgazx
         MTAIfbFde59mlhLWJ/vMmI9BO3SfYIBHg9bJl5KRt9fL12lhQ0PcM/GLa8u9mZCGsDHZ
         6DIfOsyKRorCCJQTTwep+ka0jHpwieuhxUPe2hQ0K5ai+tsfqwo/vNh8E5mAbyFV49O2
         tmJvs4n8Mz9T1cHHoW4ZF3xHWc3qJp85AnWjb5X6j+UeEBj53UGdtt4169I1R/FmEwMB
         mgRnEIe8ElcDHctgelnnCYVd3gvx7rmCvuXy3Fqf6NkLEqJFBjDjaARRPnD4h8e90BSZ
         lsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772465814; x=1773070614;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lla3EHhLIuq26dpSSZmc8KWrhgt6cGJPjby+w5yhHuU=;
        b=i+GsAee8EBWYRjrp0WmRnFvLJ//JPk25W7RaG23JWKw8WGo5EkJWpS/SCpmGNZZI06
         XjKnfv0NhCxFQL/4dHdqBCw+6tJaGZnesds2FonTxTtrEeHeXUiQ8iqkBUuC3a6o/YgO
         vkwCvCOCjFXddLrlI3PcuGvhffzbpnRhhNbWA9cQUETefzundmvHEMtx5rILd1ce2maB
         Vbvcchni2fgDLBEYIMZG3fs6ZyP0uhr7FStgT7qucMS28nbB1NwOqXUWm2zmDB/Yj20/
         Gih+3qBf4oSHSG0LSoJGQOWYRdvTP2+je+iHb0R7goXXwD7NNE1kPMj1Q3zlehEoVpH/
         QCSw==
X-Gm-Message-State: AOJu0YzHCfhp6ittQFE2PZhSpX4WnQL1SPys166d7yCd8RIpYlk6eFuU
	rcO3IgrLRiZJ4oqycwQEq5I9Q5Mplgf6SsVCQlvRYbzJjbVrXlz4EUnWrxShYg==
X-Gm-Gg: ATEYQzwNMlSWxptSFNZLrNznpaZAqfsmssSa1/e0wCH4VFcAbrcfqaNRKeynwijqLd/
	gcXhJyLAu+nMUPisrGq/1MCano1JLo/7bVPGjyTAgXEM3qZ9Nn5oVaLWBJLXa7ohlMB4k8ZyM+2
	fPXUkxHWDGJNG6okPfGNYl4L6aPVVoGYd5qldNE4NO9gcLAJxn5AZCGnB88lwebh+AW9PRa87Rl
	O+jkTLjJtj1H1i8JIP1icei3WWUcBpk0BHx4druz10T+KVokaQchPUNmpf+39sqUG0MkagPXcJO
	Wrskeews4WL6ucdxP8F5lqEIEbBmKR8cExxl2eVViEE7gjpe5PThta0/qFe0xUf92JnI5LvrOg+
	SLF35UIB5Rnb2V9sz6RCXbixChhYiAeeayuHmQw3znlNYBQZJbSa0gAuhaCHKKDVnfXPvxq+9tE
	VqOVc6f6JPDOibx/XBl06011G7U5k=
X-Received: by 2002:a05:693c:2c97:b0:2bd:d5d8:537f with SMTP id 5a478bee46e88-2bde1d48b6fmr5447391eec.23.1772465813793;
        Mon, 02 Mar 2026 07:36:53 -0800 (PST)
Received: from [127.0.0.1] ([172.184.214.215])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be1281ff70sm3405332eec.14.2026.03.02.07.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:36:53 -0800 (PST)
Message-Id: <f6582e94026eb933dff6fa895775c52ebf32409a.1772465805.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
References: <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
	<pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Mar 2026 15:36:45 +0000
Subject: [PATCH v3 4/4] for-each-repo: simplify passing of parameters
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
 builtin/for-each-repo.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 8bbdc33128..3aafb2cfa8 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -14,7 +14,7 @@ static const char * const for_each_repo_usage[] = {
 	NULL
 };
 
-static int run_command_on_repo(const char *path, int argc, const char ** argv)
+static int run_command_on_repo(const char *path, const char **argv)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 	char *abspath = interpolate_path(path, 0);
@@ -23,9 +23,7 @@ static int run_command_on_repo(const char *path, int argc, const char ** argv)
 
 	child.git_cmd = 1;
 	strvec_pushl(&child.args, "-C", abspath, NULL);
-
-	for (i = 0; i < argc; i++)
-		strvec_push(&child.args, argv[i]);
+	strvec_pushv(&child.args, argv);
 
 	free(abspath);
 
@@ -65,7 +63,7 @@ int cmd_for_each_repo(int argc,
 		return 0;
 
 	for (size_t i = 0; i < values->nr; i++) {
-		int ret = run_command_on_repo(values->items[i].string, argc, argv);
+		int ret = run_command_on_repo(values->items[i].string, argv);
 		if (ret) {
 			if (!keep_going)
 					return ret;
-- 
gitgitgadget
