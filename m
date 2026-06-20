Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFE91A682C
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 03:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781925483; cv=none; b=rqONbq+4pvlsvJzn4EKNnoQdGTATLRm3ahGkVjhfi7Al1KgyD4BP3lpo4K6/ZjSPUKyaLHpxFKkHQLUefvU83CgvnkFQG9J4bV1lAyXY2mBMcz1LoVaGi3LGcUymVK60me9+U2ij9RNcgVh4HwqxU6KMNLSpy4AN6QtI+lZzTyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781925483; c=relaxed/simple;
	bh=3ndA3p3W61K4+RtOQJ7w7pWxDKxHQ6AOPSArZ9D+ErE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8k6v60xdJNStjLqjiHjVyFB4fqkoeNxtzXYpuw0kCDK3tvFnV73QgpxQj/5x5t2/SQfb4LAqjUJauTOBVz+6TRYw5aPAbcqJ5EfjujthDHxeyz+vXjz1l3a5ShDQRGey98SxhkqA6nwXWIZsTOIKlmXr28lBCMzwpi2UCm0Cu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3vjZsaX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3vjZsaX"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c6a97e1d1bso19591185ad.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 20:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781925482; x=1782530282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEN7yMhnZQf/He2k/J8dQUobZcUDbHWJwOwDndoGobI=;
        b=K3vjZsaXsp+J8/M8Gi/MPVe8RsQmepUUrTHCGibAcKE7wdUVJ9x8+3CyDWrxAua3hw
         CTbOhZKJEyzgI8R7eLQa265NxoC9qIBJn/cneLE2MemASIZVhabRCs8vNe9mnZo51j4a
         5Y2ZprBkOMxY+vekxtJDZv7Un4dpsoweZDMeAcLsGnaLvmTis4zUwoKTSjO/qmRremJF
         06vjto0efAky7H9BagD0OY4gBrL/7J6+yQJidKsIqSRoLqCIgATMqTopOs4wSYJASyCD
         Kpa64y789qYil1yl9GvSobaJvL5XMeRSezFy4sZ1qrQUiZVPyknFj5AfORv9L2szYAa/
         0+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781925482; x=1782530282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BEN7yMhnZQf/He2k/J8dQUobZcUDbHWJwOwDndoGobI=;
        b=S5FXCqAfeN8lgN5I/QutzxZeWMx5V3wxn/2cViCvyC8hlwymuxr8oueZCWAubCmKdu
         IXfrwU2sslbZGMPfCp/yA0wkOLpxVSzmKBpL8d8VEBKa6P7PfMunvU8gkTsg2oInthSu
         uNZnIcaW0nD+r3aLMQZK6KrJAmKRp98PH6kDAxLyUVEDlMb1CaGYFQi3iBCSu+ia+JMI
         TK87GKi/fLg6Rj8Br0ymTQscFsdR3Fo6FfXIW/aca4DeE36mcIsoR9qGEtSV467zrvEq
         St7tK/FHbTZJ9T6j4XMMKYpIoCbytnmpF1NPLw3DUOTceyegPetJmSYCOe/0kUmezR1L
         54NQ==
X-Gm-Message-State: AOJu0YxefT1fVsRjnY9sanbuceQiVez5DOziaIXFGaaVE9ajGEkpNhyc
	jWv3UJ13XUTMayu7VPjMlQ6XTzRAbUr4F22+Gqq4i+CYkBdlEo4MfUj8j141/g==
X-Gm-Gg: AfdE7ckMTiV7TLqQxSQPfVyX+RJ+C4vDkhbUrLd10ErynKO2/8zy562Gh4VhGr5Z6Vq
	5o6Uhct/+frm4+iMklhB13YGBQkoxrkFA1QlHo/QUUqYCB5FjkueTK2X+ZxIdsi5TRFFnx2+1Qk
	TRdavKF9thTdSykJ47616PIO9pQvuRTeKSonsiU9LagWRKtPT3Sxv4MsiuhtaGz1WojRkecd1NF
	cuZUDLPc0zDvccqShcW1AI/v7GNbotiIhTCxvidznNPP2ksm6ci+uELYQ3D2k8pjPCzd/hmV/RV
	gW/k8QmYbjNMnIGxuLqpKDrkLdab9OWZqpPebcYYrMDddELnmUSC82jWa8GjtyYlsL5Kd7FHvPW
	G7SmUwIBigr7BPmK0gGkNQTlcgIlkVxm/k53XsLfx9322jHs26oaQhr2FroKM3btIOP/vB99pJB
	A7LqwcdctWQR3pKjbv7EPkx6GoCaB5zh2zqL1m4NzE/0Jr4yuP/6GEvC+yBQIcXBHdvQPrmy2AN
	YaQ0URfd4geXzOa89Y=
