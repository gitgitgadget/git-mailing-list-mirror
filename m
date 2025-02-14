Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350EC1FDA6B
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739574159; cv=none; b=bc+Cr0z+T9eoE1yzXwM4Rjz3X024GIwVcgQz2cONsRq/3ZRKucQ7f4Z4LllneYFi4KyoqGfpLCF/pRpvqBXJliEBI24GB57aiwMLSFJPJml+YIZnrF9ZsfBjLc3ZNYfEQkRjT8TVpoOTp3Vbj2war5Yx8jB3b2gLli1x+nC7cBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739574159; c=relaxed/simple;
	bh=fES0sLVgmO8X/iKwKMYcyCWo4tXnIZMNKhSX5kTNmmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAkeYCUbRVd8BzXKwgvZpbjgg3zBHMTqM97iDN6Iuj6+67ToKgVhfsZDTCp8Z1cbcg1jFuS4+0Eu3DWTG07/03qVYRrAMB7+eDXBrCjR0XDgJ1exWLjnXUB6bzCiQrsp9hLEsQ1Bg3CYCkMJkA89TphDl+zymTiU92NmVP6ISao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eawzWggK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eawzWggK"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220e6028214so38738495ad.0
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 15:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739574155; x=1740178955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GYQuJnhBN0yvMzA1EcZP0GVgXte4QrdClxq6a7RjPY=;
        b=eawzWggK2vKkfZQYQ5syPhIgLHh0A0mIDUClJkPJIvRKM+CeTjSBho22jyZA6MzaNe
         0fVP/NWvWc+y4mlaVihsrHFoMCU98AxKuzZgm6AR4qTpqKy2rvL9vZkolDUVqDhNfI24
         SCC+5HnBPtrSxIwmlkXWthNVdlBxoBAHZvRvQRPeTDaT16xsTT+b5EZgy5a4jPn4cvhg
         qgjWNPSdkhYwwsMjrxrPqYjPEK8UTmxrjRTeHtqy9YueK5pkLna1WpLTcDFsT4iYBR8W
         1qq+9FBInTjM3eLoC82Ran8bHOM6fIYpI9CJW7PyM0eMFzr6tut5eJyuVVkCxfIOqyrf
         fSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739574155; x=1740178955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GYQuJnhBN0yvMzA1EcZP0GVgXte4QrdClxq6a7RjPY=;
        b=xKBxiDpjPejox2TrrP1TgYyons7LuhdsU6ockeaIL2fY+QaU2cZrQODsm1pEqFCQ51
         D4Td/Rg5L6HYHmK5MfyAFyfXPOnC64mHU9VI41BA9IpOy/6cT95Ht4uzyiFU5VLJTx2r
         6yLdX9wm+DWQcls/PLZ/+Gw2kyZC7RxHGUDOonuH/+tDxWz6s8XjFWCCGl4M7wAC+fbd
         dkfqK5kVwJgLG8yhIY14Wr6+CYgyQfavfOMo5uOj0avo9tIVFZsCSLITPuFx+lDslaUG
         R+ySJAPZ+KbVv86OnKOzmIiVCQEd1XKOk2RHJiAmSkie7FFyIkMUfQIwcHauAzY1yCht
         2xsg==
X-Gm-Message-State: AOJu0Yyu7NhU0WVVzf8dLrF6+yxhtQ8UVkIu12mEVCqNL5jwZKAUl0+V
	Fi9yFu3feKtqyabIWK7QDGxFJe2plQuTN6CKEDLTazr7fDxO3xNTt0YTnWS0
X-Gm-Gg: ASbGnctF9AQNtJ28whQ+0KPJCo4hEH6pcw7uFKC/T14FMA4DuLsurRUdH8OjiVM+0Iu
	vR3q39+lRMjyuKSoVDoaBc8xfyHlW5IJohbg7DVYZuP8n4RQ4JFx/pu2/KscCMO2mfh/Oww3rk0
	C9ZOUp9AsQMXPT3gq2QhSsowuKcn708I+npEJrA+dleWjeJQ7nljpLQTa7mGtEAjBjKK49URTch
	6z5t8yr5RMZySZGXR3sBI55KXmNv800H49hEYmHw9Z9JvLOw6ZM/PoRPIREVNhrTLd5YkKOIL7A
	fOwKrYjwV+G5z/abgwfARRhCMiHgJepFka6Qhob1
X-Google-Smtp-Source: AGHT+IGYeezf+EwceGhDOxmtRKFj7CuhL9HQM/O9XytWc4XbMtbVd8OHt4aPCqh70Vji+uldpFWwsQ==
X-Received: by 2002:a17:903:41c3:b0:220:eade:d77e with SMTP id d9443c01a7336-221040a8e2cmr17988815ad.40.1739574155285;
        Fri, 14 Feb 2025 15:02:35 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22105174c73sm1495245ad.216.2025.02.14.15.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 15:02:35 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	johncai86@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com
Subject: [PATCH 6/7] builtin/for-each-ref: stop using `the_repository`
Date: Sat, 15 Feb 2025 04:27:22 +0530
Message-ID: <20250214230210.1460111-7-usmanakinyemi202@gmail.com>
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
argument that gets passed in "builtin/for-each-ref.c".

When `-h` is passed to the command outside a Git repository, the
`run_builtin()` will call the `cmd_for_each_ref()` function with `repo`
set to NULL and then early in the function, `parse_options()` call will
give the options help and exit, without having to consult much of the
configuration file. So it is safe to omit reading the config when `repo`
argument the caller gave us is NULL.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/for-each-ref.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 8085ebd8fe..0e9b126605 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "commit.h"
 #include "config.h"
@@ -20,7 +19,7 @@ static char const * const for_each_ref_usage[] = {
 int cmd_for_each_ref(int argc,
 		     const char **argv,
 		     const char *prefix,
-		     struct repository *repo UNUSED)
+		     struct repository *repo)
 {
 	struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
@@ -63,7 +62,8 @@ int cmd_for_each_ref(int argc,
 
 	format.format = "%(objectname) %(objecttype)\t%(refname)";
 
-	git_config(git_default_config, NULL);
+	if (repo)
+		repo_config(repo, git_default_config, NULL);
 
 	/* Set default (refname) sorting */
 	string_list_append(&sorting_options, "refname");
-- 
2.48.1

