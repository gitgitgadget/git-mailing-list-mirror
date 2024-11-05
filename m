Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35DC1DFE8
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787415; cv=none; b=juvs0Krw1ogg+yr55q7raJcKRAxsHU+VoKDmYpSh7JF34srlaWgWudFgT6hWiBKbF0BmV/S9698Ru8sqDES2Z6Lsg8NaeALQFiHgl27R1XR/f1uF8lLm9qCXVblVvmNjZhROIU2T4oN4HX1+OtPEDkH0o7Te3uoUFCjj9Lfz7XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787415; c=relaxed/simple;
	bh=5rSC2cIRbBc8lYaq8mLf/R11BRnUYBy9Lcxzc5mJLvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H59kbe/aZbfD9hz+Mee5PmwNB/IPbo83lZsx4c1vy36/BQyH7JI1XB1n8DiBqldj4G6HvJL/ghNoN8PPZqvx0oIGryNVvBouHaNYbZrPUf2hmFM4/RPoEZxExc58CpsrxZ9EZdgHct7uPCnbVanN3PuYmK3Lyy0wlOPEtyaKT8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LvpZYYfe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lCii+yjy; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LvpZYYfe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lCii+yjy"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 8685D114018C;
	Tue,  5 Nov 2024 01:16:52 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 05 Nov 2024 01:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730787412; x=1730873812; bh=oU+5mlY5Lr
	nRhkAWXQ8gmfzfsQ7cZur3LV6svAwlF3w=; b=LvpZYYfeGLnuZ1q0q43ehyYRF1
	1+pf62Zn5tWiVLFF9JK5fL1FRw5JaY4Rt6FhHHq60SsArvzfqcJWmPbHZgpdel3/
	LWnem2lyiIEbqegQlnaea2bL1qASw/LuXeIBivRYkfbvPRd8O2Hm8QW8fhdP2cEo
	cdKx09BGOr9bPGFS/xSO9z3iXHKhyRA3rpmgISPJXFNzX+RbPmq/gKK91Pip2pOy
	vBR4fbUZ/p99/RcKpVvZgFueK6uTLqfgM8s+iyC2ljYSnT6tAdd/M5gHQIcdhUDX
	a1glTguICoSvnTKO4M3svC/ULLm+cwUKF/q19OgZLGMe8Q5hSFuyR+X8zPOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730787412; x=1730873812; bh=oU+5mlY5LrnRhkAWXQ8gmfzfsQ7cZur3LV6
	svAwlF3w=; b=lCii+yjy6j5iGU8BoWGilAV5YCpODEk6LHKmh3odglkNgYAmDmi
	jdlR/em2UC7CFnYdAUrrT9BHdOJMHgvEH/9p1Mnfd1idqTcvIGZqTMsCCi8/6eU1
	Sw+i+XWTKk0Bizsr0WYbMmPCWtll4MGtPgTjzpWPz0akg8OtXBnzDvUvVoRpHBj3
	kuOGtKrb73P3kL7XFN1c2Mie6pLBGV+Zp9EZxrzhoTOOqZbECg3BQRgTv2x3fAUK
	SakY0GUXwuFzAIeEX4kKKuPjgO8rVI7mmhT8iw6Ml5idrHzuIuIgF+TEtUneMvE2
	JATqgv3itM4OlzTwtr1r8Rimbgt5QD6BmBQ==
X-ME-Sender: <xms:VLgpZ8cPNxbJ_mkuAPjAHLYF8AnTVdhM8Y7VXknFxp7wbCzGVYhIdQ>
    <xme:VLgpZ-OdCFOkrxIFGQZFQNp4mZlLNOXWs3TN3yOEZvLa10KxHNwlb0QV1iRt2n_zC
    1UH-bJjVuEaZMCgmA>
X-ME-Received: <xmr:VLgpZ9iDKXdTfpIfjECheTdY7JCRge-qpTp2CSD71h50MiTqMSDo9GDJ_J59lEIYEnImyqpZiMcmyCCVeMZqvQUgrkbWdkImOylHn2Yc_pCP-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdr
    tghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepth
    hoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:VLgpZx-fJClyplogc25SaNPreMUlgR_rSrbY_VH_OrLiajwEZBlL0A>
    <xmx:VLgpZ4teZTrn8Z-YHTG-Tk4IreAvkEzg8lrarvLqKJWWWjhJY1DmaQ>
    <xmx:VLgpZ4G_JCM-ZgQYmHyyq96Yj4WNfLlP0Irv-ayA6u_gkQXctYViuA>
    <xmx:VLgpZ3MBPdZb5ipdtK_2fKtts5wH4SUfi1WazthI7HNOWhKx2hdusg>
    <xmx:VLgpZyUWqzFhuTBFYTaUuUYGHBPxUfi89rmxGMYGL_tHD5mAOWi_sOEq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:16:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f612f5e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:16:29 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:16:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 01/22] builtin/ls-remote: plug leaking server options
Message-ID: <fbb9e68e2f2039204a47b25c7a8d385cca04afbc.1730786196.git.ps@pks.im>
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

The list of server options populated via `OPT_STRING_LIST()` is never
cleared, causing a memory leak. Plug it.

This leak is exposed by t5702, but plugging it alone does not make the
whole test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/ls-remote.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index f723b3bf3bb..f333821b994 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -166,6 +166,7 @@ int cmd_ls_remote(int argc,
 		status = 0; /* we found something */
 	}
 
+	string_list_clear(&server_options, 0);
 	ref_sorting_release(sorting);
 	ref_array_clear(&ref_array);
 	if (transport_disconnect(transport))
-- 
2.47.0.229.g8f8d6eee53.dirty

