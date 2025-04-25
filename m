Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4111B288CA1
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745595514; cv=none; b=m8XUorYbpMvFQSLRfvYsHBvfKAcPmAgqbonoQ1mD0IB6czr6HgHaQkuRL8qW2aPO51iBHquolpGmY+iiPSQt2Xl3kAm+k3PywVDRqNfNtFbjL3MNcm3pAdSeG0+rlZwMt8laBhTzliMjH72as/rKw/XeJYKkcZ/30Gr8EHEzQi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745595514; c=relaxed/simple;
	bh=0fVKn5P8l1LI6PXkC0/bLPgGn+yJuCpZUIROHRfrm+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3VyJg5a7AfCWVyaVivyzFc8fIthxpXJlFVEIXTbG7jtscqQkVxwHxAdDnhCUAd94A6V+oEngIMs1gEEAaSzalVT1qcVv6TzIElT2V0U+tPVSrE04gAH2B7VwC8TU39F5iwvMZoe6s3TAr1KfvLfQZGJdPsP3EqvLYvW/1ssW50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M30kcyE8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mK8TDo/Q; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M30kcyE8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mK8TDo/Q"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4B369254025B;
	Fri, 25 Apr 2025 11:38:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 25 Apr 2025 11:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1745595511; x=
	1745681911; bh=++xRvRH4fjo7ZWdG4rlyReWenICTkGgRU+/GwrD8gy0=; b=M
	30kcyE8K09najW90HbfeaMuQl+PVOfpZHo66KpgXYDMCjy4VaGLXJQWxOvd5/6l/
	+FoFnvvkeR2ud2en6iAod2LLXCf5s0fEE2dc1wUhJXqjoF+nYCcJudRXq3Ka/GiH
	RAnWaSWltTmikUf0+HWupsaA3x+n0i+jyEbshV5LaPuDQus8Y3EaJWsiKt8XawKd
	LRN0ByRyJXBmjNS14g5mXFO0iDIzM/bcCMCxSKGB2NfIiafWuwLizIfA3TK5SIY4
	3rKOU/hwsBDsEBvHnAr0YoxmdN9VVd5mh7otYT+ozA2l5o5LeW9o9GmcfmtQoEy/
	uOSxVYlVzb6gZJt3Pdelw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1745595511; x=1745681911; bh=+
	+xRvRH4fjo7ZWdG4rlyReWenICTkGgRU+/GwrD8gy0=; b=mK8TDo/Q996klJcw8
	CppMJ6xCN9YfyVEkSnOYROvZrtWveJDK+bRJj1LWSlb4cYAYlMGXt4SeciLr03ex
	PCwm5avAoQxQEk6fQV/Y7WcZbQIUc1uk44imhxsuUHEKBGeSFWFGweBC6EfrWjeR
	8Tm6FX/dUw4Tt1NiY4jrhRCQ9IVGyq691NBDyWviWCAGDYNpPbTX+XH76beGes0u
	zwnU4pt5+WihYzsh90/Yz52RpKf1ynfdTwIwmImCdj+h2iqTI7xWVySZO1NAqGWX
	9e4DHIXZ/iy+2nua54gOdZ+zyTkhFcD/YRW/CETaS1nBYVOkBwpsF7SMz2FrqehA
	CYjBg==
X-ME-Sender: <xms:dqwLaL8av3s6DMdS89zFjNKJPD3alCum3BriuLIjtUp-RrOtc5ZngQ>
    <xme:dqwLaHsZcPTUXWEWf6X2vMicv7lDNTNXDlUyeglgZ3EpY0xxW3rSomk_m2d25YIgG
    wu635PZaAijYQHjuA>
