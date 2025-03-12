Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531192459D8
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785466; cv=none; b=Is37PqvTKZBLpLgM/W1WlabXTZdUZU76jFgqg+XC3X5yUrKnPWClwTl3TPKFri4FKNodRaeTKbD1KD5Zal8QV09jlWxzU6Q0lX33XIxVK525Xonw2jcdGUoR71JZzraE9Z+9PLcY38q3Td2XwWRMeNQJm/Ru+xa5X0ssf1DlfWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785466; c=relaxed/simple;
	bh=sa3vIU5zRaiMhBcb9OIGCV7v3PtSYM6VbT4oQkpzqys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oCj6vQCVMeh3OU/U2srK6u/QjaIa2wF/CgwteV5uCejgJg1uqhvy3B+21QPsDm8lpvSBNMWteyCL5NlLV945DZ/zFciTBj2d0TlUqcE+PVFcH6qP0vcXVkBE842a9sJWsxE5+z/PeMGmA7yU69shBylkGLGt8aj4MptbyoWU+mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=le2Igmxi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5xhcsUbJ; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="le2Igmxi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5xhcsUbJ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 62B3C254020E;
	Wed, 12 Mar 2025 09:17:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 12 Mar 2025 09:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741785463;
	 x=1741871863; bh=lTDsSOcCNpIFP/e7wqgyYZoc7tmmGsYSNOr9l8GpOaA=; b=
	le2IgmxiWGulr2M3nQJidtLGKMOafrI2erbONNrze3o/mTUNFnjeRLplaYBrfchB
	rB2sQjRpZ4M0StolSCNZluMAHbL+/WQCB47i8KhtN0XWgeRaZ0C8ElMUnkX0ktbg
	qx51qXGaxjherWhuvdrTzFMqBdP41jods5edXLTOtq1mihoDePLwgIp2J3LrTSER
	Ka8oFJ1bGM+fMszyD2OnFR6EZ4oTM2gzXvWI9KCCfstNtdtkjrCEEzhAOpFvPpxT
	SIhVl9lLeqbdoOKB/4eLIux/I3M7kV173x1KHWEdtnF8M1VB4VHueSo5dmW7rFHB
	Ld7HK3FCnzUgATnFCqWfwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741785463; x=
	1741871863; bh=lTDsSOcCNpIFP/e7wqgyYZoc7tmmGsYSNOr9l8GpOaA=; b=5
	xhcsUbJ6JojRnp+MCBD/vbg9AB2hP6yrzySIYHfrLQIC+zAYI0Qf/SR0aMNTTFC3
	ciKWRvRoEdvI83LFgFuA+z7iF6fQ3uLPLqR7Ltgn3bDCaK4fasnC/ujXzQzkDQlA
	wV+aUIQGj4uAjVM5oSijEzv1Z+ol7IN6WIJLRgFTH72/DLgnur8yEE4Mc2o1wnTc
	FKMZqjPNJ7JTLkhssAdYnSA7Zh5YIaFW9K6bf3jXFAWWGmPXXdG42Q81mYRIS4Wu
	mQWSRDmV+A+9cvl1pR3TYhGCeTDvcsvIygnc0XG/3ffAH5gznBqjFXX7qeMOshXm
	VO7mZNIOhHcVwcYCfhtUg==
X-ME-Sender: <xms:d4nRZ77v38kpuuGEyBU2dGm7K5b7uQQ4ILv3Dok0k3NFg4gStmUdwg>
    <xme:d4nRZw7k2zR-f3ItuR_pHGvt-diUy_lP3292c9Oj_TbwFJ6_XNwuOg7bYjmXitK0g
    H_-qItEU0XeeUAjcQ>
