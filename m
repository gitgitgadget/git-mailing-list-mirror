Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76490631
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 00:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709252097; cv=none; b=hM0KdFopMkojSDdLjaJrsBfDA1OUfsdzleGXFMy0pdogGCsv2blVqiJz96DLU9HWvStgJUeGs+wRkg5gF9gITKjOTpZ8yoCAzX2gfLw2yNNpMr7TYxM/+nPRVZHHsXy2P5OWN7cys61WCF/3sowiZDNYzmy9uzf04t0RArJtlI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709252097; c=relaxed/simple;
	bh=MFEKYSEG3HI7mYG1ysXMfdUDr+XakqitFvOBDN2YbE4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XWewxkTWZ+i+AmEVSyGq++zzCxq2ZqkLNen59P77ayioCcS3SbW7RxPBGyayOpEUO4uDOdd0mvkg2Bo8Tk7Tw0BfaeGQ4I6YQlENgneuwSDNZibeYjuZ/yF+b43NiFHub81qfhWgtOkZQI9cN7tOSpyWlRzNeroj+4E2/7zec7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1FhwzVQ; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1FhwzVQ"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d27fef509eso19927041fa.3
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 16:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709252093; x=1709856893; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJrVXdhG6CJ81DpqPJ6pqi09B31r6z24wJf30UQFHbg=;
        b=B1FhwzVQ5XJefnp8cmSHWlDdncp1rwrFbPPNOzyjEHlJtKuhmoqq11iqw59vUu7wB9
         A8Vdx0xcscLCboyUUGBBYvHsZppRulsYdPbdQLgo87f5/QfBF60gvkmlKW+j33gVDviW
         02lbQNeCUvMAJ1nlkmK3ThQcRKYc0FqUF5EsHJRMxBOXPUjITfqBw1aIUJK7HNKoGjO9
         EnCrn7HGHfKUaFHKFykyC50pVXKU3crKEXe+SyRMLLqz1aBMYtQGcrLM5QDqY0yxtWGz
         XSaced8ctdTsVuc7IoYsU3h7MZb8bEjWpUDuXXuTEeHpVGcARSlFf++PQIx3agwmomeH
         eJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709252093; x=1709856893;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJrVXdhG6CJ81DpqPJ6pqi09B31r6z24wJf30UQFHbg=;
        b=VJak+MvKU3ST9UWtQRoh0LP0CZXXzFNew5QiMZLj41037EDfZqDkKuL8oadhwjufGA
         4FmU+F1KSvgX/3iMLOIDzraT6cT3kYb2k7v+E566IRYZ8wHijdCrIW1WYWcXonfZLbcO
         HbhWIbeW8M8BqVU1JnfwwRzv/wxqJKUsE2ra7kUZ4JziSfvQANtWnDu0u7RU4/aL2rfq
         j8ZSu/mChaUVnPc+OiVluPjB/OYZ/GO58UE/Ifvj4ExoHCJu0Vt5Akx0ws64aWxZKtfn
         9CuLJnjTReRV+ic3m4l/KbdfBop6p4q0I5yM67K012P9rltwLGN2OaU6oMpP9Qi+iusU
         Wz9Q==
X-Gm-Message-State: AOJu0YzK1wiNfDuqscw207VuzGT+kxprYnMrehICCX1ofX/eFIj0Xno8
	kROJOkzvKW4eY6ieCE2fCtu8IbWslIR+K95ZATH6uQ+Ww3YY878o3oauFJvx
X-Google-Smtp-Source: AGHT+IGwc8vstpkrOCmXWdjc3sk6L3/1AeO70thGTDXpQU+ihD+fc4Xrofr0S943N6l+jsgynIl26A==
X-Received: by 2002:a2e:a697:0:b0:2d2:42ff:483c with SMTP id q23-20020a2ea697000000b002d242ff483cmr2104006lje.33.1709252092847;
        Thu, 29 Feb 2024 16:14:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id jw21-20020a05600c575500b004126afe04f6sm6630963wmb.32.2024.02.29.16.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 16:14:52 -0800 (PST)
Message-ID: <7a56558016769a9f29e4b14a73101447195ca128.1709252086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v6.git.1709252086.gitgitgadget@gmail.com>
References: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
	<pull.1632.v6.git.1709252086.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 01 Mar 2024 00:14:43 +0000
Subject: [PATCH v6 6/9] trailer_info_get(): reorder parameters
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

