Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9484C27CB2C
	for <git@vger.kernel.org>; Tue, 20 May 2025 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747763894; cv=none; b=BQdhgEidlcvmfJ6UWLoF/rRGRqy3lBv8MDqjexDH1sKbGuwFPY8Ey9atbG91mmu4C0itr15Q4LvTJ4lrhcMmXkq0SoO6HoU4rJJf+4YO2NcQZ9+6BJLuPHEF1cH+Hqgi5TrEbtXQGzE48FHd08OOGDs3V+BXXFy8e2mnZImbPuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747763894; c=relaxed/simple;
	bh=0OA3metDEtvIcw0CA8Vmv5buxw4sEHxrmvYKwEx3u/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ig/UWxghCbSw38qpYql5a9e8TpNwlENZnAIyEUKnqByXZmkz2v/guHZX2snNZoErTB4+KOc+LqKvSiaRiTIwEzBROJcRTKQ++rxXMTrt8EpzpbFUCdoMQGHqdooCXN6Qc71aNVl1tR7O7etzRxnsLQqgN0BVq6V7VFccA1NFHC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=rwWVr3Th; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YCMBRgyg; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="rwWVr3Th";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YCMBRgyg"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8417E11400F2;
	Tue, 20 May 2025 13:58:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 20 May 2025 13:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747763891;
	 x=1747850291; bh=VpVdpoVTy2XWWkiZJB5OWfDUGbcSZhb3cboz/l0lJqI=; b=
	rwWVr3ThQ4FhT5MmMCD8RLgvHyweT8HYTbhvgGnM4SwPrgbvuGboOOgLq9kdLo94
	Hstd6jDQmYD3i0fOSQ6hwfR6JX0F3f7ImWHZKok6eczTjhx2NUV37+16IZNc5y5J
	142w4yi/d8g9Hxgwq9GBsb3SolqzOTkSYIRiXvNaO+BB+2MK2hD73xG1kO/yYV2Q
	DcJpfTKzrCHDMQioY2qWcrtsm3Qk1uwP3Ff+jzmFVPt/oaTK+2M8RNAY7fTa6xKp
	Rbd5YMtFPYQH7P5CctnJDgqFHjwmVQlhZ8bpIywgRJdGlIOstkI1h/0bhjArpv3i
	1zxSWYKwO915I0v53+8TrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747763891; x=
	1747850291; bh=VpVdpoVTy2XWWkiZJB5OWfDUGbcSZhb3cboz/l0lJqI=; b=Y
	CMBRgygGUe6cPifP9adawuDmIbIMyvc81M3gTFcATAee7Dr+BL39IYRW3d2dF9Q0
	hHL8a0nljOvU5l1n3YiZtGtNmZehPJAhPC612rxmDIArhomFShwTuY0r1elFJUZy
	L93KcAEdnUkW3mgxhCbBXPw3IfF7C531SBkLaWYoyOLBslsb4hcb9NNmOS6QqtzB
	ANKFtkxb0/bSZJSu5X92QqDUo38Sh9Z+8Zi1tFDmykM0ACjM09+NFAZjsnII/iAG
	7lPTUyUf0Kh3BIco0Y4ngTIrRcD0op8dg/DKoVYRuP8Q97Wwe/XtM/5XKxKhanQ6
	u2ZwGN+5J2RzA4FWi3VYg==
X-ME-Sender: <xms:s8IsaNa428q2iefSNPNwUPTO8CKsWodlUX83YkmgdorHYa89AOQV6aQ>
    <xme:s8IsaEYT3AjJOq6ramem2mGUv0sSZ-xPkTCVaEuBfvXmGaaHfNSwgbFifDt4ZtoR_
    jwQjcVUq_heRMBtiw>
X-ME-Received: <xmr:s8IsaP9w7e71xDkBaDZCenelGReAzgWNLxSsR3GVCU5kTtBOaSfv7mTrv-04wbyued6TcRMGAlNSJyxGghzytgxW9McpnQGvkTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdekjeculddtuddrgeefvddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghn
    shhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtne
    cunecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtf
    frrghtthgvrhhnpefhgfeglefhjeekgfetleetjefhteeiheegfedtudduffegjefhkeet
    udeggffhkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhs
    sggrkhhkrdhnrghmvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepugihrhhonhgvthgvnhhgsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:s8IsaLqilaATaQzbAaxRwAcZYj5JDqUVulccH8ptIjuS1ShSgWJKwg>
    <xmx:s8IsaIoppVuuvS9d9WczD0a1xxTkLGcQlCOpp73ScHAitpZRQwT99g>
    <xmx:s8IsaBRIw-Bz4HTe_Kwsh51aQW5sPQwdJ4LmDHCMHCTnK2adbfscAQ>
    <xmx:s8IsaAo69WIQ5Kwe2Po3UCNmnxqB3Kc85Rqk_NwFgeb5jD3n9Gl4nA>
    <xmx:s8IsaKjA2V_YYsMvVBcjgeTf1v2UapEwCCWVFw2hbPWUOssV8M66VrZK>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 13:58:10 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>
Subject: [PATCH 2/6] doc: config: mention core.commentChar on commit.cleanup
Date: Tue, 20 May 2025 19:57:20 +0200
Message-ID: <b43b78aba63fe89fb0e85754f2124f96f3af01dd.1747763769.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.780.g892193c3f50
In-Reply-To: <cover.1747763769.git.code@khaugsbakk.name>
References: <cover.1747763769.git.code@khaugsbakk.name>
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

