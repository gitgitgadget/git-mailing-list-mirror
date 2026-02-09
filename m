Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4348232B98A
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770679047; cv=none; b=eDsX29+zpwwHbzdLUA6CArzQ3L66q2ItKRfG++9wSJdHpAF6Uzfal0a4hMDCm4fO+MZOEeCt/WXNQk/Aw/0rXUNma08xkreWP5zbvtvPZCRLlGC8vJ/tcac6vLDJNvy6ujbswvGWN2Y8+W92Sd208wbWpbbYmnRcPLMIt7UfxRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770679047; c=relaxed/simple;
	bh=PKdxmFhqJuSfGubCcJ/aUBRKoxhz2PbD/YRYCrt0T4Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MIL/W9CvLDsgTzVB82J3O2EfaGImsgjfJcNNROWdxeF6Z45kotQoDGIPdWm/mniiu9SXlxafZpVXSazeVmuYJBJGkzdEaepkLSHXaJnXhwYP+mCQldtxs6lMjSb22CNzAmb2Yq0Blvc7JNKLeOGhNxFoPsRBYxVdNhGWsAAvooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBtAPLhF; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBtAPLhF"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89503a3bb83so2142236d6.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 15:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770679045; x=1771283845; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PG22K+dIRdSMs44ZCswSk6PNADFPAw4PYUhefcm/3j4=;
        b=TBtAPLhFhWku8ps3O349I5+MwQzuS+/uhztt60GgXI2eAgV/1iMrvSMJkQIGqPo0k1
         UiGNZn4zdQH3sJ/WJ8vmCElgMDr6UeHwgted9SIO5Tdbf06/KgPLAqkR/jFvAnzyaWN0
         MdavsQDmyQbJyLG8nS77hBcXXwbZM1Y1M/Pu+6frEs2lO1sF5QnrSQ03X5AknAUUt+nA
         gyTtOa6Vgw6oa5lrRSgK3yoZbJnZ8nxppopGr6HFEzFgovZP5o1zhpxcTPs8kq/JoQ6Z
         XhxSlANduO9d84Q66MlAInsV3vF9juZxpht3Ry6S9BusOMFIpSjdHxHPP5zF4tcpeO+S
         WUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770679045; x=1771283845;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PG22K+dIRdSMs44ZCswSk6PNADFPAw4PYUhefcm/3j4=;
        b=gkh+Mcu8+7XPLS0/pnZrvqvST54BuLs66gxcglcbIHN+1xahAagV3FVpn2BLMvNQM+
         Gg6SnOlI59kvh4jZRO8jFJiAc3PRKjIZK4tk70afL48jV1wcDhApMlr2Ts4E/BbBZAPO
         8FUNLMICkv1ldz8aoOBKYXm44ncTezkKfFjgX575rgpSTrVe+RTAxM3Qfob3eWY74w9F
         ZRlDPKTciFbRarFKBFKWBdEGFLbDf0XmhBGP+VbIFr3r1u8xBfRlrJOthiiRW+iIZvuF
         lkcvL46pwV6iGzhIku2185BYUwWo1cdl8w1N6wjtLAv0wnqdZOTynAFTUYroTE51tMQa
         u4Fg==
X-Gm-Message-State: AOJu0YxJ3oztpbsmfio5ChQ8E7MKzoQetpBZQpJqHtWh9NdrljNt5t0Y
	yroQ23vJXYuuPPUUZ9XO7Y/DFREe6UfTJoLFx7G7bQtkf/dzV6176v3QE+UlPQ==
X-Gm-Gg: AZuq6aLPvfbC50nIsju4rRNmxRleh+IwEDuUclIXbvIhSFExBvDagmDCDSrDgCvjWKQ
	Dquj0AorXFgIreTG2UkVI1Km+ARGplGLV/hNYNBPSB14c2ck3Nk9gtDkt2sfDDSb2/worzJm1ze
	YXyY9CRGQNKUbv9hI/aFXzqFMXkyaYg8R2jGs8KRNPmxHIV9wk7QN/6mGN2G2DsEIDKFc/4XAy3
	9ZLaVY/dYcA+Pn/bjWJBzdt3NJ57XJi0bo13tcxk50+KVxWgiw8j/pRVuXuXITq12RgJgdE7/zH
	BIA32rvIMQhRXFqy+dr1pcLnmFRKqRRBHwSjCRuA7ri5ZM4Q0FGbzIxRBqpZgZ4KUMdRl+7mSBI
	L7a0upIBATo+WHi5MESBkbqvEWw+1wlvmPNQTUaiPuJT5aJdBQSfIbJHRJSpMKlDPxIc4C1DV/U
	XdRco6nvypnJLA
