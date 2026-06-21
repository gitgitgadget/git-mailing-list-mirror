Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD56368D65
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782053808; cv=none; b=Q5IeBDLCCCeprC9t5TrT1Ip09SZ29fbJJJgE2fIhjKW1f5CQUgjZd9wvAUh1padFINDlVQFr8/OQNUBrhVMHGhwKRrJBvnROboiXbo+4ufE36Ivs8FzOffGCYaTkbmX+ZhaQKeDPRlkFzwE5SEp1JrtSQ0IMPgPgv02DpSXVoII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782053808; c=relaxed/simple;
	bh=VyXDUrHSD6zCaA01R9sreTjEBgS0CQHp7ZHUvfd8IPQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QJCZEE44D4CI4lG22ZG18BtYEVGR4iEo5AqQrVc9+VG8QoupEDJFLUzvGeIFYvKujUgZA1q67+/4nU33bSXsMi4rXp9yOpdU6hKkJx6SOBTpHHUSpdIW2NluiEqJH6/XLgk3bYmcyE+qa/vjUrNBm0WDZrhDH9+6f4X7RriofsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XltXMIhH; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XltXMIhH"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8dfd7b11e1eso10016486d6.3
        for <git@vger.kernel.org>; Sun, 21 Jun 2026 07:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782053806; x=1782658606; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUe5iMBMB2yakEyB5fxwUehiznt0+BhaC4byjMRTX/k=;
        b=XltXMIhHIaAABUY71tYjDF8vcDQMbQJPXF3f5xeug5V9zTEmVm6WigMd8tmh6hTYDY
         WJkxzzrEJpxCEgLHbtGHcBTzZN+/CaH4qcPyWt+cfQjlcUod2E9BsJk7U/Xj/ukGb4ZX
         XulbszdJguT5EQ/Y2QKfNmqPoFX8tegw52LA7D58Ze6429tPtMfX7K4qdO1AgIi+5283
         puqByMUrWFQg0wnSHGiJYdg0vN/Ygjp9NthSkgsuMCEKeCVUhicCivWA+o++oUFCZaAr
         QBb4MsIyWFg+MTh7caY9NHRupdp86NINQxYqGrijoQEJIF42CnS/zKj4KKfkL3nd/5T9
         xpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782053806; x=1782658606;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kUe5iMBMB2yakEyB5fxwUehiznt0+BhaC4byjMRTX/k=;
        b=jKUDChC+kcSGVwxz8u+6PY+LdthcIsVy7VUIZ/HaRwAeOqW695j07m/rDhV3HgO19t
         zVORccy/taqE8nMHanc6FlOuvY9tESe5SzKfCbYXBsg6zUFWdjwlJjPvuDzmxX9Nvh7E
         aYnQFCsFa5uB7/iXtfu+/4zNn3fUUiG1MNXJykyM1529vLwu1DWUIq2+SXJg9CwKRPn+
         OD2WIA/BJZWDqBFpzUFutjHfUi5nlWQ2SQ/bOEHPuTL0Z4e5wzSWPUKI97m+cJa3hu5Y
         U1Rw/vL1aXpE4SZgbBaS3JJ9VsXHnD+6QyKbMnStTR3YkPwic+fJZJuMkIGRVbSd9YxJ
         SlpA==
X-Gm-Message-State: AOJu0YxQIFKukJ1SXJRoCQT0b/kONjs+zfuSXj7oETd4eH+QS6YCYdjm
	0Nfj+e/+8ZHyqNW9uQ9lQ6ArZ3nnSYE9SZYhegCWcay3zTBB3sSPIdFJ5EKLlQ==
