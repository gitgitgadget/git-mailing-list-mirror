Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F1133DF
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 23:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390564; cv=none; b=B8t0rK6XiL5JW1dLi27Tc2tmShn+vRGLtC/g9hwfevSjzH5GWQ1Peqf/QRw+eQX64f4JF9hUshqpnmN17B7YMSwXsSsIzhrZjKlW3BUuiXFrlYE/MMxEQZEZdoCoq/BOA3s6+/+85dMybXo20W/rwo77scaI3aUpqkeAJpmDbGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390564; c=relaxed/simple;
	bh=6u2NuRnQfBqAIwfT9N+W2cLbTA8vrQV39JvWlFebs8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUAtOOcwvndqgozkLFQFbS7rrATaoOnXJfG8BvKMjaaUtdwiOJRk/JkodjIAfdkBeHHPG88fE+WTj/MLsuZRRdLbaTrR0Y6M8ayqeEX0Ey2/CWqofT3S25y9SXVU/wipLvx25M3TLO0zQsS6FJEMxKy80k3PMBCSgkG1HKwwJ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRT/3M97; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRT/3M97"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224100e9a5cso46588375ad.2
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 15:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741390562; x=1741995362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Rb3yS0CVOISQIr4Ol2n4ARfJ+e3EEivkK8XxzJZZK4=;
        b=PRT/3M973S94nNuVy4iGdBLbBWEyrAjQb0bGktzqr7iXp80rNJH+OKMatGxVo/6aEI
         NHfYEKIq4m++hnba5Vlj1SkE19f+mCAUuOBREBZu6DvsGAX3/KEKeVnNysfag5+0Pkor
         SFstlNORbhw5p9m/HK0tvz4uUvZ3Z7GYfe3VFKePlR+Q+VWyk9vGABnIP1yHTmBslBue
         vu/Ol2gLyTvp2pXVLXQEem334Z34Vd8IjdjAOdG/eY/wTG8NI+5dwW08BYLLuweNdGC7
         yr1OPuYVrzEl3SEDqdFZ8sk0HhInKjdoq3qzMYGLLkyiksaFp5175Jf7yzMsmxy3jCAX
         z6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390562; x=1741995362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Rb3yS0CVOISQIr4Ol2n4ARfJ+e3EEivkK8XxzJZZK4=;
        b=ItjjGmlqrEZFGQJaDadM6vxuAcMByfycwkaMq/nkPEZOLJNwEk5F1PhmhIDQawgPiy
         jS8KW8muPkHAGC5rtc2FlaSXcj05TKteJDCuVD8YToHtOXoPHR/Iv90bZ6bqPmgBqRJZ
         TKkh7sL0fJE8fxoz9ql8vxsZB9rnWYtvcWdwYlgQNiWWApGHgdAmk6TLP0tL+Zkov4/D
         5ns6KCDXLqn9Thp7BA/rc+wa5AQxF00cDGQu47lpDrhdxpx2Xd8qRXIXnzhgK2U9nCMa
         zKbwWueNxxkGheDdzBUA8lkOwCgRaaQWDEX4usgzz6bL39NgRkRayt46IVi2zzUsnWMB
         dv9w==
X-Gm-Message-State: AOJu0Yz3ybMbVApx5gIxWgtQarv4hghPRXN0wGBNojpUuQ5XYHDJcoL5
	iYjO1yUyYNBzYyhQpVJTtXaB/hhWzh0Pp2JsKjXjvAxaaicR063m2G4Wc0CCDZI=
X-Gm-Gg: ASbGncvHHP9CrWWNjmhd8D581ejo6TmPZfIyLujAjQNrtLjREBq8TTSzLv+uTcVv0Gk
	7/BkFMyEnlZ7swFju8kA15qJUkXfO9KASlL7SqKhMHTcXF7d+ztClDF5pLFmvKqwtU/H6LFFOwO
	teUJHp8SnhN6H9E8RSoklj+w2BSPqnE+GZUMGDy1YIuAb21xJGEtuFtmiyFR3T656P4odAdNij2
	b6+PHdAoU2m33EbalqNUhCX/NaqPhEA5T8R0YafIvzlXIF/CKQeqoYaw76hDjmcLpE84ys4hrVu
	w2ODvx0sOYjUlr3Rw+5p1KMtqFmEi8kHJCXw0pmrRK47CjsbpDw5DiP1sPMH3kbrURlMeA==
X-Google-Smtp-Source: AGHT+IEttNnfgLp/m+5p0HFSRlYzxZy4+TSiroF+oac18WQ9WXzgnoJnEdpbEVVMfm5oyJMIWvTQ9w==
X-Received: by 2002:a05:6a00:c8f:b0:736:69aa:112c with SMTP id d2e1a72fcca58-736aaa1df1emr6152541b3a.9.1741390562250;
        Fri, 07 Mar 2025 15:36:02 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736bcb8de04sm423880b3a.154.2025.03.07.15.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:36:01 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com,
	phillip.wood123@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 4/8] builtin/send-pack: stop using `the_repository`
Date: Sat,  8 Mar 2025 05:05:03 +0530
Message-ID: <20250307233543.1721552-5-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307233543.1721552-1-usmanakinyemi202@gmail.com>
References: <20250306143629.1267358-1-usmanakinyemi202@gmail.com>
 <20250307233543.1721552-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the_repository global variable in favor of the repository
argument that gets passed in "builtin/send-pack.c".

When `-h` is passed to the command outside a Git repository, the
`run_builtin()` will call the `cmd_send_pack()` function with `repo` set
to NULL and then early in the function, `parse_options()` call will give
the options help and exit.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/send-pack.c  | 7 +++----
 t/t5400-send-pack.sh | 7 +++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 8d461008e2..c6e0e9d051 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "hex.h"
@@ -151,7 +150,7 @@ static int send_pack_config(const char *k, const char *v,
 int cmd_send_pack(int argc,
 		  const char **argv,
 		  const char *prefix,
-		  struct repository *repo UNUSED)
+		  struct repository *repo)
 {
 	struct refspec rs = REFSPEC_INIT_PUSH;
 	const char *remote_name = NULL;
@@ -212,7 +211,7 @@ int cmd_send_pack(int argc,
 		OPT_END()
 	};
 
-	git_config(send_pack_config, NULL);
+	repo_config(repo, send_pack_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, send_pack_usage, 0);
 	if (argc > 0) {
 		dest = argv[0];
@@ -317,7 +316,7 @@ int cmd_send_pack(int argc,
 	set_ref_status_for_push(remote_refs, args.send_mirror,
 		args.force_update);
 
-	ret = send_pack(the_repository, &args, fd, conn, remote_refs, &extra_have);
+	ret = send_pack(repo, &args, fd, conn, remote_refs, &extra_have);
 
 	if (helper_status)
 		print_helper_status(remote_refs);
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 3f81f16e13..8f018d2f23 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -55,6 +55,13 @@ test_expect_success setup '
 	echo Rebase &&
 	git log'
 
+test_expect_success 'send-pack does not crash with -h' '
+	test_expect_code 129 git send-pack -h >usage &&
+	test_grep "[Uu]sage: git send-pack " usage &&
+	test_expect_code 129 nongit git send-pack -h >usage &&
+	test_grep "[Uu]sage: git send-pack " usage
+'
+
 test_expect_success 'pack the source repository' '
 	git repack -a -d &&
 	git prune
-- 
2.48.1

