Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287C33191A4
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295013; cv=none; b=DScxRMQpVahfplqo44EOqwh1GmPWoLkscBNdK6EBy7l1H3SokfO7hxNe2BKhYRshtBfuJwWgihoMgi10SZvuRQVvvMZioRx8VXK8HwuQM/Mk0T7Y8upq/zEtrLggS0gERctBkxzZe70UFQ+8zYHAbwlthQ1NDLFi02qmhN7vi04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295013; c=relaxed/simple;
	bh=C+zRmtMxwotg6fA3Rt/nqowYJiULyWI14WeQjF08LMY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CqJaA9FjpT3Kja1gofMgMFhiQ55/4ZVXhTwtjcyxsmOYivUCQipwTL/VPgBzwkr37/JBazCBzEsANawGsQKtm4/CTBopdGmw5fRpqhvwn5lnlcIQmC2e3hEFigj2TQWfSlOE/hy5cKNmo83QxlGU9Kdfn/x+fX8/GTsoK86Bynk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NT+8Wg7E; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NT+8Wg7E"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8a3e61fa206so103093939f.0
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 08:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758295011; x=1758899811; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuOBUVu3v0xeuOIHgrdV2iq0i/c6wqIxTcq9GgQSu7w=;
        b=NT+8Wg7E5swFMTElKt5yfm6pofxWPPsVi5m4UZBFPBgaIpF8G09bsRQvsOuQ67+Pi8
         uuI6QWy3hr/pVSVCqxXyzmovEox/zbsM2hoLwIg+KKyIEfIpIqISJ6ut66QV7+0bvZL1
         I69mvNx40MT+bqF6QX1TV9UDN1ZCMgKS45XjK0I3hH0cZTrKEWSvPSSRmUzTvOfFD0VZ
         1szIqpQWpTe0iVecEtZxAat0N+U18qc3bjWdwyYGhyBSXRRCYY2XfGQalWs/nTuJwXKC
         HzOuZu5vDmneRFSIRjlYBSQA4Hs3OO40NeKA4j8d8cLpdHU537q+EKx4JSIxHNI0l7Zl
         0YeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758295011; x=1758899811;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuOBUVu3v0xeuOIHgrdV2iq0i/c6wqIxTcq9GgQSu7w=;
        b=UtaDNvlArez6OpB+yLJDyNHmhvUm81tD8x+2opdWGfs6KiJmUElN9/PhvMCJh4jGhT
         Hg9qrdhHfBED5fvU7E0/fMLPcFJ0KrgxxlKKJ99b0r9r3k0UlSuCjpgbiNIjDerqs9yZ
         ZhvvgIJl9S0ZiyJ5lnm+Z1aTHSZKLSX/GjXAwDGa2z2OrCwCUzj2K+DxybuteHhyLzyf
         6/2pD/erTEDxUXp4E2NnFkc63AxV7GAfGhEOFHbh50dv+CrVC0+iWjg3IqB+5rQRKRzE
         33gn+N/ldqAkzVVgV1AqavT18UPugB8QHnqz2Utn9nxtkXgqTJ/FfByiTg2OHgZaDm4d
         VNKA==
X-Gm-Message-State: AOJu0YyjZ2wZBG2ZnuwBkw75iRu1M9DEoFPbE8ObNOwp2vZgac3/ny/P
	bOlr+Ll0SeIoIP3hmP20R2n15+ZL6JXd83vLofCA9OzJQaG3dpsDNWDNJnU2SMvc
X-Gm-Gg: ASbGncu5jWSMDL0QjrNyWGIHjsL4HP0wyhpz43DhmSWDLeqVI6jVVLIeJDp2gry54qA
	k20FuVATFeBYAexNyyEi8EUXVVCvSFap/6H5EhaizTwA7lfA2ujcDHz63a8ck2hTJ1PNmxHXaDZ
	/zQaHQMhFFUjcX3FmqCTwz2L4hCaq8kRp76YzacRhokEH3J28AgtoGoG6beV/PqU4r2Ays9MJNa
	QjY+Vp2iSzmkIfmoXiXEmQF/fQdDRTahNiV1st4UzQ3MTcN7QPok32xXgV1BCYg3lPdXrWo7O4Z
	lkWvvwYpuiIJHF7qU8jVHN+GGLH25CzSk/do0lFELuaSGwNaW8qxPKTXP12ijHe8nRlPIxd0S2D
	W5PJZT5hRBgXQj3lO3veSE32v8w==
X-Google-Smtp-Source: AGHT+IHSqBxyBxchdO8EL/BbyTrQdzYfgTpiw/KGaDw0wfDw6ozpCJQmen5dozUMp27LM4H5NMP0qQ==
X-Received: by 2002:a05:6602:719b:b0:884:125c:6949 with SMTP id ca18e2360f4ac-8a44f67be92mr1393118339f.7.1758295010617;
        Fri, 19 Sep 2025 08:16:50 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.200.65])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a47d925092sm181914439f.17.2025.09.19.08.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:16:49 -0700 (PDT)
Message-Id: <fd541355609b715ebe94f9e025450165bd91d170.1758294992.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
	<pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Sep 2025 15:16:31 +0000
Subject: [PATCH v3 09/10] xdiff: delete rchg aliasing
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
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Best-viewed-with: --color-words
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index a66125d44a..83c4cff6f7 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -932,16 +932,15 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 
 int xdl_build_script(xdfenv_t *xe, xdchange_t **xscr) {
 	xdchange_t *cscr = NULL, *xch;
-	char *rchg1 = xe->xdf1.rchg, *rchg2 = xe->xdf2.rchg;
 	long i1, i2, l1, l2;
 
 	/*
 	 * Trivial. Collects "groups" of changes and creates an edit script.
 	 */
 	for (i1 = xe->xdf1.nrec, i2 = xe->xdf2.nrec; i1 >= 0 || i2 >= 0; i1--, i2--)
-		if (rchg1[i1 - 1] || rchg2[i2 - 1]) {
-			for (l1 = i1; rchg1[i1 - 1]; i1--);
-			for (l2 = i2; rchg2[i2 - 1]; i2--);
+		if (xe->xdf1.rchg[i1 - 1] || xe->xdf2.rchg[i2 - 1]) {
+			for (l1 = i1; xe->xdf1.rchg[i1 - 1]; i1--);
+			for (l2 = i2; xe->xdf2.rchg[i2 - 1]; i2--);
 
 			if (!(xch = xdl_add_change(cscr, i1, i2, l1 - i1, l2 - i2))) {
 				xdl_free_script(cscr);
-- 
gitgitgadget

