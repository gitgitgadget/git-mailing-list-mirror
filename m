Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97041481239
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 12:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908341; cv=none; b=igPoBtGL2dycCmb/SFRUXJExIbrRgudJwUSSgPUjtvPrrSK8ej/ciefBJVdVLsLoNl5sr+7oYF6mhtSzsbAP7KYZQ1JfCbd6mcKeZhQtwnNvCK1gJtdliSaZ8nc4ICrMmx6GVX6kGQr6Jm51WDxkDVSc2LSioIU+TiZfGIQKpz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908341; c=relaxed/simple;
	bh=dI1a7upTI/ShAzrpsI5jXFDlt/1om4vNZM/1VUYVrP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XnK9jbNpiKXNN4E35CIzICmgIR8+2J8q25/sn9QSfEK+i3NAgs/cymnYnlCXSiuuycu007lA4QYYH0r2ykldCTMpJDptVgbj91SFQ+F6FDG3nZlcJ2T82PtdOd+CA7KdBUVzC/+GbVW7CTKT573TXNj9OXleTK2+YNFs8Sli1a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtNJSWDe; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtNJSWDe"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so5267325e9.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 05:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782908338; x=1783513138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7CzHEfJqZsnxjAC0kuMbHI3AapCvToRZt72r91hUWs=;
        b=DtNJSWDeyLFPlP3DqhFIp0i8kh0YoAVcJ4H2ft47X327+oklGCdgLyVgaLpp6wicar
         mJYjIP8srBOgTcs4uQrJh0dw8BAcn1sNrAFt9LV79O+IpMR7FfbbnaCGC9peYZjVhbUD
         xY2U3NsGFFHlHeCyZwlifxbzJ33CTDnWAd4hqbqf+4Nhd9IGTctlJ7Tju1rpZbp0oE30
         KsRcPuRioUj5yQgWHKbXONpIjMRPx6kz1M6pd0YRuBuOlpVKKr82fLy96l56uyZg9LF2
         Ebdl2OPWFmgLHkn6dvb2tZpsaLZdGbfYQyoYEWMMwZ8x6u55j/8LWYA0xX0q5k6dMpo8
         /yWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782908338; x=1783513138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L7CzHEfJqZsnxjAC0kuMbHI3AapCvToRZt72r91hUWs=;
        b=Uo5djH4HQH+mNamZigPW0qb0VgiEF/ej8EOhBPTxrtxtjRp6H3P6hsL6WX7zKdSTY+
         dI2WSBrjU6O2qJwt6ZmZK6Vr/cozhJg0+DFrcKIPC50U5jvN5D3iDws5goOt4x2XMDmv
         AIvIMijFJJIfMKsSXTANf64rkkM77b+wnF7VFGqr0J9jqCeE9xnzMMyMeBoWGHPupZVM
         9nVF0cW63wn4TEt4iV4tlT2bssa+bemUKHXKaB9TcbDuP8fTRa6XT+jisSX/JT+Lmtyb
         h8Kpyf8H31OZX+osXTC95pHNN//44kSonYh+LascGqrPrGdLXcDlKN/U4BBVzysQk1IP
         N3zg==
X-Gm-Message-State: AOJu0YyqD9c6L8sftKPapipfexiNlPMdNpNOI9rHYT8wMGgMaEQHVE3X
	aOdMfln/8+5Hh4oSHnKlIT1/zTYlZvVLl6ryUF4lTbXtPuQxh0Te0NrOK9FHD7ar
X-Gm-Gg: AfdE7clsRL5MkR+maZljzeQw86tgGFDO5o1l53PAfxac7M+aMvCm/YJoYgfTp23+4Fg
	6VSUVex7mjBeVO8qfhEVKKPFdMrQo05mZdjGmWo2VVQCh47ktQmrdyMZQrkcEEnbDxwCqV8eEdo
	g3u5rM02EzaWGvq/gRyMfIz9MUew0y1/2+ss8JoJ8JdAhOdkpDjgpc2dEDijouFnWbLhW4dGsEM
	x+qKNruJVrWU4NzXAWnh90kDDjwl2KZCgZICFSeBDAxuoUHV6tncnGLD5ThVbt8v7rW3F7aF4Yl
	g+1xCiv7E3Us8tB/zWHnjibwFu+L98/XBAfxLMVG7sWM2I4hTJvjmsaFZP7O9JTXv8Lmb8cx2Pr
	OQb1RBn1y3lk8azaxDvA6gwfSFqBW4A+RH5BAAZQ9OQViV8eu/WYyyev74IrdcbGWRhmZPg+hi/
	e4hhG/JaEJx6DaVv+rpoZZeYSYtNLfDJL3/mt7xMhjb1EtbCNCHZ/+De9z+qzpbEaDRiqD7nWiq
	LNsCbraJVm1GROHxXvYXQZ/5e1Oea3qjy8fHI4D3t2HbYV90GPyHTnN0IyD6Xq4I5uFFWr94E00
	PbfF8ssoEWY5+5GzS7nDtDadiXLKQ3D7srVioz9z+JU6AEGtrEkTuNwRXde/CW0t3w1tIRzZI+i
	8wJmkOYYvrg==