X-Received: by 2002:a05:622a:155:b0:505:e7b8:5524 with SMTP id d75a77b69052e-506398d1397mr167311881cf.11.1770679044748;
        Mon, 09 Feb 2026 15:17:24 -0800 (PST)
Received: from [127.0.0.1] ([64.236.200.85])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50648d97e72sm68555601cf.2.2026.02.09.15.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 15:17:24 -0800 (PST)
Message-Id: <7b785b6064966aefe6883ce3c45e80bb74fe79f4.1770679038.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.git.1770679038.gitgitgadget@gmail.com>
References: <pull.2043.git.1770679038.gitgitgadget@gmail.com>
From: "Rito Rhymes via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 09 Feb 2026 23:17:16 +0000
Subject: [PATCH 3/5] gitweb: fix mobile page overflow across
 log/commit/blob/diff views
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
Cc: Rito <rito@ritovision.com>,
    Rito Rhymes <rito@ritovision.com>

From: Rito Rhymes <rito@ritovision.com>

On mobile-sized viewports, gitweb pages in log/commit/blob/diff views can
overflow horizontally due to desktop-oriented paddings and fixed-width
preformatted content.

Add a shared mobile media query to rebalance those layouts: reduce or clear
paddings in log/commit sections, keep header/search content within the
viewport, and allow horizontal scrolling for preformatted blob/diff content
instead of forcing page-wide overflow.

Signed-off-by: Rito Rhymes <rito@ritovision.com>
---
 gitweb/static/gitweb.css | 71 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 7 deletions(-)

diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index 1fe120cd95..135590b64c 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -123,6 +123,7 @@ div.title_text {
 
 div.log_body {
 	padding: 8px 8px 8px 150px;
+	overflow-wrap: anywhere;
 }
 
 span.age {
@@ -537,13 +538,6 @@ div.search {
 div.projsearch {
 	text-align: center;
 	margin: 20px 0px;
-	padding: 0 8px;
-	box-sizing: border-box;
-}
-
-div.projsearch input[type="text"] {
-	max-width: 100%;
-	box-sizing: border-box;
 }
 
 div.projsearch form {
@@ -691,3 +685,66 @@ div.remote {
 .kwb    { color:#830000; }
 .kwc    { color:#000000; font-weight:bold; }
 .kwd    { color:#010181; }
+
+@media (max-width: 768px) {
+	div.page_body {
+		overflow-x: auto;
+		-webkit-overflow-scrolling: touch;
+	}
+
+	div.page_body div.pre {
+		min-width: max-content;
+	}
+
+	div.projsearch {
+		padding: 0 8px;
+		box-sizing: border-box;
+	}
+
+	div.projsearch input[type="text"] {
+		max-width: 100%;
+		box-sizing: border-box;
+	}
+
+	div.title_text {
+		overflow-x: auto;
+		-webkit-overflow-scrolling: touch;
+		padding-left: 4px;
+		padding-right: 4px;
+		box-sizing: border-box;
+	}
+
+	div.title_text table.object_header {
+		width: max-content;
+	}
+
+	div.log_body {
+		padding: 8px;
+		clear: left;
+	}
+
+	div.patchset div.patch {
+		width: max-content;
+		min-width: 100%;
+	}
+
+	div.diff.header {
+		padding: 4px 8px 2px 8px;
+		white-space: nowrap;
+		overflow-wrap: normal;
+	}
+
+	div.diff.extended_header {
+		padding: 2px 8px;
+		white-space: nowrap;
+		overflow-wrap: normal;
+	}
+
+	div.diff.ctx,
+	div.diff.add,
+	div.diff.rem,
+	div.diff.chunk_header {
+		padding: 0 8px;
+		white-space: pre;
+	}
+}
-- 
gitgitgadget

