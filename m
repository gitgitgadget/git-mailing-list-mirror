Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704481411DE
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761563774; cv=none; b=ezQb5kwoYZQzzex52b3nCtRhovPNGMRM+5UyUDFuST4DuVE15GIMFfeOpT/KQx3QXYCyh/i4Pq6qlfzxyZYZVedicQz5MhZt4jG8cX/9ctZCXGoUS1Onu+XBBbezicf/AZec/gE+NCx6iQaR9IhEqGSh+In9o8rLHI0YToVVBt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761563774; c=relaxed/simple;
	bh=4batqbcdKC0JhBeI4C6YcsU1C/CG7Ze3CVyF5UJM3NU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ryiq57AwK88hinz0wZ2ZTcbQA3eQ9srImhAH2JLn889t5O/81egv3JpFSaUn1wbEHlE9tU3k4QvoF/aOuPQoAT1NvSutsCMR9NWfQCOfuekE9b3hUunXw5++hedgcwC8wyomudERJ/iyG/B4c58Gk/2n2FulDHDX3fczRtj7h20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSzf1sqI; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSzf1sqI"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42557c5cedcso3037907f8f.0
        for <git@vger.kernel.org>; Mon, 27 Oct 2025 04:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761563769; x=1762168569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/+S+c26y+y5LuxMCBedHN/1W+FTOvsX+f5psnd8RtOA=;
        b=DSzf1sqIGRF5ePI8X2exdjfYlkSa/9ezENZa3ECL8oJuewzykQJfcme4phwgA+5LoL
         M2Ikvh++pJjrvdXVeg1x2chC28etwNTNJ+EAYrcdf5n/fGjGhY3i3L1XKbboREXk0Ybj
         fJ9g2bBXZvGrV9lmhBh9T/lzkcmWbwdknRHdjHlV28HkxwuDUkeYV1mjg3VhkyqNBf3p
         00D8CO9iW1dH+sJty8FY1Gn0mFkmiW5sfX4ILlunzuw8wdgpruqNmzGi0Mpe8PCha0mf
         LSueJJjm/f8XhPnhwt+drUeaOJlOFEaCqSZeke7CpAT/u62sF4kI1U9EeLSfE1crEuRL
         6EWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761563769; x=1762168569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+S+c26y+y5LuxMCBedHN/1W+FTOvsX+f5psnd8RtOA=;
        b=DVzv6gStRVz3sDWHkP8v046mtyUFmivpCdFfc+w1ERQx+OjduG+eClexlsQJqTO3vq
         KE+KSezHe26IL8avmfIGk6S+d01BtUa+8+sc90VnRxnxDKOUMjo9y+nJIqvJUjv+8Y8B
         zMAFqMnsPtyz30obdQMIT1a5EulyXvftCUYR4N3aOXAsFDAJoCAJN/YzVxd8zfo2IboO
         YKSLLjJ/R8choEMf1U0vp00YZ+pr/UjD1MTNj1X+eZeSsbbwsY9I4T7p5ptKUfnYUZgG
         bK6CK2w/9HayDbshBujvrhqqrkn+T8UJAllioAANKyVJt3tapJsl09+xTHp+BU0dg0ZL
         +ERw==
X-Gm-Message-State: AOJu0Ywv7KOorJmx5+U15skNOEr27OeNd6P8JJhLfNcp2aXgsa5L+yGL
	ulN/X2FIErAKzUNrn5CkdaSAy6ONysm0O8RnRcRUBwPG3jifmWJAEkXDZb1rneXx
