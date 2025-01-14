Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD43928EC68
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855785; cv=none; b=sI1zPSa7HJxHtA7QcOB0PikcrvTpJvt+872Mob4gqp68knIIk6j2CvnOartUk3F64QpiYn7w+OtZluUd69M0ArX/PLq9e4oldjKnR5BeAJUUkAwxnJpR7uqIfzDYgRbZb0XnXRPT5Jg+V5if3f3l5uwx/ovqancvXMqiW/6ggi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855785; c=relaxed/simple;
	bh=gSXySZCGfIUynZg8Ht3OzPKekirWtkNlLj8WG+FowHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RMy+5YQvxBsPuHK/vfbV2C5bdGveuXyjs5spEXIHvoO/FOUXeW47qp4z9+2zSqk1Ga7MVh7Ot5FH8LWYlYzMDD8wW6hvWAQV095k2W+F4oBz9fnp1xhJrb7rpJ9QKGBCQ6hPMoo7YQNqjdasPWNPCmizMx3kyjjSeKSnI+mscyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H7rSwgZR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BnVNM5SY; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H7rSwgZR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BnVNM5SY"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D5533114012E;
	Tue, 14 Jan 2025 06:56:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 14 Jan 2025 06:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736855782;
	 x=1736942182; bh=uqIbFGoX0ckU+WgLwVHZdvC+uiC4WT9vjcxZAJoo4qk=; b=
	H7rSwgZR+RRtz4ZCKdtvX7NWWm7pREXqKXMv7/0oKoV8s2eq7S3KiP7ROzG80WB0
	g916fgopY4mT+/DlMUfYMhTLW6quDRINGaZmzX+CvQ+Nyb1Vk+oRkYfpljr69fJB
	JEymERgX+JyYnYalqy6LwJklzwLAnKufBakGtcq9nLFmh8IR+Z/mXkiiHt0W51AG
	hEK0rxnkfXUNr1ZhmOswsq9Sivtqcn25ukaNy67AY6sWQmu5midmC5MqLwSwC4Xu
	tGXoqnBh5QTMXOz9gjXNufTnUsCZfVQmZ/bjx3xjN/wDj4bzYy/1BzwowmygOBR9
	w5ManxoUhgWu3n4krJjUZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736855782; x=
	1736942182; bh=uqIbFGoX0ckU+WgLwVHZdvC+uiC4WT9vjcxZAJoo4qk=; b=B
	nVNM5SYKqnE4l3GJHvMsxB/03vZjSD/nP82rc8lskNCJpF1h3wnrPtoHBJcJuOrE
	/QJzvjMsQfzherio/rRWNpqV7mqfS8VmXPCGfkIf4bH6sDLbdK0knuLC4jUvDgn3
	2Fcgh1+f9UQSqznCusGP3ChjoI+ULnErhtTPokVn2J3Me7TbBwnIUFMYxzeX2Uhh
	0bwqJPRZjw7TXom+VcpFiaAQh1BXdeK1jScG4r+21GKUN6YQSh40W6SYnN1LIaIp
	1ESuwd+dUmqixkw+4ljgX33edf/Bdxv8U4pLJ7MbcquUAxa1UL2u1ABNkcHMIrum
	H9nTzvZ3Ew9yXQdDlmlMQ==
X-ME-Sender: <xms:5lCGZ4ztC04wTk8PH1vUV2spGPwyiry2MeYX90q768fMEHvaiF6-Kg>
    <xme:5lCGZ8QIhp86LaQ1GAoaLC4AzY0weISxlTMy4nu5Tw38-Z8m8Au6k3M_CqPWhvhhw
    wWqVYBri_9Zc2GLTQ>
X-ME-Received: <xmr:5lCGZ6UrAlzwGsadejK9_VHh18WS58GOPpfKQZgr3r1LkwSPQbM-EKETmHP1AQ8ongGX0y55_XmpPDemlLTAEL8a_Dp3PASDzvTDKhF90K1ZvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhr
    thhhrdhhihgtkhhfohhrugesghhmrghilhdrtghomhdprhgtphhtthhopegvvhgrnhdrmh
    grrhhtihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgv
    nhhtohhordhorhhg
X-ME-Proxy: <xmx:5lCGZ2g_Irewp43D5Zav-yedu0nWIwhiJsXnLQeREL49gm2SNwc-VA>
    <xmx:5lCGZ6AzsJ4nYaqCWs_LS4DqJHvfRzGEfANLgQoM8dqXyA4eSFZyHA>
    <xmx:5lCGZ3JXzre_j0FyCqBhaZjqeOcEk6h9asp-C1GFpICE27wqQVGcFQ>
    <xmx:5lCGZxA5IZF7869LH-bz_MxA2B6BEs3gAysZag0305GiV9eS9_BeyQ>
    <xmx:5lCGZx4Uann3ztIw0WBlWB4nwBOY1tQciZcGYGT7oQjeH_o-NFBHBY_3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 06:56:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 74a7b537 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 11:56:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 14 Jan 2025 12:56:19 +0100
Subject: [PATCH v2 09/11] meson: fix compilation with Visual Studio
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-b4-pks-meson-additions-v2-9-8d7ec676cfd9@pks.im>
References: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
In-Reply-To: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, 
 M Hickford <mirth.hickford@gmail.com>
X-Mailer: b4 0.14.2

The Visual Studio compiler defaults to C89 unless explicitly asked to
use a different version of the C standard. We don't specify any C
standard at all though in our Meson build, and consequently compiling
Git fails:

    ...\git\git-compat-util.h(14): fatal error C1189: #error:  "Required C99 support is in a test phase.  Please see git-compat-util.h for more details."

Fix the issue by specifying the project's C standard. Funny enough,
specifying C99 does not work because apparently, `__STDC_VERSION__` is
not getting defined in that version at all. Instead, we have to specify
C11 as the project's C standard, which is also done in our CMake build
instructions.

We don't want to generally enforce C11 though, as our requiremets only
state that a C99 compiler is required. In fact, we don't even require
plain C99, but rather the GNU variant thereof.

Meson allows us to handle this case rather easily by specifying
"gnu99,c11", which will cause it to fall back to C11 in case GNU C99 is
unsupported. This feature has only been introduced with Meson 1.3.0
though, and we support 0.61.0 and newer. In case we use such an oldish
version though we fall back to requiring GNU99 unconditionally. This
means that Windows essentially requires Meson 1.3.0 and newer when using
Visual Studio, but I doubt that this is ever going to be a real problem.

Tested-by: M Hickford <mirth.hickford@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/meson.build b/meson.build
index e50ccac5c9f6d310d8c9f83d893ea802b5827252..30d7a894904dfe86bedb2a7a8de25529502403e5 100644
--- a/meson.build
+++ b/meson.build
@@ -178,6 +178,14 @@ project('git', 'c',
     capture: true,
     check: true,
   ).stdout().strip() : 'unknown',
+  default_options: [
+    # Git requires C99 with GNU extensions, which of course isn't supported by
+    # MSVC. Funny enough, C99 doesn't work with MSVC either, as it has only
+    # learned to define __STDC_VERSION__ with C11 and later. We thus require
+    # GNU C99 and fall back to C11. Meson only learned to handle the fallback
+    # with version 1.3.0, so on older versions we use GNU C99 unconditionally.
+    'c_std=' + (meson.version().version_compare('>=1.3.0') ? 'gnu99,c11' : 'gnu99'),
+  ],
 )
 
 fs = import('fs')

-- 
2.48.0.257.gd3603152ad.dirty

