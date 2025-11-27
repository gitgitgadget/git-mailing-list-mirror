Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A41526CE1A
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 02:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764211101; cv=none; b=lIwXsQJqwImGkxsETeKJNmv40vlHPU2FbAgtd13ujb8jDB0CvteV3MAnp+qzd/QQ4K43qP6SPgR//c4vFPrLGg7wYs7lPcPF9m/8RoKZOUq96ADjUgZdLWvugxXfYKnUjsnjFR/m5G2jEdoSGm8LL3x57T7eJ54J0UvGoIl1nWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764211101; c=relaxed/simple;
	bh=FGZEpwYWMRuXLoQ08VDO3TIlgrSrDYNhyDq7uKIHsIU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iHFgoHdTDXB37XofBMeAj6Cc2cmIOeCt/TyWJuM9vCgrqNdfcTBJrNPKzsXxFU3sl9mLwFMPrkvI01cqn0hyYIS8ZcPOLcjb2HSoHmOdNjwuwqplLafd13BzU3I0/cwvFNYNdLCNVv9kMwSgA/w1FADUBZzMOO48f+yMQwDcIso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8nGzcD/; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8nGzcD/"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-bc0d7255434so234799a12.0
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 18:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764211099; x=1764815899; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdsQqGwmcud2LexeDmZI2UjoCUAemH3F+RUmZbG91nE=;
        b=D8nGzcD/Wz+VULjdE5klxF46q6lIEMVFuVovGntrPgBluhQIYFwQc5qGpc6ahgL8uJ
         3ng+TiDkzy3cOzeqSuu1lEwEas1BJ/cC9SGl+P+1QojGkmk7qiFJA9IYE9M9IylZUYR3
         qOCWE31gCWzSj3tA5qb2eLKHBlAiworMrecbQxtLIkx+0/74yjo3gtVPAu11daaIjM5Z
         BVB59WYo9zrISV3zSrFeUykfvgO7YrSTCUyWMykg4J2YNeE+XsFZEvAuXgX3u1Ufr6wx
         3VQcvCfeAusEpeNRQLjoxXwiku+bykpXtIug1LgIiMtm3nKtP2EW2pCE8zc4gIa9Uffd
         rCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764211099; x=1764815899;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OdsQqGwmcud2LexeDmZI2UjoCUAemH3F+RUmZbG91nE=;
        b=Kbox2I39esE8Gc4w5slAAWvrwspV+T7vA2gBmVb9LPW/Fbsl6CqA1PrPuq3zHRsoih
         JbgBrNYI32HFUiNGprZkiwgVqz0hA4emCifHDxvV67N6fUeVXPFOmusAq8WPnbiZQECF
         qOWsKJkiFCCtxKF8Ee1K20h67vKSWxRb3wJ7aesE7hTRXEs7o1591vntBEB8QbHknRDv
         DloO0G0Lk0XY+j7bX7sFIi0pBAb/HPZyRpSOeFAoprgQFxE9XZfLn5+nw8O+BnR8W91o
         /CNNcElg91K2OKIDGLb3yI6HJO0BaFn7tlepHtMnL8bhI+YFWDMUJbmad/9o3XOSKfcK
         dnTA==
X-Gm-Message-State: AOJu0YwtCuUhiFgrH9Noen1l5NeoHZVCI02oEzYVRSOk2LJav6KuZky+
	4VbzMNFgX4i4SiNqB1PeQwPgOW6gQqTg1/PFdXcq2k8IAcckeQyjaZ/TKTxYtb1O
X-Gm-Gg: ASbGncsW+aEzqWI6B7zrH0quR2g2EHHWqFA1SC148sU/bA8v/FmjQedQOJSVDXc2pYR
	wl01ryIWRHfWjHito5x2obXX0QiRPyD/2lSsYzfKFx6ziBcWCFndgFa+a6ONNsHzbrO5UdYLt4x
	ZtCOOSrb/CanSmU5rflI3a9SsM8aU/ySmXmFScfl4WovDtwZgoUj+cxznKStGA7aPSDqGNu2pjF
	kGZyCGTuB2JtV60LQc1LAjXlb5+aWALf03Rqq+WLeXZOKEG8FLwcyN41xlRxLjIXHhQGT0XndCM
	ooNhEcUHFPdHAfPXHxeuS8RJVJZ3F347OQ47jifDWJjyISLz6j7G975XZPCjOU9EAUF7YKAzzvy
	QRCSMjdTmV0p7co1OsVOM2h89eeLpu4rDcvBpURJp+rCwap034lamD6PEf8x2kHFHU+pLLPnjzB
	7kJNPY0L6gmQQnRWMIPJJb5A==
X-Google-Smtp-Source: AGHT+IFd0vHMCKba9tlza2c8ZijaNQuugbaPUGbXDXUUpoB3HR9nb/CpufifWTRNKy1LrVCCBvQAsw==
X-Received: by 2002:a05:7301:5795:b0:2a6:a0f0:d7c1 with SMTP id 5a478bee46e88-2a9415a402dmr5685020eec.12.1764211098814;
        Wed, 26 Nov 2025 18:38:18 -0800 (PST)
Received: from [127.0.0.1] ([52.234.41.68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a965b1ceeesm1537240eec.5.2025.11.26.18.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 18:38:18 -0800 (PST)
Message-Id: <da99bb0bcd8c92e0d6de8b929b67095fae251f88.1764211096.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2000.v2.git.1764211096.gitgitgadget@gmail.com>
References: <pull.2000.git.1763201865025.gitgitgadget@gmail.com>
	<pull.2000.v2.git.1764211096.gitgitgadget@gmail.com>
From: "Scott L. Burson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Nov 2025 02:38:15 +0000
Subject: [PATCH v2 1/2] diff: "lisp" userdiff_driver
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Sixt <j6t@kdbg.org>,
    =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Jaydeep P Das <jaydeepjd.8914@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    "Scott L. Burson" <Scott@sympoiesis.com>,
    "Scott L. Burson" <Scott@sympoiesis.com>

From: "Scott L. Burson" <Scott@sympoiesis.com>

The "scheme" driver doesn't quite work for Common Lisp.  This driver
is very generic and should work for almost any dialect of Lisp,
including Common Lisp.

Signed-off-by: Scott L. Burson <Scott@sympoiesis.com>
---
 userdiff.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/userdiff.c b/userdiff.c
index fe710a68bf..e127b4a1f1 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -249,6 +249,14 @@ PATTERNS("kotlin",
 	 "|[.][0-9][0-9_]*([Ee][-+]?[0-9]+)?[fFlLuU]?"
 	 /* unary and binary operators */
 	 "|[-+*/<>%&^|=!]==?|--|\\+\\+|<<=|>>=|&&|\\|\\||->|\\.\\*|!!|[?:.][.:]"),
+PATTERNS("lisp",
+	 /* Either an unindented left paren, or a slightly indented line
+	  * starting with "(def" */
+	 "^((\\(|:space:{1,2}\\(def).*)$",
+	 /* Common Lisp symbol syntax allows arbitrary strings between vertical bars */
+	 "\\|([^\\\\]|\\\\\\\\|\\\\\\|)*\\|"
+	 /* All other words are delimited by spaces or parentheses/brackets/braces */
+	 "|([^][(){} \t])+"),
 PATTERNS("markdown",
 	 "^ {0,3}#{1,6}[ \t].*",
 	 /* -- */
-- 
gitgitgadget

