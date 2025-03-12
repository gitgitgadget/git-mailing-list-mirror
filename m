Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510BE245031
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785466; cv=none; b=Hu3rGlkPbNb1HYXMmi9WXIVG1pcCdcTvfNGeem5bPvOckuFDecoi6+hkPJP55SE5hp3VXSMDTqL+6tcPibGo3JG999SaNdzT8z339vE3hK/k4JsfgtnsiWN81aRHk/79BOpT/fPQuD9pYsCqI8X/UfNfbTTwjqM4zeZWdxDp5ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785466; c=relaxed/simple;
	bh=m9g05zFalXartmsWlacd1hO8SNmjhv9Ptt1heIoLSac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bV24fdcDWX/UaVXCfwpgHqzQvbxV58uWfr28BHAbE2q/k8pNJZjBBhQwkO2FLIgEVvjYiahZAWjZpqGbKhq+TtMgFfx4uGRZLZHt1ejCF6RSB5Ojxc2uOFVmKUcMZqgBYImXMDfHWm8SJnjIc3eOxZV87CViLvKLZqS1ND1JgFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SPC1kmF7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J9ntHiEi; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SPC1kmF7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J9ntHiEi"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 8BA4D1140292;
	Wed, 12 Mar 2025 09:17:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 12 Mar 2025 09:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741785462;
	 x=1741871862; bh=G/+u/EvCXzVyvj8uALmsQ8++faIKpwluY6w2PHpLt0o=; b=
	SPC1kmF7P9xEPUL1aM5rmt4/Tk0xWeVS2bDT905yQdx+Khh42OTlOe1AePCswnR7
	81Z1ay1TSoCaZ+q9A/O2swrBS8YrYLYMNM6gF2w759AV3WgilsJJUbFiy/bfiSVf
	mY6sG3YHQMl9osZyMLquGFduQ4X+1LG4fFKK9Qg9/1wgBiCoKk2LmlYIHCn2GZ1t
	lLjQU+KWRGGh9B3fppEBc6pG8yJDa/lUpIC5YVoVGSIczC9OPUgAU9H6HK8edbqf
	mwNDwe9a/zGCiCLFuylj1NGVvOdhQ5WSXddUm61UovVayUev88QuZSAGWHh/CQ1+
	nDqx5m5yhr29ikCi0iFDtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741785462; x=
	1741871862; bh=G/+u/EvCXzVyvj8uALmsQ8++faIKpwluY6w2PHpLt0o=; b=J
	9ntHiEizG2SQ8morhZj/3TxOa3L2TDY1kFXhyMtZNEumb0y5o+TByis1w428JPxt
	Se/rVEtWErta1+rIVpFt0coblVUQIOXj44PODWSrYZZDsRdBTSh//mUXHqLLDq9j
	Rwe/ju7gZGQVvm7ytW4hptPF4Q+SexHVLs4fv4LFvoSwFJcQWvv3IfzJsaaigWbl
	1UIGohefAUIHGRIemptBzHxOuPCXxZD5zGSZFaN07VWMkKJAgHLKEprkULOCq8OS
	hEpsr4UQYYi+674D8XzrvO42moiNApfdDUqP5q+6Ic22snQSbk6IeThsPSwsZKHF
	8ib10QXPrefQ6Ctji/Xlw==
X-ME-Sender: <xms:donRZ7LlHMt-iizpzSxIHu3a6jK6n4szT9_yMdbBDB6ftLOK6UGuew>
    <xme:donRZ_LUudV1fQvS84ny6hkSlMwF1ljmYifN7CIE9U4ASr-Y1iHPZZQiYhcTJWk48
    55fo0j6qQIq0II1XQ>
X-ME-Received: <xmr:donRZztv6RcQMDq1-A-xhUYeLS5fckMFmMUUKQ01fUQap73wbAnHC6smRwV5W8z7SnoErF-WiFezm3d1GYyNc66UzrFMrn9csFdw8yXCMrikNkCZOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:donRZ0bKmuFL9VJjSdb6r91t_AXfBGOGtoQfys78-cCIsbyvvunMVw>
    <xmx:donRZybIbolEMcLxJq2xLE6eEWV2RqTDrD_rsvg9SxtzirVAYioetA>
    <xmx:donRZ4D46wO4XEF3e3yMDPI3QxIaKmPuSbDB-Cu-9hBtzrAPROQEwg>
    <xmx:donRZwZgWTVOFC688p6MKus2DOE8YHuQm9ErRzCYkR10caNGfRZRdQ>
    <xmx:donRZ5Wp-FKyF1IfnNaeeHJgxeoteTaY9ukQqxwcfZfe2n9UpNHfw0T7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 09:17:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a5892bdd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 13:17:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 12 Mar 2025 14:17:33 +0100
Subject: [PATCH 2/3] meson: don't compile git-pack-redundant(1) with
 breaking changes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-pks-meson-breaking-changes-v1-2-b89e9a59d228@pks.im>
References: <20250312-b4-pks-meson-breaking-changes-v1-0-b89e9a59d228@pks.im>
In-Reply-To: <20250312-b4-pks-meson-breaking-changes-v1-0-b89e9a59d228@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

We continue to compile the git-pack-redundant(1) builtin with Meson when
breaking changes are enabled even though we ultimately don't expose this
command at all. This is mostly harmless, but given that the intent of
the build option is to be as close as possible to the state where the
breaking change has been fully implemented this isn't optimal either.

Improve the situation by not compiling the builtin when breaking changes
are enabled.

Based-on-patch-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 4ddc44f510d..6b0eb6430af 100644
--- a/meson.build
+++ b/meson.build
@@ -581,7 +581,6 @@ builtin_sources = [
   'builtin/name-rev.c',
   'builtin/notes.c',
   'builtin/pack-objects.c',
-  'builtin/pack-redundant.c',
   'builtin/pack-refs.c',
   'builtin/patch-id.c',
   'builtin/prune-packed.c',
@@ -632,6 +631,10 @@ builtin_sources = [
   'builtin/write-tree.c',
 ]
 
+if not get_option('breaking_changes')
+  builtin_sources += 'builtin/pack-redundant.c'
+endif
+
 builtin_sources += custom_target(
   output: 'config-list.h',
   command: [

-- 
2.49.0.rc2.394.gf6994c5077.dirty

