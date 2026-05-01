Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335A7375F99
	for <git@vger.kernel.org>; Fri,  1 May 2026 23:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777677320; cv=none; b=T3MpVH4RBBXx4FOYSt/X9jIL99oTfB6O5KzE0kK52IkFMh7zHkfvS8BV35Lr4v2GsiReZNrt9NZqXbWxBH3/6aVJQi2QzKnNqRzufPD1RVNHzXXl8ZrDZhz4Su8iCNGw0h+ldOPDpt1VqIxIy/2O3tIKYr5EYKwgOxiLtq/yi0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777677320; c=relaxed/simple;
	bh=GMfBZIWWX/MjNnBlsCQqUlvoiwRrrzERkWYkXzRMcJc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=guyKnEIkoyFG/22BdtWb1guz2kYT9SNRMUa+upLC6gVntxxXhvAQe6yQlI/Qrd3s6uy4o0eD8yuKBHB8BLXSI2IzFJ19aGqKhxLodF7ICuJUVzLPjyXLgmZsLXkpokjSaGorZhg4pmTKZCaNuIg2FWT+lifOJNb1YubNxVLJejk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cN8OR05S; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cN8OR05S"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12dbd0f8063so3747544c88.0
        for <git@vger.kernel.org>; Fri, 01 May 2026 16:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777677318; x=1778282118; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3A7hhoGW+CS4cGk3xniP0Vw7I1DTwDRECXOTZSuA8iQ=;
        b=cN8OR05S7VJU0mVXAMwZ94HYj/4gv0VIB0fOSQtUTOQABvP7jmPUDOYzxt/WmjNbXk
         I4KBm/vE20Z+wS5Yw85LvqGhOtRVSxQVXhIQSTuWi8J/UH/wf5ozPullEjl8uRR4F+zo
         MmHnrugrjWj32Zxgq6261IU3h5sJsxkq+gCNQs55PFNRQyb+h6ipwHXUidNvoulZfh11
         P56TyubQkU3HHfszxW4WLhvGS7m02Si/qFusEmCTn0vcdoksVjqDcmyBbPFGNFeNj5Sq
         bfOTM26Eibc2YBb2vodFlhvNnnNKUdgjA98mlasn3Pj8LcnHMDeEzDEydZhzG+dnEDXr
         EPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777677318; x=1778282118;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3A7hhoGW+CS4cGk3xniP0Vw7I1DTwDRECXOTZSuA8iQ=;
        b=j6ETYGoTi91s+wmFhi+6G54e2de/HCdlWD0/IldH12I4d+S/hXf9vRUjkFJLOS11CA
         +cobutBb60J/zHPBTE9wDMmCKXdmmVFRpyI0fgHz0OVkvjeYgONOS5IIS1TFTAq1l0SX
         7hnGhuCt0vkz6UU6ROIe+mOtLDIHyYQJDSqVGDw7JSMHvkqnqwtPGA6Ap5iU/cyI2LJJ
         x1azLmk2qFmwB0oBs9vKgVAfUxM03ShC1WkOyCJxrIJIH7kk1wbvc6JFG9FRr4mq6bLr
         ZEs/dCmA2xaUqX/1EGAGcbxZHV7VcZ0sVqisoRojpXdHgrVfp+hdsV/n+ZJOyainNjFu
         BWjQ==
X-Gm-Message-State: AOJu0YwKwP5iPqVZCK2eKJ6FwntKtSiGZsPIhF7zwIqfCBwYxzCgD1fk
	QOqmDjq9eLZRRSoYqRnqQK9UvCDXp20fsr0BwZi/IaGdOOzYE3uPkoKLyc+1ul6p
X-Gm-Gg: AeBDieu1+zhJVSqqOK1hk7L2qR92Yr+cs0O465EUqRmsUHL0Llt0ucP77NhO1ni+XNg
	YdPmgquuykZbSobfX7nGYk1+9Q3/FCDfHLiDqMFzOZJa+DinOOKH0/GmQ/u471jrPCgYVfge5vg
	3/GkOSEsBxaCLHIFkXd7NpcGKVFucTIzcVnOysOznPo1qrUy2ObI1QdhvnBKlbWUmlu3oSmePSQ
	t2jnCopDoKLWQT4ZT/k12gsKhfqxrxehIccf9sHKf1q+/th/g40Ja3OhJud5YjCJw8ClFp3o4MQ
	EFcqN6CJ+FVAwjWBTEFyv5fsG4ikNOexRJfGxB98f5YCHnimulSBVJCJhB5cqDLBjah4AAk0j0G
	cRHIJEM3OVgBkIak7rD/wHrT/46dPX1vtD63pJyt/H1+CYw+vtp1s0S512Qt35Y4nx1Bp2WgTvt
	SHDql1PcWDEe7fg4F8JQLsb7dBJdtcbhj+Td1gfCWashL4/YGDTg==
