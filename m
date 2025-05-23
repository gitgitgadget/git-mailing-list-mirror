Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB1029DB93
	for <git@vger.kernel.org>; Fri, 23 May 2025 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748028718; cv=none; b=sDGkaIArOchrjgCVCwX+VwPJrEAt1jHhWDAEarFKORpsRdCLXNIqBMAHEDG1PA/+68CEVyew+nCfxKvVM+9rQXJ0MyQ1m3B77SQbfUIJ9cpydat+kGDXvrv+e6YaE3rGMXCG7gbLqiDE4YgOd7/YmxfcQTTQIuw9b0h9vz2E5mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748028718; c=relaxed/simple;
	bh=0OA3metDEtvIcw0CA8Vmv5buxw4sEHxrmvYKwEx3u/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zak3pwtIMDPBRmhddZpkQmI6CVgpFcg7PxYcN8G4v/tM0uTNcwJsHZlksCgufK7rB+S9hWyzmUPwKdqQ1PBt2LePzHem+p0nDbQNXrvcE514Jcgrcyc/3xd2wt/Ea7tl+wdotmSOxcuPSFc6WDcxBXHFu3ti3dCEg5ziMGXgxvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=hLwGRqhU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hp5jvoIz; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="hLwGRqhU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hp5jvoIz"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3DFAA11400CE;
	Fri, 23 May 2025 15:31:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 23 May 2025 15:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748028716;
	 x=1748115116; bh=VpVdpoVTy2XWWkiZJB5OWfDUGbcSZhb3cboz/l0lJqI=; b=
	hLwGRqhUqzmbHY6rLKDBXXRelJDOgIDyq99qg97xtdOgwdNFPvLMTNV+8oDu8MUE
	v81J0xPu8C+vGYluNuIObNaYhV+INDRPuExa8zSAQH5azSat1jYANcv5+JJfyVpH
	vQeWmDjzpPOU9TQjuGA34k4WPG/Az3gw6BlgtnBFyh16u+o+DHkg3+UTZS0QTxTr
	jJwIyEyIbuoxumv1EQcwpDCPXYeP2NWjE5g19O1qowBgOMhI3C2JAj8JxfmHUQCr
	QzsXlfit2Rgu2NqZbnCb23qi8TN/uFSpLcLA4Fy/tDBZnSQSsKWgmKLAW8oQtwC8
	P2VOy30ODGZQOFAwFbmC6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1748028716; x=
	1748115116; bh=VpVdpoVTy2XWWkiZJB5OWfDUGbcSZhb3cboz/l0lJqI=; b=h
	p5jvoIzxunu6RCD/cvP/yHbAXZPO4z3F+wkjYu8QZHyL0rs2hUymsO0LoCG2IiiA
	X3jwc7oJOSckp6A6aBel88I76hCB3oSyK8DDIaDuXplJBxi3AK1KbCc8xpRKEzrQ
	cM74DA2olqn27bnYh8XfYJoPGB+T21qCF96/tq0M3g4wqTAggnoGVlMC4c5UAid1
	thNNyF/1npZIGyhrWXOQtz6iEwU4sRAuB6/DPatHIkqNTPR2Ee+h8LUquodxpvyf
	Mcoy3znEhqSorHACuknfvCR0xq+UNTQMUlUJRGTVbVS8BEjZcerxYYLuuZ6DNDWS
	M2E0bGew9bX0rD9znN8HA==
X-ME-Sender: <xms:K80waDnBUHF_PD88F8mbwIbJ32v71lFlZVaxiAIXRN-wjhos6cTt13o>
    <xme:K80waG2XfaNaU2fA2MMG5CNiyMlZdzWvh6W-O4t4QJF6CJaWMzeip7HVtZznBcxkg
    i3itWW4NGd9aV7oJg>
X-ME-Received: <xmr:K80waJq_YYhhU9IyqnUv9LWIeqvTf3tdu0VKYl73DlWIXrZA2jr01CVgCMxA5lrmFwYX5MzrEVXE6WR_qHbuAylBXW5iIFBth0o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdelieelucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgj
    fhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgfeglefhjeek
    gfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepugihrhhonhgvthgvnhhgsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:K80waLlcnlZu68HOfi5G043epSwsaIjpCcm3IoMf0OjGY-w1jwcSkw>
    <xmx:K80waB11i024RiIM-RBlsF8qxOCrFzVWk1bj8oNb5y2zDupBucXlsA>
    <xmx:K80waKuHO-04gk_UwOqdsBIwOyn_JoYW0PZE0W3lgpe0719lj8YbOQ>
    <xmx:K80waFX3fUwrkDv7Mk4L1570y4kQm_UDRZpsMCcE4SDiJ3K_jTJXjA>
    <xmx:LM0waKZ6JIJq43GS_VQxCS-SSBjsA2J_ajKlbSAjnYYTWRpOcJWsvtDI>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 15:31:54 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v2 2/9] doc: config: mention core.commentChar on commit.cleanup
Date: Fri, 23 May 2025 21:29:48 +0200
Message-ID: <e9cf956a824c888b7313d6a2ff5c513374b3e40e.1748028010.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.780.g892193c3f50
In-Reply-To: <cover.1748028010.git.code@khaugsbakk.name>
References: <cover.1747763769.git.code@khaugsbakk.name> <cover.1748028010.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Mention it in parentheses since we are in a configuration context.
Refer to the default as such, not as “the” character.

Also don’t mention `#` again; just say “comment character”.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/config/commit.adoc | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/commit.adoc b/Documentation/config/commit.adoc
index d3f4624fd27..208ae76c816 100644
--- a/Documentation/config/commit.adoc
+++ b/Documentation/config/commit.adoc
@@ -8,10 +8,11 @@ endif::git-commit[]
 	This setting overrides the default of the `--cleanup` option in
 	`git commit`. {see-git-commit} Changing the default can be useful
 	when you always want to keep lines that begin
-	with the comment character `#` in your log message, in which case you
+	with the comment character (`core.commentChar`, default `#`)
+	in your log message, in which case you
 	would do `git config commit.cleanup whitespace` (note that you will
-	have to remove the help lines that begin with `#` in the commit log
-	template yourself, if you do this).
+	have to remove the help lines that begin with the comment character
+	in the commit log template yourself, if you do this).
 
 `commit.gpgSign`::
 	A boolean to specify whether all commits should be GPG signed.
-- 
2.49.0.780.g892193c3f50

