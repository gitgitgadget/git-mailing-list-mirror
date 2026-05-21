Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43F727144B
	for <git@vger.kernel.org>; Thu, 21 May 2026 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380895; cv=none; b=e8SSFAXYSpcjrIR6wZsuQlwUhAdqzotnOlZ+RlUCo4jOeeRSKz8Sg29bJtWSpqdhq/ltvdvHRz+SUUnmWJAiI8C9R80Hx3MlJu9UzCT4AkMbTMPpMGcg4FuFWRc/uKPv033Cd9fyqlsBIKknTGjpXiaIGH62UcBxtnEjcG2vVuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380895; c=relaxed/simple;
	bh=rUwDEsiI6ETlg4k/rkLYfefYUPL/RYbVA60X75GL46E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oeEJo//Z8WDNuKOA84JfHJR7qiRSdVBsZzpjgrvz20AKBUB7QMovOS+KydxaHdV208UkdyackKBlGGxyjLWB2GPH/alAcstJj9CKVPfwW+v1cA4AZzSEGfRk5vVM2TNnLxSUmsdVoC58nVCE5FJazm91t8YsgL86dXPshNLLxZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=UYV3CKs8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YnJrduJK; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="UYV3CKs8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YnJrduJK"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3016F7A00E8;
	Thu, 21 May 2026 12:28:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 21 May 2026 12:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779380893;
	 x=1779467293; bh=jfiSdE3V188m3PKOxx8sxdbM5l9ZZ62r6ejS8EYNEac=; b=
	UYV3CKs8J6okAZ6aJj4m2vd/693JJ4vF/ZyVmZKgf3TlIwVsd21b10m1X9ADnT8A
	RHYKUdUk1leI9V+sO3I33SyoDrVtqbMHV2EGOD8tAkkNixQ/JSr5jy37SPzBzczZ
	syaCxBJY6jRHLjhsPc3AwWKEiACdaiJ66FgiliZ/k5zKXIESqVfX7j65A591U5xH
	KLEqcf91aAswh/WYe515GiBfCLYjpIyIuNwCMR5Z+H66R7QtY8abO8eT3be2Urw0
	hYgjEDfBLOHk9/8igWUsGppMDabxdDukeAeEz6+njArs+dWHiiXdq0cMwkChzZNw
	zO8nPrb3EY6b4TsdDMsWWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779380893; x=
	1779467293; bh=jfiSdE3V188m3PKOxx8sxdbM5l9ZZ62r6ejS8EYNEac=; b=Y
	nJrduJK4gaCarFztO29TN3q+vYwPODA4a50ueFmSOHNgvlehCMK5SPW9z2vVW/Pa
	mswVLDR7377q16x/2zWqDZTauog18+Yt1+XU7f/JE9pwb/xq6on5iuUIy/avywUz
	8XojCgtl2hemLQg6tFHCa5xRCbNbd3StJiMpjhp+QLUO4Rg8CE41qqrm0teerg0f
	GK0U7JUT3TKRDaWm8J9ZK5OgH7M1CoPCLlDt85k+NMO7iVgeXT9G0QLePtRuSkDI
	cBSGIOztyUPw+pnqmVpnCs1mXZDT75TFjkhWv82r1aWfBVr0KAQvS3EWvmF54lNA
	0CV03PS6nGJYHjoT2UoBw==
X-ME-Sender: <xms:nDIPavgqapaoUugT69u37ded1Y_xmFOgshMgDjm688swQzC2aVJKerQ>
    <xme:nDIPajDcnX1sqHDVFP0m40rdnvCg5bkgSY8khqeFB3mqSTW_0KNu7GPD-sl0lInrq
    g2qjxolUsMunD2DB2o6LwREulqeLqW6anQeT-hNIBZAlSMJ6qu21A>
X-ME-Received: <xmr:nDIPakHuM1pItgIIq-VIppU5paSoaDhj3c5kF3ZHViS7oNIpT3eXzsZYCK0-r1dBOCcoE-v_XifxqunwO5SwnhZoy-MfqFFGxX-WSX4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffgge
    elhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfeknecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhr
    tghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtoheprggurhhirg
    hnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhm
X-ME-Proxy: <xmx:nDIParLlNuuecPg9ZXkeMixH--2Ukw1abLvDYtRvE1JqcZQpWZZFdw>
    <xmx:nDIPaonuFkK_OpManBWa9ImLF16t6tQlYnYZhaTbwGuZwwRSdGLJnQ>
    <xmx:nDIPajT09MC3B1o5iryUQhNUng_eSL5pNi6V_BoIK14cU81khzRKww>
    <xmx:nDIPaqLFjfvfbEwjjUkVsL9Wi4G37Pgo7LATggYErcUWwY4GjjCBWw>
    <xmx:nTIPavWmKR71RTiKKgkUjqUX3jZFC7AJclHTr85Pw4IUuR0b4ft_MbVK>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 12:28:11 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	jn.avila@free.fr,
	adrian.ratiu@collabora.com
