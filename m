Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E952B2FF167
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270423; cv=none; b=kDYXpUmw7asQ1JLZAS+NngMwQPOWCbr2a/OCMtpEjr4GaxhSzn79NQp4pnCguHClOEAIY4ZQbgn9z7KRGKvIglDQ7J6zKcYTBEp3QZmKML3y2hmais2idDs5ibpqnEtFb6/s0NJ3KsgHlVRVoU6nc3Vv5WBgkwLOL21jrD75OCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270423; c=relaxed/simple;
	bh=QHetPRGrcuM5V+ERnqbQCLSo9TXriaJ2rguGGCQNy74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E7TCXwLjoUCP8SoBktx6TLFZembc3buDUwacWn6PJ0xHHR41aViHpsRgR6AfBjrWonIwKNcCiMzA652b4EiMkgf4Es8jsg11FfrWxf+Ce2gUHGdbJ4C5vpn6ii+MBt3LYItBqerqOINty1dsM3YWiJ+iuh/jgGvt1nFKGpeL/p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcDKV0vu; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcDKV0vu"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32e372c413aso1903000a91.0
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 01:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758270421; x=1758875221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uoJq2Dr96DiMOIogUmqb9IQjGPTBbK3UF+1Bo/aC08=;
        b=JcDKV0vu1PL7ilw0WVMwQ50GiJs8mX6AxHS/MB9DMtzQfzRarH8BiIeImCZwG1zmq/
         0qEqCeTpoepo7zHfDt3ycZoHiYZ/dd/4s7M7HDo0S3CxDcrTTk2iEVR3XzOe23SVUcAj
         lnADPSz5lpPx5IIRcf7NMgWGmOYadhUQjD1pdu8zPdeIyyYTfSrvI3FCIMZHLiI7Ohup
         Ljifyn2Ic7hfjoIHhGhg7VzppRojBVzjQ6dFp+2JW+NeOEiD8dGQeTLguQvICOCjeAmw
         4EZvAsAe607eu+C5D4+7NKhwtabhD+bKG/uWNl8OJpowMuyCUJ1K1fo5b41xx23sVVzE
         h36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758270421; x=1758875221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uoJq2Dr96DiMOIogUmqb9IQjGPTBbK3UF+1Bo/aC08=;
        b=NbV9IASiVcSvA8AQlwpV0+q+svgj7mU1z1uqIs2hV+qr0/AHkjITnGG00QqoacG4Sh
         6zubVatkwYPjQtXzOn1LerVZuLwe6+AyrbU31uDmIVQhyYrYQifpIGwSneRsHGiqvDpa
         qGBBUG4Zt107RiEfDUMVxcHRT1Sr+752FRfCwrfH8auM43Yhm/HXlWe+nbCdvsUdBwUw
         1avnCl2USW/SSmq9nSyVtCkYBHAI5o8FGLkFHJQju7op+jXxCVv2u5b52Re4GR2kwTtY
         WgWKQg2ZXecYexR6U0kwoU2TenEAIux05K5qYhpSuEVLNnPQYxjOQcMvQ4etDTESLzPa
         Polg==
X-Gm-Message-State: AOJu0YzZdGTuB+K1nALzvh4LxskONgMf4qo6R8eS5Bg2Dk/E4gTPkUR8
	1+7Wf0ziuR+jFF4u9OuPDi185RtjOiGbPSZ7Z41+shgYM/FgeiN9naAiyjcqBA==
X-Gm-Gg: ASbGncuLsK30XjXHzQ+QypuPExkMg6hSG2Ta9d38Biv27a0N2zKHYflH3j1EsYNEMXU
	fzsEW7ZF24HaVKcF0cfBck2vG1SjPkUoS+V2DFXe1o60HsByHdkZ5vNWSCxzqzZgbtjLSSnOSWV
	OPp3meYF0XpnJxWW1IiZII18tN1VU8QDsClm+s4VwXPryfthx+pmu19/4qjmgVPCzvsjmQ66Fe0
	+/HUXVFse4N25DzFaoK5Z5WNW8heY8EZ1Cmn7rl8t0jy7PRZBPrS4uCSQ9HfXl+PYqpEFIO3mEm
	E4G1Ogda9PzOkxcEr0TsTt8r07oTPwH/Ix9xcd8gAcFOE2SBOP++dH9BRICmOpN7VZNemAtnSBL
	jEI7AfiQ7EJ9ImWzjcoWjhW723gWNLA==
X-Google-Smtp-Source: AGHT+IGUP2eLCjFmyEqhf3Wo+xZX3+YlNbqYfUKGvMtPYeSn85gZOXMygPKy34opKvX9UzVCsPw64w==
X-Received: by 2002:a17:90b:1e53:b0:32b:baaa:21b0 with SMTP id 98e67ed59e1d1-33097fdd69cmr3500337a91.6.1758270421107;
        Fri, 19 Sep 2025 01:27:01 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33060803335sm4774254a91.24.2025.09.19.01.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 01:27:00 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v4 3/9] reftable-backend: implement 'optimize' action
Date: Fri, 19 Sep 2025 13:56:41 +0530
Message-Id: <20250919082647.535213-4-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919082647.535213-1-meetsoni3017@gmail.com>
References: <20250918054704.544254-1-meetsoni3017@gmail.com>
 <20250919082647.535213-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To make the new generic `optimize` API fully functional, provide an
implementation for the 'reftable' reference backend.

For the reftable backend, the 'optimize' action is to compact its
tables. The existing `reftable_be_pack_refs()` function already provides
this logic, so the new `reftable_be_optimize()` function simply calls
it.

Wire up the new function to the `optimize` slot in the reftable
backend's virtual table.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 refs/reftable-backend.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 570463da41..5dff1e08e5 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1721,6 +1721,12 @@ static int reftable_be_pack_refs(struct ref_store *ref_store,
 	return ret;
 }
 
+static int reftable_be_optimize(struct ref_store *ref_store,
+				struct pack_refs_opts *opts)
+{
+	return reftable_be_pack_refs(ref_store, opts);
+}
+
 struct write_create_symref_arg {
 	struct reftable_ref_store *refs;
 	struct reftable_stack *stack;
@@ -2702,6 +2708,7 @@ struct ref_storage_be refs_be_reftable = {
 	.transaction_abort = reftable_be_transaction_abort,
 
 	.pack_refs = reftable_be_pack_refs,
+	.optimize = reftable_be_optimize,
 	.rename_ref = reftable_be_rename_ref,
 	.copy_ref = reftable_be_copy_ref,
 
-- 
2.34.1

