Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B991E1FF1B4
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738781592; cv=none; b=pTxc9Ao42B+exyvRbQUvlYfc4tZcDjLqcHUGJ4t6/j9inBwtyNgwi5ijmsnSt+2fU2AbPhYeY52niuuEr++W6hhYRDhIMqEZ8kZB5rVJM65bKcYUJBTRL+e7dst0+I4IydAAlkuCUZuNyWVGCdzWRr59buKoPu7tFFHCRRPQ5Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738781592; c=relaxed/simple;
	bh=HVeukTMHNYer7qqxUJZvhIb+1eODx9LL40SC14YRDMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNMCg68n+tVYIR714avKyPO8Jw7Hbqda1JbjpjzWUyQV/SOF2dGT1IaGYsN91L9Fp9RtXQMHY5zoT+9hAEmhPvKROsJCwgL3uB6E5GeNzeK1wp//sN/Ah6KwT3go9JuL/FPEpu0MWiRqMMIlYK8XlKCQ0GaLusEmeKTvI8KuDWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/AmduVt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/AmduVt"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f2339dcfdso1063755ad.1
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 10:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738781590; x=1739386390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRekefwQgvdyI8vQ9EmJX5ETxl+wxhoojclqV8SCL8k=;
        b=O/AmduVtVC6I5frx8WggNFz5QfjN3B9m+AWr38ZbCMO/KapQsCRNLLrh316ooKuzNS
         hcF613tzgnBCnxXT0R7r2Sjr4ayLiHOfi8JvsueowDgAtUesc6bqns+QgTsA5m/X0a1B
         NTDRpQx3fI/8VeU9oh4EWGbpnOi+vSJq6PlJFoyGQEbgTbLMDfvqUyCFWLWfrL8VkeG6
         Ra0KeP4c2/ZoXTL3RFwr6B9pugNhPblt/LjuJ3Rys0SQIxPntNHbxyxbMH5LLRDiTfv8
         wCRGLDhbFBeVEX7QY4KDlBMaYVYBJ52sCUUrZutlvtHUypx4ZANuxM0DUBJUmrxwb36D
         VvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738781590; x=1739386390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRekefwQgvdyI8vQ9EmJX5ETxl+wxhoojclqV8SCL8k=;
        b=Lls/XVdYGe2hJzWIAJEQ5X7gDj7iZBCHVR56EPfQyL47jYI8fzrC0PMKXjUSLKJKtH
         hIxqk6qcRwsH8KXyfDGG3HSUYy2fjZXKrWNL3PINNphQCcyPfNuElVdAaRlEOQlSGleU
         Yya6u3rur3KAa0fXgYQlMZxi8Q+ag3cekiBGXkQIJlMDdNVTvyesAToD6iEllhGy3UXt
         oIUKGxjxJdvc/kR8dchEff3Tes6YfcaLNMo6iiicfalQsZRAP3mJ8elhzecJsKwN0Q+4
         EFEM9yFtHdQi4rNgS4UD5LUwjZ61pdJBBVJvBSI2kGaMlJl5V7bHxtuuclFqK3mkgshK
         R1wg==
X-Gm-Message-State: AOJu0YzWjjN+92SBg6gGVctC2sDFh/qfj8X2hQ+LWlap3ktolicil7fW
	uUS3C+dA/m8LaDO9C7Le6n5o9OBrYQ4bRhJxXKeARNzS7W2lUAOAwZUYOH9spUk=
X-Gm-Gg: ASbGncvD50ax819n4FFoVytGVNqrcPKG10Gx++LIW3K/rmq0ZU1OItXYz/sUwtwpL7Z
	9ho7CQGuqyZa9kslGfJxayATzM7uEaHKRgPohau03Uzh85xmbnI+pEMTSAB0oaM1g8zlh13ENwk
	9aJGw5ai9VNhP80brWocLScCMB0UnwMfRdJvneE9xEfI7suMWZILYigQNlo/pBV5tg/jrdeRuHJ
	QfkpfPXnfxx640/EWyZUrlEBFa7mvW8NStrh1Lhi+oxb7KKf9tQXApaWEuT9UrwkyaND7+maJUO
	BOasQaBTUCjCWGSd/jCyZzFxPs/huvnPu7daVJtt
