Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6750E39AEB
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731768968; cv=none; b=egqEKKMb9R1GvoxKhY2LUbawsTFfjPsY9X6nYEBIFhAun5rqq3RAQZYj/3TLPuWw3CCfnORpmFEnTuMSiuczvhoTmqknPguoOgm9D4tnLU3iA3FLf3Q/Lwqz8XgBeVtnArA7dt9UvlF2SAqdFx6o5yGRFpTnulfqM+OKk0i2Gfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731768968; c=relaxed/simple;
	bh=6gMOIE5pBm/bMmA46h6Y6WLJcXKnfdHGEHXOTtnBIAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hj0L0hwfCidCXb+pTOhOVO0wOVfd0WzgWX+hm++4O9UPYuFLdwQMHuTQserEUKnCOTjXfaUsgDhVc0AjY8QYbOHYiXe1ueXYIHF+8OJLs8G34dSaHKYVpA4P/c0stduKf+jUYa04kNOpxopqn4Afg+iqJeLciqJDA/X5w6eaSjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jSjm2fNs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WuVdBAGR; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jSjm2fNs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WuVdBAGR"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5F03A1140085;
	Sat, 16 Nov 2024 09:56:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sat, 16 Nov 2024 09:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731768965;
	 x=1731855365; bh=sJwBk1EdWrXdANBZGKHFkgr2D2ItW4bZgnpbbbctIjo=; b=
	jSjm2fNsoEtZeki4PYv3Ww6Ru43BQXiiG1Nv8LILHkg3t17qt+0ymOcsX23jcR/W
	4ziLXXczNtbRs2LyjfIknVb6qHGw30s7gaLoBkUZA3MwMJYzn7yH5TzMm4iShSgr
	YO3V2CXM2tXGUJVsj6XcfwjPFeXdttZbfGjeNUYQ3cD563nL2qIh5094T3bY5Lps
	qnjVaJMSLTFBOAeSXtilXgIyrxs5W3daNa3wba5OhrtoGi9TyQIrrrwxuvIX7s2m
	ayARmEgvjzvlrU8chAOdqfNwFdBcElK4luSmXenRV3jkRV5ZxKf91M5zEkIcVGkr
	iBN6+gFam6jfi9GLduDRmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731768965; x=
	1731855365; bh=sJwBk1EdWrXdANBZGKHFkgr2D2ItW4bZgnpbbbctIjo=; b=W
	uVdBAGRe5U5TF7TvuUp8axezBW+3CQ9kTbreeng4HuhqfJ1iswgh38HD3Amk58So
	CGSX/iZdKWx5RoB4a41EEgjAKsgceZ+tuU0OdmYEyGygKBwX+0hiHPcCKPaJ5Lj/
	i4GjYDC0VPW2VQOey15nPLNuRGi2WIRWz7aLi408i7zu6czlU8b3CjVF/VukVXEE
	b49Q4qQwKQd4q01jvNmK+9V7yzjMuGIQofHals4xBIfoJsuqO7WkbOzwV71gU04a
	8Hg9EGhuIFlgekJrvrjfKoN9IsgSRDlXJDfZJiDTCmM4xSHlqqoBVz00ufmtf9qz
	x/2w+kXLTtxhTnTWBFZtQ==
X-ME-Sender: <xms:hbI4Z6KBSBAcVDEwoisipqncOd7qTA5HzjTV5zB0E_U7hhc96JJcwSU>
    <xme:hbI4ZyLapFi9grTfjwxnrQ0pJXOUCE5atXQox7XwtGrCZaV9l_qxfG8--kt8aq746
    G2oqYnyBPWsjKEWmA>
X-ME-Received: <xmr:hbI4Z6vE42TIu45YwMz5O0dy5Y4To7KnOPoQNKtnKtB6LqP1Ry6Vq4QXteI_ACoI62TLENxCqynUqsd-9QEd5vbo6Rn0ZPkvXlyyOV3ql1QFOdjvaehSHFc6Ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdeigdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgfegle
    fhjeekgfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgt
    phhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrg
    ihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:hbI4Z_bKM3Qe6Qy0FI_BdkHXb_beUmR9BK5_PgnPaLJ4rFRo8vBixg>
    <xmx:hbI4ZxYzcq3GPCHWODzxQr3n4OCHQLHc5qIPe30JiRzD2FMw8W8dNg>
    <xmx:hbI4Z7AgtCCk0ti2acHx5kF1w0dmLCx76wB2V2gwXwq-KuPvt3xcew>
    <xmx:hbI4Z3ac7fZI2ftO0_pXbP2JDsqi4HXPw0bedeayUP89lz2N0fFeZg>
    <xmx:hbI4Z0wqOYIrFVkrhmIVO7zGxN2PhTnAWjg2P7xHQyJP_N6bZdnoLSgg>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Nov 2024 09:56:03 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	avarab@gmail.com,
	me@ttaylorr.com,
	gitster@pobox.com
Subject: [PATCH v4 3/4] Documentation/git-bundle.txt: mention --all in spec. refs
Date: Sat, 16 Nov 2024 15:54:53 +0100
Message-ID: <4e9907f092ea7825418d2a35d7cdfc1deaee8400.1731768344.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.47.0.317.g7d2562b9734
In-Reply-To: <cover.1731768344.git.code@khaugsbakk.name>
References: <cover.1730979849.git.code@khaugsbakk.name> <cover.1731768344.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Mention `--all` as an alternative in “Specifying References”.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-bundle.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 917d39356bb..eaa16fc4b83 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -131,7 +131,7 @@ SPECIFYING REFERENCES
 ---------------------
 
 Revisions must be accompanied by reference names to be packaged in a
-bundle.
+bundle.  Alternatively `--all` can be used to package all refs.
 
 More than one reference may be packaged, and more than one set of prerequisite objects can
 be specified.  The objects packaged are those not contained in the
-- 
2.47.0

