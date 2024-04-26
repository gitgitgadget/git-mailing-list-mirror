Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6BC6AAD
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 00:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714091184; cv=none; b=lkp4WIwCMtmnqhiq/MXAsUR0U4lvAA2vCPuOVauhacHNjXXX6YPE4DEPB3UnXMGqiRmT5VCrSvQsM/jpbAK0IKLuTMnxOHZG14Qg0QdJpaUI0fDPnL+tOBC2g0rkge7e4qVYJE7Cy5s/VzS9nBCsNYqyDVt/iRqsZKC7GjQlW6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714091184; c=relaxed/simple;
	bh=yX6rb+UiEB1astWPY1iRzrTuD7QPl8KVlv1oC88H+4s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bHCYrXJog+cIN+cBHKks09Q24H+aHa74KOqOPYX4ozrx/KY03lii0QrItjV7x73xMe+vgz+XNjeRrzj0kiQX/QdigESdAnfkzcIIzC9BFgtr4qoucsQ/IcprEgZss53xYj+75s1A+zVT+AYumP9oXp5kn3m4E7G0o6LUm80Jeog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIDwx7ak; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIDwx7ak"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41b39d38cf6so12350705e9.1
        for <git@vger.kernel.org>; Thu, 25 Apr 2024 17:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714091180; x=1714695980; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yELVRQ8ZDtDc4lZA2exN72FHqFJ0qjVHYEiiVMabbG4=;
        b=UIDwx7akgoxxERQHYhsryr/GFXjlvj/b7wZ/wdQ58gXnuPHLmE4d7wCmvqInOOAaop
         l92w+yIP5hOPlRJocJt3KO84kQMHC2FhmwkciWa0Kf/nIazDjOQB4g4WNp51S2fW5N6N
         GFAdmtNYkT0Piw2zwNkQS6WHl7wMUCPtMwC269IaKpVSCycR07dFgPgVM2onEJsRTjO6
         iSUCFr2wp2GW1fknWcesZvPSTm/3z7JaqkGBhpj8RnyodhvRJxRUr1jEN/vq4IcM6oqN
         UKaA6eX79ERNIayU2zEec+iCh90B9vpllEPwyFNWWvoY8RTa/kDcjrMgln3HwuSRAn7t
         m8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714091180; x=1714695980;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yELVRQ8ZDtDc4lZA2exN72FHqFJ0qjVHYEiiVMabbG4=;
        b=bl6425nFWxMaeL1VGHHO5Uli/nh5UW8Dm/3c5/sr/FvV4ri80DXMKOPcrMbBB28kfh
         zfNhrAMFHqWBANX8xwZzokmYgY8NG2C+xfQ03TkwVZ/w2YbsWlkP8iEVHYoovsho9pvb
         VblKwB6X/Qoot6YB+/gtYt+Oxh0zeIl3K4SoJrApMzD7K4oxddm8ddUssckmSre2tIxf
         /+oxjCM2LcabSIE1ABV26jQGBQN3VdZ3O40ZDh/9u3VDeGOsTxocSqqIFo5bXUsUoFTh
         O54FSVmiNoTwRomdv+jeMgwMuVRIAc3TnDza2YysTd+S1TkOP9y0JhN2y6vHXszh6iS0
         drFA==
X-Gm-Message-State: AOJu0YyuoXpl4mf0/yXDg5r81qMCeKAlt9zsYLJsLVT7EoPg4oJkkYZA
	ccVQfmWV2GycSr5Ea0C4vi5dwf8lL8tKzeKl1meEUa+uVxgvMPSe+wLoRg==
X-Google-Smtp-Source: AGHT+IFqElc0+T7H2pQE7uY090rMjOtHAdL1OMLgLw+wmRggiXV/su98VoLfr9hHTO0XadoEvU7BeQ==
X-Received: by 2002:a05:600c:4448:b0:418:ee30:3f92 with SMTP id v8-20020a05600c444800b00418ee303f92mr771242wmn.25.1714091180477;
        Thu, 25 Apr 2024 17:26:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d4-20020a5d6dc4000000b00341ce80ea66sm20914431wrz.82.2024.04.25.17.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 17:26:19 -0700 (PDT)
Message-Id: <56e1cca4b7b63725c3db60157b863ea36453d02a.1714091170.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
References: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
	<pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Apr 2024 00:26:08 +0000
Subject: [PATCH v3 08/10] trailer: retire trailer_info_get() from API
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
    Christian Couder <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Linus Arver <linus@ucla.edu>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Make trailer_info_get() "static" to be file-scoped to trailer.c, because
no one outside of trailer.c uses it. Remove its declaration from
<trailer.h>.

We have to also reposition it to be above parse_trailers(), which
depends on it.

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 92 +++++++++++++++++++++++++++----------------------------
 trailer.h |  2 --
 2 files changed, 46 insertions(+), 48 deletions(-)