X-ME-Received: <xmr:d4nRZycGzWh58mYdzGVEuFBwJ7xWRAsJZJgaM1jpYQYdla_-Sveanc474_O1p0N5yTuwiKV44-oWZIwM06JIzIfcMmibgcNmhjHwXXiwLBz6e9awmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:d4nRZ8IUqpUU9v7_RPyoKYyg6ktkvQSp20yaRMyT9UzUw5LvlfzAfw>
    <xmx:d4nRZ_LmLCMB_mKVXzbaip0B0sCxFMyZ53mMljqw7cdLCwkSYUwqYQ>
    <xmx:d4nRZ1xdmpXgOTjhSOTPHtfcpI4PK9TAcvnNgLxsLWdn5Dt9mRAfWQ>
    <xmx:d4nRZ7L5B67780z_eRIAoEvi03IB2_OMg0wj1I6rVxhalZz8uNqZeA>
    <xmx:d4nRZ8FMyFzt4dA0IX6ng5z81xP5zOEK_JNBVIRlYPz5hN9fI8Qq9yZ2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 09:17:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 46d3ff28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 13:17:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 12 Mar 2025 14:17:34 +0100
Subject: [PATCH 3/3] meson: don't install git-pack-redundant(1) docs with
 breaking changes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-pks-meson-breaking-changes-v1-3-b89e9a59d228@pks.im>
References: <20250312-b4-pks-meson-breaking-changes-v1-0-b89e9a59d228@pks.im>
In-Reply-To: <20250312-b4-pks-meson-breaking-changes-v1-0-b89e9a59d228@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

When breaking changes are enabled we continue to install documentation
of the git-pack-redundant(1) command even though it is completely
disabled and thus inaccessible. Improve this by only installing the
documentation in case breaking changes aren't enabled.

Based-on-patch-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/Makefile    |  2 +-
 Documentation/meson.build | 13 +++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 671267a8ac7..e6b20c021fd 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -509,7 +509,7 @@ lint-docs-meson:
 	awk "/^manpages = {$$/ {flag=1 ; next } /^}$$/ { flag=0 } flag { gsub(/^  \047/, \"\"); gsub(/\047 : [157],\$$/, \"\"); print }" meson.build | \
 		grep -v -e '#' -e '^$$' | \
 		sort >tmp-meson-diff/meson.adoc && \
-	ls git*.adoc scalar.adoc | grep -v -e git-bisect-lk2009.adoc -e git-tools.adoc >tmp-meson-diff/actual.adoc && \
+	ls git*.adoc scalar.adoc | grep -v -e git-bisect-lk2009.adoc -e git-pack-redundant.adoc -e git-tools.adoc >tmp-meson-diff/actual.adoc && \
 	if ! cmp tmp-meson-diff/meson.adoc tmp-meson-diff/actual.adoc; then \
 		echo "Meson man pages differ from actual man pages:"; \
 		diff -u tmp-meson-diff/meson.adoc tmp-meson-diff/actual.adoc; \
diff --git a/Documentation/meson.build b/Documentation/meson.build
index 594546d68b1..a2de85f5aad 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -96,7 +96,6 @@ manpages = {
   'git-notes.adoc' : 1,
   'git-p4.adoc' : 1,
   'git-pack-objects.adoc' : 1,
-  'git-pack-redundant.adoc' : 1,
   'git-pack-refs.adoc' : 1,
   'git-patch-id.adoc' : 1,
   'git-prune-packed.adoc' : 1,
@@ -205,6 +204,14 @@ manpages = {
   'gitworkflows.adoc' : 7,
 }
 
+manpages_breaking_changes = {
+  'git-pack-redundant.adoc' : 1,
+}
+
+if not get_option('breaking_changes')
+  manpages += manpages_breaking_changes
+endif
+
 docs_backend = get_option('docs_backend')
 if docs_backend == 'auto'
   if find_program('asciidoc', dirs: program_path, required: false).found()
@@ -479,7 +486,9 @@ endif
 # Sanity check that we are not missing any tests present in 't/'. This check
 # only runs once at configure time and is thus best-effort, only. Furthermore,
 # it only verifies man pages for the sake of simplicity.
-configured_manpages = manpages.keys() + [ 'git-bisect-lk2009.adoc', 'git-tools.adoc' ]
+configured_manpages = manpages.keys()
+configured_manpages += manpages_breaking_changes.keys()
+configured_manpages += [ 'git-bisect-lk2009.adoc', 'git-tools.adoc' ]
 actual_manpages = run_command(shell, '-c', 'ls git*.adoc scalar.adoc',
   check: true,
   env: script_environment,

-- 
2.49.0.rc2.394.gf6994c5077.dirty

