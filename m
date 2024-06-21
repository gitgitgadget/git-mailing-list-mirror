Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286F015F3FE
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993426; cv=none; b=E1cylRsOgyk9C5ZB+TaF1KEPzxKbVTXejtmhihc0uVUdjFGGYGYNOwzIDOYBr4tUEXOubyDM34QhHE6JQmLIE/IAdi+5pmYDdLYL2szHm6LmiMxl/QjKclCT5f2ESYs0EmsbfN6PQYLmJeUx9EhmEPhhjC0YEr0KiXHMa/wq9EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993426; c=relaxed/simple;
	bh=Npyp/naK/1in8TupmnvEEiVyKMWz69k9xDepej1QuVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hP2IY7mOxHSuniCTPPLsRJPk6IZzePuQOGT5d0wdQu5sK29RjfECNu59qPHRnDMx2O3uwBpyJb9V4Xn1G2YPlKTQdi5pBN0D327GAaRf1V9I8qoJTGHT5glpT22f3FCMkySFxwziDGWNhty2SldfZwNKB9f909z7tFf5zPfiWjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4moPNA8; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4moPNA8"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-700986e3092so605095a34.2
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 11:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718993423; x=1719598223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VTsI4GxMYxkcjDPfbGWKqZbHQMYcWilD4iTfCmO0SQ=;
        b=J4moPNA8d8rAPDlxp/fAMRUJplxbp7H/NWOr8Kfby8cZwisHUEwcgfPsa+QwDbYJmI
         Qly/Nz1z/ztMuCS3PFfCBEMqQcutVEWkkY4HW+u4q/CJLm80QFwOXs2S1zOK63XqIpSC
         jXEGXV28qWW5WuE8PV0ytAeCSotvhNa5zbf18HdkBUFXNEqsb6zmlBcWQ+3/Bv16eqru
         FDXyt/vq85vQVH+u7xIgAZzCdvTJZkFWGuFqlH+2/KUcs4RfnM9mL0Y1g7Pp36S0BIIr
         ccj7JCBywapod3U9AFQsArFlA2ZSM5wYb1ZdeD39z/PDTBALn9deAuokSVE14df7v5jU
         2GRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718993423; x=1719598223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VTsI4GxMYxkcjDPfbGWKqZbHQMYcWilD4iTfCmO0SQ=;
        b=EnVhv0MgyVJm8K5CAJiw7Hxqkq94SC7O/mMQHaj0v/wR1SGoYVgHlx44BzleXshst1
         X16ffCQvh3XyYIWDVeynF/6/iZMd6gKPz9lNzAfUiORdqAxZnE2F5hiLXZUauLp43L3F
         wpT0IzRGjqDrEG+PJy8NhlqblwdpZtmUoMa4xoqeyCORS5HumxqnNQEaL5/+pqb8yIwk
         cXL1YPc3qaQhcTHrlSMH0QhYlsD5I5OovGghw8LGew3NLNkIn/i8xet5JjILjQhNiK9S
         EWsRVCdfIGmmQMV7QX3tZRNGepdd+dmbbSVqD/G9NJrkuCgdBHwsHHX8unkCr5vV0g1G
         DoKA==
X-Gm-Message-State: AOJu0Yz3zKwMHmHHfWKKUHMzjYA1MBJWYacKiE+NmBYLH8SPajoUXlUm
	XHGltZ5zu17sqCXlQEs3GT29QRTu6p/6AlUooH86BZSgIX3JL7SUf78k3Q==
X-Google-Smtp-Source: AGHT+IE4BLhn4VB1cnIOcEdy5zbXQdU5tfc3cyOFymGGTp8bP+Th+AsRRot8UouCeVGqyi5IuzG9cw==
X-Received: by 2002:a05:6830:8:b0:700:188a:9436 with SMTP id 46e09a7af769-70074dbd60fmr9843227a34.12.1718993423029;
        Fri, 21 Jun 2024 11:10:23 -0700 (PDT)
Received: from localhost.localdomain ([2607:fea8:3f9b:a900:bce2:445a:248e:77bf])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef678ebsm10878116d6.132.2024.06.21.11.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:10:22 -0700 (PDT)
From: "Randall S. Becker" <the.n.e.key@gmail.com>
X-Google-Original-From: "Randall S. Becker" <randall.becker@nexbridge.ca>
To: git@vger.kernel.org
Cc: "Randall S. Becker" <randall.becker@nexbridge.ca>,
	"Randall S . Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v2 2/2] Teach git version --build-options about zlib versions.
Date: Fri, 21 Jun 2024 14:09:47 -0400
Message-ID: <20240621180947.64419-3-randall.becker@nexbridge.ca>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621180947.64419-1-randall.becker@nexbridge.ca>
References: <20240621180947.64419-1-randall.becker@nexbridge.ca>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change uses the zlib ZLIB_VERSION #define text macro. No
stringification is required for the variable's use. If the #define
is not present, that version is not reported.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 help.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/help.c b/help.c
index bf74e935b9..f378750af4 100644
--- a/help.c
+++ b/help.c
@@ -760,6 +760,9 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
 #if defined LIBCURL_VERSION
 		strbuf_addf(buf, "libcurl: %s\n", LIBCURL_VERSION);
+#endif
+#if defined ZLIB_VERSION
+		strbuf_addf(buf, "zlib: %s\n", ZLIB_VERSION);
 #endif
 	}
 }
-- 
2.43.0

