Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5463C944F
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040191; cv=none; b=EnA9fqKpBcRkAHzHKE9ol7BFgaPQLt1Iie3KCO5W/Vzxs23WRbRyKXudYNUf/XXyVRdQk+Sa8EUbJUTKV8gqNM0X1e6mGcnm+PSBsuB5H2SAVVFBh5h43Dd16gfRVvf6Hx4tY6VwpXj4uUJVG75SmdfNjfKfhu4FWueeuhccTa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040191; c=relaxed/simple;
	bh=2FIRM0+IThQzyRY/KLk9FDxlgHqETupwSs71sqKONTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ec58Qb0/uChbJ99JAbe7Gza7/jNLJXBoumWhSe3UiVMWtTEYzOP6Hci4Ow3+sK31dZlx/FiOzoTe9gSTJc7t3HbR4gpItYnDresu7tvdYTs5mrlU4DrRW2pPRT8fAiqfTuBfWABYTF44nv4aOl9hnX1CcDacEBzaslrLxu7XQaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=npe+ywRH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H+nDsKxh; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="npe+ywRH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H+nDsKxh"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 0F7F21D002AE;
	Wed,  1 Apr 2026 06:43:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 01 Apr 2026 06:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775040188;
	 x=1775126588; bh=Ehh5NQYEczt6DQTGF0v/bjnQ7ytFfM6v8OGzoWsA0M4=; b=
	npe+ywRHJFG2/AWlXXwgJXjip7N2brFBsMqmkIG3xJWJWqeCHtKuU9U/BOTx6Gk7
	8Zf6zS7X0Ckq4GwzblyL1aLp9JmuA4EWVOnMoK6q3hbj4/AlxddDeU73yF/LhzqH
	vypxG0mMEWqT11L7XV0/NGpOygs/DFLO2PvCyvEP7KbHyyN+ZB1JIP9fFra1xADN
	ARD5WXo0s5baaS2+5r2kKpqBg/CmTqTpenmjYByBp1wShGE6FjzhQqFRxywHt826
	WlpUnt1+2KEAMh/K4qVxbMKOi2D8mSkZ7bHsHkHvRo47uXYKa3PhQN3ikU0Wsd3G
	idj1IIf2n9ot2jnVPbu23g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775040188; x=
	1775126588; bh=Ehh5NQYEczt6DQTGF0v/bjnQ7ytFfM6v8OGzoWsA0M4=; b=H
	+nDsKxhTotQuMXuohrnaaDm9lGSl8magupRm4W+6D6hOC/zas7KUPzkXpDl2hFwG
	hEXWlN1X7UmwQh/ad37eYBw2Jg3oQhFhtH8VthMUjaCJ+HglPhxo2m72+7NZnmzw
	MnZYsH4Y4/0zk9JIIYv0HNoJD6EJEUg5/tuC0e/rclnBsLfYEOT7C7vphdk61JdX
	WZ+q7wUlR4F/50uCBk7OHVBLhJWZpyfgeX1G6yQ+HLtEQlDdHywrUz/GeJrGRbhU
	ix/+P6SeC9KySXUpPMBRDgmK1yIkMhf+0olvfNE7A7P3yAH8OwPVPBdXzPlQprK7
	AbTEgmeTwdFu5veFioOkQ==
X-ME-Sender: <xms:vPbMaUGBAsGG1K-o50x-W5w00sDykqimWaxzQ_4JaE_ICyVhGNu-Cw>
    <xme:vPbMaRpatZGjyseozNUMK6593_Gwr1qpcyvXxb9vOX3Qu-SQwTZiKsuXguJY13mjs
    OM77_OB9kRAPuSc0lvR5Ldomnixx6pX-t_1yvnYdqwB2IAAZRdWnw>
