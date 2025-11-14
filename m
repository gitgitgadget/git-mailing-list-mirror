Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09A72FBDE4
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 22:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763159824; cv=none; b=TRsioUiRYxrbJVojkDcRmXjvbnrtVDeQAQuC40ICpfFIWsbOdzBLKhMVgYOXGwzIrs2AV7jrM0lRTrlGXfEVNp5tVeyCo8p4dKNB/ZfoDzyTXTEy6osP3Iw7Yy7qlG8iMlgQlzsXX2M6qqmQF0z9TltdkDGZBwpGdgXjplBE4is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763159824; c=relaxed/simple;
	bh=jeJVuo8REtcyXkkjoEV0zgg27pOBBnqK/Z4hsC+Uszs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oowC0d+6i2SZSGgWzYU70Le/Z+tB3j7pl1gJUJGxRNeyDPRynwteKUDilzbrIyGdmkPhEeJwo54FVjH5R48aV44dXQhK27z3H/5bVzTaJRrBFQnyx8wRCPRi22RDLY6EY2KLJ3BdfM9llNIkqKxaAwFUTUJoYj78Bv0O722NqPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WY6L6JwJ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY6L6JwJ"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bc1f6dfeb3dso1402192a12.1
        for <git@vger.kernel.org>; Fri, 14 Nov 2025 14:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763159821; x=1763764621; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Is+Y4OtDniKKLO2QyFgOzpMa/iDGzBTXGW05qdr/U2U=;
        b=WY6L6JwJBELZxWIIGER5/xG8ksSaljunY6r9rvlKXcyGbbPkAGEdF+X/7Mte7/kam1
         G4Hs6vlDZdSRdX81FyFxw3FD3YKGZQg64lPYxjmuISTly/H4AKVuWlKqFm80HG7RsM9B
         3r8MfUBOtylzgzQcEqzOU+2JDvI5vJoz2xaH5Pubqpq4lAQQxgEClKbW0HqpLIoHsyeM
         nk20fmAOBVhjRLJNVD3o/qx4I7hFQnulwelhLaWE8/66mz/Ol8CMEgq60+begfyhbx6m
         cJUWQQYYh6mKGZI9Mizk290res7oS94+VxNQiv/dQLCbC8477Ett3g911z/oGSCyV+jX
         rNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763159821; x=1763764621;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Is+Y4OtDniKKLO2QyFgOzpMa/iDGzBTXGW05qdr/U2U=;
        b=veL1m40atTPL+Udtxo1GrnW88EMXhrtENsWA2I1IumbQUqzIqyUI5sa9JgNZRgVbNA
         qY1eao0KmncGzvFYMVaak4IaeFOWCO/NJuUr8lHhYN3Es4R7uU52Ub8tijpzb9xoTVf8
         QTn1Awzq1tPEs+vZPm8aZDdrSLW2wBTmG811eP4GoHn6xIsNDDGS7ebGuINff6ZYH0eB
         6orTB6x0TocEXwNV05Gpagz1QNXtobRQLWdSFrzob5IPk1lNtRVdqa1a5MXd0Zwji/K2
         d6Oy76fmkQMemB9H8VXIe94w+sKk5VPwDbXJzdDZspQf7muxQjliSEXVj96EJ11vClN8
         LXPA==
X-Gm-Message-State: AOJu0YzEbh0WLfr+JL3Lizhp/ODQkz7wljRZOcW3KyJ6qL6JwPYlao5F
	y7lfcaX7cSn590gfld7PEx3xDWkE7enBXuvIOo1qLwniOp1WsD/wE11DLn1N/uCJ
X-Gm-Gg: ASbGncuLmJy+PeNabFJI32HFSxl1HEA2xiBTemEPY61uZYTJg21k/sdMPpyZA4b+2tq
	Ay9X29yQs4rJghpS4S3Q8I7AL8kL6ziaiUMXG8wQsmoAe6rZIss6gZbz5Xt9+g67RWN0H+L12DC
	77JV7OiNrc8HE+bhrmrIi7VoM2tcJyAcmAwduFrjaiymjq0Z+q0LGf0BWEDuiwgOIhMoxs6b59i
	I1F0v3fJwHb8juSyS9hEqajBhu7gBUv/ZuZagYsG4nx1SWE2bHwmUwz3rl/fu+eCdkMX+xnT/ed
	XyYqbsPDjJHjQNkO7//f1DuRXd7/WCfUs8pX04ZebxHy5tMWpnmPC/kQp7rjkPJ+tyNAvK+fE0T
	UTRsZXJg/bQmpvXTBo7+ANMqwlDLKV5dlZ19Q6/Q8JQF8nGqipyNEVVH73nv3SAwRulQEzQmUp3
	WaVg==
X-Google-Smtp-Source: AGHT+IEDD+qy4lvcQOrYHLq/IGtsdYUNyh1Cvp1ReeNo9tIVE73DU1lD1/MpKpmYIVsSh80aWlBFwQ==
X-Received: by 2002:a05:7301:4d0c:b0:2a4:5c3b:e2b0 with SMTP id 5a478bee46e88-2a4abd9768fmr1700146eec.25.1763159820538;
        Fri, 14 Nov 2025 14:37:00 -0800 (PST)
Received: from [127.0.0.1] ([20.169.73.145])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49db7a753sm13434418eec.6.2025.11.14.14.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 14:37:00 -0800 (PST)
Message-Id: <b60a03eb31bba747db546258e843ac94a4b70950.1763159816.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
References: <pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
	<pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 14 Nov 2025 22:36:48 +0000
Subject: [PATCH v4 02/10] xdiff: use ptrdiff_t for dstart/dend
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

ptrdiff_t is appropriate for dstart and dend because they both describe
positive or negative offsets relative to a pointer.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xtypes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index f145abba3e..7a2d429ec5 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -47,7 +47,7 @@ typedef struct s_xrecord {
 typedef struct s_xdfile {
 	xrecord_t *recs;
 	long nrec;
-	long dstart, dend;
+	ptrdiff_t dstart, dend;
 	bool *changed;
 	long *rindex;
 	long nreff;
-- 
gitgitgadget

