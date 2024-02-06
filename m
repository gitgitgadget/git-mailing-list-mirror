Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D43C7A730
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196360; cv=none; b=CPcdTdi+UKht5uBXQNecHA2mxC9ffsM8BZLUnAjOaas3Z54L2oamhXV6FmQ+vo4/1bklFKkmWLiPHKtW3vhO+e20Wesns09P4ZTkoGkwcsZRsMemZXAof9ZhnmZV1zrxjnk8Hp89FWSeo15lTAUGxJCYTHgcPV7w9zRQ2ZFGljU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196360; c=relaxed/simple;
	bh=MFEKYSEG3HI7mYG1ysXMfdUDr+XakqitFvOBDN2YbE4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rfgssfVwM2BuaSDn1Lheu4PDBixOosFOBCKDJ2B2jaB6QUDCdtdvFPWh6OhlfaoZknoCNi6iIo3N91Yfs3N4zfwKcy6LF7xK4/GB08n2zjdMrk6dFQNcBltJKuuH28/qYyoBnlY9fRrovvANid0wjOuWtzD7xmloKMqQmJVUcf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGX4Z/jV; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGX4Z/jV"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-339289fead2so342746f8f.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196356; x=1707801156; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJrVXdhG6CJ81DpqPJ6pqi09B31r6z24wJf30UQFHbg=;
        b=CGX4Z/jVDkOZUTb7jSzgq14s4EpxVRfvjVHeW3HmBiPUrTgilqjaeaJnBjeehO6jx5
         Ux5Jm/CYtByw/faSFUImxDuP6LdCgtR+QhN03oI3J+saNr19+jdG4/OcqhFuANxtGdvV
         9W7TrOyRxpAC5CGuKRxG9EuskaAv7hKs/1BBwQOsNSs4/TdaxogSm1l7sVi0EZaPgrjC
         ThtjtbpsoC4GyzTiL+bdccQyUybG/gBM03dFxrL/tIr8qAlExTEbqFZcZZgbLl/L4qmI
         8HNV3QAWEG5J+3TYdky853Z7q5nEIwCZYXC3PDrPVFxiihghKjNPQKWiOUh5TcmsE4sp
         yZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196356; x=1707801156;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJrVXdhG6CJ81DpqPJ6pqi09B31r6z24wJf30UQFHbg=;
        b=QburNCB9o1g9zwHO/cWm3u3R6IuF+9Zvz/JScZiM6reJ/Tgihnvr84zhUPd+8LF83U
         Tq1QqvAWkXqd2DI9mR4BgIYmAfkr/X9FsL9tks4+sEn7+zZ8FTVEcEHmryRjdhv4E+hi
         FJ+vnw2FZ/fJNEY6pO0fxtgdDwlXaMsEOoQfhkYCF6AnJHY8GHFjgPfzQTAQM5A4DJav
         2m6j6hn3Df8zJw8z6E0OcDvKIBRi205NlwQ6HueYQ3cHA505bCHZ4AW996YiJocZrPVV
         u8rtIYcC4M6o3jOxiOKh344HB/yAB3ltFvv0nPlrxlrK7SflZuX5cOaREwW9C2cvwrKr
         kLUg==
X-Gm-Message-State: AOJu0YwnKB6SDfpWcRVmLUki489cpnUbWdAFggLPdi4DPjYuwBD/kdEw
	MUoumurEUhLlWCKHFO0h2tghxN2Qegs9YMhXsP/ChJYeznxhHHO9nPx8ADGZ
