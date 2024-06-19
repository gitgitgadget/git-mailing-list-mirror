Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E08132129
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 12:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801860; cv=none; b=nrgEnB2PLqx6+28Brj6FwqUPOA5gwLQU3u6tZi8FLA7qDf0Jnc8NqhgS2kqzspNMk2Efbb6bxKXUU1ds41csC1AYbRIkpZr/GtRe/vXpSbxbOF0YEsNvFCUdu4dJkHh1NcT9MKhXYUJrBOIg6985jNNd+e4j9+ivUrZ9cWU3t3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801860; c=relaxed/simple;
	bh=8WmvwybqYAbskP9YlCbCM7P80VtOaiWupd8OWeRXmOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CN9kBa5EX5caujEwCGmJklUmg8Eh8iT7G9168XzCX0EHJ7r3pcdSqyFO7pZGQOChZSEEdbgI2UeSQOHsLK3WW9fh5cRdU7afQkjPGu3nNmMDI+G6eubbS/60QL8K44X07FeJOFi/7M/+tyCkGYULQUTysFgHABi43qBGauWgsTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+qFkx8p; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+qFkx8p"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57c7ec8f1fcso7880125a12.0
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 05:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718801856; x=1719406656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KC3SsKkoUtFWyZxkr2s5yCHUIcdml+ol4m/HJG/PNwM=;
        b=e+qFkx8pZB2gUlLdg17o3/I9RZZ9jj6AXMje8qnwd8H3DSI4Amfy2lGeVeCkYQb5Qf
         X+PomIBBC2SOoAmXa9yfZb+pPiOsRBYiE0uueb0La8ziSy0V0R4EZwb0TF9SlnkIPGJC
         l9+UBJ86qwubEXU6lTrhwzxrxDUVhXurtzNSDktFPztEQGlpbkyhtj9ruFLlnrqnUtck
         MItHw9khBYWI6LwCPZmabQLQHZ7dtkIDfOa4jROBIns/QbVBJHoSE5NUmHugVZCoIWpG
         ZBaFItjkvvqeOFGuBjI7vmIYtPpYevSpQr0omQc8WGnhMc2XzBHXGQeVq27op8JIuU8f
         9QYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718801856; x=1719406656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KC3SsKkoUtFWyZxkr2s5yCHUIcdml+ol4m/HJG/PNwM=;
        b=PcRvxeXoUvW1/4Cg5RbVzxzW6lTDz9Y1PobGubXtWVvptbtPa9O8Bvw1J9Xo6uAcW8
         LiNHYGJs73btL3LLFZYgWoFQgZlKIjC4V4i15GFX8FokomcbO5RLBgJNJ+8VOuy0Wto3
         ECpdenhIL16tGcWnUp3I6xFfGhF5ID2RzT4jUCqY7eLZGRU7kOof53i+yWypnt6cUCKG
         GTdNmjTARuFgq1/5ZkHKymq/4lFsNknYVVHnDBn3yclMn2x8Zv3GwHKVbyP7AO+wEz2F
         hGzaddNcke8mLxQb8Pb5bihJN3586Bgd2b8/CKFhan/uWDNDQOpoCrkrgAHA4SChUcvL
         N6xA==
X-Gm-Message-State: AOJu0YywpnjbhmNNiwE7KQbZ5gp8GwjG4TQOIZq246hqRX4vrR7PVu4Y
	yLxg9Uk47fF72N3DvhaNIuehLf4yrNKgmO7Ra+Xfx/bvYYov0KsUjos+Uw==
X-Google-Smtp-Source: AGHT+IFkmOJZVyznSWwX3q11pT8sXjx6iNC3nJSqjSyoJU+B8QvhnpnvOxr6IHpYjXwQr5TN57RyNQ==
X-Received: by 2002:aa7:df8a:0:b0:57c:c019:a9f6 with SMTP id 4fb4d7f45d1cf-57d07ed27d7mr1379625a12.32.1718801855690;
        Wed, 19 Jun 2024 05:57:35 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72e95d7sm8334237a12.47.2024.06.19.05.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 05:57:35 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3] version: refactor strbuf_sanitize()
Date: Wed, 19 Jun 2024 14:57:06 +0200
Message-ID: <20240619125708.3719150-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.45.2.564.g3a7d533bde
In-Reply-To: <20240619125708.3719150-1-christian.couder@gmail.com>
References: <20240619125708.3719150-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The git_user_agent_sanitized() function performs some sanitizing to
avoid special characters being sent over the line and possibly messing
up with the protocol or with the parsing on the other side.

Let's extract this sanitizing into a new strbuf_sanitize() function, as
we will want to reuse it in a following patch.

For now the new strbuf_sanitize() function is still static as it's only
needed locally.

While at it, let's also make a few small improvements:
  - use 'size_t' for 'i' instead of 'int',
  - move the declaration of 'i' inside the 'for ( ... )',
  - use strbuf_detach() to explicitely detach the string contained by
    the 'buf' strbuf.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 version.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/version.c b/version.c
index 41b718c29e..331ee6c372 100644
--- a/version.c
+++ b/version.c
@@ -5,6 +5,15 @@
 const char git_version_string[] = GIT_VERSION;
 const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
 
+static void strbuf_sanitize(struct strbuf *buf)
+{
+	strbuf_trim(buf);
+	for (size_t i = 0; i < buf->len; i++) {
+		if (buf->buf[i] <= 32 || buf->buf[i] >= 127)
+			buf->buf[i] = '.';
+	}
+}
+
 const char *git_user_agent(void)
 {
 	static const char *agent = NULL;
@@ -24,15 +33,10 @@ const char *git_user_agent_sanitized(void)
 
 	if (!agent) {
 		struct strbuf buf = STRBUF_INIT;
-		int i;
 
 		strbuf_addstr(&buf, git_user_agent());
-		strbuf_trim(&buf);
-		for (i = 0; i < buf.len; i++) {
-			if (buf.buf[i] <= 32 || buf.buf[i] >= 127)
-				buf.buf[i] = '.';
-		}
-		agent = buf.buf;
+		strbuf_sanitize(&buf);
+		agent = strbuf_detach(&buf, NULL);
 	}
 
 	return agent;
-- 
2.45.2.563.g6aa460b3cb

