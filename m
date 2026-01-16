Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4273026F28D
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 02:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768530596; cv=none; b=mp6AmK218UOFVA8TYz70APodCF/FBz7d4KAUOD+/z8vzs58iamXfqH3WcG1ZlBDBNLRidg5DXknS7yBw7H8P0G5eS/jthE1pX/Avcy+lxlqtxCa3m3taP3V4EpxXZjJWRMpM2Sh+fmBjzjeKm5moZLxZK7iRBguAc51dckrB6v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768530596; c=relaxed/simple;
	bh=D1Rvxui1lomU6/wq2dILUNXBUwnlOcUfv/evV7c+gUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UPLHGY2L0uAewyHDHCMAtL4D7G2meGwEUZ83+9g53OQe+t3JXkZyDPMM+mu7X/jyzXgMtI/J6th55Y2A9wMAZQgGF+/psiu8a9WnDMM2BXiNlFZQaZ3oLY2G8bFyn+Ey0VtsvvNS0nDcMwd5XihVqvC5oGUvQ0DiH3wo3RbIhk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPMsJcYq; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPMsJcYq"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-640e065991dso1386476d50.3
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 18:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768530594; x=1769135394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6eFn5Jnk/iG2MVP0gdaKrjt0FiKm7aNqIP5DX1o9WwM=;
        b=DPMsJcYqnScWWy95h/BDG8p9ypE5jgyif5Hl6HHqlm+6nDVfBe7uJ7XeyWwOFYlUag
         CSuhmyhduDY+O9Br4A1BBTNLezEx1bD3GOrBlBPjS3WF2pDdnEUjAFG4C6pIyayKVJgC
         9qKdffFSiJFmKzQB92yfCYyYCiILKfRmLhP9MVmuYDYTXtoPpK9avawg04YxU2Tb8KOV
         vF3RoGgxw3Wdf0TsZnpFTRkcuFcg1twpFtFPkon/JXsZvT9pTO9NDqM0b+zO1qatR+Qp
         nfQMRlvaAjLEozuqUlBSnYgeX4htWlGF3aB87t4ZvFkav8k76oVaHnmUajpJqfYpxKn3
         XYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768530594; x=1769135394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6eFn5Jnk/iG2MVP0gdaKrjt0FiKm7aNqIP5DX1o9WwM=;
        b=JHaxX8elkOn+TeNbLj0DBHWTYrDy7iu6wGU7kdzWg3hsWr0kSmepQwufqXWYPhuiGG
         yW9m9BDB/LorRy1SNmABIUfeeoiynJ/R3vO5m7ltsqpP9eiRcIexDSUl3jVFEyBSm6Sz
         r4eg70a6WqUQgsV/QtCnxTxRTvcnLXAVvkIUfY3gRhaTO2eN7bhfZcCE8GrriF36SKoM
         wqmWN80aBgZDc/ZbUYSysyFSZZn8IPNitg3Ar3IfMMyU8nSav+otaCGhPFOq9clR0Mac
         wS4VrnPgmWk6kTvJDNr2aC0RX3y+HQE/T8xhIcaRXGWf66ZbX4T3vRXGw6Gv+OVNwiE7
         0Z/g==
X-Forwarded-Encrypted: i=1; AJvYcCXSWB1fHb00DS/CVOPejqXMNCetX6/RneAcFz0fOPgahv1k62eAH51asUe0NFkMk6LpoLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YySTZLA07UKJPv9YfUWJLKR4YCDf1g3aAG4EJHgMwFD9sizZoir
	S/lEwnktZWiBiuBMThsAaSGo8a3qCL2/zZtvVDT0zL6D6z1xeXfxX4wiL+BA0/Py
X-Gm-Gg: AY/fxX7HiQ5Ywo1WqEmMGynNi2Y73SumgoEl63tEWePp1QVyAADtjRbM1wI9yewBJSo
	9PYltEj8KXCF2wnXPb9qZIGN2+ugZrSHzbuh5vMo7+O4xTQYZNIBwqtzJ+cmwsUvf7qKpN+qTDn
	vq6dko1OxAb2owJg2pkolL3vdNmbH4JHX+b2G7PtWpCvCRuWNzYjj/wvLZdebUhIGhg9wttgaEs
	3Uofkp0MQKODMzx3GqLwg34rGqIkHwsniXcqseKabA1Os+vDFbIxmuuel27JG/StgOw7s0mR+TH
	W7JDMpmXnDSRIx9qzcBshklT9WneRtFKqwc3UzPKuf/OK3Xmioy5AxpfZ7c/YaIoB8p8cgYeHhF
	K9n/WF2dntVnjVEaJ4IN65OskZkumBnCLeKKAUFlMc95gJJLQ7Chfi2T2Uu+M6S5Soe6pKiBa7G
	lKR6nERr9PdSrCFfRPRG+2OH01MZFpTOJU6tWa6aRaAZk53jzB2kJRa7j3u/RmKsklWvcegZ2WU
	SiW8lsSW7SFmV+MxtrK74DqQw4nKs00vq/GnkarKRziGGJa9SHVTwWLBBjmYhw8WZ3mSAoNr8k=
X-Received: by 2002:a05:690e:1589:10b0:644:4259:9b63 with SMTP id 956f58d0204a3-649164b01f2mr1206767d50.41.1768530594115;
        Thu, 15 Jan 2026 18:29:54 -0800 (PST)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649170ac7a1sm584205d50.14.2026.01.15.18.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 18:29:53 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH] help: report on whether or not gettext is enabled
Date: Fri, 16 Jan 2026 10:29:40 +0800
Message-ID: <f3500e698fd40297d2e2634785529b76d49ca470.1768530514.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.51.0.rc2
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
"gettext: enabled|disabled" line to `git version --build-options` (and
therefore also to `git bugreport`). The status is derived from whether
`NO_GETTEXT` is defined at build time.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 help.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/help.c b/help.c
index 20e114432d..96d70d8e6c 100644
--- a/help.c
+++ b/help.c
@@ -799,6 +799,11 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 
 		if (fsmonitor_ipc__is_supported())
 			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
+#if defined NO_GETTEXT
+		strbuf_addstr(buf, "gettext: disabled\n");
+#else
+		strbuf_addstr(buf, "gettext: enabled\n");
+#endif
 #if defined LIBCURL_VERSION
 		strbuf_addf(buf, "libcurl: %s\n", LIBCURL_VERSION);
 #endif
-- 
2.52.0.435.g8745eae506

