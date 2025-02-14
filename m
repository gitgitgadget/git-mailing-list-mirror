Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69E81FC0F7
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 23:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739574142; cv=none; b=Kh2wMQ6RPSFbL+4pnXJ7qg5UFgOFju0MhcfsyyCXnQzNb/ZH8Cq+wAxsZC6afTzmQKljbtvffz34PUeFax9+fZowNarwy7DdTRicodW4sABy8btdoYWfeWeVCROIWm5QNLtkma+tsMX+6gLVujNZX9YKncHmYLyA3BiKOPwd3u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739574142; c=relaxed/simple;
	bh=wNs/pXh7+EomLLeCkHUXKI64X1x5QFlLZuJRc17gUHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoQV3K3Ak+92mLYddYFdbQt3q9tluQBgP8IFGnk7qSH9VoDLSHzxYp8N0wEZel3l0emK94lmcVGx7OYcniWrLcxFuOSnG8DiPR8GlySv4/vL+3UGbo28v+hL4r0OPUZWkAinlrQs80ym+FLHR8uvK4Aaz2rajNJXfbqOsCqvP9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ji29uSXi; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ji29uSXi"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f9b91dff71so3820195a91.2
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 15:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739574140; x=1740178940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCyQeLEBW6sUEDFsr3ceeRqDPL5FZQ4g5iEkea1rkCM=;
        b=ji29uSXipsXh/dlQ9oS++9P+3lvLL+sl9O9lntYaQYyeXOjmTKSeEP4A0185Tt3pb2
         gOvuMxZPwPbjOt5T7+vSr82LvhB2dFY3IrVP3LOruUoUS/gzK7klTfJdHERtxNImMUvJ
         AWSMvTe4/UlqWWvKBuvvLMswDLxp5BHnQnEErm3erBOHHBJFyJC4yHCgwU2kfBy5ypF1
         9PdeSnoeTZ67ZmuMSUj5/PP3uaRaIcIzSFgEzoGWD7iHg+FbZMwkHSKd8NQg4AnyMxwg
         xmYR8O3zOEj8zrh7jtkS5+ZVQsB8o+Q+0L35heuzQmOcBRxI043QmO2R09QtaeaJKlmC
         M9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739574140; x=1740178940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCyQeLEBW6sUEDFsr3ceeRqDPL5FZQ4g5iEkea1rkCM=;
        b=UMKYRfmJWFkGgF3xn7OHgRgMzexXKNGF1eu4j30tBCgPfs30dk2Vk2sy0iKGOIjG5p
         +9tNFVhwv33jlK5aYGnkJFezR7aJxHa31pb+LFVgnwXWLALclEw0SgZF2T14OIiyBKIH
         FJPZ2U0NL24VmhThlBCTZaAfPx14ngXgRk/4fiuewRQ+ywCmcZZSLssKck4oBK+Ozfz2
         2u2R5mHQCAfShhreErtHwOpiCu8bBNVxfK+YpWx4Bqle8KpF6Ek/uPLlGzyRVBw6qnsv
         4jynSJbiMTOJZtJMnYOEVl6MPwTJqiwMTcHz0UBXhfgPsnQS/SAV+fE1c68RFpR8rjxK
         LaMA==
X-Gm-Message-State: AOJu0YzoAf+FZWEtSx/aNMywV/ifQl2wr1LkjBGjlh5dtPahfMXcOZTt
	aMYguujbzw/TEcYtHM4uQMkNsODEU3IPmEVr0vJTZkuUzXXs2r1SYwLUPeaU
X-Gm-Gg: ASbGncskkVPOrTyEcUnIhBrSX0WRLQWfL+5oOwl044etlTVAtnWhRRKOKdFf/hurHz9
	lgJ5kcdkVtSLHkyfOu1CXtmynTbVru+t6VwbO/J36QN+pAJM/f0hc4is88c2RfnJRMMJbZWucuC
	c5PSglcGnY5xbLknqJyzDw7yUdL5SCB1HmoXS34/DvRH2YOrdGKdo15ZXLz/ZOEgHqBw5csEjV8
	sUtAD1jGZZOYkG5Q6LIpi4AmlUcgBQjMD1VsaVLE5UID0UyU0J5UG5aBgaBNGGv00tYlq5SdZ2l
	6bQncJacn5BSV0IaRzO9m6F0qV5dNuKcoxCILHeG
X-Google-Smtp-Source: AGHT+IE2Giwv2fkbYhvZ8S13aEc2//6ABufpRQjEOxE/HaJzrHSMumuN4trVHyasMh/MzRtdPVoXeg==
X-Received: by 2002:a17:90b:2f85:b0:2ee:e317:69ab with SMTP id 98e67ed59e1d1-2fc407915f8mr1692716a91.0.1739574139708;
        Fri, 14 Feb 2025 15:02:19 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22105174c73sm1495245ad.216.2025.02.14.15.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 15:02:19 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	johncai86@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com
Subject: [PATCH 1/7] builtin/verify-tag: stop using `the_repository`
Date: Sat, 15 Feb 2025 04:27:17 +0530
Message-ID: <20250214230210.1460111-2-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the_repository global variable in favor of the repository
argument that gets passed in "builtin/verify-tag.c".

When `-h` is passed to the command outside a Git repository, the
`run_builtin()` will call the `cmd_verify_tag()` function with `repo` set
to NULL and then early in the function, `parse_options()` call will give
the options help and exit, without having to consult much of the
configuration file. So it is safe to omit reading the config when `repo`
argument the caller gave us is NULL.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/verify-tag.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index f6b97048a5..990e967af3 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -5,7 +5,6 @@
  *
  * Based on git-verify-tag.sh
  */
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
@@ -23,7 +22,7 @@ static const char * const verify_tag_usage[] = {
 int cmd_verify_tag(int argc,
 		   const char **argv,
 		   const char *prefix,
-		   struct repository *repo UNUSED)
+		   struct repository *repo)
 {
 	int i = 1, verbose = 0, had_error = 0;
 	unsigned flags = 0;
@@ -35,7 +34,8 @@ int cmd_verify_tag(int argc,
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	if (repo)
+		repo_config(repo, git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, verify_tag_options,
 			     verify_tag_usage, PARSE_OPT_KEEP_ARGV0);
@@ -56,7 +56,7 @@ int cmd_verify_tag(int argc,
 		struct object_id oid;
 		const char *name = argv[i++];
 
-		if (repo_get_oid(the_repository, name, &oid)) {
+		if (repo_get_oid(repo, name, &oid)) {
 			had_error = !!error("tag '%s' not found.", name);
 			continue;
 		}
-- 
2.48.1

