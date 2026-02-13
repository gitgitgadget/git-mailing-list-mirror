Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF7033D502
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 23:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771026948; cv=none; b=EFB6oqrRtyLu3S4iDmT4vkBn7FnW6tXk+QC9nKzU/RpcRNJxR/XHE/CHey71t5F+9OFKviIjpVy9TBU3OVtnFPL2XfOP7e0CaE8eadVv8g97i7n18WERW6dkJIk+Fd5wZQfKRxcBQFYzUiaw8yLdkBZDpKVTOO4BD7R2niUkWVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771026948; c=relaxed/simple;
	bh=jnZxZHybTScvJBpgPWXS/cNGn6JAGzJt+QbFkk7j+hc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=twymQXVZMyYRX5zx+s10jZFJ/c0AznzLdK1z8NlWB5XBtP8gCdlCHa2gXoTcNbJMNmmp6TpYQPoSfcbPgb4+fEoUAVzWn2Nc0/ZdIlPrURVP+4l1UOwQ4DOPGqTEsqXIxKw+C4Q0S+TrZ9d3Joua3BnuS1ICWZ8X3g9njoOuakg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAZnEZCG; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAZnEZCG"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-89577f866d6so20455176d6.0
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 15:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771026946; x=1771631746; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAzhFuRZ2SJdSK9F1xCSqLK0xt8spRnyjC+Gfiotgs8=;
        b=AAZnEZCGfeKGVmm7IAn49Vqk5yIUDPdx60fdG47pOS6ROA0IKIZL9oQI2W7K2HxIM5
         MubmeQ7vf2z5PmPDOqYtA9EmNz+HLk+ezJsRwpQ2MwGirReffeFqJ1A0np1LFzabhmu1
         WdaedJZS1oFSsqAPIwqdEE9+47XugbBKkDaRjZtoy+XX8lw8YB8hiAPByRYSke4ak6YE
         HJ8yP8yN0J+BB/R4wUV15fUXNUBShZE7uzXzSIngcYowObO9ahvFvoKiHMb12/sb/gkq
         jxYmAXsOKg0CCoJ7S2Si1gxg8qddS31bSevqXhdaJG1r7V35QBT/RfxeePmqYMgT9sAp
         nsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771026946; x=1771631746;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PAzhFuRZ2SJdSK9F1xCSqLK0xt8spRnyjC+Gfiotgs8=;
        b=dwEs49EVPWsKINqSbSSrNvKEFZovtgarh+UkSuLpDjJJhPRuOdO7eOfsxpvtKiCvpL
         7NZb+L5mDUoyZknk6fJIs9uun8HMG8HOHr4P+w34PlYjxm3TW0cWejqwijSe4YaKQUyr
         zohvSqLr7WnlMbAB+85OWX6tMXmANR9MZcKPvPZ6gMY0hrMT0/heHJmOnA9DL932MA1O
         gOYSgIibyhcsmx2Ph8cKYgHwD0J38/hT4OYxBIWZyvnMUy4B3cgLmtpygD2Os6sgJY2C
         4fFUpG4e1VpezFSxleYxBZh3BZlaXcaWWRCVjonwVeSYzktqStzLYfYIARdwCx4Iye97
         e12A==
X-Gm-Message-State: AOJu0Yx1mhpglWKVOHa1crYEGyRcRWQw6zmDukW/Y6ACDb2FhHYwtYWz
	4t+lxiuNFkZIPgf9X2JXhxHeojjQa84QaAAzn/CV6BnRvQ0aC8GH6jDLXLgGcszQ
X-Gm-Gg: AZuq6aLRIe5iARnnnY9J3ZVObvqAFvbWs9sLNJQEVdBx45APWWfT+DwmajV2dGLOVwZ
	ddYkU8FB2blpX4qBIao8+JvWidAsX1cMrQ6dcBeW37AtsTbzXyD/56XmP5ROvdP79ixO8kXIfLb
	RvIC3FXDGpIHfOBPkkWaYW7znEKzYQqulqiMxrvdv9Z9z9gHpHtRt2Gjm9sJZGzfYIIv7c4A+3u
	VC+RzoI8gBhoOWZT8T5nznNs0+l1EmI+jjGzBYKk6cILJv5vJT9i0UmhbmfvnOaJdI8ceDvSljz
	BLM7gR1KUxmTkt45+pIyCpPadHIb6ZvKdojdk8dUTp0HslkAYwcIiguCvXeKODoRq7Q51fx3RZ+
	PC0GeJaK5/U9xwlt0z8fr1haaezDqO05kjp9bs0dBnoXz5ovpK7fq6eaP/adnAYuIdCqcj8Pnsg
	hKiZGhkNeOzLZIaVoNr5D1VvZOUVcOUIwVdFk=