X-Google-Smtp-Source: AGHT+IHi1PxRIZGw0xOuRSmHaopoh34QdmRHz2bLudC1O5T4txTeWRgvP53aMI6n3/zL4lIs1NosFQ==
X-Received: by 2002:a17:902:c946:b0:215:ba2b:cd55 with SMTP id d9443c01a7336-21f2f145833mr5122115ad.2.1738781589560;
        Wed, 05 Feb 2025 10:53:09 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f1e9f3ebbsm13754285ad.190.2025.02.05.10.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 10:53:09 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	=christian.couder@gmail.com
Cc: gitster@pobox.com,
	Johannes.Schindelin@gmx.de,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	ps@pks.im,
	rsbecker@nexbridge.com,
	sunshine@sunshineco.com,
	usmanakinyemi202@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 4/6] version: extend get_uname_info() to hide system details
Date: Thu,  6 Feb 2025 00:22:34 +0530
Message-ID: <20250205185246.111447-5-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205185246.111447-1-usmanakinyemi202@gmail.com>
References: <20250124122217.250925-7-usmanakinyemi202@gmail.com>
 <20250205185246.111447-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, get_uname_info() function provides the full OS information.
In a following commit, we will need it to provide only the OS name.

Let's extend it to accept a "full" flag that makes it switch between
providing full OS information and providing only the OS name.

We may need to refactor this function in the future if an
`osVersion.format` is added.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/bugreport.c |  2 +-
 version.c           | 16 +++++++++-------
 version.h           |  2 +-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 5e13d532a8..e3288a86c8 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -24,7 +24,7 @@ static void get_system_info(struct strbuf *sys_info)
 
 	/* system call for other version info */
 	strbuf_addstr(sys_info, "uname: ");
-	get_uname_info(sys_info);
+	get_uname_info(sys_info, 1);
 
 	strbuf_addstr(sys_info, _("compiler info: "));
 	get_compiler_info(sys_info);
diff --git a/version.c b/version.c
index 3ec8b8243d..d95221a72a 100644
--- a/version.c
+++ b/version.c
@@ -49,7 +49,7 @@ const char *git_user_agent_sanitized(void)
 	return agent;
 }
 
-int get_uname_info(struct strbuf *buf)
+int get_uname_info(struct strbuf *buf, unsigned int full)
 {
 	struct utsname uname_info;
 
@@ -59,11 +59,13 @@ int get_uname_info(struct strbuf *buf)
 			    errno);
 		return -1;
 	}
-
-	strbuf_addf(buf, "%s %s %s %s\n",
-		    uname_info.sysname,
-		    uname_info.release,
-		    uname_info.version,
-		    uname_info.machine);
+	if (full)
+		strbuf_addf(buf, "%s %s %s %s\n",
+			    uname_info.sysname,
+			    uname_info.release,
+			    uname_info.version,
+			    uname_info.machine);
+	else
+	     strbuf_addf(buf, "%s\n", uname_info.sysname);
 	return 0;
 }
diff --git a/version.h b/version.h
index afe3dbbab7..5eb586c0bd 100644
--- a/version.h
+++ b/version.h
@@ -12,6 +12,6 @@ const char *git_user_agent_sanitized(void);
   Return -1 and put an error message into 'buf' in case of uname()
   error. Return 0 and put uname info into 'buf' otherwise.
 */
-int get_uname_info(struct strbuf *buf);
+int get_uname_info(struct strbuf *buf, unsigned int full);
 
 #endif /* VERSION_H */
-- 
2.48.1