X-Google-Smtp-Source: AGHT+IHG7YVpG5do6pjLeu2RIzE5j5fK7ka3M2CUpel6a5A+kVZSsr5jMO6dn9JesrTXhjqL1zc51A==
X-Received: by 2002:adf:e788:0:b0:33a:ff92:6e2b with SMTP id n8-20020adfe788000000b0033aff926e2bmr449125wrm.4.1707196356120;
        Mon, 05 Feb 2024 21:12:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXA1FforoaRiVcP09G0w/qDh67rrjyG32hJOn9teBbPiZBJfE0lNHN305kAXqCg8FOpaliePgCbkjS43hMdn6XevKy7/JwF5RFoTZD9z+GlLhj0SUWj/O7oxQGbSl/ZyHnV+dxz0pqP+TyMtV5pDIdJ7lb8J8r+FVPphDMKIID/hEW6eHzJiG1l1OWkUAPQwXQBs2c7J5SByw==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g15-20020a05600c310f00b0040fd0f7d267sm637055wmo.44.2024.02.05.21.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:35 -0800 (PST)
Message-ID: <c1760f803565818c3856345d72af5ae7565cd37d.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:06 +0000
Subject: [PATCH v4 06/28] trailer_info_get(): reorder parameters
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

This is another preparatory refactor to unify the trailer formatters.

Take

    const struct process_trailer_options *opts

as the first parameter, because these options are required for
parsing trailers (e.g., whether to treat "---" as the end of the log
message). And take

    struct trailer_info *info

last, because it's an "out parameter" (something that the caller wants
to use as the output of this function).

Signed-off-by: Linus Arver <linusa@google.com>
---
 sequencer.c |  2 +-
 trailer.c   | 11 ++++++-----
 trailer.h   |  5 +++--
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3cc88d8a800..8e199fc8a47 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -332,7 +332,7 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 		sb->buf[sb->len - ignore_footer] = '\0';
 	}
 
-	trailer_info_get(&info, sb->buf, &opts);
+	trailer_info_get(&opts, sb->buf, &info);
 
 	if (ignore_footer)
 		sb->buf[sb->len - ignore_footer] = saved_char;
diff --git a/trailer.c b/trailer.c
index 5025be97899..f92d844361a 100644
--- a/trailer.c
+++ b/trailer.c
@@ -997,7 +997,7 @@ void parse_trailers(const struct process_trailer_options *opts,
 	struct strbuf val = STRBUF_INIT;
 	size_t i;
 
-	trailer_info_get(info, str, opts);
+	trailer_info_get(opts, str, info);
 
 	for (i = 0; i < info->trailer_nr; i++) {
 		int separator_pos;
@@ -1032,8 +1032,9 @@ void free_trailers(struct list_head *trailers)
 	}
 }
 
-void trailer_info_get(struct trailer_info *info, const char *str,
-		      const struct process_trailer_options *opts)
+void trailer_info_get(const struct process_trailer_options *opts,
+		      const char *str,
+		      struct trailer_info *info)
 {
 	size_t end_of_log_message = 0, trailer_block_start = 0;
 	struct strbuf **trailer_lines, **ptr;
@@ -1150,7 +1151,7 @@ void format_trailers_from_commit(const struct process_trailer_options *opts,
 {
 	struct trailer_info info;
 
-	trailer_info_get(&info, msg, opts);
+	trailer_info_get(opts, msg, &info);
 	format_trailer_info(opts, &info, msg, out);
 	trailer_info_release(&info);
 }
@@ -1161,7 +1162,7 @@ void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
 	strbuf_init(&iter->key, 0);
 	strbuf_init(&iter->val, 0);
 	opts.no_divider = 1;
-	trailer_info_get(&iter->internal.info, msg, &opts);
+	trailer_info_get(&opts, msg, &iter->internal.info);
 	iter->internal.cur = 0;
 }
 
diff --git a/trailer.h b/trailer.h
index c6d3ee49bbf..410c61b62be 100644
--- a/trailer.h
+++ b/trailer.h
@@ -94,8 +94,9 @@ void parse_trailers(const struct process_trailer_options *,
 		    const char *str,
 		    struct list_head *head);
 
-void trailer_info_get(struct trailer_info *info, const char *str,
-		      const struct process_trailer_options *opts);
+void trailer_info_get(const struct process_trailer_options *,
+		      const char *str,
+		      struct trailer_info *);
 
 void trailer_info_release(struct trailer_info *info);
 
-- 
gitgitgadget

