Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FC320F063
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816264; cv=none; b=cGFVkIg2eu3N7WwNFPYb4NEaz6y1RGIID2l/S/fQNNRS5NZMb8csHaS3TGxoQMSOdNZErQ8YH2NxwbPODPLTLY1V/uptyKUGizgCoXkZlObc6L5vHqPQ0LmzMv3J47yPa3CB7DGUITdtYr8Mo/KONKNSA81ghNejjonztxVe54Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816264; c=relaxed/simple;
	bh=jS7NeVOtKgwNpNd1bJv68JhG0SP0Rx9DxNBbSJiwZ60=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=WizLJ2w1UoJEcWuKUhEFj5PEaFAmsyK4pGrLZYQtQRAjrqFuJrdTf2f6h0ODBiW7yrFqm8ULm+6/0kzV3jidTHLz3mqH5wPGZ+ZuU6PSFvstH2fsSXI2vb33/uNQgbgyKiJXfULgIqFQHYY3MBi9IlZI5bft2ppkzpbR+4ij40I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFnXNGHu; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFnXNGHu"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-88728579b64so199733539f.3
        for <git@vger.kernel.org>; Tue, 02 Sep 2025 05:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756816261; x=1757421061; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QnAHHWvLi1vrCGKf2ucuUk4oo+AX6Gc9aIMqQTdgYKk=;
        b=GFnXNGHuTwcdpcvINh7fsd1z1RkERi74+iourGJWs914D3PXTr6QrO57c5GX0sAdLm
         HuLk1tL1CyWpeD3Q35jcFE2/RWQccP8jPV7Xt30BQujRTNYt/71hi9K9+0dCbritWoD0
         1kGDNNqea7x9IPkGND4bt8Q5yUAerDUHTnNsLetOtIHTR+KYUO68yFCwZ4z7lGVsOtgg
         wTaZLW8lsPLbHHc3cdm1dDYL7HyHq5yH9oTynZu2Ywe91kANGyvz6cI86Y/6Ip/9OWeC
         EJTSAe4kL2do3NkBHKMNcXJen6x1ZgZH2FGApRPGiEP/Qp+KohA7aBmWqFb836JN92B5
         O6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756816261; x=1757421061;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QnAHHWvLi1vrCGKf2ucuUk4oo+AX6Gc9aIMqQTdgYKk=;
        b=Bh4xNXNcEP5Lr4hz3hqod/KNRKKD0RXIGrUZ2/yZ5Cxh5GRdH+L5Tc62t+lHRirkEy
         OezSfeD+QgWbm82UzxQcIB//e6QUUMP+cXoQA/Airx4r9iGHOXCyAfbZvNRGEmFFW+n2
         RNPxYXzf6QIV9iRxLI1RS2xDlLey0vwTkDEMZLbtfAfXDtCeSdOz3TE4T0rYSs9AJx5o
         L+kG4FX6C280u1/WyG2QkAu9zw5+PQA0h1NY0omVPqud1HS65z13WSK3glx2Egy51nZK
         SxacfeQnGzF0NG4fuucmIB3GoNBGyiaiT20Ef/jkBbzR+hKFYh1NXcmdXNrVj/z1biQK
         Xf7g==
X-Gm-Message-State: AOJu0YxY25vbTlOPIdMSHqhpt+HHwXGQlqgFDideQTdFcxNQP7tOqf2j
	sA6nQiahPYdzriQEmPWUsZ6vhQWjAx78iAtJvM/kMUJbFkHC1g/IVjUSCgEKuA==
X-Gm-Gg: ASbGncsAv9Khmmh9QsetkCjSnQ/DPDlJ7I+PFNjBDpqDms4aoAKJ52jk/eDEe78BDjt
	iQTK5+73x/JpaCdLxMGP9h/bTFV1Pf7hJHWyPcI1Kc7n1QJjQqI+UMfDSjFxvkO5Bp1qxhJZoJ1
	DLwT067qvMUoLakLzd38L0RR2Y1ZqUiQ+CoZ0RJT11qI1079OilJAeNTebEpAr6qxMxHORwHRul
	L4PuNQso4DGLVLXBB6FMD5mqfOK7mMmZtDdiPq/DikKp13FDGbrQLb3ve1rJ7pnW6x9f2h/ntbm
	Im+MrNiz1L8C5zGyM++IEMz4mwLZS3nevL9/Zdx/f5cA4MWC3L9eVILrmwVcHpt9LLRH6JEqxME
	T3JUsinUVE2y8lRBxp6W8kFGK
X-Google-Smtp-Source: AGHT+IEsVxEBJSREL7/ss8E5OOy5k7IZ/4KRJjjM5lPUb6N1XpZoMRYAfkUWqUUlX/Gznlp+Vv0maw==
X-Received: by 2002:a05:6602:150e:b0:887:48b8:fe74 with SMTP id ca18e2360f4ac-88748b903famr154514139f.17.1756816261355;
        Tue, 02 Sep 2025 05:31:01 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.108.24])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8871e34ab18sm313239839f.12.2025.09.02.05.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:31:00 -0700 (PDT)
Message-Id: <pull.1966.git.1756816258606.gitgitgadget@gmail.com>
From: "Greg Hurrell via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 02 Sep 2025 12:30:58 +0000
Subject: [PATCH] mailmap: consolidate multiple addresses into one
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Greg Hurrell <greg.hurrell@datadoghq.com>,
    Greg Hurrell <greg.hurrell@datadoghq.com>

From: Greg Hurrell <greg.hurrell@datadoghq.com>

Merges contributions made from three different addresses:

- win@wincent.com (old address, initial contributions in 2007–2009)
- greg@hurrell.net (personal address matching full name, so this one is
  the "forever" address; contributions made starting in 2018)
- greg.hurrell@datadoghq.com (current work address, used for recent
  contributions)

Signed-off-by: Greg Hurrell <greg.hurrell@datadoghq.com>
---
    mailmap: consolidate multiple addresses into one

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1966%2Fwincent%2Fmailmap-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1966/wincent/mailmap-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1966

 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 96c2740fbb..afa21abbaa 100644
--- a/.mailmap
+++ b/.mailmap
@@ -81,6 +81,8 @@ Fredrik Kuivinen <frekui@gmail.com> <freku045@student.liu.se>
 Frédéric Heitzmann <frederic.heitzmann@gmail.com>
 Garry Dolley <gdolley@ucla.edu> <gdolley@arpnetworks.com>
 Glen Choo <glencbz@gmail.com> <chooglen@google.com>
+Greg Hurrell <greg@hurrell.net> <greg.hurrell@datadoghq.com>
+Greg Hurrell <greg@hurrell.net> <win@wincent.com>
 Greg Price <price@mit.edu> <price@MIT.EDU>
 Greg Price <price@mit.edu> <price@ksplice.com>
 Heiko Voigt <hvoigt@hvoigt.net> <git-list@hvoigt.net>

base-commit: 6ad802182101d622e6a4132f48292ddfa79e2024
-- 
gitgitgadget
