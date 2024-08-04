Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9478056766
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722780704; cv=none; b=HIjTEhZ1enscC35evLV3WAvqV+gCGyUqje5mosjNDwZK1NxyqzBukur8d7rbIRX9TQZr+HnONl7s9VAaCFrp+NYtDPQdHbMSQ6GSrW3QvvnQyqVZyx+rROna7Swwk8M216zH73ag455COu9Ll6l+rqy0BF8ZxbQgdqR3WZsRrhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722780704; c=relaxed/simple;
	bh=fEql4UDf4O+NGVTCY/xpS8UYxGIbT6Me4V5hNvMDVIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sD7IXSWldeFC49MIr/xV06IJRn8Ezw21/OjGGehS+If8ntH6tyscCK5xabhmYtyYyM4gwpS9i+KRZ7KM5swHK/N3bmYNqRTRJFvtNK7aRmZgJFu0mUogtMwvlslPF2UMIEJrZ2aN+GDyJnX+XvgZ9jf5fHExcEuoC25r4DSzO7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5bEFfE8; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5bEFfE8"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so6532860b3a.1
        for <git@vger.kernel.org>; Sun, 04 Aug 2024 07:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722780701; x=1723385501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6LdhOVS1MV0pBmGNCTIpy/RdXSBas1kpEK/p/JLXE0=;
        b=Z5bEFfE84VYYcITaTY61HiAt8HN6pUPjkMqMZkXenc2yWPuyHs1Q2MXxAReEeF13XT
         H8KEGlOUkzY9och12UA9J9B+QCBWNMy3aO4E/JXhUZ/yQfdKo6b4mW00T+CvP5cp/De7
         ot1TcH1fibSxw5PrUh/dna6+V05yF8p9xaCTadhkTmtklMzivWrmZ0zT0Qq+BizkCUFz
         E3SFWNQOgPmCn8RsVXFPlUvyB6h3b9rXCv0L50HJgZjnSTZfxnrkCeKdwan45rrGX2RP
         gTBj2+o9vdmoFOiVrqI/QYQf16fcL6psnbAylMsDquLH/wXWZlSHGXn+pv/+4+T4Xabd
         lzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722780701; x=1723385501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6LdhOVS1MV0pBmGNCTIpy/RdXSBas1kpEK/p/JLXE0=;
        b=kU5jtjIJMGvTPsQubcfnsiQBVeRW74ku4PqZr0239nwywe8oaod6F9oymyf77K7cmw
         /+Mo54WufJ89Lc6F66Yb35tqFhDSK7cRAyfBKyn8IyDTy6FmOaPlH/gcR7Y7v26HS6mn
         hLaHQu8rj0hsyho29BQ3uPjJKW4kvMb7qTrkLsKC/iswz6JhB3nu39hFNJnpZ2TE8yQL
         Ppl7vcFwzbEp4x/uwDVw2/8DLgnaxQtpYf1Lu3ZP2+h6j9U2HdnLuO1fMWrp5+Wim/Hu
         /3Vi+W0HAXSNTP5bcaqcgXlsBmYHidwAThctjR5ylfirtCuSTc42iLtRvk+VjajYNexm
         EUFQ==
X-Gm-Message-State: AOJu0YwiUJViN76l2OU5EdJF1DsjbRT5WOmCzcfI3AEHzJc/4LUCbz5E
	HF+c0DNF/aK26CFc1LpMpqbMNN3+kiOxY0mYcKlAJNzvMTY7ECVAN/esznyO
X-Google-Smtp-Source: AGHT+IGmxJPql5O5oI/LOLqkPoEjf343Vfd+/7kyXzskQpahPCkLg1BiGl2It71h34joY84MywA4JQ==
X-Received: by 2002:a05:6a00:66e7:b0:70b:260:3e2c with SMTP id d2e1a72fcca58-7106d046079mr11189377b3a.28.1722780701319;
        Sun, 04 Aug 2024 07:11:41 -0700 (PDT)
Received: from Ubuntu.. ([27.59.94.183])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7106ec269d2sm4125047b3a.17.2024.08.04.07.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 07:11:40 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 4/5] t-reftable-tree: add test for non-existent key
Date: Sun,  4 Aug 2024 19:36:48 +0530
Message-ID: <20240804141105.4268-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240804141105.4268-1-chandrapratap3519@gmail.com>
References: <20240802121318.4583-1-chandrapratap3519@gmail.com>
 <20240804141105.4268-1-chandrapratap3519@gmail.com>
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
index 7cc52a1925..2220414a18 100644
--- a/t/unit-tests/t-reftable-tree.c
+++ b/t/unit-tests/t-reftable-tree.c
@@ -47,6 +47,7 @@ static void t_tree_search(void)
 		check_pointer_eq(nodes[i], tree_search(&values[i], &root, &t_compare, 0));
 	}
 
+	check(!tree_search(values, &root, t_compare, 0));
 	tree_free(root);
 }
 
-- 
2.45.GIT

