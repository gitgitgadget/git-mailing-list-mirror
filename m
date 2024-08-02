Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9BA1E2894
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722600879; cv=none; b=OZ8kuJjmDppNw61e36ifIRAVB8Ts5Qg1E/ajVm+1qs5gU4RUyemBPKwxLaYvJS6DbjCsJfiE/IZcNL2yPtC0b3dmASkMS5W3tUXQ0vdftc2LIi0M6Se/eEmUMrLJ7Er1DKe0VAy3Ye8h1VOvdl81gXP8BsOG/GYoRN6zXzCweKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722600879; c=relaxed/simple;
	bh=Lc46Y8U/wW96XQMyz3vl6CsjMo+P8vbnaHspBKzQ3I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+Eib+vH6BT0CcvWuTg3p4fd6pQ0spFxCCbPTURc6Yn/OxQTwzkvAmIyAMCV8Ay2TATc4U8byrPW0tJYss7qJ5w2EIGmcIzNSrzqX9kWn6Iyun3bzoSLCZA46ZdG5uhFoFX+ff1ABrEXZnoceJsincSIO/myVpWmCXZ4Tb711rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxNv4bM4; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxNv4bM4"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d1a74a43bso5981668b3a.1
        for <git@vger.kernel.org>; Fri, 02 Aug 2024 05:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722600877; x=1723205677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xf8MrBUi738+95nFcX6h19aWln8Z6syjJXhu+jOLWJU=;
        b=KxNv4bM4E3C6kX5PYql9o43UWI0kyTtTDUeW7xm0URLjMyDRxiGfHmip8R9lfLaYDO
         e/b+dLYlKVUzCdADERMmWfnDPlR7II5z9ICzS79F0HpIwxqSMBIUp+t81oHieRNsU+3j
         l+Z33yL26pAmX0wufv8vyILKonY72vdP/0zpMnjX/j2KbRNkumUUosWU7yNbrbnFln+n
         qVDh14jfX9BDZT66LesZVQNLtu2pJTivjdM08BGJyRWCZ5MSb6z+ad+nICzRsadqYSKn
         g4+1JL4m1i/cb4ouOY7qFXPq84LxuYL/lqAsf8ktddRcXve72HSkb8u8Ysy9nEFlxlRi
         /3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722600877; x=1723205677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xf8MrBUi738+95nFcX6h19aWln8Z6syjJXhu+jOLWJU=;
        b=X/LHDuAl9T/2kDtfs1fhp9XIMO8kW+ZZQN/2G61QbvClhNr/FZiAtLP7KthhSe5zLw
         dlCYELLWrXCn2016L7u9mdUHj2PK/wPuifca0cXHFUpc14S1R4IyQzGg2+IrGD1eyZ8q
         QFq0g330IDdnRKeQEdSqTxesSqD8+g6OYH6Yia3C6Of8CJdiryIrA/pv1az8LWsSFMId
         G1u9i09RYP9FX71yzEVjsy4vPU+Ii4V8P3ok/yMT8hoNdJVd7EeUyIq+9Y1j804Obf0r
         FOX9a4U0fOA2YxOdV/vr+vYJZKR3DiFmlodujkzJHmOshlYWXaGtcfKA7WWRXDo02Car
         z+jA==
X-Gm-Message-State: AOJu0YxXO74t+Lof48LdpMnryBaERWtW+z/+8AtgGMntjLK/e/l92w6v
	Gn9SSMRciag74UdnPJeVvUf4BZaW2HLolfFK9wjGZAz0sdhZs2EZhaAi7Q==
X-Google-Smtp-Source: AGHT+IGM1ZuOVC6AAnBeSnlz1hq0Nc6oJGBxIUjYPH8d2eaAN697iWGBGUwvWNqFBmCAaxgsOlrRvQ==
X-Received: by 2002:a05:6a00:66c8:b0:70e:8f89:7e29 with SMTP id d2e1a72fcca58-7106d043129mr3430751b3a.25.1722600877060;
        Fri, 02 Aug 2024 05:14:37 -0700 (PDT)
Received: from Ubuntu.. ([106.213.168.25])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7106ec16034sm1294534b3a.15.2024.08.02.05.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 05:14:36 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 4/5] t-reftable-tree: add test for non-existent key
Date: Fri,  2 Aug 2024 17:38:07 +0530
Message-ID: <20240802121318.4583-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240802121318.4583-1-chandrapratap3519@gmail.com>
References: <20240722061836.4176-1-chandrapratap3519@gmail.com>
 <20240802121318.4583-1-chandrapratap3519@gmail.com>
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
index 5efe34835e..0f00a31819 100644
--- a/t/unit-tests/t-reftable-tree.c
+++ b/t/unit-tests/t-reftable-tree.c
@@ -46,6 +46,7 @@ static void t_tree_search(void)
 		check_pointer_eq(nodes[i], tree_search(&values[i], &root, &t_compare, 0));
 	}
 
+	check(!tree_search(values, &root, t_compare, 0));
 	tree_free(root);
 }
 
-- 
2.45.GIT