X-Received: by 2002:a05:7300:6d21:b0:2d4:aa5a:391c with SMTP id 5a478bee46e88-2efb84b138emr630353eec.12.1777677317664;
        Fri, 01 May 2026 16:15:17 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.231.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b390df0sm6188321eec.17.2026.05.01.16.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 16:15:17 -0700 (PDT)
Message-Id: <e584fb03f3c23fda452b8e53d287f8f835becd48.1777677310.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
References: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
	<pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 01 May 2026 23:15:05 +0000
Subject: [PATCH v2 3/8] url: move scheme detection to URL header/source
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
Cc: Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
    Matheus Moreira <matheus@matheusmoreira.com>,
    Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

From: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

Move enum url_scheme and url_get_scheme()
from connect.c to url.h and url.c
so that other code can identify
a URL's scheme without depending
on connect.c.

No behavior change. url_get_scheme() still dies
on an unrecognized scheme name, with the same
translated message as before.

scheme_name() stays in connect.c
because it has no other callers.

Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 connect.c | 22 ----------------------
 url.c     | 16 ++++++++++++++++
 url.h     | 13 +++++++++++++
 3 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/connect.c b/connect.c
index cb145de30e..1ac7acc6e8 100644
--- a/connect.c
+++ b/connect.c
@@ -700,13 +700,6 @@ int server_supports(const char *feature)
 	return !!server_feature_value(feature, NULL);
 }
 
-enum url_scheme {
-	URL_SCHEME_LOCAL = 1,
-	URL_SCHEME_FILE,
-	URL_SCHEME_SSH,
-	URL_SCHEME_GIT
-};
-
 static const char *url_scheme_name(enum url_scheme scheme)
 {
 	switch (scheme) {
@@ -722,21 +715,6 @@ static const char *url_scheme_name(enum url_scheme scheme)
 	}
 }
 
-static enum url_scheme url_get_scheme(const char *name)
-{
-	if (!strcmp(name, "ssh"))
-		return URL_SCHEME_SSH;
-	if (!strcmp(name, "git"))
-		return URL_SCHEME_GIT;
-	if (!strcmp(name, "git+ssh")) /* deprecated - do not use */
-		return URL_SCHEME_SSH;
-	if (!strcmp(name, "ssh+git")) /* deprecated - do not use */
-		return URL_SCHEME_SSH;
-	if (!strcmp(name, "file"))
-		return URL_SCHEME_FILE;
-	die(_("protocol '%s' is not supported"), name);
-}
-
 static char *host_end(char **hoststart, int removebrackets)
 {
 	char *host = *hoststart;
diff --git a/url.c b/url.c
index 057576042a..300acf98fe 100644
--- a/url.c
+++ b/url.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "gettext.h"
 #include "hex-ll.h"
 #include "strbuf.h"
 #include "url.h"
@@ -140,3 +141,18 @@ int url_is_local_not_ssh(const char *url)
 	return !colon || (slash && slash < colon) ||
 		(has_dos_drive_prefix(url) && is_valid_path(url));
 }
+
+enum url_scheme url_get_scheme(const char *name)
+{
+	if (!strcmp(name, "ssh"))
+		return URL_SCHEME_SSH;
+	if (!strcmp(name, "git"))
+		return URL_SCHEME_GIT;
+	if (!strcmp(name, "git+ssh")) /* deprecated - do not use */
+		return URL_SCHEME_SSH;
+	if (!strcmp(name, "ssh+git")) /* deprecated - do not use */
+		return URL_SCHEME_SSH;
+	if (!strcmp(name, "file"))
+		return URL_SCHEME_FILE;
+	die(_("protocol '%s' is not supported"), name);
+}
diff --git a/url.h b/url.h
index 39d621312f..24c8cd91d0 100644
--- a/url.h
+++ b/url.h
@@ -23,6 +23,19 @@ void str_end_url_with_slash(const char *url, char **dest);
 
 int url_is_local_not_ssh(const char *url);
 
+enum url_scheme {
+	URL_SCHEME_LOCAL = 1,
+	URL_SCHEME_FILE,
+	URL_SCHEME_SSH,
+	URL_SCHEME_GIT,
+};
+
+/*
+ * Identify the URL scheme by name. Dies if the name does not match
+ * any scheme that Git knows about.
+ */
+enum url_scheme url_get_scheme(const char *name);
+
 /*
  * The set of unreserved characters as per STD66 (RFC3986) is
  * '[A-Za-z0-9-._~]'. These characters are safe to appear in URI
-- 
gitgitgadget

