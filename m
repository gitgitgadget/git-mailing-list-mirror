Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD35EEB2
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759857122; cv=none; b=SR4lh0FA3hbE7GE1w42QUkVlvD09FkUQ2qgr8j1RfMRkfrkyQIZPrDvMFhjs7OFTXpY9latalfh1wIZYPjKMrBk5CIu/goftLP6Vyjv/mqup/Cx++zT+pC9KhdARwOn/cmACo4u91MIiCKboPv0gfTPBT3ytvMrKxWJBDp77HFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759857122; c=relaxed/simple;
	bh=ybk02SrZALvcIZsCPZ20btGbiQbHXFLjcoH2GFo6D5o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Kq8cCV16AEEFDdSynjOeOiyXkMNdpH/D1CzZP71JJlFS+pZrzRcW6ZkNR/obOOESdNUcTU/81ExzRzbjU7YDiaPXPditCpCv1sOazc7jcq4DLcjemaD+gqfXgIHlNdHHbExMSA+K6Ej8q+8eUeae3hsNzJa08j4mPp6uJPQ88Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KC9HO9z7; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KC9HO9z7"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b630753cc38so4217312a12.1
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 10:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759857120; x=1760461920; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HFCwZxqKk9FqKMkJBscaVrbSulYpN9zrxRgai8BNUjY=;
        b=KC9HO9z73lQLFNiR0AqsLvDW7K//uSN+fI/Yiq0ol5Yc+UrBIBsiSbFm6xoRsKRz14
         W9pe3iXaO9XSzY4m5Pt3BqmsQPxZeCASSVTeiWAOZ3ZZIodESPqlMaydPIx2Q4QWNF7/
         gGIowLIOpsNfC+cZvdILRDSAJHe/ognldwXxQG0a8WOQaAWr4PEFiB2PUPrlfj0/Lbrs
         UKzbHe/HIFwDutpVyQOsxJwLUVtoUznVHd3H8TAzJLmO+N2PHRrmLY7rD0QEvKoiEZgw
         UEYD7z/Y3ouf2xHR6SW3gj7gKmOrQ2z6INfn5xqgjMcjLsDDmMZis/I9speQpSd5VAkO
         ScrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759857120; x=1760461920;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HFCwZxqKk9FqKMkJBscaVrbSulYpN9zrxRgai8BNUjY=;
        b=jfdarUI8aoA+aB4CVlpLUSJ1aaghkBBgml5gXmo0C5JUvPFRMoAM9yNQmCrQEz2kQO
         Sza6YNHFsnZD9Wn9SWPZ4JuS863ZnBlfUAO0ykyHEjIAcvYKNWgZ2EWBhGqQBHaS6tVW
         kCqiXqsFL5YtELsCw42CE7hK1gq9eGDT+gC1+UO3Lte9zrZgftSusX5aw+oTW/oaJ+Q+
         Y66jSguh1t6RcmHmxJk1HPl238wpYcy82+L8YH0DS7i1oGqNx8akk37l8/8liS5E21TZ
         D0Y0Fzzv68FanbZKHXkwKuvbGeJYl8CLzNNRoVPs9nmOwCVKBrtpVAC1wTTOIHDlAT5K
         fyvA==
X-Gm-Message-State: AOJu0YxcWlCKWBVjnmC0ldGr0UnbHBhOl77WL6jv2sU1er1RwVYm7FOc
	g+e+5M+K/xbAx75lkQimq1pCMn0DIfs0/L8e/1smAR4/xtyqb38y88b4QjRIxg+FMNNKDUd6acg
	+z0WbihlKWxBn/ulOW/oDgGxJ80uFCDJClcl+yDjmuhhvE5oVxa+ihF5YSTSKBmP3vfxPXNKmk8
	XbVL9pahxdd237XW9KmIUEoIwF7LOwzo2BMpgj09hbcvz7DNbrVrXDZhB8+gGkjeLepO8TVA==
X-Google-Smtp-Source: AGHT+IHeg98UOlOBgVpqs5vQe47/yhryOmuSmMFW+MnLVL0IRtzNtQbeYbxykR+KdYe+S3G8HHvnezWiMAorq5oT8pjm
X-Received: from pgbfq25.prod.google.com ([2002:a05:6a02:2999:b0:b55:7de:e92d])
 (user=jonathantanmy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3d91:b0:2f1:302d:1285 with SMTP id adf61e73a8af0-32da81393b7mr380493637.17.1759857120096;
 Tue, 07 Oct 2025 10:12:00 -0700 (PDT)
Date: Tue,  7 Oct 2025 10:11:44 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251007171145.573858-1-jonathantanmy@google.com>
Subject: [PATCH] mailmap: change primary address for Jonathan Tan
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, jonathantanmy@fastmail.com
Content-Type: text/plain; charset="UTF-8"

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
I will be leaving Google soon and will no longer have access to the
google.com address.
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index afa21abbaa..7b3198171f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -126,6 +126,7 @@ Jon Loeliger <jdl@jdl.com> <jdl@freescale.org>
 Jon Seymour <jon.seymour@gmail.com> <jon@blackcubes.dyndns.org>
 Jonathan Nieder <jrnieder@gmail.com> <jrnieder@uchicago.edu>
 Jonathan del Strother <jon.delStrother@bestbefore.tv> <maillist@steelskies.com>
+Jonathan Tan <jonathantanmy@fastmail.com> <jonathantanmy@google.com>
 Josh Triplett <josh@joshtriplett.org> <josh@freedesktop.org>
 Josh Triplett <josh@joshtriplett.org> <josht@us.ibm.com>
 Julian Phillips <julian@quantumfyre.co.uk> <jp3@quantumfyre.co.uk>
-- 
2.51.0.710.ga91ca5db03-goog

