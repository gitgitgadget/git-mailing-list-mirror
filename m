Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD6E366DA1
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 23:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753706; cv=none; b=mP08Os7/Hb9f39Y20qPyzvgH+qXyWQA65XRXCa8KtJUgTjhIIVSXryUN9s6s7DYNrlh8eN1tl7+4Oph7PhSrldcAQ7riIy0MyA0tbOT7zrHUOgEvaI9eX6u/TwgZ6n4ATKJKCyyBlm1a+/q0TdJY3ZUzJa/oq0CJpX+tyofynZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753706; c=relaxed/simple;
	bh=ofptEC+roE0ZY+rl2Q7VFF9Q34MuEuWHdoyDdrkVgt0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4DmkNTcxwvhSDsnB8+xN4GDlMSVrUem00IGFvqJiAVkOBKT3LrJVsrWnS66i9UJVz7maiITP9pxMo7/ZxxI4QvBeq9NNPurNh4t97VlQsmmOY1QHtzXS9XnIzHjIdtq1vZFqd1veNm13QL7jxMDoeUqvVM8DKL+vMQK+4TRxC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VDdlf6an; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G9eAdJeA; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VDdlf6an";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G9eAdJeA"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D7F5EC057A;
	Thu,  5 Mar 2026 18:35:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 05 Mar 2026 18:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1772753704; x=
	1772840104; bh=zmozIjLDl2ul6KH/B3WxfMC/mc6FH23k1wfiK283XRA=; b=V
	Ddlf6an/Hudm6x+Gv1sKSSYwMC2e7DO9TVURNJCWJitKAFQmIXBAPmzH6ixexwqk
	BIXsQpRKBbhqmXYiiTHKSuNNIWxHarLOVnGHgh4TYA7KhOz8h5K3KOHOK9hlF9M6
	FaSeFtu18GC1hYVz64+zza4PkH8G0HRv8WfKydoNZzIluQIrl2SXPz7NeywfkT14
	fg5UHwZvnglPmk2Cb/N2u4+iBqsaentuRc0NpFOiakz3MQT6LRJnQvzmtSw3Eiut
	9bpSjGYzOBydPc9m/04LKNINTvJGcEa2CiBgSnSpF91l8eXearJiDX43+qRKaYLI
	2JWCTQS8eTca6jiI6ssFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1772753704; x=1772840104; bh=zmozIjLDl2ul6KH/B3WxfMC/mc6F
	H23k1wfiK283XRA=; b=G9eAdJeAddBLsgV4rslCap4klqBP6X+2dsVbEuoogeX2
	CURwQjnNu4s5ENOjx5IPkji5GlVYZ1z/8lM2FcxInodi98cByIgMLvzwgxgjpZxs
	kuS7GNBIdaE+fT2KNoymwAMPBwXKyK2siSj/6iL5NJb//NKHhVyqZeNyvnNRuel5
	n+RftlcqFCWEsgAm4MoegiOM+eccRPP9SDf5qgJZ2YZUwZxSkqS2/zOAfBXgN5zH
	h5HA2ikfAFauC/P6S9IDiJLMYDXE3dvThlmPoF96u9YcZOYa5ciKWWvxGt84CUEI
	cdnu0lMsDIxExS1NhKTfuUfAKYo+bPnxsYEdad+uLA==
X-ME-Sender: <xms:KBOqaYw0tlipyWICs7B0xxzw3304AkCOwpet_6VDtq2hw0g3qH9SIQ>
    <xme:KBOqaSTHbSrFUO7q0k5wvpSfozKqYbciEdPYcfDWrkRRKWzDn3tp6BshjdOSYnUek
    4RYPbH-x80yboa8acQ-nGICXmjn3O34YCSoS8ZxOwLFTPvrZb_v2g>
