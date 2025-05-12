Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2D725B1CD
	for <git@vger.kernel.org>; Mon, 12 May 2025 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041609; cv=none; b=m4nyZCMkAE13dlITIvbeCoia5/X/4nPFHjMkg5Vxx7vafhrAJ0+YpU9MP+1AFk4H29WwOvlJwZZWcpxWxopRoOjscJMCwy8tXg/iJi/LP0OpVd27koFKWXJC+cGX1ijp7CJDvQ3js+w4CPivY/pfyUZzILE09fx+CFEBhrw7v3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041609; c=relaxed/simple;
	bh=AF6wvG+DrZUBTx1cf39KNzEsH5OmzZr1GC2vqZvKF+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XFEJcnopTzZMn2SDvRMWT9KrERlQ+9pKSesDSl6AQoapu7vuyw8UnqD90EaZ942rDGOvjj0u63n/8J7tbEYKAKCjyCEmhXD4klB8WdyJUaWDcoLltLA+GwZsFv1yfNsRHAPvWu9hnB0Eejrvr2o5s0+7Rc49yagmCddmE1DO5n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sWev3H57; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G+GDdq/8; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sWev3H57";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G+GDdq/8"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 0F1081140140;
	Mon, 12 May 2025 05:20:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 12 May 2025 05:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747041605;
	 x=1747128005; bh=pXlv1vV5mEvFitAzV7wVOmzx2JqQRoLQ1GWYauj00cw=; b=
	sWev3H57eRj5bs5srJdmsgkdAfMfG8rqA/vvxpseV4G3nlhse2lsVOoz+PioQgNi
	Bud5U8r578awSk1QqaGzeVfNVO091zDf8Fh/zvwby7eXFBX3lDS5RdNHRMC46NDE
	uC7aLqMUzA+wevrqEKDFQZ+k478bEHK5JxVtTwiDlgXHJwlFvyomaOlsQt8vpZ+c
	M/5mhR8HqVLLQod7XchDrx0+USpO18xwAsPEKDeG/hGLH5LWQVczgVdXp1C1yoFu
	Ta+OLbojC8/GWnqpY7CrBPUS2Da+TpefsMxisX8zxZoOVbltbYqigDJRqUmaINbj
	lHHJaNgRDNJue0jVFZT5AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747041605; x=
	1747128005; bh=pXlv1vV5mEvFitAzV7wVOmzx2JqQRoLQ1GWYauj00cw=; b=G
	+GDdq/8Oxts5XQDyCVSDtFJQ7nLeWu79dy5La/jrr2WF+Vlbc+Os+otRb2FaevzM
	LsydSFzaBKBGsPT+sCLlKy3Du2Mtzu1j+zf6QjU83DOW0a24nhW6e7An9FxJk7n0
	bxdb0C3lI2BVa5qLlKIyYm0FzQmV5kXfDauDcLnIpEGO8X8ALo3NujZ1NW52dNgm
	itcYyqqk3hD7tMk8u08PSF3nuQ7fNk9lIfQ6pfoNSOKueEh0+xdNs+w5wPOY1Whn
	YtZeZOndV54kB73w2v9uFgjfbck9fp0hE6b1N9proMBPdG6ZGrAPH8u6l9NS0WBp
	ABv4uZrC6fC/WqAQuFbuw==
X-ME-Sender: <xms:Rb0haIMYDv1L5nS0Mvvu3dpmFm6JqxMqk8U-ULqtM9_SHjJb6scQsA>
    <xme:Rb0haO89wOM2wWCLe-hWhuTM4Vtze9cWtXbTknxOxtWEfa4lL6rjkt0KSufFSKWkB
    WL23k3jJbwl0PQbzQ>
X-ME-Received: <xmr:Rb0haPRwMwJQuZeJ-YFBeBzC1fkkSZSFr_jZubaoJlTknrsdKJzKZsLZ4I0sraNtUpXUVga9zXTO-GqVUDeMmxjiHzte2ZkWJtWp--W0lrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddtkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehmrghtthhhihgvuhdqmhhohidrfh
    hrpdhrtghpthhtohepthhmiiesphhosghogidrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhih
    hnvggtohdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Rb0haAu8NSWs-uM_eFbNZbSJUgvC4ElAiSZoKu2XVGRPAVs4CaUJUA>
    <xmx:Rb0haAe3Oj_BT3KkbiXE0lQVxN4JlF7yOLllYs7ahwB2bxh7v8F1mg>
    <xmx:Rb0haE3UyvnDOxDM9Z3l65PHoWSXTw4WHjfYxLU_CiNT83osa_Zg4Q>
    <xmx:Rb0haE8ks4WQ3FXWTlcSKy3fW5Uy_jkWnVhVC0dJ5TLHhvSxmYuDMQ>
    <xmx:Rb0haC8Wiu205WbqRRoYQJCU2U-Asg9t7Msvm_pgggv04V-RTNwxGmyA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 05:20:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1dd09277 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 12 May 2025 09:20:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 May 2025 11:19:51 +0200
Subject: [PATCH v3 01/11] contrib: remove "remotes2config.sh"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250512-pks-contrib-spring-cleanup-v3-1-32e151b0bfb0@pks.im>
References: <20250512-pks-contrib-spring-cleanup-v3-0-32e151b0bfb0@pks.im>
In-Reply-To: <20250512-pks-contrib-spring-cleanup-v3-0-32e151b0bfb0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Matthieu Moy <git@matthieu-moy.fr>, Eric Sunshine <sunshine@sunshineco.com>, 
 Todd Zullinger <tmz@pobox.com>, Elijah Newren <newren@gmail.com>
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
2.49.0.1101.gccaa498523.dirty

