Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3632356BE
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 06:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771913621; cv=none; b=El3PHZXLBkOqX/SinERWcr7yi2ncQs3jClTZ4L6NIKYYUdNOGVds90K6WQtmzBbJuI2XvZeMmrEwwMcdRXajSpEVET5dG/UWm0nU+dafIfIU4kroB32KI/+KLDLHi0cGDDEoh1JjSMxjtFUq+9uLWWTb4W3wz7QZCHPNKA6hSnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771913621; c=relaxed/simple;
	bh=2P+Sy1WJ69JLPeSyrA5a8pcwYJBbZ+Zep1wWAVlJaSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VABL/QQgU8ndQR6bvyMtLZYpBgSagFfANKeFNlttH9G6o/4bnM1yxEg5h0EIdLdedGFVXRM/5OflVLROJ1LjGUKwk81ZBUvCMgcK/yVw9lAi1HvuImWaK3ET6iabLCMbJzX8WucYCl3zEqYEhQzLIFTva4awNrYMj03Sla1Orqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=L18M4ZY6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="L18M4ZY6"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-823075fed75so2306390b3a.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 22:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1771913619; x=1772518419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Xe6/pEM7EWpmw1p58bBYJunY+r+Qr04quy+4VMg6J0=;
        b=L18M4ZY6yo2Ttks4S0m1ChNoI3b8MMtpQLR/sr66woIN0nGa9WSQ9Vo+zjVbtOC3is
         4gTmFFzmGyBWePmdC+ohMtRWLMmr4eXjmqsheaFgQhfIwpcJCexNY6XbTJhT4xYds++M
         JesP4p9mYc36D4KZDIjzXmpkJUer2ZHfl7ZBy1VBwlKPwdv3fnI2id7tb4dSmJWr7Iaf
         WJIqT7qB6jtV8CrjPfgsFO6mjZ6uZKwmyy+MrQc8MLtcGxobhCBy0eXvCe7otAO8cWkA
         dbfYSnIayCINRensGeYblM+NxuurzMYTbMDqwuQ+ydQyLWW1U1tZjpWD1TLCQy6dzvsy
         F7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771913619; x=1772518419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Xe6/pEM7EWpmw1p58bBYJunY+r+Qr04quy+4VMg6J0=;
        b=Ba52yQN8G0DHFRedLr+vLbTlhWjw+ZEVgdjI3fTXfMUWQT4ERWtr/4Q0QZ12HUdeug
         cj8uPXFPqkne7mPdvk54HRia4j3GUjsQMoMExvwYZte0IKMgFAuwByzGMZ1vtJm9f8tJ
         wL/ZRpgwzER4pU5mHwjC4OnH1oyrg25RvzNYwXnnvJNseTUG6S+8UofogO5wTYAiAfcI
         m4ZuRT6BU7F3MZIpsbBdSIz1LWqA5kA8FnuMIHNMQK2s2TE3mNAZMLEpNYkscg4TrZT8
         BBAbJLzIwzpieB/TuPikCNAN3q1fKrWIps1OrD0D30ufReVhJktooF5LT4CwRVqL/3rc
         FmlQ==
X-Gm-Message-State: AOJu0YwuxdzoIxJ4DeVT+U8BiVuINZQ1mKv5HPEgGuStU2q8/iqbPQXG
	0ytA2wMgP03tyyL1Ef5MuY7GR6691HY7rlXrLW19T7g2q1C1YY1UZezyu2HQV+JKPKq1iYDQG5C
	jqkKTl80=
X-Gm-Gg: AZuq6aIJ15k7olppIDnXAgZ+VLZD32JROh2zwH2DPECKzpV8QktG6dcAQvR5/ESMPEy
	9lBGMbfMymVkdbcmIEzc48atq4XoVXGmQHVX3wYXhTKzEjqhLsD9iOdl32FvgeYmkKnlZ1OLeH1
	w4S0FyYzr9CnCy7eVK2cuBeOukxnt7DWIcyf1I1Gn3Dyr9eyoYgl1dPq/G/1aEhT58Aer/A0IBf
	ixzNTHmCSVMp0T1V1ptkttgCVFMfV9RXnW2vzZRvbXH+C0FZY24hVDjc4FeapzOSj5j8TXPr3pz
	rWxtX1NjNEyJcR1ckMQqrOTwCzBeLo7b55+spN62vTMcJbuYzWKX2RBf3N/9xeMoqgDgW7lrK8g
	FM3yzNI3kujal8uiMMhQFYlN/71stwwGagUpWagV16vM0Dl9mewulNeoHE9S/9AkYGAxh/de+QK
	1mRiEmtHCQkij30w+E8+rNtEWnCSwZ46WKVqwIk6WwnZrkhyiRUu4PwWfTdVDgXrp/
X-Received: by 2002:a05:6a00:1d09:b0:7ab:2c18:34eb with SMTP id d2e1a72fcca58-826bad508d7mr12251715b3a.12.1771913618688;
        Mon, 23 Feb 2026 22:13:38 -0800 (PST)
Received: from LTY2K703JV.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826f2fc0c9esm5692869b3a.8.2026.02.23.22.13.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Feb 2026 22:13:38 -0800 (PST)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH v3 0/1] diffcore-break: avoid segfault with freed entries
Date: Tue, 24 Feb 2026 14:13:28 +0800
Message-ID: <20260224061329.60364-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212072002.2347-1-hanyang.tony@bytedance.com>
References: <20260212072002.2347-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v2:
* fixed the ' in test, and removed unused lines
* clarify the cause of segfault in commit message

Han Young (1):
  diffcore-break: avoid segfault with freed entries

 diffcore-break.c              |  1 +
 t/t4067-diff-partial-clone.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

-- 
2.52.0

