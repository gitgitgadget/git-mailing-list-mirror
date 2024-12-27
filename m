Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10191F5435
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735308013; cv=none; b=aQj6FxIvkDKFGLAiA0xIjAn9WRBExi0JEg0g2n4vPHX448B6YUnR7WBipj58YUIQOqn+VWor60FGRRUM8Pxcg9X7zvzBwCeJMsCa7cW+PsJPNg49K215Pb7KXHZJhd6KxWJ9+UJGSMDW60UZdfpc+OiWDONp1tETHzstA1xIevk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735308013; c=relaxed/simple;
	bh=66ot4C1x3RabNf60gNM5oySNumzXHbfrikqLXJNLdUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TeI0iVrnC8HA2NMDsPjxdh5ppukijSh69Q1RYuwSUJuaXtkhhbViGjHGi3m/m3x+RQ6vXR7tfIvh7aajd6HzgDwWLmkzTWrgcNtmiMNwodpSsbvzJbmzL9XdqZx3qnrGaUncTIjcd+W/pHA+7bFjCbQhz5VgHT3LgTMm8Uf3PHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uZy4frEc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RNe0iPA1; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uZy4frEc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RNe0iPA1"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 058362540181;
	Fri, 27 Dec 2024 09:00:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 27 Dec 2024 09:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735308010;
	 x=1735394410; bh=HcGJznM7C5LtKOyr0BQFdZKRDlGgHHCopkTUWV8bK1o=; b=
	uZy4frEcKmIYx7Jm33RD+XDi5oa57AXCgP0ZnjvdC5bZ2ZBxoDm7kjCfsqjhO083
	BE3kGf/DIt1c2GkyrQiq8Sl5sCaENlECdfgn3SM4OcffMbM+DLt/5k0mYwg8Um2r
	NLNzMtbaIrCbtewy0MPT1GDJmv0D9uub8+AEN+PVQc8eQ8AyyNqsdTkMzPzeZVok
	C9AxVX8BmdTwbp1Cj7XbLi+8Hw0wZIUw80LveOMy24lD9YHkqFPhJiN/vZQvSnN0
	WKh8Oms8boNtX0TklRa45fyfg/wGoMvgoQZn31xxFFKNJPQ3PKjIUUtwrwxUUrPO
	Djkjnwkeqcqrd7Zaq4fBYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735308010; x=
	1735394410; bh=HcGJznM7C5LtKOyr0BQFdZKRDlGgHHCopkTUWV8bK1o=; b=R
	Ne0iPA1U/Wcq/zRnLFkeZ0Hcv2HlZZsTAxLO8Hy+Ns3zz3Nsdo8mqW+QN9+FBFDM
	tH9Vx7UGk8NJ8gBoekL4ZBQYNIXU1q/f1bgdmql/yhjZV+GfeLz1VIR5PUSGhTsN
	5/uQsAHbuHC/MzY8s3UALtlU+o31I8MKm/0GW+7P+1/wF+90it1+si+mf114IDf8
	bMOW2+g6DweNFnuN7M6vfsS6pDh4VvYqujsMAMCMxYjFqrrkTrtCLZtufgg1jl2j
	byVeY8LEHDSmaKySr6By7xWgMesFPP79ocjq+nveVL41aErM6TFKWHaxvhDyzctD
	hc15kZj65q2rCMKD4U4NQ==
X-ME-Sender: <xms:6rJuZ7YKklj_jeXn5cRiT8ncM2feHpk3PL2irHdoLE7Bos1sJ8Hdeg>
    <xme:6rJuZ6YvjOfcyO6-QfO07HKpXkLtSLhIzDytEvU6lg2BzeucNAgCFpEc2znCAEOPa
    S6wkfFO0QSUSPNY6g>
X-ME-Received: <xmr:6rJuZ9_F52GK-h2Y4cbycU0HEo-QqtXJT00Eo2pEtyZ5V2szEy75M3WDV9Q4k9T9mmVf7CC1226SgrT2DB7pGYGnzIGjUvlfLZbnsM0Wqjgh-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6rJuZxoG7fuYD_aW_UG9qSAfyFPaBicjxHwgy1I0xIwoLjDGboimJw>
    <xmx:6rJuZ2q5op8T1ssIK3i1PYWhd3ukvRVcqrYV8GRI-QZgXjxf1F5QJA>
    <xmx:6rJuZ3TKfIWOERm6wRGXry-wZHyQj12VqzGlEduB0_4-1iOBZo1AbQ>
    <xmx:6rJuZ-r8k6F4V3M2bANG4usQGq9Vlo9kFqHfYPno8eDIR6tMHfuedw>
    <xmx:6rJuZ93JPwQe52s8eSAFqN7Osgs-OoWIj4Eir1_wzU5EVxltP_TJ_Xvs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 09:00:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1084b22e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 13:58:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 27 Dec 2024 14:59:36 +0100
Subject: [PATCH v2 08/12] Documentation: refactor "howto-index.sh" for
 out-of-tree builds
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-b4-pks-meson-docs-v2-8-f61e63edbfa1@pks.im>
References: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
In-Reply-To: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

The "howto-index.sh" is used to generate an index of our how-to docs. It
receives as input the paths to these documents, which would typically be
relative to the "Documentation/" directory in Makefile-based builds. In
an out-of-tree build though it will get relative that may be rooted
somewhere else entirely.

The file paths do end up in the generated index, and the expectation is
that they should always start with "howto/". But for out-of-tree builds
we would populate it with the paths relative to the build directory,
which is wrong.

Fix the issue by using `$(basename "$file")` to generate the path. While
at it, move the script into "howto/" to align it with the location of
the comparable "api-index.sh" script.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/Makefile                   | 4 ++--
 Documentation/{ => howto}/howto-index.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b2d146c44f4ded750b5e0766eb66b25cb5ec08e3..e284ec8b98d6187ecb73011f6e490610dd3e7370 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -411,8 +411,8 @@ gitman.info: gitman.texi
 $(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
 	$(QUIET_DB2TEXI)$(DOCBOOK2X_TEXI) --to-stdout $*.xml >$@
 
-howto-index.txt: howto-index.sh $(HOWTO_TXT)
-	$(QUIET_GEN)'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(HOWTO_TXT)) >$@
+howto-index.txt: howto/howto-index.sh $(HOWTO_TXT)
+	$(QUIET_GEN)'$(SHELL_PATH_SQ)' ./howto/howto-index.sh $(sort $(HOWTO_TXT)) >$@
 
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) $*.txt
diff --git a/Documentation/howto-index.sh b/Documentation/howto/howto-index.sh
similarity index 92%
rename from Documentation/howto-index.sh
rename to Documentation/howto/howto-index.sh
index 167b363668b8b53d752d5971798d3ca26c8f7f1f..eecd123a93607998e8b4eb8511f4165973f9d93e 100755
--- a/Documentation/howto-index.sh
+++ b/Documentation/howto/howto-index.sh
@@ -48,7 +48,7 @@ do
 		file="$txt"
 	fi
 
-	echo "* link:$file[$title] $from
+	echo "* link:howto/$(basename "$file")[$title] $from
 $abstract
 
 "

-- 
2.48.0.rc0.311.gb6c66824c1.dirty