diff --git a/trailer.c b/trailer.c
index 6167b707ae0..33b6aa7e8bd 100644
--- a/trailer.c
+++ b/trailer.c
@@ -979,6 +979,52 @@ static struct trailer_info *trailer_info_new(void)
 	return info;
 }
 
+static struct trailer_info *trailer_info_get(const struct process_trailer_options *opts,
+					     const char *str)
+{
+	struct trailer_info *info = trailer_info_new();
+	size_t end_of_log_message = 0, trailer_block_start = 0;
+	struct strbuf **trailer_lines, **ptr;
+	char **trailer_strings = NULL;
+	size_t nr = 0, alloc = 0;
+	char **last = NULL;
+
+	trailer_config_init();
+
+	end_of_log_message = find_end_of_log_message(str, opts->no_divider);
+	trailer_block_start = find_trailer_block_start(str, end_of_log_message);
+
+	trailer_lines = strbuf_split_buf(str + trailer_block_start,
+					 end_of_log_message - trailer_block_start,
+					 '\n',
+					 0);
+	for (ptr = trailer_lines; *ptr; ptr++) {
+		if (last && isspace((*ptr)->buf[0])) {
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_attach(&sb, *last, strlen(*last), strlen(*last));
+			strbuf_addbuf(&sb, *ptr);
+			*last = strbuf_detach(&sb, NULL);
+			continue;
+		}
+		ALLOC_GROW(trailer_strings, nr + 1, alloc);
+		trailer_strings[nr] = strbuf_detach(*ptr, NULL);
+		last = find_separator(trailer_strings[nr], separators) >= 1
+			? &trailer_strings[nr]
+			: NULL;
+		nr++;
+	}
+	strbuf_list_free(trailer_lines);
+
+	info->blank_line_before_trailer = ends_with_blank_line(str,
+							       trailer_block_start);
+	info->trailer_block_start = trailer_block_start;
+	info->trailer_block_end = end_of_log_message;
+	info->trailers = trailer_strings;
+	info->trailer_nr = nr;
+
+	return info;
+}
+
 /*
  * Parse trailers in "str", populating the trailer info and "head"
  * linked list structure.
@@ -1044,52 +1090,6 @@ int blank_line_before_trailer_block(struct trailer_info *info)
 	return info->blank_line_before_trailer;
 }
 
-struct trailer_info *trailer_info_get(const struct process_trailer_options *opts,
-				      const char *str)
-{
-	struct trailer_info *info = trailer_info_new();
-	size_t end_of_log_message = 0, trailer_block_start = 0;
-	struct strbuf **trailer_lines, **ptr;
-	char **trailer_strings = NULL;
-	size_t nr = 0, alloc = 0;
-	char **last = NULL;
-
-	trailer_config_init();
-
-	end_of_log_message = find_end_of_log_message(str, opts->no_divider);
-	trailer_block_start = find_trailer_block_start(str, end_of_log_message);
-
-	trailer_lines = strbuf_split_buf(str + trailer_block_start,
-					 end_of_log_message - trailer_block_start,
-					 '\n',
-					 0);
-	for (ptr = trailer_lines; *ptr; ptr++) {
-		if (last && isspace((*ptr)->buf[0])) {
-			struct strbuf sb = STRBUF_INIT;
-			strbuf_attach(&sb, *last, strlen(*last), strlen(*last));
-			strbuf_addbuf(&sb, *ptr);
-			*last = strbuf_detach(&sb, NULL);
-			continue;
-		}
-		ALLOC_GROW(trailer_strings, nr + 1, alloc);
-		trailer_strings[nr] = strbuf_detach(*ptr, NULL);
-		last = find_separator(trailer_strings[nr], separators) >= 1
-			? &trailer_strings[nr]
-			: NULL;
-		nr++;
-	}
-	strbuf_list_free(trailer_lines);
-
-	info->blank_line_before_trailer = ends_with_blank_line(str,
-							       trailer_block_start);
-	info->trailer_block_start = trailer_block_start;
-	info->trailer_block_end = end_of_log_message;
-	info->trailers = trailer_strings;
-	info->trailer_nr = nr;
-
-	return info;
-}
-
 void trailer_info_release(struct trailer_info *info)
 {
 	size_t i;
diff --git a/trailer.h b/trailer.h
index a63e97a2663..1b7422fa2b0 100644
--- a/trailer.h
+++ b/trailer.h
@@ -73,8 +73,6 @@ void process_trailers_lists(struct list_head *head,
 struct trailer_info *parse_trailers(const struct process_trailer_options *,
 				    const char *str,
 				    struct list_head *head);
-struct trailer_info *trailer_info_get(const struct process_trailer_options *,
-				      const char *str);
 
 size_t trailer_block_start(struct trailer_info *);
 size_t trailer_block_end(struct trailer_info *);
-- 
gitgitgadget

