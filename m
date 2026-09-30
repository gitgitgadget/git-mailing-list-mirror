Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F0551D520
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 21:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803555; cv=none; b=VdsX2HXSaF3Derh1PViWfTk7zMBRlsM5wCnzsp9bCRMVY09BTGkiAORmXYTR4c7eZ5AqJPpOPV3Cpp3apWgEzlluAyjgeomQHV/9ieWRz0I97E+as5DCv2Ya+j3Wa7Np70CzJPsx22zYYRKs91btNH5y+AtFhwxI5JNQvK9S4VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803555; c=relaxed/simple;
	bh=nmnT+BxbiKicnTMIzE0Yj8KI0BLjqIhI30o2ODkPOv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDvpf0QfShI1quYJrUIcOcG0nIGJh0jgnPfBO9SrFIZN3DwTuUVloBAa+bA871jJk4T6UpkFR0o4cueNqpFWpzzxzZlWI4oiGEhkl54MqsDDYwV5NG/HFtxRHjFAadJN1fn5mNjkqOtOxiu7bu1RQEhNKSnVdhrgfG0YoFffMaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkBt8J9E; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkBt8J9E"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-67109935888so5666060d50.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 14:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790803550; x=1791408350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=66djkRtAq3SzNbU24/rC1d9K636KQEvK0LfSphyMTO0=;
        b=mkBt8J9EETlCGz/NUa2o+Krss968tYtXJXRNp48Zo7/30TkGHV9nBhzVB1OCtIAFub
         HEp6jPRpGFVmyW0bo7MjPIft2w+2aZtt2ijlK65VCYqPxhvbIud743Ak2X6SATH3o6dc
         MMg1eF9UBZjG4co7mOt/yjBC3KRSSvNZFMwV8z9XXypL1hlg4Nqj9CU9H05PvQKd6gGI
         MABQ0QWvyjiLBPCwa9Pbu6+5FwQ3i3qhkTKdxt2zPoXQBAJHAqRZEwD/2DLP0DC186l2
         sFtufId9MjFFZynu7sipB6ftAQcTBs90nZB33JQjqxPr0w+Bn1tjmprspYw5Pgd7UHc7
         PDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790803550; x=1791408350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=66djkRtAq3SzNbU24/rC1d9K636KQEvK0LfSphyMTO0=;
        b=k0ICozp/lT5glLYbzrEp/ecsuO8327EReFPmtTJnk1PIKQtZ8BInzxo7s6NQ/LeJmo
         AulkN5dp4eFtGxfeAJ9F5qZpG0kb6bb3UOar9UH2xX9Uv054hin2PIraszWuq7AAgMIM
         r/N+OtopGkFqgBsCax1IGlM975SAAdlWNGw8bxH/IBRAzQhbuBD3djjcsmAyBZU+v1VO
         etTScX3gLgcrgX2U+ite5axtdArIO6hXIsICIGlFKjKSm1G9kSw10gok7Q2a+hzJ5Pu+
         zaBFh5JfFF70A5PhwoTmh/IEY8tguM8TT4dS3cREhepy6WMWYKmKJr1eIC/S2NaM10Jr
         Jc6g==
X-Gm-Message-State: AFq9FYImNaak+RT1+LEZCPmHRCfb6wiFSGQcEjVjUXPDMA7odGo3LLIG
	GvSGembXaD6rBkn3VocTy+GF+3Yv3OAtQP99jiFN565GelJaITOZRIwI4ClXX9pR
X-Gm-Gg: AYBFou2ioRE9Q4/m6aBR3kjmxvpV+fyCUrp7G3B6/gY1EX0KSGZgWtMsW1qn3+9Z1cO
	ohLdIDa9fBJjoQpfnXXPiHohl+BF63/hvIEDx13CR8nw+O7sUWXc0vDg3ZnQ80isgVBIm7TCPZy
	0muXPf5ggcVAuvjXu26pWr3imXOmyFEmyJPBrUCNtRMXYAG1ByrjbL2bGfOIyvBOCk94KHAP55X
	5B71GA5tCsvXvEi4Hc30hU7o7H5IpCCOY3hx6xFO/Rezqfe0TLLyEGZoZiCkZWNqTI444lvDpPc
	DkBqcgUp+IGR3+VZC+F2aader+VeXMbOEAQrF4TGOTztJ2fto8RzRqDLEoZfafdA9nk1mPTljQQ
	FTIp1AcJa5cjBGK95WvjHWdVRJKQVc8KRdo/RdXoSOol0KA66pAdRlbqJmLK8IZG517iPMMDqUR
	lsqYPdi5OzPtHBYRo5IAlNY9yyhoTiSFtioFLit90r341IUyWH8ntEpaVPcL2FeliNBfXbqR+Kh
	4+YSlDwCH9JeOpK44PCnWAMChCrVrEHkzn2qPtq54qvLKREtnuKKV6fyY8qGFK6klIWtKvwhIWR
	SHTwSWuAMwAj496e2rjpBkrKBw/5s0GG
X-Received: by 2002:a05:690e:1309:b0:675:657b:803a with SMTP id 956f58d0204a3-6768344720emr1761132d50.34.1790803549695;
        Wed, 30 Sep 2026 14:25:49 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67691a15e97sm264063d50.20.2026.09.30.14.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 14:25:49 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Eli Barzilay <eli@barzilay.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	John Cai <johncai86@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v5 1/4] builtin/stash: remove unused header
Date: Wed, 30 Sep 2026 17:24:38 -0400
Message-ID: <d8f4c3645977a555c5bdeb1111597f54d6906d92.1790803471.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7.dirty
In-Reply-To: <cover.1790803471.git.ben.knoble@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com> <cover.1790803471.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang complains that oid-array.h is unused. Certainly none of the
oid_array* functions, types, etc., are used, and the
transitively-included hash.h declarations are used but covered by a
pre-existing direct #include of hash.h.

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 builtin/stash.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 7a9843413b..dfea2d2c4c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -31,7 +31,6 @@
 #include "reflog.h"
 #include "reflog-walk.h"
 #include "add-interactive.h"
-#include "oid-array.h"
 #include "commit.h"
 
 #define INCLUDE_ALL_FILES 2
-- 
2.56.0.rc1.315.gc6ed9934b7.dirty