X-Received: by 2002:a05:600c:3493:b0:492:5030:5e7b with SMTP id 5b1f17b1804b1-493c2b24629mr23762145e9.10.1782908337911;
        Wed, 01 Jul 2026 05:18:57 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be810be8sm68267235e9.9.2026.07.01.05.18.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 05:18:57 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com,
	Jonathan Tan <jonathantanmy@google.com>,
	Calvin Wan <calvinwan@google.com>
Subject: [PATCH GSoC v15 07/13] connect: make `write_fetch_command_and_capabilities()` more generic
Date: Wed,  1 Jul 2026 14:18:41 +0200
Message-ID: <20260701-ps-eric-work-rebase-v15-7-c88a43b63917@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
References: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
 <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Refactor `write_fetch_command_and_capabilities()`, enabling it to serve
both fetch and additional commands.

In this context, "command" refers to the "operations" supported by
Git's wire protocol https://git-scm.com/docs/protocol-v2, such as a Git
subcommand (e.g., git-fetch(1)) or a server-side operation like
"object-info" as implemented in commit a2ba162
(object-info: support for retrieving object info, 2021-04-20).

Refactor the function signature to accept a command instead of the
hardcoded "fetch".

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 connect.c    | 8 ++++----
 connect.h    | 8 ++++++--
 fetch-pack.c | 4 ++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/connect.c b/connect.c
index 1dced8e632..7b472f8e5f 100644
--- a/connect.c
+++ b/connect.c
@@ -700,16 +700,16 @@ int server_supports(const char *feature)
 	return !!server_feature_value(feature, NULL);
 }
 
-void write_fetch_command_and_capabilities(struct strbuf *req_buf,
-					  const struct string_list *server_options)
+void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
+				    const struct string_list *server_options)
 {
 	const char *hash_name;
 	int advertise_sid;
 
 	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
 
-	ensure_server_supports_v2("fetch");
-	packet_buf_write(req_buf, "command=fetch");
+	ensure_server_supports_v2(command);
+	packet_buf_write(req_buf, "command=%s", command);
 	if (server_supports_v2("agent"))
 		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
 	if (advertise_sid && server_supports_v2("session-id"))
diff --git a/connect.h b/connect.h
index c4f6ea4b0a..c2bf492ed9 100644
--- a/connect.h
+++ b/connect.h
@@ -35,7 +35,11 @@ void check_stateless_delimiter(int stateless_rpc,
 			       const char *error);
 
 struct string_list;
-void write_fetch_command_and_capabilities(struct strbuf *req_buf,
-					  const struct string_list *server_options);
+/*
+ * Writes a command along with the requested server capabilities/features into a
+ * request buffer.
+ */
+void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
+				    const struct string_list *server_options);
 
 #endif
diff --git a/fetch-pack.c b/fetch-pack.c
index 4a8a70b5f3..3d32114907 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1387,7 +1387,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	int done_sent = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 
-	write_fetch_command_and_capabilities(&req_buf, args->server_options);
+	write_command_and_capabilities(&req_buf, "fetch", args->server_options);
 
 	if (args->use_thin_pack)
 		packet_buf_write(&req_buf, "thin-pack");
@@ -2255,7 +2255,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 					   the_repository, "%d",
 					   negotiation_round);
 		strbuf_reset(&req_buf);
-		write_fetch_command_and_capabilities(&req_buf, server_options);
+		write_command_and_capabilities(&req_buf, "fetch", server_options);
 
 		packet_buf_write(&req_buf, "wait-for-done");
 

-- 
2.54.0
