Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D9023C367
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034706; cv=none; b=qhvrTalRTxuBDajadFFpZ1Ra7/yuk9fuiXcrcJW6Scjv/iqv3odVyN8cxlWt1k2D1iovT/1aQnF3F5iD7eBNG8WPiMljzIpuhnBNYGGZbpgRwwTxIUrs49ZSSM4M1ubuMDkDRqWgBch9Ahq4uOHphMtybOFmsnyyCRPcNFBi3YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034706; c=relaxed/simple;
	bh=hlL0F3ZRmXa/IIPRCWBVxhju01BBpYXSqsL2xKJe8ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RleLE8bHHGPSSRN3K9vpOZ1wafqFhS0+QinXaJbya5PcGRCRJH4ZbEgK7xt9L3H35SE9MKkj/5gW+sIzyokOGkv8d4qJaG9hUGTb16+v3cbGI1dAAbDOirV//zQ6P7vf91EULwXPE6v/79GcpGdxNQIZPK1oS1mLU+ma38BFO6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Iw9oo1SF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TcXP4PP0; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Iw9oo1SF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TcXP4PP0"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 35E721382C53;
	Mon,  3 Mar 2025 15:45:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 03 Mar 2025 15:45:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034704; x=
	1741121104; bh=o7i5UwPq8uxG1hTX4Nlt0fyY4HeBRi7l3X3aB5M1s3Y=; b=I
	w9oo1SF6oz3ACRd6vqZzKA/GQN6iI7ZyTcFinZPEIbbEGRDeQLGa2VBQPlvVUmir
	qoioXs0KdScX42ku0LprMbCUSdFLTSkqfq/DnK53dChuARbhLGB0kEamyOfdapRh
	XW3UjdOYbifZOJp8nq9rhKqFQ2VNHOOzAx05lNw1f+vSHzzvkODK3Q4WGlz/p2gt
	MBcCYJENoIfnGyF8M9AaQid6y4vmek55vt8/y11Gvoxql3hHF8umFMUTXEZ1vnvB
	/aMDlc13OxV8YfckY6vkZyK8Tiq+dH6tAjHcNjsZ9oIAInrzjXOqu9bppAXI/7Wp
	+6FTyazri3006j5CA3SpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034704; x=1741121104; bh=o
	7i5UwPq8uxG1hTX4Nlt0fyY4HeBRi7l3X3aB5M1s3Y=; b=TcXP4PP0WHQx6pfN2
	yEXmzR67Gwp/o+uLRtqFLTa1Ix3DHJs3xu19NzZcmJHEG1Krz0Pw2XxYqfjmt279
	7+hYnK25bimJTllcak3Uis3Qjux9tAA7quohLlDjNeVq/a+9OQVsSIJTWdYZTTtY
	TdVUmX3sqdbiXYA8Yl40lCBdMeBi76UFsmsFDZs5KP6JRFr02K2iTYkIgYlcEYYV
	bTdyGQuChfZNfz6FPA222aXTC8FHC74jxmXX3nqquJUT4pdOKPFCGkLA2ankuAzJ
	xny53xOoVIyiaiy7Kb4RdbpNtl28vLf8jgLGQZ+7jYFphRL1tRRVA4S/Ha+5uGzh
	pBMfQ==
X-ME-Sender: <xms:0BTGZwbwBDTaqb4pllCM3VhdgzUMIeQNTQY8jvrJwlRto1eFw8V09w>
    <xme:0BTGZ7ayPVeRPvdthFwlPq7BqDM0FKfPZYxiDv91hh6GnNgQ2osScv1yW9WI8V7o7
    X398KfAqbN6vp1-MA>
X-ME-Received: <xmr:0BTGZ6_z_B40YBjBnQwP_m-_br0cDvO8rLNiuAOUkiBN_3eYmjJaMlHMcFw8o2ogLRAkH3T8kDWbtQyJMayTHGNN9QM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejuefggf
    ehieeugeeuheevgfegudetheetuedvveeuueeileeuhfeigeefkeekieenucevlhhushht
    vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:0BTGZ6pn2iAC9jBw93hi1yTbRDDFd02xWyzbZEMyuYCUnZgjvZVV-g>
    <xmx:0BTGZ7qjHG_W2YRajucehCXcNI4L_KsotTrWSCFefPrfVbRdNouDcQ>
    <xmx:0BTGZ4RuqcZ9rFxuLGU3IDrrbgRpl4ynw2UQJWf5qusa2uwRPC0idA>
    <xmx:0BTGZ7o3vJvg5X72ZXXJ_WkVUDuXoiUUvBdE-DdUriUEG16kwA-cPw>
    <xmx:0BTGZ6WgN7KVj35hMhDXvPJM_tjoyX9lI9-s8uZgzOVLzsz9Jt4KSLN->
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:45:03 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 15/34] config.c: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:13 -0500
Message-ID: <20250303204443.360595-16-tmz@pobox.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250303204443.360595-1-tmz@pobox.com>
References: <20250303204443.360595-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 config.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/config.c b/config.c
index 36f76fafe5..dcb5cb5265 100644
--- a/config.c
+++ b/config.c
@@ -1652,7 +1652,7 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
-	/* Add other config variables here and to Documentation/config.txt. */
+	/* Add other config variables here and to Documentation/config.adoc. */
 	return platform_core_config(var, value, ctx, cb);
 }
 
@@ -1663,7 +1663,7 @@ static int git_default_sparse_config(const char *var, const char *value)
 		return 0;
 	}
 
-	/* Add other config variables here and to Documentation/config/sparse.txt. */
+	/* Add other config variables here and to Documentation/config/sparse.adoc. */
 	return 0;
 }
 
@@ -1679,7 +1679,7 @@ static int git_default_i18n_config(const char *var, const char *value)
 		return git_config_string(&git_log_output_encoding, var, value);
 	}
 
-	/* Add other config variables here and to Documentation/config.txt. */
+	/* Add other config variables here and to Documentation/config.adoc. */
 	return 0;
 }
 
@@ -1715,7 +1715,7 @@ static int git_default_branch_config(const char *var, const char *value)
 		return 0;
 	}
 
-	/* Add other config variables here and to Documentation/config.txt. */
+	/* Add other config variables here and to Documentation/config.adoc. */
 	return 0;
 }
 
@@ -1744,7 +1744,7 @@ static int git_default_push_config(const char *var, const char *value)
 		return 0;
 	}
 
-	/* Add other config variables here and to Documentation/config.txt. */
+	/* Add other config variables here and to Documentation/config.adoc. */
 	return 0;
 }
 
@@ -1760,7 +1760,7 @@ static int git_default_mailmap_config(const char *var, const char *value)
 		return git_config_string(&git_mailmap_blob, var, value);
 	}
 
-	/* Add other config variables here and to Documentation/config.txt. */
+	/* Add other config variables here and to Documentation/config.adoc. */
 	return 0;
 }
 
@@ -1773,7 +1773,7 @@ static int git_default_attr_config(const char *var, const char *value)
 
 	/*
 	 * Add other attribute related config variables here and to
-	 * Documentation/config/attr.txt.
+	 * Documentation/config/attr.adoc.
 	 */
 	return 0;
 }
@@ -1831,7 +1831,7 @@ int git_default_config(const char *var, const char *value,
 	if (starts_with(var, "sparse."))
 		return git_default_sparse_config(var, value);
 
-	/* Add other config variables here and to Documentation/config.txt. */
+	/* Add other config variables here and to Documentation/config.adoc. */
 	return 0;
 }
 
-- 
2.49.0.rc0

