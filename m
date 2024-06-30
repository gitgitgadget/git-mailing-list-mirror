Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F20E4EB45
	for <git@vger.kernel.org>; Sun, 30 Jun 2024 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719783241; cv=pass; b=Y1Gu5q8YuRlBmJPMkFnwMf6GEJTRoLQWju9P4pvX7l3VV8fwpBdFrysNnGkHxJiqKaLVQz25u9Ot0Byy4rY3crc/2spLr6vQA3UeO9Gggjpf5QxH/c/VGhkBuYh/2uiXo2p7DMOLPrpQ2ZJ7O9xVVp4UjlP9xnaQsEvaOAW2pS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719783241; c=relaxed/simple;
	bh=2JpsppeJlxUTSQvF6P/lGS0FLy5XicRlxxrmDgcuWXA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kz6KGHyIfGMVUSox//CYF56kgSKp2PqlhJxezPxNh/6LQM4yVYlYFMuItYNSuyR3lTqRnydcu9xdNrNZ9QVqBfDRucIyLcC3AjsKU/kXk7kyDxTnHMFIQZPl9S0Z90iud3gq45+TXoSKgXxIGLSCpPgHTUL1PYrb0GsTDZVVeuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=cX2fgOVb; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="cX2fgOVb"
Received: from localhost.localdomain (unknown [IPv6:2001:1ba8:120c:f201:e842:876:cf00:268])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mikko.koivunalho)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4WC2VR4bN1zyZr;
	Mon,  1 Jul 2024 00:33:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1719783231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Te7k+Jd5Kh39uBqgh0YpTQ6o3sbJd9j9ufcyHJyzW4M=;
	b=cX2fgOVbiDpfBwHzrT+T5tH4fy34FYmiY2A5PJbqovP4TBNTNtAvzbjr0bzQAwr9peuUHA
	zovxwW1zKaUs1KRzRo97yIaEawPxeqZsYYiEtFVMWGAYZMdMVWCEtcooc4aBzKvERB+M10
	I4byQSNRLqHEGsRc4+NLu6bXnOqDqnA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1719783231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Te7k+Jd5Kh39uBqgh0YpTQ6o3sbJd9j9ufcyHJyzW4M=;
	b=YKpJZuZiSvZamsdpBrTzlz8wfd5bhB938+65M0UqWuAivmhQCey+ABZVO3oUR5TPpsVPit
	bP4aOu4LW594q/YH35ITHIxHKFBTLsYQ+isIIOU5Yy5Lnt0FX/w04P9pCY02bzGOsW1c9k
	lV5bhyD1AGorJKupN2V+V3EMvPvmmto=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mikko.koivunalho smtp.mailfrom=mikko.koivunalho@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1719783231; a=rsa-sha256; cv=none;
	b=Lqqx3fo6eWDd3ksWjlpOVYLv5OhB2ZH+OMKyOufI64xSoShBCl2XynWIUfH6pMtErXn7RJ
	ReMtl/OlL+dhxZq6mQjAky7jsMXAHoQZZeRvuFA3Gf9BXkoQsLFa4OI+j9dNFj2bifV6hJ
	GJ8ur6Ah0i3HklCI6pxhYppByz1HLVk=
From: Mikko Johannes Koivunalho <mikko.koivunalho@iki.fi>
To: git@vger.kernel.org,
	Mikko Johannes Koivunalho <mikko.koivunalho@iki.fi>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Roland Hieber <rhi@pengutronix.de>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 2/3] completion: Add hook in Bash completion for commit message; docs
Date: Sun, 30 Jun 2024 23:33:35 +0200
Message-Id: <20240630213336.2212166-3-mikko.koivunalho@iki.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240630213336.2212166-1-mikko.koivunalho@iki.fi>
References: <20240630213336.2212166-1-mikko.koivunalho@iki.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mikko Johannes Koivunalho <mikko.koivunalho@iki.fi>
---
 Documentation/config/completion.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/config/completion.txt b/Documentation/config/completion.txt
index 4d99bf33c9..5032eab5da 100644
--- a/Documentation/config/completion.txt
+++ b/Documentation/config/completion.txt
@@ -5,3 +5,14 @@ completion.commands::
 	can add more commands, separated by space, in this
 	variable. Prefixing the command with '-' will remove it from
 	the existing list.
+
+completion.commitMessageCallback::
+    This is only used by git-completion.bash for declaring an executable
+    or a shell function which will be used when user types
+    `git commit --message=` and then presses completion key (TAB).
+    The callback must return one string for commit message.
+    This can be used when all commit messages must have, for example,
+    same prefix, e.g. a work order number.
+    Instead of this configuration variable, environment variable
+    GIT_COMPLETION_COMMIT_MESSAGE_CALLBACK can be used.
+    Environment variable overrides the configuration variable.
-- 
2.30.2

