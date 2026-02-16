Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A23330AD1D
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248230; cv=none; b=idZqkR0PnQpp9PS9DvFk8hYJXaGFdcjfEC3nor76bDanszKnm2q1NGtdGN6fZ0XkshqcRV7V/0B6gqUxEfUalqQ5qqMx95lROZDc6IZQKjr4H/oDm2dWcfkTE4RLhAP4hpXmNBtnW5sCjoDZKnIdOYtYwQI3Rmu5UrNqenHH7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248230; c=relaxed/simple;
	bh=hqmIsYf9n6/L+Fl/seiMDq+kQ1hA6AyovitUZ2cDlm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5SfvSZxHAOIZY8iR2E7nyjsrjQJVUc0XdgkpmKuohiBcDOANhGvazOAbXtgbwr1CI3bcsqU4NAUDNo9pN/kuFXFK96VqdUSzlGQET0+y+ypbOx6E6AjlcAya9NsKGtKowZG0IWCafijWiK75R9ORSgMPoO7odUgD/s3lttBkiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nV0QrLa3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nV0QrLa3"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48372efa020so21950625e9.2
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 05:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771248227; x=1771853027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXA0Upfejq+MOPjh4yqMV9oU+06mwlz8/oLNUxml92Y=;
        b=nV0QrLa3BTQb8L0CMWT5OivutE4SaA3Bz+L2l20GI4/gEmWJYI/dbWMDABR8NxffT1
         fe67UgXnE16R81ClA0nvOLXWRrEYK+y0dFBZuR7cPNvKBcYxLM/AHAa2SxD0kOTsvhlr
         eYZH7n6B6TkhfUVxENgF7Fu3LGMVu760M+t88wvcmzN7CNQaL2mMHqgK3H/F+lzvA9z1
         EqPIKpXAW6rPkANPxC3YDKHa9ywptXtCZr+1oUqcRhsnVdp+6xweQbXanfpIK5kVvv+y
         x/E4OoHxxJSoEW7i7e+CoJLtIZ2L53g0oCsV7sDdeYijPw34n/ylVwDg+YaQJfXFOLKE
         6mJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771248227; x=1771853027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zXA0Upfejq+MOPjh4yqMV9oU+06mwlz8/oLNUxml92Y=;
        b=bz9IS5bqiAdwrnLRTZ//at6nlbzdfYOGlmdEa20ApGY8kqC79WC7Qc0NSu0OAlZxeg
         B1cpA1dsVd+TSryWqXupm12yr7t/1zh52NyoTozbFLWzxGvtJZCOSXqmzPuXs1V//rTL
         u3Iq+ASmo1hYbhxVUlAxgTYHY9+kdcQUoGdChxhaLphedPpXK66mthhEvIuP4MFu/PWf
         jEFizVO4RCzgW2RhJjJEXgS6y3uf+KX4MVl3s3VgiE6s5jgJGdKFwJdd3iwbJ3MZzrNV
         MrjKAZT6FNY+vaIJHlMr3My4ia+zw+7hY7UEIhXPY1UTm8+k5T8oCYLgP6Zi/2NIvHrX
         Ti6Q==
X-Gm-Message-State: AOJu0Yya+K2J9d1dKq5og2ljTILC8YzGuaYOuEAiy1Eo9pjVMKMb0oeY
	GeOF9ZcFDFlAEakjuDqpaEIazNSf+H0eay4mV7EP+8fw3SthDG7nl4H+qMEk8Q==
X-Gm-Gg: AZuq6aIXWDTlH8zsgH17CzrpAyYkfCzj0DUiuMWBLMUXHlsHVl+c3o0IOWgUxHt7O+8
	TPRPx5eqTC8bapxkP2DsFMjP5+L/T0da/IFfYbn0SE+RwB2sxxHr2S3+a6kaHDRjUYdUNSs9mEE
	c6Uq9MjAHzCoLQsjXIbg/LidddP7HFiZ3SwE0BvBjU8jHEalV8GWnGDOcU2jEyWzMjePqT9FQJP
	jGpbqcfGkMOu9XEP5LmvOOdv1d9sDLdHwRUm2kJQD8EcMBFvsxh4H+3XK7Cf+TdNIwlkDmjW/rF
	RkboTXwRd9xF+UCdbqSpuJa9pSCMYcvDO5lFWq09hENvAs3qoVCahrqu+f2z89+Nfzf1uWYdebv
	d1KxY13Xhuw+LaKtfJXELdeHQ1rsCRZrFRQF/me0WjH08hyw8yeezCNw4SPGlZFx5Gn6cfoVh5o
	OKUeeY9NCtKDIApUA0PREA+e8oTLSNzgp5eL67RqP6muIC8zYudMv2szMRUhDLGi2KDYZnCF/k3
	4CBVQ57ItQilE1Q+BnjdqY0irrfFZCMmE2QHJ4=
