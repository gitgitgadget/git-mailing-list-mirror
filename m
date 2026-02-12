Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A253C9476
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 04:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770869440; cv=none; b=DY7cvELRtGJLBcNGfMNvgkzRry+hCWLrdY5lmwmMJJxzDt5UgtSSAAkczzMqJtKUUNRFLAQLZxb8LvZhA3x2+6gsev4rPIVBM3YlPyFVH6v79c8/EWrAGMg672PI3abHOXqUjgu3YP/Uc/J3xjPi6IkhtYYsk2FGYI6Iq+lgcGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770869440; c=relaxed/simple;
	bh=2hSrQhs/Gdiy8H8jb0zbC99GB7VXtxWxQtnWFj4bW/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udNZ5Q91va91oPnW9JUq5sLk6uldKrlyaC9pg9amC0JiHadm9phTuD4ndcjzZAIS2bgvIZXt1g4/zAUMQmOBYjIwq3hF0suxvV8PL4++3BR6cEVoB4erTtfGYR9C0yBKgSE2+zDZSj9CxwDxORuPrlIuvfJeMAD/viLhqMJWsHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZyaR6oM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZyaR6oM"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a871c8b171so15378825ad.3
        for <git@vger.kernel.org>; Wed, 11 Feb 2026 20:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770869439; x=1771474239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xDNt/Zzqe2QM8rAhpnCYGapE0/IbHgkzT1igj6kHuQ=;
        b=UZyaR6oMU/ziebM0a0PBa0y6pIiLdE9uZgK9Xpf8P0iidTunQq7PsUs1h9uIjvEJQc
         AR0S6EjLa1jSiX0EZP6YoqTCCCr8MxYKvRWZT8p9trK5di1Se0PLUOqAz9DLp5CN4dRB
         l31Kmrtkylqvib0gBjZUgZAudxBwQprfcoYVX34fWfk7yGaOWuXBCDvu/QHbExKPVjDp
         qjGpfq7Mx9jERpj43vhB7nMFEX0TTEHMI16HQJ8oGQjAnChAyGTN4SzAOwurvkchSPvT
         nV9JBAwEA4PeSQl/S9EvBCXQxpAToi8sqAIDOh9fa4U/rtP8Su3e35bKbhxFhh9abbQB
         ELIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770869439; x=1771474239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9xDNt/Zzqe2QM8rAhpnCYGapE0/IbHgkzT1igj6kHuQ=;
        b=kduke2qtVwULRUk8etxI+zxiv1uoxLfrDOKO0AeRvKEiTpm/voRTOp3qQVwNV+OVJs
         nWLhwnx+5xuVnitKQrwDnCeethM/ofuf2bQb3wbgmo4vWAlJJcmsFp/oBh4Ywa6kS6tB
         XBAKjsO4HkcZsTbSrFdOhFhmpjxvMaRARufMBbPHo7Z6/pfGoh43REVWeKjtYoMIC+rw
         Ay2FnKDIWg+yIdGGrq5Ev2gMT9xSo3wTUzOl2YYE7Bu9Fuw17LwaWM6aiyI8CsDM40AW
         j0rBBwr1CN/67w0MGXHSmBgNOQsSZjJhbI9i5Y2OCHgoi8GheQI/8qBqj2pkHf7rxWGH
         StRQ==
X-Gm-Message-State: AOJu0YzFVYbgrQNY8JmEY2vGyt1VPOYC9Bn31NJibO2EAfTbYn3NaJjG
	nHMntKy/YGxx35vTHoO7Eom136cTjyYLfmCFeGNrfKhTTDDFc8ufAQ+VFLsv4Q==
X-Gm-Gg: AZuq6aI33g4h61zbZViS+B0SeDENO3AYnXEoSYnWi9qfNFua7opScr6zHknyyXGODzo
	LfnZvN7dsgA0/kmopLrkDMIkF+1P3HrSuHkmiHAPXxivcaHfJc2EjaXqx2dENaZ0LiRtLIgExsp
	P3Gz0k6t3KJw/SLk3n7fNQaqWiibhQVUyzrHmvt7TFqv/0NMtgm+kBH3L6HQuO0qiRGNRHhV1bb
	cMqkzklD/908e1wD9eNPHvnOuf04oaThTQyOehMWovY579/dFVYDFjqYWWXwZuGJUe3GxvaqQju
	ggo/dibZqVQv2XW9ZjuLg6eggLWibDtRjUF7ePq9RERtd+qM3HZ24aGX3g35ymqVoiH6Nc+f9tE
	1ApSy0nqTUehmDkJ65WMNSjpafWfbqJWBmOUeMVtO9iokRA4GHwHVrTJqJGhpIY5MxMZsVLtcrL
	WhHqVUVxC5nxZgu5CZMyHdEFGC9T4yBUtjx/x9nQduVgyXnLdOWGDjCqLK4aVh1vlm7ohymXe3x
	sg=
X-Received: by 2002:a17:902:cec2:b0:2aa:e574:d7e8 with SMTP id d9443c01a7336-2ab3b028aafmr10718065ad.0.1770869438711;
        Wed, 11 Feb 2026 20:10:38 -0800 (PST)
Received: from localhost.localdomain ([60.254.0.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab29966612sm52919805ad.59.2026.02.11.20.10.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Feb 2026 20:10:38 -0800 (PST)
From: Amisha Chhajed <amishhhaaaa@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	stolee@gmail.com,
	peff@peff.net,
	avarab@gmail.com,
	Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>
Subject: [PATCH 1/2] sparse-checkout: use string_list_sort_u
Date: Thu, 12 Feb 2026 09:40:16 +0530
Message-ID: <20260212041017.91370-2-amishhhaaaa@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212041017.91370-1-amishhhaaaa@gmail.com>
References: <20260212041017.91370-1-amishhhaaaa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>

sparse_checkout_list() uses string_list_sort and
string_list_remove_duplicates instead of string_list_sort_u.

use string_list_sort_u at that place.

Signed-off-by: Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>
---
 builtin/sparse-checkout.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index cccf630331..34e965bfa6 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -94,8 +94,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
 			string_list_append(&sl, pe->pattern + 1);
 		}
 
-		string_list_sort(&sl);
-		string_list_remove_duplicates(&sl, 0);
+		string_list_sort_u(&sl, 0);
 
 		for (i = 0; i < sl.nr; i++) {
 			quote_c_style(sl.items[i].string, NULL, stdout, 0);
-- 
2.52.0

