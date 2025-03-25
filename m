Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D2B74E09
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 08:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742889719; cv=none; b=pXIyXx1j7AgIWxHsem5P2eM09ofVT+VybyZqvl2JHJGMAC2dk7UTbl9HIcICB7SXr2I4Q0W+rbp9QtLSz/8dfI4k54o7X6BDOIyd5MHwzaF7/SxcL9hefkrl6UK4jLbt/0wahAuiLt5lMeroSwykRisvJ2pWDPQQ8U3a0v9QYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742889719; c=relaxed/simple;
	bh=5eDboXlLY48klQSRh7ROAxKsGF5oZ0kBcpqQ2u9roxg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tCreiOrIzEMKllRIcqy5chESltlUF3evyv3eJSqmPgWYqmNRwOYyh0GhjcqGss8mBzBhsTlofuumqoGhsWPSnmixkcZR8aSQ3urXUceTrnNaTWn71zbdv7O0MUEj5kua+MKjbXnN51gfDMmvHGK6sERKpkS8uVNRsLr4RVIZcWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7cj1TgE; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7cj1TgE"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3913958ebf2so4224793f8f.3
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 01:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742889715; x=1743494515; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nZguIGcg25DdMGIUwc0IS/mZSObQwqLnttu/HYceu4=;
        b=R7cj1TgE8P7roiDzXXWZS6oFG87AenCNtDi2RqOVuC3pm3sWTZk6Jpsw/pDZGxtvZm
         9upZlcZm9J7lYErUOBC3Rr3qFnPAfmucLCNs4RHgyXZZlawPbcjxdqbwwJAK1xM3/bYW
         MafF5mUS/u1DFmH+coEvHKbsXiO2gl3Z2tgYX1qbuCtdPYTOEaeae4bgB/TmbBsWzlJt
         jTzTKQ9OB5LF4uIlcwk2w9qzV9KjUU/fpaHutdL9NY/eMfUVQyinv4jEESKzPiNO2nKP
         uizJ19nzndKeJ6mbr6BVIzheAoJ0AN+IPYPCkuih4NFDmy+L/E8O6W5uZI7JohdOfNKU
         oFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742889715; x=1743494515;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nZguIGcg25DdMGIUwc0IS/mZSObQwqLnttu/HYceu4=;
        b=nEWae1zmduK1TVKr/oorK0sLXn08/8cXJFKATYf26rcAiocUC8c7AWVluiaS9jc/nX
         rMJ51Uwf+4ScFdpYm3+n67yDUD5rGrr8B9GtxSOQD2Ix4FkvYxKLIZsSwPeYDriReLFK
         7qu6bBZtDWnPuDuvpz86k8SbGhdu7NHEme62wV8vXbp70G1dWxUZBvEtoWFgfFhdm7FO
         Voqu6Jtwg6ANPYV+c1+XaTIaQmuUpHa5LvckiU7jRx0o8BF+YwD/W088nqx7XUvKpaHf
         x18rOqPa24k8deyaZwNKcP6gfAor2wUP7U3EO9Dv20zHA++kL14yjWDfs31UrRpnwQtC
         zWnA==
X-Gm-Message-State: AOJu0YzLyrvVnKYL8IMUuwS8Qq04HQBb4jOTCAWOV/Ozs8EQZ8ZOjBI2
	kwmlfGpmf+W3uRnlYYvHqP4Aol5/OR4Nq8WIw8dAqLNzTxqwRCxuYPrwqQ==
X-Gm-Gg: ASbGnctoC/WLv6cBVL04l8CpdUg52UBM4WnkfZLcRWr9BUXUeHwziZni9hOVyYU51bu
	RjPOGztZBxzLpUYX0FNhVnzwAbVEhCyAm5ijVFaCd3uL12MkREEAGRWs2cpD1FgcItzuKjzy5tK
	laob1MrOJorZJFzktqMc9o0Dhx8qVRZoQgR89IOJlcvCBDjJCYPISIleDed1zpK9kvG6cb9r3cr
	h7vTtcKPZtER2HY99D+LZ3ND8uWdUoXmi128UEWQqhfn/5n1C4e1p+FOxRzfXNA2on+rIb1l2HQ
	JKrRjiLvD33eATN+94DQ8V20kTWZnJQbcj4WdXmi7qluFw==
X-Google-Smtp-Source: AGHT+IGitkX6SrsXjRZDMQevMRlrV6q3/xvvMjzPSGvga5V05t15VxPXUicG4zSeiI2u+ulkKCU1PA==
X-Received: by 2002:a05:6000:21c2:b0:399:6d53:68d9 with SMTP id ffacd0b85a97d-3997f939949mr9890245f8f.38.1742889714750;
        Tue, 25 Mar 2025 01:01:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd277d5sm144406435e9.19.2025.03.25.01.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 01:01:54 -0700 (PDT)
Message-Id: <7dfbdc48954b55a435c8cb429b648d77a1a9d044.1742889711.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Mar 2025 08:01:50 +0000
Subject: [PATCH 2/2] rebase: avoid using the comma operator unnecessarily
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The comma operator is a somewhat obscure C feature that is often used by
mistake and can even cause unintentional code flow. Better use a
semicolon instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index d4715ed35d7..62bdf7276f7 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1843,7 +1843,7 @@ int cmd_rebase(int argc,
 	strbuf_addf(&msg, "%s (start): checkout %s",
 		    options.reflog_action, options.onto_name);
 	ropts.oid = &options.onto->object.oid;
-	ropts.orig_head = &options.orig_head->object.oid,
+	ropts.orig_head = &options.orig_head->object.oid;
 	ropts.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
 			RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
 	ropts.head_msg = msg.buf;
-- 
gitgitgadget
