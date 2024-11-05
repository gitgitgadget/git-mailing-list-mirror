Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008451D5CEB
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787454; cv=none; b=HXJ9WQS4/l5Fz0ZaU728ffrqGLzO4AUR5FVfGxvJR5mPHn0fGUh6iLmHuRIGEAeIbg9cHJFMVk4DIQwLAs6NWlg0KBLYvbSrlJCoZunI7oqr/+wlaH3wDAG+PFkl87Fzyax6pSEFL0sCYHLC4HI89qFJ08NFHclTcVGguF1AP9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787454; c=relaxed/simple;
	bh=SdVLCzoGuklJrhdqLawDpGY29twMT/f+hcGW4jVGk3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpFfwF2ipKxqpWPOL7cXRfPG4YtJM+cCjEmZuGZ5twYKBUrTGzOTVgT8t+PqYhVyQ5vsI9vMTA3x9RxbLTgyeQvqz9I8aRnR43BhN/2lZDrOTC+QrAv+zfo54j9BCQ/Nzsm+IU8Hoh43x4vMgTW5fkHD//qpuYuqePQKcW1UZaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cJQYxjwt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dGpMf9V6; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cJQYxjwt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dGpMf9V6"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 22FB3114016D;
	Tue,  5 Nov 2024 01:17:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 05 Nov 2024 01:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730787451; x=1730873851; bh=jsjFLSH1yU
	0DYORo3Rid/srSfZN27sVe527D/RN4REA=; b=cJQYxjwtP1UwL74uTo6sJXLx35
	olQ2ciRmwvnkU3ruuntksHX+ZuLk7sUWSHzq5d35CQmRsyJm4YmbSAt8QUGWinGq
	CnQG6xkDsCFgYuMoKWiKEj5ipmMg9e/WLsXMggPELfLHf5nLA63cNjKfxTnLZF9N
	6ASDJH+cocSEF1FRcw4YI63ggWgecTGBMiApX5capOt81RdXM6uXksLrkAYNlrTG
	Lu52e6Y30Q07qqP8PquFd6ULiZAC5EWo7nT4mZh67Vp7Z0vv9Z6wPtKsGoRmrcGW
	cAANqD/OFJ1/UTguNlyPnY8S2gMEKbxq6U/4JDR7XwtzG0otLam6C+ogXjSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730787451; x=1730873851; bh=jsjFLSH1yU0DYORo3Rid/srSfZN27sVe527
	D/RN4REA=; b=dGpMf9V6rKGWs5KHq02ArZWhgNuJlehKC/v42YGqX3J28DvaDOI
	5EhSlH04irX70K9nOHYu2HC1+89k5OP44hxqIN+W/QY/JUR9piYHQoQcW0LwxN1z
	BPjUwJgfpe0Yi3HUomuTdXXNDcS51a2vLKCRPx574fpfCv6Xl8D2y3k4xA6nFVuC
	OZ67s8uc5SNjCL+b1KDAUfJbD8BdTuLIX/tmGhHthTRbXBcWbBTstvQsmMtEAP7H
	5btljMb3Q2Znz8xlsKa+Tmr9a45clllV0V9Ip2k2q3WBdRM0NnPpabSYFxKh3+/e
	M81l8CLwmimB8YIfNZsDDCPk/B+a9lKtnSA==
X-ME-Sender: <xms:e7gpZ8og9uVTSN41O_HeKHsShXUJvx1g2hcPYzsLF94gqV1bDhksVg>
    <xme:e7gpZyqOb7nEkld1Hm6k38X6JdofDSASTapaxODKt7yyibRYRY8kyneWuTxsq4O1I
    8M7uIO16FmuFpEmmA>
X-ME-Received: <xmr:e7gpZxOcUaCM4NeCLdFEQfkUNBXm4ZAfUuhQfNt9q1EjAzwBfuUWGptOsn-VcyB3XTHrYPM5v1fsNCyqmdoq3qpEtHnQni-eE0S8dt6fetxr7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehjlhhtohgslhgv
    rhesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpd
    hrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:e7gpZz7yXzXDqFQAVq--wt9XXswjiIkwqEwpLWtBqR5nnW1vVnsv_A>
    <xmx:e7gpZ76c6T6uysDYQttWUol5DJg-w6V_rw0hmPcmZvJ0VbnJiwiEdg>
    <xmx:e7gpZzgNWXCmRUjjT6TS6SkDP5z3m3FVJMQtZB9GBUu592K05U-dNQ>
    <xmx:e7gpZ16CCAoDLKt0ir1pSh7i30nX5bDFRqdqaQeP_TlgM-h0RAl47Q>
    <xmx:e7gpZxQvV7NROjksg192FwpXVdTqltZpnne_pBuG7bYvOSGlWSj4B9ad>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:17:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 58268622 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:17:08 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:17:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 13/22] transport-helper: fix leaking import/export marks
Message-ID: <40e0c2a2cacaf2e6879b262c43321728af25579e.1730786196.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1730786195.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730786195.git.ps@pks.im>

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
2.47.0.229.g8f8d6eee53.dirty

