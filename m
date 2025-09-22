Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9353E31B11A
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 19:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570726; cv=none; b=XlgvZSewWhJtSfdlfpD2FGNZCb205XBBzCYENTXs1EzJayVSv263CtBVNX5abJiePfBII7i/OAa0VMaWp9UvVsLucdhJ7lfZLKJMFKw8LrznF1Gl3S6L5ruwLRaRQj27+BKRG+wrMBQmx7801olMMvwTvVaidrsBdACRl7q7QBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570726; c=relaxed/simple;
	bh=C+zRmtMxwotg6fA3Rt/nqowYJiULyWI14WeQjF08LMY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Qxwl8eucCeFn5XuZ6vNAKLmKmuslJoQ5TMNXqfB/dTFOHXCEyZLKh/0jNI7Jnv1nA9NGFESQdqjO61yRRTPChZBgQfTGzZuMcp6JEyOQEOY0XKEEEfBVmBuiY467KUOQ7ayo4CdDXbn8OcwUjsekA/rFC/TejdUqFWd0H27u9dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5Jfc9/C; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5Jfc9/C"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-42575d46250so14363125ab.0
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 12:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758570722; x=1759175522; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuOBUVu3v0xeuOIHgrdV2iq0i/c6wqIxTcq9GgQSu7w=;
        b=e5Jfc9/Cq1rbID1pr6wvTk4S9QRmHNCMd6E6nsIxvZ4B1/KfluiZjMb/lR2nuztv7i
         sXh3gCv8KHiCsL1BFoFXEZqvMAFGbybs3G8WAEluPltCyQ8+Ks50KOcAMEkj2K/cPWBs
         yJXO5FZMfE/OPXscdExh/tG6wSDPZU7rwYO4ZzfHcycCyfsg/iYd/sCK+WDWLDR5mKL7
         grJms9/MlviQLi5db+PEJO7siV0wGjuBfkPQ3BbAMqARxsY4H07k5HwXfeWLN+z+oLnU
         AaPMyeCpf2CDxw40T/RTinjII14Ybay4EiogV1YwaRUrzfCzZlKA7qLZVKt+YUj0dIiw
         6Q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758570722; x=1759175522;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuOBUVu3v0xeuOIHgrdV2iq0i/c6wqIxTcq9GgQSu7w=;
        b=AIrdnKbgnWHgwmXy3T/hCISlEqQouPdjNq5kaGmrbYpNZ0Zja+rMmeGnNphkLi40dp
         YmLF6GDmyq89ZqxVS/n3z8ZuCYYsvhumowLE2Riv5rbCKk9xLwTQPXJmJGS3WcHcfXUb
         WfOOGXC7i0o5ksBT5GS0iEVzOp8QWoN4Clj0vlPbHh0mldVOke3edZqhhKWrEIe+UZbX
         sniTyWLR44itEZ2bCpJjtjvRuacyNyvtre8hk922b8h4TmRys5px5K86wi4b7aID+ixA
         HM6M94GYb0sTScKBmPo0xPa1+ovtMm/WXq3l5rvE6owXGGNIm2nFzplhZjn1Z4Ptt3lX
         p28A==
X-Gm-Message-State: AOJu0YwDmihR10w5IPF0zVjpnjP0s8l+9UCtwOwwjKcqSsr0l1xbBQv8
	l6T7eKBjyfXW9LcdhVtb4yNMO+s291YKQ16bVjifa4Fg70HncR9WPGzMfdikww==
X-Gm-Gg: ASbGncvPgBWd/DMX4eEzGd8xMoPlsSN/1lMuC8tLVq177tR+4GiuflGGX4jotOlRqBl
	fMIBoTDHVKdICtP68fcqVdCDQHMCFRzNjjaX/Cu2ny5IKgHn8y6Pv/RvT9A0De54M43XzIvQpP5
	XGqFTUHtOXIFeQ9aQ427n63BJhUeLLlqArfLsp93giX5yGEgvjCwKkrHyhsu9GHpCLll5Kmvr9e
	XwQ32lvlNsg+BZKzM3gbN8wd8SMVAcq1qCNTTRqGEDsX7OAXXa4O6f/lZmzLb3lNiH2Q/CjcyjO
	ovxWRQozqub785NXbA0ybQhBRh4ymZLW/JQlaI8VPMQaxuixWi3P1wCp5rlfAcijRGwDZpZGDhm
	7h68cUuzfGNbXKj8SRNWSf6qKLg==
X-Google-Smtp-Source: AGHT+IHU3kdgiZmKJP2mvDo4540VKfLu042lntRt+h944ToRZWCzKX7A/yfP3UoOCdy9S9AyFrT5IQ==
X-Received: by 2002:a05:6e02:2782:b0:424:8030:2f86 with SMTP id e9e14a558f8ab-42581eb42ebmr2177205ab.29.1758570722343;
        Mon, 22 Sep 2025 12:52:02 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.80.135])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5505433c271sm3951531173.78.2025.09.22.12.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 12:52:01 -0700 (PDT)
Message-Id: <97135495e213d274e145eb96a5e1d60ec694ffc8.1758570701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
References: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
	<pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Sep 2025 19:51:39 +0000
Subject: [PATCH v4 10/12] xdiff: delete rchg aliasing
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

