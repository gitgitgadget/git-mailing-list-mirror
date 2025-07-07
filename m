Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747871B4257
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751914422; cv=none; b=TY0+zLNuBs61LOjnVWcX9ZPK8rhjvbXgi70qfvQoz/uctRcl1FU2Nhdi8pCCDqTmuR0xMR6m5SAVtGlzOopppTSRwoBlrdwnlBWEqcc4h6VSjtuqGL8SMENSOvyVI7BPBUQuRK9TjOSpgiqBGLh6M55CXiKd595+RhlS1IisUWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751914422; c=relaxed/simple;
	bh=ycuh470JgOMKOPCZ5ZyCa53f1xY0kKsH2F4D/zhuIJU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=QM5EuZXpjBWRhrrofzyE/DghvLKyYh16JgPIyy5gdiHhc3bI/caDtlRAtGvtCYzOAam3ItbLWQu8AgJwdISSzFcWgSzIEPZNKEsNNhfh29jxZsHxvi7p1FddqiBxj4/EugZuNQoS/KxubcpTpgqH6EqMWllg6iL2nT/nMltmb8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPtTszCx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPtTszCx"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-453643020bdso27379195e9.1
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 11:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751914418; x=1752519218; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtGLQIoK+r3lkTuRkZEbs3LHqcoKyxr7lYoIjxI11zo=;
        b=jPtTszCxOinApv6ofi87xnTX9cAWnfYpQ1r6QiXjuaoJnPJh69lUx31Y+PPZUVPSi2
         nom/LDHcEyFmjex4tohyRGIHsfyeZM12rUYcG/tgt7VapeXo1hZ7WZpCTTlWa7dJyuNs
         A5tyVybh4sXZ2CS2j5/8LHQZ14ktZ5Y+AfdTajBXuKKG4kosvQAOrD6ef0FBGArGwTWC
         Zxp3FL9l24V+0kcsB8WXpIdxZnC6LmUJNcDCfF3CbLX0fO3Y7LrQ5veoKCrPFzeUg4JP
         JxgkOCF/rWUc8r2zbU/OuJt8dh4vK6pz1LuRa1Zd07aokPm8mInS+povqt0bDTUeTFOy
         AaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751914418; x=1752519218;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtGLQIoK+r3lkTuRkZEbs3LHqcoKyxr7lYoIjxI11zo=;
        b=YBKfaSeCbZygFgrCzYXHz79NAGPZcVHitGBhpTHjQ5E/CgOI7R82SI4YuVXB3aCRBH
         ZMaMivpS6tcFmPwajYL0EcdqwMhnUR1XLqe3xjR6mGfQH3i2TCYroDVvcqEbCuVip90s
         fLzpNgrMEsYCiQglH1n78VrV7TK/y2JtktD46oyj52yX/C92ecPNMT/vB7QYDkSv4N0V
         RSDbZKMpJQwi7/FmWAAY66tslQEF75z5xuuXI2zgAaQ2UCi4TpJuJ1ETSwNsCyJT26AJ
         IU4P1ZPnFbVCC3djcEbyTfGBBbJzL2yBIXXkjA4+q7aSUtgfMdPD2deEGg8KLQV++/Md
         L6MQ==
X-Gm-Message-State: AOJu0Ywg2pvjjLo8ev13ZPvmt8zPRGC9D/LSHsHdj1ifLrBaZaVcFgh5
	1o9tS8H3wwEMq071XN292jO4Pq14KiYMRVQsTJOJ0LQzakv8WxNkIvOvU82Nxg==
X-Gm-Gg: ASbGncuk8kfFNhpxUn32N+9GUYIRwa5rsMe8YQPr7EoWuFBfPRPbYCcpge22M/wOSfD
	a7nEUS32G0bCXuJ6MvvU1R/p4YB7QF05ooH9YYi2uco7VQCptNLi/G3P/J458a7QQ1XZ+hP3ppJ
	TKNiblRpO+JFEM1nyKfiB0wlc4KR6blpDOGzVz9OQNB3Pfv7kPPkyi1/W9qetedEIGwwjwMv2bM
	yU90M3AIqCyaHwPz/19+oq3yO9F8tYa3jbHYjhA5aaU+GlWcCtQBBDOta41KHgZlTN1deUpLMb3
	UppUkGoBLcG2IXDWP170ePS4XfxXJAIIkGFdBNmesL1hrZbZmNJT67mePeN02jQ=
X-Google-Smtp-Source: AGHT+IGGo5FjdOKULqKNBEPo287i4U58PDeq7QuNUqMYTE28qXkRgBs4XNcqQgvWeuSMXDAaBZvuEw==
X-Received: by 2002:a05:600c:5308:b0:451:edc8:7806 with SMTP id 5b1f17b1804b1-454cccd6204mr4972725e9.32.1751914418438;
        Mon, 07 Jul 2025 11:53:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd397080sm363385e9.5.2025.07.07.11.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 11:53:38 -0700 (PDT)
Message-Id: <a4ac3ea53066b12ca237e208fb5594923e181363.1751914412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1933.v3.git.1751914412.gitgitgadget@gmail.com>
References: <pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
	<pull.1933.v3.git.1751914412.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 07 Jul 2025 18:53:27 +0000
Subject: [PATCH v3 4/9] doc: git-log: convert line range format to new doc
 format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/line-range-format.adoc | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/line-range-format.adoc b/Documentation/line-range-format.adoc
index 9b51e9fb6614..3cc2a14544cf 100644
--- a/Documentation/line-range-format.adoc
+++ b/Documentation/line-range-format.adoc
@@ -1,30 +1,30 @@
-'<start>' and '<end>' can take one of these forms:
+_<start>_ and _<end>_ can take one of these forms:
 
-- number
+- _<number>_
 +
-If '<start>' or '<end>' is a number, it specifies an
+If _<start>_ or _<end>_ is a number, it specifies an
 absolute line number (lines count from 1).
 +
 
-- `/regex/`
+- `/<regex>/`
 +
 This form will use the first line matching the given
-POSIX regex. If '<start>' is a regex, it will search from the end of
+POSIX _<regex>_. If _<start>_ is a regex, it will search from the end of
 the previous `-L` range, if any, otherwise from the start of file.
-If '<start>' is `^/regex/`, it will search from the start of file.
-If '<end>' is a regex, it will search
-starting at the line given by '<start>'.
+If _<start>_ is `^/<regex>/`, it will search from the start of file.
+If _<end>_ is a regex, it will search starting at the line given by
+_<start>_.
 +
 
-- +offset or -offset
+- `+<offset>` or `-<offset>`
 +
-This is only valid for '<end>' and will specify a number
-of lines before or after the line given by '<start>'.
+This is only valid for _<end>_ and will specify a number
+of lines before or after the line given by _<start>_.
 
 +
-If `:<funcname>` is given in place of '<start>' and '<end>', it is a
+If `:<funcname>` is given in place of _<start>_ and _<end>_, it is a
 regular expression that denotes the range from the first funcname line
-that matches '<funcname>', up to the next funcname line. `:<funcname>`
+that matches _<funcname>_, up to the next funcname line. `:<funcname>`
 searches from the end of the previous `-L` range, if any, otherwise
 from the start of file. `^:<funcname>` searches from the start of
 file. The function names are determined in the same way as `git diff`
-- 
gitgitgadget

