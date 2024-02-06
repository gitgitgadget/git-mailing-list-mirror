Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66017E59C
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196369; cv=none; b=P2OwR1IV1xW6zMM8rO9au0So0sFgBDUh/bESZqCWnwHJ1xIvMZZIFJrB4Ca+5X+URpl3peljWe/IxR1nYj45qYvGXIBYwHn28AeEyPHO2+BuEsZJWXFTGbBqKgLlyr/iMSKz14qwj5TsSdxyNOqZIZigbCLrWHteITcEqYyUjeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196369; c=relaxed/simple;
	bh=3QBod3B1n038BlgbObVjc68fbhnSBc9pvZJY+URzakc=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sdh1U2iqdqQXqSuSMefhXOEEdwz7AprFvhHwEGtj/DPRLGZfcppCY3Od7g/8rU/JZD3GEjqri+BRLP0kzAGyAujrTCtkZeq3cTWR2UNaaa1HY4Gg0Bt9hdUB/RgUqGlySinLe4SG0HHKIcjSLAbbkUj5weBq9ncvm3DTLkuL8vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OywSLDyr; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OywSLDyr"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33929364bdaso3190000f8f.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196365; x=1707801165; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Du40f09+tzKNtNcLoTuwc85Ub2+RD+11x9pcKQ3b0s=;
        b=OywSLDyrD67vRUkavhYnNR7vMIq20YpJrI3FLPoCgpEl6XaoY3Df+Er5XLiTR8P9Ib
         FXbvAx5UuySlqTDaW+kQWj3UN3piQtVXuZT+tlheRsPDjmlJIqW0vOseAo3uAu9nVC4y
         F0VdeEqGMMLDEkT/tyCfbyyXxfhnH3R8cFcHlmwGS8y5CmDgYisNirkVbdJ/2zmeYpvp
         RH0gXwHLkkjViFk5Gfr7+GzLJmWMewRFh+YHnDCuZr3gHYSHeDslu+MxgEuZOsDhHoIv
         cE0UeD2RpSqjyK5Fd3JTkiQO3KgGdoDiyIaFAhYOtHyNVRtHH88Bj8sffYy90TOQBRBu
         dN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196365; x=1707801165;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Du40f09+tzKNtNcLoTuwc85Ub2+RD+11x9pcKQ3b0s=;
        b=I2jZQcK8dO+P1soULfq1wkk9aRI5RqbKNxeqBalnQBRNSQ1czXTaE4FrEdcNiU9/Wa
         XUXk3uW0iCrHGvkScJiI1DM+Se8Ulwh0sXneJoQdAszdVfL3TCba3inB2mr/cemZPJOb
         gIgUZ8uD/4WTV9PrcVLJiPrEClnc/phItlvmbNInbw/ftHVDwgiv190Ab+/njaNo5A6c
         LAakEH0tQI0byEaonbmwVVXZ+h7khWGhbbmiwgqOanU/CfOs8tyDU17HRe7gBTadF+MZ
         UxNJqcp2JdIZNGyV7MvtMSz6GPiEtWyeChF25+CkFUkkoP3C+nm9hGOlAItlLaswOgZ0
         T8og==
X-Gm-Message-State: AOJu0YzenJyRJ28s7zn12O0ANjGFxYCvMlfb60rpjzBXP2FW9xV5wyMY
	KaqihEdddqgNnD4aIDHENSkzUujF5nMCPZFdGqr47zOG92LGRi+0w2An1gU9
X-Google-Smtp-Source: AGHT+IE2Z6skIl75ogNSpgizdfPn0xqGzE74huSLGWrOVxhD7vXUBFAi5id+TGci+1bzvVxwyLGnEg==
X-Received: by 2002:adf:cc85:0:b0:33b:3773:d93b with SMTP id p5-20020adfcc85000000b0033b3773d93bmr357257wrj.46.1707196365446;
        Mon, 05 Feb 2024 21:12:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXm+gDs+jqRbcQvjvvIwb52s5iRADZCNk5r2VaTlNPfGSTbNaJdi1hyR4eP+789xqqmow9yG7AyPALuAIBBEG3DakfuRiVzksq2lBZfvczoCUi30D5OnvtXlUcKUDRsN6BWNT0THeFCw/W2r6tiL48+A2UwFlrNCP4fBepZO9xH3CVArJ/AmkB0wwyOA97yrN510arP8mhO3g==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c1d8400b0040fe930b52esm17167wms.9.2024.02.05.21.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:44 -0800 (PST)
Message-ID: <31725832224e3d6b14066af8a87eaf4ab589179e.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:16 +0000
Subject: [PATCH v4 16/28] trailer: finish formatting unification
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

Rename format_trailer_info() to format_trailers(). Finally, both
interpret-trailers and format_trailers_from_commit() can call
"format_trailers()"!

Update the comment in <trailer.h> to remove the (now obsolete) caveats
about format_trailers_from_commit().

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c |  2 +-
 trailer.c                    |  8 ++++----
 trailer.h                    | 15 ++++-----------
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index f57af0db37b..11f4ce9e4a2 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -171,7 +171,7 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	}
 
 	/* Print trailer block. */
-	format_trailer_info(opts, &head, &trailer_block);
+	format_trailers(opts, &head, &trailer_block);
 	free_trailers(&head);
 	fwrite(trailer_block.buf, 1, trailer_block.len, outfile);
 	strbuf_release(&trailer_block);
diff --git a/trailer.c b/trailer.c
index 5c42a19943a..4f3318802d1 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1053,9 +1053,9 @@ void trailer_info_release(struct trailer_info *info)
 	free(info->trailers);
 }
 
-void format_trailer_info(const struct process_trailer_options *opts,
-			 struct list_head *trailers,
-			 struct strbuf *out)
+void format_trailers(const struct process_trailer_options *opts,
+		     struct list_head *trailers,
+		     struct strbuf *out)
 {
 	size_t origlen = out->len;
 	struct list_head *pos;
@@ -1129,7 +1129,7 @@ void format_trailers_from_commit(const struct process_trailer_options *opts,
 		strbuf_add(out, msg + info.trailer_block_start,
 			   info.trailer_block_end - info.trailer_block_start);
 	} else
-		format_trailer_info(opts, &trailers, out);
+		format_trailers(opts, &trailers, out);
 
 	free_trailers(&trailers);
 	trailer_info_release(&info);
diff --git a/trailer.h b/trailer.h
index 3c13006a4c1..9f42aa75994 100644
--- a/trailer.h
+++ b/trailer.h
@@ -101,23 +101,16 @@ void trailer_info_get(const struct process_trailer_options *,
 void trailer_info_release(struct trailer_info *info);
 
 void trailer_config_init(void);
-void format_trailer_info(const struct process_trailer_options *,
+void format_trailers(const struct process_trailer_options *,
 		     struct list_head *trailers,
 		     struct strbuf *out);
 void free_trailers(struct list_head *);
 
 /*
- * Format the trailers from the commit msg "msg" into the strbuf "out".
- * Note two caveats about "opts":
- *
- *   - this is primarily a helper for pretty.c, and not
- *     all of the flags are supported.
- *
- *   - this differs from process_trailers slightly in that we always format
- *     only the trailer block itself, even if the "only_trailers" option is not
- *     set.
+ * Convenience function to format the trailers from the commit msg "msg" into
+ * the strbuf "out". Reuses format_trailers() internally.
  */
-void format_trailers_from_commit(const struct process_trailer_options *opts,
+void format_trailers_from_commit(const struct process_trailer_options *,
 				 const char *msg,
 				 struct strbuf *out);
 
-- 
gitgitgadget

