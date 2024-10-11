Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477671F9AA7
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 05:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624770; cv=none; b=OUCzntfrVL8Dg2yPbXIT5XxU2h+PFjbMgvE7FpulhJoyzMlvmE1rFF9WK9WT3JJ8Dtu/sRJ31vcGApTbb+uGzCBar6wvAW2JUIccWeeUJ/EQwz8I0rbct/I++RlCj3xPK+mhwBZF80JAUO/n1sMttZcNNKg36du/cAodacFlmSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624770; c=relaxed/simple;
	bh=bAzSPxkum0PKfLT2dnzzCjEm3sq8Pmj1lJB8C4u5v0g=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrXTkgYlP6bK+X1Erbl/UQN777Tud9ebZgIl+cuxxSR+cGWxe/LPpaesDGndzb7KQGlC/vsLa+4rnTYyOn0HlqoX19KWLljFmyHyxnKy5Qti7lmul0Pgw+68j5GFzc9NjEYM1Vy8Ru76pBRDn6oHZ6GPVuJO+fHYVBU56+3gfMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QgwLen/I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=buMg6nsI; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QgwLen/I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="buMg6nsI"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A15411400C4
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 11 Oct 2024 01:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728624768; x=1728711168; bh=Pteuko61CJ
	aREjl9f7VpsYwMxjDuAXNNLetM6KewWc0=; b=QgwLen/IkUi3C3H8XoL5Jar4NE
	G34JSUv6pue7m5yZgf3L+PXGCy0JoyYUSh0b3A0pYPSrYzrLX27Tk2Vt8mgRxPM7
	9VzZOycFCv501caed8QtM8q0RED8nJT+XjjCrakdGCzINEzzoAGp4UDuVASyjyfm
	IYmclvKmTsEARdzgR558SZ0PoIBNEtWUvTK507TV0CJ0v8LjLgI850cTn2PsGAWu
	DIxh2smYcbb3X38Zp6KikJJT/MDP4ay4njwXlsFs41szG3Z0bECrTWEgFDHYZu+v
	QOVyTm+jhMuaP3CDl5D4mqFmUvNT+h/zpezeBQ4th5N3lYs4eonv4/J7W1ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728624768; x=1728711168; bh=Pteuko61CJaREjl9f7VpsYwMxjDu
	AXNNLetM6KewWc0=; b=buMg6nsIoVoojHoNi6wBFJByYat20BvfsMhQG8LlHoz4
	s3aTvLloke0GUg0sCLFpdZesrCXKx+lb3NnPlPIdMdz4gidqknPBaLQECe1Gpo4x
	1FK8pfwEBk2shtl3nlSZO1VAc/VGG1XXj6/s0NMTynjEfmTqOy5VG30ftsGMG7CM
	i6JZCldMn40Wse6MZyJ6ZVtzABMsmcW8VjUBmJ4NjdNZtnpnzLTDnAq9H4A4sTzE
	yASad3SRckG0kZgJ21x0dTJNPl9i6YIz509UFn8wz3h8P2rtuYFXGQNersuJsAg9
	LNJqoTl1flc7KHQzxx1gAGsIo8nxXY+vlWG8jC/uSQ==
X-ME-Sender: <xms:gLgIZxvEdUIL6mHMNXcBMfwLXMIkdQ-GLub1P3Nhpyy-Pkv_a6ptRg>
    <xme:gLgIZ6fdLpVMjxQyESnrpnliRHvH1q80hbj5JYgBZ_Ky5HtmXg-Jppjyem45NYE8j
    gKPYS9198oZLLACrA>
X-ME-Received: <xmr:gLgIZ0zCbL9iv7h2H4aehcjbPVeacIV5X1xeI7eG7oDhAF4iDcOegbnz7AgeUBj4IRTkddeTlLZoW2MJdeJyUr7-NlIdsQHRIe_LRKE_uSsIfpU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gLgIZ4Nu0oJTJDu-6eES-zz5tqP-7LKmMzNowZn0Wpizkb3QCNj4Pw>
    <xmx:gLgIZx-E6nkg6IO6FhMSdSRzFooGmI8TRXSMdzG4wohHBrQjCzGdig>
    <xmx:gLgIZ4W3CMsI7rez7izmyJ1E7F6xDDLTPFPWuvvXS3x-Hv-jHmsrow>
    <xmx:gLgIZycz0T50sZKaPz_Jn67IfCTN-eAU4XklDaI9nHiurxhxhdvkTg>
    <xmx:gLgIZzmnCQG39Mfs_YIRRAXhJPj6qv4ZET8eQvOvbNOHFJLON9s93SXF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 16bff9cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 11 Oct 2024 05:31:41 +0000 (UTC)
Date: Fri, 11 Oct 2024 07:32:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 12/21] transport-helper: fix leaking import/export marks
Message-ID: <16d969ed7b16a4de34484b70616291512a686005.1728624670.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728624670.git.ps@pks.im>

Fix leaking import and export marks for transport helpers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5801-remote-helpers.sh | 1 +
 transport-helper.c        | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index d21877150ed..d4882288a30 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -8,6 +8,7 @@ test_description='Test remote-helper import and export commands'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
diff --git a/transport-helper.c b/transport-helper.c
index 013ec79dc9c..bc27653cdee 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -399,6 +399,8 @@ static int release_helper(struct transport *transport)
 	int res = 0;
 	struct helper_data *data = transport->data;
 	refspec_clear(&data->rs);
+	free(data->import_marks);
+	free(data->export_marks);
 	res = disconnect_helper(transport);
 	free(transport->data);
 	return res;
-- 
2.47.0.dirty

