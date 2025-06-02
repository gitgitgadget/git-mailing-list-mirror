Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F55223DED
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 19:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748892445; cv=none; b=iU55Ob8ccBU3IJwLyQFGQg6SDnVnTN/gqUmWfwIACmcZy+u7G/PTEbcIynj4IHvMVUQHJu9cwzM/q11Ai4kEJXIBBBKf+WvpZjy90wW7x+7zUyM55PoerclCOsfHBMR3CjgJ2Rx9HCEn5VwZnBxUjdPgPMCR3smYA6ocX0bmDYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748892445; c=relaxed/simple;
	bh=IOGfjoTI4vlDyihWBFUcdKHQp0oqzKlj5irZJuYQAd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdFDSoU7h6DkXt0la+nwJlSgp+4csrhfK7+0dV+M9JvbP8EMeUZmcPRfyxZBvcyjU7sLBg5X1qwQO53uU4Nc5W6pAUq+81Rw/zyRad0MsY6jbP/ysbvfqxVDHYd6wY1Q69jPKYOEnc9+ZaJhdhsBTJzW0KfRZ+qm+Rgf3WZBkNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2xi6SM+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2xi6SM+"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-747d59045a0so1355594b3a.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 12:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748892443; x=1749497243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1KD92crQ4HXPVB7HH8CljLDTe/ySRyrhsUMDqSkaEQ=;
        b=I2xi6SM+SrT1+tiDDC8PN73v7Zfv3+2AcFqLieFZRLz+vc3JGLqNs8QJmCLVsF90O1
         xRSwQ/6CfCIPDkby4Cu//tr+IQZh/H6e+2rOhx51JKJTiBqkrLwu8nXSwO/gQ7mEx2BK
         zEV0mKaMGIb7DYIqQ8J0+y6eXefn6wi/ETFSOIoviml/CXypbSvCOdfgXNkbw9GEZUkw
         JF7bYWr5lIYaucl+cKMeBiZEiWTryWhBS/YQzatwPQh2qOFAbm0ct5Uw+nho6Ezws3vc
         RAUBrdJ9SBGm/dG5evg/RcC1TaRTgMPr/yGZNaJK4l43mAD0EUSJmmACsKmHF8OUiBwi
         bHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748892443; x=1749497243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1KD92crQ4HXPVB7HH8CljLDTe/ySRyrhsUMDqSkaEQ=;
        b=pEYXeskJLUtY8DYsueMQaRTaJnvkLQVaUD6lCQMo7QBswGk75D92qYefQg3lyoQTpk
         dDt/TUNkCpnMOFbVXez7+yiBNF20FGFOHgieH02DPdQQkjfO4R5clsGpcxmp0w8N6Xm3
         cHZ4xLfFm67lCPij/jmNvkrz+YicU1h4M1wwwgX+9uFyiNNFUwQ3g0hc0m+i1n1j9nCL
         9C/beboFgafoRd2VnDIYjet+ErAZk52orRD6SuK7d+Vw359tvYEiIFDXCR/mx/n9+jTQ
         VK4fbfkf69YiPXkwmJVQauhVzCQHDPzc9wRfBrSiWlEIpGiMTcYhi/8dQ8chNZNPCFYv
         ShNQ==
X-Gm-Message-State: AOJu0YzfsboA4jO+XjAdEH8DQ0bQ4dRZM05m4Hgy01hm+M+9IHqRN9QH
	T2sg6Ba06M8TF0KnJ5Xw9IqYrylaFOIdDFnOYADCEzOOuvPi1UjF9ClfWnxZSA==
X-Gm-Gg: ASbGnct5alPnm8UDbgis35Rb+Lto8G317oiGgJd/dusyu9zvAH1Qi0eZ9RnPdpR0XR3
	xusw2jEC8Nb3Dd9rR2ly/txMEli8C4vZbllN/Sod2lSxUeCHWppPyxE2pWgC4HHRm+ohggVKfa8
	MBuV8BisTeGwyUC5ZyrRE5q2aW9BS5Dfka3qVslHAl6p8vVbpQ+rMhBaX6XSPvEPr1BfSXAqdCx
	gKbFd+gTU1ibrVRo43pbnL0RytXHZTjV0K6XcTsYk9sg98drBftRgWBbj/XXvItQDvb2epOi8ZQ
	rWCeEV9LEidIZ5lrzrG1GNpjZux6KZas4w==
X-Google-Smtp-Source: AGHT+IEoLziB1WcV3XT4YcEZqnjLgH6qvRrv4tsiC23mvXKxdAs+2ModVDvMaImcmVsEMT2mmUNy2w==
X-Received: by 2002:a05:6a00:189b:b0:736:8c0f:7758 with SMTP id d2e1a72fcca58-747c1a7f839mr17484300b3a.10.1748892443364;
        Mon, 02 Jun 2025 12:27:23 -0700 (PDT)
Received: from fedora.. ([2601:646:8081:3770::9eb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeabad9sm8283031b3a.51.2025.06.02.12.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 12:27:23 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: git@vger.kernel.org
Cc: jn.avila@free.fr,
	Collin Funk <collin.funk1@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] completion: Make sed command that generates config-list.h portable.
Date: Mon,  2 Jun 2025 12:26:47 -0700
Message-ID: <1ff542bb1090cc5185644d6032addac5cd0df402.1748892261.git.collin.funk1@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <0ab924839df48d869682bea1b0cb400f378ca6dc.1748889654.git.collin.funk1@gmail.com>
References: <0ab924839df48d869682bea1b0cb400f378ca6dc.1748889654.git.collin.funk1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OpenBSD 'sed' command does not support '\n' to represent newlines in
sed expressions. This leads to the follow compiler error:

    In file included from builtin/help.c:15:
    ./config-list.h:282:18: error: use of undeclared identifier 'n'
            "gitcvs.dbUser",n       "gitcvs.dbPass",
                            ^
    1 error generated.
    gmake: *** [Makefile:2821: builtin/help.o] Error 1

We can use a backslash followed by a newline to fix this.

This portably issue was introduced in e1b81f54da (completion: take into
account the formatting backticks for options, 2025-03-19)

Signed-off-by: Collin Funk <collin.funk1@gmail.com>
---
 generate-configlist.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/generate-configlist.sh b/generate-configlist.sh
index b06da53c89..e1f9e99488 100755
--- a/generate-configlist.sh
+++ b/generate-configlist.sh
@@ -19,7 +19,8 @@ EOF
 	s/::$//;
 	s/`//g;
 	s/^.*$/	"&",/;
-	s/,  */",\n	"/g;
+	s/,  */",\
+	"/g;
 	p;};
 d' \
 	    "$SOURCE_DIR"/Documentation/*config.adoc \
-- 
2.49.0

