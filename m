Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F1117920E
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993426; cv=none; b=M8RHS+p1sRCASpDmOxYPpNP3Wb1DHw2rtvQG8wpg5i1DQjQXkYQj/56wmDnfyCfVdJgDJK1hBWNSBlFxQvUVlZr8+XbzVvzW7VAXUraP+jtXEUS8cXWSQUai8fGYV+vUCUTHyeZm5Nc26U2LagZ7UqUyaJ+sKGw5nsG8RIXgn8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993426; c=relaxed/simple;
	bh=8KYxFrnqA7aSapB8nxTBduh16HnfBxCwWLJ44jidEBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ip3aTr/EVgKHc3ZKirXx8RrrZDrvDG3C4jfZrqz4o+sPZVdN2ZJFQm03a3j5hYvH+0rA7D1xQc0BGLvOD8NHYVIr8+vfd7F33ag8T6PC3zbG9Bf7EymmWHTXGraVRfK32V4WHAkCZkfZ9Ge4FgeZkOHBWYyKUK6Idj9/v0yRqjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZ7bCfqY; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZ7bCfqY"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-62a2424ecb8so26391267b3.1
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 11:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718993422; x=1719598222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZeOg/XstlRP3x+3az8hAEEQqKYTYvEbzy10Irouwow=;
        b=bZ7bCfqYyoDAtFGE2iPlYqFmJZUBZXPvvET6iXhptOYJEe6DezmpF55sGIQavxC/PG
         9gM34xf0E4qdjkY8fVlLRotj5cmxutnpzUFQYyUVtREV+80p4LD+G6oNdGxgX2Fw4tos
         w04XdO6HCBAsxXrYusXBa8fNTffFfcoEYZVpPWIZ0PXfPDY5pb2siuxHnobNcoqu6Rq5
         Udf3drc0Mf6sOs5vwnnHONQCWhbTH+p10/iuzG7Sli/it3DyQobJBB8nYBZMzIBG7I16
         H9QdnUPFZ7+Rs9kzAIWkcmaPXy1ul/AdHtpzTY2WbH+3t7U5ehYSHUHeEtRJVpPrUn50
         /TBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718993422; x=1719598222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZeOg/XstlRP3x+3az8hAEEQqKYTYvEbzy10Irouwow=;
        b=Pf/D5K8JLKb1zUejEZBluWlZ0gyDiv8phwuip45bXmsEkdkPHKMEuJ+cf/2CHGmrx4
         aTKzLj1YwX+iFefy5Sc3buNg1eRwPg8nLePNqek/T2uRNiAod4TDep1uM6mUOkp3tZDd
         qgOTSTF5QOCjucfWlwxyBLTwETPSNIh9hqxt/4B921prX3DiW53ZlyIFa352z6duqfiv
         W5LLA4DXMXX1o2dZ132I6Sul/ObsnoDD3fyJc9mh3Iu4Mo/vKQ15bhWWmgl8PL+bLBS2
         d/RhRexfT3YeYK+hqhzUmnC2r+oQpPtsxlp1XAP88YHH8OaQY6p52+KPlGtjJ8ZVPtfg
         vwmQ==
X-Gm-Message-State: AOJu0YxJTbRIcOIuxlzPgSqC3wbmJCN+rS+6JnkPoxIWoVvawIsN1Ovm
	IiE6v8lqlm2NfeWv51ZuCPlSHZj0KmGC0AOcmxQu+9J0ETcVOpEqxa8dCA==
X-Google-Smtp-Source: AGHT+IFYCbmXq6gobPS7Wyfd13bbWEt3wc+rsfIEA4WT89qLeTdWruqcr9Lv6Imh6EmGYBNcPxHkVw==
X-Received: by 2002:a0d:eb0c:0:b0:627:d23a:44ff with SMTP id 00721157ae682-63a8db10073mr92158787b3.3.1718993422208;
        Fri, 21 Jun 2024 11:10:22 -0700 (PDT)
Received: from localhost.localdomain ([2607:fea8:3f9b:a900:bce2:445a:248e:77bf])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef678ebsm10878116d6.132.2024.06.21.11.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:10:21 -0700 (PDT)
From: "Randall S. Becker" <the.n.e.key@gmail.com>
X-Google-Original-From: "Randall S. Becker" <randall.becker@nexbridge.ca>
To: git@vger.kernel.org
Cc: "Randall S. Becker" <randall.becker@nexbridge.ca>,
	"Randall S . Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v2 1/2] Teach git version --build-options about libcurl
Date: Fri, 21 Jun 2024 14:09:46 -0400
Message-ID: <20240621180947.64419-2-randall.becker@nexbridge.ca>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621180947.64419-1-randall.becker@nexbridge.ca>
References: <20240621180947.64419-1-randall.becker@nexbridge.ca>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change uses the libcurl LIBCURL_VERSION #define text macro. No
stringification is required for the variable's use. If the #define
is not present, that version is not reported.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 help.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/help.c b/help.c
index 1d057aa607..bf74e935b9 100644
--- a/help.c
+++ b/help.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "git-curl-compat.h" /* For LIBCURL_VERSION only */
 #include "config.h"
 #include "builtin.h"
 #include "exec-cmd.h"
@@ -757,6 +758,9 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 
 		if (fsmonitor_ipc__is_supported())
 			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
+#if defined LIBCURL_VERSION
+		strbuf_addf(buf, "libcurl: %s\n", LIBCURL_VERSION);
+#endif
 	}
 }
 
-- 
2.43.0

