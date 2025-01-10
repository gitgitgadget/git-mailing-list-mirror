Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA52D20DD53
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513742; cv=none; b=ONt3hdn4Y08ZsK5qbBl/tvGYbUt1v7p7lTC0OOIrRQzveKaYRQyFO5C/v1gJKZDHM1NjlHt9MVq5YatEvohNV0REZWrbuTs9ckFZwtmV2XXsjpvyA2IBtMvtJeZdomw+nyFFD7LhMHI7xWPJwqFhyte+tbFOO0LR2AqxbGqR15g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513742; c=relaxed/simple;
	bh=VkGmP6dtna8AcsPGfi4wX9oGLHnNGeVUKdAxBiXayN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T6gBfQhYXLfHcWSGct6/VxpZHUnKFLmZpTCnEePu+9BCdp+6Hp8ky+PWkqXFWdOUjD/3k/msy7ulcLjQgNITLoP5b8xYPtsYEES6UZ20Ot9NgyEnZL98z5lkaCnM+vkIUgtJjpUyyeT2jqwlChfob8W0DrPnYe0vHPge/gFOfn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GmcUSqoV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EmdTO16/; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GmcUSqoV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EmdTO16/"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D9CAB1140114
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 07:55:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 10 Jan 2025 07:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736513739;
	 x=1736600139; bh=ScrNkVQUeuyxBdib3D1Kk/Ec/D4iPbHuoTN7kjIx73c=; b=
	GmcUSqoVFONUODtFUAwp1R2UNymJ5rmP7n+lx+d50YfOoI0IkWBZ20CaZfEi9BP/
	wB1ia1DVEmO9vJf8RHGFKlrsfEq+jO6FQAn8YqJZPs5ZdCiQHxPDbOxCIVrmSQT1
	UZ57yK5V5iC/+ExnC0S8sPYnkGG21f2jYuW4WDfU0P4QUDiAfaqd727EmWqhIJfB
	+E5cpAgvow+/KR6QJcAl56VaaIZaVNQGLIn2vMWFIRzwV5YUBlZiQmhxitVpPH87
	qj40rJRjwRo93Nqbhm5J+5jP0QwYnZmdqSnpFMxTrB809gcOFvVNjfLbhc8ubqRB
	wf7OEUBrAeSqneuwTJ2GcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736513739; x=
	1736600139; bh=ScrNkVQUeuyxBdib3D1Kk/Ec/D4iPbHuoTN7kjIx73c=; b=E
	mdTO16/WYUczfKwHnnZKVge1ZORHDcgccU7rNhB30e8Fc/irhxmeIpDHSjg5bstw
	vC0VO9Bd7CVbqMHg23mtnFEDEE7gLF+PaF4TuyO2q91sChn4RuzibOr9gpFt8UWm
	3p2jHvCDchO3TZUKeTjsADYg4VDc0b1GiubG2pGLUwkSUjAhsWdq3DyYHsuDPfgj
	7SaUYrZZFLTkPsVuB9cmCzD+7WBFGVCSlQpYh6BJ+JzX7nN4cL0w+1XPpsbqsYhG
	lgXwnXkKrcUGOjOWPXgVdUF9ICHtzwYqHAvbMlwH4DZVj9vhqFObPF8PtgHdTJYG
	ouk/gMw5YjU01x0CVBLRw==
X-ME-Sender: <xms:yxiBZ26jesrUhNHJWb9gY6XVGdl-O0470fRFW4Tz-yhcx-dCEYMgQQ>
    <xme:yxiBZ_6FarqegPZtySbEB-6Fv0xSaNNrwhzAJ-Jx1sEvWlFafkCMDapjP3YVeSwJ1
    zQovKkzP3qwsSz0AA>
X-ME-Received: <xmr:yxiBZ1eZRdVSIcJaqWxCkmoUW7WxhxAkuZqxF0kttkp6BfDyYTTAu0kPIz0ZZAhCwnGwZ0t6Be5BcwNZz6DxvQThEXIByTcXL4toG619Y_9uBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yxiBZzLgfWloYmbf3LsDLcouvKp3WqbIQOrZZEUGa_LOtwDuLPa_9Q>
    <xmx:yxiBZ6IlYUgTDmt2Y8GCR_-APpmCbN57BrlHZkP4Y1dEvU2L9WIZEw>
    <xmx:yxiBZ0wua8dm-VvvBhSZJdDutsR9Z8frXWHKorHxA_PDUPp0yjglvA>
    <xmx:yxiBZ-KP6Dxv7bN0SA-vgua8EpKrNvCLDlD89wNxMap1sEwA0gjaaQ>
    <xmx:yxiBZ8j_CVjTT8u_hqDE0MInhS-uei2Zzsup1eNHDY64APEm7eDbSknr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 Jan 2025 07:55:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2146b095 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 Jan 2025 12:55:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jan 2025 13:55:34 +0100
Subject: [PATCH 7/8] git-zlib: cast away potential constness of `next_in`
 pointer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-pks-compat-drop-uncompress2-v1-7-965d0022a74d@pks.im>
References: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
In-Reply-To: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.48.0.rc2.279.g1de40edade.dirty

