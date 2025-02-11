Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6A91F03F4
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739263857; cv=none; b=kgggN/fachzktJzzbBuzf0tzSSpXjK1DqakYph/V6xi7t6nFxkzglufxMdJAf6l1fssDg/Jydv3Z15ieQCAQsaY7zvw6jQm7dosyoIbov1za9M+1teS1oi8puXHh0Oo3hZbQODnJGxgscdRwF5omOUwC/9tO6SJgcbTGxcM8qk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739263857; c=relaxed/simple;
	bh=17N7VocmfZJeVnuHq/f0+bycl3xpueu5wz51Z3gMyA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gb9Ga+9VcHP036n0xemHIi/zF55zUdeMQzwYB5IWdxTKsVZvVvofxsEeAvT2i1T+87yhLdBMk+qpjoCw+DdJesim5AZeavxP5Mfa3Xm/cXIIOMb5O01wXjpqVJjzjTznZ33gtC8uVJkhRhkB8q5tyd1SCJl5Tgn4evszEr4q1To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pd4lDFev; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pd4lDFev"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f4500a5c3so103531095ad.3
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 00:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739263855; x=1739868655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTlfV8sxLAVM5HmOqiScCyvjUdi07C2Elp61HaMzN3c=;
        b=Pd4lDFevpln3FBu8S6A8OtikAezG0Xo8QK8zm3oEFQiBhC3NOfnSPZtU9FLLeeGXoU
         eX6UkD4axm1UoY7EjIiUwHNsxTY4D7/uSIw+hx0vw5W1jGmhF8dXZDIR71HydLHuBA32
         zJROM8U8Ks0b3iPzEzcBsdZkYkC4oT2CyttkHtrGUvZtQX3QW9dYnw3F3IddFdh94bSq
         tLVQScw7gc3av5Of99ikt24VZYanztwqy8WBLkgx9cMhX6gqcmyWe9W3/tcOrpT/YuZZ
         T3i/ajgOOjlC364quzyoO5TqTjTTIvExIp3s7SFw+GWOycK2MOlxxbOQWCiG4WpTAOb+
         DYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739263855; x=1739868655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTlfV8sxLAVM5HmOqiScCyvjUdi07C2Elp61HaMzN3c=;
        b=EvMgX0neZcQBgncbUp4tiZbEg3OjzF/WOuMwBY9JxoevTxtFmaMKZc48KWH2s6rZxF
         22kHcRrqT2vEUf/wgGkuBsE03tIhzHSwdOwV1Rlbzl/3kNm3onzwMiuvZxwSBvJH+bOu
         csHm+MDxTQmVWDCYsigrG0ItPH3WY/emntI0RnvX7/wy+Pt99j4F2OdD360wKOmUg3sQ
         f3/qhZttJxLtPEEDAWbDNBnQUfjWfuUrkUGUulu8tqXUoGo93G0RErWnpyeDbu7KHxyn
         3ySdy/ax6ticM9I9RYW/0cjq8ZdMlYylktSJG1wF5MTbWLGyqzNNNLn/qlyVXeSQ1v4p
         1eRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTnriVh349eVbASUocD/Es2ritY38+iJV6Czxb0axhi/1DvJexWuqboaayT1+7MjOQAgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQG8JYbBMgaARdh0RvMnVAODYlkkpd7D48ysD25T8TqtSeU9u+
	LfZfqljr7hpirHGaArbI5c/vlGNrxn/lqzNolHqiqfBOoUMuTo+M
X-Gm-Gg: ASbGncsUwNtdEKQwFl6qRbKoRfuEK+3+9vg0zXycfIG5trAnaKSKhSaRjbeIit8iJ/P
	hqLCs5hmIzKR2P7jq+WiH43Ygl35Gm2S34UdQPhQ4irmIjwi0YpkRBYK1acyWFOe5+xiHSRhfRX
	wXIuY1/iAnRtPqupnV/GEJdwc1u3TfGx4y/ZaCGCcYbh/5vVyG7n2tp1oHBbx0vPGSJ/+h+4aIH
	zmKV904f7z37FD2I2x262sfAUxleioIm1fH0KdSEcn5pHKgPENY2fFsZaaQnFfSIn6Q+SDpTvZQ
	QQk+ClshOIaMqDy26DOmlTAry3A2LmbwTKRgm8M=
X-Google-Smtp-Source: AGHT+IFzTIHgcadHdj/W18twGIXPV28ybGaypQNyFsFpClOJHWl6KNSukycIN7vW8FrrYNIl0Q53eA==
X-Received: by 2002:a17:902:f685:b0:21f:2cb4:963 with SMTP id d9443c01a7336-21f4e7f2369mr255040595ad.50.1739263855628;
        Tue, 11 Feb 2025 00:50:55 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:3858:1e16:caad:e1d4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a46534sm10201701a91.21.2025.02.11.00.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:50:55 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v4 03/10] diff: short help: Correct -S description
Date: Tue, 11 Feb 2025 00:50:15 -0800
Message-ID: <20250211085028.3923875-4-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206014324.1839232-1-illia.bobyr@gmail.com>
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`-S` shows changes that modify the number of occurrences of the
specified string, rather than only those that either completely remove
it or add it for the first time.
---
 diff.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.h b/diff.h
index 0a566f..49ece3 100644
--- a/diff.h
+++ b/diff.h
@@ -606,7 +606,7 @@ void diffcore_fix_diff_index(void);
 "                try unchanged files as candidate for copy detection.\n" \
 "  -l<n>         limit rename attempts up to <n> paths.\n" \
 "  -O<file>      reorder diffs according to the <file>.\n" \
-"  -S<string>    find filepair whose only one side contains the string.\n" \
+"  -S<string>    find filepair who differ in the number of occurrences of string.\n" \
 "  --pickaxe-all\n" \
 "                show all files diff when -S is used and hit is found.\n" \
 "  -a  --text    treat all files as text.\n"
-- 
2.45.2

