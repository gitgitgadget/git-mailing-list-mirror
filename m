Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB5522D780
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 05:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309485; cv=none; b=aB450nDIX3cVtmXvDALTeTlFaoQb5k8NzyQC2w3OFiE6l4FLn1yZFkYwzi4q3PblBcfBB2sLBq1B9DQs/dAvz1UizLL2H4FriPRyhQdvjQ88roN3ZPIvir2oHX4NUD45myZetCFJYgS+mxTAPHZOqBCMOi0DQTtAVkz9jt2U3z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309485; c=relaxed/simple;
	bh=qmcaNEypyQ/rEKasaFGGhBDzvNkRgb16DqR/SKFAQug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMdLN0Fcisii5sikmCqq4Y6PvtzyByWUnizPPidT+m4MYFtT3xewVs8SKEa5+cZCE2Wfx0Q+qmRZ9f/5w7VwTwZfQJWsdRgmhqqnrX4/35AkTbs1T8emACPV8OsaPCXnHMYix/6IL2k4LmdcYFC+UQ/GYHpRxZ9HYuBcnonB268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqGoqEeT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqGoqEeT"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45de221dc05so8450935e9.3
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 22:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757309481; x=1757914281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nC2JLHO1bc8sFA/XZPQg3qmIyoeohy2kBsu9CTJyTg=;
        b=CqGoqEeTdNX7H1oYESr7A0WCfutmx7lXNNnJ415h/CtMG1CY/iEAadSyNdLI4bb4rI
         IoH/8+uPOkNQut3yR9LHljbUWdMX6iGW3jEtobkaQdXD6lMeyl1Zvv/nOSBlexSfYMAh
         TPfc5q+2JQkknshBbmMD9ieaqA2qxT2xX9MjD/hlFhWA2iTVi2elNxKAw2+6p89cyJYA
         DHMtjfetJ+r3Frul58L23aUMwFwEBCG9pVC2+B4aNsCMiCVd0g7Ptlzq/xXEDgzSrJA5
         wiCqrsqW3lWGXnI8vcJQj3/qrRJmI5ELEPIrHxXG82YzD2zt7lDjr2UmZSRgOo6nwwMM
         bHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757309481; x=1757914281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nC2JLHO1bc8sFA/XZPQg3qmIyoeohy2kBsu9CTJyTg=;
        b=TcQzLvmHDsqdGA5RAFFMH7zWlVomxTubZuRTlchylmukTiUKkWKp/OuvneVLdD2/V5
         RESfM6gAuYmLhvZXG8Oxyi2R8zTvcDORocZBuIsufEUUU6/GzEU5Bdq2N6OM9xHVvb9c
         JW72Sl8ZPop+H+uNvn+ImAHpo3mJUeMd27NDnOejgvhQGEZkLFkh55CwMLfxGSPkdy6S
         B8CN8YjxAK7FRJsH6fIZezew5rqi2cRCCmfJhUUU1k0xwxpCI4ekXC5unBigfpdNjahA
         Or8gG1MDOQMMj6aBuM/Pud1xP/tT155S+63iwjeCyWnoqi1IMpgQBUNzYZxwAnMIk+qE
         yZkA==
X-Gm-Message-State: AOJu0YzxVu4gjfdJxSFTHqfyWbXZN/TH5PWWA/946jldudu6mJXUOaci
	GRD7B4ZoK7f/juy03P+aqpbJdeG+q3lmJW2ZC+SJilBCcoDqlW5uFlgX63YwHQ==
