Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACB18F6E
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 05:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754543375; cv=none; b=QvWA71scXhXFmkjgUV7qKSMf3/G7y6/zR25FSfTda78dx6yVoeDCVQT4B66CB3Tg2BCpw/3Qb+du6Xbmwu4uW6y+tT4RVOL+hzcdE1Orc/gq3MnOPyxaz9BLdNOFINmTcl9ZVn4Nl4P7vcDuM4SFQwTrRy92antd5n3cRDzXniA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754543375; c=relaxed/simple;
	bh=qJtKR3efALeeXoNEZSOG00QwRr34hiRJvFCkBYJ/UjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fqqA5y2A/uG2W5ITQdTKS3EfhOaknlY0UH+eDU3GLap7v4tBg/rLmdkWgVtUVshGAQy2yZ57tN19slaCgtAyq+FoImFGXlQTNVcnvjWqS87b8OWpxSOdenelV4j6oh+Jua21aGSfFWUMWa8NJpDkNKRP+k5gBaY7IowB/Tim4QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fYWyBxM5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O/BiVaJ/; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fYWyBxM5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O/BiVaJ/"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 751031400017
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 01:09:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 07 Aug 2025 01:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1754543371; x=1754629771; bh=kF3GD0pUYy
	WklhD0ZcRO3N19iWMex9jX0I4Sws4rx0c=; b=fYWyBxM56a9oo8EWbF+UsFLPz7
	1YOO7nz59FePznpfDms7J2WLDEko8jwcNsRCyaikck5Y0BTcaSO/2jP8HO6ud1QW
	q9ysjFJLM61V/8yrakDSaeWaL2etMVaxqJZQAgia2zFhc+uBo1BsQFqMKOy3lpci
	ddLFFZJGqohOhiEjcHj88c8juPNb7UbPcHmw/ddlc7vdx797irR9wUVHBZW/Oj6Q
	PVGMxr/ylwURv/0OtPJEqPg66qKo6VRwR4NryO2xZ6XKP1oJ5MZDH5pNbosZK0Qd
	MMiTVgefhG10h6+ihHX0K5xqCTvslhfvxGsBA9Q44xcaMfEZbfDaBUyagH7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754543371; x=1754629771; bh=kF3GD0pUYyWklhD0ZcRO3N19iWMe
	x9jX0I4Sws4rx0c=; b=O/BiVaJ/ZCXQj/Zlyp14n1QqI/XSnSzZHkcel1tIasQy
	8Ple0Nh6EgiQTtvy3j6fb/lfJJKIkDuUzTqwEfS4JURLKVFeXx9Mc66a5PcxTX/z
	EdXPvmo9Ge36nrk39Ua3zvMOPpZFWdRHDZESSUrfv8HNp68cxBkIlTMzJYOfk0JY
	Br9LSU1EKPb+vYicmRKRI+l8J+CmnldkDFnA+SS/CSFzv6S0LwfGOGvW3Ugpp2g3
	iLt0PxBr3BNl2yYW+znrn0TkAu019tog4cOerBtpIl1QhyUOuWh4U5UHkrCFyqIv
	bgdDkYkXN688ZwAQBqSl9CXXbWyVJ999zzXSt40iEA==
X-ME-Sender: <xms:CzWUaNzC_ytdzz97WOeTRSzxJA_gTSMCmmJBnDz0YotiEGJKo5Po-w>
    <xme:CzWUaPQK6msueKQXr2u-c6k4pzgXoY1yZIzPf2mzd_iPFv5FsRKLnYifU_9KI6pzE
    LzGvL3fn9Gb067aYQ>
X-ME-Received: <xmr:CzWUaAtj41Eqd7g7lCU54xoV1worx73Q5ckszHrNol_LuB5-WyZH9Lioe7m5TZS3ZNJWOEWxiLdoAxFWIihoYgiI25GUraKMdk082fRYTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddttdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepiefgiedtffffvddvueehheejheehleduudfhhe
    ekkeeggefgueffheevgeetjeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:CzWUaBsDFqKXC_NgNwl8dOKQQJq0WFeCwjYjQUKVHCxfbq24io2v6A>
    <xmx:CzWUaGyBuNIEGpGuyHdoiC23FrtSON9MDA5tTydF2xk7m_jcdedsJw>
    <xmx:CzWUaHgsZYOk3Dsh2K2edXdMjKQH-2DasLhaGeqmXa6BBYlcLWvSoA>
    <xmx:CzWUaKBeO7_IvjSzQ66P1nAersXxr3VXCice70C4gr8WNAIIuAodSA>
    <xmx:CzWUaMokBK6cO8_EoFqwhAL_HtikmbeuVpE5rOU_r54qxPVwVW0dVcXB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 7 Aug 2025 01:09:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7aa70764 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 7 Aug 2025 05:09:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 07 Aug 2025 07:09:25 +0200
Subject: [PATCH] Documentation/RelNotes/2.51.0: improve wording for a
 couple entries
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-pks-relnotes-2-51-fixes-v1-1-507fd15b28f4@pks.im>
X-B4-Tracking: v=1; b=H4sIAAQ1lGgC/x2LwQqDMBAFf0X23IUkEBR/RXpo41MXJUpWpBD89
 y7eZhimkqIIlPqmUsElKns28a+G0vLJM1hGcwouRNe5lo9VuWDL+wnlwNHzJD9DhzZg9DHF70R
 2HwVPsHl43/cfzpDgGmkAAAA=
X-Change-ID: 20250807-pks-relnotes-2-51-fixes-0e72ed15c5bf
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Improve wording and fix typos for a couple entries part of the Git 2.51
release notes.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/RelNotes/2.51.0.adoc | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/RelNotes/2.51.0.adoc b/Documentation/RelNotes/2.51.0.adoc
index f8adc2c5cf..e2cd673f43 100644
--- a/Documentation/RelNotes/2.51.0.adoc
+++ b/Documentation/RelNotes/2.51.0.adoc
@@ -97,8 +97,8 @@ Performance, Internal Implementation, Development Support etc.
  * "git push" and "git fetch" are taught to update refs in batches to
    gain performance.
 
- * Some code paths in the "git prune" used to ignore passed in
-   repository object and used the_repository singleton instance
+ * Some code paths in "git prune" used to ignore the passed-in
+   repository object and used the `the_repository` singleton instance
    instead, which has been corrected.
 
  * Update ".clang-format" and ".editorconfig" to match our style guide
@@ -139,7 +139,7 @@ Performance, Internal Implementation, Development Support etc.
  * Redefine where the multi-pack-index sits in the object subsystem,
    which recently was restructured to allow multiple backends that
    support a single object source that belongs to one repository.  A
-   midx does span mulitple "object sources".
+   MIDX does span multiple "object sources".
 
  * Reduce implicit assumption and dependence on the_repository in the
    object-file subsystem.
@@ -292,8 +292,8 @@ including security updates, are included in this release.
    and also they learn to honor the -U<n> command-line option.
    (merge 2b3ae04011 lm/add-p-context later to maint).
 
- * The case where a new submodule takes a path where used to be a
-   completely different subproject is now dealt a bit better than
+ * The case where a new submodule takes a path where there used to be a
+   completely different subproject is now dealt with a bit better than
    before.
    (merge 5ed8c5b465 kj/renamed-submodule later to maint).
 

---
base-commit: 64cbe5e2e8a7b0f92c780b210e602496bd5cad0f
change-id: 20250807-pks-relnotes-2-51-fixes-0e72ed15c5bf

