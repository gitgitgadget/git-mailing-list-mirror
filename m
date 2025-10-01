Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00603019B6
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331305; cv=none; b=pqReyIXTzE0xt7zFdRIVa+zTOffjZ++Yw6HqFMSty3qNrjHCamaFBARRDomm4f1j5325nrykcM2Lykfc9+LkEtNmuAoaxTSkVDiEltdpXX4WyyWhSxmuqoMdFoav4fMeb1ofDNQSfwUcq2/W7/oex8ImUw6JLzlcL805t9a6aBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331305; c=relaxed/simple;
	bh=tD+Mtd109w2U8IY0TULaYmKZq5O1J8o5F8B/XBYGnuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pegaXM93VM9IsCHgMqAly51pQEVx5Pn0KJSBD5adOFjAw+4Dd4shP7PCZOTBc+RyO0AjR8uwXCl2+ikAXKpiN1XvyvY/LDQ6Ew2yFcFsllxZ52UHPgmqU/cRDVWAKGMtna4sXRdYLpqPUW7ZEnzPP/Aur/FzmUL9PpwrBPpl2w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kQvOm9/0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kQvOm9/0"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27eed7bdfeeso16555915ad.0
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 08:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759331303; x=1759936103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KmEulphrGB2CFsdL/ua7PCSQ0xfm2/8Q7T9EsFZi44=;
        b=kQvOm9/0i5T6tHv4+w6Lck0dPH98XbrHsW2i3rJsxKefCQCpQiwnTiH5rVnkuk2H++
         WTrxxrHNyua6+HG+nVCWVqehL3A57XNyJTpESWUzSl939RRJIKwNOgP3Q0R64OVwJO00
         AezPBNjbwxlWSHhdfnG7fu9hGo/lPnu3Zn7TOUx2McEsRwQ2yLzlH+26J9+QyuCevshB
         oOxmofxrPL2eCZdGjWEolaMQ+BzFLN+jkXWUoy/Gh4usRlt2tz9DIuDwfKVu88LjFBzF
         V6J7awhn0njS1t1x1Po8RGYcNvWNmrzkzryaqKO8OwmDXnk/gq6xehZRpKZoBIL2CXDi
         eVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759331303; x=1759936103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KmEulphrGB2CFsdL/ua7PCSQ0xfm2/8Q7T9EsFZi44=;
        b=qL+xhTadyOdnTjiwetLfjlxibvVaWi4WPCsPRCzplo0Fx2rnYzKTZrMUcBjEzxD+Tn
         OhFWQnI8vyhSKjXO9iAnjkFr8fFOeDniO3sb6xRBVtMnRtmZ4SxSUXKaQ2S3VHEakTcQ
         fGQz2jhkEaZPAZ0l+85O+QLUrMkjNdxIdT2YIga6Yqx3AJQDunv5cqHb1rjYDNPrhVTt
         ga/boW644/YmvLXAYmNrjgK7UQRTbPCP7ggl+wBcTVa3kLyPlEx3MZpLEpz01hh2X6UR
         2a9VS0v2Yj8DB+bcFdZQ+0h0Ct0yylKyenA7177tlaRiKN6vD/GAGDGa/qWsIYXR6LJG
         dFOA==
X-Gm-Message-State: AOJu0YxljDoj4Gp5HVcyCF3C6aDC03Pbz3NQEendgcwgj/ScXyrTsMx4
	UoUauha2gK614XR97YiOg02RHSAuXeyB/10O6fgcSznHppOBJ9McG0MJdmhXlHaDyhlMRq7uQm/
	Ykm6L
X-Gm-Gg: ASbGncty9Y8UfzFX7VHYjXE521YfJzl9GCUPuGCwyGC9APOyql++puQYeAbL4RXDAbj
	Kc9u7EBW7M2ucGpTWSMBeMCWVKTX+P8NzBRrFhVgcB1G+0A4Ls56Y+gErSWoj6kCmQQSyUl/SfJ
	SIya/eXuNFnn7EEN4sIr0ltFXJ6OPQ7CiZJqpS6SEWDmXm61vsQEg2K0iRsj9CFUQFU9At9QVuX
	7WxbZKwcgEsGRY4EAqWn+5d7NyfcXvW3n2s/5Sv1IPj9C50tr1dT59TxK6SqAktyMmwas9E2xZc
	8s3xR2DsJbdqyjtnt1xU6ZTUQaUDvOEDNKen/a+OB46rGZBYbkIacLVCh8p0Tgrivlt7inby2oN
	i13P/4qQDZuWTqc/89K34qh71A1aI22YEgjzwJt867PiaABbPaubBifnGjYbgYqh1bBQHaqzBob
	IFWl2M4VUFTth2228=
X-Google-Smtp-Source: AGHT+IGhjhyyzYUleQENdR8DDJjj4Qk3uD+SScWcF4sMYRRxLSB9mzNwppOHqb1M6ZKWf+Ga4ORL8w==
X-Received: by 2002:a17:903:3c48:b0:265:b60f:d18 with SMTP id d9443c01a7336-28e7e9e6884mr43559075ad.1.1759331302699;
        Wed, 01 Oct 2025 08:08:22 -0700 (PDT)
Received: from LTY2K703JV.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed68821f8sm187106925ad.73.2025.10.01.08.08.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Oct 2025 08:08:22 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	Han Young <hanyoung@protonmail.com>,
	Sigma <git@sigma-star.io>
Subject: [PATCH 1/1] files-backend: check symref name before update
Date: Wed,  1 Oct 2025 23:08:05 +0800
Message-ID: <20251001150805.9652-2-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001150805.9652-1-hanyang.tony@bytedance.com>
References: <20251001150805.9652-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Han Young <hanyoung@protonmail.com>

In the ref files backend, the symbolic reference name is not checked
before an update. This could cause reference and lock files to be created
outside the refs/ directory. Validate the reference before adding it to
the ref update transaction.

Reported-by: Sigma <git@sigma-star.io>
Signed-off-by: Han Young <hanyoung@protonmail.com>
---
 refs/files-backend.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index bc3347d18..d47a8c392 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2516,6 +2516,16 @@ static enum ref_transaction_error split_symref_update(struct ref_update *update,
 	struct ref_update *new_update;
 	unsigned int new_flags;
 
+	/*
+	 * Check the referent is valid before adding it to the transaction.
+	 */
+	if (!refname_is_safe(referent)) {
+		strbuf_addf(err,
+			    "reference '%s' appears to be broken",
+			    update->refname);
+		return -1;
+	}
+
 	/*
 	 * First make sure that referent is not already in the
 	 * transaction. This check is O(lg N) in the transaction
-- 
2.51.0.373.gaf4ee0e35.dirty

