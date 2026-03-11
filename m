Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2745534FF58
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773239057; cv=none; b=BweOzDglWwNNxe+293zwiFjyhYiw6+oGeKF7c1OUcfyKUY8Q34sQ2TNeotgaYYmnLe8JUBv8oPtvkwN70+4sKHZL7r8elrmXc9xC4HkZT9KFYRxSCURbO9/miTNVyUJ4ooosXr7WTr85JsEMwPlwYCYk+j633fXXnUtitXv3PPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773239057; c=relaxed/simple;
	bh=L57DyL9JqYHJOxjCUoep8ioOMn7Lq7x9XdFf52WIIgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUcge5ckPp4bI6v3fSXiU4v5DqP15ZJ1M9l/11bSH4sSZ5hzv6rT7rTKAU0zyjt6nYKtLGl5arN8EsrixCuDkv9C3ySRceRWn4AqbeXSJVxaYqGfdVJ22YrYAfgRq6eH/7CHcNk5xZv3nUMcHA37tXISBCSToA4xf33+rEX8f5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgDZCCPY; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgDZCCPY"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82985f42664so3797869b3a.0
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 07:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773239055; x=1773843855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qz1lJcZy2HT8Stn73SouVxpOMJ392s47/FcfWKynnVU=;
        b=KgDZCCPYuLoDzTrF2Fo7Yg5MybBUKzYnrh53ldEls4aJNd1LoSYF6Z2Me9R7aSozrt
         jKF4hwQFnIwDBtiZFNjv41JquReLcwWHI192pJ2OABeqsAz7wrcbdJs7PVwvTBtWoggK
         Ca1T1gdcSXVzyvK36pbVj8AKyR5QBJvJqLVF1GChUx86RwRLnJ2LCo7ydUyfWn3ur9ZZ
         p42GfXqVR7yl99bYfUio50rMY9oyZ0YTi60oWjIaRTwr/h1s+BETVRSfLbYfE4zNs1YE
         mMdPRk3Dd1JTDtZDfVCCWD9gnpV4uOKe3izmAqtz3RRfkttgd2NwUCoBvy8iBJ7XcR+6
         Ms/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773239055; x=1773843855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qz1lJcZy2HT8Stn73SouVxpOMJ392s47/FcfWKynnVU=;
        b=L0ZLAXFd/qe6JQUztEqkxcszb3lqgaMgdGCuNe2NNwOx9g/rNiI3gxr/e4O3t1MHzK
         jevWdODHbNWgYERSSyDr2g/7ghbmYXdU+SdZ7TsnCoQrGprffoRCRnDCKJEFZOci24FT
         YAOpAy0lIMJ7j9VLCXuOWh7FD//sFbfQIWbbLlAE3ldGBuqRXYcPnbkuIXiKRB78T1p0
         LEeb4qbgp8Eqk8jVeiUo+hfZeMyk/Se2tojU4QBaVpEsrt/zX8Ylldi8txtC/TWqwtUx
         yGaxh6PdU3/wZ5qskqnorZAm+qxZ+RSveUTB0p3nOI6q+OMzyBy0c9aHDb6EcoXeDihf
         barw==
X-Gm-Message-State: AOJu0Yy0flGm2mY/SYzvHK/6xySF7z1EkvVBVAM6RhLmE4gnYrPfxsEI
	a04mZieyhNsEzyhaNcS0CO6FmU4TAPjCqlDBFshmtZh3b2Khha716gEASH3xYBSp
X-Gm-Gg: ATEYQzwhsvl3w67J4/wfS4pCdghrk/6kl0j2azbrUYuUIlYAh0kPCY7YjMiNx/y2QF0
	n58Uu8orIX/cyl9XSjnk9zH6exeyvO6jvk1Eg/fjxfmV87EmeZ8IgsPcUZAOBOGo6PWkJjHLkJS
	DbAmPfFO86hGySLekd6qjZ0+pl0djdg82MHlj6phxD5wcc1KwO3TinJ25MdNIwqmTzMGP9ibAY3
	oE8Yy8VYULKJqtkkVa0s8hNoujXmBM8qaQ4LWvDS0bzrzEfT8Wa8bk0AR7u/Dhlwr8Vv7wRJvFj
	nZafRCm0HaatyiYtyMwmDmDDUsu5gQecGFRdx/FQx7urBQulkevfLoyIOUbEBqw3yDR+KTzZOGE
	Al016yNZYSDHr0/iVfWnXr/aTg3dm2xo6ghjxoY+nMOM9HMTZwcGfI8z6GtMNWJqBUW6sC6nslG
	qTmtiWneAH3kNs05JOb6E7Q+Sj3BcUChcvVRzEcuCdptWTAR8=
