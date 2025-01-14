Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9932361FE
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855875; cv=none; b=jv8/geBDd7/nPxpD+M2ZdQoLS7cn3BNBKCRY///Z060/OAbCbzxAII9U25zf49edsBH8VbvyZCdkeVi80YsQ69dh5FerjNl2Hm+fJD6CKNByHnraZS1m6QEal16X5f94T57kR2usJL/AYogsWUtH9awtVlB0xfCTHAJWcjwmBXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855875; c=relaxed/simple;
	bh=pamU+jdlpLJBLc3lM+fpeFvXtzgjojwSm5VYyYQKPPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ceeZ0bLkQX12RRMyx98LvR878d12/yT83YTSACvOmNunAqhoKyNDS+dZJr3JY5SE/raaoQEW02/M9yfMII61ybTiTZ1Cgwh59+Qt+HMrDS2Uy6GPCnnkuWMe4MsGWWLukv4b/TBE5PEKYQO1g9OXZ8LfMi2/xNC0DRtzjmdJY8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pHgkYjr9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gW4w1ybR; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pHgkYjr9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gW4w1ybR"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id CEDAB1380214;
	Tue, 14 Jan 2025 06:57:52 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 14 Jan 2025 06:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736855872;
	 x=1736942272; bh=FzoirsCuTMVAtJ3tU0FqSdLHfmBIVZmFYB8c/2m+0Ok=; b=
	pHgkYjr9XG4Y5O5/Jy/t2aXcHqhon7yFoVOBVd8HQhL/vcVWYaQ4owV4/c55W7i3
	L44g/FL4Wn8r0P/R5mK67c/YgbMlHmcm4N5x/V/TI9s0Z8r+SAL+Gq849Ap7D2+2
	obC3G23ZmPyYHpl6g/qUTbsoH2wIROPR1Q8UVZFA6OUoKsz68yY6tFc8XQzijNfh
	a9TzApxh/ghhgoJlvflXGSmYW3c5XpJH/8UmCvlq/D72H/khCIKWAhRvq+7NVktl
	mgDKPcwKyi9hemyLL+Ny/ZiuOrf2nHq+1YTIf2sIjgvdHz002meGUYHQCnZezNGz
	7RI0Ary6x8Mlxff+ztgSvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736855872; x=
	1736942272; bh=FzoirsCuTMVAtJ3tU0FqSdLHfmBIVZmFYB8c/2m+0Ok=; b=g
	W4w1ybRu5IUKCPYyD5ivOIcC4Vf6G2it8WsfgKifV+7v6iU4TmaTFdQ6szJc6wgY
	zeQLa0ERqtmItGAfA9eUkRRHbnN3O6kMT9QRYwR4PRdkfa8Mnpg9js6WTlpDF6VZ
	kOW174jPVngdb6ee4mbEUTUlWeLIzijIBmpzex9KOMHDGAqlvDeWanpRV6w3XN+E
	JAPwT3byLVrQVxFj24nRPjjW4fuREkGM7f5UnmVSiQNdBZay+oClVDrwZw72wkqA
	jMHfSQsAUpADKWX7xT7oxX3jHzy5YbizhOCPnHtq2yq/0i9UJeLFCFVOldwop0br
	yTR10nxe33eyQUkNe7Fcg==
X-ME-Sender: <xms:QFGGZ7N1OV2-Spq-cCLthPE-EJ1fKb_c03HgsJ5rRnNPWlW2zWoBGQ>
    <xme:QFGGZ18LMFQXTSy8qOB4SQRhtba3Epi5YBi5P5zJIs6BagjaGuqAXQRDo4lYc-PVL
    CPQJD-kbZhGIpGO4w>
X-ME-Received: <xmr:QFGGZ6SJoNcA4FjugwT8KMY_duvX9nkw21RqkmhwmtvmKIDmsT40itLzIoaN_dbooqlgbh4U7Q1mW2tBtX4rXJtDzlVoB9LkUzlvXDA4NUkShw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhm
X-ME-Proxy: <xmx:QFGGZ_teF2uae9cTARxV_POVib36Ysdu7Srk5ICnhlYQlEAv27Hxnw>
    <xmx:QFGGZze38A1WA9Z3hRlw4KFhUUnksizRYRDH9xz7p4UsPy_Qjy2Y-A>
    <xmx:QFGGZ70ItE16rIZIHZIhkSSFqFFx5YvTGfSA4psLjtrNWJnuccgihA>
    <xmx:QFGGZ_8XWzw2RFBtMj7J2HF6m-P2g9SihUTMh53rgUv1b_zKrJaxiQ>
    <xmx:QFGGZ0rUkK6NuutKIvFmz9_9AjOFgFEFN-PdBChpxFnqUoVCvKF4EGoC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 06:57:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6d764818 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 11:57:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 14 Jan 2025 12:57:48 +0100
Subject: [PATCH v2 07/10] git-zlib: cast away potential constness of
 `next_in` pointer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-b4-pks-compat-drop-uncompress2-v2-7-614a2158e34e@pks.im>
References: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
In-Reply-To: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.2

The `struct git_zstream::next_in` variable points to the input data that
and is used in combination with `struct z_stream::next_in`. While that
latter field is not marked as a constant in zlib, it is marked as such
in zlib-ng. This causes a couple of compiler errors when we try to
assign these fields to one another due to mismatching constness.

Fix the issue by casting away the potential constness of `next_in`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git-zlib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-zlib.c b/git-zlib.c
index 2e973320c232438cce7c83e25cc60a6b773670fc..519b3647ac8c55e66b00f46242a6e17fe6b600a1 100644
--- a/git-zlib.c
+++ b/git-zlib.c
@@ -59,7 +59,7 @@ static void zlib_post_call(git_zstream *s)
 
 	s->total_out = s->z.total_out;
 	s->total_in = s->z.total_in;
-	s->next_in = s->z.next_in;
+	s->next_in = (unsigned char *) s->z.next_in;
 	s->next_out = s->z.next_out;
 	s->avail_in -= bytes_consumed;
 	s->avail_out -= bytes_produced;

-- 
2.48.0.257.gd3603152ad.dirty

