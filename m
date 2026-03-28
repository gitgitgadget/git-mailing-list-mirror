Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965072D838E
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774728203; cv=none; b=WIIYwyLoWnKcJdSw6CqCyIvqxAt5knw5oO3PclmZmgmj5/I1ZHgCt+iVdVMkz4Gnfyppp9Aam3uBfWZyWzFQ9LK6frZo+MDknAW8B+2fGvYmLz5UhFlFS5WhtckjEijdcc7A+/BVxGp1RYigMgkxWD6uhVK+GD92rsWastNkH2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774728203; c=relaxed/simple;
	bh=7mdZQVDn0hHMEnDbJ06XEaXKFP0cmFbXAzuHszMPQ90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwyROuh40d6mF0QdxYMolGcm/Mn/RrC4kxnd2ppiBUZHVgL+o5Sla8RPsRr3ecmUWS4bbSDoLt3rC4XzScFdkm7b5A6nA/8gLrpWkzjPEq5xwxCH9yKFcfsSYUkhA5t3iRo1c7OOnS/JUnyu+KGy5cS29jmnsUEFIDSVYy9yGtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQXGr4SP; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQXGr4SP"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b0c30b517aso12111575ad.3
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 13:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774728202; x=1775333002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+hRbjUwpFWkFPQt85XBh48m/EoOTf+dHaZYRtiLGC4=;
        b=mQXGr4SPp7aJdNWaitzdQH4ixYieF/49Jg/vZY9F1wcLVV7RrNNaRoj0W4TzPXAHT6
         VpsoqUFXn52vfn3kJwtbqK/DubWi/BfGjclEK5ZGHIpI39ifmFNbTdwuDhAP3vC2yJwJ
         B+tICft1C7ICCxm1Xyq9nXEOjC8KB1wpZZP6Bb+b3+nMg+bRWmoodPalhRWws6+ckKwG
         M6JdYQTZHnHjGtwQnu725RP0nNAE+io9xycqtJE8jrhDul5nj0/kqgP1NpsQ4Fxzw/QD
         0IhhT9z5ZcgaJEf0nqMdh3fyulJqOcHriEDSTbgsR6QiZZWPSVI6x73Vii4Q+l3F+Ei1
         sjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774728202; x=1775333002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x+hRbjUwpFWkFPQt85XBh48m/EoOTf+dHaZYRtiLGC4=;
        b=hWJh2ICiswO6Diro3kaTLirZOidMmzn22j3H5xHkYv0AmheEdY8c6Fq/6hn3ig5IKQ
         BJx9YruBh24BBPe4olWM3UHLG7GRHmYmM6/dUhKUdVoMK62q/WX1EIe3G7fJx0ygTTHw
         o0tukfLrJI3Z8HCXU1sUuDvGYZCFYkuzstNoWazRchd1JUObEVRb1yi1jG4wrIO1+RiR
         C3NLNuOhDpPGeXbNJnD5jYN0oQoORV+xEklBZgERCtQefVvQdciJUyg2KfkU9rv50gtI
         QkmcyPEoTcj+Bpr/PddcjJwFgICHUXMpEjFPrvm8O4joJYZrrxaRmb8QgMN/E+GImBRi
         bhpQ==
X-Gm-Message-State: AOJu0Yw9iz6vKup5ouD02CqnM0sAACwjlcJK1nNDRoFpjUvMEp94LbuU
	OOAdqQJRLY6vcin2J5I4J156uA8BEWWSAaHqKKGglOEFUbJbZJE5NUhd4T3XzZid
X-Gm-Gg: ATEYQzwYFW8FmWcTEkVa8YErk3hsD+SIagwsqsEgb3GJIKSJX2iY53X4MtfdksvcKCC
	gKI92lP613X5kk5Jxq4F5hu8M639agZV4YitIg1mVZZGl2jUS4K4YxckAYr2VYLnxaOLOrQLSp6
	CJwP+KPCSMcysk3CQsywM1DHfyKy5Z3HtrU5FWWmb7XlBfCTuZP5DFatYnKuKYtzyHQ3MNwU8ut
	hiHpa5jQJ/Vv2YNgYlU8fw+WV3bQsyiLd0e+J7NQCVxRO5ekATvAuEq3286GaoLOXx67MbJGW/r
	k8MICkdzWAaZbzuivcUYaTkewq6/uVdIkdC1qWuz91/Oxk+RSZRKMJ+Za8/A4tS8cPfw+csqEbM
	9lXEtcFSfK0+ROZnqs+Lrqc6JvPVIUd7BXa2tfQz68FOhOZ4/CcaTEbzVyshcGDPy3Jxjzh9iUI
	n7z+SpL3hRcLliyY6jci6Wp+RSt8XM641YhbX9+SbWJhjQweqP96ArIvE4hAqHxIEtuYeWwIplm
	EnDfgQ2xg==
X-Received: by 2002:a17:903:1cc:b0:2b0:7b57:830f with SMTP id d9443c01a7336-2b0cdd40048mr73664555ad.33.1774728201675;
        Sat, 28 Mar 2026 13:03:21 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917bb31asm2359786a12.23.2026.03.28.13.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 13:03:21 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH 10/16] t4039: avoid suppressing git's exit code
Date: Sun, 29 Mar 2026 05:02:49 +0900
Message-ID: <20260328200255.247759-11-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328200255.247759-1-vikingtc4@gmail.com>
References: <20260328200255.247759-1-vikingtc4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update t4039-diff-assume-unchanged.sh to redirect git-cmds
output to a temporary file instead of piping it directly to
not hide the exit code of git commands behind pipes, as a
crash in git might go unnoticed.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 t/t4039-diff-assume-unchanged.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t4039-diff-assume-unchanged.sh b/t/t4039-diff-assume-unchanged.sh
index 0eb0314a8b..9eb3c3f04d 100755
--- a/t/t4039-diff-assume-unchanged.sh
+++ b/t/t4039-diff-assume-unchanged.sh
@@ -21,7 +21,8 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'diff-index does not examine assume-unchanged entries' '
-	git diff-index HEAD^ -- one | grep -q $blob
+	git diff-index HEAD^ -- one >actual &&
+	test_grep "$blob" actual
 '
 
 test_expect_success 'diff-files does not examine assume-unchanged entries' '
-- 
2.43.0

