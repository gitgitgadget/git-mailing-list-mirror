Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161EC17B4F9
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718197378; cv=none; b=LYI6lazNPPVrZ3nI5de4AxlV228paEvK5u/LQH7IOWwVCmh7cQBu39H/HEKf+VmA23aeks48yZUaHQTWeN9dPNBqvK3G1bJpUL+cnLvHyG3/JUqMNy2f4kAXAwdpxt7bVXA7mtFJaaJ9kDZVbT+YODnfp69FjWr1i2EKA9c8mvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718197378; c=relaxed/simple;
	bh=OCBQ9tjRvoQr7HXZ8VMV3IU6S6ATeB1pR3zF0tokTtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwSKyHxvL8dHmQD1zrtJ4QIb5wB54tLZrJcJTgn0LJpkfoKVozjiFkrldWZsohZb+1/2w+QqvbiYRcL5eUI9yoFxVeEYjdAkVzIfv/wcX1Wl5mhB+BeiO9aVAdhpDi1/pLbqYDxUnRJaNzNHXPPxusF3S3PkqBUJBPYX9CqjVuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTSPTRwu; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTSPTRwu"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f44b45d6abso54219635ad.0
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 06:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718197376; x=1718802176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KZcKIhlNgpm2MiNyCc2/Weo4ZRujP+9T59sCvV/69w=;
        b=CTSPTRwuSTgSN/eb4K7ydBuj5RII2G2rApDdsI1FbELTtRnfWTkpGN2pW+9PsJC5Ek
         xYPgnVuBNOAHQIXAGT66HpfkObhWNBPFwwzawL/zzngfB5d1tnbWzmLaGjFlRqj5VsIn
         xGfYPrBlKvp4tDOmV4sF0El37ZBeBSn+WPpkCEZUSJAHzega2O/BHc5ISDPiXn1O4XMY
         0WE1pAKyBhqG6qH0KSi4Ff/hwWSjUbJ7VYbsBP2EKw/PzpkKq2Hf+Z8hlbdjTxnMZdKm
         xnkVX223sNLHGzbNFCvhrMxVRD36F6xQOukxpHaeTXnVPxiSk2UL1zKjJd3KHJHmtY6S
         rAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718197376; x=1718802176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KZcKIhlNgpm2MiNyCc2/Weo4ZRujP+9T59sCvV/69w=;
        b=A8KY/0e7npPtMevKTzJh0Ni/7MeX3Xg9id1+x/5C5VgfH5z4v2pc+QewMjejVIXSHI
         i3is4B3DZXQhNejrt0kEmblpayguwn8AxRq6lvCpcBHM1X2VN86Url6/ttLzIIYzmU2x
         VdQPMWE7tNxxXG3pNoOBwLRLd1JZbjwZQ7s/y1pddFcRC8CcgqGVgRwR4cQsv/acpMHK
         AbL3glsJP1JdfEftsPFI8+3x2Q+oygzPxZn15jGmcKcAr6rTlvYIIH6sokbU2gThyqRC
         HQYcxER35o44fnQvGz0VR/vEOE8GSxDnSK9ABG59Tr2z2DtGglGFw+huVXZYrR42T2rT
         nmTQ==
X-Gm-Message-State: AOJu0Ywb3NqpApoj7ePi0HoHoS6Qc6f+BWlH7zHPyG/G9ZlF24MoZ8E4
	aG65muL2KbqS+/3m2KzQK0AIc4l9zrL3BG19TUE0Tqqq2QmTZxjx23iqYtGLoPY=
X-Google-Smtp-Source: AGHT+IFxeLLVu1L4512kpWhlZ8VIyi2BntfPllOUi1eB+OrZ4Lj3g75fI0ulYCgGQvY1VfcqYnvB8A==
X-Received: by 2002:a17:902:eb82:b0:1f6:f04e:56d0 with SMTP id d9443c01a7336-1f83b7a3267mr16290085ad.48.1718197375993;
        Wed, 12 Jun 2024 06:02:55 -0700 (PDT)
Received: from Ubuntu.. ([106.206.196.39])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f6bd7fd25fsm123942325ad.280.2024.06.12.06.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:02:55 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 4/5] t-reftable-tree: add test for non-existent key
Date: Wed, 12 Jun 2024 18:23:02 +0530
Message-ID: <20240612130217.8877-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240612130217.8877-1-chandrapratap3519@gmail.com>
References: <20240612055031.3607-1-chandrapratap3519@gmail.com>
 <20240612130217.8877-1-chandrapratap3519@gmail.com>
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
index cb721b377a..f1adab4458 100644
--- a/t/unit-tests/t-reftable-tree.c
+++ b/t/unit-tests/t-reftable-tree.c
@@ -43,6 +43,7 @@ static void test_tree_search(void)
 		check_pointer_eq(nodes[i], tree_search(values + i, &root, &test_compare, 0));
 	}
 
+	check(!tree_search(values, &root, &test_compare, 0));
 	tree_free(root);
 }
 
-- 
2.45.2.404.g9eaef5822c