X-Gm-Gg: AfdE7clD4RVFKcLZ9f1gtpLkalq/Dsd1/k1BUShUrAyq9cLu3f3NJ89WBIi5DpWVFV0
	5f68dmsYU7v6oJ5Ll+6UD81m8L5Dj9OoRDi439Y/PZ2C2eAFbWJ1Xe+8qW76A7cOZQWorUPwDAL
	n5U/3SR0PTo0rb+f5KscskOxQ0xE/Wen8uzQM9F4J9X3CxV9VTiyuYpY2Lp3Q76SXmL4uPCESdf
	PXiLRBAD8tcdMjZTMUBKcqtwRMclQQgzs9eU04ZTcRV5UICVRaN4lJb7eW5EUR6qAjLjqoKI+JG
	Nc5qQOJHzvBM59M2716dx9QRXiUllezz3bQdLjFSRpErtKMxclV+REPh9AIMWFq1x7hh/y3vEKR
	tvM3SfsXu5PBKHJyFXkQCMEJRECipNmPQD88KjdtWhNdeSsDab8LVdSivWmtVnLrNPQfwdBil+p
	bhqY+FprVwzwPwtdan9+d4zTLaXA==
X-Received: by 2002:ad4:5604:0:b0:8cc:de2:3b79 with SMTP id 6a1803df08f44-8de3f97e7a0mr143396016d6.20.1782053806281;
        Sun, 21 Jun 2026 07:56:46 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.70.225])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f01855bsm70174776d6.9.2026.06.21.07.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 07:56:45 -0700 (PDT)
Message-Id: <b613d4ac4a258e0e280a15547efe0b510a57e83b.1782053803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2339.v3.git.git.1782053803.gitgitgadget@gmail.com>
References: <pull.2339.v2.git.git.1781995570677.gitgitgadget@gmail.com>
	<pull.2339.v3.git.git.1782053803.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 21 Jun 2026 14:56:43 +0000
Subject: [PATCH v3 2/2] git-gui: silence statistics under "make -s"
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

The catalog rule runs msgfmt with --statistics, whose output goes to
stderr and so survives "make -s". In non-verbose builds the rule also
captures the output in a shell variable to strip it to an 80 column
line.

The statistics are not needed, as in 2f12b31b746c (Makefile: don't
invoke msgfmt with --statistics, 2021-12-17). Remove them, and with
nothing left to format make the rule as minimal as the other quiet
rules, so a quiet build stays quiet.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 git-gui/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index d33204e875..2e1711adc5 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -69,8 +69,7 @@ ifndef V
 	QUIET          = @
 	QUIET_GEN      = $(QUIET)echo '   ' GEN '$@' &&
 	QUIET_INDEX    = $(QUIET)echo '   ' INDEX $(dir $@) &&
-	QUIET_MSGFMT0  = $(QUIET)printf '    MSGFMT %12s ' $@ && v=`
-	QUIET_MSGFMT1  = 2>&1` && echo "$$v" | sed -e 's/fuzzy translations/fuzzy/' | sed -e 's/ messages*//g'
+	QUIET_MSGFMT   = $(QUIET)echo '   ' MSGFMT '$@' &&
 
 	INSTALL_D0 = dir=
 	INSTALL_D1 = && echo ' ' DEST $$dir && $(INSTALL) -d -m 755 "$$dir"
@@ -155,7 +154,7 @@ $(PO_TEMPLATE): $(SCRIPT_SH) $(ALL_LIBFILES)
 update-po:: $(PO_TEMPLATE)
 	$(foreach p, $(ALL_POFILES), echo Updating $p ; msgmerge -U $p $(PO_TEMPLATE) ; )
 $(ALL_MSGFILES): %.msg : %.po
-	$(QUIET_MSGFMT0)$(MSGFMT) --statistics --tcl -l $(basename $(notdir $<)) -d $(dir $@) $< $(QUIET_MSGFMT1)
+	$(QUIET_MSGFMT)$(MSGFMT) --tcl -l $(basename $(notdir $<)) -d $(dir $@) $<
 
 lib/tclIndex: $(ALL_LIBFILES) generate-tclindex.sh GIT-GUI-BUILD-OPTIONS
 	$(QUIET_INDEX)$(SHELL_PATH) generate-tclindex.sh . ./GIT-GUI-BUILD-OPTIONS $(ALL_LIBFILES)
-- 
gitgitgadget
