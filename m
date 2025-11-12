Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9E22EB875
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 22:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762985003; cv=none; b=Svz81Ke2rffNrnU0KR+v28rx4dcQDM2lWZYIB4U4q9SiSa2X25bzrywhzKqqK1XT7X3yfaE3mIE1X3leKlEQDsShjC/6Nzvc+ncc/bdVX4Bu2C6FPSZm6dQR14vaxqLvukZ9j+rSt80rijNfWuyBoEkl7fB7OlbfSHNvUQTwqYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762985003; c=relaxed/simple;
	bh=aSwGGwYIW2uwqgq3PKIH2S/Iyv6PADLhSqsGJ5KFves=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5Pymeq0WRP6LZUMbLlKts4dZBVpI1VriWxmmergnA7V5W0Gwqv7kHJDXBQjvlq06Xd+Ru1MVyVVrQLw6jkWARa3iy1SFWyqUCURdAKNHPobbuG9qkfe2FB+YBFHuM2MW+1A4yJB72pJ3ZzEgqVoEJ9DVaQLvlctfrQnZGSEStM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ainO6yPd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CcgDunEm; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ainO6yPd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CcgDunEm"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2BD177A0026;
	Wed, 12 Nov 2025 17:03:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 12 Nov 2025 17:03:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762985001; x=
	1763071401; bh=OftAP5iWTqYtRWG9xF5hkAfALPaWq8hMBBtLU+XfHE8=; b=a
	inO6yPd+PH/eqk/yBSHX4qflSmLT+y5AwRLaKRkwZLFh1SNG8IAwjbBgaXGQMurW
	kgaYyk3ynTZnBdS0adgOG0Oo0aFKzuwMWmt/unmHkwp6/gUTazdwG3r07H7Jx54r
	E5y5A+VawrcmZxkRXPAtmjCghO4XxqSFLdAhWRaALnAHK/N8wMRlVSYCBHMVR+dz
	rgqueZRjs1/iXmPp0nCVEQUM/vALgdJ5JnEAGFlxZHai/E7SRL7jWUd1HwR1cExD
	/UGMGhgUQUk2Jzq2ePIbHVEs0HRHppqnfJbiLQasRQZilAQbG02Ykdx7pCKQ2i40
	9pyANDyuQUu31J1wyTlCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762985001; x=1763071401; bh=OftAP5iWTqYtRWG9xF5hkAfALPaW
	q8hMBBtLU+XfHE8=; b=CcgDunEm0WxUK73wxBXlWa3lTbRXLDZIEPUrqETrPZ56
	I+OklQiwR4+GQNY8tfFFhEDx+JFx5oZMyi2QysUtgIHB1g1XZOK98VEoprSKmVnF
	wqA2mIdnVrUCgqUTruF+ESFJPeEOyOuuEodgWD1/rEobxgvC3fsc/F2479CXh3ws
	n/KeMM5OsOXdsBeWPfm/vBUBBz/JHPcXdG6mIlqX4AD+4R2aVwJ0OY0lTMgxryiw
	Ui18rRYbZXK61a/cXne/dH3ysOsGv9IzxXGl1x76DKAZj5DUaGHEW5uFlKATNxmx
	JBLeZVvjIoeYnIu5q4Mfjs3RZURhRoan/DyfIUMWOQ==
X-ME-Sender: <xms:KAQVaW-v2nDwkV8zRU9i5-9W6kacU64tAPLbuh8tsproFxSUe88D7g>
    <xme:KAQVacsLolulq2OKZrnPZLYVAzNuhOziTR4Z5nriVoxQ-96IXP74JtAoNRyuAnDXn
    gZsRNnuPoAQYnGxSepqcz7H1MW6CZaVLieA5qSpBFSx84tL1KqnSA>
X-ME-Received: <xmr:KAQVaZpdBLjSOwEKzuY2R7yyxyqidZLPWMX5AVl1gkOxaFV1G4g7QVBdtudDt9pbVZm_QHZOqloBNrmFCqPY2wJX6Aneet_bqNKb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepheenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:KAQVaZl_xkMe2WehGydpVMF6LKjCKQDNTi4HrCh2wqYQ_sXAYtIZqQ>
    <xmx:KAQVadxH-mqSWzLuUA1zPijrN9QhN0K8QvXwDr43_YgF1EayecbyPw>
    <xmx:KAQVaRksiA2QOUXRnAAxPqanyLNLsZQYv_fAeKlyIqV-B9pheMBZGQ>
    <xmx:KAQVaWfvOUuBzdNLuE9gCnrmLqTFuc-A231aMvy3SmhT7bJruFsRuQ>
    <xmx:KQQVaSUh_5l0FCOgaams_Al0B4Dkh7p2wwMmwH9HBfxsHdHt8yPty1cS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 17:03:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 12/12] attr: enable incomplete-line whitespace error for this project
Date: Wed, 12 Nov 2025 14:02:58 -0800
Message-ID: <20251112220258.1009253-13-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc2-441-g030905368a
In-Reply-To: <20251112220258.1009253-1-gitster@pobox.com>
References: <20251111000451.2243195-1-gitster@pobox.com>
 <20251112220258.1009253-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now "git diff --check" and "git apply --whitespace=warn/fix" learned
incomplete line is a whitespace error, enable them for this project
to prevent patches to add new incomplete lines to our source to both
code and documentation files.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .gitattributes | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.gitattributes b/.gitattributes
index 32583149c2..673527dd67 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -1,13 +1,13 @@
 * whitespace=!indent,trail,space
-*.[ch] whitespace=indent,trail,space diff=cpp
-*.sh whitespace=indent,trail,space text eol=lf
+*.[ch] whitespace=indent,trail,space,incomplete diff=cpp
+*.sh whitespace=indent,trail,space,incomplete text eol=lf
 *.perl text eol=lf diff=perl
 *.pl text eof=lf diff=perl
 *.pm text eol=lf diff=perl
 *.py text eol=lf diff=python
 *.bat text eol=crlf
 CODE_OF_CONDUCT.md -whitespace
-/Documentation/**/*.adoc text eol=lf
+/Documentation/**/*.adoc text eol=lf whitespace=!indent,trail,space,incomplete
 /command-list.txt text eol=lf
 /GIT-VERSION-GEN text eol=lf
 /mergetools/* text eol=lf
-- 
2.52.0-rc2-441-g030905368a