X-Received: by 2002:a05:6214:2264:b0:88a:31e5:80fa with SMTP id 6a1803df08f44-8973f2bd416mr31479316d6.16.1771026946249;
        Fri, 13 Feb 2026 15:55:46 -0800 (PST)
Received: from [127.0.0.1] ([145.132.99.17])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b0db51fsm717452185a.14.2026.02.13.15.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 15:55:45 -0800 (PST)
Message-Id: <48fc882785013b129fba9b8aada6c1f2e239a4cd.1771026918.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
	<pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Feb 2026 23:55:18 +0000
Subject: [PATCH v2 13/13] config: restructure format_config()
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
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The recent changes have replaced the bodies of most if/else-if cases
with simple helper method calls. This makes it easy to adapt the
structure into a clearer switch statement, leaving a simple if/else in
the default case.

Make things a little simpler to read by reducing the nesting depth via a
new goto statement when we want to skip values.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/config.c | 59 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index e8c02e5f21..1de3ce0eaa 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -393,25 +393,44 @@ static int format_config(const struct config_display_options *opts,
 		show_config_origin(opts, kvi, buf);
 	if (opts->show_keys)
 		strbuf_addstr(buf, key_);
-	if (!opts->omit_values) {
-		if (opts->show_keys)
-			strbuf_addch(buf, opts->key_delim);
-
-		if (opts->type == TYPE_INT)
-			res = format_config_int64(buf, key_, value_, kvi, gently);
-		else if (opts->type == TYPE_BOOL)
-			res = format_config_bool(buf, key_, value_, gently);
-		else if (opts->type == TYPE_BOOL_OR_INT)
-			res = format_config_bool_or_int(buf, key_, value_, kvi, gently);
-		else if (opts->type == TYPE_BOOL_OR_STR)
-			res = format_config_bool_or_str(buf, value_);
-		else if (opts->type == TYPE_PATH)
-			res = format_config_path(buf, key_, value_, gently);
-		else if (opts->type == TYPE_EXPIRY_DATE)
-			res = format_config_expiry_date(buf, key_, value_, gently);
-		else if (opts->type == TYPE_COLOR)
-			res = format_config_color(buf, key_, value_, gently);
-		else if (value_) {
+
+	if (opts->omit_values)
+		goto terminator;
+
+	if (opts->show_keys)
+		strbuf_addch(buf, opts->key_delim);
+
+	switch (opts->type) {
+	case TYPE_INT:
+		res = format_config_int64(buf, key_, value_, kvi, gently);
+		break;
+
+	case TYPE_BOOL:
+		res = format_config_bool(buf, key_, value_, gently);
+		break;
+
+	case TYPE_BOOL_OR_INT:
+		res = format_config_bool_or_int(buf, key_, value_, kvi, gently);
+		break;
+
+	case TYPE_BOOL_OR_STR:
+		res = format_config_bool_or_str(buf, value_);
+		break;
+
+	case TYPE_PATH:
+		res = format_config_path(buf, key_, value_, gently);
+		break;
+
+	case TYPE_EXPIRY_DATE:
+		res = format_config_expiry_date(buf, key_, value_, gently);
+		break;
+
+	case TYPE_COLOR:
+		res = format_config_color(buf, key_, value_, gently);
+		break;
+
+	default:
+		if (value_) {
 			strbuf_addstr(buf, value_);
 		} else {
 			/* Just show the key name; back out delimiter */
@@ -419,6 +438,8 @@ static int format_config(const struct config_display_options *opts,
 				strbuf_setlen(buf, buf->len - 1);
 		}
 	}
+
+terminator:
 	strbuf_addch(buf, opts->term);
 	return res;
 }
-- 
gitgitgadget
