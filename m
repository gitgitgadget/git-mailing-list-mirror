Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457025BAC4
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 22:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308752; cv=none; b=uQhhPezSynZ6SfXzhVSjCDMO3CeCm93nwAYARPmp6/E66DWFFGvRTxdIz5PW/slh6u2A/m8rfXGGtMC2xmZZfPesseWxVSpOip3GrXL8XNrQPpcfYgsr2amB6/ThiNRc72ulRsAgCVofbgFiEMH7KByxayBJNhk3+9yFoOTVtTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308752; c=relaxed/simple;
	bh=9OWE2jYEz2zBDeQHs8Xq4vCE0xUCJd6dLtTfQvVL2GU=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tE/y4G3eE455rc/hmC9S9qweojYoOhf61a3HkJOgPlEcYDECZA1CoxwIJiFfOQWn8HDzh9lDFXq6UyEr2m6RZZBk/30yu6pamL7t6/y9aPivEPkMxwmFW9ll2pD/P6DjxF/KhYaKAude1+p4ijUGIv8RTRBys2goj/tI/TCG3+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBnfqiBh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBnfqiBh"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e9ef9853bso13754675e9.1
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 14:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706308748; x=1706913548; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJEUR8ttb2FW4F01SMStunvlwDlg5leFii8d3URYToA=;
        b=dBnfqiBh/RX4/lHnaLOcSTbB3o3TjweGxZck1nJAKrhpBI4AB6c2Yw9Yjo/YLTGnxY
         3aaoHKNo042WpgmZe9IT4AOfYFuJwez652/iLZqpnHxDPpOXdzoaRVFxkF2n4mJoJ89K
         L/zXMKmOrsQbhp3KMnTu0tzwwL4vdI21S+rybOqC47M76iCCwrYeOiPS8wOfOvtHX9lM
         a0iDNeGDZC5V+7JRCm7LBqvmhJGcms7KILPumjE7Cl97ThBidv5zrUFI0JnoY6eesNrA
         8lO3j8ZoNnf88D1Eeth5Hy3c8PUo9nzJY8e7Exp2OUJPkmE2YIVqjNc44XSem4LL15Xg
         Ng5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308748; x=1706913548;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJEUR8ttb2FW4F01SMStunvlwDlg5leFii8d3URYToA=;
        b=oTOfupEDc+RARyfQ4AV6SWmxlrTd7SlOgVp73s8UJMb7z5ghTGqRVncWkSntBjHaER
         Xcmsk46pyvDWnQqLc7vrHg6qTLI6Dz0USBfyBZeMFrQYm3M+eDeRkEM7P/qAb5wxcxoZ
         G2Ow3h8PhMIfv6eBZzwEid7jJifpz66uEOs28rJmDUYBXszByc5jfgPeir8V/IS5zXQl
         hNiGoMygGEI6sTgXmQar020AmAU4dsjeWuyYlMq24h6QO2ruBJIlmcdYvHmwXGJtksQC
         jwH05TJSSovEdLbqOzmSWqeZHXxIfl3AiWiCfx3tD3N7H6lrbRwNbxV18rIrB2p2ehOK
         6M0g==
X-Gm-Message-State: AOJu0YwLvIiusYEndzQpwycYSLvQX3OsL6y3Rwc42WxTpgpTkVcGik/4
	WkJBkjxMo2kgvIdvC7wJo/ANYcgJ+G5gQPLI2vUGu0mAF3WCbpDVvS20AJb2
X-Google-Smtp-Source: AGHT+IFMMDmB+42gLo5Oq6q+3/QkCUWxIIdq4i4XpP/50vp1rALiqR8Xp9iaIUszkbYqMpqoLIm04A==
X-Received: by 2002:a05:600c:3650:b0:40e:e1c5:122a with SMTP id y16-20020a05600c365000b0040ee1c5122amr294177wmq.60.1706308748138;
        Fri, 26 Jan 2024 14:39:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c468900b0040ee4f38968sm1964812wmo.2.2024.01.26.14.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:39:07 -0800 (PST)
Message-ID: <ed67ebf8647bf7ed7d3effb65b4759cde0ebf759.1706308737.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
	<pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jan 2024 22:38:57 +0000
Subject: [PATCH v2 10/10] trailer: delete obsolete argument handling code from
 API
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
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

This commit was not squashed with its parent in order to keep the diff
separate (to make the additive changes in the parent easier to read).

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 39 ---------------------------------------
 trailer.h | 17 -----------------
 2 files changed, 56 deletions(-)

diff --git a/trailer.c b/trailer.c
index 1865d04bdf2..8016908039f 100644
--- a/trailer.c
+++ b/trailer.c
@@ -745,45 +745,6 @@ void parse_trailers_from_config(struct list_head *config_head)
 	}
 }
 
-void parse_trailers_from_command_line_args(struct list_head *arg_head,
-					   struct list_head *new_trailer_head)
-{
-	struct strbuf tok = STRBUF_INIT;
-	struct strbuf val = STRBUF_INIT;
-	const struct trailer_conf *conf;
-	struct list_head *pos;
-
-	/*
-	 * In command-line arguments, '=' is accepted (in addition to the
-	 * separators that are defined).
-	 */
-	char *cl_separators = xstrfmt("=%s", separators);
-
-	/* Add an arg item for each trailer on the command line */
-	list_for_each(pos, new_trailer_head) {
-		struct new_trailer_item *tr =
-			list_entry(pos, struct new_trailer_item, list);
-		ssize_t separator_pos = find_separator(tr->text, cl_separators);
-
-		if (separator_pos == 0) {
-			struct strbuf sb = STRBUF_INIT;
-			strbuf_addstr(&sb, tr->text);
-			strbuf_trim(&sb);
-			error(_("empty trailer token in trailer '%.*s'"),
-			      (int) sb.len, sb.buf);
-			strbuf_release(&sb);
-		} else {
-			parse_trailer(tr->text, separator_pos, &tok, &val, &conf);
-			add_arg_item(strbuf_detach(&tok, NULL),
-				     strbuf_detach(&val, NULL),
-				     conf,
-				     arg_head);
-		}
-	}
-
-	free(cl_separators);
-}
-
 static const char *next_line(const char *str)
 {
 	const char *nl = strchrnul(str, '\n');
diff --git a/trailer.h b/trailer.h
index e01437160cf..a71b770c564 100644
--- a/trailer.h
+++ b/trailer.h
@@ -32,20 +32,6 @@ int trailer_set_where(enum trailer_where *item, const char *value);
 int trailer_set_if_exists(enum trailer_if_exists *item, const char *value);
 int trailer_set_if_missing(enum trailer_if_missing *item, const char *value);
 
-/*
- * A list that represents newly-added trailers, such as those provided
- * with the --trailer command line option of git-interpret-trailers.
- */
-struct new_trailer_item {
-	struct list_head list;
-
-	const char *text;
-
-	enum trailer_where where;
-	enum trailer_if_exists if_exists;
-	enum trailer_if_missing if_missing;
-};
-
 void trailer_conf_set(enum trailer_where where,
 		      enum trailer_if_exists if_exists,
 		      enum trailer_if_missing if_missing,
@@ -79,9 +65,6 @@ struct process_trailer_options {
 
 void parse_trailers_from_config(struct list_head *config_head);
 
-void parse_trailers_from_command_line_args(struct list_head *arg_head,
-					   struct list_head *new_trailer_head);
-
 void process_trailers_lists(struct list_head *head,
 			    struct list_head *arg_head);
 
-- 
gitgitgadget