X-Gm-Gg: ASbGncvNOZcC5vJKSbikXLu/Z6eIUp2GKOgbA2QP7DyayGxI0G0yJU9t+OFg3n9Q30V
	Zx2nd0U81s4/aGrCn7gZJ4MQrm8WF3OS5dKhoe7qfX1EXzq2HCjTGtvuGyGPhjYA+ESOYajy6Mc
	7yuKtbiMP7teWgYo5K7D/ja3a31yNJ0r/BuF10MMa1vWe2JjcH1ruDcAGSukMdLWefSlHvfWyRl
	CPP0HemxNJIaqW/euSCTnCzlWRz6+rE0YLvKKqikVyrMlnffngWz4aphouJn5nPNF8CVoPEcZo3
	0V+hI7ZbxscN8sdyee2pZtamtpGIuTbAcwdFzaaZayq6atcGiS/YHOJ33OjTmWV1F1n1QHpkAuf
	ZPmAjT453XNmMgAkBVphUxeWZ0qvMqnFiWM0nKQOLnBOGmXm7l6goAiTEVWhyc8MDLrMbno5ids
	kEmJ20CV38qmxiLRK3QEefbmuy2rntQY0Gxrxd
X-Google-Smtp-Source: AGHT+IFD5XZYgox9e6tassQseAXrVsDMlEFVtTGtbVPYuOJ+yJU4UD37Ol+Fg8CpFnvdU+a5vC21fw==
X-Received: by 2002:a05:6000:428a:b0:425:8559:5d17 with SMTP id ffacd0b85a97d-42704d9457amr23892488f8f.30.1761563769138;
        Mon, 27 Oct 2025 04:16:09 -0700 (PDT)
