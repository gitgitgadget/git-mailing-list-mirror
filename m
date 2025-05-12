Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F55296FD9
	for <git@vger.kernel.org>; Mon, 12 May 2025 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747076605; cv=none; b=iZDrEKrUsZitxUzqxNaKjj3mONpYGEq3Q1r0+CtHm+t66CT4D4Rwa9o1DKr6bCca5cppnWlbfu2bq0MuMaFYLtQHhPo2WiOVK5Xa2v03oRwmUrTX+d5gLxAJiaasaj9GKzYRwmqNW4xVpcbTKkviwXpDTqkohlSX7eH20nmHJG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747076605; c=relaxed/simple;
	bh=8zirgTEdzne5epiX2juvRyzw0XJLdU30JLstkrLWoV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=reY7oVztDqLUu/Dn0YqpInI1ncx3csRkqd8k9eaSMY+ZfWGwi/kX7gXF6nK8bSyvBrEDzDn4HPwy8Fs8D8mlfZKkAK64bK0NP/Y4AzLutqGj9YuiTDaspYorTDfIbln9AtoDnc3/AZRU9eYVNgEYweuuCt4Ku3fQHs9upKMti4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NHPZppVn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jmNLiew6; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NHPZppVn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jmNLiew6"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 86FD71140090;
	Mon, 12 May 2025 15:03:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 12 May 2025 15:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1747076603; x=
	1747163003; bh=nxx+8fQR1Y14N3+Kwyrjj1R0M99gpeYNll8gZQLJC9Q=; b=N
	HPZppVnV2JJYK4etZyZbpAi5bHZUTVsfCzG0HwDPJLAz8xENNEwRZ5zNONYDKKyo
	9lbKChviCr4cCShvKCyC2d0886005IRy0bkU7f5rnaI9v3atS5GPEmCtIhaUrk0h
	pkf951NrNXMp4foQGGL9Ybqersepw9SspfZyLo4VFBTFADgOBkdJqyn13hm5Z9gC
	ocyQ2HO3TySJPiE6QdCvKKh/6DTt/HcCSiFJ/kia8rEdbBDI0T0OltB+7a/TMeh5
	72QwU6rvMOw2nJ7GgHk+rQwU1soUrSQYcgeDeQre2S0dzztQHkhFZsyExEBuxbUM
	slckZWwvmq0ksrpUEtmAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1747076603; x=1747163003; bh=n
	xx+8fQR1Y14N3+Kwyrjj1R0M99gpeYNll8gZQLJC9Q=; b=jmNLiew6mqoJmAHv0
	/dsu6d1VrRQexzuBrK/11MlYmFQAh27eoBtM49nEt+DuKx/XTBaSK+Q5MMQ6qSiU
	6CISW8vYA2a2TltIHWFXSJono3s7sGXtOSpY6Ztbr6jjlX/HvTR1DtPoTo5+P5bC
	eFgARLa+/0EUiW8XVoSsaqG7L8uyIQyX6rMdlO6dfAYgWPK+7z4VV/jlmEgQfHjb
	RJxyBYrhTJKZDiq8YXUY3TIy3H0Iwdp1ziRWEGhTRThbcAum/eyWbXxnFUQRE95G
	574SL1MX4emH02/PIm2pbtqkyC5lGx+9Un8VVsQcH7Ecy28UHSHSGqIQylo8Cztf
	+efNA==
X-ME-Sender: <xms:-0UiaBHmaPAHnelJ8azgp6otCsQtLyOqR63Ls_lPfSkU6RpAgWY1Tg>
    <xme:-0UiaGVX_7ioJ0gjPdlWGzngO2dZzQTu8q8maK2EeFTai2tCyxIhaekYNlgs1OyEx
    NWsVOILwSSIGlTwaA>
X-ME-Received: <xmr:-0UiaDJMuUu8lrpTJrFdnABaZEXYSX3_FKw4SbYEBX6aCd9qYPR_tNKEL2w-dCRpoFcFpktkgnUf4GANkMHxTMq3xCHbMIV7I6ngutk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddvtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepvdfflefhueetgfektedthfduleffudet
    leefieeulefhvdduieeukefhtddvudeknecuvehluhhsthgvrhfuihiivgepvdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-0UiaHHJVZfuZej_GZrLNPqB-lJNB8Jc8HZJ-5rgYg8D059MoukRuw>
    <xmx:-0UiaHUP8nBj_LI-ZcNgUa2j58pM7chIb4ivWVbYAU42VBBGbqunvQ>
    <xmx:-0UiaCNPtseNaJDvg0AyYj9oYG_LR84pAVyFJWBKMDhgoxILZkHJtQ>
    <xmx:-0UiaG21mpThuyZ9HzGzV4Oh742tp5Am4cVfNaYsheWvXH3px0ablQ>
    <xmx:-0UiaGATFw4Cn7m4LzzMXqEyVwAsmkqTwC9dHLT_pBgON508t2ytK8Xp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 15:03:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 6/6] whatschanged: list it in BreakingChanges document
Date: Mon, 12 May 2025 12:03:11 -0700
Message-ID: <20250512190311.1451556-7-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-674-gc1e4f99c0b
In-Reply-To: <20250512190311.1451556-1-gitster@pobox.com>
References: <20250503005814.3030099-1-gitster@pobox.com>
 <20250512190311.1451556-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This can be squashed into the previous step.  That is how our "git
pack-redundant" conversion did.

Theoretically, however, those who want to gauge the need to keep the
command by exposing their users to patches before this one may want
to wait until their experiment finishes before they formally say
"this will go away".

This change is made into a separate patch from the previous step
precisely to help those folks.

While at it, update the documentation page to use the new [synopsis]
facility to mark-up the SYNOPSIS part.

Helped-by: Elijah Newren <newren@gmail.com>
[en: typofix]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/BreakingChanges.adoc |  9 +++++++++
 Documentation/git-whatchanged.adoc | 10 ++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index bdfad29d8a..ac9a84c17b 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -178,6 +178,15 @@ references.
 +
 These features will be removed.
 
+* The git-whatchanged(1) command has outlived its usefulness more than
+  10 years ago, and takes more keystrokes to type than its rough
+  equivalent `git log --raw`.  We have nominated the command for
+  removal, have changed the command to refuse to work unless the
+  `--i-still-use-this` option is given, and asked the users to report
+  when they do so.  So far there hasn't been a single complaint.
++
+The command will be removed.
+
 == Superseded features that will not be deprecated
 
 Some features have gained newer replacements that aim to improve the design in
diff --git a/Documentation/git-whatchanged.adoc b/Documentation/git-whatchanged.adoc
index 8e55e0bb1e..d21484026f 100644
--- a/Documentation/git-whatchanged.adoc
+++ b/Documentation/git-whatchanged.adoc
@@ -8,8 +8,14 @@ git-whatchanged - Show logs with differences each commit introduces
 
 SYNOPSIS
 --------
-[verse]
-'git whatchanged' <option>...
+[synopsis]
+git whatchanged <option>...
+
+WARNING
+-------
+`git whatchanged` has been deprecated and is scheduled for removal in
+a future version of Git, as it is merely `git log` with different
+default; `whatchanged` is not even shorter to type than `log --raw`.
 
 DESCRIPTION
 -----------
-- 
2.49.0-674-gc1e4f99c0b

