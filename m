Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DB31DEFF0
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485811; cv=none; b=RE0j+uvQtj/C1+a6tVw2O/jPaQtD5koTiXsFyvaywEuoy0P8gE2WSiFFnb/eqw3aFRaQglXgZrsHznvIGdq9+Mblbg5WOvYfNLSTxa2UZbD9lGqC7q7U9Z8AUO1xh1t7xM9sp+QgOK7d0c7GSXQyEDDoy57EamFN0AjrUX62cSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485811; c=relaxed/simple;
	bh=SLdTqxSlyXH68V1nqHRtdOi3MlKQlNzre+BYo1l8TZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wmaap+K4+gxzKsOoaF2oqaFD1eMoLuKShlA9B9mCBRmgKmlLqRt11hXYbV+zUiUaOXJW9FJF9eOEzxV5q+6G/OikFsQL+rs0uQrjJMurBVrtB7E2/fGRlFXERSDorfn7rvG3iyjS64XIb5xxQhW0awzc7A8hr+Y6urqIdW4ozis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SxSq+Wbp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mddyFutF; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SxSq+Wbp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mddyFutF"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D2ECF13801C2;
	Wed,  9 Oct 2024 10:56:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 09 Oct 2024 10:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728485808; x=1728572208; bh=zXCzswH6p1
	bB7+oTa1qN17e3pkC6PAqW+fT+rqPq7YM=; b=SxSq+WbpJ9yfmHlY4KpHku3RI2
	JrnNBu7Pwno1tkPU6p14cGKVzbtfqvrVxm/fwiFOF4kctV1zs9X75lziZ1HKvUVQ
	BemyiDHQaF3x1JwiQlFL+vFI8lzev49l64io/7Jcfv2ZFlNSFU+u595gHviClLhQ
	a2o8Z2PWvB/EDerrtaAmdRFtipIYKOX2R5ibWCu7JnPnzLqJlCoM8Ig76gV6Fim9
	v2NZ9FdaZPs2nStigeWmX2UDyYl27Tps/Bslkrqp3u9ns1sIlpxozv4J+ADwALy/
	nG+7x/xysti1UYpQBfez3atRNht2+V4q9rsf3z1C/wQWQv4XOyCIYazpBu4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728485808; x=1728572208; bh=zXCzswH6p1bB7+oTa1qN17e3pkC6
	PAqW+fT+rqPq7YM=; b=mddyFutFPTjj3QrxIkhx9yCj2Sc55wY3bdvTHBufVZE5
	kfvm+xfbxohGQ/f5Ij7RiNFsH50fTU0JVSbI2nTH3aFp7jFDmLfrx6UwUdAzNrux
	NeUOol4qI/YUAUQjtrLun8zzgVWfYKWJzpyi5iCLJpw5POZVrfjM6cs4iWLMjGeI
	C0I6auYs6PF3BYVxUxy2x+8RmSYX7oizeJFhfBbCwxi6XNceCz44sEeXvncdKjJY
	oziHin2+uI2QjLa4Xbu0palNpsmXar8eIsddCH1QtRsvMcSLrBBmtEcR/SY6oQ8c
	Dsc0GG+BKl+rORte2wFMc1b6G9hvCWBFv+TxJtrXug==
X-ME-Sender: <xms:sJkGZxKRwQkAY9kc1EiAN9txm57wpxtBjV3E8MaYDFwgIVvTFw5zTw>
    <xme:sJkGZ9IMT7ALrVJtDfL1HcDJe6HM_Mr2jZHJmh6UdPgyOQ7Y4ATEUt2M4Ge_nAITi
    W1-GnJdrvDMLmVpmw>
X-ME-Received: <xmr:sJkGZ5t5JfyXeednrvHqm5OgUPPglK_gzN5OjbmTweNQaYHgOesNu4HFV21Mw7_Re9tAKWKccOHdBaiLcpyMlb_bKoV8jjB4nVy1DVArRyiuFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghstghh
    figrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuh
    hnshhhihhnvggtohdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdef
    sehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:sJkGZyZ1_dCkSoUJDQNmQU2tE8jNF5lg2idnakou1NK9__XnRniyKw>
    <xmx:sJkGZ4bJduI-kuKhZN9jjCXBnI8iBXq9t6rsGNs2niYKxti539kNRA>
    <xmx:sJkGZ2DOEKJuZ71kUwXjvfIq50kXnRCBEhsrkHFJxaJ-yB_MDgkU7A>
    <xmx:sJkGZ2awrw2M4yZ4WSvJ2QSF5IIMN_pncoD703f3g_BpXNDAGoZJeg>
    <xmx:sJkGZ3y9mdkIQDbyyWXeELk6AzcLrq6c8CPCPGzvE6iAE52qiAQhDnuR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 10:56:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d5d3dbc2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 14:55:44 +0000 (UTC)
Date: Wed, 9 Oct 2024 16:56:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 13/24] Makefile: extract script to massage Perl scripts
Message-ID: <7f567d7ce237460e37b8eae29d14c453f95f3e94.1728485139.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1728485139.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728485139.git.ps@pks.im>

Extract the script to inject various build-time parameters into our Perl
scripts into a standalone script. This is done such that we can reuse it
in other build systems.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile         | 10 +---------
 generate-perl.sh | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 9 deletions(-)
 create mode 100755 generate-perl.sh

diff --git a/Makefile b/Makefile
index 0d542c58f3a..50fbc4f29d0 100644
--- a/Makefile
+++ b/Makefile
@@ -2605,15 +2605,7 @@ endif
 PERL_DEFINES += $(gitexecdir) $(perllibdir) $(localedir)
 
 $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
-	$(QUIET_GEN) \
-	sed -e '1{' \
-	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
-	    -e '	r GIT-PERL-HEADER' \
-	    -e '	G' \
-	    -e '}' \
-	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-	    $< >$@+ && \
-	chmod +x $@+ && \
+	$(QUIET_GEN)$(SHELL_PATH) generate-perl.sh $(GIT_VERSION) GIT-PERL-HEADER "$(PERL_PATH_SQ)" "$<" "$@+" && \
 	mv $@+ $@
 
 PERL_DEFINES := $(subst $(space),:,$(PERL_DEFINES))
diff --git a/generate-perl.sh b/generate-perl.sh
new file mode 100755
index 00000000000..b9e04d6f42a
--- /dev/null
+++ b/generate-perl.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+
+if test $# -ne 5
+then
+	echo "USAGE: $0 <GIT_VERSION> <PERL_HEADER> <PERL_PATH> <PERL_SCRIPT> <OUT>" >&2
+	exit 1
+fi
+
+GIT_VERSION="$1"
+PERL_HEADER="$2"
+PERL_PATH="$3"
+PERL_SCRIPT="$4"
+OUT="$5"
+
+sed -e '1{' \
+    -e "	s|#!.*perl|#!$PERL_PATH|" \
+    -e "	r $PERL_HEADER" \
+    -e '	G' \
+    -e '}' \
+    -e "s/@@GIT_VERSION@@/$GIT_VERSION/g" \
+    "$PERL_SCRIPT" >"$OUT"
+chmod a+x "$OUT"
-- 
2.47.0.rc1.33.g90fe3800b9.dirty

