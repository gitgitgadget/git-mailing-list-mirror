Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B003299AA3
	for <git@vger.kernel.org>; Thu, 22 May 2025 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929349; cv=none; b=T4CkLwZfUsYOlYQ7vcVheVpe02sXX+g8fwkDenFFBSjFF31bsB9w6zlrpq1aPF45NEV8uiKw6pFb4dnP7ueFRs4YRl1B6hcE3K751n/W7OkzPCtqskK/4fRyD6JID649YD8C8SaJdwgOBLeqfa2uCvlhR+KY7JnkVTYSZutNodA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929349; c=relaxed/simple;
	bh=RGgXQyyiaBRS5275x++TKTaIFD4dsqICCDM2UL8P97I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBmI07Jnol4IgBUyC//Mpjy/BqWZn//ZaGZbpcaTDDpA03xsWh2iBTTIFGa3lyb85RBQiSs4qUKPIk/xVZuycYzfn754uoP785eeK5A9RNef2YPBK3pwmVeTsfTjy9eg1M/pJmvwGcPZEFhgXruBRpKVceD8n+JnwI/vHVcQurE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hE2Zm+fH; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hE2Zm+fH"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-441d1ed82faso64295275e9.0
        for <git@vger.kernel.org>; Thu, 22 May 2025 08:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747929346; x=1748534146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bf/05Aqs5K1EWabKPGByvmBgzWbVHtezC2xYvfQs9KM=;
        b=hE2Zm+fHCiuTX9+88foRJVuo/VIi4PEnQG/6Toewa17HYpLv9VXEC6sYu0exs8qwlF
         G3g0gY2Taug30bPveAc54MgXBlZ4rUi48ccYGNhd8jvDSiyazt2DFdEf4W+IebhZuJst
         zKZOIG6hHU1jDaJJUiS7P5AIqD4RarHbbNpNl+tDuHCMYBRTFPpkI+YlCsbNgFbTECnS
         36eSJLVh42/QxIn2wB+qg913gqbRiP4s3kc3NlLZOtk5SolgfdjyGyMr0+fYKSUmhdrr
         GJm+4qqAnVgrEqme07JXll9VrZXv+gP5fnnG+ov5uqGJfcIMsoclmh6rOYP2f75rpKLD
         eGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747929346; x=1748534146;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bf/05Aqs5K1EWabKPGByvmBgzWbVHtezC2xYvfQs9KM=;
        b=vVJE0Tyossuj2SYHFrW5Am7TPND9OB3dtOAzOFH9iAkjOFw8RJArvgtAB+lRVpHQgN
         iVtkFGaviBaZA/ZNflpZML0piBK+HnLsZdtDZtwX6xgeCDHr2w9IPq2eu7OUEp4uosyM
         ZiGb+jNAGpvZ/fj82YWMHToIiIexecX0B/+echAneubca2tOlmbBDqTc9Gum0KL/6Qwm
         uLT0vIFWPREbZqe4RU8/0jlkhSy8xZx0hjCJb38xaf6WTv2daw/NZM/V14JpE5zvYvGb
         S/71H1E0BK9185v7/oMyT+vsYNNWljWCBDrjhUUieVuAeMk0mttVwuqaTaxYdtH+PIjM
         /8Rg==
X-Gm-Message-State: AOJu0YxAff8epOk3uhgJ+aQAorNaRrPUUauSdQoLmAAzRWhJXelCGjPl
	HG1BfpkXvxwpva2vuffomOJBOHH8NPLfEzFwxJAe9/IM9w09maw1zzxkOXQxRg==
X-Gm-Gg: ASbGncvs/fxeeDIzMTHSORIvhIAwb6kn7O23rIMIvGSfKzmqzvOx2SmZxLZfHTY5QTi
	Wr1aD62+16N4/HYrdvChZ+8Jjtwv6iVn79eIptPuQGh/HFcq7E0rglVPUgIyKUb68wI7Kx/q7mR
	7c3ijqZbRJK2RUnIA3QW3c8y01eFoIUhXkmkIIpi58BHEWl4B3uwag1Ev6z5I5Cq4XucL5gEtQH
	aIgI6430r/u3Bpv0SqvWuY8iCT3Qu3pl+ucTekaPTjt4w8ImHrAOy4ng+/65XkkUa7RniM/7kDl
	qvjCGnZDKnVQMN71boI0Iybar9G3/Zqh7wp5zE3KTLk6QGd9egxS0X54TLuZgJBuSys=
X-Google-Smtp-Source: AGHT+IEFr2s5fTe0rs9Djc/m4hpkeSotVadgfNWdvoPsyDuJXQQ5KgqTYFqz2JGm6ZilMXXa3wcxcA==
X-Received: by 2002:a05:6000:26d3:b0:3a4:7373:7147 with SMTP id ffacd0b85a97d-3a473737314mr7039486f8f.25.1747929346268;
        Thu, 22 May 2025 08:55:46 -0700 (PDT)
Received: from berwick.broadband ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a369140048sm19253599f8f.57.2025.05.22.08.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 08:55:45 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 3/4] midx: avoid negative array index
Date: Thu, 22 May 2025 16:55:22 +0100
Message-ID: <5b6cfb9d212552918a827626cfd9065d40be30f4.1747929225.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1747929225.git.phillip.wood@dunelm.org.uk>
References: <cover.1747753388.git.phillip.wood@dunelm.org.uk> <cover.1747929225.git.phillip.wood@dunelm.org.uk>
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
index 8121e96f4fd..ba4a94950a8 100644
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

