Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B5B233704
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772629554; cv=none; b=ebcnkt8l+/Xf1H8B6GveZ/KT+11EO183vCDh3C+lRNTU75RaXdSdif/JtRxxuWQK4jElgPNB82kjUfWfx3o4jwwqL/nKTrmrrFGtAfYt9iL0uEg5CjtQ5Ig5KBe9jIS7/soEkwjQV9D8FgZMwzzZhfJRwkmX+SEtvaZotQu9JHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772629554; c=relaxed/simple;
	bh=KPaay3zOtBE2+vHwU6Th8yw2WNX6+W1407oC/+A07k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUANqLDlKL8TJ1VayM3fJWng3tDoRfZMtgrFK5hxZhTtR2Cafb3Ldd9PF/dD36ftRjGRBLALXX+l3051MWA4YUDALdVtyiWjmDBiWqK8XQWhY01d/p+kZKLWbZdQ3gYXDQiKuCGHZqfSWv/QNX8Kw8nfKranffXBp/t4YDKMMDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JE7IP3Nb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE7IP3Nb"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-824a829f9bbso3202154b3a.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 05:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772629553; x=1773234353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bheFZ/T8q8CojwuEIJvulCetcv/fIQqEDFCzyx2NMkQ=;
        b=JE7IP3NbMJcMVWdR237fvHrwI3akuGgdVahIXieu2Yboo8DryWUpXZv+ssG5OO8bPK
         jOczgdB6/2id81MM3sL4GmGfeLVuZFcRNT/jqcek+zmbbOnWqWGCb+kysvIHuxvx17De
         rldUStnrW5dbYajGopbdeIHbhzBg8yuBN2DKlQtHLQDnS0ZnlmehOR/MUZgDC8+G4Y3r
         0C3U7eHdMZvke7RRYJpgqaSUiQw8NH6bxRLfwgIeQxqmXScqHFTjAC8PWoHOhdeuGzoR
         v/xRlN0okryyWPbiBKtdV+xn7WwWqkXxVmhlnK6vqq4p6QBEDCfR5wfPN4ovEAf+LSBZ
         ricQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772629553; x=1773234353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bheFZ/T8q8CojwuEIJvulCetcv/fIQqEDFCzyx2NMkQ=;
        b=IrhgSg5TBQ2o8aTfuB4KeTTajAyU67OiHBaPDJxE20/tuXBIvQyD6BkWplAWHU1HIb
         XZmNVTBiUXb7uHt7yLx9si9zrX5Vt9/Q5j/x8y4q84bmw3ZY7tbIybcNrRTVbpG4Ct28
         uNluxgRndtg48wKK8edZm6Zo96PqFuv2M/dMy1ZZ/WXIxP3+2Bo0mAy1G6B6n/PNPx7s
         uhXD4Zb0crPK8ghJ8Z51XJt/0wCpvAnRno8JYreZylXifVeApIiOMN9GJEMQCeF6X3w+
         uH8rtGN7xaPwcRSRLjI7ZfmoxFbbSR/t3mIyQvpCzv+WqF9fnEbnqOZArGeEDSJs+Crw
         hMVw==
X-Gm-Message-State: AOJu0YwcSiOtfJoG3Taurye7jb7gdScPP7kTBb6MOjwPZYl7BpwNKbIo
	6My7xFoPxKF+NNxDupDKMt2EW2c2/R3McwhiEswk7PY+qZ4Ug+Z1nJMBe2XGZZkP
X-Gm-Gg: ATEYQzxi7efPoNszLcYUQkKLBaPnu8Fa6lTd65bYQyWsRdh6cUQCFW4+1dN0086pemB
	PhPW2o/9N7uW2LuXQnHpH5za0gpyBw3uwwnu9z0dTG9ifRmNwNc014awfS98KZ8oxtRK83mIKY6
	9wPuk9DAK6BvfYCQSPJSLB0/TEVBwP85Lhp9Sq2XwgncBk673q0tQZMBEU1b2ndUIsy50OI66j0
	ZmDZ/PB6bTB0ZsRIXSOKHuINOAOn2m1skDYFlqHWpYqDy1/Wf0+ykFKcy1Wv8Qu/LtZFq8eVb0v
	KNQ5BgYC7ZULKOqzZvhxx+ez2k2Er7n2uQoQnC4BpUohO803FF1tND2H6TiHeOwBhz6irgX7e9h
	cAgsAW8HGYqKQVp5jy9UWc/sxJbQxzJPFMGNg5qOD+eGDc5bzKXMyFIBmOjKtl/m+zeEljbD5Yq
	Ke8R9nygRpgy0WmB9amJJrPIhPgYHWgBj/NimeKCI7GDonTVwM+W7q5majy7/Klg3GSqMQpueQE
	CR0+E/oUKed0LWWvI8uhFtjdA1+8aPW
X-Received: by 2002:a17:90b:48d1:b0:359:9bad:13d9 with SMTP id 98e67ed59e1d1-359a69e79b8mr1861725a91.15.1772629552840;
        Wed, 04 Mar 2026 05:05:52 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa3756dbsm16473717a12.0.2026.03.04.05.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 05:05:52 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH v2 1/3] path: remove unused header
Date: Wed,  4 Mar 2026 18:35:00 +0530
Message-ID: <20260304130502.8475-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304130502.8475-1-jayatheerthkulkarni2005@gmail.com>
References: <20260302142138.712273-1-jayatheerthkulkarni2005@gmail.com>
 <20260304130502.8475-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "environment.h" header is included in "path.c", but none of the
functions or macros it provides are used in this file.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 path.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/path.c b/path.c
index d726537622..f613d8bbd1 100644
--- a/path.c
+++ b/path.c
@@ -4,7 +4,6 @@
 
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "environment.h"
 #include "gettext.h"
 #include "repository.h"
 #include "strbuf.h"
-- 
2.53.0

