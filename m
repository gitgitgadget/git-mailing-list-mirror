Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFA3227589
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623727; cv=none; b=Z8ZYpzi28If3zZMAgns07Rp/+rXHcqXSvY2QmQko8FS3YOGI/7Pu+fhxILHvEEQHA+ny5ar65CnY1Dl7r9kETSmZ4/zJgwlUfP2q7nviLmZxznzk9JEWzQrJRa0kbLqhzMPhiVn2DtsO4yOyk/g1kuB94y6FnTbMHzpwaRD9UT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623727; c=relaxed/simple;
	bh=PK6OjpOg+HBiAkOOhVC6TG2eRRN1rNuiUzOnej274Uc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fTsilPqHGSqS+3df0LsPWXSwSEa0j1f9eFSGyhA+8bUGC2jhBblQfvNoiiKlljaXtk6C/Udy+07I6rMzrc4mMrdc6ZmJgNo/a4mMZt3sxbewKJnD4YtwK7evVL3Z996LpfYVc8bI7eVQiEkLfb1eydevF9y5WBAeiUrgCqqgHS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YLpkxG68; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UpVLTp7l; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YLpkxG68";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UpVLTp7l"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 77FA31380251;
	Thu, 19 Dec 2024 10:55:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 19 Dec 2024 10:55:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734623723;
	 x=1734710123; bh=GOx9AMRe7bNZ9/oIGNXHSS46PctYoQ3j1/fFTQ8iGOY=; b=
	YLpkxG68VjQQkQF6gvswawJtPorPge/wQYZklLybCveY31jrHmd4OlvMOeKBJcvx
	kgCgd3zEYU4h3e03Jw0ocOHO8ZihXaPa7NrVLEJINkZ46BNHFAWqoIVpeRpftur3
	hM2/H6fgEaok3Tk072+5q9n+KlBGqtLaCcKReDGuSQGnx0sOEtsR9o9ln/wgdf/U
	0R2snZw5L4bh1FI2FPDogU99lvuWZBANEXG4GZOF3ksi5iiwjw730HaWPkQt7E3q
	DHhtjZXzcsTIb+YEqImM6DUVleuWf112jYuiubDZ3R1ZemKh+S61ZX5LHJCgVM4G
	ljVV0qTSd7LyQC8LEY16sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734623723; x=
	1734710123; bh=GOx9AMRe7bNZ9/oIGNXHSS46PctYoQ3j1/fFTQ8iGOY=; b=U
	pVLTp7l3tf/+trnQSb4jnfHu5xswjyjnkIpscUWIuHw/cARN0u2zaF9QUjQ8D8v/
	aiqbFiPjPnFVZHj4bniawf90JitSwSHfubO5P8yMqU09yRVePxhB2tyfTi/tXLOR
	pq6mdeIFkWMKHDQJHnQZwk54gJLofr0mrVp4YxAovoaa2+kjQV6c2pSTdC0cmgE0
	ZIHCBEakQAu1eHzB39aNq3pZAjX8wlEAcI85+nZWtG2OHRzSTE8PcPPlzRdKmIGv
	nJMRB5UGyJSEaBMcCICGWnvbLHdwF9GwqNWhI1zD9JiygT96BrBsGk/5WMQoIull
	vgPpc6DUAFXkKs8iJD1MQ==
X-ME-Sender: <xms:60FkZ4IejRs5IWon48bC-wCPSrK6exM9fsJSzm5K0WKNbI7fZm5s6g>
    <xme:60FkZ4LlTKhDnHEg-P_JgtNBUm_W8jae2kgHY5waze29w43f85odb8_YvjiHrRCqO
    ImR7kr-YesizSOzXw>
X-ME-Received: <xmr:60FkZ4vcKAbOCU88mtB-gzw715hGxpG81hPb_VvKCQy_GYppi5Fn5Jr2SSzVXrCI7X7VbxvNsb8xZuw2-qumIG14NeSdvNZUyEuID7iWJvud174>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddttddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    phgvtghtrhgrlhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:60FkZ1Y1knRYh-hxed_KSF6IFoJYgEB5gpEO_zr_M2JgWo9-ox9ACQ>
    <xmx:60FkZ_a9t_ku4EIw2xBno4OC6o3UuPoZLNKQIzh8NHmFw7weF-wMUw>
    <xmx:60FkZxCClVtNT4sS69agwZt8L0EunB_-A_uONrgdLftxt5tPp8ob5Q>
    <xmx:60FkZ1ZS4IrQlU3k9ihI7U2Jup8pK9z23qUWl2XsAeb_HflGy2RG5w>
    <xmx:60FkZ-WVbd8Q8atbM7bpvn7dYYyVpwJaFeA1XTbei2_TBo8oMSpOiLye>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 10:55:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 45315913 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Dec 2024 15:53:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Dec 2024 16:53:36 +0100
Subject: [PATCH 1/2] GIT-VERSION-GEN: fix overriding version via
 environment
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-b4-pks-git-version-via-environment-v1-1-9393af058240@pks.im>
References: <20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im>
In-Reply-To: <20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kyle Lippincott <spectral@google.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

GIT-VERSION-GEN tries to derive the version that Git is being built from
via multiple different sources in the following order:

  1. A file called "version" in the source tree's root directory, if it
     exists.

  2. The current commit in case Git is built from a Git repository.

  3. Otherwise, we use a fallback version stored in a variable which is
     bumped whenever a new Git version is getting tagged.

It used to be possible to override the version by overriding the
`GIT_VERSION` Makefile variable (e.g. `make GIT_VERSION=foo`). This
worked somewhat by chance, only: `GIT-VERSION-GEN` would write the
actual Git version into `GIT-VERSION-FILE`, not the overridden value,
but when including the file into our Makefile we would not override the
`GIT_VERSION` variable because it has already been set by the user. And
because our Makefile used the variable to propagate the version to our
build tools instead of using `GIT-VERSION-FILE` the resulting build
artifacts used the overridden version.

But that subtle mechanism broke with 4838deab65 (Makefile: refactor
GIT-VERSION-GEN to be reusable, 2024-12-06) and subsequent commits
because the version information is not propagated via the Makefile
variable anymore, but instead via the files that `GIT-VERSION-GEN`
started to write. And as the script never knew about the `GIT_VERSION`
environment variable in the first place it uses one of the values listed
above instead of the overridden value.

Fix this issue by making `GIT-VERSION-GEN` handle the case where
`GIT_VERSION` has been set via the environment.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 GIT-VERSION-GEN | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index de0e63bdfbac263884e2ea328cc2ef11ace7a238..787c6cfd04f0a43d0c1c8a6690185d26ccf2fc2f 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -29,7 +29,10 @@ export GIT_CEILING_DIRECTORIES
 
 # First see if there is a version file (included in release tarballs),
 # then try git-describe, then default.
-if test -f "$SOURCE_DIR"/version
+if test -n "$GIT_VERSION"
+then
+    VN="$GIT_VERSION"
+elif test -f "$SOURCE_DIR"/version
 then
 	VN=$(cat "$SOURCE_DIR"/version) || VN="$DEF_VER"
 elif {

-- 
2.47.0

