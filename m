Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B2C27F745
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745425210; cv=none; b=XCFsqkbfbyEffLH0Dm+yjObkExQHCACAqKeAt12SK7qtDwa8TX+BEmWbwm1jXcgKJvzBMC76w/2AERIJH6FV2+M/KCQDjt0jYywv87HeX3uNTvaIZT0ufRKI5xDmTvULUNLBfIjOKN3Q3h5jPxqiFdhDiOrpGjOFs3lu+EbcRok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745425210; c=relaxed/simple;
	bh=Z60sPwQ/u+AHpR1souix1dpS/0mfxDNS5SmlpZM0yMg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rfpb1CBsF+QGdsKhuvegx2nA5l+1ElYJ6sSGRRe+dq/0gdd8RLbsAXwDjxfsfGeZsd2mos2n9he44VUocIa5FRf+3P1uqS27noKG4khY7a7xuTvYedbwDp5+KkHcecBo1LwAMZf33eM7f3QiEUZb5g6Npv105jW96z1EZiJVBxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xA78mfx7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YbDih9xM; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xA78mfx7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YbDih9xM"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 799BB1140286;
	Wed, 23 Apr 2025 12:20:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 23 Apr 2025 12:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745425207; x=1745511607; bh=P+N6kcbrPg
	LjRHDt/Tw5ssQdwdZvv3+F2sSyi/9wDko=; b=xA78mfx7IU3evU0ovRCGd56Tta
	1zMvkIOhR+yZkD0wGbY3Bjl5Yqy6PCppOybTUga+tjG/TKuF7+Unrd9f81e4eDbC
	quGxmUmv3gjwsCNnyfmK6Smv8hApPdsMnxzoseoOXTNLNnAjlg4LtvqmqRu12cMm
	XOXX3jr0HJ3z2K3Rllup7lSDQXL1kQNfoWN/cX4xl86J/Ep8wDBjqBwbrvKDtqD4
	gcDGn+dHWLVcunUSHpDj+ZNwgk8Sx4u3qaC/1cj3SDCKcrzHqShKnBHLetcTJvj9
	tfYyB/iFqeugI0J5PgVUmRBOFObC5FrxvB/176TgNp+VjAj8wBgzjKwwVfbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745425207; x=1745511607; bh=P+N6kcbrPgLjRHDt/Tw5ssQdwdZvv3+F2sS
	yi/9wDko=; b=YbDih9xMT/nlKjqFCFJqUQY1wX8T578wyrn7giEV9IpFCAW39Gv
	TIXUaEEGKGaRIbOx54LxnSgGS1l1wgll3OSzImgR4XQrvhe8axNghqpxlGHwE/L2
	h5WyEis10J/Cd37XMqPsWjqPQyJcvRyn7Z5QINmhamU6shKW+g8jBL7BpR45d6+I
	2r4SOONS/UrfQBIHkzAfVcxl/pv71OiIcz1qwBd9e3HPBPttl/TBSa0Ofc6UCGMZ
	c+H6OYEjgJ//sBaDJNcX+u9SDCZA6Cf2WJoD9bd8gVGRYTl1Xg5fMDZpDQYlzl/C
	QT10VGjICdFVMotkU0qfms8EWDyXaBMHkpw==
X-ME-Sender: <xms:NxMJaG2yH0HN0WxtOP4c5gXelCZ2OwAndP0KajY3a8ANu0ncJP5KKQ>
    <xme:NxMJaJECP39k-oUoGXQihVGw87nF3qvw7TUsE-SzMb5JQp3jyR2FgoWEd7O1cpi2h
    Aai448yI_cul52OzQ>
X-ME-Received: <xmr:NxMJaO61Lt3_QG7IeN0gwRTxxERQesNfIfEabS2kekoGt-OI9l_WS3goaIwZRGNoQhQDNzElzNh69f4KDcaRfwbb58m7G1_a2zqG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeejtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:NxMJaH22ooQpUczYahWN7QdAE_5b12dOzxUcg6OeqyL-j_kfwEuNZg>
    <xmx:NxMJaJHFu4bw0QCJZ_DeR6h6SGcXbAzZWfXWXdDT1Wna2RhnxM34CQ>
    <xmx:NxMJaA8BBnKBIHIcD1-CtdEDxFMoOSURgWPciItXRCUwNaT1JOC3JQ>
    <xmx:NxMJaOl-81-bzVa2ymf1to-lsSt3ffSZ-hRLOZ9xYRxdDziQDA6Bxw>
    <xmx:NxMJaLY0wSEN6BUnIDOhAh9aYgXkYvGCoqApGR3TXiIN1ZpUMQZr4GCo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Apr 2025 12:20:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 3/6] mingw: do not use nedmalloc on Windows/ARM64
In-Reply-To: <6c2e17eca68b143eff7b33d195bc66a486471547.1745395308.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Wed, 23 Apr 2025
	08:01:45 +0000")
References: <pull.1904.git.1745239150.gitgitgadget@gmail.com>
	<pull.1904.v2.git.1745395308.gitgitgadget@gmail.com>
	<6c2e17eca68b143eff7b33d195bc66a486471547.1745395308.git.gitgitgadget@gmail.com>
Date: Wed, 23 Apr 2025 09:20:05 -0700
Message-ID: <xmqqy0vqzw7e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> -	USE_NED_ALLOCATOR = YesPlease
> +	ifneq (CLANGARM64,$(MSYSTEM))
> +		USE_NED_ALLOCATOR = YesPlease
> +	endif
>          ifeq (/mingw64,$(subst 32,64,$(prefix)))

