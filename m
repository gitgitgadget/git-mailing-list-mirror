Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52061B85CC
	for <git@vger.kernel.org>; Mon,  5 May 2025 06:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746428179; cv=none; b=IqebYzDD+JHoTLQzZ8Ki2sILzMhtHDqNCUj4u+0KMhxuJ301dig6hrMgt9cNzwGU8ymQK41GVaRFL2K77nbpqZUHJGfH6SFWsg4VLi8RiqFzDgux3zrHz4bvJD0LTjUxQOT+trLRLizzVh+xiO9NIbo/jVuGLZlr/4oblO8X9ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746428179; c=relaxed/simple;
	bh=eReFwcokgIagYHAA/DTkbVrEHr15QbjvYWtZb1mt6Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdplU1hXWAbHPiJd+myrDhQHJgp7ADTrVTFJ4B9sl0ldriKiXUezOy2dlNE9Nh8EG2RS6UwKkRL6AeoQ6VfwMuzkKAieRv/Xgnd223yVqHLj6eje+xS8SiQWD0krxUqw8FNE+2drHdVYIl1dD71wYKwDWQWFmFpznaIKuvvNMIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rgC+jGjh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tE5ltVOT; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rgC+jGjh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tE5ltVOT"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C95F9254022E;
	Mon,  5 May 2025 02:56:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 05 May 2025 02:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746428174; x=1746514574; bh=bJyKyhOy0O
	m4zoYgK5+GihEJ1nir8vdv5KCv+wOoMCk=; b=rgC+jGjhxevpB3jHt6NsnCUN+h
	UTWl1CmOB8JwgvVcuLW4yqx484n10dijjGSXp+FSv2k8FNfmYICsWQaoQNmSmsly
	WxnzGQ0lTmwryH8D3WVOy87G9rqWqaRZMB70ferSYtDQEvab1O0ghwqroRqrA5hx
	enZe/Ak3FIFnYPsQK0DXEvU7DXOyKoZdPJMdhIsUVZeZIq5OqpWP6cYNXqlhbkqd
	C24I/5UPHYe+YeKBpS73kzHDxGzpuWf5IPJWuul3c0acILV5qB4HkRoXvSw3XGLH
	JADtZIdd0ALVy6jyLJu6RHNJlY60yOCaHcCN5f4aL4gxIRopkio6WpPLTtZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746428174; x=1746514574; bh=bJyKyhOy0Om4zoYgK5+GihEJ1nir8vdv5KC
	v+wOoMCk=; b=tE5ltVOTK2x77KjAYAOgbNYfmzyly1W4hrGN52jaxMcjXws2XcV
	ECDR/X70Ak5n2HfaumiQfrceY6vGXmoZiQFgigyQdWbl6fuW0QeZKq/917ceEsBl
	KF8TO+f81F0wvlzZvniI+gYIi5WKdo+uwr8J4Z63Z8W/hPKYH3bzsbzjGY/Jna7c
	vkMz6zSYGIFrCEIBPWippZQAv3nqdGd8lWZvJ15qEeh4vWKRacQqrfxCA/7GiUOV
	w8v0SNmHsY+3liYeSIF7v9AXPMn/QwqKF4ZsXiQcrLcXYUJBPDh9+oDaNysdUNbZ
	CD8ouYNOP9CbKOShO2D1F5NdAaeSGw9rjWg==
X-ME-Sender: <xms:DmEYaExu9vAg19siqt7x0-qnSyPIxEcWJEcU5L5TmIVZ1njtbRVGvg>
    <xme:DmEYaIRaC95WXykg8DuJVNgMY-0lgXRqi8SeAW4AB4m9HFqPnPqjW9hR0a98vrung
    8mzlcIrqpmHBaUkbg>
