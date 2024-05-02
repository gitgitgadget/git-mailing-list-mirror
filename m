Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6DF286A6
	for <git@vger.kernel.org>; Thu,  2 May 2024 04:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625677; cv=none; b=TtxVSrTy4BZjG0YkCpIX79UbKtrkbzliMAQagAd9L/ZfLjPfkY7gYN9KufYcLoOBcq1EvC313SUkq3U/E4ka2LkRmm1vKdDWEU6cCshJRB/fWEbUgujBGtHsQ/Y4rww5S6t2Wexs2qHnj/M3ry5uHQqDBM0NwhV3Ujrp/VZKZug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625677; c=relaxed/simple;
	bh=oEQBb/9zguig5IXXgeMlUxPxea0HsztQ9iTJrBw+gEo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tI+yrETIYItHF8QB2uBvRS2TDRF40Z4XOxZNuVcIRPR/mDUEKKbN4HhhIZ19dbz2Bo14OSaYTqPFmN4qC8G5lPjUANOblUJDav9lJDFLsB1aNs+jRUneJ4FMVk7PE7hVqTQzkkCNxofqL4yl1dxeU798JDWnnyq7ioh7aZ7VWws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5h6ccQg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5h6ccQg"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41ba1ba5592so40144555e9.1
        for <git@vger.kernel.org>; Wed, 01 May 2024 21:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714625674; x=1715230474; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wu37bVUqp7rA7s17b6iU3IeqALt8CAL1m5L5YOMUILE=;
        b=c5h6ccQgyr64jFq2SXFgucewrRgPd75KgwPZ5cxgXZOQNg9UHhF4t8gUSYgZ8dWMCV
         Cc55sEW4JQ2UzHiDMK98Nxy4N0yGJ2IvCIbUi505q7RV9RY43eB3fpsT90M5oeWsWBoj
         +u6f2y4OA95fKRLDlEbfRNr35fsNa+6YsazJvBZm2LvwXrLKxOHfC8oEwTVd+dhpg3he
         NzeE4AjRdoYKhogDq5x6RQH+kvT8UeGUAX7rmy+6cAjBiSKl/HKgAWSSwOq9OSYc7b6E
         pVNwcd0eG//j86lqRkqKyt1Ql8fZAkDNTRdsOUIm07hFRmxgyanHdJmbRiN/gAgiaIFb
         V9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714625674; x=1715230474;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wu37bVUqp7rA7s17b6iU3IeqALt8CAL1m5L5YOMUILE=;
        b=kSMbHlm5ISru4wuoCjYgYNO6c0FQzSBca27mgTSJ41kOQulUivZJ/d1j0tCY4zE0Ka
         u6G+WuiwClG9w0P8Z3regqnwMTjLISq2lEafZdSvYxPB0ugejTyycdF7il3UqOviAJx+
         Mk51xOPEv/w7wHvbyqrg8j7PTRfkuf2gLrQtqan9R9tuNwAK/fbN5IHpi0ObqFo/IYxf
         3dvdpFzxIqZ5ScLNSpsNHYVdiXT+u8s1ebtFiz1ytdIzmCvcV8uSd/vlX5f2pjH1wOSU
         PaVBTY1NpvulQ9ECz/+CKda7joh51C5sFKVibRWZ3h8Qebvj3W0SPs6E9mOJvv+U9Ia6
         AyRQ==
X-Gm-Message-State: AOJu0YxpIc83IGkQy96X4yhqOPmRl/+FYaa5tZ4Rg5T6Nt0EJahNR9Ol
	yzYkmeUu/c4tMhpSQ77D1h2yFqWPJKFlUyibC3x3d2xX7Jz4quNAQAWImg==
X-Google-Smtp-Source: AGHT+IFYGTAcWIMEnjQ/Sx8tKfo65aCtM16SwQZQKUFEgLe3A9jlrbOMdvWVbiHmUS5Xj8BsahQTYg==
X-Received: by 2002:a05:600c:3c9a:b0:41a:908c:b841 with SMTP id bg26-20020a05600c3c9a00b0041a908cb841mr779764wmb.32.1714625674037;
        Wed, 01 May 2024 21:54:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c4f4900b0041bf7da4200sm498455wmq.33.2024.05.01.21.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:54:33 -0700 (PDT)
Message-Id: <a3d080d4d6cace4b331a5dd54e45d24db53c38f4.1714625668.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
References: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
	<pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 May 2024 04:54:21 +0000
Subject: [PATCH v4 04/10] sequencer: use the trailer iterator
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
    Linus Arver <linus@ucla.edu>,
    Linus Arver <linus@ucla.edu>

From: Linus Arver <linus@ucla.edu>

Instead of calling "trailer_info_get()", which is a low-level function
in the trailers implementation (trailer.c), call
trailer_iterator_advance(), which was specifically designed for public
consumption in f0939a0eb1 (trailer: add interface for iterating over
commit trailers, 2020-09-27).

Avoiding "trailer_info_get()" means we don't have to worry about options
like "no_divider" (relevant for parsing trailers). We also don't have to
check for things like "info.trailer_start == info.trailer_end" to see
whether there were any trailers (instead we can just check to see
whether the iterator advanced at all).

Note how we have to use "iter.raw" in order to get the same behavior as
before when we iterated over the unparsed string array (char **trailers)
in trailer_info.

Signed-off-by: Linus Arver <linus@ucla.edu>
---
 sequencer.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ea1441e6174..4c1f6c675e7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -319,35 +319,32 @@ static const char *get_todo_path(const struct replay_opts *opts)
 static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	size_t ignore_footer)
 {
-	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
-	struct trailer_info info;
-	size_t i;
+	struct trailer_iterator iter;
+	size_t i = 0;
 	int found_sob = 0, found_sob_last = 0;
 	char saved_char;
 
-	opts.no_divider = 1;
-
 	if (ignore_footer) {
 		saved_char = sb->buf[sb->len - ignore_footer];
 		sb->buf[sb->len - ignore_footer] = '\0';
 	}
 
-	trailer_info_get(&opts, sb->buf, &info);
+	trailer_iterator_init(&iter, sb->buf);
 
 	if (ignore_footer)
 		sb->buf[sb->len - ignore_footer] = saved_char;
 
-	if (info.trailer_block_start == info.trailer_block_end)
-		return 0;
+	while (trailer_iterator_advance(&iter)) {
+		i++;
+		if (sob && !strncmp(iter.raw, sob->buf, sob->len))
+			found_sob = i;
+	}
+	trailer_iterator_release(&iter);
 
-	for (i = 0; i < info.trailer_nr; i++)
-		if (sob && !strncmp(info.trailers[i], sob->buf, sob->len)) {
-			found_sob = 1;
-			if (i == info.trailer_nr - 1)
-				found_sob_last = 1;
-		}
+	if (!i)
+		return 0;
 
-	trailer_info_release(&info);
+	found_sob_last = (int)i == found_sob;
 
 	if (found_sob_last)
 		return 3;
-- 
gitgitgadget

