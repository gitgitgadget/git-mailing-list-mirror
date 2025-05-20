Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185DB2512C3
	for <git@vger.kernel.org>; Tue, 20 May 2025 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747753486; cv=none; b=ttrRMOH1I97/HY/N9Iv/Sw5m3aXJgMa3SiLjhcfMnTJFF5pjmLa2sqhYxH1DuhqJanTtinYZhijCPVqSrZp7slGCVc0io2gbYMT2Zhcfjl7FDr11KrltpPoCspK0Kf/vW9hAqR4Sttk4xLMUCAqSbBC7aGS4v3NKD/7Oq1uNQuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747753486; c=relaxed/simple;
	bh=rwdSW7E+3RVEN5iEX6gsTCMMMx9EFUwTd3txdt/a/J4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tg5sPLsmmCZzzY54z3oR0hWa4aBwPuOSjy1QxISNbLiXqQskFUzo5E3IpBdXPOpKl1OcxCULcmBY1xO892ubNEvjKKJyVerY1Ie+r48x9CPcPU5xhIOC2wtmGkMIXwCELveExb/hoxTndPW03aTomMdqMxxiFITt0LCTrDYmXBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkmFFaq+; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkmFFaq+"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a36ab95a13so1728037f8f.3
        for <git@vger.kernel.org>; Tue, 20 May 2025 08:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747753483; x=1748358283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h/st2tNLSRQHqyapqAU/nnJ/PuvVkbMwUSEdS6Btx90=;
        b=IkmFFaq+rLW3oXnennZDZn3NKNG/miFnHmc8jWpLK4raBnaknilWDQwT4YDJJCRx37
         sASIjvHpwN16R1D77Hx5wEinwFfO47nfb6Gsc6u+dW4sNeUk7r8+QvyBsTqNSDeY7pq/
         hJ444paYvTf63KttJSngOKnkPH5Hc+LeNn+fcVuM4kPKDCRuiwtFdNOeq9VPAy4ztmQp
         9HufOPX50MgkANacjNPQ36Ml1/K11hO5eoarBid3dmXT+T3oGr1tkdjfvZ0p0ZIUKtaK
         1XWgP/BTPgKmxlj4OW3MuWhxu2svG6Y6282MHxjYCbC3umCoxLTtjOmbtTpdYTfdQ5y0
         HktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747753483; x=1748358283;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/st2tNLSRQHqyapqAU/nnJ/PuvVkbMwUSEdS6Btx90=;
        b=ZrRzFsZ0j4oR47ahRF/jwG/yls7Sf1OPAhCuYTTk+/trjS3BRWbHrRCi4odBP+wJ9V
         XywobcUf93t9O+Vd8mX3zgUbGT7088QlUovQd5CgQpfTAVKc14OyI6PsBgG9F0YKfnKR
         3ZW4z9iKfgjds+c36mfYdLAPaXXdRe8M5Pm54rBrFfhweAUA4Lqa9rggX6sOJAxmRZ1f
         dlhIEo4u0yyaf69afo94PhS21rC8FR5vWdhQZBkU8ximoIPq4WMxTNmM3p3yrFcKqV1E
         3zhloNTPnmNmZ+WraV/VMK2GGU28mR1UAntVMpIH30XfonKqkwk0cc8oZNK+wFyrEmgC
         J6SQ==
X-Gm-Message-State: AOJu0YwLN+7paHT475DjqTWhfZCMVLp8wngT90+bdqMbhhHvxAtZDZ/h
	uyqXMKJ50Zd+/cJFWPSOy1Jb9hLgKgdau+WgS0dfA4z9WENf37ytp6Xt4Pxxmw==
X-Gm-Gg: ASbGncudMegxFijveF9VsSMm4SZ6eVjdwZTOJu9rNYe3jK2YAES+UrjtPG8fPZxgbi4
	aOxe2l0FY0t2mPny36BfJ/3UbKCKWiDA00Hv8QbhnDcY5FbgUWUeuxNDgri0XudPOuFZiEasw6S
	KViRCAO899x2lbumvBgBQXMWuUWBkXsfoF6ZSPQAS74EaGZIXMNSlwn0O5fzqPMH+7xpA1Pn8Zv
	VtgA6DBTmzBxMTpslhpwZHBMsIOJRS6+WgrLX4dConJ6opdItCXKZzJovdr21ia6Dk98rEh66r7
	C3YQhwNnQOGyUjDuZghlZPnHKdZhXpSY95wNZc+SZgYgNUdpLiEA62k36NsENbVB5ec=
X-Google-Smtp-Source: AGHT+IE/xew5sk3Z7iXYOOqDkUP15xTPetyx+3bROa91Yovn7x8LfHJ+jhYRYtF7b5DZdsy6FAo1rw==
X-Received: by 2002:a5d:59a6:0:b0:3a3:7752:108a with SMTP id ffacd0b85a97d-3a377521242mr4358987f8f.25.1747753482859;
        Tue, 20 May 2025 08:04:42 -0700 (PDT)
Received: from berwick.broadband ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d105sm17014029f8f.11.2025.05.20.08.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 08:04:42 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 3/4] midx: avoid negative array index
Date: Tue, 20 May 2025 16:04:26 +0100
Message-ID: <688b0273604179b5bebe3748445158e09a7bf1a0.1747753388.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1747753388.git.phillip.wood@dunelm.org.uk>
References: <cover.1747753388.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

nth_midxed_pack_int_id() returns the index of the pack file in the multi
pack index's list of packfiles that the specified object. The index is
returned as a uint32_t. Storing this in an int will make the index
negative if the most significant bit is set. Fix this by using uint32_t
as the rest of the code does. This is unlikely to be a practical problem
as it requires the multipack index to reference 2^31 packfiles.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 midx-write.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 2ee381e8fcd..38a458d7322 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1566,7 +1566,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 					  _("Counting referenced objects"),
 					  m->num_objects);
 	for (i = 0; i < m->num_objects; i++) {
-		int pack_int_id = nth_midxed_pack_int_id(m, i);
+		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
 		count[pack_int_id]++;
 		display_progress(progress, i + 1);
 	}
@@ -1697,7 +1697,7 @@ static void fill_included_packs_batch(struct repository *r,
 
 	total_size = 0;
 	for (i = 0; total_size < batch_size && i < m->num_packs; i++) {
-		int pack_int_id = pack_info[i].pack_int_id;
+		uint32_t pack_int_id = pack_info[i].pack_int_id;
 		struct packed_git *p = m->packs[pack_int_id];
 		uint64_t expected_size;
 
-- 
2.49.0.897.gfad3eb7d210

