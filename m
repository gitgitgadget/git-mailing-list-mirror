Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4646E82889
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718025086; cv=none; b=RZYYmKoJfpaMbnUTauSzqA007RLACe8fCxnc7gME/+uToRMQYshBWn82kKPQuxh3KRcJGs+h8FM/aldyJQ92DaRZokPKJKCrftR1M0ayo3CDV/k6LDBaOZkM10VpFqqtMa3Jc8VQxyHB7aU3JlqS/e3jpd6ogmXj20OUyTf4yd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718025086; c=relaxed/simple;
	bh=11N7wvHkwccmHznyMGTlw97HGAQrJ/FhUgJDsx/czXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kh42fk90Gzl7i84TQonarEocB6BXtRfBQlh8RZQxeflll46cu3ZxoEDfOvGyvKX3c3hMoANrFuRthZenRiQkSnY4QrGt8/RB2zsde6f5XHQjHjPE0mmm6vsVwO/YFTihvx39eo5WHNUnRoLKnb3222KDX6AEk69VpppyEyjiZIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoObRptJ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoObRptJ"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70417a6c328so2140444b3a.1
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 06:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718025084; x=1718629884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyCQWXZ5d4CiLY0kGIokt9eQRJcvdockpuVnB3UR3Lk=;
        b=UoObRptJTfX/HlE+Y/Q45VH7gpSD9V+HUi/jar0cUeLhRNDFKZ161dojvpPo2igdwp
         tVnlAX85FGMT5HoJxbk33cLNIALHq6xFjgLGazoG70byJRa6h8tP0MDYezMOUE3lO6S/
         3m1HVDjSVy6+ZUtAXkaSoDkqCso21JZ7K67357fHrPSwrSjBdn6uJaWxMa7uXKH8Di0+
         KXCMpv4AoNAxqbx09udmbrJpLQlBoL8htCGlkA4DzNRkBfOjKQnbtuQy8oKUGDl5dVPv
         LK/bEFU5IxAQMrIOyGDzMTI1QhHzn1k4/k50LjcFmaJSuJH81lTTuZCgMCFGI3apvYY6
         X3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718025084; x=1718629884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyCQWXZ5d4CiLY0kGIokt9eQRJcvdockpuVnB3UR3Lk=;
        b=Mdn+priAiAEP2Wn65Elp+wpv4hJtXMUK2Ee+o5jcUXmFiJhTlATK20WoqDTlK8IDUl
         je9YUX0RgHyFQ+RgYHHAFL4dOZJTue//uBryhmK0WDWfpeYW7bIPWIKzF4w68bqTZQzI
         6jw7QH6dlM3uiPhsYv0YXfTJRaZ0jHFshCnLr4pciNI50+6Y4dP0G6gct8k1wtkQJcq6
         rmgQGukK+pqDFHrek9J5iIMD7fgdCa7W+j4vRJ0EG7DC2KY4AtFll1t3TAIaKHILQqcs
         4xRy+FUkfOg+he7II7K67S7porofi/sHWwzUMF4J9OTN2uDuAI5JjpNMq56Yfvtmu6R/
         tiVg==
X-Gm-Message-State: AOJu0Ywp+gwielKSt3+NxIHH6l45IK6bIb0eJpPgi0A39LY6i2yA/441
	QggwXc88TxLd46AhpiqpdjOVw6/Ot0Grq+7vkj0KdneDj/sXFsYCscpTEfv4
X-Google-Smtp-Source: AGHT+IEE6DqPyhRueYdIrhw4E0ibB0Qb8eGCOQBGBUhSHop+AhCbj3yqs4vFRzTGrFghjypsSlEdAA==
X-Received: by 2002:a05:6a21:2716:b0:1af:cc75:3f79 with SMTP id adf61e73a8af0-1b2f9de087amr8718322637.55.1718025084219;
        Mon, 10 Jun 2024 06:11:24 -0700 (PDT)
Received: from Ubuntu.. ([106.206.194.184])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70599bcac14sm1378516b3a.1.2024.06.10.06.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 06:11:23 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/4] t-reftable-tree: add test for non-existent key
Date: Mon, 10 Jun 2024 18:31:31 +0530
Message-ID: <20240610131017.8321-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240610131017.8321-1-chandrapratap3519@gmail.com>
References: <20240610131017.8321-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current testing setup for tree_search(), the case for
non-existent key is not exercised. Improve this by adding a
test-case for the same.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/unit-tests/t-reftable-tree.c b/t/unit-tests/t-reftable-tree.c
index 78d5caafbe..b2fca0cb5e 100644
--- a/t/unit-tests/t-reftable-tree.c
+++ b/t/unit-tests/t-reftable-tree.c
@@ -44,6 +44,7 @@ static void test_tree_search(void)
 		check_pointer_eq(nodes[i], tree_search(values + i, &root, &test_compare, 0));
 	}
 
+	check(!tree_search(values, &root, &test_compare, 0));
 	tree_free(root);
 }
 
-- 
2.45.2.404.g9eaef5822c

