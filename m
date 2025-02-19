Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FC91E04BF
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997257; cv=none; b=jqSaQVFikFM+feIZhn+kaOnkbKy1TqRtqqNZSpva0+MLHzzNmDHJXFlE3G8IY0PAma1mtRNTyIPv5hDq8pVR7CvndLBh7eWIn62lRpg55WymgnbRa/xqbFO4ChSruNj8YmLNPxUk0gKExNsuHmV+svH1j7TQPP+Lw5b3To/KbVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997257; c=relaxed/simple;
	bh=yUsRVVynB8WUTVMHhlRlQW6RnOl4HaL8+LpyclczGXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjaIOyHKkJGC8+IQUp3ut7757VTgM7XwsLSCiscThnsK5vFo8+zd+0WsgBbmVrSEeGQGPPvoUkUR7KE9fbYhzbm7200C6yKya4OWirenVNKqSTtIruBSB0JMdJtJJbW5Z1+FnIiB25p6+I/lHXYO/2Vj0nZ184Xl4/Gylosr8Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAC6Pr6w; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAC6Pr6w"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21c2f1b610dso4397645ad.0
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 12:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739997255; x=1740602055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJAwjPxYS3ZV1QhvQbMqgdWYuN3NUNCxW+1as9J/akQ=;
        b=dAC6Pr6wk176Qk817bciBAjXDjS9pocQgVzeSWGuQKLpiGPl7ZlUKQsvzUj3ppsFZ1
         bmSqoOQhtWU1f3cvuLily7WUQfPA1+ZHCNCi5l0bG9KkhYxkcZfUFAJ16OU4l66AZQ62
         B1VcfqIicLMzivXQfUhUwda+7mvKPJb5JOvlGcJ/0/oV/mqdXX0rd0JwFLhK+ChtvFra
         TEhUYtQwQOcPx5oRXZ+5XBYdTK+QjZ9HEkoBPk6f48pmvcHWnQGSD4mjliyO590zbHHc
         YnSYQzIWMkqNreQCP/xBlWjd9SRrSnT+XGrBfgGTD7UCLgq01CoPTSvS+XnnJGdg7/Yg
         i3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997255; x=1740602055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJAwjPxYS3ZV1QhvQbMqgdWYuN3NUNCxW+1as9J/akQ=;
        b=hEZJphH3ZwVit7VgqqDJareWJ7VZe5ollkRYMZLWMr7bjCDBMtw4q7Znv1A5f9ywrL
         Fjzw2rzeQRhgRauL9Pbyy31UR0DQbDYp3VZukaaDNukP1pgrSN2bA8rj2Mi1ZBqN7tA6
         +25Sx88BMpfrjcGjRK5lrZRbO/xW2lIX2j2CXi6HrfvTu7aFa8eKarZ39gTnLnA1bFrY
         486e7gBOJAudmSYrmIe5aSwUVo2ErnbNwyelKMuoxN7Yk7hUWULTJggLlZPJQ7t3Ay8p
         b9i3jGXLXe7hdNBW06AGKEtyRhDA3xVyji+oBu7cubUO9QbQfD6N/mrOuUJNNPNDSoD9
         vwsg==
X-Forwarded-Encrypted: i=1; AJvYcCUj5f0TLdNkCdiFIDB1LIR53PWDASFuHwrva2tOPMiKw5Pb/i4D+Mj0XnP/bD4zT7wOjwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSRpa4Ya4pscu0xLEIznrHK8eeLVJy30j3wd8Ap0NvuvJhPD9i
	GIerz+GMKguUuJtCc9PJVr4WEtHa8pOwy+bm7s9iMkPl0L2c4j+a
X-Gm-Gg: ASbGnculZOaEKhQaEdAJIOT43NjPeAymK2XFmRqH9NJyVzGDX5dKBYOQGIRZs5QcjFd
	0j6wGvgr5U6e01ziZ0LX3Z0NWtYB6oVfS8efpvGhn81m6MdCY1CchrD2CvDWY1+D5PIKvtzRmum
	np72YUS/6vZScVZFfvGYzACjDU0zVjWp7uiYbSnFCkEZpZ1r9L+gr8ut5A6MMW/IojzdcMiOTAG
	JrSCZ/+SARhlk3rXKj0oW5Il85QdhGc1d97qUHn9hllJINAqk4WYhZs1TiO9YYqB5rxRk4XsGJe
	kF3vQ8HtyfnIQd5Z3dYPElucT9eNyT1UiD+V9cfp
X-Google-Smtp-Source: AGHT+IGCJU1sD3Fwu1q2ZkqdBBdG1utTyjWnIf8KEjFnYM96gQOCCmT58a0YCuUK3eIACE1Qcu2hZQ==
X-Received: by 2002:a17:903:1a0e:b0:220:f1a1:b6e1 with SMTP id d9443c01a7336-22104028854mr332391445ad.19.1739997255146;
        Wed, 19 Feb 2025 12:34:15 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53499dasm107791355ad.12.2025.02.19.12.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:34:14 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: gitster@pobox.com,
	christian.couder@gmail.com,
	git@vger.kernel.org
Cc: me@ttaylorr.com,
	chriscool@tuxfamily.org,
	johncai86@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com
Subject: [PATCH v2 06/12] builtin/send-pack: stop using `the_repository`
Date: Thu, 20 Feb 2025 02:02:54 +0530
Message-ID: <20250219203349.787173-7-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
 <20250219203349.787173-1-usmanakinyemi202@gmail.com>
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
the options help and exit, without having to consult much of the
configuration file.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/send-pack.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 0848d23171..0ebfc98317 100644
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
@@ -221,7 +220,7 @@ int cmd_send_pack(int argc,
 	if (!dest)
 		usage_with_options(send_pack_usage, options);
 
-	git_config(send_pack_config, NULL);
+	repo_config(repo, send_pack_config, NULL);
 
 	args.verbose = verbose;
 	args.dry_run = dry_run;
@@ -318,7 +317,7 @@ int cmd_send_pack(int argc,
 	set_ref_status_for_push(remote_refs, args.send_mirror,
 		args.force_update);
 
-	ret = send_pack(the_repository, &args, fd, conn, remote_refs, &extra_have);
+	ret = send_pack(repo, &args, fd, conn, remote_refs, &extra_have);
 
 	if (helper_status)
 		print_helper_status(remote_refs);
-- 
2.48.1

