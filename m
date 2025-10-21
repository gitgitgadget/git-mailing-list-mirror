Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F75934F259
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071199; cv=none; b=d4oSrn0p0nRPL085EYylHrj0nsXID888cRQqYVCu/Mw1p6bilXgrNHx8/zZ04dRUhHBVi6qqyVYurg0syQB/Hsa9mYneGWJbUfobLxPWJ+63BuTbnqFujHXM416kjt/Mdoei+m1RdXHjgcn6C2Y2IFC4iJNzT1tcnd42IRP6etE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071199; c=relaxed/simple;
	bh=htbJqM5wvvII7KGgbvF/ZIu5+sQaFm/imRpOhQylIEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSgTu/hP9ZmJhhTtWh0NswRocIXU4mSPx2G4Mr7hLf+eorXmKd26K04q/8CR9wt1beZN3wNK1hSm6svp95ITgdhyglSfgE3gAd/inpXy3Y8IIxIp1nI494TIdW3dugpUthphE8ZsD81f89en8oIR5sfViPih5gn3eADPXp+SoWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOGF5Bzh; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOGF5Bzh"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c2823c3475so3091374a34.0
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 11:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761071197; x=1761675997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOcOhCtFL08Rguip5ezEK5IYW+3bSj1GYD6zFl4VYq4=;
        b=fOGF5BzhUvcBHPikTW/TKCsGugNVtyF67hXCtMwuQCfXSRGMb+bgYxXm93GukTytXh
         lAT+0BPgJ+OEJQrqlbSZrHVXMuSqdcelKTtW2NAEZTiWS7NajIKSGxmtgH7T/ceQNOD8
         2Nr9x0B5Siu8xSW7b8H3oqv8zwumQV8I0omeuOMUMm8QO6Jfu4yCR7ex2GjGHA9jYQ8k
         oibRRl5WOuEzll9LHHTuJjBT9/Y7T0MwNXtAazG4rjgdQkqhJ7e5nS02VC6+fTDsOdXo
         wLMffXkMDuGN4YcbUeUf01yeu+sF2Yivikh1XBVP2Zi1fU9mbt+uWKzBNX160inUuM9U
         cOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761071197; x=1761675997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOcOhCtFL08Rguip5ezEK5IYW+3bSj1GYD6zFl4VYq4=;
        b=mj5AQVWMzcpkHqGnx5RjdM0uDOP57+yU8YnQ0RIMFlbELfbpzH0MYVwuzaV3BcrINm
         KCvDVSJg91yRfmy6OHBq/i+PIkouldeoIAt/hkRjBsERZ7Qfs0G5yU1++P+LdkPPL6As
         qLTuQLAiETMVBtzzXj/3eKgOvuTuU6Pvid/SeHYIvUNDjZUlanYFqN403WiWA3VoVcr1
         wT7lNOw9h9q9TpKzjGKWmKRqv9QomDYPCYvEdQABJwo9hEQqfr9I733fStEGADXYEv5w
         0sDNYuAjt4p8x4ii2dEDAK0Ts0MMeGms7RUAWMVKLdlOyD7rWXxq65IIFRgLPWmVO5m9
         pWew==
X-Gm-Message-State: AOJu0Yzu0CIoEmFXlPpMsL8txCF9gQDoMdUQ0V2QVQhzilWNZ0HkKm8I
	xRnCCnKqW0f9YC0GVtUKasAD28IDypVh6Wzzt0yvv/dGEpqQO0i/Ug1+6X+PGA==
X-Gm-Gg: ASbGncsq8dhpmKVYv5qD8E+pBxoWrj5ISJi04xKQ3MOss3pQMyUHqcbN0yCVaYt0e+2
	nZdY8cZFm9eAXGG7jo6XPL6zU+KPaLAYZu1jKFgjiu2/3yN2IxzVWi6vfl/LgcQw2P+LxhOFe2S
	6Vx4EP7gYw3PzqhylKLpfufYr7cgt9YsssCmPqedWDMsXLe8SDQ9DmDqyc1APm09zg6k74Hcj4Y
	K9wQluqj1j2kFIR9FdkJLDxPzxhIFhHqRdfk6P185ychxShoDTruKks9HgkqvddLaJP6nv2Brl3
	Rpqdoi4mviqQCkUivJ/EBaTt10iRi7La0Ya9Fyi6RYIbJ9jj7SJuh3uZxgXj0aBB1pad27RwZ9Q
	Fp8l1IierAx4DSMn4xZryMHYIAAA5s+DGU3uMyco+zO9GpzIsw55ez0Cg5XADz1hvaL1SaqepNB
	YyYzEEa9Ni
X-Google-Smtp-Source: AGHT+IGeSPCroS7mMVGu2S/GMlhZtIdjr1YIPAeLXIrvwBge65rpo35NjUQl19YyUfwV35J0TrRLCQ==
X-Received: by 2002:a05:6808:16a4:b0:441:8f74:fcd with SMTP id 5614622812f47-443a309882cmr8445244b6e.58.1761071197360;
        Tue, 21 Oct 2025 11:26:37 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-443df722e5csm2795853b6e.24.2025.10.21.11.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:26:36 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	sunshine@sunshineco.com,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v6 3/7] ref-filter: export ref_kind_from_refname()
Date: Tue, 21 Oct 2025 13:25:57 -0500
Message-ID: <20251021182601.2687284-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20251021182601.2687284-1-jltobler@gmail.com>
References: <20251015211213.361797-1-jltobler@gmail.com>
 <20251021182601.2687284-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When filtering refs, `ref_kind_from_refname()` is used to determine the
ref type. In a subsequent commit, this same logic is reused when
counting refs by type. Export the function to prepare for this change.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 ref-filter.c | 2 +-
 ref-filter.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 2cb5a166d6..30cc488d8a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2833,7 +2833,7 @@ struct ref_array_item *ref_array_push(struct ref_array *array,
 	return ref;
 }
 
-static int ref_kind_from_refname(const char *refname)
+int ref_kind_from_refname(const char *refname)
 {
 	unsigned int i;
 
diff --git a/ref-filter.h b/ref-filter.h
index f22ca94b49..4ed1edf09a 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -135,6 +135,8 @@ struct ref_format {
 	OPT_STRVEC(0, "exclude", &(var)->exclude, \
 		   N_("pattern"), N_("exclude refs which match pattern"))
 
+/* Get the reference kind from the provided reference name. */
+int ref_kind_from_refname(const char *refname);
 /*
  * API for filtering a set of refs. Based on the type of refs the user
  * has requested, we iterate through those refs and apply filters
-- 
2.51.0.193.g4975ec3473b

