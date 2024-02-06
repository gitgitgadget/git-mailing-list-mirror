Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5621A7C0B6
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196362; cv=none; b=hkolGZGVlPLwjUhcUSF5kaoZxJEZwUROGcio0Nkd53PalqqZm4ORPTbjI174bAUP4qUtjUJKLu7yZEpsFThnwp+mIG3mynm33A/4oL1FClakSgex9LXGqwTs7uozXTeFtAmtvML9qpweo6YIClnPp7MQZz1oGl7KANDeO/uDeRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196362; c=relaxed/simple;
	bh=8zW5s9dVw12pr9fbZJS4z8TlV+Q1EwM2vdLxdUNtO1o=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jeE7UlcHd2bLopDWCvavJypVSEyRn3CF0vu1MOE+9wxkgwI8xEdHu0ZtDNvXejU0vjclepNGeqqnuTWgbFXR8zsxgThHwnd1qErthDbCMcAx5wA5vALCMkuMmjsqlfjljMWVb8a9LSwu02eZHEt1WpKWFztiiBw+H2/FD0dIuoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npGwSMxG; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npGwSMxG"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33b13332ca7so3199325f8f.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196358; x=1707801158; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVmCHXSxcIJ8BC25Gubr/EV2nNjiB4Aj4jeRQHFX7BQ=;
        b=npGwSMxGZmNZbN6nyHSk/9QQbZATFHyTxySpLmyy0WDSu5CKMg3SBcO/Q0UIRaGYfP
         A493YS/1O3ijhdAONYe4L7IRYTpj1U+PCnoe3WUb3k1s/0efZPJfdM8b4vHl7J7fkHet
         bFCvRwwq+j93ZbpoDxPiWUTig+nx+fWlxuHgLs/Zc54y9WWfNuTNJF3QbiFm9SgEJM+0
         13iZMQXqv9SLhVkE2e9rKdWilTObFGymjVuc3PQwXNfxsVQrpsDaWeI8284VrBZtFdrN
         YEicxGs9yT+kFXXnxUmDuriAJjw+7n257/sse4I3xt3Dx06t6JJH3cXPMqBWrsH0GAup
         Jb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196358; x=1707801158;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVmCHXSxcIJ8BC25Gubr/EV2nNjiB4Aj4jeRQHFX7BQ=;
        b=bZDXrgp1eELmuNA1ClWXBdXgfpRgAwwj9oGJP98BbuAi8Vaxk/b7VIz2Qz5/mXUJiu
         iNLJYHIT/vB16lRkmfA9Zjss4RtZAw37XzBcPap6aYgatV5paliyETngQj+0oNjPsxU9
         WI+hWxzGdVHjhV/ZFC+loBXblVbPQTCTjplyxHQdzppu0+uOW52geq/Cn9yUN2iPtJqL
         w2vs7Fa4KVmF/0ebVjDPD4QtcI5+JUkuH44YBEbHhD2zcPja9jQH6Q4+B7H1SmRQ8dsA
         jIgAS9bwJ5sSMN+poII79fmDFxCa/7koo1/kjaqO9uMGou0nCyq/sT/qptBZ/lQdkXqc
         B0zg==
X-Gm-Message-State: AOJu0YwUNHDrxdh5s+1IoIV7MgEeHBNog9E45/1QKtbDh6iaSxH2i6Ca
	TAe0VbI477o541CKlHMGGtJPvoPHQHVH6h5Qe79E+d+35I6GQlnGYu1vHiMk
X-Google-Smtp-Source: AGHT+IFPA6ySMuwoPUCvvXKUGaDOOPZb78hxdg95P/CSH+BShheLZQzHWy8L1mO5mVmrQXpV+FgkKQ==
X-Received: by 2002:adf:ea49:0:b0:33a:f27b:7fc1 with SMTP id j9-20020adfea49000000b0033af27b7fc1mr427523wrn.31.1707196358204;
        Mon, 05 Feb 2024 21:12:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVbgqB3ZOndMv1LkvSIpHa+B/kvFWb39cG5HF2jYDk3c0C2upxQKuEq2I9p9TAXqMi4Ha0DX7NMfLk4xDA+6ewGdsgMs091ouAnPU13F7CgyuOD4kH9/jKHrjjdzlutLv7FiBq1QfbYTIKPaHXbwO7j1afWzxrJfBnVvvBqhLofikMzdJX5oSngz2Ge6Jhf2mPpxT6bEe2x6g==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d4c48000000b0033afe816977sm1048148wrt.66.2024.02.05.21.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:37 -0800 (PST)
Message-ID: <b97c06d8bc324139710b6fb8c7765326f2a2bd2c.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:08 +0000
Subject: [PATCH v4 08/28] format_trailer_info(): move "fast path" to caller
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

This allows us to drop the "msg" parameter from format_trailer_info(),
so that it take 3 parameters, similar to format_trailers() which also
takes 3 parameters:

    void format_trailers(const struct process_trailer_options *opts,
                         struct list_head *trailers,
                         struct strbuf *out)

The short-term goal is to make format_trailer_info() be smart enough to
deprecate format_trailers(). And then ultimately we will rename
format_trailer_info() to format_trailers().

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/trailer.c b/trailer.c
index cbd643cd1fe..e92d0154d90 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1087,21 +1087,11 @@ void trailer_info_release(struct trailer_info *info)
 
 static void format_trailer_info(const struct process_trailer_options *opts,
 				const struct trailer_info *info,
-				const char *msg,
 				struct strbuf *out)
 {
 	size_t origlen = out->len;
 	size_t i;
 
-	/* If we want the whole block untouched, we can take the fast path. */
-	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
-	    !opts->separator && !opts->key_only && !opts->value_only &&
-	    !opts->key_value_separator) {
-		strbuf_add(out, msg + info->trailer_block_start,
-			   info->trailer_block_end - info->trailer_block_start);
-		return;
-	}
-
 	for (i = 0; i < info->trailer_nr; i++) {
 		char *trailer = info->trailers[i];
 		ssize_t separator_pos = find_separator(trailer, separators);
@@ -1153,7 +1143,15 @@ void format_trailers_from_commit(const struct process_trailer_options *opts,
 	struct trailer_info info;
 
 	trailer_info_get(opts, msg, &info);
-	format_trailer_info(opts, &info, msg, out);
+	/* If we want the whole block untouched, we can take the fast path. */
+	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
+	    !opts->separator && !opts->key_only && !opts->value_only &&
+	    !opts->key_value_separator) {
+		strbuf_add(out, msg + info.trailer_block_start,
+			   info.trailer_block_end - info.trailer_block_start);
+	} else
+		format_trailer_info(opts, &info, out);
+
 	trailer_info_release(&info);
 }
 
-- 
gitgitgadget

