Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A721E47DA
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502945; cv=none; b=tGeW/AjyCmFfh4f2n8CKCcJ8gkf0RhPG/C7cEvASO5lYF/NphfCR4LhQD1aTGmk/IYDZ3F92fCJJ/z9hCmZFKJJwS/geEPzMnDbp70IUZkYXHe7iUKQZbBnnt9RAUuOGkhkbo8CTmS2CFSeJmCPNYaxAYmSXEUZVA92eML8fQkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502945; c=relaxed/simple;
	bh=LJ9+Sj8zD952kM4HrLaDrMhiVCGlDPFPW7u1hzyPoRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDBcYHYAUc3ZlwyZNJzetz6momu6zEUi/TYAj3gFr75QIn8+jcu7W2rFJVCFm01NioLK/8F2W2NLA3x0XiDKiriENYykJ86mKfVerTGDvu1JWtEYMJlbtOqne5sOLqlhSvUV40QpW0pKkMA7E0XTbL3faG8Fs5x+/zXZg2+RFEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=guoTF1+8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E2NPZ1BU; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="guoTF1+8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E2NPZ1BU"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id A985213800E9;
	Mon, 21 Oct 2024 05:29:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 21 Oct 2024 05:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729502942; x=1729589342; bh=XLCvzyic5h
	ngx5Lg6s8CN9+gHnWuecWTCs4DglQol6k=; b=guoTF1+8Muk0kxPAR6NVSCkOg0
	a5uz8IzkBkFEE7RRKNlWQxpCrx+JX0r4TPim75Vm/3ZHxa7JjimA6i6WMXbvoJ+n
	glG6e3ZlLnuACFzaKZBrPxdCKBZjw3w/jYOhefaFBorLCGO/6wCc51ZpCEl0TgLH
	szz8ti0kx8CXKrqK4LXZ/HJGtCAUrdbPukQkUqNLDt0qVRhk1ZhnYKSHCyjqQ0TW
	l99Vv8TldewFnv2S2TFv2WCO1eOjLGsnhG2iys8jh6ZKIEu1ZMn9PyWGmZW+MVO+
	wLd8BLa2RUyZm8oNwII6JEd7pew7/Elj/gOgKWR8Ivfa+xKZjwJs7NFo0K8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729502942; x=1729589342; bh=XLCvzyic5hngx5Lg6s8CN9+gHnWu
	ecWTCs4DglQol6k=; b=E2NPZ1BUrwi4dUIqAs85ma6dMp2nYreLKWaJBYKv1B01
	L7mQ8ZJZJv4e1OgTuXf0zozr3SNUBo1yDwh1aRBLNSNi2ok5GiPY1tZ8GzpVcOe/
	758B5RcI/MNO7p2HrmVWsk0izOymIVbLNONG2JaTMRvWxUB1AD2OpAAotHygdw5v
	9up+Ip2KuoAzcOg5nGKdKpo3ctpp0XkqjqXgU0Moc0rHgtzT7hai0MTStjvgbocF
	ef4VYumwqLAC1bNAM/jkhS7leZFWjdwyLtJv9jRDUt0Qgyi3MeuyzufvfVVc6fSR
	oHieA9vuWprfOoLheKAeIDr0uT/JQmHVvvPY+S4VXw==
X-ME-Sender: <xms:3h4WZ7c9TExzW5-RBtZ0mHBykTlMTHOMN2t6gIyhZZLjixr3TkTNnQ>
    <xme:3h4WZxPNktpoR3lOtGWWDRaa1ghlhAqfpkzeluOvmXTNa4JW49zJTMbg6S_LyIE2P
    epQvqMsdy4bJCqoiA>
X-ME-Received: <xmr:3h4WZ0i7pHP9yyqMa16BUDhUhvSL9cmLZdh5IAk1JB0pq_JbiX_BQrmAwqLBV2i4GvPNJIhH9amgBMk_78XzNj41xQYihUDf31FRcKnucPi6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgih
    lhhorhhrrdgtohhm
X-ME-Proxy: <xmx:3h4WZ8_ZqZjylV0if7-vv3i7L9mIP4sRJSuvBcvT9vzMRASI_k6AeA>
    <xmx:3h4WZ3t7GSNVWHChoxwzQJwdk5Qrmgxi6Oz8bL-MyZGI1H4lJbd02w>
    <xmx:3h4WZ7GxFNc22ObFPFJRES3pRxkZVUHhzAaiR1X6mhXMMBpHAJ4DFQ>
    <xmx:3h4WZ-M_PuvAnXnDyjt6TwRHDJeOm5RVck957pCDljXr07rF0oBkYA>
    <xmx:3h4WZ3I8RRdjTubDOEutAcTxWLQ5rTTs9276LqJ99_jibqhKE0QbV0UD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 05:29:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 167d18fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 09:27:34 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:28:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 19/22] t/helper: fix leaking buffer in
 "dump-untracked-cache"
Message-ID: <b8b702eeb28b384bc359c77964509fa105645eec.1729502824.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729502823.git.ps@pks.im>

We never release the local `struct strbuf base` buffer, thus leaking
memory. Fix this leak.

This leak is exposed by t7063, but plugging it alone does not make the
whole test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-dump-untracked-cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index 4f010d53249..b2e70837a90 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -68,5 +68,7 @@ int cmd__dump_untracked_cache(int ac UNUSED, const char **av UNUSED)
 	printf("flags %08x\n", uc->dir_flags);
 	if (uc->root)
 		dump(uc->root, &base);
+
+	strbuf_release(&base);
 	return 0;
 }
-- 
2.47.0.72.gef8ce8f3d4.dirty

