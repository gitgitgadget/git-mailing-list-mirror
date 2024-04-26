Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1501869
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 00:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714091179; cv=none; b=I3e3NjC45/UwAn1TuGXdOjEXJ/0i+2tPguL8KDrX/yupMZeEfYU13xMi+nkvDBz10UCbFTLKNP/+yVQc0NST9qq6ALTscFcZnbFpvO0FubLO7uWDjwStSSCm4t8eyx88DpbQrav3eVRpAjP9mbafkGr/KHhGlmo2lTolhMjaYec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714091179; c=relaxed/simple;
	bh=9kAoMDOFAxLoPOZrzD7YL4t/gUJSopvjOz6CeQeZXkI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nQNANU4xsKuxv3f1SRtoP2jP2Hp6NFC7Uf/oj6v08ia91VPcONIVmUIXIoHMn4SQCpIzfgZJER4RvGzNDZMU1OVJsOE1B6sycrqXkfp2WxBtq2OMvfLLzqwyeFQedw+n8LzGRqwSuANs5K3iyTCoBaOUOuAzTs2PB6XIkMuuu9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgeUCvW/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgeUCvW/"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-418e4cd2196so12804225e9.1
        for <git@vger.kernel.org>; Thu, 25 Apr 2024 17:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714091176; x=1714695976; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOGKGuTkdwRSPqSSaqCCsiOdFMxgqW/ZfvgOAqeO+ic=;
        b=cgeUCvW/eoKa+ebCLtnClNSmpgSwpM7UKP0phKUBpOoyrgkCFCrgnPHaWIcWZv6k90
         RTKV2Z43wdaCt9gtz/38PGvI7PuOBId3VdOns+fb7v+9dyNNHjbjk3RPZBdbfR299yhI
         KXBTbOKB6W+niaBOp/f50bkn3kRELW+oyUXcKvlZdVzi4/zr9gNcF+JuKQuuJYq9YgbF
         WEHjAEtYOPeqnbEKVxL8K06IggVTVFqKqyOqCRdVtwYStSDIBVijl+euZEl89DN4hfOY
         eZ6ln88L2I5/n3vbPLMFHYADS38sLXg4sR5Vm7Yf3TyzEaKl9fnl2uulr6yn/9rdLfg4
         Phwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714091176; x=1714695976;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOGKGuTkdwRSPqSSaqCCsiOdFMxgqW/ZfvgOAqeO+ic=;
        b=fXKosHB5RTm5SdGtmnw4YD0HfFelOwBVxkg5qePTv7HNUuiyBMcwxgiaXuRs9oQ93P
         J+i1esVmX39Hh6eL9407XmElnSaSDO/x5N0Lak2klefuiF3MphGNb3IPnks3+L4tGkPn
         6wh9UEzooH29ipcMRfC/ZR4QQA9kWV+G/baV+iOvTKchXrfkJWDLi3TuL7KIXL5whjf0
         CbRGpRjON64dAANNerrtKhVQymELCDdbzeP8+pVDR/swWaQS6M9fQ0vahccDQifdvdEi
         gV5+pDUo4CP1VUYMnYcyVKaDfkJvBL7+bS43V5l6tQzv2GxO9SgN//55c7Q9zgp9ryhW
         +lAg==
X-Gm-Message-State: AOJu0Yyffr8Uy6k9/aTxjKhFw6aavjLXPVbexy8p9fRyBP1Jz4+16sJa
	fK20RS5yKHHfaHRh7NReAEIfmee+Fr7vlgAiBOe2wkmift+DtS4AXGnMAw==
X-Google-Smtp-Source: AGHT+IGtbgWHo3lYWEaJj/z/aaEmMO4DiwMb6U8GppiH1l+0jjSmiWSK3vrYKydU4aJ+fi6iYGMt3Q==
X-Received: by 2002:a05:600c:3b85:b0:418:2a04:d8cb with SMTP id n5-20020a05600c3b8500b004182a04d8cbmr765104wms.14.1714091175644;
        Thu, 25 Apr 2024 17:26:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c468600b00418accde252sm29248506wmo.30.2024.04.25.17.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 17:26:14 -0700 (PDT)
Message-Id: <4a1d18da574de8d0dbcde62b2d33c05026da1ec1.1714091170.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
References: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
	<pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Apr 2024 00:26:04 +0000
Subject: [PATCH v3 04/10] sequencer: use the trailer iterator
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
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

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

Signed-off-by: Linus Arver <linusa@google.com>
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