Received: from QueenJ-PC ([105.113.60.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4a5cc4sm129109125e9.11.2025.10.27.04.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 04:16:08 -0700 (PDT)
From: QueenJcloud <qjessa662@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	qjessa662@gmail.com
Subject: [PATCH v3] MyFirstContribution: add note on confirming patches
Date: Mon, 27 Oct 2025 12:16:00 +0100
Message-ID: <20251027111600.1481-1-qjessa662@gmail.com>
X-Mailer: git-send-email 2.51.0.573.gb660e2dcb9
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a note after the `git send-email` section explaining how
contributors can confirm that their patches reached the mailing
list by checking https://lore.kernel.org/git/. This helps
contributors verify that their emails were successfully delivered.

Signed-off-by: QueenJcloud <qjessa662@gmail.com>
---
Changes since v2:
- Distinctive/correct name to the email
- Added changelog note after '---'
- Removed extra blank line at the end of the section
- No other text or formatting changes
---
 Documentation/MyFirstContribution.adoc        |  6 ++-
 ...bution-add-note-on-confirming-patche.patch | 39 ++++++++++++++++
 ...bution-add-note-on-confirming-patche.patch | 46 +++++++++++++++++++
 3 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 v2-0001-MyFirstContribution-add-note-on-confirming-patche.patch
 create mode 100644 v3-0001-MyFirstContribution-add-note-on-confirming-patche.patch

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 02ba8ba5f6..95f96b8451 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -1153,11 +1153,15 @@ NOTE: When you are sending a real patch, it will go to git@vger.kernel.org - but
 please don't send your patchset from the tutorial to the real mailing list! For
 now, you can send it to yourself, to make sure you understand how it will look.
 
+NOTE: After sending your patches, you can confirm that they reached the mailing
+list by visiting https://lore.kernel.org/git/. Use the search bar to find your
+name or the subject of your patch. If it appears, your email was successfully
+delivered.
+
 After you run the command above, you will be presented with an interactive
 prompt for each patch that's about to go out. This gives you one last chance to
 edit or quit sending something (but again, don't edit code this way). Once you
 press `y` or `a` at these prompts your emails will be sent! Congratulations!
-
 Awesome, now the community will drop everything and review your changes. (Just
 kidding - be patient!)
 
diff --git a/v2-0001-MyFirstContribution-add-note-on-confirming-patche.patch b/v2-0001-MyFirstContribution-add-note-on-confirming-patche.patch
new file mode 100644
index 0000000000..0e29510cba
--- /dev/null
+++ b/v2-0001-MyFirstContribution-add-note-on-confirming-patche.patch
@@ -0,0 +1,39 @@
+From b6e46728e3ce0714c03b9af548b734deadd95ca3 Mon Sep 17 00:00:00 2001
+From: QueenJcloud <qjessa662@gmail.com>
+Date: Fri, 24 Oct 2025 13:58:14 +0100
+Subject: [PATCH v2] MyFirstContribution: add note on confirming patches
+
+Add a note after the `git send-email` section explaining how
+contributors can confirm that their patches reached the mailing
+list by checking https://lore.kernel.org/git/.
+
+Signed-off-by: QueenJcloud <qjessa662@gmail.com>
+---
+ Documentation/MyFirstContribution.adoc | 6 ++++++
+ 1 file changed, 6 insertions(+)
+
+diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
+index 02ba8ba5f6..6e7f3036bb 100644
+--- a/Documentation/MyFirstContribution.adoc
++++ b/Documentation/MyFirstContribution.adoc
+@@ -1153,11 +1153,17 @@ NOTE: When you are sending a real patch, it will go to git@vger.kernel.org - but
+ please don't send your patchset from the tutorial to the real mailing list! For
+ now, you can send it to yourself, to make sure you understand how it will look.
+ 
++NOTE: After sending your patches, you can confirm that they reached the mailing
++list by visiting https://lore.kernel.org/git/. Use the search bar to find your
++name or the subject of your patch. If it appears, your email was successfully
++delivered.
++
+ After you run the command above, you will be presented with an interactive
+ prompt for each patch that's about to go out. This gives you one last chance to
+ edit or quit sending something (but again, don't edit code this way). Once you
+ press `y` or `a` at these prompts your emails will be sent! Congratulations!
+ 
++
+ Awesome, now the community will drop everything and review your changes. (Just
+ kidding - be patient!)
+ 
+-- 
+2.51.0.573.gb660e2dcb9
+
diff --git a/v3-0001-MyFirstContribution-add-note-on-confirming-patche.patch b/v3-0001-MyFirstContribution-add-note-on-confirming-patche.patch
new file mode 100644
index 0000000000..d5fe3e0bae
--- /dev/null
+++ b/v3-0001-MyFirstContribution-add-note-on-confirming-patche.patch
@@ -0,0 +1,46 @@
+From ad52256dcdfa5080dcba9451a67af1d3f89ba26d Mon Sep 17 00:00:00 2001
+From: QueenJcloud <qjessa662@gmail.com>
+Date: Fri, 24 Oct 2025 13:58:14 +0100
+Subject: [PATCH v3] MyFirstContribution: add note on confirming patches
+
+Add a note after the `git send-email` section explaining how
+contributors can confirm that their patches reached the mailing
+list by checking https://lore.kernel.org/git/. This helps
+contributors verify that their emails were successfully delivered.
+
+Signed-off-by: QueenJcloud <qjessa662@gmail.com>
+---
+Changes since v2:
+- Distinctive/correct name to the email
+- Added changelog note after '---'
+- Removed extra blank line at the end of the section
+- No other text or formatting changes
+---
+ Documentation/MyFirstContribution.adoc | 6 ++++++
+ 1 file changed, 6 insertions(+)
+
+diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
+index 02ba8ba5f6..6e7f3036bb 100644
+--- a/Documentation/MyFirstContribution.adoc
++++ b/Documentation/MyFirstContribution.adoc
+@@ -1153,11 +1153,17 @@ NOTE: When you are sending a real patch, it will go to git@vger.kernel.org - but
+ please don't send your patchset from the tutorial to the real mailing list! For
+ now, you can send it to yourself, to make sure you understand how it will look.
+ 
++NOTE: After sending your patches, you can confirm that they reached the mailing
++list by visiting https://lore.kernel.org/git/. Use the search bar to find your
++name or the subject of your patch. If it appears, your email was successfully
++delivered.
++
+ After you run the command above, you will be presented with an interactive
+ prompt for each patch that's about to go out. This gives you one last chance to
+ edit or quit sending something (but again, don't edit code this way). Once you
+ press `y` or `a` at these prompts your emails will be sent! Congratulations!
+ 
++
+ Awesome, now the community will drop everything and review your changes. (Just
+ kidding - be patient!)
+ 
+-- 
+2.51.0.573.gb660e2dcb9
+
-- 
2.51.0.573.gb660e2dcb9

