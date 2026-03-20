Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499792FE58C
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774028828; cv=none; b=fCFC+guwTkRd0ZdSuYe6K/riVj93MNz3QMFH7BGzz1YXEolkMCWMHBIhHtZfsQ926hkqoAwudq+KOaKwBbewJyXT2oZvCE7G2ZU4nyuIL/Oec9ezuA3bv62oPThJvNEMTXmOI7aMMAg6+wK19W6mFtska6nDIqbNZEohHTrqO6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774028828; c=relaxed/simple;
	bh=n/2biQ4DVAML0bnBOOnoQj06w/WQa6W0sFtnBQc2VIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PljDET6WLMAB8u6c9ck9LPyVmredWg9H+cJGo29St5bznGCgEWIyCsi+W0ZKzwXfGq5kVH7LiMHQGdiUh7mZ2a8ZCGQrifbJvBLl2sqtVPJ5wDCcMELHa4hpRQg0Nl8AW1cBOWvq4gTfznBYtpneGvGB7o1iezb4bz0kAFPr9j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L1YqwRVa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V7yxO+cy; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L1YqwRVa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V7yxO+cy"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id EEAB21D001C4;
	Fri, 20 Mar 2026 13:47:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 20 Mar 2026 13:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774028824;
	 x=1774115224; bh=X+ycT20wTFjUL65znpz6D34DMI6ZYuJE8ucL+bJLZOI=; b=
	L1YqwRVaHMC7WwbuFwOxEAqLBIKI2jstYlyWzHkX1zfFlIlPZ1vmIQN6vnq5ollG
	mfhnLYcDkDp6fRA6Sqh00+jZ2KHGX1qRmqhWBfhTUcbWYRz6bS69mvmiAqCrGsuX
	1FnbYj1Y+IFIGWViAGY81LfYM5bZGR0cVvEyqV+l0Ess6I/XazCXUXs+QQYr75DM
	NgbhNmqNqpt3F7m7Yy4IFDR4+MVKQXLGCnyNoMJ3ODSD/0QxOfDTVKyH0ud38+NE
	TzIKmOyzTPuXrCjk4daId+U709Mlcm79ormenLo1Dy1wMcLwMwXDvXXrT0MqVOdu
	1bXcsK86KsCPPlrm4TuDqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774028824; x=
	1774115224; bh=X+ycT20wTFjUL65znpz6D34DMI6ZYuJE8ucL+bJLZOI=; b=V
	7yxO+cyjlkf5xV+Yh66KqlpUb+e91ogRIC0mQR70hPxhgWViO4htVApBItZfEV7v
	L0KjEV1dO1EpY1Iy/opxF3RHm6sp0XlE3DX4Mq0uSd7s0fxI2RHQZvxsbsvnotJi
	Hrf2KqCXskGHRrvWGPJQzRyGzzaL/h5c+gE9hCspBhcwVkuNwRr6RZtWVwDmLFF0
	7LtKuFWLL1i2rPq9KagHZFzhPaSL9QmEOsw+OOBH+p9ibVlPRFxPtCAGfC4+mWFf
	tQWti7D6/mbmRjFLSLsMQeUXCwP+cZe9VPCD7KUtTuiwFUo8XMJE+W36Uvra/SgQ
	mOP8rWbtE44071el6qVKA==
X-ME-Sender: <xms:GIi9aeqZXqUue6K8BTN-gTsN9WnDsWjNda7aAXnQ_-YYN_kZpJBGdQ>
    <xme:GIi9aQUGuS6ffKJPi15W0FPeNFKYBUyKkvpVpn0Jmf46ptgI5lSqndNGEPFY6As45
    bfCp6-f4R9tKhklatDrV0M9hYJeme4QUcrY1UoDCEMJ6kgpvic>
X-ME-Received: <xmr:GIi9adBoj0uu_Y9HGfcBLlry4nQBKOBy64eGf2caCv7YZ4GsMZeCaZA6iiBVTe-D-YWcqH75teAJmsoCNLpE9X-MVaXdGII-bQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnhepffethefgieekkeehveegieelie
    fhgefhudfhtddtveeltdehhfefhfevieeuhfefnecuffhomhgrihhnpehprghthhdqfigr
    lhhkrdgtfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrfedvtdehudehfeegudeisehgmhgrihhlrd
    gtohhmpdhrtghpthhtohephihsihhnghhhtghinhesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhish
    htihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GIi9aU3w5-dkYZT3jX5Cox44gpQDyHbMXwzJx3_sdx36IVsZwDeT8g>
    <xmx:GIi9af1NGNMZW66FBq_TNw8r9Rys0EwBk_rrXSlLtimilZ0cqI6pNA>
    <xmx:GIi9aZCh1pEa5rOXCIag6j8ul-NIkp3xSEO-m8V1txthp9Za1kQU9Q>
    <xmx:GIi9ae6gUsx97VckUE3G_EZGOf3wbunmRKUJ0M3tirvrYS7IaZGDOg>
    <xmx:GIi9aWNw81VMDtuVNRsg8RxV0hQLH17uuzCxoJIgdPMeRUoZwbf75ZDr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 13:47:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: Yuvraj Singh Chauhan <ysinghcin@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  stolee@gmail.com
Subject: Re: [PATCH] path-walk: fix NULL pointer dereference in error message
In-Reply-To: <9d0746d8-2194-4a13-812b-9b46d04c189a@gmail.com> (Tian Yuchen's
	message of "Sat, 21 Mar 2026 01:32:25 +0800")
References: <20260320114556.3151040-1-ysinghcin@gmail.com>
	<eca1a469-2e15-4466-ae58-978ffc23c177@gmail.com>
	<9d0746d8-2194-4a13-812b-9b46d04c189a@gmail.com>
Date: Fri, 20 Mar 2026 10:47:02 -0700
Message-ID: <xmqqpl4ye6ll.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Tian Yuchen <a3205153416@gmail.com> writes:

> Then the message 'failed to find object' is misleading when user 
> encounters the second scenario. Wouldn’t it be confusing if a user saw 
> this message, checked the object using 'git cat-file -t', and discovered 
> that the object actually exists?

For that, you'd need to remove the block in question and duplicate
the message generation, perhaps like so, to allow the message
properly localized.

But that is way outside the scope of the patch that was posted,
which was a surgical fix for a reference to an incorrect pointer, I
would have to say.

 path-walk.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git c/path-walk.c w/path-walk.c
index 364e4cfa19..bd2c47079e 100644
--- c/path-walk.c
+++ w/path-walk.c
@@ -161,20 +161,20 @@ static int add_tree_entries(struct path_walk_context *ctx,
 
 		if (type == OBJ_TREE) {
 			struct tree *child = lookup_tree(ctx->repo, &entry.oid);
-			o = child ? &child->object : NULL;
+			if (!child)
+				return error(_("failed to find tree object %s"),
+					     oid_to_hex(&entry.oid));
+			o = &child->object;
 		} else if (type == OBJ_BLOB) {
 			struct blob *child = lookup_blob(ctx->repo, &entry.oid);
-			o = child ? &child->object : NULL;
+			if (!child)
+				return error(_("failed to find blob object %s"),
+					     oid_to_hex(&entry.oid));
+			o = &child->object;
 		} else {
 			BUG("invalid type for tree entry: %d", type);
 		}
 
-		if (!o) {
-			error(_("failed to find object %s"),
-			      oid_to_hex(&o->oid));
-			return -1;
-		}
-
 		/* Skip this object if already seen. */
 		if (o->flags & SEEN)
 			continue;

