Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B3737E2E1
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 22:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777415266; cv=none; b=XdRRqQstQJiNNKlIsbqccRShJngvaE3MBdp+DXUmqLOm/OOM6RMGE/MaRm5F6ABjj+mDrGRFwtUT+HWB/BWWAImuwRDId5zn5ECVFRsFkjPdWaB5FbX2IYhNr52YyKNkYkK9Hhp+qMFPtxhdXosW85GyCe8bBDnDuxFTBUjkQBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777415266; c=relaxed/simple;
	bh=2gVEDcx7FzPvE2Ak1OyIADYTqSl7XD30t0NiskR5Sc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNNW8QPK8vrkhLKYbtT3nqzJ0fGaMnf/iJ3Xuh8pCnPqz2BQDCwll0Y0dFe9C5SoeK2Ojy4lt0HzhtG9x4s+nhy1xHCORhTVLEbXtKJ18EupAYBtt641p7hSV9Vzg8FRq79dCwcOK7uCFGtkBd6vYhAVoKgrIogHh2VuvbOqDRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=mObpyLmV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pO/CLXlP; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="mObpyLmV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pO/CLXlP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1EFFC7A0277;
	Tue, 28 Apr 2026 18:27:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 28 Apr 2026 18:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777415263;
	 x=1777501663; bh=d9j6OUvygxvmWr/ltxSEHwuKG+yTtu/Wo+VC9O9Ccow=; b=
	mObpyLmVs2dhDVxoDzRJONcqdgPuErSG5b5VKxu46QzJD6PoNNrqVUi8zQSmUKx4
	oluMY7cksWoYIN8lCus81zsNv8H2MlKLOQDlGmu+ajoC9/R8FxhvaWJgLBxCAltN
	0hP86eaKgRw/UjJ4EiT+KpgQKxjzHbhybb4VHLS8h4ozg/msnFFC8V2UD6wC2DJA
	/3j1WwoXrjRhk7poZ5tZvheS4C9/FAM3cV1DTxOY3uSBy3eJxWaIaBbVYOm0aJGr
	WPpV2kF0EB00OmY8eOlPAPN5/9ZkD1SBEffOFEH0o2xM6hf0eOWio6L4rK38V3v5
	gexsOGKAjjqP2iOgF3ruEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777415263; x=
	1777501663; bh=d9j6OUvygxvmWr/ltxSEHwuKG+yTtu/Wo+VC9O9Ccow=; b=p
	O/CLXlPFqhC/rpBt+LlV7zEmk9TYvg0lnxm/ZworXQK+/sNekGphGEV20AOpYYZV
	MAqJhyC5n9NWGiloUH0rwn64DdZ/DLU/Za6WUcqV2z+yq7ewMS27iehc3xrD/JIr
	enauxg+A0CYu/jPEsFLZF8451PyA9PHe9dJTMuUugSX5dkwA/rxWoDa3y0/TL79K
	yOZfeHIuxnaRP5zjUbm6lMqjyN2F7kWGUb644+GakXCf5+hKUmTAO5oEW/dTFe5j
	FgBGhbFQl9BMUaLuJfCmo9X1SLF/brvwLSbOTo6Qp2Ed/ZbzPU9bCcZ05Ol+Uz1f
	f49zMb7o9EyA5feI0Wqug==
X-ME-Sender: <xms:XzTxaSP_KnNn9D3p_nUYtf3wDix3yY5sci3WyFRiT2tEP8rq2wjd2qY>
    <xme:XzTxaYYLnurwcyrh1X3AVj5UNFhB4PFL7n13HIvdHSRlCahexxAmZwctDtvH-yPhz
    3i82DmnCwVyCTmSIICGJpd9ZEPScIcjkI97QDpzQj06mP87rRVFKA>
X-ME-Received: <xmr:XzTxaWpUq-s-ILhWdxm88CAf7bdCyu1A0ddiZm9if4mSg21Ffx7mumcx6dQotGyvcNBapRi_ULS70nXY3yHRDtAEG_5uL5i4AMWN6jzvA8dQhnowl3b12GcF8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekvdejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephffvvefuff
    fkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgfegle
    fhjeekgfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgt
    phhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:XzTxacawTOx9_zZcSOKwGesG-1PCo13tKMjEQG_A3tqYq7CDAz3Gsw>
    <xmx:XzTxaeSjYphk5yyfsehzehQ2UJnxRruQAW9eZrElvNxPdl-JlEpN7A>
    <xmx:XzTxaT4hAFpuEjhHbL4B9DoHXOH1-GlRkTRZV3V5ooZxveysWNVLgA>
    <xmx:XzTxaTzl5kalbsUYh2sF8JbK6sctSmfuG_lms0YomBfX4YF33WxOxQ>
    <xmx:XzTxaUYZNV8YD6UfxQycifWZOaFMr9llo9YwrbP4w-JVV8GtZwgRWb1j>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Apr 2026 18:27:42 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ben.knoble@gmail.com
Subject: [PATCH v3 4/5] name-rev: make dedicated --annotate-stdin --name-only test
Date: Wed, 29 Apr 2026 00:25:55 +0200
Message-ID: <V3_name-rev_dedicated_test.66e@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <V3_CV_format-rev.66a@msgid.xyz>
References: <V2_CV_name-rev_--format.51b@msgid.xyz> <V3_CV_format-rev.66a@msgid.xyz>
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

