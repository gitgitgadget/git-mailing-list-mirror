Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E480D3CFF5E
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833363; cv=none; b=PFLezID26UszRtPGJEsbJx8rARidjLPUfxUzr7/yvm7KMPsNZseJ8LWZMNa3plg1Ra0EE6h7maCi6KC5AKNDUhfbTReUdKpy4SnPmsjeI5v40zjWC9VSNWdX0XOPK5Hwa/zyDqr8PoOQAB1yceDPACq5DIuj1nyefNzqwZvvbJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833363; c=relaxed/simple;
	bh=Ap/70vZ4VhrqyQ7qKjM5SwTNZo6utSbnDpwXL1AzbhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdxSBMGAu8BG03ujLGVTBVrK0UYIUTSdgYRmQ9CN//DjbE5xOsP2WxvX33pU6F9LTfpGnll+7mS9fD5M3ktmqs3WltBt8UqTDRaC7FhVDzga4hqZH9Gebcq6gqilWj6ryyhqz2TK/b8Hx7JYx91NEjf8tB5wk1HhFntGWRCjfL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUwF1PzE; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUwF1PzE"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47231f1f8f3so4153861f8f.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2026 08:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782833356; x=1783438156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UECmQ66lIfAdz24Xg9lYa9hdniw5b3GC0vh+hhJdAy8=;
        b=OUwF1PzEMxiwmfTA+rcdT5I6l+FcU4jr4sb7oGF28aUZ8lVKs7GrtAcruKpU/h0Hts
         Pa+f0OkvMh1F20cjMIY8Yvwcp0/8xhtSeE9vYOzDKKFLJZR4A1lh1PVrFc2b+pxjGRhO
         lQMkEfSVHgKZbszeYsH0gaAaZuFf4t6zCaCRGbosg8jErxrbH9hnv2XhzM92YmpeAH8J
         dD6nZ0ThJ8TbcmVhbdngJzgo83akfNhL+ZQRFR8M79UpXqvUyFyoaNOk7H1HdfvGG4Wu
         7KpaL+ELieMGs8sRYREp/S26urVA6to2wHk++X8VG1asF3QRVBNHHknZfROUwpZ70Klu
         gDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833356; x=1783438156;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UECmQ66lIfAdz24Xg9lYa9hdniw5b3GC0vh+hhJdAy8=;
        b=eBj36xL/G/FIXkaQcSl8Fdrgo4lf2rV7SPbQhWGJWgucqplRwFIclyL/jNOnha5b9j
         PqpdSZ/DogXEfJVG/1YEHD9VqnwiZcQIUwfKthlzQZY94EozzKs3ZbwbEgbZlH4ZKmsT
         vQUs1H1NWbkIEsQTFU2lL6DBgqLcgIDOM43vhpT/yW8f62KfZoBQnBM2PO9FYqucAXj0
         m52CN/kxtG1B8s59wz6I3klWiLiUSsKzE+c5YiF9kRcdx+wgYL2ZuXSuKegGzMnuIYMY
         gI8ULTagCqCbLrtD0g9nUAD19ZmGfaRPUuVw95eEGO4ExD2fdWTUPfsMesUeHtUeD/VS
         6HKA==
X-Gm-Message-State: AOJu0Yz2MNC6lmm5tm2hykv8AKgQPO5a+ZFTYttX9NXF+v93ERCoKAPO
	RVCvv6RO8AfEVd1gzB364dwYgT0fIajVQK1DAMLilAccO/RmXf5LrSs8ogjp7A==
X-Gm-Gg: AfdE7cm0hNtt84dlDHUJLenhE9lQ0guaveAiBqL5w5XvKZgCjKbA7VlkwFjcn4DsdWe
	F7+zLp7cQpS/ekhdHxhmPRjHtd9CHHA7J1sntG+vbuT+7bPPsqgMbfNkTdoXDBcQ/OIESssWDFI
	2rWce2yklbcwB0OHseO2oyPHfGVZgrere3TaRoVT2BKD6cyZMbafvcj8cwUcfbWnS4BPVeGdyJJ
	WI9ot/bllW40Ej1ZK4kFo9/OkiozNP1sRBvOYjf/iKLoxW4+1hUK5AXwxIlNxbAnDEzVe7Z2brW
	e8eK2701174IsTmekOR+uAXArmdhV+3Qncutww9JE5+x0G1Womk8ejHe33L+cFn7w4qUYVZ/3eY
	jh1GjLJHVzKpNMXjqoy01qyrISi9etk9yDwUGzXkDfjFtKsoqIjWwGPM+LcmWtLT837D4CIsoI4
	9YaNrvslj2KRNzKFex
X-Received: by 2002:a05:6000:430a:b0:475:2171:ac1 with SMTP id ffacd0b85a97d-4755297271amr5496389f8f.32.1782833355804;
        Tue, 30 Jun 2026 08:29:15 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47567979eafsm8477378f8f.34.2026.06.30.08.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:29:15 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 01/11] t3400: restore coverage for note copying with apply backend
Date: Tue, 30 Jun 2026 16:28:51 +0100
Message-ID: <65af2ac07a2bf85336245a7d9b9f0a8a0e8affdb.1782833268.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1782833268.git.phillip.wood@dunelm.org.uk>
References: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com> <cover.1782833268.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Now that the merge backend is the default we have lost coverage for
"git rebase --apply" copying notes. Fix this by replacing "-m" with
"--apply" as the previous test which uses the default backend now
checks the merge backend.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3400-rebase.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index c0c00fbb7b1..f0e7fcf649a 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -270,9 +270,9 @@ test_expect_success 'rebase can copy notes' '
 	test "a note" = "$(git notes show HEAD)"
 '
 
-test_expect_success 'rebase -m can copy notes' '
+test_expect_success 'rebase --apply can copy notes' '
 	git reset --hard n3 &&
-	git rebase -m --onto n1 n2 &&
+	git rebase --apply --onto n1 n2 &&
 	test "a note" = "$(git notes show HEAD)"
 '
 
-- 
2.54.0.200.gfd8d68259e3

