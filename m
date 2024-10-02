Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A94198E63
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727908708; cv=none; b=kHH9cVS4i4HybEohugLKTAZSdcvideDe8ieBSlzk59MYLCqdzBHoHLAVI+Rzz/ZiY9SXe8/uAlA2mhkTI5HefVrU68UxDDHla2zXYXof1aHX8DZWktOnpkfoMW3fVrpNb6bGgLXD9vdzJyOFWtSJET6MBGFnfFhwD6acMLwLqYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727908708; c=relaxed/simple;
	bh=zoWJaSRe96OXLoGPg0P7JAIOG1J2Fz3Ag5ttYVmGW3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pRQcaPW7zKwcS7TraZUGJTpgC2+CKYUqSPOtmHNBPelMokM/TdHgGUhfCr9WcqWtu6uIzYZUmkr6HSjbGj4xnZAqo2CoKZOEibwbi+AHhZBi+B+S0/gSWVNc/G0nLMxc6suzi471rENHTdPGUFM+kqu91WRb6dFNkEp7NeHkrlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R46UKGDg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R46UKGDg"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42e82f7f36aso2122535e9.0
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 15:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727908705; x=1728513505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOmb5iznCNW/u8v4cxIzpprRDY+indVcQH2aXHDGm70=;
        b=R46UKGDgldykZgDUuy4uYg4a7enEsRUNdlhK8H7KDPU2gT2iGCOeNSz5ufUy421jrz
         +FznuO9gT+diyNRTJr+pheiKQDlikbTs5g8smzUjhPGxz9klqo+iy8KnfQ73CqETnNSG
         dWMD7rdpwHvrsSY0yrT2NYxNdSknoK/dH/qlZR9D4W9j1qRkaF21f4dNa9dUuJo1rv9V
         h7/IfINGgwNiizx4LypW6Mc4jIuzCgp3oTXjR0IaA4DNIqqjNz90ydL6jL1fWHDFxmah
         EoiHIX67LTs+0k5/M2OJuyr8bzZW9HodEZN8++htDYycb38xLNMA7qIvnd82w1v+Hhzw
         TqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727908705; x=1728513505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOmb5iznCNW/u8v4cxIzpprRDY+indVcQH2aXHDGm70=;
        b=ARW1K1SnCUuDfpfvp+MNPR+LuKwoC4weqWv5PWkZzQp/cwddIey5bSnhqbqgachK7u
         GrKgF1AqL835wgQnkiN8W88ObZJ/z315LO1GHL+syPhNRanaQaCyht7o6QfxHTXWOC6t
         bYFzenx9njsqxDFNepgGMox7mitep8eIEkOgpAMfmclLVvGLY0GLhZf4eNYhZ4WRY5kf
         v6XrixZRehsux8NPA1j7OkV2HxWSgKucQpK/vZ8IBMR5lxEWclhzCJI1g3RSnrMbvXtK
         lPDw9T7YP0ao5EGp0985A4tfj/6wAD0ht7mTgzTTkF+ELNILzBH+YyAr76csnC4JYo/l
         yk1w==
X-Gm-Message-State: AOJu0YzgWAxe2QBZVyX27gRr0+La0AAfhHQBu3YF6+JMfbijHeHQFxf6
	6aMal0UmDAFAN3qOr2xAnMkd6bWoLT9XddP1yTEZUdBnXp1VFizn0vHa0Yaq
X-Google-Smtp-Source: AGHT+IFsqdoRS/FHjo42Zaha7b4W3xHUZpEQG4MI++bT3LYLEOwwTRS3n9qwkLuJH4XCdvMZiWr1bw==
X-Received: by 2002:adf:ee4e:0:b0:37c:c5d6:b2d2 with SMTP id ffacd0b85a97d-37cfb817f45mr2813748f8f.0.1727908705236;
        Wed, 02 Oct 2024 15:38:25 -0700 (PDT)
Received: from void.void ([141.226.9.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79eacba2sm29753095e9.14.2024.10.02.15.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:38:25 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH 2/5] reftable: fix a typo
Date: Thu,  3 Oct 2024 01:38:13 +0300
Message-Id: <20241002223816.14858-3-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241002223816.14858-1-algonell@gmail.com>
References: <20241002223816.14858-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 reftable/reader.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/reader.h b/reftable/reader.h
index 3710ee09b4..91377b9ce5 100644
--- a/reftable/reader.h
+++ b/reftable/reader.h
@@ -30,7 +30,7 @@ struct reftable_reader_offsets {
 
 /* The state for reading a reftable file. */
 struct reftable_reader {
-	/* for convience, associate a name with the instance. */
+	/* for convenience, associate a name with the instance. */
 	char *name;
 	struct reftable_block_source source;
 
-- 
2.39.5

