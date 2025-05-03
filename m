Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DAF27466
	for <git@vger.kernel.org>; Sat,  3 May 2025 00:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746233903; cv=none; b=qeJLYHGsCZZrzMYclt1OIJnTLdUtN0/Hi0k3Iz7vzR5dlWd3MsvJpNcZEMTLED8g8HOP/UZJGQ6vb3u+btVQI3ZhCPxgdi7S9AkAvUNgczhGLGwq+v378lexEAQUvf4K3OKE8h8/MBGg7Tqz3C08NsoiSmRWbkxx9MPkIxFSoHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746233903; c=relaxed/simple;
	bh=w4pzMagaVbpP9wDOjJXu/Q4bZiIqDFTNsmIBF59rrcc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pIiYSaLD/x9uKj3hyqmwuc/PvdC4dDLp+aAXCGejdxwR4Apnfp3Oed5cGMytMEt3QM4xpts5X/VrlWRfB+NAFF66omeY1zvmR63zsuD6+FYCoFSxYCcAeawuFK6q/Hd36HiSPT2hb2ySfSKhW2vXkg++n5BT3brepsD66ueebp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wi5hQFfw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CGlCE80o; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wi5hQFfw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CGlCE80o"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 06D501380517;
	Fri,  2 May 2025 20:58:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 02 May 2025 20:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1746233900; x=
	1746320300; bh=zv4CP5AyL3jWZ/kG/W41NfP4MhLjhY/ZFoczK7is4SU=; b=W
	i5hQFfwgiyIj+tn0jDQMgNXVIbNiXRoyIAVr1Y0ubTCjBpnEp9QoqnSBYW04hVcZ
	uisDg2onGt9bml39RkSMEZW/kNIsnjwCynR6txzYzaGuMH2Wzhk/Ud6n8ToD3LXV
	Jl88z9REV/fJ6kV2Hlj6rr2Tx1w9n0ILjdsN/mf2is8jj5cW5GMFdGRoEjwFm011
	mcGPG4R4FBeGhKJVTFBMfOy6U1GayI+nOwmmYHdi+UUXE7cHyM/PlFGNDzK0gZHK
	BnuTKjRg26RgRJMCU6/FiIu77SOzvR3/C8qqo7fAa6yP7e9U7uHt0+0gn2fXjMzE
	yZk+JChPr3YLobDbaR53w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746233900; x=1746320300; bh=zv4CP5AyL3jWZ/kG/W41NfP4MhLj
	hY/ZFoczK7is4SU=; b=CGlCE80or1n/hS6JzVT7x3+8unn+wKnhmHTX6/bqpY7W
	MYdQ8OphT1fhkEPeLP0SroHj4ginp8DLpj+18ozr3tiOtgL1c/ks8xujVHLGMDaw
	882ujknGwqMMnq9xp8vstcXvNCfdBv0eDaE/SRjJtHZfGE/6WtGqyLAYVyehiX6B
	ifBZyD0S/rhLocYv0r4AmzpRubF/kabvHpQxOPUswlRoyPdumw4fJYG0Cn67X4aE
	ZEk8CoWq7U84LzWeQrEA5a1Nxc9ySrNk3z9eVjC2+17N1hqKRTXYcFYac07NGhFf
	TfqBeDCXd7UaEcbLHlo+F+ixEaLPLSCfjRbgPUULyw==
X-ME-Sender: <xms:K2oVaJiYOUagYzUeZut3VngAf5Shux2UI_TBskhSckyM8a7pJWsrlg>
    <xme:K2oVaOCktGlKrVEUV_0jTPVP64WxYGbDA-S5H2vGypoiwhKXW6qcucpal67US51-n
    vrzONm3hmkbuK078A>
X-ME-Received: <xmr:K2oVaJHL64MFlW_IzEJ9pOGrOkeaFbUjIFQMi70cTJbxT3MY-tNi4WDCgxhwYQM7pgyvswUL10URLUaR1KgSRxModRW_x5hmQ_ZT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeefleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:K2oVaORe2bCIKi9F9g2jNWyqFa42QE-DHsmpG-pdlprVQgS3oNNZZw>
    <xmx:K2oVaGwDQgbe8D9hWtInuHuYn5gOPyzdxp6SZ4CKuu6wNJQvhiAHew>
    <xmx:K2oVaE4ZpUmQAmw121usiKTeBh33HCkE8MULntEPq2s8vWRaSFI-CA>
    <xmx:K2oVaLxrjRqVl3nJFz7SOg1xyoPBVYETEmWJ0Mq3CxzSbJgebTUjlg>
    <xmx:K2oVaNjenqNWDelwyhiekDZwthRiGILX_ukkCTwd5Elua7z50GFDaUad>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 20:58:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 2/6] doc: prepare for a world without whatchanged
Date: Fri,  2 May 2025 17:58:10 -0700
Message-ID: <20250503005814.3030099-3-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-601-ga5925c3955
In-Reply-To: <20250503005814.3030099-1-gitster@pobox.com>
References: <20250501225958.2947677-1-gitster@pobox.com>
 <20250503005814.3030099-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These documents mention "whatchanged" as an example, that can be
substituted by something else.  A new hypothetical command "walken"
would come near "whatchanged" but since the latter may be going
away, we can say it would come near "version", as the fictitious
command sorts between them.  Similarly, we do not have to use
"whatchanged" as an example of a subcommand that is also implemented
in builtin/log.c file; we can instead mention "show".

Both of these changes allow us not to worry about adjusting these
places when "whatchanged" is finally removed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/MyFirstObjectWalk.adoc | 4 ++--
 Documentation/user-manual.adoc       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.adoc b/Documentation/MyFirstObjectWalk.adoc
index d6e9dfdbbe..102a465a48 100644
--- a/Documentation/MyFirstObjectWalk.adoc
+++ b/Documentation/MyFirstObjectWalk.adoc
@@ -83,13 +83,13 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
 }
 ----
 
-Also add the relevant line in `builtin.h` near `cmd_whatchanged()`:
+Also add the relevant line in `builtin.h` near `cmd_version()`:
 
 ----
 int cmd_walken(int argc, const char **argv, const char *prefix);
 ----
 
-Include the command in `git.c` in `commands[]` near the entry for `whatchanged`,
+Include the command in `git.c` in `commands[]` near the entry for `version`,
 maintaining alphabetical ordering:
 
 ----
diff --git a/Documentation/user-manual.adoc b/Documentation/user-manual.adoc
index d2b478ad23..7124345966 100644
--- a/Documentation/user-manual.adoc
+++ b/Documentation/user-manual.adoc
@@ -4240,7 +4240,7 @@ command `git`.  The source side of a builtin is
 - an entry in `BUILTIN_OBJECTS` in the `Makefile`.
 
 Sometimes, more than one builtin is contained in one source file.  For
-example, `cmd_whatchanged()` and `cmd_log()` both reside in `builtin/log.c`,
+example, `cmd_show()` and `cmd_log()` both reside in `builtin/log.c`,
 since they share quite a bit of code.  In that case, the commands which are
 _not_ named like the `.c` file in which they live have to be listed in
 `BUILT_INS` in the `Makefile`.
-- 
2.49.0-601-ga5925c3955

