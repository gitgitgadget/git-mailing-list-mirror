Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48AC30C629
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 21:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758662690; cv=none; b=X9qXknPbSpd5c1YWaIwMD6eDbG2TO14T6Zu8EpdB50bfdHcTsd5irsMKqklWv3LlikZmQ3GF62R4ZuniK2qzEGkdEzl9bNuR+jsJLv8ZIBhYAFfmtxxCUXCncvHjUGYCSyf9vktOygdT3ckTmM5iD4Xqr2PKJqqAAScgaq6D1Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758662690; c=relaxed/simple;
	bh=C+zRmtMxwotg6fA3Rt/nqowYJiULyWI14WeQjF08LMY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nXiAam/5vxWysy+UseUBm06ZKGjNwz7rHhSwtvBP+fHtKpilcRxA1WpFJ1rIHRu82KGJyXQFr7Gm8nrn5ivcOg9VSO7JejNn9w6QRelnpw8MqXPet1CiP7PKQGYuPlBNJYNVJXHDN808qTajko4Ln5Zxgm143BjzqPeIl5OaJLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6B9nGxX; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6B9nGxX"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b550a522a49so5294175a12.2
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 14:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758662688; x=1759267488; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuOBUVu3v0xeuOIHgrdV2iq0i/c6wqIxTcq9GgQSu7w=;
        b=J6B9nGxXzR6K9/9WEbUX+/0w3ZH7DHuMXZKUqp8I0nKof3nBoNpb5rPRxSlOZ2KcM2
         lwSaw2QkPR6b4ror4sdTVw03iREwDNcDwIGd+c+gpvbuk6nVds2ur8qiKPWsPdyQdAC8
         lugdipVjUOjRh34w90v0l9HV0Udr7zssRWIAswlTrCz8woQL7HXQMVIYMe+mi3X8UPfU
         8a/c5lXXbs3ckto/LkQxoLIlUhvRzf9eNM8KpkXgBGoyrAFDZupO/zolr67VRotZpJGZ
         06dBwnOPf89/xZ98KyievlFkW51BZoEB6WiF0CbBzSQAkv5sjUjZCDormHIMJfzsLdFr
         IOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758662688; x=1759267488;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuOBUVu3v0xeuOIHgrdV2iq0i/c6wqIxTcq9GgQSu7w=;
        b=C3KljU1kiDCbpMss9t2/k3e6VRkW2OKdrlpetagLX1ukIloNM7jDmAwxG9OE/xmLB/
         bEqD4eMTOi7GxfThNMFVdyYon8fyjundQdMDMFmvgQh5J2WrFsahXbrE/GI+hkq62g9a
         MON2aLbOxdlE44kGpn8pwe6jocFFOw8X0Qulnmj96EcAm+AN25n5ghAiHPSzXFfTdvK3
         zk7Z6AsuawwHSKdiqgSp9rCahCsmSKJBn270jbaLbkc8IBSi8NWBnFzNzjksXDYwJwx3
         lNkfB9s8kk/7FUCqyNOxwe99WRcsO00iuiGhj9e8gVFFrZuT7cIs7MdyT2Yhz+Bi1mBp
         J+KQ==
X-Gm-Message-State: AOJu0YxuEOvr0uyas57S0cM/wVz1mfHLVcIVwstkaRlCNXUPm9TPQHGK
	wcSWMWWP+fG7L7hU0+WLZAwfuDIb+G9jhr/bMAM0faMeg6PHqbqVD60gUWWtmKue
X-Gm-Gg: ASbGncudO+hRTK9rSB4xvzbt0DBoFPDFWUUrnWHXqG9E2sZBRLsOuwAAblOvUTLG1Oa
	IXPBMMAK5H6RnbPguf18XIFf60VQD3+LXAUraepw6OgLswfehYy/MCyWkZCvfX5NTCYX1z81w0W
	e+cw3MmbkQLhbKso5XC6E2tb4e6O9q8eigzloRMCIjH8WfxgM0HtHROM9D3lLR/eRm7mSrNfyDI
	uhaSu7kO14JjcxwQIL5U+Pmi1Unvl1Ex7IkgfzZyuAfFnQV6zMe70t2TG9HwpMup3I601+mcLhy
	P1k8uHqc8GWphFsCl7weiF7roQw7jKTE7DhVWS/YbMaN8s/czl28ZPe5A+L+Y+Gia1Iv+pdRQxq
	dIdZ17chGRfFowuFHPWdPgDT/8A==
X-Google-Smtp-Source: AGHT+IG5SJhBIw8Jequ2ViiMcoaDvugADrNeIYcECJJuM5BMQRErFRUXpV7raFRcAjvLNcGAjQxF/g==
X-Received: by 2002:a17:902:f710:b0:26d:d860:3dae with SMTP id d9443c01a7336-27cc1572006mr39824765ad.3.1758662687864;
        Tue, 23 Sep 2025 14:24:47 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bd90332sm124457a91.1.2025.09.23.14.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 14:24:47 -0700 (PDT)
Message-Id: <7b0856108a29f42e5a4d3faf7489d5522b683f71.1758662670.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
	<pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 21:24:27 +0000
Subject: [PATCH v5 10/13] xdiff: delete rchg aliasing
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
    Jeff King <peff@peff.net>,
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

