Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE422FC889
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755127227; cv=none; b=pP8fSH6k6M0Dvg6Tqd+AoydkX+30wKK2ovSvhr7DrEZNfmZmVDwHbxvW3ZvZ+xOCTsvnVDpHEIWLslbQn1Mozq9has5+LWKelxwhd30csVru3ml6xkH2CkGp0zWcYgx787Ta7qiCpDRPhLXoxcXJ9ChelggbVC+XJ2DlXV2Ehhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755127227; c=relaxed/simple;
	bh=146GhdsL2AJ4XbufvmAOxj2YuZzoeImB1PUSjF35/t4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UPIwy9b+IbqZQ3Qmbu6fb2i9DVaFs96WSl0wvROOWs6wuLqaOkn3SPIU5nakU1LUUQf01VEdzBv2FEZE0nEB6X5zPswZkgGs1VXzqU7T2p0D2BWGshoUBBegWsKeGBNjTg55IRSQruKtcC8qBbd2WSvaSrHGp81+ooRem7K/p8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6VIbhRf; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6VIbhRf"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b065d58so1913745e9.1
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 16:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755127224; x=1755732024; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwDESRWsViYGncFOyQY+1M3Eok4QTCR46eGO20fTCvA=;
        b=K6VIbhRfNLOEFQU2WNFTmv5IsoWucZdiRdVMAAvQdpl1xlL7EtKAtYGKX+P6hxMygN
         U5BqrTAHnegR7Xw41x9ZHKvE8dBHOyEqvSqDsCyr1f+4Ao63EO84IPLH+JELTyx1epHc
         5lTSOPWrexpOi7VrUh9/zS+bw9bXJmyDp2P6w87nTXK85hlzhRlJpY8IcUDSX19Yh51k
         eJLeLn+TgIiZrcS+RxpihvbPYOgUBCHQWO1TD+xnfnDSUW6AP3ahHxN+zEtPg57fHiSy
         +aejDIoG0XJAId5z6T1yFunGefFE0F0qI6HIWaPpd0/rpmA2fUfspRrpKD1636Six3oj
         m9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755127224; x=1755732024;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IwDESRWsViYGncFOyQY+1M3Eok4QTCR46eGO20fTCvA=;
        b=p35FA89DkRC6tBn+MxRe3BaOJrXBC1neEn2tf/bMM4BfmX3L90PO3tbHKPzc76EZ94
         Hyb/5gmjuSZdPTVoksFW00QogkMiez7prp3us6irYu5xklOm1jguIZ/0w/LlWRxe5BFl
         jSh/iUS+7koVqC188qYHb5hr36n8zqCQNPrN/D4a2nm1dNnrC/PudypDSIYtR74hzS7F
         nav2onkBiYbxrZkKctX2y7DMAJGFfVh2hjbpT6FhgZfHw3TonVP0GddxNv6AhEQHkHbR
         Lj5zLv2Lv4hjP7kmijzHu2I/NFxygQXVrVHIFIgC7To4Kw2byUDv0mEUvAIr2LTg+se7
         xMpw==
X-Gm-Message-State: AOJu0YwBBgWNMo0bWQ2dOYSiELXC6BWIiZaYjsMR2KjjZGjpmVUsj81k
	bjcaO2ZCKqdgBeIzQEVzBe6R6py4Eklh2qvTRbOo6+9Lenj+P44m+5Odgd6arw==
X-Gm-Gg: ASbGnctE8I5vG5k1PiptLzxkUWRbD0dSbyNqokaGRsVLZyjVjMa6LdhLSlAgODdvjQb
	CqqRxsMS4Dmcyy1A7ylFWxtsJJjUmZ6YSyMKxD0C4jIgbOcXMntfVYqbjHKJFyPcmBoB/DeABot
	EIO8K0qK3dj3qa99psByDFhzezvnaTeRiHovdGB0hJKXgor6BUTrBDQJxOcXHB9Cd80zPIGSfuF
	Hxx/l1HZtx6xTbJSzHvUODkhifLNpHafy1a9WhQ8qx0GgSAdlvDceCU8qXUoxBC02dNqKpLW6Y1
	8SBHrBxFNhJabWQRNIT3egUJzaC7FNnQb6QITBsdaQWbM+iVQArlaNP4V9PpDlRzdnUrAZUkKZ1
	Q2FxTZ79ZZXD0wmaZWn9P5VU=
X-Google-Smtp-Source: AGHT+IHefJvcQVjJoPwQSo46l3M5JdJyrmFBiw0ku1jMG1nIstw08DvowX3XpqmCGKSKChjbve1dwA==
X-Received: by 2002:a05:600c:470a:b0:456:eab:633e with SMTP id 5b1f17b1804b1-45a1b646b2fmr4572415e9.17.1755127224002;
        Wed, 13 Aug 2025 16:20:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a5961a0sm16792595e9.27.2025.08.13.16.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 16:20:23 -0700 (PDT)
Message-Id: <9e595f9ad59776d74a431731824410c7b73795dd.1755127218.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
	<pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 Aug 2025 23:20:18 +0000
Subject: [PATCH v2 4/4] doc: git-add: explain inconsistent terminology
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Chris Torek <chris.torek@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

I think the fact that git uses these three terms interchangeably is
extremely confusing and that it deserves to be noted.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-add.adoc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 6a6f5223419f..0b887e1d60ca 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -45,6 +45,10 @@ exact filename of an ignored file (e.g. `git add ignored.txt`), `git
 add` will fail with a list of ignored files. Otherwise it will silently
 ignore the file.
 
+[NOTE]
+Git uses the terms "staging area", "index" and "cache" interchangeably
+for historical reasons.
+
 OPTIONS
 -------
 `<pathspec>...`::
-- 
gitgitgadget
