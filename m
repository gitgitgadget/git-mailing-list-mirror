Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F3334CFAC
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 06:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775112690; cv=none; b=kR4Yg5lBXrjPrCUblOPnk2EoJrGmecS1URpLYUU7DsjmjdSor4FtvAI8k63N0DskpBVwn9NENQnP1UtTS0eVe3RTXUJQehox3M7fSEMB7olm/1Pi5v6wAhAKrmHiYlw0dMHMyYvSNVXIhFHE2DCPSnFwd0OywZ9DyD6l4mTsx8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775112690; c=relaxed/simple;
	bh=33ojwlQVdv0kcabejNzH9WmYDg+hsaBY9ITqMkOYlFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ARpNqS4/4jOIckU+I3HPub4cdhJ+YCAYGjDon0jLsHs4xLZPEhfMNEDQe+Jfmj6d04+bOEYwWZJGMHf3xEHSJ62fTqaxWf8llniSYwOjlfAEdLBb3XFB+wPNxDggbZHWqCUASlUCgNXBdQjpM3D5f6HquuPrqsbzdY8issgffqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mOmyExtv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uibc3V5I; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mOmyExtv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uibc3V5I"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 639941D003AA;
	Thu,  2 Apr 2026 02:51:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 02 Apr 2026 02:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775112688;
	 x=1775199088; bh=8ZmtQtITpclR+49EBgy1+8oRQX3gZ1zmnxtp3ppX3RI=; b=
	mOmyExtvlCtJkVMaZgoCwgSI6Knirh4cMkzW5+HxHLtPFIUaWDQdjI3023R6hPbn
	dlu2g6wrnaz/SjLCysP6e6mNPn11NfwR7GRrX/HszLmPFE2whmfpuUzT3YseWCJg
	iP1nUV6bRBT/LvnjbvdNR1Vh+r3Bf/NV6x71JcmQTiyW3RCct0N6Vy5z3iUgQoqe
	YLh13912/Fcru87BOxSKnCqGYSI7rjFIh32TAk2bL5taHK70MFrnJU+L/acyoGCa
	HfYXLJgm5X+y3VtMNMOfqoIlQ9vBSzGBBpWkTTTwFKz6BMoGk9qTeVYsVxOfsq5l
	HTaZMHB05lrue8OJFQ9F5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775112688; x=
	1775199088; bh=8ZmtQtITpclR+49EBgy1+8oRQX3gZ1zmnxtp3ppX3RI=; b=u
	ibc3V5IwOO1c/dHsCGhusgA11viAoCQMkbTqx//54oP+fx0e0jeEuWQAeC1m8bn+
	DxCOJ2pv723OoHHxF61H2Mk35rVJVqPMNmHKerW12mMfQ1xccpPMWT47aViZq3GL
	ljnXnrJlnpG115+V+12EOf/0MC8ILxNpK/E0TTZAM9BsC6m6+QnNx3ZFx2wAzXXa
	eAvvbruw4IRMLksBOMwDqBtycD+qJbfbzCC0HaOBsNO76i3/9mKETwPNFFSYTfRx
	eKTopneJHoCOuae4udVw0q0pnwu4HNfV41BmOi++OsS1gpN1oy/aBFE7qbZrDNQy
	Bld+5tXksxnX7acT7KhZg==
X-ME-Sender: <xms:7xHOaRXfw3z7OazykzXTX9_NkE40CnUhkAlFMZzEHQK5HXvDPd8ObA>
    <xme:7xHOaRtbwAGDUHsvc6npESszUdYsYl4KZ9S6QWbfk5Mxelg96RQE51dMImDJPxdkg
    oQwev1Pvo3b6qI6GVTr0CLGSn1dGrkM74eHXHC_zyJSv43uVfUalQ>
X-ME-Received: <xmr:7xHOaVUWeGVO2uTRBlI9ezgB2qun16BbME-y5tGUkwP5IKTZ9enpSlsCckOvhKByrgu9jfVp6Xg4542Ei_ciqBb30gOoUfICsXEnGtJ-uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohephhgvrh
    gsvghrthesghhonhguohhrrdgrphgrnhgrrdhorhhgrdgruhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7xHOacmgvMfiiFTmWhnDp-H5FPVqVMenSkj5JnvrL0G_VHiD3_RcVg>
    <xmx:7xHOaWYZ-3jwGDOjVTtcLv-in44KVPmTDfzCjff15ZL9t4JJwsaGCg>
    <xmx:7xHOaXOC49IcYZ7rXqDSPBCdqB2zMOoOHqhNMG1L9vvXNTaBXXUy2Q>
    <xmx:7xHOabYSV9tYfsOTOcnyVWDQQckqH5S-6ppLmcy34PrPZTI8ABFzZw>
    <xmx:8BHOafWuh9G30CZdRJw5mjDcKFYF9PBn5WFbhx4hMaBQrDKxRPukSr-d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 02:51:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id be293e9a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Apr 2026 06:51:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Apr 2026 08:51:19 +0200
Subject: [PATCH v2 2/2] t9300: work around partial read bug in Dash v0.5.13
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-pks-tests-with-dash-v2-2-cd7ab11dabc0@pks.im>
References: <20260402-pks-tests-with-dash-v2-0-cd7ab11dabc0@pks.im>
In-Reply-To: <20260402-pks-tests-with-dash-v2-0-cd7ab11dabc0@pks.im>
To: git@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>, 
 Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.15.1

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
2.53.0.1323.g189a785ab5.dirty

