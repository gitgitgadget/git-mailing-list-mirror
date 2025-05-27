Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE9D214236
	for <git@vger.kernel.org>; Tue, 27 May 2025 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748380824; cv=none; b=UYgFDtozcIvXZEaRA3cPmfLTFnjEHNIv0kLEs411mN99fobQ3qu115MRjLo1S1eJ8D+6jQnbPb2nt62Sb2X38my1XTQsTAyarEoKhQr1i3CHieXLp9unaj4Q9M9D1fDiJKAHG0t2dqx6fTIPQMMtu+i2muZrvaf1+x5LWuYfzbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748380824; c=relaxed/simple;
	bh=2bstXcL2GbFJfX9roxcagOoosugGimVL4hwz8Ra7nQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/1kniE+fnHTTl76Or4KAWnoMhv6lE/+KKRhNOJy/d/IQgA9Vq0lumv7r92lEnYPTcASID7Ev4HxAOXnCodl02grnriU7B1hj94eGifvEHQQsUT/6nCu2ceWB3kzERjAjZTJSEPBFR6awwo18GiMMusCaI2F2xgblx0Gase76UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=WpLJHL9s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XbVmOtq5; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="WpLJHL9s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XbVmOtq5"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0580A2540170;
	Tue, 27 May 2025 17:20:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 27 May 2025 17:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1748380821; x=
	1748467221; bh=0jIXRQKhmw8FHCJICDwPLsotsSLsIBbwheE/rTcIHfI=; b=W
	pLJHL9syfTAKyf234jMKPrjbBk0GBR11nVYRu0UrRtkQtenW6wrsSv1rSt0St0Rv
	7lIsS0QAIWfm5zV9WVy7ivNPCfJg4Z5DpqnRYQZ1R9FiThPDJ3q/yWt52U++bbdN
	TWBQzyfl7gv2OjL1qS9b1ANSvW3FdRBcp8XDq1SyCyPTj6STWMras0TIVeO6Us0k
	v9pwDR2SIXJXyXok46KXwfcufzmpEnsZPG5WVSDVmcBtyqJeW6JeDjeBPhEobDLQ
	d4Vc5KGa6u8jAmwL9mhW6pmdoOQ8WMpczr/yUNeX4Xbcyb2Hi9UDXRszbQqPKDaO
	fWOvnVjy+c3XhRCosEvyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1748380821; x=1748467221; bh=0
	jIXRQKhmw8FHCJICDwPLsotsSLsIBbwheE/rTcIHfI=; b=XbVmOtq5/jzQckWvs
	GWa+b+n78oJImLX3EMnpY1ABZ8TfJYNmAvynTyxpg1wlTxmQQu/k5cj/U9aoAuI2
	Z2U0CKoq7Z4ooLW9v06jZcRQTmm8qg8RfX6VhwGP081tFx6hUuW6qsV/7my83gry
	HpOeZj4qeLCj61Nl8brCpikKVgYTIWRUG3FQGjsMNu5sW3K9iN8zfNkI8ZV7I/1d
	Y1hVvpWKhXDFGm95rsH3xu4Jc/7MV5cyLQQhnR3cQYqk/ltzN2YXYnW/qS+wXYKx
	MtwvXC//KJ2aYT0f0Md/kKd1eF63ken/ANCRVg00E/1maVzGu+EgWB6K0PhpcmsE
	UnRAg==
X-ME-Sender: <xms:lSw2aJwsnagkVVkub1fCalDzgJdsoSCNreEwMkcT-W2ToXGwivoJJZY>
    <xme:lSw2aJRCxrCJcfgZNLb-8IU-egmMXr9kAy2kuF_iprRUdIsYCi3qd3sFWbqNXCbdZ
    cI65wa45nou5UAeow>
X-ME-Received: <xmr:lSw2aDWpCxTKv8d16e1hdusfNqtqXydJw5vg0hqOvDkB33slN4MzpNYYGeXlfRsE2CI6ORUHoD1ppRg6okcjPDzIbG7O2jj62LjdZTLCXlpAaYTCHGueiVAJxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvudegheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffo
    jghfggfgsedtkeertdertddtnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpeefheetkeeftdei
    ffdvjeetueethfeugfetgfdtveehhfevffeuffdtheeitdefudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepugihrhhonhgvthgvnhhgsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:lSw2aLgVvDovxFcfkxuxzVbJrmtbTMUyXVToiuCo0etAlGkKKCrFJw>
    <xmx:lSw2aLBTfM_mGfSVjpuRoDw26jEL0EDk2tc5wCJ-4Av61nRrgHvolg>
    <xmx:lSw2aEJeRlKYEhEaE9sWj_gPnLpITqxPNfAx9uWmi39OnWhLH7lVxQ>
    <xmx:lSw2aKD_GtTTC0TECSSHfm44lrjvTDenGjJgCovpI7sUtvC-EiajaQ>
    <xmx:lSw2aDc5BEALKLe2c8KErTphNxHehVFj3kRMZIh4xGX-FBztrjGIxBCN>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 17:20:20 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v3 7/9] doc: notes: point out copy --stdin use with argv
Date: Tue, 27 May 2025 23:19:36 +0200
Message-ID: <e18472f735d658656f7fdbc21ccc5befa63feb85.1748380390.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.780.g892193c3f50
In-Reply-To: <cover.1748380390.git.code@khaugsbakk.name>
References: <cover.1748028010.git.code@khaugsbakk.name> <cover.1748380390.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Unlike `remove --stdin`, this option cannot be combined with object
names given via the command line.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-notes.adoc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-notes.adoc b/Documentation/git-notes.adoc
index ef5a939516e..9ce71ec3455 100644
--- a/Documentation/git-notes.adoc
+++ b/Documentation/git-notes.adoc
@@ -87,6 +87,9 @@ In `--stdin` mode, take lines in the format
 on standard input, and copy the notes from each _<from-object>_ to its
 corresponding _<to-object>_.  (The optional _<rest>_ is ignored so that
 the command can read the input given to the `post-rewrite` hook.)
++
+`--stdin` cannot be combined with object names given on the command
+line.
 
 `append`::
 	Append new message(s) given by `-m` or `-F` options to an
-- 
2.49.0.780.g892193c3f50

