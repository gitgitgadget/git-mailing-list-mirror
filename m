Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518861388
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723747877; cv=none; b=jnBLT7v/ACZYdANURVdfQGLBwhUMgLyRho0GRzWykCDsJnu5xQHiK6EYvl3iFEF1a01WOI0tRaNOZ4k4vMkdgZHPC2QbxK1OeIJ9G2bxeQZWPUGK02FshoGMBdcvkmUsmNT5EaLh8l4aMxVNCVKg1EouVDkQtfqc2qrZH78h0IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723747877; c=relaxed/simple;
	bh=jNkWHO4x25eQ9Moa4D3BKnnBq+csq4NXuoHZIwcN8BM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=aq9p6FruN7cpP1mQLUBO0aX6P4qN6GIfA0fUZqqtSuB6YY0gUUSCfN9yo8jCxNVB+qTgrmGO3rEhJ7jewxUF8BZkYaXHywO9sFIKyH5UT+sHn1IeVpBjvBaDbpTOHdTTUQ11cbsttup9F2ViooH52DGLxqgRwLQGRQ3CWTrUsjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2nvPxwmd; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2nvPxwmd"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0be1808a36so2103446276.1
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723747875; x=1724352675; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pCpg0Z/KiJpqd7fioUhVvxKWwdEDZajAub7Kw57R9+M=;
        b=2nvPxwmdG2Fzq98uOOjKjWfwac57a/FFlDckKPX2OYpHFVGzEGYZad/AHQ6IxA0imn
         c1zDR502csVnF18dIJjorywmiqkacH8nuR4t7ee7vBdDGJEsWfJlqM5Tm/RyQJ4qkfuJ
         9xIF2iddvYcegCoTNHVM3d2USe+Y0Yl8XOLhjqPuZQTZ+u8cDY5TwSWGTRuGhqRcgNNn
         DgnhJGW+UcYhY2PvKdsucsHrVBUD2L1S7OgPx5+T8hmVVR0AnDnWNPNWJPF/vGe/3Xr5
         QzcSxiCQFt7shD07JXPxtVAoHge/fcycV60cl2iK+8V087hMOSySbpeMlwEQ2dMH36p2
         hhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723747875; x=1724352675;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pCpg0Z/KiJpqd7fioUhVvxKWwdEDZajAub7Kw57R9+M=;
        b=KgvSvpDmrx230qvItMTtpDlYXKwx7d1wn6PnZ3fa2Q+qUqoynX+VACW1zYnTe8y1Dw
         mGU3b/ASxxf6FWHd9a67tFuXJLDqLJB8mX7JKZKRWJNRpfTdViNhAFKnHFR4enRE4eRb
         IWr0eKsjgd45uxBJuAi1kV1LhUIe1jnSta2uzAqkbl86jXXN5atiVNozF8umyJseDFPq
         ji8GYzPVy8pUvm1tG3vdK94KJUNsuqJodnG6oAV6gRI8zRR7HweaAg+MKf8SaaISJzqA
         d7TdKyaeLHDJbUwEe23YAFozoFc5Q1B1DkTY+iqLiBXJ3Adpxy+h3s7LZXuxZZtZd+Pu
         mIpQ==
X-Gm-Message-State: AOJu0Yw8chDTLYqgBRUIEHreEFhHnCUa6+SYAOhl3VaRtMlEuSEIH1VW
	ZknDa85SJTrfukMWig7T18Sk2eaFzXKWPR1nQcNePkOmSG1jrf4YBRXzhxqvEeg0qoTeszoL2na
	KEDdsXZtDBwV/VLHm6Roq+e6lRI+rY/HutrOnZglJhRPradwawc1qNBQbUVOC8yMMHEX/EVcslr
	8dskQsHmJNpwi/9FxXjhqKqYjuefeJjmndAGeH9Wk=
X-Google-Smtp-Source: AGHT+IHCxMrJY4jUzPcGjP4SlwsZbYL8o+kTyeh23Xlf+rd4a/NxTrl3YDBzzH3azsEziDJXTYkbsQpt+WuLkQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:d4b3:f740:176c:e447])
 (user=steadmon job=sendgmr) by 2002:a25:ae95:0:b0:e11:5b9b:a53f with SMTP id
 3f1490d57ef6-e1180fb0a43mr1102276.10.1723747875169; Thu, 15 Aug 2024 11:51:15
 -0700 (PDT)
Date: Thu, 15 Aug 2024 11:51:11 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <cover.1723747832.git.steadmon@google.com>
Subject: [PATCH 0/2] Add additional trace2 regions for fetch and push
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Last year at $DAYJOB we were having issues with slow
fetches/pulls/pushes. We added some additional trace2 regions which
helped us narrow down the issue to some server-side negotiation
problems. We've been carrying these patches downstream ever since, but
they might be useful to others as well.


Calvin Wan (1):
  send-pack: add new tracing regions for push

Josh Steadmon (1):
  fetch: add top-level trace2 regions

 builtin/fetch.c | 27 +++++++++++++++++++++++----
 send-pack.c     | 16 +++++++++++++---
 2 files changed, 36 insertions(+), 7 deletions(-)


base-commit: 25673b1c476756ec0587fb0596ab3c22b96dc52a
-- 
2.46.0.184.g6999bdac58-goog

