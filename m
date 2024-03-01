Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8251A2568
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 00:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709252099; cv=none; b=dnU4T50CdaMeoNfw6mjO0X26Tew5sn8AdFyWRvLFTHoYTxK3OxO3UDofnRnAXTxrQNtLxMMDRqm9xLwW+ZVm0eE+Hhh/XukEq9egaQs+gBvymJulHsBEMnM3vlJH33cuQysx9vVlgbUuLvpZifD8aKmDNvKePh9+OwyE2VYdnQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709252099; c=relaxed/simple;
	bh=8zW5s9dVw12pr9fbZJS4z8TlV+Q1EwM2vdLxdUNtO1o=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rCmGlKlLNCXbxKdPOeSLxKLYq0gzb/niB+02GdpMEZm/QBIXNo8QQ+Qz7RwhiF/mskSKOYuGSkoStqUbAR6/UkF6/OjVjC1a5j4CEOQwfdD41gC26et696rWnm/uZvhQxlwZj40y0wwALxhz0BgRdT5POji8+sNf/B1d65FUhUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrCqj0xv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrCqj0xv"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33e1878e357so230835f8f.3
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 16:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709252095; x=1709856895; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVmCHXSxcIJ8BC25Gubr/EV2nNjiB4Aj4jeRQHFX7BQ=;
        b=BrCqj0xvfOkSNbgE+t5hRO8yCmv8mncae3wPvZ7ivgXmdRVbQNog8hi1XzNSC5WVG/
         8vWmviF7D+FPFLzeyrJy1XuBpmOCndXYKiK/eN4MK9msGPoJlm4OsxyUYO9/YdGsq/+l
         S/6E8E43ObqulLTFp/5UKhLsKx0o23an2AgmoxX+wEyJ/KJPsEa033fbZoHa14F4KtfY
         yj5fkJu3aYG0SHNiv9GZxfxZUo5WiUVDh34NLZZiCgg4WIf3AMV7WcdbQHaCxMedELVT
         jJsDyQZ/KC9LktFWM/IYueINbknJ8ikYDECYM9O/ltVgY9RrtQDqBM1RSFPSwMhgi/4X
         +YXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709252095; x=1709856895;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVmCHXSxcIJ8BC25Gubr/EV2nNjiB4Aj4jeRQHFX7BQ=;
        b=AuJmmyxW27MoOfQvhxAKiph58uVrKR/++zjqC3dCwF1HqywMzVVC+eB4QgC6n8+Mbm
         RnZWeo1tbGm0DWZAFeW0ZAv5rpWav7yCOUeyJ+Qw2x2U8KvlyTwW77CwGhhf1Crae8+h
         Pk6g4mwIahwM8dOok8KhYs09Oi4GgzWrom4IdmoViePyaUZ0ybN96WXmYTchTVHtanpp
         pU+9mOrV/53cMDJpFWiZZ7gfOfAtV5fix3fgn0egCYBK4jUhXAbmYi3GsK5J5kOOvIRf
         07g9PYsN6v0+Rg/+5/xpRidSSV6p31yEByNdJ5g2L1HEeGEG5XEwtt70H51M3TPqEaoi
         VqBA==
X-Gm-Message-State: AOJu0Yw6fBdy8MurHQoPKtGrjKI8AUwU3iPIApe8jTSr7U2m/CwL+bja
	qQMKPsAGuVM2j+ZRj7vr87dLSYOXRnZbCtlBYCkE1Y2MUSNbLHGbAE0CfJA/
X-Google-Smtp-Source: AGHT+IE/qdvAa6/rxXAeCX1KzOSAxGOguTscqG64rn+sgoVmJ6XWse9z8Se4QuWQDINiFFtlIQmG/g==
X-Received: by 2002:a05:6000:1970:b0:33d:5548:435e with SMTP id da16-20020a056000197000b0033d5548435emr104219wrb.53.1709252095175;
        Thu, 29 Feb 2024 16:14:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u20-20020adfcb14000000b0033b7ce8b496sm3002433wrh.108.2024.02.29.16.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 16:14:54 -0800 (PST)
Message-ID: <26b1f19d0e11af0af8c3be8eb88ef97bf6c24fa3.1709252086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v6.git.1709252086.gitgitgadget@gmail.com>
References: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
	<pull.1632.v6.git.1709252086.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 01 Mar 2024 00:14:45 +0000
Subject: [PATCH v6 8/9] format_trailer_info(): move "fast path" to caller
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

