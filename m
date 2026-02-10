Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2AA32B990
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 04:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770698595; cv=none; b=qZd+4w7XNVWZRlV1Z/XO0JeOsrE0oksJyvpJN+Wy8E5KcJMjFTVU6OcJJ/9FdJbnQUct4v1cnydnJDDYBCaVRctrHfh8i/G8TV7I94mZlBDerGp6HZciJsxXBjx+3xSlmwZ1GRGwq68yH0QpRR9AoZUQd4HIKCPR63UvFm53daU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770698595; c=relaxed/simple;
	bh=rfrGeB+CbdaLVCLXbb2y96BQ7hDd7YOCmb8J/ObzRUM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=unYVTW0IUJiqLV0HNxJzD+ppPMr+ibrpWD5ckaerKj5J4AgY/pjBrX1+Rp6wjn5o6cvG9nqlu6jioylL0q2EHO8HqC3OKv+5w1X5AX/YGw/wc00TeWl2HS89m4kL1oWAWq7gddt1plslzbnOo5FQ1o177MP2iF3HdwaXwt70Hcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zgu1sQne; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zgu1sQne"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4042fe53946so1276241fac.3
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 20:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770698593; x=1771303393; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4YWx1RrtgJxqF5lTCdsDfOQwCaXTEtjgl8V1rxxZeI=;
        b=Zgu1sQne0xu2IgmJ+JkrsS0Al6XNpkbNiXmzPpU+aRy0QBZ02GnMPLuVJ5y8CW9gxf
         0CMLKOPKAu7ze2soZoK+epti67AQnAcnLmd210kuWqm5rhPK5lpy/z2t/qYOOzv73Wn7
         /YD35fUkWjzGzP46pXhEUnbJFkczlS0SQt6wGry/09wVxyJwZREr2Aj2u1aVljvEaSU7
         6OaZawoiK61bhSYqdzMT8lGbCLcSDaNWRUuKMRQdlyfn7jbAg+oDeEIxgmo7RoMpaUkA
         FiHEngIJufcahvTmusnBYNkUCn0wBQGHjbx/d8ILpd6cKTxAH5/s6tY9u5BHa/NcJWDe
         ZwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770698593; x=1771303393;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X4YWx1RrtgJxqF5lTCdsDfOQwCaXTEtjgl8V1rxxZeI=;
        b=FBeMGyz50ZVrnYAf2WEME2aQGR4Ym+9gZ32IDnx4XZK8oVxVV4teFovn3hNF1t9q5R
         OIMD02FOjnpnTUJbj5uPRrX9aZaAPyRxBZa+ZIw2LhmZCPi/VCjGTvwAl13K8Qt7scZu
         nB9mJi7AxQ9s7LEC7uf/8sJlLq2ZpBwI9KeyddTCPoFbhMU4sGV9JWXsNxZxBt1doQEq
         6iE7reoXJvi7TDNiY64gxFVoIHSsmLmZS+8hXIDfi4avf8BQPRjTtJozTwSIb8ztLHuR
         QN5nxfukGlANky85KFlVIWesd/FESKixCRfVa8ceUsMwdP1RghsegrYpHMKFabLNsdCt
         3ACA==
X-Gm-Message-State: AOJu0YyRreEy+UoPfiAGov4jk3FK5Zy5gxKSqHiKO6VDsDOK+sKmfaWx
	VurctOo6DY0UBKlXTtmR0dfkJpEvQOBAxbJXjC94suolUuzPqYgaWZAUYuC7Isrz
X-Gm-Gg: AZuq6aKA08fQhUXLHcglzSVOpFzNVS9JLl3vBdaU/w3e55UAPyrJ+kgBSvwcBH18BrQ
	MWT8aUL06YSadwERczAtUNquNXBO9BqUjSQQ/1dy8pdFV3ThfrEa1eAf7zAbklwQ3GVrJDH9sX4
	0vlA0ZXMPLCbrTSVKcWO3VB+L16aijg1CdeIhL8jKV7LrvdbyTt40m+s6r8b0aPSAANX+DHM+UZ
	osmanW0+GDsDPhJr2lZFJVoqdgVdlDIb8QXq1+PpHI6y3L/o2wKHvn3vDfGhclYFZOuiFxU/Kak
	VNzUddn+2hRs4VrzL1bStPXtt7Xp5nACXC44dErXiz2XfiDOirQZZJI3QG0UhiSB0yyR+vv8yS+
	Ir6QdAygY6qRVZtsY6lb+zIw8KMBfjwIp3FO1svkoplM7r1dY4rDE0I58CkHRkTJ6qN/VKnFept
	k9+t1d7J1Mw5QeY9myaG+S5yNCwCpL85AzNWHv
X-Received: by 2002:a05:6870:be94:b0:35b:32d5:8fbb with SMTP id 586e51a60fabf-40a96ebefc0mr7425928fac.37.1770698593050;
        Mon, 09 Feb 2026 20:43:13 -0800 (PST)
Received: from [127.0.0.1] ([52.173.178.210])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a996429c3sm9128106fac.12.2026.02.09.20.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 20:43:11 -0800 (PST)
Message-Id: <5601a5a84f4c67b3dfb751c2b93d1c300909b9e3.1770698579.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Feb 2026 04:42:58 +0000
Subject: [PATCH 4/5] config: create special init for list mode
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
Cc: gitster@pobox.com,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When listing multiple values, our initial settings for the output format
is different. Add a new init helper to specify the fact that keys should
be shown and also add the default delimiters as they were unset in some
cases.

There are two places, differing by the 'git config list' and 'git config
--list' modes.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/config.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index 5146abcfa3..e69b26af6a 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -917,6 +917,19 @@ static void display_options_init(struct config_display_options *opts)
 	}
 }
 
+static void display_options_init_list(struct config_display_options *opts)
+{
+	opts->show_keys = 1;
+
+	if (opts->end_nul) {
+		display_options_init(opts);
+	} else {
+		opts->term = '\n';
+		opts->delim = ' ';
+		opts->key_delim = '=';
+	}
+}
+
 static int cmd_config_list(int argc, const char **argv, const char *prefix,
 			   struct repository *repo UNUSED)
 {
@@ -935,7 +948,7 @@ static int cmd_config_list(int argc, const char **argv, const char *prefix,
 	check_argc(argc, 0, 0);
 
 	location_options_init(&location_opts, prefix);
-	display_options_init(&display_opts);
+	display_options_init_list(&display_opts);
 
 	setup_auto_pager("config", 1);
 
@@ -1366,6 +1379,7 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 
 	if (actions == ACTION_LIST) {
 		check_argc(argc, 0, 0);
+		display_options_init_list(&display_opts);
 		if (config_with_options(show_all_config, &display_opts,
 					&location_opts.source, the_repository,
 					&location_opts.options) < 0) {
-- 
gitgitgadget

