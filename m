Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84BD13F43B
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 06:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618364; cv=none; b=dcrdcaH3GZlKzxvJEtPrdjdhk16X3Jukshgup7Q5SqHTHnmlfCrhSJUzSmjnHBUqbbv5b17r1sc+be67wVo6QsXF3hzpi6hIgC7rcS6t1kh3V7zOKc2KSYlzIDUI28iadI3umGZgJsKzvGC2dE4qCYjRgbDCjFEUXP8dXywsgqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618364; c=relaxed/simple;
	bh=ITE4erRc/b8Y/qTNPG/XLEHIMWZjT1sbyXWO5GLDM6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3jTkX/cooCuBPBII9YDKjeuN5MY7FdYlXi6N1CQtkOV7kd4Mc/j1XL2E9NsktYdkkZqyFtEq5trVrkPxqa62mlSenWXXvtVKnhHhNHSsXyam1sXzQyx7ahrOTsUtZBtWqsD6vdKa6O7vdfDvsBbAMSqPcbXmrPRkWCaiL1aS+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eomSaaTN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eWhTlt6Q; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eomSaaTN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eWhTlt6Q"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1EA1D115173A;
	Wed, 14 Aug 2024 02:52:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 14 Aug 2024 02:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723618362; x=1723704762; bh=r5fZSpie5H
	T8amF2hqjnv7n2KKUlCZFOuB9vonuv/XE=; b=eomSaaTNzbj3taOwQ+G8VMk39K
	b4lbafDp3i2+W5SHU+wINH4OwD0YajLv2sgKACiq35qMLAY31L7YMgJU9mrkbVS4
	IC7vuy3qYKD84wY9DPQ2wrrqVZeANm7l8Fn34UnDMJ5cRx4qlX6qGL20m1vLXkHF
	KIEDyUBQb1Ae8BT+2MnDiRx8BeiYKXJbHqYGqbdG59CNFicJ8IH2shyloTS6Bvc3
	ZMsPsJwQGX9Uk+ziUVXmsmQGv2kV6qjCqZu4ol6XiJ90IX5mcmj3DkbIZKMwXAtG
	RjhS2sbn2XgxsDcdi5LTFckWsKEZdAT+FBKlXUPyliYZDmIvq/wudefxDbWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723618362; x=1723704762; bh=r5fZSpie5HT8amF2hqjnv7n2KKUl
	CZFOuB9vonuv/XE=; b=eWhTlt6QbzcuvD4YQfL/gYyewCDA/BzYhFSsVdSDcegg
	uFFA1HPwRZkQICtDGTcHwpODnxCO4bfxb/n1Q9eAwL07NtAYn8s7Rfv+u+45LLFH
	2A+cXqyat3v2Ga58MwmODIC9aftcO23MuBxS7tzP/VlQQjWQwJOuUWJJlrDTfF+d
	rLQtxX0f9EJvUmvvvxjzZU5ySDMNGCDlbve1i8Mqld9hg6oia8AISAt4n38dUq86
	S6VGHOBWbKFmWS5mcTbCU5J3EsnFKewaiUA2YRetCvatkAJSCI/GYyE/hns5E/2z
	q6YdyEyzlmack0QfOnePtjgnpHs7wcr1vak3/dpugw==
X-ME-Sender: <xms:OlS8ZoeWmBMQv-0NhOPNCiuEJhx5X8apX41QkdOUTaOk0-EUkBwDYw>
    <xme:OlS8ZqN9n40H2QRFhlYtleQcIgC5G7scqVGOSGuwhPGrd9Tc6BU85Ma0f3LwIZckl
    tbyLdKThXp4Nqfk0w>
X-ME-Received: <xmr:OlS8ZphIbbsIJOCmvrDWTJlXgDJOH4DPRvJd4WN4b6W_kTASVr4-N-ECo7y1WLlN8tRB8DyEPkDcJRb1pQ4ZYEpyxQGSSwAbor9QP2kUkvYEvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    grmhgvshesjhgrmhgvshhlihhurdhiohdprhgtphhtthhopehmvgesthhtrgihlhhorhhr
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:OlS8Zt_kw_1r-Cw8CAktDN1q_p4yVv8UhLy48jDmddSkU-CSKet4CQ>
    <xmx:OlS8ZkuR4Kcwce2EqpzIKELT_y4KOsdmiIYTDuKlWzGcHm9Ic-g1-g>
    <xmx:OlS8ZkHbMbnUhOmJPn8MYowi1h1ZbKI3fuZ5LnPsmsuDl5odGwiQ1A>
    <xmx:OlS8ZjNSwJVLRdnf6B9HZoPP5Qt9qRh0P86USt5jCt664NgoB1JIYw>
    <xmx:OlS8ZoirhKsBTjeLFrbui_cswC0CJBDHZMTgv29jG-sdGGREXgH1Jvr3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 02:52:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 652f86fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 06:52:22 +0000 (UTC)
Date: Wed, 14 Aug 2024 08:52:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 16/22] unpack-trees: clear index when not propagating it
Message-ID: <9db41181a64f2bddc0d33528dcf32292d21ed145.1723614263.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723614263.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723614263.git.ps@pks.im>

When provided a pointer to a destination index, then `unpack_trees()`
will end up copying its `o->internal.result` index into the provided
pointer. In those cases it is thus not necessary to free the index, as
we have transferred ownership of it.

There are cases though where we do not end up transferring ownership of
the memory, but `clear_unpack_trees_porcelain()` will never discard the
index in that case and thus cause a memory leak. And right now it cannot
do so in the first place because we have no indicator of whether we did
or didn't transfer ownership of the index.

Adapt the code to zero out the index in case we transfer its ownership.
Like this, we can now unconditionally discard the index when being asked
to clear the `unpack_trees_options`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t3705-add-sparse-checkout.sh | 1 +
 unpack-trees.c                 | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 2bade9e804..6ae45a788d 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -2,6 +2,7 @@
 
 test_description='git add in sparse checked out working trees'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 SPARSE_ENTRY_BLOB=""
diff --git a/unpack-trees.c b/unpack-trees.c
index 7dc884fafd..9a55cb6204 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -210,6 +210,7 @@ void clear_unpack_trees_porcelain(struct unpack_trees_options *opts)
 {
 	strvec_clear(&opts->internal.msgs_to_free);
 	memset(opts->internal.msgs, 0, sizeof(opts->internal.msgs));
+	discard_index(&opts->internal.result);
 }
 
 static int do_add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
@@ -2082,6 +2083,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		o->internal.result.updated_workdir = 1;
 		discard_index(o->dst_index);
 		*o->dst_index = o->internal.result;
+		memset(&o->internal.result, 0, sizeof(o->internal.result));
 	} else {
 		discard_index(&o->internal.result);
 	}
-- 
2.46.0.46.g406f326d27.dirty

