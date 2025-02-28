Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB4F1F4620
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730407; cv=none; b=Wi4GMOXg9ABfPVoeb3B/3n2rWFspefVfDWo5njRIdOmdbden2LzhzhL5qUrqMC/E7GZYoVdt1JQJXaIuY0b5PT6kcMW1lssgY8ifH/e6UBaEae5C8O2pJ4ZniXGlmR3hPTRUyjZFroIUZxA/F4Js+H41YqujcD4QmjVaDBNhBNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730407; c=relaxed/simple;
	bh=Ntzr7WgB3W2/7/FE7H9yFdn2yXOLK8DEaj8tnGm1Nus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cj9yMChztK95Lb1vD72SmJ3Z0EVt19nYfVNef+It3JIBfdFkperdJFA0pCty1kIFcBcDFTVVeVLAGpmTYhOzSsjScBPX/RhLbOuitgtxIDaPFIbsuhAbmXd3ukx3FWv9g+pb2yHxmqQ1F0wYUJD4MlswliLgH7U0jKPGZ+n1ivc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VSvrq+zl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0i3KdoDz; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VSvrq+zl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0i3KdoDz"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 049B511403D0;
	Fri, 28 Feb 2025 03:13:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 28 Feb 2025 03:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740730405; x=1740816805; bh=IuVpXhYXVq
	DpkFHylSjAqcTuKgU8E8EWh/jpVnO0e2M=; b=VSvrq+zlaggDAmk1FyCq6/TsfG
	swkWAs3Uye8rHR0w/PD4k8PR+aFGBBBwNhu+IMnasiQk/PJ8i8txGJhFvok0RdUk
	HHf0Vgh07Tos/gtAulfnirOblUKnYRqmRSqMAg9FEf90L4CmZhb65n4+NleCg/Gy
	97AN/es4CBeAMENTi2lBSTHdYLRwPvQBzjqhAIwbHrt+N5n4mSUjcmB1ucpBUpmf
	B3Rw9KVTA1vLjlJokV47OKDso3BFdEshs1FfesEeY0VF0mXM9cAkifsq4QJcrCyB
	4WY1y/IjB/+e96OhcUjm+8NPFskOo55A6FS+rF7aQcxwYQsfZ8xF/Julf+Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740730405; x=1740816805; bh=IuVpXhYXVqDpkFHylSjAqcTuKgU8E8EWh/j
	pVnO0e2M=; b=0i3KdoDzrMOsmUdOo7lLlFGfs0YVdEc+eA3hhSP9q3tipaFYVMb
	WiuMK1o4hmhUgFT6wCfmS3BPb1W86jEEoP/BN2LejfjUekyVHUvUvrRR38cie6NK
	cEm2Bjl7miNuwnD+20Sq9TvhTsVpndIzYumVMuVbxuF/R9DsaoKVPQ31NpYeJisp
	8aqWSfQOzNex4SWFBroERS5gnGKeIZO3kS3b4kyui/DRP4xrNZ2CmwmjoNXrkKVw
	2CsseQoFx3O89a2NbdeUroHDYF2OfUCUzN56WaEEgxROhSheMvEad/FejfzVFqs9
	6AXgcyEimE6bndgBYd9i4OzzAQ0hC8ziuBg==
X-ME-Sender: <xms:JHDBZ33_zO4HrfdgxSAYKINWlRsg5q2wxLAvLLrAu2zRA6k5Zeuq0w>
    <xme:JHDBZ2EyBRBe020EcWjhwOOBDRErSwk3xJtNqNFklvSdb-GvyIYatL72NgFF5VqIg
    9BEaF4U2op74k29uA>
X-ME-Received: <xmr:JHDBZ37xRQQ8yMdli7mDpYSJH6ZJwRT12rJLU3T6F1xZLIJSYTU5ZEON5Y_BRxEsD5rKrQblUvS9J1esg9Xf0B7t9BNf4j1O-AT_sijN7wEzWGPb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekleekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhmiies
    phhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhn
    vght
X-ME-Proxy: <xmx:JHDBZ81yytHExLVun8MXhSjiO_4jfuv0Yy_6yMe62DH1fr9u7RX4kQ>
    <xmx:JHDBZ6HTlg1zGMgiysnA2iC9E3PkHx4DhRxwJ6AHlh4g6JQDklVOoQ>
    <xmx:JHDBZ99drYJS7ALACaf5H-YpMkX6wSCmUX7K-qw4DYrB0Y1kBKyNog>
    <xmx:JHDBZ3njWMQt8TOzRgUESO9d1ircEzLB1fL7oq29eP-JMIyLnAqcjg>
    <xmx:JHDBZ2AAin34szmriDrAuBLiN04UREt17xWhstYyarQW_rX2FgMZTIBy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 03:13:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cac799fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 08:13:23 +0000 (UTC)
Date: Fri, 28 Feb 2025 09:13:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/3] contrib/contacts: rename .txt to .adoc
Message-ID: <Z8FwIqnYYPk5bV7O@pks.im>
References: <20250228034713.203461-1-tmz@pobox.com>
 <20250228034713.203461-3-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228034713.203461-3-tmz@pobox.com>

On Thu, Feb 27, 2025 at 10:47:05PM -0500, Todd Zullinger wrote:
> The .txt extensions were changed to .adoc in 1f010d6bdf (doc: use .adoc
> extension for AsciiDoc files, 2025-01-20).
> 
> Do the same for contrib/contacts.

ef18273a2d9 (Merge branch 'ps/meson-contrib-bits' into next, 2025-02-27)
wires up this thingy via Meson, so we'd also need the following change
on top:

diff --git a/contrib/contacts/meson.build b/contrib/contacts/meson.build
index 6ec92f47c43..73d82dfe52b 100644
--- a/contrib/contacts/meson.build
+++ b/contrib/contacts/meson.build
@@ -16,7 +16,7 @@ if get_option('docs').contains('man')
       '@INPUT@',
     ],
     depends: documentation_deps,
-    input: 'git-contacts.txt',
+    input: 'git-contacts.adoc',
     output: 'git-contacts.xml',
   )
 
@@ -47,7 +47,7 @@ if get_option('docs').contains('html')
       '@INPUT@',
     ],
     depends: documentation_deps,
-    input: 'git-contacts.txt',
+    input: 'git-contacts.adoc',
     output: 'git-contacts.html',
     install: true,
     install_dir: get_option('datadir') / 'doc/git-doc',

Patrick
