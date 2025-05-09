Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F71F274660
	for <git@vger.kernel.org>; Fri,  9 May 2025 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746782236; cv=none; b=LhVGCU3jO7J5ZBe6iuo6ilSS+giv9eJnrofycwRJrMTqDvCcy/p5HAdr59/sNsVmkjOIzazXLUYZZhFfRDzGM9T807YGihAjV+sMGkW9zKjd3pc169GcGruYFIhVCi3c1lGHoOf0dyvq3+/9b72pGQD9GS3RQ9k9HWG4D8Ly6q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746782236; c=relaxed/simple;
	bh=Nb3DQtdXuC/LlTQ1uAyMGKXdqjqHL46/BMwE+kZSP3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sPtj4nq5DcrGRkh73de09l8qetA92LO7u+jhTzsIhOdU1Y5HNS4XQPSRgpuJz2pc7hb90/VMpEULPHsOXuJfKqyQGPdgQxA9o9iPrXDfEvqiG+bpXuLF6vgK/jejPjQTQas7jZAGGrUh2aQDFK1C4WKe4v4cQaIMoJacTNzU2dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=xHQCHJ3H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E/98igu3; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xHQCHJ3H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E/98igu3"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 212981140182;
	Fri,  9 May 2025 05:17:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 09 May 2025 05:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746782233;
	 x=1746868633; bh=bNkl8tMJsxI51QxT8kBmZk3z5FHT3G954CdnsEyle/Y=; b=
	xHQCHJ3HyBHq7DeF+jcY+aBtGOTzE/Ga6qAoujA75mU6YBLKuERWsGvkF84qkM9S
	FDw/sziXto7ADCoaPIIdXbJVSSo4HHN713SL8NeOWBzGOCJOE4zhkDqCzXydTHAp
	5O7MQA7qhMfvUVCqjUGihLSx2gTx9HSFCYOK5qDP/yOrsSzquRzkBY1/RRNj6M5Y
	QeDqykVBU2ehjtLByW1fMrTNJKjoxbWpBvd76rL1dd8Xqpx8Wc+3K6dm3XiS4U8+
	KItEcJxkGh7nKxiSvi2bJqaWj6IOFpxyCuA/Xe/JI+680MwCew8Vhenz3CYy0Bv6
	7brfMGe+JZjWlnh5UkWyVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746782233; x=
	1746868633; bh=bNkl8tMJsxI51QxT8kBmZk3z5FHT3G954CdnsEyle/Y=; b=E
	/98igu3GgiDx4e/kqyBOcxOlFH3pHAnzwK601/RWl0b+rl0hoT2um0c8aTOfQaRM
	SopTfk2WVtMyo7qZyEkJcJ1hzDGUQrndfxHpEV1yUYysNmFfPV/zdmRpD2o/uNWM
	7GQnBcbhgvaMnhljW77zeE7nOf7ZkhbX8ucZ0qARlmJR0USw/nSqM8pRBop0Ov7X
	d8Ldc+nm1w8FCabWwZH77Dl3Rx7AsaMKJ3dlLCbwQkEEBdnQdqq/ASiFkw7LJrtb
	cUE0nh8caP6gKM3ViwSLnuNqQQBLITSxi0a6Xpu2lF1MEks12yx7u+MoXBdBWiyC
	5mvJ7YS+5ZQsDx1EnXWpg==
X-ME-Sender: <xms:GcgdaG2dpd2m9y9EbNVMxg_9D5l1N11DvGg-3KTd5ivr3I6T-f27hg>
    <xme:GcgdaJERZhm4ssnQlH3R4sDFNrfTMaJlOhOiCSeZToM_2sEAjhMN0UslF_mqTY8aT
    Ii3rjcJqhg25WGQOw>
X-ME-Received: <xmr:GcgdaO4YSmsrNzdZ8cMjq5LKIbYo9SWgxo02bpXJTugm-YCyZ_j9Pi0I9ma2jueSJqYRP_v_8OBThW2mLD-anrsP_7sJmCtF-kHKp9Zl0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtsehmrghtthhhihgvuhdqmhhohidrfhhrpdhrtghpthhtohepshhunhhs
    hhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehtmhiisehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:GcgdaH3dPeVf2Zev0274UknHlWQ6jgWbpB83Zl1LqcyBFMdUBXL50g>
    <xmx:GcgdaJFg1QGWNKOr5ajmPt_QjC7H8pZKPTPZEx_iZl689GIvw3nxGw>
    <xmx:GcgdaA8AL8FeIimBtoAjgDiV5xHBZGrnExYl3FKOEcrP7oCBRNtVzA>
    <xmx:GcgdaOkRgv1T7JrKGRf-08X9F9rTxqEyRyc1zQRTlKkCvESAxCu8pw>
    <xmx:GcgdaJ-C_KsqGkJl3mBhX1nc4S0NREq0ulRnB9wdsAgtYyvAw5Wm4RMf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 05:17:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1d7dd1b6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 09:17:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 May 2025 11:17:01 +0200
Subject: [PATCH v2 01/11] contrib: remove "remotes2config.sh"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-pks-contrib-spring-cleanup-v2-1-14e20d95ec68@pks.im>
References: <20250509-pks-contrib-spring-cleanup-v2-0-14e20d95ec68@pks.im>
In-Reply-To: <20250509-pks-contrib-spring-cleanup-v2-0-14e20d95ec68@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Matthieu Moy <git@matthieu-moy.fr>, Eric Sunshine <sunshine@sunshineco.com>, 
 Todd Zullinger <tmz@pobox.com>
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

In fact, a full migration _cannot_ use the script as it only knows to
migrate remotes from ".git/remotes/", but not ".git/branches/". As such,
the migration path via `git remote rename` is the only feasible way to
fully migrate repositories over to the new format.

Last but not least, the script doesn't even work as-is as it sources
"git-sh-setup". For this to work it would need to be invoked either via
Git so that this script is in our PATH, users would have to manually
call it with an adjusted PATH, or distributions need to install the
script into "$prefix/libexec/git-core" with a "git-" prefix. All of
these steps are unlikely enough to underpin the claim that this script
is not used at all.

So given that:

  - The script cannot perform a full migration of all deprecated remote
    types.

  - We don't advertise it anywhere.

  - It has been basically untouched since 2007.

  - It doesn't even work unless users do manual steps.

It should be safe enough to just remove it. Do so.

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
2.49.0.1077.gc0e912fd4c.dirty

