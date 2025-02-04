Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354692135C2
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738679353; cv=none; b=qDZKgEj1RMTs/b9QdE1CqDfKlKFF2k2d9iPuOhhpdng/vVYqIKuQ59a8s5o45MFzt22KRC5cuNp0J6OIngpvmwvszyNyw2iuSKH0VYBtZ0thym8oGCr5/9sPeO40bzCNg7yBbja+Ls8ezvMcljmJ1EMaLJCdcHvoHo7OfvJMlDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738679353; c=relaxed/simple;
	bh=lifKQfIVi8WWx4IGU4bJ7E8zXdfLTm9UdxIBsvzDcNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fg2a4qefVW+yg34Jm1+ytr+hx2ZrTSDg5/+0o1IHXVgwLpTjI8ziUzJLmV6onwnf5rZfbgKhAYA10Czku5WVbctyzenASwckhmOQ+M85LDlLs6p9Gbon7Rggkang6+JVMxuz6Ip4VVd6ujHnWDVaFSCWoyT3iAfv098sNQNJzUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ktf3B/Tt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ktf3B/Tt"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21680814d42so97364995ad.2
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 06:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738679351; x=1739284151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaOtzpm6ARxJ60G+SmlGLIw0n+UMOS2aYBQQ6LhFhV4=;
        b=Ktf3B/Tt8NRmguoxM1qBs/AK9PgC1BpbrcSZXmMehbRPVAdv1/Rp+7lw4ReUJ4PeXO
         LXadXEaPURwfFTUfqM5ZjHooM+eKhgbU/CMLF5lovcAX6hKsuvaVXzdvqhx9i5HF8XhK
         x/KhIYNtBCDomZ3t7AEEITOWBPVDDzzGX6vWooTE6SRi4eIiAMClOpCJsEiEDoMZjWWH
         14PVYteUimrlKoiWuRqwYFFcly6I5693t+Y9zQRuLQ+G7q5aBvCw0q0bLCHQGO64A0c2
         wsYdOugm2XBK+Qr96cYiWRQeRQua9wvmS1SEtHNsv5KrZ5C4TdukZ8RFxzn3fKYphhdu
         654w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738679351; x=1739284151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IaOtzpm6ARxJ60G+SmlGLIw0n+UMOS2aYBQQ6LhFhV4=;
        b=JdVbiJ8t987RV7VabYZ38NCUtK5tuQ+kS9lWrKSlKh+uwmxuyyZInv5gSSCVMUY3Xv
         BvHCLBfArWpdf8RCjCzBnFdnYG2y+eJcxezP7nB69FRmQl/WhRmw6Sn7HhSe/KUkGOKh
         R51bWlTLlsn6uwW4e5z5lFbWuy79r3IFrluxUvPabWXIVMdYSiJrSWRKMrKQHQ+5dS3/
         e8jVd99D1zDdyQTd4DnLTGG/QG7h1bumlm9PkD/tYRS8/PcJrUopJ0cOWfmgoIa7XkFO
         NJFMy4MCIIknyPcDNSLY7IRELJGue3DIuSudV+XFInGfj7ndYZoahbnPoClNDAHaU3FO
         Ms7A==
X-Gm-Message-State: AOJu0Ywn5Cluuj9gGa6m4Ln5ekmstmN/t9wggFbTzN3hnMDdYBN4l08i
	SVL7+8cQIJor6JN9ROmTbEorRhB0VvMJNJGKMGMJKEcC+pgRvHQ37YIepw==
X-Gm-Gg: ASbGnctzyj46rNM17cAcrUIL+vT52uOoxwZvx9ZNRtQp2mUrq3Qx16nkMyJ0iYZcvhL
	e3diu7jtO3WXsV2xBdIaaX4LLGmq9f58H7V5I0TJEy2uvqsedM96XTxO8RQ3bB7jycmaFNUQk7O
	ZBrZubNNryPfvd+f7+FxqwjpPvWFHoNbsHmLx5ejFlbyR3J8pMoL2QYh2FMyqy1yDLTPgEoiVTH
	pIYGH9At+SnKeV41VgmOea2ZZKVgJoFcnatiQvOVufI5avROJbu/0QMXTZYiRoOi3vwW5df2u9d
	XblceaBi0zMhDQ==