Notice the funny indentation above?  It turns out that the one in
the context that looks funnily indented uses the "correct"
indentation, which is quite counter-intuitive and confusing X-<.

I forgot about the rule while reviewing the previous round, but we
had to prepare for newer GNU make with commits like c18400c6
(Makefile(s): avoid recipe prefix in conditional statements,
2024-04-08).  In short, the conditionals like ifn?eq, ifn?def, else,
endif should not be indented with HT and we instead want them to be
indented with SP.

    $ git diff master... config.mak.uname |
      grep -E -e '^[+]       +(ifn?eq|ifn?def|else|endif)'

found them in a few patches in the series that touch
config.mak.uname

    msvc: do handle builds on Windows/ARM64
    mingw: do not use nedmalloc on Windows/ARM64

Fix-up for "mingw: do not use nedmalloc on Windows/ARM64"

 config.mak.uname | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git c/config.mak.uname w/config.mak.uname
index 6222d2c5a4..3ec82d95e6 100644
--- c/config.mak.uname
+++ w/config.mak.uname
@@ -742,9 +742,9 @@ ifeq ($(uname_S),MINGW)
 	HAVE_LIBCHARSET_H = YesPlease
 	USE_GETTEXT_SCHEME = fallthrough
 	USE_LIBPCRE = YesPlease
-	ifneq (CLANGARM64,$(MSYSTEM))
+        ifneq (CLANGARM64,$(MSYSTEM))
 		USE_NED_ALLOCATOR = YesPlease
-	endif
+        endif
         ifeq (/mingw64,$(subst 32,64,$(prefix)))
 		# Move system config into top-level /etc/
 		ETC_GITCONFIG = ../etc/gitconfig


Fix-up for "msvc: do handle builds on Windows/ARM64"
    
 config.mak.uname | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git c/config.mak.uname w/config.mak.uname
index 4831e9ccf6..4ef453ebcd 100644
--- c/config.mak.uname
+++ w/config.mak.uname
@@ -432,11 +432,11 @@ ifeq ($(uname_S),Windows)
         ifeq (MINGW32,$(MSYSTEM))
 		prefix = /mingw32
         else
-		ifeq (CLANGARM64,$(MSYSTEM))
+                ifeq (CLANGARM64,$(MSYSTEM))
 			prefix = /clangarm64
-		else
+                else
 			prefix = /mingw64
-		endif
+                endif
         endif
 	# Prepend MSVC 64-bit tool-chain to PATH.
 	#

Taken as a whole, here is a range-diff of what I will queue based on
this iteration.

Thanks.

1:  da1408a34e ! 1:  734bf24007 mingw: do not use nedmalloc on Windows/ARM64
    @@ Commit message
         there is also no hope that any fixes will materialize there.
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    [jc: adjust config.mak.uname for c18400c6]
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## config.mak.uname ##
    @@ config.mak.uname: ifeq ($(uname_S),MINGW)
      	USE_GETTEXT_SCHEME = fallthrough
      	USE_LIBPCRE = YesPlease
     -	USE_NED_ALLOCATOR = YesPlease
    -+	ifneq (CLANGARM64,$(MSYSTEM))
    ++        ifneq (CLANGARM64,$(MSYSTEM))
     +		USE_NED_ALLOCATOR = YesPlease
    -+	endif
    ++        endif
              ifeq (/mingw64,$(subst 32,64,$(prefix)))
      		# Move system config into top-level /etc/
      		ETC_GITCONFIG = ../etc/gitconfig
2:  e27caa3dca ! 2:  8945fba590 msvc: do handle builds on Windows/ARM64
    @@ Commit message
         is time to do the same in the MS Visual C part.
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    [jc: adjust config.mak.uname for c18400c6]
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## config.mak.uname ##
    @@ config.mak.uname: ifeq ($(uname_S),Windows)
      		prefix = /mingw32
              else
     -		prefix = /mingw64
    -+		ifeq (CLANGARM64,$(MSYSTEM))
    ++                ifeq (CLANGARM64,$(MSYSTEM))
     +			prefix = /clangarm64
    -+		else
    ++                else
     +			prefix = /mingw64
    -+		endif
    ++                endif
              endif
      	# Prepend MSVC 64-bit tool-chain to PATH.
      	#
3:  f1f6c1f2fa ! 3:  619950d421 mingw(arm64): do move the `/etc/git*` location
    @@ config.mak.uname: ifeq ($(uname_S),Windows)
      	ETC_GITCONFIG = ../etc/gitconfig
      	ETC_GITATTRIBUTES = ../etc/gitattributes
     @@ config.mak.uname: ifeq ($(uname_S),MINGW)
    - 	ifneq (CLANGARM64,$(MSYSTEM))
    +         ifneq (CLANGARM64,$(MSYSTEM))
      		USE_NED_ALLOCATOR = YesPlease
    - 	endif
    +         endif
     -        ifeq (/mingw64,$(subst 32,64,$(prefix)))
     +        ifeq (/mingw64,$(subst 32,64,$(subst clangarm,mingw,$(prefix))))
      		# Move system config into top-level /etc/
4:  687bd4ea96 = 4:  436a42215e max_tree_depth: lower it for clangarm64 on Windows
