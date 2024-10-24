Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAD51D5149
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773653; cv=none; b=szjQgZpmL3ec0dUh7fO27e1FvcUCozcFrN1qVwiztjcf4bcSkEkCwFoEI/+5M9DVVRYUofATvgQF3dke/c8a1voRt/dfrHq2EvdvaigD89mGObRmxbf4ihImSHKp+WvXQKb6sTQu6UY3g2Nl4vv3ztRTWqW7lhcyxtH2BJYO5VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773653; c=relaxed/simple;
	bh=eJsEFyDVZouXQv/l7UYSqZgVSYuIfXyFOfbinWSNaMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WV2pfkV8AO9yrrXgWi0i10tfmRRIJgcSVIQxtDK42iRYREmjjDSGwKRPbrVnLln4JqDzckYDcpSw8voXXonB16Ao5CJCIX5kuVgbd+YcMKvOly17ZHomPnYnob4K/EACWVgA6cmIzHEPsMPPH4ffdkxfqUDMf99Ozbq0ozfzBwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wdFFJcye; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DCtTGp4J; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wdFFJcye";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DCtTGp4J"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 17146254014F;
	Thu, 24 Oct 2024 08:40:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 24 Oct 2024 08:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729773650; x=1729860050; bh=/hefA1R70C
	iZnSDbZ589F9ViaqeKJvzJDSmQM56U4W8=; b=wdFFJcyez5DQgq/117x9JWfXM0
	TZjH6yGjrf1gyEjWWiKHxgovnT3MHGukholpgsgyWAhQ+VDx51NbJQFKwMqhT3eH
	JBxgzOXJcNXIlcY2BB1tT+GE81akoAhXWiZBYdG3XEXIhTItA5Lp6JY3hWjAK+uc
	Ba33T/CdShcAueX7JfnkgPZFtpDCx6YIbJYFnqDFdzlfsw/dpaoleWBnIcgGAmj3
	SBAuTCDP/RhjEPoT4VpyMjgPM/WX4hCFR0QiiHVmTQ3d6wRlvZOsYqdTjnHQk4Ev
	spZvN594bCybDMC4WDPqwPcnUUKpy+mGcyB+GgcDAcVsmt9U0o2g8tdLEtFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729773650; x=1729860050; bh=/hefA1R70CiZnSDbZ589F9ViaqeK
	JvzJDSmQM56U4W8=; b=DCtTGp4Jk0saNPqCcl2AeNN5sCtJCwVoHKTXCDfRPLKt
	FdoZFFVqwv8SVhcBjQ2CiLT23lUaVDRfVGrgsrc+kIyPYa0efQgn4yAaGd3iyXpz
	N/zpUSbOQ7oAJqEh291hEpX1Ogj7k1cFbHcNGkSidRcuWen+j/Aj71kt646FyYHp
	SSYO0kJCERTzz4Y4ejhhIIwo2Xlm2StNUrDdOav867iW4Qa/4SsOz5c7kMGH6xRj
	2frFZuU2jO0Tc2uIJl1mxYWIif1+n+5Bz2xeEnQA/U4GyOnWaPrWrZItSzkNTMQq
	AZEwolEqCA1lCLr6ynhyFnEU0nnsGbiSO8aTfQdp5Q==
X-ME-Sender: <xms:UkAaZ0eM_iYAZTOrHI1LPfM5YCc1y6EqQWyDLTlEviM3FhmY3QKIWg>
    <xme:UkAaZ2Og03dZZ7mOm67slNH7GGR9987oBB5sA3QvQuAP5eX1O01b7IKyxxYnfJdN7
    X_YUuQwnh51x49qiQ>
X-ME-Received: <xmr:UkAaZ1iU2NMTgwrya4K5B2TqoTZmiKNUnwlprDv0H8JQCXwTTsP4IbXoPtprEcqRtNaW1Rv2reMV0QMUHV3RSfS5ukOhQfFWUkfyC0W4pUqzE9aX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnheptdfhieetveekgeegkeelieffhedvfeeigefgvefhtdfh
    gffhledtlefgtdeijeehnecuffhomhgrihhnpehhthhtphdrshhhnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgs
    pghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgt
    ohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepvghstghhfigr
    rhhtiiesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:UkAaZ5-lgR40KDYbrdQaCDwYKcyJkzVz10KU9CBKwDdAfYUQw0bQkQ>
    <xmx:UkAaZwsj2ETXNk1ySC2Vq3WFA0G105cIvXKfIzDaptolL3FzF-b2Gw>
    <xmx:UkAaZwFqjdgHrvqgMs_1d1yyC9J75QPJHof7iU3XRZwsT1NNkb5yqg>
    <xmx:UkAaZ_OZ_EqtZURBxa9K7oswbS8aqfO9N9kl9tAnsetfPpPA-gOR1Q>
    <xmx:UkAaZ18JQtNcnrefqBO502uwD8CZaKn2dyfhqnGF2_0H2g-WeN7yEath>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 08:40:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 19ca7b86 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Oct 2024 12:40:52 +0000 (UTC)
