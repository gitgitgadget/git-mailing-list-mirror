Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E25407560
	for <git@vger.kernel.org>; Mon, 11 May 2026 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514448; cv=none; b=aA8wgx+5Suq6MZvRwjJxwBooLrSOwa6MAFPSTPhwp3JR8JmY1xmF0DcmzwvQ72gM7zb9GQtcyZcPVL4zuRfSNL6LJXYoyb38HPBC3JJQiOtxj6Y5gN9V1w0nO7xC99R39l1in47ouuJJEYTatXH/y3c1EFGQ4ycaXEjG/URKqC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514448; c=relaxed/simple;
	bh=2gVEDcx7FzPvE2Ak1OyIADYTqSl7XD30t0NiskR5Sc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uazzLKAU4GLS43OT1YtBrHuPcucdCUzq25+CisO/m8eIIpitRQs0S3u2YZWKSWpLRMK5ro2b4C0pMMb2FpA9rlU3z69SBJgOoR9pqfedO45ykQzspKsfMnHxJwh8pFIdxQcUiVnupj6/pvIoOLF1oa9wAvhuN4XJb/78nZxW6ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=O7SURnyy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LU+V7WHd; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="O7SURnyy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LU+V7WHd"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B5EA2140010D;
	Mon, 11 May 2026 11:47:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 11 May 2026 11:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778514444;
	 x=1778600844; bh=d9j6OUvygxvmWr/ltxSEHwuKG+yTtu/Wo+VC9O9Ccow=; b=
	O7SURnyypcxS44tuonbNWxUzPA5Yd8cxFkvinvto3w7yBfKva9MkxD5zkazf8wdU
	bWTrmgYx8iiAWVBCEehHgSQczdzb3IspINiZBNqSB8ctxohlA/fXmQDMGMqx6p8/
	nxsr4g+be29iPRtQG5Ivvf3isIHGwab4ljC/tMuyxdqs8RWFxIh18srJCOMRJjBT
	o7icfTe9/uMNZOiUdyhUgWHbM3UR3KNUUXVKWBYYrhBim36PzZQRFJXv1TM06teY
	6VPbMOEqe71lY0PBvGugqb1QgIbY7ZF6V0H/VxxFMmFxnjQF/P1l4K4k38QYteVu
	EHoJ980xQcESr6roCK42sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778514444; x=
	1778600844; bh=d9j6OUvygxvmWr/ltxSEHwuKG+yTtu/Wo+VC9O9Ccow=; b=L
	U+V7WHdOR/aq/VniwfDxNb75YbrLCimU0mXoeAdvAYF4yk6vY6rDqJ9/+/lzmX/e
	9lp/W68qhfBiSn4pk8Q4X2e6nn6pbiofqGVCynaNrsa4VOJEzWhkInEqolHCgQJN
	uq5IskruzhMTyp3R+cB/QDoUyeGOs1YefiCTkVzhHy1y6xak+3h9pmXSM3AJ8scJ
	dSGukvbOf+vnIoSvDyB4ttdHb0F0Rc0KURh2ky9NFMbWkjz8OHJbVIj2wV7KBlDL
	+Ye2g3QOIbAwqQdhg/JpltkxYRYmm1RYbhLRXECh3Chj9WMOnNae0c05EEkJnAPH
	nlxwWjVGieim754upQvXg==
X-ME-Sender: <xms:DPoBarxAed8BwyKeyjvAzjWSpkVl-EN_RuJJbSYCohu1TJj9EPifcnk>
    <xme:DPoBaqruIdr97-Y4upomFPvN7239iM_VDkSh_tYlAdENFLdmd5-A0TrdpYpyk27tp
    QIGQA11DabfRY2AS0B9-T4PrX0p9gY23aOWfIeT4cNaaIAj3p1jOTc>
X-ME-Received: <xmr:DPoBaq5eZcwMcXoqpdzFN8JR4u8-rPdVVrDUCrbJzhn6MUjcX-RX84YyaAZfdYBKwxSxPJKG17mB-3OiofjZav5gj8Eb5uBzcrGWBaE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudelfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfejkefgteelteejhfetieehgeef
    tdduudffgeejhfektedugefghfeknecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtgho
    mhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
    dprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhm
X-ME-Proxy: <xmx:DPoBaheA5TGFJ6B6wlGsOIn443kRJajOs1V-7Jo-O4u3S_nxezeFUw>
    <xmx:DPoBav6hrwXb0FoXshArU7nOMw9N7hFnswsBzV51okuzcUJ3Yd6P9Q>
    <xmx:DPoBaosBLxkn7JFD3Q1gpEgkw79-81e-ARkgmIgDFPSVcxbCLfShTQ>
    <xmx:DPoBavjp1zyHl5zm1QaiPNfiONt4vo5Fg1MgDf6Coa14nPeHM4qtjw>
    <xmx:DPoBapLn_D5lFkwkF3DN60_0cPTzQbK0NpAh4YaGm1wcvir1GUagXeNF>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 11:47:23 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	ben.knoble@gmail.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 4/5] name-rev: make dedicated --annotate-stdin --name-only test
Date: Mon, 11 May 2026 17:45:48 +0200
Message-ID: <V5_name-rev_dedicated_test.6cd@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <V5_CV_format-rev.6c9@msgid.xyz>
References: <V4_CV_format-rev.6aa@msgid.xyz> <V5_CV_format-rev.6c9@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The previous commit split the `--name-only` handling:

1. `--annotate-stdin`: uses the new `struct command`
2. The rest: uses `struct name_ref_data`

But there is no dedicated test for the option combination in (1). That
means that the following tests will fail if you neglect to set
`command.u.name_only` properly:

    name-rev --annotate-stdin works with commitGraph
    name-rev --annotate-stdin works with non-monotonic timestamps

even though it has nothing to do with what these tests are supposed
to test.

Let’s add another regression test now that it is relevant.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 t/t6120-describe.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 2c70cc561ad..62789f76381 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -298,6 +298,20 @@ test_expect_success 'name-rev --annotate-stdin' '
 	test_cmp expect actual
 '
 
+test_expect_success 'name-rev --annotate-stdin --name-only' '
+	>expect.unsorted &&
+	for rev in $(git rev-list --all)
+	do
+		name=$(git name-rev --name-only $rev) &&
+		echo "$name" >>expect.unsorted || return 1
+	done &&
+	sort <expect.unsorted >expect &&
+	git name-rev --annotate-stdin --name-only \
+		<list >actual.unsorted &&
+	sort <actual.unsorted >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'name-rev --stdin deprecated' '
 	git rev-list --all >list &&
 	if ! test_have_prereq WITH_BREAKING_CHANGES
-- 
2.54.0.13.g9c7419e39f8

