Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4A518952C
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687641; cv=none; b=RWl3ZteM13wit4gFotwXw4AYSNEAhITiDc2zrH408DS1JoBZ3FWQ21cakw6WSFLl8EJeRgJJqz1GpsyYd9R8frYAi1t4z0FFqVFnBmKfkJa6K//mpBZTI3t1rtgbn30G3w2kwRcIV4ZgenuSIRmcftp/sB1pHeG3sIkFyBTMSAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687641; c=relaxed/simple;
	bh=ZcPOlwEC9nSBhPwsP/uHloMq6nfrynv1PXipBWbuUn0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfTNIyy+8mkVXoukZqmb1KmGjvos9Q2KRxvjMs56ZxtSf9lTqmwDXFDfo1aralTBJOBYhbdr0QIWSGPAk0uaX49wXLkBA7ZIoU+qHh+bXhcKiuAL/2fC91EW09SGrYZw/9arWrzfSNS0mCZg8hiCIcFy8WGZ/sZyJ5KR2eUomW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F/4SfSwb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OImCSifP; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F/4SfSwb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OImCSifP"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id E177313803A6
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 30 Sep 2024 05:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727687638; x=1727774038; bh=PkFfBejS6v
	yN6U5GoGafXYqQGc9rWUArLvkUJKidIq0=; b=F/4SfSwbMMg6txwMiR7qQzwy5F
	1vs/Da1seaqRO7E7OjOfjgJUDoKM1zwf7soek/7fubBzIEMndGFtuT8m7rzPGezV
	NAxbgDGGMTa0+z/qWThfHil+ea/c46luJa4/4R1QozZ73SY1I++XWQQ80TqBKqau
	EMV4mrE9oaRnxZW3mcgERvDu46Y/J9frj8DFtszFbvcbw7HoJ3w+AY/JfhRiUp9n
	WiFYAbFJp2t9RByYB4pf5QiyRofrsPvxa9Mu05vgmqEtGvrgp98f83mhrk3L54In
	iIcQweZk1YwPfcaDc2wt4DhhDamOks/Yyd/eKtbWROO+51eKas506rTt9HHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727687638; x=1727774038; bh=PkFfBejS6vyN6U5GoGafXYqQGc9r
	WUArLvkUJKidIq0=; b=OImCSifPn2pkWFKC0+x7ziI0ddlTzucM99rM++3ONHYA
	jJ4mjqYbzgxer4iE9jDv+Sd+HJlYdTXtRCcJ+TZWZ2LeZTDsWD4v7DYj/E8kZA42
	iu6hIAgDXCbB29srZqKgD7jHFuCGkLfwlmtOqfd/CNSt4P7Z6bm2YRANV5K0gGZU
	NldpySc2swg/rfnfh+QDDRbzi3gWs+UHzhenTrerYfD2+0WM8W7WbpC/WL2Msm3Z
	bsCIyMwIgNeiCFTkOCi+9hnZGxzU3G7EpEOUd6mwN/VN/8VOo0orseJ6BATMdGB5
	aKdeEKR1rZYDwj2HZvvxCh99XBT/yDMgO5D2quKxag==
X-ME-Sender: <xms:1mv6Zi68R1QRqMkSdTSjhHzUenqtjsj5zQo2TH2R8ekXRLtemaGTIw>
    <xme:1mv6Zr6P-vt3QwI_KiwY-563XTRnBZgtGQ3zBxyjSKmfRN6VsP8edmbfK0qzIHm3j
    V5WEGUPdEaqRcgT7A>
X-ME-Received: <xmr:1mv6ZhdAXKVVkQ8ndq9RSuCZ8Qrxq2H0TidXKeTMkUICw13Rw4sHuCQbfRj7RZVXlZkSdtmcYFgFJqjC1pu7UtEK8GaPn4GKJaxzdzRrkvibn4E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1mv6ZvJf85WeK1jmZWt1FceK4Gyjt8VZh7ayZztSPcv2b_Cw3VttTw>
    <xmx:1mv6ZmIKLwzJagTxSuckiMphCQfsuknSQ8IQORDDP4xlhK9t147-_g>
    <xmx:1mv6ZgwUmoKbWblVcKUp97px9K-eGsQmvUP2Rc_Ue43u7m66ZELBjQ>
    <xmx:1mv6ZqLiSl_OkZtuKDqa_NzGl0OtYs23PexkntE45uc2VVOl3zFxVg>
    <xmx:1mv6Zoi3R8RnLj5r6xnGJQzjtiukc33aBvT5FV_xuZKviLvqmOkF8br8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id be0a461e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Sep 2024 09:13:12 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:13:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 15/23] pseudo-merge: fix leaking strmap keys
Message-ID: <9e1161d55f96253bfeb5cddd1bbd381e2dad8a71.1727687410.git.ps@pks.im>
References: <cover.1727687410.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727687410.git.ps@pks.im>

When creating a new pseudo-merge group we collect a set of matchnig
commits and put them into a string map. This strmap is initialized such
that it does not allocate its keys, and instead we try to pass ownership
of the keys to it via `strmap_put()`. This isn't how it works though:
the strmap will never try to release these keys, and consequently they
end up leaking.

Fix this leak by initializing the strmap as duplicating its keys and not
trying to hand over ownership.

The leak is exposed by t5333, but plugging it does not yet make the full
test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pseudo-merge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pseudo-merge.c b/pseudo-merge.c
index 28782a31c6..bb59965ed2 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -87,7 +87,7 @@ static void pseudo_merge_group_init(struct pseudo_merge_group *group)
 {
 	memset(group, 0, sizeof(struct pseudo_merge_group));
 
-	strmap_init_with_options(&group->matches, NULL, 0);
+	strmap_init_with_options(&group->matches, NULL, 1);
 
 	group->decay = DEFAULT_PSEUDO_MERGE_DECAY;
 	group->max_merges = DEFAULT_PSEUDO_MERGE_MAX_MERGES;
@@ -275,7 +275,7 @@ static int find_pseudo_merge_group_for_ref(const char *refname,
 		matches = strmap_get(&group->matches, group_name.buf);
 		if (!matches) {
 			matches = xcalloc(1, sizeof(*matches));
-			strmap_put(&group->matches, strbuf_detach(&group_name, NULL),
+			strmap_put(&group->matches, group_name.buf,
 				   matches);
 		}
 
-- 
2.46.2.852.g229c0bf0e5.dirty