X-Google-Smtp-Source: AGHT+IGFZ/LQ8jjHfVuaiQvz1zwfl45q4f8TTflYYB38z4X/xVUpqoEJVZsp18X/76MtcRYd2uTkUg==
X-Received: by 2002:a17:902:ce8f:b0:215:9d29:9724 with SMTP id d9443c01a7336-21dd7ddfdc9mr444796235ad.38.1738679350843;
        Tue, 04 Feb 2025 06:29:10 -0800 (PST)
Received: from meet.. ([103.240.169.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de3320fb8sm96687255ad.234.2025.02.04.06.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 06:29:10 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v2] remote: relocate valid_remote_name
Date: Tue,  4 Feb 2025 19:58:52 +0530
Message-Id: <20250204142852.13035-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204041430.36035-1-meetsoni3017@gmail.com>
References: <20250204041430.36035-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the `valid_remote_name()` function from the refspec subsystem to
the remote subsystem to better align with the separation of concerns.

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
Range-diff against v1:
1:  cbf0f21045 ! 1:  7736bae283 remote: relocate valid_remote_name
    @@ Metadata
      ## Commit message ##
         remote: relocate valid_remote_name
     
    -    Move the `valid_remote_name()` function from `refspec.h` to `remote.h` to
    -    better align with the separation of concerns.
    +    Move the `valid_remote_name()` function from the refspec subsystem to
    +    the remote subsystem to better align with the separation of concerns.
     
         Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
     

 refspec.c | 10 ----------
 refspec.h |  1 -
 remote.c  | 10 ++++++++++
 remote.h  |  2 ++
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/refspec.c b/refspec.c
index 6d86e04442..83ec7d7e62 100644
--- a/refspec.c
+++ b/refspec.c
@@ -236,16 +236,6 @@ int valid_fetch_refspec(const char *fetch_refspec_str)
 	return ret;
 }
 
-int valid_remote_name(const char *name)
-{
-	int result;
-	struct strbuf refspec = STRBUF_INIT;
-	strbuf_addf(&refspec, "refs/heads/test:refs/remotes/%s/test", name);
-	result = valid_fetch_refspec(refspec.buf);
-	strbuf_release(&refspec);
-	return result;
-}
-
 void refspec_ref_prefixes(const struct refspec *rs,
 			  struct strvec *ref_prefixes)
 {
diff --git a/refspec.h b/refspec.h
index 69d693c87d..dc428f86f2 100644
--- a/refspec.h
+++ b/refspec.h
@@ -61,7 +61,6 @@ void refspec_appendn(struct refspec *rs, const char **refspecs, int nr);
 void refspec_clear(struct refspec *rs);
 
 int valid_fetch_refspec(const char *refspec);
-int valid_remote_name(const char *name);
 
 struct strvec;
 /*
diff --git a/remote.c b/remote.c
index 0f6fba8562..3d451570cb 100644
--- a/remote.c
+++ b/remote.c
@@ -3003,3 +3003,13 @@ char *relative_url(const char *remote_url, const char *url,
 	free(out);
 	return strbuf_detach(&sb, NULL);
 }
+
+int valid_remote_name(const char *name)
+{
+	int result;
+	struct strbuf refspec = STRBUF_INIT;
+	strbuf_addf(&refspec, "refs/heads/test:refs/remotes/%s/test", name);
+	result = valid_fetch_refspec(refspec.buf);
+	strbuf_release(&refspec);
+	return result;
+}
diff --git a/remote.h b/remote.h
index bda10dd5c8..0c14d665b6 100644
--- a/remote.h
+++ b/remote.h
@@ -461,4 +461,6 @@ void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
 char *relative_url(const char *remote_url, const char *url,
 		   const char *up_path);
 
+int valid_remote_name(const char *name);
+
 #endif
-- 
2.34.1

