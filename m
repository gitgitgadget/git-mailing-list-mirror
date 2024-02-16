Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A4A148FE3
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 23:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708124961; cv=none; b=g263MoGkLSXyQ93DeeFb4aNu/6maegMsCFnJsHjj9sXLp6QYfhObt6qOG2ZNdXEef+eawPjOYzOHqm2cPJDjyulIVMC7pJ4yhgyUsZLhsl8jRxxgsy0S1TWFGFjrNXuB6RpvjRdE6+pmKTgc1LuUYqEoucKSY/cs+/IrB6kxdZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708124961; c=relaxed/simple;
	bh=MFEKYSEG3HI7mYG1ysXMfdUDr+XakqitFvOBDN2YbE4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cH7rE2hT3B3PJbotFtGQaV9rKyxLxR4zD6HDv7o4wU5vWLGXwaaTDRLiqCAw/2bhNQ4naWjba6JX/fyZBzQeOcTuWHcRCbqw7Aa6YDayOAprsiCJlTpEVf9knfMj3jHmhvBOJSs+L+lxBRC58xqka6NWN51rrGPUbzP2LM6HI0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9Qw2gFb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9Qw2gFb"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41232741dc4so8336335e9.3
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 15:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708124958; x=1708729758; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJrVXdhG6CJ81DpqPJ6pqi09B31r6z24wJf30UQFHbg=;
        b=I9Qw2gFb4ijZAh235azWqSVtiBMfqYpR9TlmnmdpfSw3OTIgod9lR+ruQpTeX0KQqw
         8z0m6MpqAkoJ72Q7suuN56i1jjiCuH9V3FrmdzhOLTX/yjrMYLXaTKag6hMlGmckvYCS
         3haAFF4VP39pQYNA1B0Dglip/tQplGp14sltqdQnD6Mbo2e+kp0dTcLCE+/OJL02BcFe
         tsNpRvDlkylbxpJR2OSf5I8oJDYRSrDkwDsa07qJzbcb45GMHTNjJutFdBr5ogrtW612
         APafYs2EbwWWN6JPnwTzO9QGmGYXVfSkcBpOL/OHjU1D/JTlAr9d46V7Ue8KL3VzGdTZ
         h8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708124958; x=1708729758;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJrVXdhG6CJ81DpqPJ6pqi09B31r6z24wJf30UQFHbg=;
        b=W8RPwJhdRTHHbb1BMRy96coVwa3QALd+D+G/QE9YXFKUZ1FNymhDNgqqUK94cTSvqb
         h4ugMLC4bRy8QDL3PRD1vYswFd0pULmTdr6vKbtz+iAVZ2HwIrEKNqOuW2N34iSS6Zww
         +0AZdBo5z7aJNqu6ZHU64LKZAZcf8dyV7bZ4+OzmJuVh+NS1VRVyD1Cm4M5DZyKSHFaJ
         ChDPkG56BAGxUJUY+D7+aGJT4TxJc5xvTvZ1X0Np4t5gtPQJQAFX9QbG6ACLvlsVKVGg
         sC/bTShAWI2qkAhCMNWfQs08a9kwAAoT6f6wpiAS8+0N2RrSVlbuEkGNyDd7lTm7oyHi
         /5IA==
X-Gm-Message-State: AOJu0Yxic/41yeZMee3sVTBxt0rMSs7L9nw5/mM45omCtM0b2ahL46qx
	g1n/vZAMhTWvwM4/ck9re8ZFA93msC8z2sI295vb3M1ICuTKXXlhN+n5MfMk
X-Google-Smtp-Source: AGHT+IEE2OQGr8w7/OfYtVNZI4ri4+9T7IZxdayWlPcjamrLfPQxM3GZDJ2ReyOk90KdtPE9Zwxq9g==
X-Received: by 2002:a5d:5646:0:b0:33d:13ee:1699 with SMTP id j6-20020a5d5646000000b0033d13ee1699mr3340197wrw.66.1708124957871;
        Fri, 16 Feb 2024 15:09:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e6-20020adffd06000000b0033cf60e268fsm3275591wrr.116.2024.02.16.15.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 15:09:17 -0800 (PST)
Message-ID: <c1760f803565818c3856345d72af5ae7565cd37d.1708124951.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
References: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
	<pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 Feb 2024 23:09:07 +0000
Subject: [PATCH v5 6/9] trailer_info_get(): reorder parameters
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

