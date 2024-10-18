Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271CA17798F
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 04:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729226179; cv=none; b=kibTxyLZdHqwE5MY+QzJ5zITcT71FrwWLtaSuPiI967lsScfT4zUFeOs726msiaErJmaI5wmk2VBIHgjlpiEIf9u7CuSMdwOhcD+nGZ0o+h+qBRxjBuHtQ63nJ5ilz3nL9ONok8aizBgs2VOrciR2hlHkgn/z6vaHIAJfR/cI2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729226179; c=relaxed/simple;
	bh=Dy7N1mSFAHrFyJephavVf4QQL5SUncZ2Zk3vXeTyLwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmTt8itEohf67BytNwGSv9NL+Ae1716zSisBcWTxyF6Dhl1Z88BVojX8lyykplrhXYJW/rXWa0Rj6esinI5yhN53BH3j+PZfMD7jJy+vAuLgn0bB+vhHK1UsnDJ0qGlVrRN+mcroAEafjGWc1ST5XdKeLVsj8qL/KoV1Mei8k8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pvLbxrq3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SFGiuDSd; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pvLbxrq3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SFGiuDSd"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id F3EB01380269;
	Fri, 18 Oct 2024 00:36:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 18 Oct 2024 00:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729226175; x=1729312575; bh=9WXQPK0wkn
	ypaSWOVsXs9CBCnRkRurqEGo1vh8XbN2c=; b=pvLbxrq35IqPwJl839X3gNPDwu
	pGMWlMNYo29zLi1ASY1RYZZ167VCDjn/QXQV/QgOiom7PRScmfsQuZBAEY1u8FYq
	lPeSTNkEnxKjHNl5QsRAQc47EKTJzA7NZf+yloFOshxd+YMozCMwcD469cuj9LZY
	cGM82/CPH9pj7Zhdfc7ZFAQ4xuCcFiZoKZ4s2QTa9auYHYVqy1SWlXrpfT2kFU7J
	+WpV2VVM8+cIEqWwjg+RdWIOTrvm6g6S9bnHqpzQR15H/icbO0W0OYSL6PbfCW8e
	T1StCTF1PHrE+FC2N+Kh2CzRm0L8aK9YoF9/SNYyedIqu1fOnvm7gyJrTmSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729226175; x=1729312575; bh=9WXQPK0wknypaSWOVsXs9CBCnRkR
	urqEGo1vh8XbN2c=; b=SFGiuDSdcf2yMXZOjM4V81adbBPE9lQr9gGHF7u6tL2V
	uEymfS0UBfycWZBMzMS9JnFcSmTWNGy6Av/IWWHnsaPb12SzJ2Y6wbwVHdwTMRR4
	1i4EQtd/WRIJe2T7+QR7TK0FHr+7aQ4KnxAEQ/xZHAyQjegPp3t4pzz3QIPsEjDy
	m5XXa1vyShtZMYAj6MOUGrq85ZczEpCnX+kSPjUeZ4KeiTmi/EH3SNuf2gh27DfF
	DZm0Tfj8DPj1PZcN3qrsIGtEigmRdQh4wrLEnXabJQ2dvwMg+tc1LvrSeU9CHKKt
	6ahnhLT0rnKS3vAiTHSjnvGDLoVcd0NHMPukOlbfhQ==
X-ME-Sender: <xms:v-URZ_BaRFNkrRPR7wroQGPhoBGuOzqjFXOaJ_fciJwps94KNSOaZw>
    <xme:v-URZ1h0BBvb2JtSRvP47qtSFreKuFMq70IRbZkXlREKzh1dbjbrtzHHpRfDWlgwu
    nOfQsEEqmsat_RR4g>
