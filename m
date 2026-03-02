Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB28423A71
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469945; cv=none; b=twaSZgAo00N9iwtBqbQltoR5jsuzt26KyxqZH+hJYBwuRYOM6ukZTCRKgHksZTuDltvVZ3dxgIEx8/rAvgBES6BfxfaoTaUWcTvtBOVu79TW2idKh/18aCHqyWbZXOqxJx1FBLVVNG99FUkk2WOmdA37Mbs+dDm6e4bu1yLXgjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469945; c=relaxed/simple;
	bh=Q4ti9S4d/LnslsRQhhjDRKPcpAzRcYuC5+Qy5b6wKvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z2R21fB66YRBa8neGCXgEi7LEhuOJh4efuaMu9cbrGonGfWqZKlICGS8MmNWMFF6FrkFzPFdKPmh2zkQn+wmv0/K2327zjYN1WtnOU6Hu7koJZI6AVYXf6nxke66MtWo5hxu+6JFYwM6RC4QnKhjsboxH/HAkmevZR8RBClR3zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k67XTgWc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k67XTgWc"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ab232cc803so22497595ad.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 08:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772469943; x=1773074743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eui93+oFLYiDaca/e1mRdHiVxdHiNVy9oJoBF27avEE=;
        b=k67XTgWcmDTkKvmZmeh9pfxXwKiFE6MLHXTQtZ6NXRX+YZbh+gwC6PhwsUzUcEWa0m
         5JE3fHB5WKi403l/4uVEFoua0iWoeoX4eVkCmxtuxEhRJj2S84yaSXsHwet3oWpXNulx
         7j2ePzfC22V+KJ1erzR28KvrGU8dFyYahy0FtsBbLXxnZO0PoEwD+93mmk+PtbeCSmsR
         1d590Ply5I0J1AwQmDUXsxyny8b6bmb0LqgFR84ISRTYGp6GDs47v40hSmPGd5K/eJcd
         kOvdf15Y1MXez6WRq9SuBiMx0c/nPInUsuHtiPVhy5DXU+C9de5amQFSPZpGn1GQ5Dgo
         Q0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772469943; x=1773074743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eui93+oFLYiDaca/e1mRdHiVxdHiNVy9oJoBF27avEE=;
        b=bSOAjp7T9oSL+xX2d+jCZB60tec6GTdyrZEu8HXkDzgqZuSp5iwg+UN4tGCsprR02s
         jKT390joce1FRZ3L23k2+Kwk4DSbA7+YmsaZMIudtTN/OccaWT3BvsnYcfr3482PZfrK
         WEmq2Vhfzcz6ajZOdPxiKtqqGqqDByykqLuvrlW1hE9EYN/d7TTCDJW4yUcf5+vvTWbb
         3jMjpZusfS0HY+pKZp9b7pshAI/F/2SJi1rMEL4V8n3vkXT3g9v0esRre49Yru3FA6kT
         oKPQ5B2PJVYznFxthtC//Yu9EA+ptT6Wopg2p1PzVIL7j2GuRaKmadL3NTS/XkILVmkD
         FZ7A==
X-Gm-Message-State: AOJu0YwXEpwca6KRXHuFIgIh8B02mcZmrkwE6jZMxv+zKNHm8cbqDVv+
	Jns3kQKybbcWOpP/15bDIQ2XYibRm8v94IobApYAqUxnncfkKi+drghqx1eBPFUKo+o=
