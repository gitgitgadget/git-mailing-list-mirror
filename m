Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74096215F72
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753949271; cv=none; b=kcPI9yRdEzqPMpCKKqsk6UmXchUF3qr4TGkEpv/9baYsdJasv6C57wsR4Xg6uokfoTO6fWlROGUSKkNTZynjtC/MbES9TtPdVaVfjwjtbUKGBlrVK2XvU56P18SKgGp75xZRvqE8IMjLhm5smz7X7PzHgHyKlsjjeaceYHaAIgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753949271; c=relaxed/simple;
	bh=1bTmHsK8g8z1Wj76D9eC1Ui3eas4A+2nnswZqxkNkTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gW9noKI5cHZODzUc8Mmzw6nKdTeRWTRfpCyaBXVSwJrj9rUwFxP/OXm27G8dVHH+waUdJvdUG7vz6shQCkPH76/qOSseAAy903u+4D6sUNrGBS8cBjon3X8iTBsUdBc6EaDaHzL/sHDnRl+gGxWW6VgTq3s3g1fTc9mlGjcN6hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LB77QuA1; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LB77QuA1"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b42099901baso93152a12.2
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 01:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753949269; x=1754554069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKqkuxEjtdBrT1THHfge6c+kz3ynvLPbVG1z0g+VDWg=;
        b=LB77QuA10RSGqwzZ3GPBdZKGs7c++S/Qwh9p1RUPDRDSIjt7tr244U88kT/xQMISr1
         1Sml/8TDhYX2Uz8cD0N5INcAwGkKbsSCXuwMJd7iKz3NEGWeyxV9HNOvQ/hsq7rhFmB8
         XmJ4wBqOkqEz9AJ8SuSclDR+68XX34jsjr1S18KIJaPE/3hL+waOXgUoXgb4BpqPt+6F
         jYTzpJQjhoVW4q+ENsikTYDQsd7QM6KeH5eSKZ0lAMcUqBE4DNET1qiwwxwZDQrXY33i
         H++6xySVz0syPI6easgxKCmUejgokLlCH8zkEgDU7Zi7AtYpApt4vYjpBPsE+fzoIcGa
         o5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753949269; x=1754554069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKqkuxEjtdBrT1THHfge6c+kz3ynvLPbVG1z0g+VDWg=;
        b=JQiyLvLNZPDUBXpT2UfSz0RMeUqCshjTDnuTLz1ClKo879phs/ciNGCaN0QADXCCTm
         YD9XAB8IQn/WHVYy4fwjDhQuRp8jqKXWeTFw3IlQYnR7F8KaCbV1ghvPOZhJlDkWD2gm
         HeRtj/xre04Hxo1D7V+ziGJ3HNda0M+b1z78DhvLU1D2qyUlKc26MNUn+SNV5Qtrmh+g
         JpWrlwv5TVXsDVj/qgkHAddTi5AKPETvNvpNd7A++vzUv59BOjDGGk3Uadki7Gm1YrSl
         JtDQyBwXuc1B1mcPCkoZkddAA/BwZtnVMtdziTKwY6iCMd+/wXYrKqTt7qiIN92iTgHv
         R2lA==
X-Gm-Message-State: AOJu0YwW6+B8KV/kTmd8UNN8KRIb0vXJyq6zTpqIIR+qK3ISBx9+1ZwB
	q3eT48+47wNTW5fWQ/1uAUK2OwDWy0nux3ipVvcmADdEolduC8JkEDHFyuqxsw==
X-Gm-Gg: ASbGncu26pyfvhNN+RyVPGDo3JySB5CxZObRL40yxd8MU2xQL7t/2oHQevRnZpr94vc
	BkAr/NXtk1Jx9tZC0WuYXfo7JKTJzmL6jJ39oAssc67vsRTKIvqG3gCBc/6YMYYL13iVWdQCgKz
	KXG9J3czJzct5oAfc94/HhxS/UWboYrPgI4iiS0ePQ2FRefdzS2OdX/Bb4HyLsPezrxi4D75WNT
	aLi5CaHEZFDtBT1xOG7nT2i08/HxDmQRH6jFqCAGfHeTFhQcgi+Nc1+y7atGonsj45k+F6NW9Hg
	Zrsa/gG2mtD1Yqc4Y1jr75AN+EJbSuo7QuJwfUqrRNVrOyJUzj0FszdaVE+QJG7EJGOQTLKCUzF
	xDLt2ByZ3TOkuG3c30XFb7MrX5aWz5zOJ6/adT1H8/e+V9UXdy6w7YQxg1reB0AZXkzWY31ev
X-Google-Smtp-Source: AGHT+IHgC4OOiGoUUXhCHzHijdYwu9o60K0ZowMzczrOlcekQAmw2NZg7goID6aQYfsVnXi2ceKqMw==
X-Received: by 2002:a17:90b:5285:b0:311:9e59:7aba with SMTP id 98e67ed59e1d1-31f5ddb7e9cmr8444625a91.2.1753949269254;
        Thu, 31 Jul 2025 01:07:49 -0700 (PDT)
Received: from localhost.localdomain (c-73-70-17-6.hsd1.ca.comcast.net. [73.70.17.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207eba6b69sm1237309a91.2.2025.07.31.01.07.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 31 Jul 2025 01:07:48 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	johannes.schindelin@gmx.de,
	mlevedahl@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH v2 2/5] git-gui: fix dependency of GITGUI_MAIN on generator
Date: Thu, 31 Jul 2025 01:06:25 -0700
Message-ID: <20250731080628.27917-3-carenas@gmail.com>
X-Mailer: git-send-email 2.50.1.475.ge15fa7359c
In-Reply-To: <20250731080628.27917-1-carenas@gmail.com>
References: <20250730164052.15371-1-carenas@gmail.com>
 <20250731080628.27917-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since 854e883 (git-gui: extract script to generate "git-gui",
2025-03-11), the logic to generate the main script was pulled
out of the Makefile, but adding the resulting generator as a
dependency was missed.

If the logic changes, the main script should be regenerated, so
add it as a dependency.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index a87dc06..179857d 100644
--- a/Makefile
+++ b/Makefile
@@ -168,7 +168,7 @@ git-gui: windows/git-gui.sh
 	cp $< $@
 endif
 
-$(GITGUI_MAIN): git-gui.sh GIT-VERSION-FILE GIT-GUI-BUILD-OPTIONS
+$(GITGUI_MAIN): git-gui.sh GIT-VERSION-FILE GIT-GUI-BUILD-OPTIONS generate-git-gui.sh
 	$(QUIET_GEN)$(SHELL_PATH) generate-git-gui.sh "$<" "$@" ./GIT-GUI-BUILD-OPTIONS ./GIT-VERSION-FILE
 
 XGETTEXT   ?= xgettext
-- 
2.50.1.475.ge15fa7359c