X-ME-Received: <xmr:v-URZ6nx7AmIfFpKoZVqVGQN5J0Z6s5cQkPSeE5HclcQYgeplPGFm7kcgFYfRNcjVl__Hz0GL1Hha7ZK5f050twT0DwieRjKhEj2cKB4IoHK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehvddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepgeejieelffdvudfgleeuveevkeffjeelhedttdeuleet
    vdffvdefledtleekveegnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvg
    hlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtoheprggurghmseguihhnfihoohguihgvrdhorhhgpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjh
    honhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:v-URZxwnsLWScFjkmMI0SWndONYfVIr0K-y8z68poy6dYszaFehjdA>
    <xmx:v-URZ0STNzGh8P11kCGaZr0rvB_lWIMUQ_Bovcqu5WOdhbqkQj_0BA>
    <xmx:v-URZ0Zojx7KU0OYmUUgw9xZe7Gi5aG4xDyOnKAKEhadCdcyOamQrg>
    <xmx:v-URZ1Tb4yEx-DtkhlHA_tHjIfauLonWuqjTwhw6_UUu7mCGXDjnvA>
    <xmx:v-URZ5KtNY5-yy2L5GkU6IoW75Nlhi5wizuqPeq_kTrY7Pr77DSknyTk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 00:36:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e34c4f97 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 18 Oct 2024 04:34:51 +0000 (UTC)
Date: Fri, 18 Oct 2024 06:36:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2] builtin/credential-cache--daemon: fix error when
 "exit"ing on Cygwin
Message-ID: <658fe4fa540a0a5316e11ed43f9139d5ef818ee5.1729226155.git.ps@pks.im>
References: <a4472d6d1551e7c25540c4c8361bcb6b1c9f92ff.1729084997.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4472d6d1551e7c25540c4c8361bcb6b1c9f92ff.1729084997.git.ps@pks.im>

Clients can signal the git-credential-cache(1) daemon that it is
supposed to exit by sending it an "exit" command. The details around
how exactly the daemon exits seem to be rather intricate as spelt out by
a comment surrounding our call to exit(3p), as we need to be mindful
around closing the client streams before we signal the client.

The logic is broken on Cygwin though: when a client asks the daemon to
exit, they won't see the EOF and will instead get an error message:

  fatal: read error from cache daemon: Software caused connection abort

This issue is known in Cygwin for quite a while already [1] [2] and
seems to come from a change in Cygwin itself. While we haven't figured
out what exact change that was, the effect is that we see ECONNABORTED
now instead of ECONNRESET when trying to read from the socket connected
to the daemon when the daemon has shut down. It is somewhat dubious that
errno changed in this way: read(3p) does not mention ECONNABORTED as a
possible error code, so the behaviour seems to not be POSIX-compliant.

We have discussed a couple of workarounds:

  - Explicitly close file streams when handling the "exit" action in
    `serve_one_client()`. This may easily lead to races because we need
    to be very careful about the order in which we delete sockets.

  - We can adapt `serve_one_client()` to not use exit(3) anymore, and
    instead handle the shutdown in the outer loop. This allows us to
    handle the shutdown elsewhere and be less intimate with the calling
    context.

  - Start handling ECONNABORTED.

The last option seems like it is both the easiest and least-risky fix.
It is unlikely that it would negatively affect any other platforms given
that read(3p) shouldn't even set the code in the first place, and it
fixes the issue on Cygwin.

Fix the issue by handling both ECONNRESET and ECONNABORTED.

[1]: https://github.com/cygporter/git/issues/51
[2]: https://lore.kernel.org/git/9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com/

Original-patch-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/credential-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index 5de8b9123bf..7789d57d3e1 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -30,7 +30,7 @@ static int connection_fatally_broken(int error)
 
 static int connection_closed(int error)
 {
-	return (error == ECONNRESET);
+	return error == ECONNRESET || error == ECONNABORTED;
 }
 
 static int connection_fatally_broken(int error)

base-commit: a7c6fbb48a5849db1bb1f841ef5403476fed0c0e
-- 
2.47.0.72.gef8ce8f3d4.dirty