X-ME-Received: <xmr:DmEYaGV6OJ-W9w0asLqe6Fg24P7tsWD2Y1fjcSIztJwVv2CaocF1WhzbVzCAfKdGsCN0ZOpJs_yHD-UuwwjBXzAxvMI137J-hM9tiLTjVpdFUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeejtddtge
    ffkedujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:DmEYaChHAjkLOqswS5kBkZXf1KcxLFBW5UiuhxkIXonz3k1mgGj4_A>
    <xmx:DmEYaGAACtd5BKVfxrZYtzM_k_2NVRegCULQQIY9YdFylzcW1qGVtw>
    <xmx:DmEYaDIF_6Q-0g2TxQOWA-5QpNMN8ciANdKkmVaXxGbaDy7SklPyyg>
    <xmx:DmEYaNCz9fc3vxuMQ327t9e3-2_mZLu00fHSgJ-uyQNGnJodLZQwzg>
    <xmx:DmEYaIyeHE1pCrSbMZgnew2DdGBjPRBLgG7jqybuIQPwMimYF4NckVkf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 02:56:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 31cb0f9b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 06:56:13 +0000 (UTC)
Date: Mon, 5 May 2025 08:56:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 5/6] whatchanged: remove when built with
 WITH_BREAKING_CHANGES
Message-ID: <aBhhDAZTLJQTIQSC@pks.im>
References: <20250501225958.2947677-1-gitster@pobox.com>
 <20250503005814.3030099-1-gitster@pobox.com>
 <20250503005814.3030099-6-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250503005814.3030099-6-gitster@pobox.com>

On Fri, May 02, 2025 at 05:58:13PM -0700, Junio C Hamano wrote:
> As we made "git whatchanged" require "--i-still-use-this" and asked
> the users to report if they still want to use it, the logical next
> step is to allow us build Git without "whatchanged" to prepare for
> its eventual removal.
> 
> If we were to follow the pattern established in 8ccc75c2 (remote:
> announce removal of "branches/" and "remotes/", 2025-01-22), we can
> do this together with the documentation update to officially list
> that the command will be removed in the BreakingChanges document,
> but let's just keep the changes separate just in case we want to
> proceed a bit slower.

We'd also need to adjust Meson so that it doesn't install the
documentation anymore. So something like the below (untested) patch.

Patrick

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b109d25e9c8..815b0334e53 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -510,7 +510,7 @@ lint-docs-meson:
 	awk "/^manpages = {$$/ {flag=1 ; next } /^}$$/ { flag=0 } flag { gsub(/^  \047/, \"\"); gsub(/\047 : [157],\$$/, \"\"); print }" meson.build | \
 		grep -v -e '#' -e '^$$' | \
 		sort >tmp-meson-diff/meson.adoc && \
-	ls git*.adoc scalar.adoc | grep -v -e git-bisect-lk2009.adoc -e git-pack-redundant.adoc -e git-tools.adoc >tmp-meson-diff/actual.adoc && \
+	ls git*.adoc scalar.adoc | grep -v -e git-bisect-lk2009.adoc -e git-pack-redundant.adoc -e git-whatchanged.adoc -e git-tools.adoc >tmp-meson-diff/actual.adoc && \
 	if ! cmp tmp-meson-diff/meson.adoc tmp-meson-diff/actual.adoc; then \
 		echo "Meson man pages differ from actual man pages:"; \
 		diff -u tmp-meson-diff/meson.adoc tmp-meson-diff/actual.adoc; \
diff --git a/Documentation/meson.build b/Documentation/meson.build
index 1433acfd310..2fe1a1369d4 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -158,7 +158,6 @@ manpages = {
   'git-verify-tag.adoc' : 1,
   'git-version.adoc' : 1,
   'git-web--browse.adoc' : 1,
-  'git-whatchanged.adoc' : 1,
   'git-worktree.adoc' : 1,
   'git-write-tree.adoc' : 1,
   'git.adoc' : 1,
@@ -207,6 +206,7 @@ manpages = {
 
 manpages_breaking_changes = {
   'git-pack-redundant.adoc' : 1,
+  'git-whatchanged.adoc' : 1,
 }
 
 if not get_option('breaking_changes')