X-Received: by 2002:a17:903:244e:b0:2c2:7e17:39f6 with SMTP id d9443c01a7336-2c719054d54mr64639105ad.36.1781925481778;
        Fri, 19 Jun 2026 20:18:01 -0700 (PDT)
Received: from jayatheerth ([2409:40f0:f:5924:9ce6:f181:f81b:c57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af590sm9581675ad.17.2026.06.19.20.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 20:18:01 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net,
	kumarayushjha123@gmail.com,
	a3205153416@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC Patch v6 2/4] rev-parse: use append_formatted_path() for path formatting
Date: Sat, 20 Jun 2026 08:46:42 +0530
Message-ID: <20260620031644.353772-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620031644.353772-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260620031644.353772-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the core path-formatting algorithm lives in
append_formatted_path(), print_path() doesn't need to duplicate it.

Replace the body of print_path() with a small mapping from rev-parse's
existing format_type/default_type pair to the shared path_format enum,
then delegate to append_formatted_path(). The two local enums, and
every call site that uses them throughout cmd_rev_parse(), are left
untouched.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 builtin/rev-parse.c | 73 ++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 44 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index bb882678fe..6de01466db 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -653,53 +653,38 @@ enum default_type {
 	DEFAULT_UNMODIFIED,
 };
 
-static void print_path(const char *path, const char *prefix, enum format_type format, enum default_type def)
+static void print_path(const char *path, const char *prefix,
+		       enum format_type format, enum default_type def)
 {
-	char *cwd = NULL;
-	/*
-	 * We don't ever produce a relative path if prefix is NULL, so set the
-	 * prefix to the current directory so that we can produce a relative
-	 * path whenever possible.  If we're using RELATIVE_IF_SHARED mode, then
-	 * we want an absolute path unless the two share a common prefix, so don't
-	 * set it in that case, since doing so causes a relative path to always
-	 * be produced if possible.
-	 */
-	if (!prefix && (format != FORMAT_DEFAULT || def != DEFAULT_RELATIVE_IF_SHARED))
-		prefix = cwd = xgetcwd();
-	if (format == FORMAT_DEFAULT && def == DEFAULT_UNMODIFIED) {
-		puts(path);
-	} else if (format == FORMAT_RELATIVE ||
-		  (format == FORMAT_DEFAULT && def == DEFAULT_RELATIVE)) {
-		/*
-		 * In order for relative_path to work as expected, we need to
-		 * make sure that both paths are absolute paths.  If we don't,
-		 * we can end up with an unexpected absolute path that the user
-		 * didn't want.
-		 */
-		struct strbuf buf = STRBUF_INIT, realbuf = STRBUF_INIT, prefixbuf = STRBUF_INIT;
-		if (!is_absolute_path(path)) {
-			strbuf_realpath_forgiving(&realbuf, path,  1);
-			path = realbuf.buf;
-		}
-		if (!is_absolute_path(prefix)) {
-			strbuf_realpath_forgiving(&prefixbuf, prefix, 1);
-			prefix = prefixbuf.buf;
+	struct strbuf sb = STRBUF_INIT;
+	enum path_format fmt;
+
+	if (format == FORMAT_RELATIVE) {
+		fmt = PATH_FORMAT_RELATIVE;
+	} else if (format == FORMAT_CANONICAL) {
+		fmt = PATH_FORMAT_CANONICAL;
+	} else /* FORMAT_DEFAULT */ {
+		switch (def) {
+		case DEFAULT_RELATIVE:
+			fmt = PATH_FORMAT_RELATIVE;
+			break;
+		case DEFAULT_RELATIVE_IF_SHARED:
+			fmt = PATH_FORMAT_RELATIVE_IF_SHARED;
+			break;
+		case DEFAULT_CANONICAL:
+			fmt = PATH_FORMAT_CANONICAL;
+			break;
+		case DEFAULT_UNMODIFIED:
+		default:
+			fmt = PATH_FORMAT_UNMODIFIED;
+			break;
 		}
-		puts(relative_path(path, prefix, &buf));
-		strbuf_release(&buf);
-		strbuf_release(&realbuf);
-		strbuf_release(&prefixbuf);
-	} else if (format == FORMAT_DEFAULT && def == DEFAULT_RELATIVE_IF_SHARED) {
-		struct strbuf buf = STRBUF_INIT;
-		puts(relative_path(path, prefix, &buf));
-		strbuf_release(&buf);
-	} else {
-		struct strbuf buf = STRBUF_INIT;
-		strbuf_realpath_forgiving(&buf, path, 1);
-		puts(buf.buf);
-		strbuf_release(&buf);
 	}
-	free(cwd);
+
+	append_formatted_path(&sb, path, prefix, fmt);
+	puts(sb.buf);
+
+	strbuf_release(&sb);
 }
 
 int cmd_rev_parse(int argc,
-- 
2.54.0

