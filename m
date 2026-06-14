Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BDE20DD51
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 17:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781459546; cv=none; b=lvSB0dN+gpE+BDE91zylmxgB8nSeprd2Isxgwlzdq3qJWMo95qXSTW4pIJh299yzFE84K5kE9jdpXfEC4c0L4qlSHIcoX1Y99ki8OUi/k/ruk2kb+7/3oKtOVz4ZifFYU72TJexIqvC8Slpf1sRk1tLN1nLk8Hg4/9kB1+Kduk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781459546; c=relaxed/simple;
	bh=j/Vjnp+mf8PSq2xtGnqJg36+fCDkBpIbR/rR35tc8Zw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jO0CAlzsHKkst8DFnWvpuJewDVf2gWwhFgnw/AjqIdNyFhqBVO1FFRE7N6sMLonjsGzc2aqz1C0CNnVN4xMPhqpDXUlfAG5mOTZwg9d/kS5zdstNdt2PCLiTIroJpuVWmdq7omUJTXkmx4XU1fFj8TkGbuTCKEx/mBqrLD2RwkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEryiUdd; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEryiUdd"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-304d7f31215so2377088eec.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2026 10:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781459545; x=1782064345; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JNy9Rgptiw0TNBN1DVGf1BcKYmY6CLyrH/uRV1zJ5A=;
        b=VEryiUddf+OgIyYt4Zj9hOOZurIuFj5t44mbdFYY0ZcT74cJJJtUq4jeXf8KIcZLGy
         VZQ/4JyELMX96RyZyazmxrPixmLlzSPpycwj/p+A7JUMUiQzU6N+S2x6/br8WO7P7u/Q
         C4U5zgDvZudKdAG++F70dZz59YDrT65ihLhnJDLrerAcppQ6KPtwRa77FsNWGtZZioaV
         1VsqD1emCVw2918eoimiSzCSpMX1LduZpJBvKxwHB9ujJRAUSsTlfBAct7yDld4LbGDe
         ujEHX2Hu3aGc+Rpz15fpFGsk2dIyKpT9C/VNblOI3aQ/HaZQZHC1FDGasEtf9gAxwSCK
         NawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781459545; x=1782064345;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3JNy9Rgptiw0TNBN1DVGf1BcKYmY6CLyrH/uRV1zJ5A=;
        b=LwTJyEpxSuBFPEIhSY1viBqsfatR6l2TuGB2Cbtf8C7wvCaiy2CBXhqJPK87ppx3NP
         Dc9ofPKpR8If5cezzAKwIsHltjxCuOZsb0Hf1bi+M5uIFnfWOOUAE8oPUYA2xpAM6rCe
         sNyS+GhYSIWAif++RsWtOJcDkIu+QpxaIioHRFVXAHPm8sPp+lAssSpJzBoxu505c8I8
         EGcCiQgTmy2Q/31SBymCMwm3opNRciOpi+9B96c6qcBF64PhI4+3GdUIpxcJcg8fFn/k
         1QlaH9qdEjjqSV7R7TALYbL/ZalgcqQG71fGo8aYjl4GEnkTx6tfjvANXSuksK3txQJp
         7kvA==
X-Gm-Message-State: AOJu0YxmtpG0TzZvrQL2uX2G8eWYeLYzExEr8M5kOekO7peiNhj6b/kI
	RdYlkyiiLXb4vi0NP+yNqZYRKme3fUeENmSF8nsIfENRSDfN9f5sWSU3gZNmNA==
X-Gm-Gg: Acq92OE8Tdz3142elvjTqrj0AUYWqnQDDXKC89EBppi65hYWwrqBnzTw7quVRZQ6zb5
	OJMNjwPUPDaNjsAEMevA0evoQH+5Kg29Q8W8+ClZ+Bevb9gHHBc+4gDbp9bj3jOujqo5IeAJnEQ
	Un7RM/LVgI9QiZUOXSvwR9IO56UkPOAWpKtDIc6xSQ4LaFTt5/vIa7eoe0o/LOLfZM1wUgqKB8Y
	UbmUVAInta928U7RV3zm+jeQOApqXdTb/B29aY97xZNK6u4+32OQWhKKjTuDfgDm4YegMrdrvhS
	SpqUXP5uSYV2k3WTpPgaPSpNeNRaz6SghORnrcSGVTgrTWAXrYErusU41Fk3Gk1+P8d9aDdrRIt
	bvqWH/6fGKBL0rkItgTQw3iNbYn43QTyLQCPaefstI+BfFw6bkvM52FyjU+dzdLaTN7MVBW8v+K
	o8F+mYvTMuHFZJHDnQRkp+yTIcWwGy
X-Received: by 2002:a05:7300:b905:b0:307:d4e7:b18b with SMTP id 5a478bee46e88-3082004bd24mr6088538eec.20.1781459544572;
        Sun, 14 Jun 2026 10:52:24 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.212.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d810fsm11918588eec.12.2026.06.14.10.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 10:52:23 -0700 (PDT)
Message-Id: <5071c5106a9740ba7d11d45803ec90340f43aa4c.1781459539.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2339.git.git.1781459539.gitgitgadget@gmail.com>
References: <pull.2339.git.git.1781459539.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 14 Jun 2026 17:52:19 +0000
Subject: [PATCH 2/2] git-gui: silence statistics under "make -s"
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

The catalog rule passed --statistics to msgfmt unconditionally, and its
output went to stderr, so it survived "make -s".

Pass --statistics only when "-s" is absent, leaving a quiet build silent
while default and V=1 builds are unchanged.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 git-gui/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index d33204e875..76245fa84b 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -90,6 +90,7 @@ ifndef V
 	REMOVE_F0 = dst=
 	REMOVE_F1 = && echo '   ' REMOVE `basename "$$dst"` && $(RM_RF) "$$dst"
 endif
+	MSGFMT_STATS = --statistics
 endif
 
 TCLTK_PATH ?= wish
@@ -155,7 +156,7 @@ $(PO_TEMPLATE): $(SCRIPT_SH) $(ALL_LIBFILES)
 update-po:: $(PO_TEMPLATE)
 	$(foreach p, $(ALL_POFILES), echo Updating $p ; msgmerge -U $p $(PO_TEMPLATE) ; )
 $(ALL_MSGFILES): %.msg : %.po
-	$(QUIET_MSGFMT0)$(MSGFMT) --statistics --tcl -l $(basename $(notdir $<)) -d $(dir $@) $< $(QUIET_MSGFMT1)
+	$(QUIET_MSGFMT0)$(MSGFMT) $(MSGFMT_STATS) --tcl -l $(basename $(notdir $<)) -d $(dir $@) $< $(QUIET_MSGFMT1)
 
 lib/tclIndex: $(ALL_LIBFILES) generate-tclindex.sh GIT-GUI-BUILD-OPTIONS
 	$(QUIET_INDEX)$(SHELL_PATH) generate-tclindex.sh . ./GIT-GUI-BUILD-OPTIONS $(ALL_LIBFILES)
-- 
gitgitgadget