X-Gm-Gg: ATEYQzx/XY8MRuxvzEctbflwn+ZsO6EZzjxAmWCrzSRfafr1T9HqUDSD1IxidN8Xh7w
	weqH1p/eZhM8HxSpKVBBQQy+Q7WVQr+0TIDBp9qB9UYFoVgUskwzSKzsQtfqTaPbKe4reu8mEHS
	WsUELFTgJl8Hl8NdriDgaV6RenyT4ib35eSidcTunega3rA6LvblHtSwbmorwe6JhKu5mEOu8nU
	TlG6tPOeL+ypv3IqIO2dSKVXd21NE2J/Os5PjY+9ieRsw4cvCHWqQIjBKPCwpyoEP6Yrv3UOq7U
	KlxkO/1+07rz800AY1bRx98B6xYdGx824gZQKNAZzk7ArgR9hOkZlTsmuFjulQ6pYm50/MM8KE0
	uj8RgxQhO9srn9YsYLDrRP3G9nvJK2zK4ul0sC/0/J65MtaK6B6Ij5ds0ESpWTk4YpG5z6XezHR
	a1R9zcOnthDuyRJAn4oFaL1OoXhC1rRLKgVbmKiwIq38YNvVe216l1sap8ShIum9oYylHbOSw=
X-Received: by 2002:a17:903:1b48:b0:2ad:ab2c:d258 with SMTP id d9443c01a7336-2ae2e407e3emr118395235ad.14.1772469942724;
        Mon, 02 Mar 2026 08:45:42 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:562c:c6af:6cda:a983:4725:5ffa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c2e4bsm204519235ad.32.2026.03.02.08.45.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Mar 2026 08:45:42 -0800 (PST)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: algonell@gmail.com,
	jeffhost@microsoft.com,
	gitster@pobox.com,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH] t: fix "that that" typos in test comments
Date: Mon,  2 Mar 2026 22:15:21 +0530
Message-ID: <20260302164521.79148-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several test scripts in the t/ directory contained "that that"
typos in their comments. Updated these scripts to use "it", "the", or
a single "that" where appropriate.

Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 t/lib-unicode-nfc-nfd.sh          | 2 +-
 t/t0019-json-writer.sh            | 2 +-
 t/t6416-recursive-corner-cases.sh | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/lib-unicode-nfc-nfd.sh b/t/lib-unicode-nfc-nfd.sh
index aed0a4dd44..201ab9b24c 100755
--- a/t/lib-unicode-nfc-nfd.sh
+++ b/t/lib-unicode-nfc-nfd.sh
@@ -75,7 +75,7 @@ test_lazy_prereq UNICODE_NFD_PRESERVED '
 #
 # Note that I've used the canonical ordering of the
 # combining characters.  It is also possible to
-# swap them.  My testing shows that that non-standard
+# swap them.  My testing shows that non-standard
 # ordering also causes a collision in mkdir.  However,
 # the resulting names don't draw correctly on the
 # terminal (implying that the on-disk format also has
diff --git a/t/t0019-json-writer.sh b/t/t0019-json-writer.sh
index 3a4e1cc7e3..0d30cd36d5 100755
--- a/t/t0019-json-writer.sh
+++ b/t/t0019-json-writer.sh
@@ -290,7 +290,7 @@ test_lazy_prereq PERLJSON '
 '
 
 # As a sanity check, ask Perl to parse our generated JSON and recursively
-# dump the resulting data in sorted order.  Confirm that that matches our
+# dump the resulting data in sorted order.  Confirm that it matches our
 # expectations.
 test_expect_success PERLJSON 'parse JSON using Perl' '
 	cat >expect <<-\EOF &&
diff --git a/t/t6416-recursive-corner-cases.sh b/t/t6416-recursive-corner-cases.sh
index ed20de8ea2..63de0fc6cb 100755
--- a/t/t6416-recursive-corner-cases.sh
+++ b/t/t6416-recursive-corner-cases.sh
@@ -775,7 +775,7 @@ test_expect_failure 'merge of D2 & E4 merges a2s & reports conflict for a/file'
 # it feels sound to say "B and C do not agree what the final pathname
 # should be, but we know this content was derived from the common A:a so we
 # use one path whose name is arbitrary in the virtual merge base X between
-# D and E" and then further let the rename detection to notice that that
+# D and E" and then further let the rename detection to notice that the
 # arbitrary path gets renamed between X-D to "newname" and X-E also to
 # "newname" to resolve it as both sides renaming it to the same new
 # name. It is akin to what we do at the content level, i.e. "B and C do not
-- 
2.51.2

