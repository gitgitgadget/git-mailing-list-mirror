Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570FD2F2341
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 11:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666237; cv=none; b=utWMLiO/ypZVKGav0HGkfrbIFF8wkYDwE9mwdpbFYvG+fzFcZZmigOiagj/98SK3yhkhfCTPbN87jOZWsbV4f8YmQUj0qDkP4oS9rYEznrCvXldEtziH0JyOox2PahTI85Oj6ruKZi0rv6Shhj5EVIxhgmc4r/6TZVGRYKAsqGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666237; c=relaxed/simple;
	bh=eCoBG3zvW3Gqe5520hj81qxcjFzxb5EghDNjCr9ZcmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V93CeLIZ7Kd0DkDbvRiJwzSFut1EOJsuqZLaxj/SH57Ylhbc1opLDVXX2jEl1bEnebOenEiYNMdKnk4lq7XfDyoWA3/eChpDILWpEY2Qyl7N7XuO1L7+K8FZB4F9THh6ca5pkvWshiG0kUjLt5k2XbilOsdHfwCz/1A4gJp5RvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7EvCPmy; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7EvCPmy"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso3724492b3a.0
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 04:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752666236; x=1753271036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DRfexSHINwU88EbCjKzrXSYRxzQ6iESe+v2vq9YSoI=;
        b=J7EvCPmy/du6QE/YIJzmB/zW8FpflUT4tJCjBlU5HTTzr5ar4t/Kl6pj3iDYpGarBI
         I7WUdSCLXs7p5UGwnrJiZcmCqT1ZtIo1pxW2v2r4piyx+n458mKx742NoJiySZ6MAa2y
         0fXNCRjOMv9O4qeY6duAnhtOYevX0qfb4sFpegAd2AfWL7v3l1AYSuzGbVunmQwZzsYQ
         6if7aYDDL9vVZwfDvdC5oUFgHX/9jlE66eidD96HgPInJF9mtmIZquxW2c5UyHeRvCBC
         m/SjMKYszsOgnSIkei9hBLO5vi1K2vwuNDTsvRDMcAW9mJtsPFQND7wxhcW2q/l0fHCg
         /ssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752666236; x=1753271036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DRfexSHINwU88EbCjKzrXSYRxzQ6iESe+v2vq9YSoI=;
        b=urbDa033BE601Ag0le6XFNTIDaWltOWButA1wiH9Z04KzYyBxvzZhgdD8jRx+yfw1u
         nANRZQAjDeIFom3PsYP70g8Dp77ctuRuHX5GjTAfPoWJlQubhXkxUWJH2IallQ+Puwy3
         WdYTWmIJ8KuWYU8QwrIrjVwmmwRo2iAjMw9uPrUzmqfw6CG7iA85v/LHEWWf/CaDYpS4
         kx/6/1PFZlnJ25paLWIfQtAlDAi8haan8m5CPpPqDYYccsv7Qrgewb+3bcRkoftoaYyu
         LHWwBer+EZnGnJHCavjcDjbnepAtOZgsIfaR6+TSuLptglnt8YCxRa3ho2pZyLPyvXyi
         GsHA==
X-Forwarded-Encrypted: i=1; AJvYcCW2C8XZJ6XwR/rBpry1VywBhMc8NmnXdI+nbsLbd3VkRWhZxvRGw2ngIj3GI8DAAKC60nM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQdRF9QFq6/4jwsrZiOzUSxMdmZwky6t+zsDUMNlyZrk9HCVwu
	jDBCHb0AO7jTpX2nZyZLbG0QaEJ44Y8gy7mwzh4F0t6LW7FvEfhcjN+s
X-Gm-Gg: ASbGncvq1F8DGQLxU8dqwTo9hgOA/e5rnvtKCEON58CKNjnsDodgA69X4G4oQPsb9GF
	JAhI8FCmHKKR2ztpaHThcXCJiVEagn7He3+iNzosI0RPLKWcraudmUCrmN5V31Zor254e1rNr7k
	9NJl0tKxUYSNxkynydhhpXkNi/54QbG9/omY5NFi1gwXTmkNaxT+1mYtpNxgY41w7/uzwqwRc6V
	R5SKZGWOIDVI5l3zY6arkBdY8j4EuPOHmHgec196KePbZlZvTlgIKU7xmYdo9Gsc4nBlCtnTWgN
	wHTaeDV2QZ23HhiBX/8AG1Z8Eg27ZcdQJHS44i8D1Q2ZrRpAjD9FBLrPIzM+97uvg6g90DXktQ8
	bQJgUfcygNAqlZJL9xHR/qKTj+uL/TwsCMHZsLP8duVMzvA==
X-Google-Smtp-Source: AGHT+IGyw4noCY+oXmiMYoTcoItWzXUv5iB50sJxjWtLPP3vt6VVORFHq5+dpjVnI+ocjTdY45uNpQ==
X-Received: by 2002:a17:903:faf:b0:23c:8f17:644c with SMTP id d9443c01a7336-23e25758939mr40235465ad.35.1752666235481;
        Wed, 16 Jul 2025 04:43:55 -0700 (PDT)
Received: from thinku.iitr.ac.in ([103.37.201.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f21e970sm1267553a91.39.2025.07.16.04.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 04:43:55 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	phillip.wood123@gmail.com,
	shyamthakkar001@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	gitster@pobox.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [GSOC PATCH v5 2/2] config: set comment_line_str to "#" when core.commentChar=auto
Date: Wed, 16 Jul 2025 17:13:29 +0530
Message-ID: <ffe16a257f5cff54630aac0b9af601705b2865d6.1752665506.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752665506.git.ayu.chandekar@gmail.com>
References: <cover.1752665506.git.ayu.chandekar@gmail.com>
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

The patch text is based on Phillip Wood's message:
https://lore.kernel.org/git/9e96aaab-79a2-4632-94cd-d016d4a63b30@gmail.com/
and the commit log message is wriiten by me.

Based-on-a-patch-by: Phillip Wood <phillip.wood@dunelm.org.uk>
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

