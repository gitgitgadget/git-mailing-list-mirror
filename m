Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CF414A089
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708124964; cv=none; b=QE2rGSY0+Y4v6DUPD3OpjkABLzAzGu/f3nooVc18pG9aMYWvjJVbA6wwf6Ig57WUdDzl1Zq6hsHYlrx4B8ONweycLwyt7vTYbb4EPFv/GdX4AlRPBUUblSKu+08hLDJFmzBtAIPuhHf4f/QA3gHCUMr9H0d74E+V9bgiTW5Y/kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708124964; c=relaxed/simple;
	bh=1AnNkl+0zcRfBspDz4HCBHqgL6cIQ3kapJT3IfgrPl8=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=W0PeSTH2MqHAVrJzESJT/Drg3sJmd0ZSYTgzQ10eudhtiesRW/ONlaTcJFhsLcLmOjOqRaPNMpezpfE9g2fmPmO7Z0tzzvHXRyXJrODj9UthFp5VH0nEWQUJS56WKbhSV1fBfXFqFys0cRyADs/n+gkbWWr940ruaI999eOIOm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uj3kR5mp; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uj3kR5mp"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33d118a181fso1150262f8f.1
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 15:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708124960; x=1708729760; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyOrpV5KvK6K/5vJwLnuuHInkEOKWOETatb7vpt358Y=;
        b=Uj3kR5mpkG1gbutdGUTUHxT4qoOLM1AIDehPhynqv4CVaRoPk5p6iMXzmYd6bcFyCd
         uXEzLMNesVw8AQ2+1d6cN4NX2Z2qDnM7JVP9YeLJWWBgZgy3O/V8feJ0aI8UBrVGvqKA
         ViPuTocyR0u9pm5Ie64GOHtloiUt2WdnX4CwGFdY1JnVUvFcb2UYp3I7I6EHY3t4Jxy4
         Ij66ND9z9K5FfpJdZOet3d3ELNij7GFtW/Wv9LDHFC9MkmxdZ2M269HXcRBh2L1JJSYq
         uGpg7M+hiyn976Rvj5YiX4UHePdxMujGJdBIQgV5hQfr6pJKkhF8DZH4LPRC8G+baoXX
         zgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708124960; x=1708729760;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyOrpV5KvK6K/5vJwLnuuHInkEOKWOETatb7vpt358Y=;
        b=Z8H3MP/SYeqGmYRP2Yxc1qlL0nkPGd7YraONwf8bprGRSHqGJ3j4CppYWT+ILKP8iE
         9nPP+Oma6TKMJ3+Wogh37l9tv4LD2BAwZVD68iPCe5kgi0fMEkW4wSISbtxVCt8JQ0hu
         rRZqu0+f3Wsw8drO7T0e2AYEz6zMr/mI400oWfe+8sRDG21TWMT274kZ7+7GdLksqLdP
         jrjQx1qZcljGzjDng4BUfZEyoLn0R+Gk/rN5zqkRtPlDrjh/CwGbzz9SaheUBsb4rwjk
         el4Lz1nUbb0fEczw+pnoytL7YIlRu9n7L2qyASqCCCtMYlWqonCSx2VYZCIpBjEvyG0N
         y29A==
X-Gm-Message-State: AOJu0YzmLkAsCNoZwUF0rrwCEcD5ilputBjNvzT5NRy+ja1aLLowSWws
	mbIwoxPqo5/xqp4XpS4VOeCTP6O9Nr9BpIwqsfQPPYQA0/53M+H4ioHzryiq
X-Google-Smtp-Source: AGHT+IGgpnaJS2kndC6cEUdaDpMeV8UjbKlS84h9ofHZXeMhf9wVNR39aQKfmaTcMlCGL9PYfqujOA==
X-Received: by 2002:a05:6000:1143:b0:33d:2071:9b85 with SMTP id d3-20020a056000114300b0033d20719b85mr1866167wrx.19.1708124960612;
        Fri, 16 Feb 2024 15:09:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f9-20020adff8c9000000b0033ce40eee9fsm3288993wrq.58.2024.02.16.15.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 15:09:19 -0800 (PST)
Message-ID: <7c656b3f77546ae917ff192031c62d4521d9df8c.1708124951.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
References: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
	<pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 Feb 2024 23:09:10 +0000
Subject: [PATCH v5 9/9] format_trailers_from_commit(): indirectly call
 trailer_info_get()
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

Instead of calling trailer_info_get() directly, call parse_trailers()
which already calls trailer_info_get(). This change is a NOP because
format_trailer_info() only looks at the "trailers" string array, not the
trailer_item objects which parse_trailers() populates.

In a future patch, we'll change format_trailer_info() to use the parsed
trailer_item objects instead of the string array.

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/trailer.c b/trailer.c
index e92d0154d90..e6665c99cc3 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1140,9 +1140,11 @@ void format_trailers_from_commit(const struct process_trailer_options *opts,
 				 const char *msg,
 				 struct strbuf *out)
 {
+	LIST_HEAD(trailers);
 	struct trailer_info info;
 
-	trailer_info_get(opts, msg, &info);
+	parse_trailers(opts, &info, msg, &trailers);
+
 	/* If we want the whole block untouched, we can take the fast path. */
 	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
 	    !opts->separator && !opts->key_only && !opts->value_only &&
@@ -1152,6 +1154,7 @@ void format_trailers_from_commit(const struct process_trailer_options *opts,
 	} else
 		format_trailer_info(opts, &info, out);
 
+	free_trailers(&trailers);
 	trailer_info_release(&info);
 }
 
-- 
gitgitgadget
