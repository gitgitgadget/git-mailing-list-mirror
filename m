Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA1C14D29B
	for <git@vger.kernel.org>; Sat, 17 Jan 2026 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768658389; cv=none; b=qBmiEzdfzcfQpYw3FSICR+vWrT0tVf+GraaIlyUX1CvbBnsfBFLXwjDYgfyorYkctABz0JxD8bF8dYu8RaCZVdC+VJ0dfNwSezWMai5hKGrLTOKk6kBeTKEiHeFQXGeVE/+JCwPRSKo1WlpeQ6Osz3k6ZBLV6OitqvC5//RPHe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768658389; c=relaxed/simple;
	bh=zAGW95StlAVB+G6jFs0u2zbQydW9f1beOvjxivyGCjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GciwfPRrcbwmIGzKEJh3mNVfsEjPMk4nSmlvXRgBeytZkvvLf44GmSEIBhxtHYYPpJ85LCsnsJ4bmbk9jpUKjk+RflqOjxo7B1QYGNChBRJOqdScv9D8DgdxYE0bcsbximeAnxjihPmbR2lJL7cZQeDDpeh9/7eaN/3+nVE4Fak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXoiPSNU; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXoiPSNU"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7926d5dbdf7so23327887b3.2
        for <git@vger.kernel.org>; Sat, 17 Jan 2026 05:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768658384; x=1769263184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLMCK9Ixx1Edd74j72R7dQSy3iBGtwDhtIuQm9s7mPk=;
        b=LXoiPSNUJSBOlzA0Fvt9zx10Ny0gVuvOyP9in/6o7SQv0UwwLypgVVMY6hbQ1biD86
         VvEbh0bzmpfKn+r3/GgYa7IsChc69HmYoGdG0vIXoqvm5z2VGZMORnNqW4oZrtuHEKvE
         4WEYdBG5hbU9n0oJQOMWbPrGK0DbC5+Aifso7vyhhZS4tlx/G+TURSTQYNAWVJGU3iRp
         90xwaoYheQpQdE0XAa5bcR9m829uo5iqg/I4iCcxx7qH2+Ca8kFKNt3XEPbRUCq/+YeS
         HxYVLV5okEZzgJydPgJln1J0HtLcCS6Nk+nEbMaRPPJoxr9JIftY4/XSNCVgaqfK8+lb
         m+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768658384; x=1769263184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yLMCK9Ixx1Edd74j72R7dQSy3iBGtwDhtIuQm9s7mPk=;
        b=AuGHSML75B32tAiGjQG02eqDcO+g8mynSlF65h936Y4vzXakggesgchfNzdcqjUXbZ
         okANYxqqCHI4f72aTSx0f4tXa+LRDARKR0a/XNS+ZHoIlUuDn3mGVhqQ3UWtoz28FEZX
         hepQOum4A0dkRq/btLtTHApjOI9pU+V0045ZBezrtuShU9aiF+bmO0N1fbpJyilsiibq
         Zg/TLfgQABMFs5xl3fUbRLyAYZdxuRCdIdq6wx1VaQ7J2Kdts2jef5zz+8eOGKg/HY7U
         4nvdETeRHXFD4fCwIfhl82tnKH4UQLpRuACqi1LxsJ5UIDsiiHovwaRsiIOYHcFvlLae
         ZOEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjkUZbGWHDNXuovvGpBCkVDqtfiVdEVbFjTJXi94fFPt1weZ90wQZL0JCTJSrBFkypTVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlNicaHWn9bULhuVDEhQRcehRhruqeJsbQfhNO4Rc+se/C47z2
	UNiCnWcVoYlmZv7bSVf4vp7apEBQmSN4At54DXuDaySGxMWPRPxDJblh
X-Gm-Gg: AY/fxX6P0iic+NbhOsrNL/ZucUXouM8CTXKk/tQSrN3To59tSoF77YhWUbIRIEE4TRI
	rUdGdRb/iz8KkNd6feb2Sh3BzHzlM5P8n9O2NKWsRf833/oWzpOfjDA6Uj8fwqXSL8e6co3SQrs
	4PTNSk47yHu6pR09IRjVVa8hILU7NW4acBg844SgthhKAPofPtrX9Vi/Hg6Dmcm4F+L+13NWD87
	Bl5qu27YOZsbnyOE+otBbP14/InueoQHqeBZX++8cVynVhZ6kF/dsGCQaz+ch0Dtrk3SutW91d3
	JJw5hkrI5roDJMGMz3Yh2Mf4IojK7PhNmcA2c8Qe5r7Ao9Z4bHKB7aYfA1WDIWJukeBbzFNCKi6
	f3J9RwPHwE6nyK0RAXekt+cfI+Ffv+m6GqsMOmYZuaItlH7rGP6DVrEc8ycDEAKDgLWdo1YLyK8
	qE1/cbVSyrM/TUUeuLb5w+vdzvDvLnQCBw7DPk3q6VKBlP/jgNR7Ktiu9fpdGuPCRoiDCFmcHii
	+Ych4d+eaNv4wXTy0Vs0snXSM/cNZn48Pyom0KKrYbkEg70dPaRr4Wbu3tsnPxB6ME0cF1mNoE=
X-Received: by 2002:a05:690c:6f8f:b0:78c:5bb4:1d27 with SMTP id 00721157ae682-793c5393eb2mr54805287b3.38.1768658384328;
        Sat, 17 Jan 2026 05:59:44 -0800 (PST)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c682e0c2sm20352117b3.30.2026.01.17.05.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 05:59:43 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2] help: report on whether or not gettext is enabled
Date: Sat, 17 Jan 2026 21:59:38 +0800
Message-ID: <251e1b533ca2e38a9bedae44360ce636cdea4bc3.1768657640.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.51.0.rc2
In-Reply-To: <xmqqo6mta7bg.fsf@gitster.g>
References: <xmqqo6mta7bg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When users report that Git has no localized output, we need to check not
only their locale settings, but also whether Git was built with GETTEXT
support in the first place.

Expose this information via the existing build info output by adding a
"gettext: enabled" line to `git version --build-options` (and therefore
also to `git bugreport`) when `NO_GETTEXT` is not defined at build time.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 help.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/help.c b/help.c
index 20e114432d..3c36d9c218 100644
--- a/help.c
+++ b/help.c
@@ -799,6 +799,9 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 
 		if (fsmonitor_ipc__is_supported())
 			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
+#if !defined NO_GETTEXT
+		strbuf_addstr(buf, "gettext: enabled\n");
+#endif
 #if defined LIBCURL_VERSION
 		strbuf_addf(buf, "libcurl: %s\n", LIBCURL_VERSION);
 #endif
-- 
2.52.0.435.g8745eae506