X-Received: by 2002:a05:600c:4750:b0:483:7783:5373 with SMTP id 5b1f17b1804b1-48379bfd6b6mr123801515e9.23.1771248226957;
        Mon, 16 Feb 2026 05:23:46 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370ac3564sm235688025e9.5.2026.02.16.05.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 05:23:46 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 8/9] promisor-remote: change promisor_remote_reply()'s signature
Date: Mon, 16 Feb 2026 14:23:14 +0100
Message-ID: <20260216132317.15894-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.77.g4627d513d6
In-Reply-To: <20260216132317.15894-1-christian.couder@gmail.com>
References: <20260212100843.883623-1-christian.couder@gmail.com>
 <20260216132317.15894-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `promisor_remote_reply()` function performs two tasks:
1. It uses filter_promisor_remote() to parse the server's
   "promisor-remote" advertisement and to mark accepted remotes in the
   repository configuration.
2. It assembles a reply string containing the accepted remote names to
   send back to the server.

In a following commit, the fetch-pack logic will need to trigger the
side effect (1) to ensure the repository state is correct, but it will
not need to send a reply (2).

To avoid assembling a reply string when it is not needed, let's change
the signature of promisor_remote_reply(). It will now return `void` and
accept a second `char **accepted_out` argument. Only if that argument
is not NULL will a reply string be assembled and returned back to the
caller via that argument.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 connect.c         |  3 ++-
 promisor-remote.c | 24 +++++++++++++-----------
 promisor-remote.h | 10 +++++-----
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/connect.c b/connect.c
index c6f76e3082..a02583a102 100644
--- a/connect.c
+++ b/connect.c
@@ -505,7 +505,8 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
 		reader->hash_algo = &hash_algos[GIT_HASH_SHA1_LEGACY];
 	}
 	if (server_feature_v2("promisor-remote", &promisor_remote_info)) {
-		char *reply = promisor_remote_reply(promisor_remote_info);
+		char *reply;
+		promisor_remote_reply(promisor_remote_info, &reply);
 		if (reply) {
 			packet_write_fmt(fd_out, "promisor-remote=%s", reply);
 			free(reply);
diff --git a/promisor-remote.c b/promisor-remote.c
index f3bafb7731..96fa215b06 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -920,25 +920,27 @@ static void filter_promisor_remote(struct repository *repo,
 	}
 }
 
-char *promisor_remote_reply(const char *info)
+void promisor_remote_reply(const char *info, char **accepted_out)
 {
 	struct strvec accepted = STRVEC_INIT;
-	struct strbuf reply = STRBUF_INIT;
 
 	filter_promisor_remote(the_repository, &accepted, info);
 
-	if (!accepted.nr)
-		return NULL;
-
-	for (size_t i = 0; i < accepted.nr; i++) {
-		if (i)
-			strbuf_addch(&reply, ';');
-		strbuf_addstr_urlencode(&reply, accepted.v[i], allow_unsanitized);
+	if (accepted_out) {
+		if (accepted.nr) {
+			struct strbuf reply = STRBUF_INIT;
+			for (size_t i = 0; i < accepted.nr; i++) {
+				if (i)
+					strbuf_addch(&reply, ';');
+				strbuf_addstr_urlencode(&reply, accepted.v[i], allow_unsanitized);
+			}
+			*accepted_out = strbuf_detach(&reply, NULL);
+		} else {
+			*accepted_out = NULL;
+		}
 	}
 
 	strvec_clear(&accepted);
-
-	return strbuf_detach(&reply, NULL);
 }
 
 void mark_promisor_remotes_as_accepted(struct repository *r, const char *remotes)
diff --git a/promisor-remote.h b/promisor-remote.h
index d227299fd0..3d4d2de018 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -49,12 +49,12 @@ char *promisor_remote_info(struct repository *repo);
 /*
  * Prepare a reply to a "promisor-remote" advertisement from a server.
  * Check the value of "promisor.acceptfromserver" and maybe the
- * configured promisor remotes, if any, to prepare the reply.
- * Return value is NULL if no promisor remote from the server
- * is accepted. Otherwise it contains the names of the accepted promisor
- * remotes separated by ';'. See gitprotocol-v2(5).
+ * configured promisor remotes, if any, to prepare the reply. If the
+ * `accepted_out` argument is not NULL, it is set to either NULL or to
+ * the names of the accepted promisor remotes separated by ';' if
+ * any. See gitprotocol-v2(5).
  */
-char *promisor_remote_reply(const char *info);
+void promisor_remote_reply(const char *info, char **accepted_out);
 
 /*
  * Set the 'accepted' flag for some promisor remotes. Useful on the
-- 
2.53.0.77.g4627d513d6

