Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C3628135C
	for <git@vger.kernel.org>; Tue,  6 May 2025 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540768; cv=none; b=ag0RP4Eu16riqBC1CwH3Hq2qcF+gkabDAY8EIC7yexonLIhqGiyMiueYFhdpwlysVhXGuI4aJ9Ixm94THB6tgDuvfXQhI44kCidr0/iz1Nv9d2yx52tyfKF9eP/wF3KLS91tqL3mdSEs7f9FT/Tm3IB6GF4zNl6Tjrr+6DuEEcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540768; c=relaxed/simple;
	bh=cH/kyn92OLiLkqKsYzOkSJ0uDILptXWT9DMItEBZzNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gI1oPg2TyedQIyBgTt3mTDTXleRjmF9+kGVq+Wfqm9cNNL1ZgVw782cHxiQ87NSFiSMbs+haw/uCLnL/shbITMwoZhUVdcVEhOKMWw75b+KxDSp7cCGQC2B6PTfNunjWF9EARMcJxdxT28A3gdu+1PRekepfO98SKV5b4sXEQi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jp+9OByN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rTFsMFWV; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jp+9OByN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rTFsMFWV"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1A6EB1380FB7
	for <git@vger.kernel.org>; Tue,  6 May 2025 10:12:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 06 May 2025 10:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746540764;
	 x=1746627164; bh=u0H89f+OCm0giry/hX4hrH7U8KP4smyMWowbbkynH2M=; b=
	jp+9OByNSkgOgdegd3aZQiGmJNfKWndXDYk89wJDQ0n40tm9I0cOB0y6Z/lLIS62
	ywvmGavUOqIckMQG5QOD8zvQNBmwW/J48XMG0r+5fIPA4U/HU2VDucmOOZzje9wB
	sDC6iNyNV6GHp3ni6PSDAvsxBpxq4wYVl4jK1bJGKD0rugQ0YN8hSd9RL+288PdX
	KmKsiuHeNkESzGowJwQw1En+Wu7hwRf20216b8KNfvcSy3hntyBgyc3LIVu9/CUZ
	ghek806LlQeTaXEMmw40cyjuGWcIA0jbcRT9XU1Z3kP6CAh9y6nU2LHKOV5mJ+71
	p5PNhBUA3W2koZTU2Ons2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746540764; x=
	1746627164; bh=u0H89f+OCm0giry/hX4hrH7U8KP4smyMWowbbkynH2M=; b=r
	TFsMFWVXhvJq/wZ9ioDZxmBssXzxwH74GB62hNxfFLYasLOR8CU3XNzJJbduL4I7
	WRNpcX81xzQ/IGNnhUJO9lKtR6IgBLgz8OV3E1/P0ltRfm1gUt7qH1q8DPqEP6vV
	3cfyZJipV6mqWLJ+2ByRWAmSyZS9GKS3O8XseBZAnCjaGe+xzm6slDToxDAEBk+d
	d5YzyWcvIVUYlTS1qiWWOFLsy4oE8YmQYZMX6u1VqVXLT5UCjYmGyo3cKnSKDvwz
	kFpLcwbabSAhtXgslbor8Bo8/7jpMg/IAmDYvTxdpl8n3XVw7WZF5BUL9u6NdSah
	UYMJAisun0lKXPuSOP1rQ==
X-ME-Sender: <xms:2xgaaEtcQpX4_Vzgn2zxhJpzg9Cwkyh6TdM-SpoyX-pOYv_SglZKyg>
    <xme:2xgaaBfKRpNxnSKYs9SOEoHncXGdBOZ9kkOgFrSN6DssVlIMsNxEb46EwdR46Dsk1
    TvzwLoAQsuKjjwSTw>
X-ME-Received: <xmr:2xgaaPwNSYXogo861JbT0EjMVTtsxl3Gw6i0TTUXGrnK17vxDhY6XmAY_Qppe677c3a0SgpA-tSlhCYfWuk73Pj0DdJe0yend2nBHF5n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2xgaaHPI3hOMfVb64SYPTYomNAsSUZOMmgtTi2SZUquUhc4uCLL5tA>
    <xmx:2xgaaE9vOl659LTP7PLn-yHEIoUm2QvJvtyOkbzqZFTtcXreLp2ybA>
    <xmx:2xgaaPX6nD6Z7l-sWgcnYAJbIuyCXwSmYRsE0vYh4i-iJv9L6OMp2A>
    <xmx:2xgaaNeJyPTyfqrcXjjRTIdS2UrAPRemChaHlkXGOL8GgqjWNLSiNQ>
    <xmx:3BgaaPbrUtoSm8e9QbJDthNfrFHmgn_dhIh4nbOM3rI6C9ztLMhcFAyB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 10:12:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 437ddc8b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 14:12:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 May 2025 16:12:34 +0200
Subject: [PATCH 01/10] contrib: remove "remotes2config.sh"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-pks-contrib-spring-cleanup-v1-1-e6d5ddd79a72@pks.im>
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
In-Reply-To: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Remotes can be configured either via a repository's config or by using
the ".git/branches/" or ".git/remotes/" directories. Back when the new
config-based mechanism has been introduced we also introduced a helper
script that migrates from the old-style remote configuration to the new
config-based mechanism.

With the recent removal announcement for the two directories we also
started to instruct users to migrate repositories that still use these
mechanism to use config-based remotes. Notably though, the migration
path doesn't even use the migration script. Instead, git-remote(1)
itself knows how to migrate any such remote via `git remote rename`.
Furthermore, the script hasn't been touched since afa75bc8aa1 (contrib:
Make remotes2config.sh script more robust, 2007-12-02).

Given that there is a migration path without this script it is very
unlikely that anyone still uses the script. Remove it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/remotes2config.sh | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/contrib/remotes2config.sh b/contrib/remotes2config.sh
deleted file mode 100755
index 1cda19f66af..00000000000
--- a/contrib/remotes2config.sh
+++ /dev/null
@@ -1,33 +0,0 @@
-#!/bin/sh
-
-# Use this tool to rewrite your .git/remotes/ files into the config.
-
-. git-sh-setup
-
-if [ -d "$GIT_DIR"/remotes ]; then
-	echo "Rewriting $GIT_DIR/remotes" >&2
-	error=0
-	# rewrite into config
-	{
-		cd "$GIT_DIR"/remotes
-		ls | while read f; do
-			name=$(printf "$f" | tr -c "A-Za-z0-9-" ".")
-			sed -n \
-			-e "s/^URL:[ 	]*\(.*\)$/remote.$name.url \1 ./p" \
-			-e "s/^Pull:[ 	]*\(.*\)$/remote.$name.fetch \1 ^$ /p" \
-			-e "s/^Push:[ 	]*\(.*\)$/remote.$name.push \1 ^$ /p" \
-			< "$f"
-		done
-		echo done
-	} | while read key value regex; do
-		case $key in
-		done)
-			if [ $error = 0 ]; then
-				mv "$GIT_DIR"/remotes "$GIT_DIR"/remotes.old
-			fi ;;
-		*)
-			echo "git config $key "$value" $regex"
-			git config $key "$value" $regex || error=1 ;;
-		esac
-	done
-fi

-- 
2.49.0.1045.g170613ef41.dirty