X-ME-Received: <xmr:vPbMadRrt3ChQLsDS51xzvMWBlYzCdCg-CDt11RkCzATP_LQFxt5kF7gmRsQqK9YjtuJy6-9MeLq4IWgP2fg6peXzPEB8Hj7lfyTa61XbxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvrhgsvghrth
    esghhonhguohhrrdgrphgrnhgrrdhorhhgrdgruh
X-ME-Proxy: <xmx:vPbMaeNYO7ozGt7h1V61f589gWT3ii8pYt25V_XQdVAEXWaIThLc9Q>
    <xmx:vPbMaQPT4pw710AqXwcSTMKTzVNcEfcVtfaQsdZ70yxuQDhYKxAW5g>
    <xmx:vPbMaesNt58LSroJQxxsU5LoQYmQPcojxp53hPY4SM4Wa2B5Wj6rqA>
    <xmx:vPbMaaWKd4DNQnw99GcRveoFwAP4pkEe9AbnCoUSRjAFTgn9BKf6OA>
    <xmx:vPbMaQ1-n4h-3YdG9DkOsgvo4SOIc_rEfXkbudfPWoiKMhoPn1NfsVJS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 06:43:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9b1dd767 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Apr 2026 10:43:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Apr 2026 12:42:59 +0200
Subject: [PATCH 2/2] t9300: work around partial read bug in Dash v0.5.13
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-pks-tests-with-dash-v1-2-d70b5040aa5d@pks.im>
References: <20260401-pks-tests-with-dash-v1-0-d70b5040aa5d@pks.im>
In-Reply-To: <20260401-pks-tests-with-dash-v1-0-d70b5040aa5d@pks.im>
To: git@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>
X-Mailer: b4 0.15.0

When executing t9300 with Dash v0.5.13.1 we can see that the test hangs
completely with the following (condensed) trace:

  git fast-import
  + error=1
  + read output
  + cat input
  + echo checkpoint
  + echo progress checkpoint
  + test rogress checkpoint = progress checkpoint
  + test rogress checkpoint = UNEXPECTED
  + echo cruft: rogress checkpoint
  cruft: rogress checkpoint
  + read output
  + test  = progress checkpoint
  + test  = UNEXPECTED
  + echo cruft:
  cruft:
  + read output

Basically, what's happening here is that we spawn git-fast-import(1) and
wait for it to output a certain string, "progress checkpoint". Curiously
though, what we end up reading is "rogress checkpoint" -- so the first
byte of the expected string is missing.

Same as in the preceding commit, this seems to be a bug in Dash itself
that bisects to c5bf970 (expand: Add multi-byte support to pmatch,
2024-06-02). But other than in the preceding commit, this bug has
already been fixed upstream in 079059a (input: Fix heap-buffer-overflow
in preadbuffer on long lines, 2026-02-11), which is part of v0.5.13.2.

For now though, work around the bug by waiting for the expected output
in a different way. There is no good reason why one version should work
better than the other, but at least the new version doesn't exhibit the
bug. And, if you ask me, it's also slightly easier to read.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t9300-fast-import.sh | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 5685cce6fe..479437760b 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3635,25 +3635,21 @@ background_import_then_checkpoint () {
 		echo "progress checkpoint"
 	) >&8 &
 
-	error=1 ;# assume the worst
-	while read output <&9
-	do
-		if test "$output" = "progress checkpoint"
-		then
-			error=0
-			break
-		elif test "$output" = "UNEXPECTED"
-		then
-			break
-		fi
-		# otherwise ignore cruft
-		echo >&2 "cruft: $output"
-	done
+	last=$(
+		while read output <&9
+		do
+			if test "$output" = "progress checkpoint" || test "$output" = "UNEXPECTED"
+			then
+				echo "$output"
+				break
+			else
+				# otherwise ignore cruft
+				echo >&2 "cruft: $output"
+			fi
+		done
+	)
 
-	if test $error -eq 1
-	then
-		false
-	fi
+	test "$last" = "progress checkpoint"
 }
 
 background_import_still_running () {

-- 
2.53.0.1185.g05d4b7b318.dirty