X-ME-Received: <xmr:dqwLaJCzY-lBaig8Ony3kv1zBn0auzYC7NWJyVo52XXteeErYM1fCGwVhh3ZbwSRTQE96HV3nSC39stD8hs5an7M2tWCv6_qYTdZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepvdfflefhueetgfektedthfduleffudet
    leefieeulefhvdduieeukefhtddvudeknecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhgu
    vghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:d6wLaHdAaqBLlq4RvlnKeff6kH4cm08AvnZJ5lC_laUxPYeUxXilUg>
    <xmx:d6wLaAMhIJ9w29b0ah1JkjaQccUBh_rsqFQ7vNVU58tNM23y6ktoLA>
    <xmx:d6wLaJlcASjwLAOIAOxjyh3UPPnjxi-7uDPakrXiuhQaGe92FvWaow>
    <xmx:d6wLaKt0b79_VUKPtIbGN5KY1mZF1Gd6lTrF9ZVjYN47HL6N6uTglw>
    <xmx:d6wLaEPI9S5ErIrSFsQMQM0dTi7kk9QoMTtSq36o5BV3lS3A6jbV335b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 11:38:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] ci: update the message for unavailble third-party software
Date: Fri, 25 Apr 2025 08:38:26 -0700
Message-ID: <20250425153827.147585-2-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-564-g9a5a794ec8
In-Reply-To: <20250425153827.147585-1-gitster@pobox.com>
References: <xmqqr01guwuq.fsf@gitster.g>
 <20250425153827.147585-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An earlier fix added an extra message immediately after failing to
download a third-party package.  But near the end of the script,
their availability is checked again and given a message.

Remove the new ones added with a recent fix, as they are redundant.
If we were to add more places to download these software (e.g. for
other platforms we currently do not download them on), the existing
warnning near the end of the script will also trigger.

While at it, as Dscho suggests, rewrite the WARNING: label on the
warning message to ::warning::, which presumably should be shown a
bit more prominently in the CI summary.

Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ci/install-dependencies.sh | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index e51304c3b0..be20271d3c 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -71,7 +71,6 @@ ubuntu-*|i386/ubuntu-*|debian-*)
 		chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4" || {
 			rm -f "$CUSTOM_PATH/p4"
 			rm -f "$CUSTOM_PATH/p4d"
-			echo >&2 "P4 download (optional) failed"
 		}
 
 		wget --quiet \
@@ -79,16 +78,12 @@ ubuntu-*|i386/ubuntu-*|debian-*)
 		tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" \
 			-C "$CUSTOM_PATH" --strip-components=1 \
 			"git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs" &&
-		rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" || {
-			rm -f "$CUSTOM_PATH/git-lfs"
-			echo >&2 "LFS download (optional) failed"
-		}
+		rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" ||
+		rm -f "$CUSTOM_PATH/git-lfs"
 
 		wget --quiet "$JGITWHENCE" --output-document="$CUSTOM_PATH/jgit" &&
-		chmod a+x "$CUSTOM_PATH/jgit" || {
-			rm -f "$CUSTOM_PATH/jgit"
-			echo >&2 "JGit download (optional) failed"
-		}
+		chmod a+x "$CUSTOM_PATH/jgit" ||
+		rm -f "$CUSTOM_PATH/jgit"
 		;;
 	esac
 	;;
@@ -151,7 +146,7 @@ then
 	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
 	p4 -V
 else
-	echo >&2 "WARNING: perforce wasn't installed, see above for clues why"
+	echo >&2 "::warning:: perforce wasn't installed, see above for clues why"
 fi
 
 if type git-lfs >/dev/null 2>&1
@@ -159,7 +154,7 @@ then
 	echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
 	git-lfs version
 else
-	echo >&2 "WARNING: git-lfs wasn't installed, see above for clues why"
+	echo >&2 "::warning:: git-lfs wasn't installed, see above for clues why"
 fi
 
 if type jgit >/dev/null 2>&1
@@ -167,7 +162,7 @@ then
 	echo "$(tput setaf 6)JGit Version$(tput sgr0)"
 	jgit version
 else
-	echo >&2 "WARNING: JGit wasn't installed, see above for clues why"
+	echo >&2 "::warning:: JGit wasn't installed, see above for clues why"
 fi
 
 end_group "Install dependencies"
-- 
2.49.0-564-g9a5a794ec8