X-Gm-Gg: ASbGncu8iHft3GdmxCXGgRr9Ut9EUIGUBGgSYNzWFuU9gW0t+rOlyl9lyd68y2tFPEf
	nfN1y4gc73BLkkI8HTW6BQ0Y1gaa1UzxzVTifV70CrgEyAofXK5qO1Uvu76ajBuaTjKc2yojldZ
	nHsc0t7+pbz470x3bSLgLkY+MdMKg+4FiMsyk60la2rf/pYpuWqaEC5I6nLZQ8j3NNuwp5X4A/8
	/ukZFcC+Gk+Mt1Zd5+377FvMX6gtrwNnpMwceQeTHjd+3hbTW9KunLKIbFug95P35b4aCMpu3vF
	xxEUgsZkuXPj9nt9KEY/RfAnQ4iBRYOBOTex/1IEAFMq3bkUuuEpGmvMq76i5PehZKqnVt9ZJvd
	ZKeoU9ubSnytyA36fdm1ueNw8kBYBGXnnxvTqyhsKEAb4tQPT4HcoVhsHi7VfkWHo5bzC6AQB9f
	+1NLlI
X-Google-Smtp-Source: AGHT+IHgbVusRB8Kic5qMRPwPoUF8wC+6PKjPPYiaKPLnP2b0Zwg1bP28vSXPilvi4VSbt/vc0iPqA==
X-Received: by 2002:a05:600c:4585:b0:45b:8ac2:9759 with SMTP id 5b1f17b1804b1-45dddecf557mr52919935e9.23.1757309480504;
        Sun, 07 Sep 2025 22:31:20 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d5e5fsm40356579f8f.27.2025.09.07.22.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 22:31:20 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Jean-Noel Avila <jn.avila@free.fr>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v8 5/7] promisor-remote: use string_list_split() in filter_promisor_remote()
Date: Mon,  8 Sep 2025 07:30:51 +0200
Message-ID: <20250908053056.956907-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.174.g123d41a7fc
In-Reply-To: <20250908053056.956907-1-christian.couder@gmail.com>
References: <20250731072401.3817074-1-christian.couder@gmail.com>
 <20250908053056.956907-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A previous commit introduced a new parse_one_advertised_remote()
function that takes a `const char *` argument. This function is called
from filter_promisor_remote() and parses all the fields for one remote.

This means that in filter_promisor_remote() we no longer need to split
the remote information that will be passed to
parse_one_advertised_remote() into an array of relatively heavy and
complex `struct strbuf`.

To use something lighter, let's then replace strbuf_split_str() with
string_list_split() in filter_promisor_remote() to parse the remote
information that is passed to parse_one_advertised_remote().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index c22128d09e..afec0d081d 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -623,10 +623,11 @@ static void filter_promisor_remote(struct repository *repo,
 				   struct strvec *accepted,
 				   const char *info)
 {
-	struct strbuf **remotes;
 	const char *accept_str;
 	enum accept_promisor accept = ACCEPT_NONE;
 	struct string_list config_info = STRING_LIST_INIT_NODUP;
+	struct string_list remote_info = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
 
 	if (!repo_config_get_string_tmp(the_repository, "promisor.acceptfromserver", &accept_str)) {
 		if (!*accept_str || !strcasecmp("None", accept_str))
@@ -652,14 +653,12 @@ static void filter_promisor_remote(struct repository *repo,
 
 	/* Parse remote info received */
 
-	remotes = strbuf_split_str(info, ';', 0);
+	string_list_split(&remote_info, info, ";", -1);
 
-	for (size_t i = 0; remotes[i]; i++) {
+	for_each_string_list_item(item, &remote_info) {
 		struct promisor_info *advertised;
 
-		strbuf_strip_suffix(remotes[i], ";");
-
-		advertised = parse_one_advertised_remote(remotes[i]->buf);
+		advertised = parse_one_advertised_remote(item->string);
 
 		if (!advertised)
 			continue;
@@ -671,7 +670,7 @@ static void filter_promisor_remote(struct repository *repo,
 	}
 
 	promisor_info_list_clear(&config_info);
-	strbuf_list_free(remotes);
+	string_list_clear(&remote_info, 0);
 }
 
 char *promisor_remote_reply(const char *info)
-- 
2.51.0.168.gc8716bf361

