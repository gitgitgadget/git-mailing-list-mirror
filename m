Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FFA2EC54B
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 23:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758842978; cv=none; b=lrs6Ifp962gJYI4hU7Tec/TMXtqdfmzvo8dhvoooPShw05WthT4f4blAt6GOdgnew4JxFNn7CBJgmARPu0tSgXleSsNnX2a1Sne7eh4lS4bgY9W+Qphg1kZRdYPshJyINg/tZLl/KzjLl7n9LGPdziTDeXwBmPXEUAs7XU79DtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758842978; c=relaxed/simple;
	bh=rhL7z2JuUNObAPJolsKbTI6C1GU/Lgrn+nn1ssbaLoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVHo5/KCj9tu/4j5BaHya6hCCfAIbuhBdXMAqfa62XvtqStHqpQIvVy4rYk0tIL2Q3Vr46l4l83qc1B7hEWDxyVxF9vTvKaL1ZANO0DwJ19uhGkqB+AcfRcS/fB+XzX0BoS4Un+tVwfr3pkqZDXI7sUsDCuUsAqbkNRXeYQg5/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/9iVihj; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/9iVihj"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-30cce8c3afaso1360578fac.1
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 16:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758842975; x=1759447775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xISjwdtj2GzvnStBEQ4LDObogRyfw+Z5+EIiFS62pTU=;
        b=H/9iVihj/QPTFKk30nbAbOzLL+holiaQmaWmxN//t9FsB1is1UfgET2oR3Km19/3f5
         Pfp59RbOYplAGCDmSqgoVGnIP06sy/Y1kpfTCR7bCkXrz29kZL+dSVd32dnihXdDbdTj
         T/D4n8itqls1qBRUy7ZMsmo+xbcPPOGnazvYbvYxtU/Xe8mzck0XFz/IKMJox5z5E7SO
         hGZGfYU7fvBNEH05/o9vyAlE5ImDVQid69fzJZZMuiykdjG5rFOJj3bt3Xs22R7C7rRK
         F2gvigZzZHvhA6QOG0YVEJM/ArEPqxkkNkaoUvAZUHAjdahzi1ihnjP+lIqkmMuq/gx8
         mhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758842975; x=1759447775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xISjwdtj2GzvnStBEQ4LDObogRyfw+Z5+EIiFS62pTU=;
        b=j2J/LgZWZMy70P5mhScVjUZTiVzBkY4x+ZNcncjLG1eLs0XewS29XP4f2grBSJUPb3
         AxPC8r1AVlzgj4xLbQmmd/93IAKR4xzVpsEyLFm9gG6lOyq+2fVHwbmTWLAZjFtfPHYK
         kaANswbJesYqtv+wTJfzHxoz7nq//A8eDrBGdx+KLXCRyyvGjAYlqCOBVBk83fjaelH5
         X4rlcYlslJaOIjRxJOOETiUHPNMdnYvRKB68IfnhTFQXx1e8QGfcZTEvP+AzHmL/g77h
         XRet+oAVCaP27QheTyNMoQWmqhzvkvDXCbPszu2ZdL0xLChhq1IoxZeFOSnl0dBR+LQk
         vP0Q==
X-Gm-Message-State: AOJu0YxiVdhU4nudy4+MtlrupHdOZrkxd/EUNw8rvK4698rwMve3hh/j
	FsHlGfi56Hs5mnSWw5x/LzCkEy9D+UI1LC0V/XwJHXIPI7mQD5Qp4b+B5H7LiA==
X-Gm-Gg: ASbGncut5EppcaifTxgxFleCI8bmdGNSLJrFuRqIpqkw+treL9evygWxisW4iWSFOJN
	5vxUpUJIOJTaG5/8AEyVDKG5153U0uRcrzNMgAcv0WLzAnTLbjVLVnaXOEd7mkULt2qpGn0fH1A
	Et+k1XngWkIuSO+PUatj29dR/AemnTX8ix/Uheg6ocoVlFwuFJV9pAqlTA0t4QjfwnGwmli1eI+
	Yr9QJ6sT2pyEf7P95BeBiuJuL9RxC1fAOn12bBPiYdx2eYwVi1VuaFfTCu94N+Wjmg/7liHSYlt
	SLtmei0I8p03+s02a9puwDwnRXITBqMqUDsGMen9g2ZtAg53GdHTqPqe7Z4fsqK4aUqi2iPaqwx
	EGbccXFa8Sahiq/LrMgEaA3BCQ/p9zgw=
X-Google-Smtp-Source: AGHT+IHnT96OBlQJS9z9ux50SDVmYOwfp6BUbNZ6Gx5swh8OLWL/TgUH78YctLtkveO3pqsLfUZc/A==
X-Received: by 2002:a05:6870:8326:b0:35d:45c7:4a97 with SMTP id 586e51a60fabf-35eea473fbamr2981414fac.34.1758842975589;
        Thu, 25 Sep 2025 16:29:35 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7a2402e5d70sm674273a34.36.2025.09.25.16.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 16:29:34 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 1/7] builtin/repo: rename repo_info() to cmd_repo_info()
Date: Thu, 25 Sep 2025 18:29:22 -0500
Message-ID: <20250925232928.3846-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250925232928.3846-1-jltobler@gmail.com>
References: <20250924212426.2930029-1-jltobler@gmail.com>
 <20250925232928.3846-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subcommand functions are often prefixed with `cmd_` to denote that they
are an entrypoint. Rename repo_info() to cmd_repo_info() accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/repo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index bbb0966f2d..eeeab8fbd2 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -136,8 +136,8 @@ static int parse_format_cb(const struct option *opt,
 	return 0;
 }
 
-static int repo_info(int argc, const char **argv, const char *prefix,
-		     struct repository *repo)
+static int cmd_repo_info(int argc, const char **argv, const char *prefix,
+			 struct repository *repo)
 {
 	enum output_format format = FORMAT_KEYVALUE;
 	struct option options[] = {
@@ -161,7 +161,7 @@ int cmd_repo(int argc, const char **argv, const char *prefix,
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
-		OPT_SUBCOMMAND("info", &fn, repo_info),
+		OPT_SUBCOMMAND("info", &fn, cmd_repo_info),
 		OPT_END()
 	};
 
-- 
2.51.0.193.g4975ec3473b