X-Received: by 2002:a05:6a00:1882:b0:824:92b7:63ac with SMTP id d2e1a72fcca58-829f6ee89ffmr2895677b3a.13.1773239055060;
        Wed, 11 Mar 2026 07:24:15 -0700 (PDT)
Received: from CPC-yingh-DJJP7.reddog.microsoft.com ([70.37.26.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6eebea0sm3552081b3a.40.2026.03.11.07.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 07:24:14 -0700 (PDT)
From: Andrew Au <cshung@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Au <cshung@gmail.com>
Subject: [PATCH v2] transport-helper, connect: add atexit handler to reap children on abnormal exit
Date: Wed, 11 Mar 2026 14:20:21 +0000
Message-ID: <20260311142021.3464789-1-cshung@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223165147.3294516-1-cshung@gmail.com>
References: <20260223165147.3294516-1-cshung@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When git exits via exit(128) on transport errors, child processes
(git-remote-https, ssh, proxy) are never waited on because the normal
cleanup paths (disconnect_helper, finish_connect) are bypassed. When
git is PID 1 in a container, these un-reaped children become zombies.

Register atexit handlers in both transport-helper.c and connect.c to
ensure children are reaped on any exit path. Clear the handlers on the
normal cleanup paths to avoid double-waiting.

Signed-off-by: Andrew Au <cshung@gmail.com>
---
 connect.c          | 17 +++++++++++++++++
 transport-helper.c | 11 +++++++++++
 2 files changed, 28 insertions(+)

diff --git a/connect.c b/connect.c
index eef752f14..322b1f816 100644
--- a/connect.c
+++ b/connect.c
@@ -20,6 +20,18 @@ static char *server_capabilities_v1;
 static struct strvec server_capabilities_v2 = STRVEC_INIT;
 static const char *next_server_feature_value(const char *feature, int *len, int *offset);
 
+/*
+ * Ensure the connection child (ssh, proxy, or local git) is reaped on
+ * any exit path, mirroring the transport-helper.c atexit pattern.
+ */
+static struct child_process *conn_to_reap;
+
+static void cleanup_conn_on_exit(void)
+{
+	if (conn_to_reap)
+		finish_command(conn_to_reap);
+}
+
 static int check_ref(const char *name, unsigned int flags)
 {
 	if (!flags)
@@ -991,6 +1003,8 @@ static struct child_process *git_proxy_connect(int fd[2], char *host)
 	proxy->out = -1;
 	if (start_command(proxy))
 		die(_("cannot start proxy %s"), git_proxy_command);
+	conn_to_reap = proxy;
+	atexit(cleanup_conn_on_exit);
 	fd[0] = proxy->out; /* read from proxy stdout */
 	fd[1] = proxy->in;  /* write to proxy stdin */
 	return proxy;
@@ -1449,6 +1463,8 @@ struct child_process *git_connect(int fd[2], const char *url,
 
 		if (start_command(conn))
 			die(_("unable to fork"));
+		conn_to_reap = conn;
+		atexit(cleanup_conn_on_exit);
 
 		fd[0] = conn->out; /* read from child's stdout */
 		fd[1] = conn->in;  /* write to child's stdin */
@@ -1466,6 +1482,7 @@ int finish_connect(struct child_process *conn)
 		return 0;
 
 	code = finish_command(conn);
+	conn_to_reap = NULL;
 	free(conn);
 	return code;
 }
diff --git a/transport-helper.c b/transport-helper.c
index e95267a4a..cdfd40dfc 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -17,6 +17,14 @@
 
 static int debug;
 
+static struct child_process *helper_to_reap;
+
+static void cleanup_helper_on_exit(void)
+{
+	if (helper_to_reap)
+		finish_command(helper_to_reap);
+}
+
 struct helper_data {
 	const char *name;
 	struct child_process *helper;
@@ -147,6 +155,8 @@ static struct child_process *get_helper(struct transport *transport)
 		exit(code);
 
 	data->helper = helper;
+	helper_to_reap = helper;
+	atexit(cleanup_helper_on_exit);
 	data->no_disconnect_req = 0;
 	refspec_init(&data->rs, REFSPEC_FETCH);
 
@@ -249,6 +259,7 @@ static int disconnect_helper(struct transport *transport)
 		close(data->helper->out);
 		fclose(data->out);
 		res = finish_command(data->helper);
+		helper_to_reap = NULL;
 		FREE_AND_NULL(data->helper);
 	}
 	return res;
-- 
2.43.0