Subject: [PATCH 4/4] =?UTF-8?q?doc:=20hook:=20don=E2=80=99t=20self-link=20?= =?UTF-8?q?via=20config=20include?=
Date: Thu, 21 May 2026 18:25:58 +0200
Message-ID: <doc_hook_no_self-link.6f4@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <CV_doc_hook.6f0@msgid.xyz>
References: <CV_doc_hook.6f0@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Do not link to git-hook(1) from the config options when we already are
in that doc.

This implementation is similar to the updates to git-init(1) and
git-commit(1), implemented in [1] and [2], respectively.

† 1: e7b3a768 (doc: git-init: rework config item init.templateDir,
     2024-03-10)
† 2: 819fdd6e (doc: convert git commit config to new format, 2025-01-15)

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/config/hook.adoc | 19 +++++++++++++------
 Documentation/git-hook.adoc    |  1 +
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
index a9dc0063c12..083dc60a132 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -1,10 +1,17 @@
+ifdef::git-hook[]
+:see-git-hook:
+endif::git-hook[]
+ifndef::git-hook[]
+:see-git-hook: See linkgit:git-hook[1].
+endif::git-hook[]
+
 hook.<friendly-name>.command::
 	The command to execute for `hook.<friendly-name>`. `<friendly-name>`
 	is a unique name that identifies this hook. The hook events that
 	trigger the command are configured with `hook.<friendly-name>.event`.
 	The value can be an executable path or a shell oneliner. If more than
 	one value is specified for the same `<friendly-name>`, only the last
-	value parsed is used. See linkgit:git-hook[1].
+	value parsed is used. {see-git-hook}
 
 hook.<friendly-name>.event::
 	The hook events that trigger `hook.<friendly-name>`. The value is the
@@ -14,7 +21,7 @@ hook.<friendly-name>.event::
 	This is a multi-valued key. To run `hook.<friendly-name>` on multiple
 	events, specify the key more than once. An empty value resets
 	the list of events, clearing any previously defined events for
-	`hook.<friendly-name>`. See linkgit:git-hook[1].
+	`hook.<friendly-name>`. {see-git-hook}
 +
 The `<friendly-name>` must not be the same as a known hook event name
 (e.g. do not use `hook.pre-commit.event`). Using a known event name as
@@ -27,7 +34,7 @@ hook.<friendly-name>.enabled::
 	Set to `false` to disable the hook without removing its
 	configuration. This is particularly useful when a hook is defined
 	in a system or global config file and needs to be disabled for a
-	specific repository. See linkgit:git-hook[1].
+	specific repository. {see-git-hook}
 
 hook.<friendly-name>.parallel::
 	Whether the hook `hook.<friendly-name>` may run in parallel with other hooks
@@ -37,13 +44,13 @@ hook.<friendly-name>.parallel::
 	all hooks for that event run sequentially regardless of `hook.jobs`.
 	Only configured (named) hooks need to declare this. Traditional hooks
 	found in the hooks directory do not need to, and run in parallel when
-	the effective job count is greater than 1. See linkgit:git-hook[1].
+	the effective job count is greater than 1. {see-git-hook}
 
 hook.<event>.enabled::
 	Switch to enable or disable all hooks for the `<event>` hook event.
 	When set to `false`, no hooks fire for that event, regardless of any
 	per-hook `hook.<friendly-name>.enabled` settings. Defaults to `true`.
-	See linkgit:git-hook[1].
+	{see-git-hook}
 +
 Note on naming: `<event>` must be the event name (e.g. `pre-commit`),
 not a hook friendly-name. Since using a known event name as a
@@ -60,7 +67,7 @@ hook.<event>.jobs::
 	setting has no effect unless all configured hooks for the event have
 	`hook.<friendly-name>.parallel` set to `true`. Set to `-1` to use the
 	number of available CPU cores. Must be a positive integer or `-1`;
-	zero is rejected with a warning. See linkgit:git-hook[1].
+	zero is rejected with a warning. {see-git-hook}
 +
 Note on naming: although this key resembles `hook.<friendly-name>.*`
 (a per-hook setting), `<event>` must be the event name, not a hook
diff --git a/Documentation/git-hook.adoc b/Documentation/git-hook.adoc
index 750df58e58e..4868852aa0b 100644
--- a/Documentation/git-hook.adoc
+++ b/Documentation/git-hook.adoc
@@ -204,6 +204,7 @@ unintended and unsupported ways.
 
 CONFIGURATION
 -------------
+:git-hook: 1
 include::config/hook.adoc[]
 
 SEE ALSO
-- 
2.54.0.13.g9c7419e39f8