X-ME-Received: <xmr:KBOqaX8YIbMB6242inYKMLrPu0-gNG3v7ravIg_Yid5Dw_EaP671kJrndkgAtWeYcet0QN6ZsuXCt87r_tIYr-_NuPJaXfs3JQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:KBOqaRrRB-CZh127yw6wPgvqiRPFyrxVbh8nxwtYkl6zQZrLUULv9g>
    <xmx:KBOqacnh76IYSu_uRqljYrgIbv9ZxJ3cMEot_dtjMSRKB_i0PPe-2Q>
    <xmx:KBOqaQKk4fW3FAfHLRvEX7-mMt_b7qxUCeAUOHiY24NSPp0PyMgXew>
    <xmx:KBOqaZxT2TO-ZNvAjOZ_a6gP6aJ5dhU7LlZ_4_D7YsgrBHebhFRljQ>
    <xmx:KBOqac0k5cY5PXRYNfFFAuj90e2bVNpABM9qprihJAJF4xXIrp5L3wAp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 18:35:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v5 6/7] sideband: drop 'default' configuration
Date: Thu,  5 Mar 2026 15:34:51 -0800
Message-ID: <20260305233452.3727126-7-gitster@pobox.com>
X-Mailer: git-send-email 2.53.0-629-g0c401728ca
In-Reply-To: <20260305233452.3727126-1-gitster@pobox.com>
References: <pull.1853.v4.git.1770113882.gitgitgadget@gmail.com>
 <20260305233452.3727126-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The topic so far allows users to tweak the configuration variable
sideband.allowControlCharacters to override the hardcoded default,
but among which there is the value called 'default'.  The plan [*]
of the series is to loosen the setting by a later commit in the
series and schedule it to tighten at the Git 3.0 boundary for end
users, at which point, the meaning of this 'default' value will
change.

Which is a dubious design.

A user expresses their preference by setting configuration variable
in order to guard against sudden change brought in by changes to the
hardcoded default behaviour, and letting them set it to 'default'
that will change at the Git 3.0 boundary defeats its purpose.  If a
user wants to say "I am easy and can go with whatever hardcoded
default Git implementors choose for me", they simply leave the
configuration variable unspecified.

Let's remove it from the state before Git 3.0 so that those users
who set it to 'default' will not see the behaviour changed under
their feet all of sudden.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/sideband.adoc | 1 -
 sideband.c                         | 6 ++----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/sideband.adoc b/Documentation/config/sideband.adoc
index 32088bbf2f..96fade7f5f 100644
--- a/Documentation/config/sideband.adoc
+++ b/Documentation/config/sideband.adoc
@@ -6,7 +6,6 @@ sideband.allowControlCharacters::
 	a comma-separated list of the following keywords):
 +
 --
-	`default`::
 	`color`::
 		Allow ANSI color sequences, line feeds and horizontal tabs,
 		but mask all other control characters. This is the default.
diff --git a/sideband.c b/sideband.c
index a90db9e288..04282a568e 100644
--- a/sideband.c
+++ b/sideband.c
@@ -33,8 +33,8 @@ static enum {
 	ALLOW_ANSI_COLOR_SEQUENCES    = 1<<0,
 	ALLOW_ANSI_CURSOR_MOVEMENTS   = 1<<1,
 	ALLOW_ANSI_ERASE              = 1<<2,
-	ALLOW_DEFAULT_ANSI_SEQUENCES  = ALLOW_ANSI_COLOR_SEQUENCES,
 	ALLOW_ALL_CONTROL_CHARACTERS  = 1<<3,
+	ALLOW_DEFAULT_ANSI_SEQUENCES  = ALLOW_ANSI_COLOR_SEQUENCES
 } allow_control_characters = ALLOW_CONTROL_SEQUENCES_UNSET;
 
 static inline int skip_prefix_in_csv(const char *value, const char *prefix,
@@ -62,9 +62,7 @@ int sideband_allow_control_characters_config(const char *var, const char *value)
 
 	allow_control_characters = ALLOW_NO_CONTROL_CHARACTERS;
 	while (*value) {
-		if (skip_prefix_in_csv(value, "default", &value))
-			allow_control_characters |= ALLOW_DEFAULT_ANSI_SEQUENCES;
-		else if (skip_prefix_in_csv(value, "color", &value))
+		if (skip_prefix_in_csv(value, "color", &value))
 			allow_control_characters |= ALLOW_ANSI_COLOR_SEQUENCES;
 		else if (skip_prefix_in_csv(value, "cursor", &value))
 			allow_control_characters |= ALLOW_ANSI_CURSOR_MOVEMENTS;
-- 
2.53.0-629-gb58d2f6a3e

