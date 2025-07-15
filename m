Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765FD2BE656
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605543; cv=none; b=KZKtUIVoqTilDlXqlcMFu5vtugfEqskiZScnqZTazB/GuGL0xr/ZCue5ltbmic26w3gCKAqWGykgqmUKU625l1dkBQg8LDzZn3gux8rM92wNayuWBlt2XxK9/AmOv12+AflMixEQW46KBqDEUnwyxhDXaY2LOm6psVQe/d3/mQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605543; c=relaxed/simple;
	bh=LrfDC4I0hlMEs33S/9XCqwWn34zBGlTqqPHcTsiD2I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4cj21ppfOb+MrI5p8gbuO6grA2lzJboUxbKX0iFg2R/H0imTyWWZI2Se7lE69HAp7v64Lg6RK0nytaS73yQtjcUlrQro+R2yPWZ0xKt1wJAkb1FcpQtra6lBqS70kjA9PIZv6IPbyF5ubmR2iYjyfI+O0p64OsOCZYsARr8ONM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CymoZT/B; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CymoZT/B"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74af4af04fdso165134b3a.1
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752605542; x=1753210342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cT0hW0PtF7A52mDrJuGrGU1Y6VMZUknhe+4iSxL0nLU=;
        b=CymoZT/B1LU6k7DgGM/f52eGtuXuicnISeWL110bxbck5Ac7BzL5fLxAUimVR5O6Q/
         vkZxuOMl1hNzZGp+VXuVZzGoRiUpJFfQGbqc59sb+ibzK2rb3R2npEeLfcFOeIuQ9iGv
         1F41CtAKoJY/NhKGUtKP2b+0eYTM01d8K+xBqcc34KBWrkWTd6bqe/+A9wqSuaCFa1Py
         u7NuZS5nw/4wQXNX4PidhwOfkagzmlpWhGJ0gd1HPXOJs0j5sMNgjNx0PfLnYrODePZ8
         mOoI+b4+jT4WxCSmHJgIjxxEhRTxv9TLN7m3R0Qn5rK5My16q2+yXPe2y1TfYIasQ0rT
         5O2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752605542; x=1753210342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cT0hW0PtF7A52mDrJuGrGU1Y6VMZUknhe+4iSxL0nLU=;
        b=IGiCeIURd57zKddRsugjxRV9GBvwbmjXHotDLT6m1kyVgxPY2mcqWMQkAJrDgv0z5U
         kdMdUURt+JaIvm94VF4YeeJrzaJJiOHESwo3yP1Z9x+cHtVxYqZnyxh3EIZO/1h0HR+v
         DZR94rvjLDtB6MjeMNyrUL6YSGHT73QDqlb9G6ELK9Q02kFRRg6QPC+jwVr5bMCML0tW
         KV1xsD++5cgO1N6+km+iMkbZss0h/TltGqC0J80T9bE6tNwNZSyzmm1el4HAkyfBj0LR
         koy6zikyZylzLBk5Eh7yGKzJxFGKPKa196ptj1hOjfrcoac0FHzDKUZOhhPhB1W+BbuW
         ohAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZHS3S2VUZE7xN8n8hA0yAiPfxh1hSwSvrHPXaa3e6NU4E64ZkXQYA4E4L8LAR6ihaOOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXL7kNwaoXH5mRARRPRbxPn5EaI/eiUWRIJoZlI3mBUDSqeEnr
	pH1RBZ3FlUpTT+bc9XIX9KjWqwQQFZsdgrGO1jDqZjf73RxwLx5VQF2i
X-Gm-Gg: ASbGncsg7gKgv7Z7BX4ZDbjPydf7xR0Rnun2IcmywGKQE2NU6/ZKkEeitn3jRURm4CH
	9bfKeyJElAZkDFkyOFqXI3AJGIQYQVZ7+wCimnM8fW/AawB8VE2eN7vj2zgYuxeSJi7yIgvp/W0
	ni2Qz/DXHrYOoguqzI5hqNB0SB7DVvPB3e94/q/Uudr0vuL/CSbNMwW6l4qN/BGHbpKWUl9ItF3
	XeDGFUZQCP/NA6lxeSe99iIFeB6p761uqKhaqC9dd7QIx638oSoyH8qbdTHeqQg9aHC4MWUFeZL
	EFiu/eFI0WCBDN8x6ND52G352bIWcJu5BBSo/iaI3bn/sywynNIjUy9vKUU1QacGFNl5ms2ZQEx
	1FmexJ6yGlaIrmPQ4mVh8zZp46qFmKxpwelQ=
X-Google-Smtp-Source: AGHT+IF/x75zaBZ6ao1Q9QjvX2AD/T5JMuZ3+UJvVJj1/rYwkdzmmTTw+JYxAkVOwsuTLaYYNdrqOg==
X-Received: by 2002:a05:6a21:112:b0:225:9ac1:7c6b with SMTP id adf61e73a8af0-2366f09f8c7mr8405038637.4.1752605541422;
        Tue, 15 Jul 2025 11:52:21 -0700 (PDT)
Received: from thinku.iitr.ac.in ([103.37.201.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe52c914sm12415806a12.7.2025.07.15.11.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:52:20 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	phillip.wood123@gmail.com,
	shyamthakkar001@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	gitster@pobox.com
Subject: [GSOC PATCH 2/2] config: set comment_line_str to "#" when core.commentChar=auto
Date: Wed, 16 Jul 2025 00:21:26 +0530
Message-ID: <2a3c2d323bdb520a37a099b361be9ec5f2d5d46f.1752602474.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752602474.git.ayu.chandekar@gmail.com>
References: <cover.1752602474.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If conflict comments already use a comment character that isn't "#", and
core.commentChar is set "auto", Git will ignore these lines during the
scan using ignored_log_message_bytes() and pick a new comment character
based on the rest of the message. The newly chosen character may be
different from the one used in the conflict comments and therefore,
these are no longer treated as comments and end up in the final commit
message.

For example, during a rebase if the user previously set
core.commentChar=% and then encounters a conflict, conflict comments
like "% Conflicts:" are generated. If the user subsequently sets
core.commentChar=auto before running `rebase --continue`, Git parses the
"auto" setting and begins scanning. It first uses the existing
'comment_line_str' (which is '%') to detect and ignore conflict comments
via ignored_log_message_bytes().

Then, Git scans the rest of the message (excluding conflict comments),
sees that none of the remaining lines start with '#' and decides to set
comment_line_str to '#'. Since the final commit character differs from
the one used in the conflict comments, those lines are no longer
considered comments and get included in the final commit message.

Set 'comment_line_str' to '#' when core.commentChar is set to 'auto' to
reset any previously set value.

While this does not solve the issue of conflict comment inclusion and
the user visible behaviour stays tha same, it standardizes the behaviour
of the code by always resetting 'comment_line_str' to '#' when
core.commentChar=auto is parsed.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 config.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index eb60c293ab..bb75bdc65d 100644
--- a/config.c
+++ b/config.c
@@ -1537,9 +1537,11 @@ static int git_default_core_config(const char *var, const char *value,
 	    !strcmp(var, "core.commentstring")) {
 		if (!value)
 			return config_error_nonbool(var);
-		else if (!strcasecmp(value, "auto"))
+		else if (!strcasecmp(value, "auto")) {
 			auto_comment_line_char = 1;
-		else if (value[0]) {
+			FREE_AND_NULL(comment_line_str_to_free);
+			comment_line_str = "#";
+		} else if (value[0]) {
 			if (strchr(value, '\n'))
 				return error(_("%s cannot contain newline"), var);
 			comment_line_str = value;
-- 
2.49.0

