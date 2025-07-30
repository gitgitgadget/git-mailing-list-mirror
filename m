Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8132DF3C6
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 16:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753893844; cv=none; b=AcQhQwcj11ZsD0KN8esVykFFiqpwh4xyrsa+lecX8GeDoOckXkqK57H0mfWbakDAlgQik0q94i6CQ85ieL3uJS406DHoTqFyhrhDD0jf8ZWkhHM9/nk7g6PHNKsZcwDub5+Rwu4SiquLzB8Ktrdy139pdVdEnmmWlbEBXluQMYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753893844; c=relaxed/simple;
	bh=92MGJlMBOqRRZ+U6RIKGby45QWSGX1SoOE5Z7WW/DVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eC/YlYt5VNMmrgbvr850C6zHZfNdXo3BOBY3MVkDhIoyQVi9CIOX6cXmBL7Hiok6R4cY/GPSdm0p6kz9NnYEzSV4GSCPF88qrDY2Uz27L78Sc5PkF+cEUs09m35eeYdPSDgBiC8qZcHpq+U8EQjn2GrF+qX8Nj4pk7uIZI8RRA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5FTgX8j; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5FTgX8j"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-769a21bd4d5so22108b3a.0
        for <git@vger.kernel.org>; Wed, 30 Jul 2025 09:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753893841; x=1754498641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jv2FjXuS/2tr3eVml/kvAQRlvPvTy2fBPVRb2QMmRvI=;
        b=Y5FTgX8jXqtH+Rg56up+iMWvCIw5mIscl88JwfRSYa0qSL4dZH6DwqGet2GNzVqDpr
         moPAaNh+FwYldbDPjpeMLfpNYsx30Q+3Tn5u/XOPV2nCpbMsgwJk2Fl5Zlm4AM+Ps0xs
         1JMYif7uvZJaFQLVJKvYWNbBnHwBk6AxnAbJ0DLNjGSI/yw01OMC8cWgWczUT4VRNMti
         zbmg2TE4nHU8ZXnD1le4XEB5a9B/nf/7H+evpIBwZQpZIliMLcjAJ0bACW5F2IS6ccao
         JhDhESesEGfAMDX5LD8drGZxbeKvEMXAr3sMfJawJsvZJoSd6ch32naSxETc7O6r1C2n
         juuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753893841; x=1754498641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jv2FjXuS/2tr3eVml/kvAQRlvPvTy2fBPVRb2QMmRvI=;
        b=xEAZFYU0Bpc5+RV3dOe8ZmSrdzR+OOfES9WiZu/r+KHCSqnO9NuzzajOP2LjYAFiKh
         QEJITNBW5d4duOHrCbOdv7DsmOtP10FdWifuSxnTLLPYyrTdkYYe4080Vp58q8q+xey4
         bAdy7kIVyJnAE2YOlmRU8lBeSVWBitY0xJY9mDc/ri0R5wjGvl8DBj+Y7UFWY98/LdFw
         w2wYQIOs0dFsqkRbiCOrUxBIBsEtuLMXKv9blm3Zw+aBlbm8vAnVIPFyjdeNDxI7dmSj
         7hy37Astd3opAcroHQiGV/G70oH7eQwrqrBxwPliv4NQBZ4Jic2l/JQlGCJ0YnYBqKVK
         zJ+g==
X-Gm-Message-State: AOJu0YyggBTIkOa8VdA1zxxYQmkjA5UdvJ/cn0cecdudd+Q3tVTkN6t6
	F953Huq158/FXN37M5lcqxPnxv/yEPz3XdCY9+nncncUFVX3W/RiERdi93Jz/Q==
X-Gm-Gg: ASbGnctKHO0WySxSAX6t4O/Y8MCCKfWa3mvo3udCl5XCHrL2PIZ8t59cORxjEMyjSgq
	avnK+hipNk64iWN8uJP/NA/KGqZWtzsy4PsllJIuq/HafYoV1d/d3sB34//qwMOLJgLWtWA8MAS
	YABbCHwK+QF/nFinjIk2uP4GZNjKXOCGkBjeyjwW6WFglxKyhZ4PnGmUvUxpkmhTb1u8JMd/1Mn
	h4gm6KC3hwCKq4kYbWsYbgHWUnJySOmHn863h63u+OSIlgBZV/KAa+ov+0TI5PfbiDu6oWXgpPh
	eU5eNkx8bhy5fl44uo+Pf1XEYrwy3Mh/i/gU/ND3xeqYGMyOMoNQjcxdm1XWn6kB0vhpz8mwLtY
	FZwOlxF1GOVIhWRq8NznJVQ8m6VzGcUV4vh2omrtE2vTgHeZVcnVRaIfGPk7TK4Zyxmi8Nrcs
X-Google-Smtp-Source: AGHT+IHFsQSf5+0I/ju9p+v2nPF02DSKt0h8my2rI3EoACqmW9GVVI2lYQhRww40iGwuHDP3XkHk/Q==
X-Received: by 2002:a05:6a20:9392:b0:21f:39c9:2122 with SMTP id adf61e73a8af0-23dc0d84dacmr6443847637.2.1753893841068;
        Wed, 30 Jul 2025 09:44:01 -0700 (PDT)
Received: from localhost.localdomain (c-73-70-17-6.hsd1.ca.comcast.net. [73.70.17.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f58b95esm9671536a12.16.2025.07.30.09.44.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Jul 2025 09:44:00 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH 2/5] git-gui: fix dependency of GITGUI_MAIN on generator
Date: Wed, 30 Jul 2025 09:40:49 -0700
Message-ID: <20250730164052.15371-3-carenas@gmail.com>
X-Mailer: git-send-email 2.50.1.475.g795bb014d8
In-Reply-To: <20250730164052.15371-1-carenas@gmail.com>
References: <20250730164052.15371-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since 854e883 (git-gui: extract script to generate "git-gui",
2025-03-11), the logic to generate the main script was pulled
out of the Makefile, but adding the resulting generator as a
dependency was missed.

If the logic changes, the main script should be regenerated, so
add it as a dependency.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index a87dc06..179857d 100644
--- a/Makefile
+++ b/Makefile
@@ -168,7 +168,7 @@ git-gui: windows/git-gui.sh
 	cp $< $@
 endif
 
-$(GITGUI_MAIN): git-gui.sh GIT-VERSION-FILE GIT-GUI-BUILD-OPTIONS
+$(GITGUI_MAIN): git-gui.sh GIT-VERSION-FILE GIT-GUI-BUILD-OPTIONS generate-git-gui.sh
 	$(QUIET_GEN)$(SHELL_PATH) generate-git-gui.sh "$<" "$@" ./GIT-GUI-BUILD-OPTIONS ./GIT-VERSION-FILE
 
 XGETTEXT   ?= xgettext
-- 
2.50.1.475.g795bb014d8