Date: Thu, 24 Oct 2024 14:40:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [RFC PATCH v4 19/19] meson: fix conflicts with in-flight topics
Message-ID: <45e2ab4044a6c437a01c719d7f85ec9de083bb4d.1729771605.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729771605.git.ps@pks.im>

As support for Meson is still in-flight we have to accommodate for
conflicts with topics in "seen". The following conflicts are being
addressed in this commit:

  - ej/cat-file-remote-object-info adds t1017.

  - cc/promisor-remote-capability adds t5710.

  - ds/path-walk adds t6601 as well as "path-walk.c" and
    "test-path-walk.c".

  - am/git-blame-ignore-revs-by-default adds t8015 and t8016.

  - ps/reftable-detach adds "reftable/system.c".

  - js/libgit-rust adds "common-exit.c" and "common-init.c".

This is somewhat painful in the current state where Meson is not yet
part of the main tree, but we'll have to live with that for the time
being.

I've split this commit out into a separate fixup-style commit such that
it is possible to test this topic both with and without "seen" merged
into it. You can simply revert this commit to test without "seen".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build          | 4 ++++
 t/helper/meson.build | 1 +
 t/meson.build        | 5 +++++
 3 files changed, 10 insertions(+)

diff --git a/meson.build b/meson.build
index 86d9a5c9f94..d1b97443b8f 100644
--- a/meson.build
+++ b/meson.build
@@ -65,6 +65,8 @@ libgit_sources = [
   'commit-graph.c',
   'commit-reach.c',
   'commit.c',
+  'common-exit.c',
+  'common-init.c',
   'compat/nonblock.c',
   'compat/obstack.c',
   'compat/terminal.c',
@@ -177,6 +179,7 @@ libgit_sources = [
   'parse-options.c',
   'patch-delta.c',
   'patch-ids.c',
+  'path-walk.c',
   'path.c',
   'pathspec.c',
   'pkt-line.c',
@@ -217,6 +220,7 @@ libgit_sources = [
   'reftable/reader.c',
   'reftable/record.c',
   'reftable/stack.c',
+  'reftable/system.c',
   'reftable/tree.c',
   'reftable/writer.c',
   'remote.c',
diff --git a/t/helper/meson.build b/t/helper/meson.build
index 5e83884246e..f502d1aaa36 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -40,6 +40,7 @@ test_tool_sources = [
   'test-parse-pathspec-file.c',
   'test-partial-clone.c',
   'test-path-utils.c',
+  'test-path-walk.c',
   'test-pcre2-config.c',
   'test-pkt-line.c',
   'test-proc-receive.c',
diff --git a/t/meson.build b/t/meson.build
index 48efe51fbe6..dfe7c3b8064 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -167,6 +167,7 @@ integration_tests = [
   't1014-read-tree-confusing.sh',
   't1015-read-index-unmerged.sh',
   't1016-compatObjectFormat.sh',
+  't1017-cat-file-remote-object-info.sh',
   't1020-subdirectory.sh',
   't1021-rerere-in-workdir.sh',
   't1022-read-tree-partial-clone.sh',
@@ -718,6 +719,7 @@ integration_tests = [
   't5703-upload-pack-ref-in-want.sh',
   't5704-protocol-violations.sh',
   't5705-session-id-in-capabilities.sh',
+  't5710-promisor-remote-capability.sh',
   't5730-protocol-v2-bundle-uri-file.sh',
   't5731-protocol-v2-bundle-uri-git.sh',
   't5732-protocol-v2-bundle-uri-http.sh',
@@ -820,6 +822,7 @@ integration_tests = [
   't6500-gc.sh',
   't6501-freshen-objects.sh',
   't6600-test-reach.sh',
+  't6601-path-walk.sh',
   't6700-tree-depth.sh',
   't7001-mv.sh',
   't7002-mv-sparse-checkout.sh',
@@ -946,6 +949,8 @@ integration_tests = [
   't8012-blame-colors.sh',
   't8013-blame-ignore-revs.sh',
   't8014-blame-ignore-fuzzy.sh',
+  't8015-blame-default-ignore-revs.sh',
+  't8016-blame-override-ignore-revs.sh',
   't9001-send-email.sh',
   't9002-column.sh',
   't9003-help-autocorrect.sh',
-- 
2.47.0.118.gfd3785337b.dirty

