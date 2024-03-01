Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1D052F7A
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709278859; cv=none; b=gRxkt2SPZlzOPCzNZ3LpIudcOnIVqWI24mxY7M+3ONa7dwGErrEtVB/yS9+qZuQM+5h2nZP2B3ox5Dg0Ku8oYcLYYyzQKg70z6UNA4Ha3FU/Ey/6+pNu3h/aU9zkUP7M7WRHqwTFwMj5zfpGJhk3mOKKQSnBIBm2YgMVRTcQfoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709278859; c=relaxed/simple;
	bh=Y3gmv9QirTvMGSfd5jmT7mgpiKzfcCl1xAN2FPXu01U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/sHgONrignb9HvVAtHdDzPYMlNOkYHK3Uw9l7WjdSbhCkwZfoDz27bmmE1XxM7NyU7qmbOWs9DmAvhwaHo5NhSTNxIoX5y1D4ciUBrKh93wC9q60UZy3Ewfr7GUoBNHRoRuZN6lZTWCLZv8ue4Q1ocIXJnFGcq1Xf3BH7SUDjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpLhx0PL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpLhx0PL"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3392b045e0aso995673f8f.2
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 23:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709278856; x=1709883656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0xgFkK/IjmqXZZ97rcH9A5bgqoUtICBDMREOyhk3s4=;
        b=DpLhx0PLkWkAjPrSLL+TUvHlzYmhxARDN9hv/BAu3vOoxhkS+g0GiFkYQ1rC4LRp2q
         qwKfxq+GblnM0T16XciFW3OsSP18BxMT6YPYFl0Tsnnr4Uue5HL38ApM9IMbgL9vnLV7
         6a3q7xjaD/MjARn7KS9vKobqe0CmQtqcAVDtELYNH9fXzE9++fI6Rlk14teqkvQ4ajij
         xiuejf187SuGTGl5I+STHcOGWIV5Xfa6O04g26ItUTwKSyYN81op6uArMZS22F7+ZV0D
         53yCYZfozO6AXb1dL7YJsx9b/EZTauWNYDUna25oO2UqlosrNrnG6wI0tFWF8g2WY9GD
         Osrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709278856; x=1709883656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0xgFkK/IjmqXZZ97rcH9A5bgqoUtICBDMREOyhk3s4=;
        b=pR3+t5Q6l44eTld8FcbP3gUsq9bIvPm8ZRdP3QKN2+P/gIbyoML+9bqJhffB0Q3uDB
         wv4Ak1WAFr82WkxZP+y54fQDBarm6LW8ShMf7ovqRdDqEcA2fs3sjiMxNO/xTUlVt5Hp
         AiSukMqsUhWmFDkZWH0JxeWDMn1UPzjCWe0COuC/5297h0UxFGUNrwF4vDWSGJlOmXk+
         DIG/IJ1PEdu7MGq45JOiMwe8618xgx4JdfztuwPk+i3daJsLPjRQ4hsa5BmoXbdM/Ws+
         tgB9e/KLrHU5HPUoWHHoVlhkapE7T4vOT/6YaYpxLv6wZt0n3tduZA4+aFAN/uaHRi7z
         bakQ==
X-Gm-Message-State: AOJu0YyO0mvP2VoE+Wbuf9rUTbTpdF6BxfV4O8AQcYb8X/NVKcBZQIMg
	12bVfikaWu7L0UtjA7Zw59nhHDEWGef2/AnofDStFtQ9rgujpBcQ2/Hxoc0t9hs=
X-Google-Smtp-Source: AGHT+IFfO7kycOAZPfy+oJc0BOEI13uspIen4JowgYqfxgwv+LMFOzeBLrEFxPQumi51UN9RGJk9uw==
X-Received: by 2002:adf:ebcb:0:b0:33e:12eb:7822 with SMTP id v11-20020adfebcb000000b0033e12eb7822mr579465wrn.71.1709278856010;
        Thu, 29 Feb 2024 23:40:56 -0800 (PST)
Received: from host-sergy.. ([154.72.153.218])
        by smtp.gmail.com with ESMTPSA id f10-20020a5d58ea000000b0033d4cf751b2sm3811064wrd.33.2024.02.29.23.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 23:40:55 -0800 (PST)
From: Sergius Nyah <sergiusnyah@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com,
	gitster@pobox.com
Cc: pk@pks.im,
	shyamthakkar001@gmail.com,
	Sergius Nyah <sergiusnyah@gmail.com>
Subject: [GSOC][PATCH] userdiff: Add JavaScript function patterns
Date: Fri,  1 Mar 2024 08:40:48 +0100
Message-ID: <20240301074048.188835-1-sergiusnyah@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <xmqqttlsjvsi.fsf@gitster.g>
References: <xmqqttlsjvsi.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a patterns used to match JavaScript functions.
It now correctly identifies function declarations, function expressions,
and functions defined inside blocks. Add test for corresponding change in userdiff.

Signed-off-by: Sergius Nyah <sergiusnyah@gmail.com>
---
 t/t4018-diff-funcname.sh | 22 ++++++++++++++++++++++
 userdiff.c               | 12 ++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index e026fac1f4..d35cce18a0 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -120,3 +120,25 @@ do
 done

 test_done
+
+test_expect_success 'identify builtin patterns in JavaScript' '
+	# setup
+	echo "function myFunction() { return true; }" > test.js &&
+	echo "var myVar = function() { return false; }" >> test.js &&
+	git add test.js &&
+	git commit -m "add test.js" &&
+
+	# modify the file
+	echo "function myFunction() { return false; }" > test.js &&
+	echo "var myVar = function() { return true; }" >> test.js &&
+
+	# command under test
+	git diff >output &&
+
+	# check results
+	test_i18ngrep "function myFunction() { return true; }" output &&
+	test_i18ngrep "function myFunction() { return false; }" output &&
+	test_i18ngrep "var myVar = function() { return false; }" output &&
+	test_i18ngrep "var myVar = function() { return true; }" output
+'
+test_done
\ No newline at end of file
diff --git a/userdiff.c b/userdiff.c
index 2b1dab2649..bbe2bcb9a3 100644
--- a/userdiff.c
+++ b/userdiff.c
+PATTERNS("javascript",
+      /* Looks for lines that start with optional whitespace, followed
+      * by 'function'* and any characters (for function declarations),
+      * or valid JavaScript identifiers, equals sign '=', 'function' keyword
+      * and any characters (for function expressions).
+      * Also considers functions defined inside blocks with '{...}'.
+      */
+      "^[ \t]*(function[ \t]*.*|[a-zA-Z_$][0-9a-zA-Z_$]*[ \t]*=[ \t]*function[ \t]*.*|(\\{[ \t]*)?)\n",
+      /* This pattern matches JavaScript identifiers */
+      "[a-zA-Z_$][0-9a-zA-Z_$]*"
+      "|[-+0-9.eE]+|0[xX][0-9a-fA-F]+"
+      "|[-+*/<>%&^|=!:]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\|"),
--
2.43.2

