Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E9463A9
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 05:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710565341; cv=none; b=RN2Hq53J5OZX3ubPV9a3bBKKxZLGI846NPx1gbFgNn2s0XoE653ZTkfZnUGKldBPKrxvmyhJvDXR/l5bKjPMchx6w+bmNA8KjH7ftQnwUrLPxo0RmB/rE869dh9k3PjL2NZiKWiszvddRybdHC7HN0gBRkE546i5al2ReM9DaCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710565341; c=relaxed/simple;
	bh=iRPFi8LIr3SIuC0n7W6wr10Bm2ZATm3SUvGOzp0HoU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHLsQG/lfx6YJDhPRpdk7Vn92KNodZeTXFOX3+bAjqwntPauzfiNkV7UOXhDumxxSY+Hlm8oFy598fKpE8M1KB0OqdvJ/xUhUHlEYTZnv/U/3lds52Z5KXBs5CKQm7x55B118RV6qtgSJswArqrnj2AAGwgHSL6R25NSZy27Kmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpdhyQ7D; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpdhyQ7D"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e675181ceaso1410639a34.2
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 22:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710565338; x=1711170138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUIONtJ5KEoQK/94CQIULSssl5M/JscsMh01aE/FDD0=;
        b=YpdhyQ7DBGFx1EYxrxp5HTnDJGkihOkOIIXajXxtQ5drdq4vA9a/TrUs48zHgPaQX1
         +nWRgWEylj+aakRpDfytw2RSpWgk2uJ734Cx75XOT5cb7dS59tzTAz3h9EpgQ5vl8ZgY
         vfVmx8LEcwRXzT/0+nanu9UTtc4CwQePz9tZu2KYxfvnHlweVsxAs0RbrFBvw6qO54KS
         DeQabuLL4M9DauaO53qo1/TxyfWb2AQGoP50Cz02Wtn7rCiZNZEAiNFy8OfrPo9PsWZh
         VucKQ6mv2Y+ZN8tOS+4kyxn0joy90hWxJ1X7F0M6/lid2Xg9+n1EDpAD8yM7YLCUAyrz
         Y1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710565338; x=1711170138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUIONtJ5KEoQK/94CQIULSssl5M/JscsMh01aE/FDD0=;
        b=Wh46hYr+3TOVgndJ8tO4wu3xzSpw594kR0DvK6Z9XNAkaT2tPyhRIP2KvKK0enAY53
         Tsps7OMoDRhxLESZikkMUbNSe8nKTUCLiYkG8x/1A3sVPqhp5jdFkyjVczkBh07A7hek
         UYiv3dCHEbqFUb10Hed54gtXazpF1sxb9I3c83moKbnZG9qkxqN4qhVBy2tJE19Wfwfr
         g2wQww5hLuofF2MeHFRxZp0HW5wak+xV6WJq9m1i5k3QGj3GYVg5MM9MXZJKCxRWukfl
         Zo30kKNKYw7w8UB7yd4Ojw4hJfTbQLwLbiZBJzAGxFqL3XgWmEGdlVZzN9WRDDLdvMTG
         qlag==
X-Gm-Message-State: AOJu0Yy+R223OKVRHNTY2DZRyfOBMkL6HgikN/TmObJ9hR+hgwh7IkPZ
	oEutdhBzqs7CPRNOK9w+q5W77O1rSIVu2sTrvi7GMc3TEqrAWyJ66uEA0U59
X-Google-Smtp-Source: AGHT+IF/zSZAYcs3HBSqJcQFoa9ryYfGAajhVBzYwlDYl1pLKFGuch9pZ62FVjfBD/UI5avDKFk6tg==
X-Received: by 2002:a05:6830:613:b0:6e4:d93a:a0fd with SMTP id w19-20020a056830061300b006e4d93aa0fdmr5954508oti.9.1710565338107;
        Fri, 15 Mar 2024 22:02:18 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id f6-20020a0562141d2600b00690cba72427sm2765420qvd.33.2024.03.15.22.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 22:02:17 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>
Subject: [PATCH 2/2] docs: fix typo in git-config `--default`
Date: Sat, 16 Mar 2024 00:01:25 -0500
Message-ID: <20240316050149.1182867-2-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240316050149.1182867-1-brianmlyles@gmail.com>
References: <20240316050149.1182867-1-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---
 Documentation/git-config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 6876803253..a6e82b871b 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -286,7 +286,7 @@ Valid `<type>`'s include:
 
 --default <value>::
   When using `--get`, and the requested variable is not found, behave as if
-  <value> were the value assigned to the that variable.
+  <value> were the value assigned to that variable.
 
 CONFIGURATION
 -------------
-- 
2.43.0

