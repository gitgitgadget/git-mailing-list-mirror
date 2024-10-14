Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF708F64
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 17:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728927783; cv=none; b=c6NFk2c20DbI4LNuyfhUgIshl4N/67a6JV5S9scL9RT6U4z0WZavX28pmg4t0p9Tl7wMrI4r7csPC+OQzlwAs8vyDBKNPuZw0zi8oGykmE4yOa7IYSBXhgPFEsvEFVlMB3RifmGyGP8rHohxohbUX/soupDxom+Mf6NqnIpQ7RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728927783; c=relaxed/simple;
	bh=1NOiqI5Mbld+NuamSpnPlbAcIe1nTDWoljJKE6r/nog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXQfcIJQQvx/CRJUPEcKoLLX5U2Cuc7SXo3pMbhpZ8KHCAr14umie7km9A7qCb4j7cWzJEl+u8Kgq322YY3ZcrvQB9g551UaZF2gycWK7sNnLtgoYVZ7VJ+NPKMOlAqQcZLRSWuOFxCpBaXsfsdyJ2nGO2ZgDiQZJo0UrtwzusU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UYDvBLdb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UrotUpRt; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UYDvBLdb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UrotUpRt"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id BB81C138022D;
	Mon, 14 Oct 2024 13:42:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 14 Oct 2024 13:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728927779; x=1729014179; bh=xTP6yhR49n
	MboqloAkoTR+zktmqSYl0KhEVaKUWg6Pc=; b=UYDvBLdbbuufv4XxGCcYysO7iE
	ngERZribBTrY9ZvSxg/du3wnV2l62vSZzyS0WV3WbN4/+h5QaZM0CSihgnbqPldW
	J4uURJHoEfPyWnnAOFnkJn7TbBkiV2eCkwpkYRIW+hPHt8QZHvxhZ1MugbUq/BXm
	+3170E3kTApbxOF9l05rwtqegmUyJIiTyAlV6tI46SA+o+ixnqoRTwaA9cRlMVSA
	EmPpadLnuFLcT00vh+HEYmHdGg25R0grL6h4aTvRalIJe/rNYoXybvzcttzxy4k7
	pypLj4ZGQ5tPr43ds+zqzvXUE2S4ZzCNQF9yJk6KGMjyBVZu3Ejw7rcibmdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728927779; x=1729014179; bh=xTP6yhR49nMboqloAkoTR+zktmqS
	Yl0KhEVaKUWg6Pc=; b=UrotUpRtjsV79QiGN+S6L6fko7MdaQMXhw8YknZIZIrh
	ai2k8sNLri16R9tTeHr52jn++EnRt0iJIa0nE7LJtbEE+oeqSTl1NdTzlex/+rsQ
	+u4X9qF/Ey+RdDeYKuF56txKdWmXPhkgbovk/f9L8lHWBzwTf7auc6tAhklZxCRm
	l8spZq7DmYyVzVDjOZfB1DH9qvr0RUS+Pj66OrqU++HzfAPZoL7PyqvFIsH+oDjt
	AztLPmdjTC0A8At8gNOylK8knewm2LIVU+MljrVOGfYAQiun48yKM9ruGTwylUKi
	r/8O5CGqhIHcChwMcW8wX4rYRfK+2erWsem769BcDw==
X-ME-Sender: <xms:I1gNZ9H_14o3Oea3q4g8D-0gLsuqSBTCNm6MMSTnwUMX5pfR5l1N9A>
    <xme:I1gNZyXOb4gAunuYku4j4EWAnA6XuUTH9wDClinekzVoenQxL88_QIpJ9sL_n4U2g
    -U9qk29sBxCRWWegg>
X-ME-Received: <xmr:I1gNZ_JbTKIs41VRXi28UbzCtsW52Pa8YbSB10XAJizKnBY5U3h06xI1cGxftfTV-7j2uLs2FpT-8Q6tGcdSYuU5ShUEtNICbaCR7IatoHvgAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:I1gNZzH-GZkqVOmAW5-O8Z1XTfkH2ryFslhQa10upSZ9ZI107YRfSQ>
    <xmx:I1gNZzUF4Zk10N32sQrFQwx6xYnDp-qbpBt4VBtrt7EZy5Nl2HTbOQ>
    <xmx:I1gNZ-NxP_PfRyYOxWclf40LXXcWaL5wzkCkGi-pZHlPAVSgTmlj8g>
    <xmx:I1gNZy0BN9yyhVMPTiZ7t2Pdl1ZKd4U6iUNplZnT9jcyNWTmHkFz0w>
    <xmx:I1gNZwiksQCJVuacIXUjaAx8AD4ILue5n7u0VljIfTr4nOpjL8fSOmaX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 13:42:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 22715ea1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 17:41:41 +0000 (UTC)
Date: Mon, 14 Oct 2024 19:42:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Modernize the build system v2 problem
Message-ID: <Zw1X9-d1OH7Df8Wh@pks.im>
References: <28e13e74-d4a4-4be5-8555-27a69c5c5787@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28e13e74-d4a4-4be5-8555-27a69c5c5787@ramsayjones.plus.com>

On Mon, Oct 14, 2024 at 05:59:03PM +0100, Ramsay Jones wrote:
> Hi Patrick,
> 
> I took your 'Modernize the build system' v2 series, from 2024-10-09, as patches
> from the mailing list and put them on top of master@ef8ce8f3d4 ("Start the 2.48
> cycle", 2024-10-10). I had to hand edit the 14th patch to change the version
> number from DEF_VER=v2.47.0 to DEF_VER=v2.47.GIT, because of the change of base.
> (It would probably have been easier to just base it on v2.47.0, but what would
> be the fun in that! :) ).
> 
> In order to fix the 'dependency loop' error/warning from make, I applied the
> following change:
> 
>     diff --git a/Makefile b/Makefile
>     index dc60b2581d..c7b28975ac 100644
>     --- a/Makefile
>     +++ b/Makefile
>     @@ -3219,7 +3219,7 @@ test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(
>      
>      all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
>      
>     -bin-wrappers/%: bin-wrappers/wrap-for-bin.sh
>     +$(test_bindir_programs): bin-wrappers/wrap-for-bin.sh
>      	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
>      	     -e 's|@BUILD_DIR@|$(shell pwd)|' \
>      	     -e 's|@GIT_TEXTDOMAINDIR@|$(shell pwd)/po/build/locale|' \

Yup, I've already got this exact change pending in v3.

> There are several ways to fix it, but this seemed like the easiest. I suspect
> that you have already fixed this.
> 
> Having determined that the 'make' build procedure seemed to be unaffected,
> I now tried the meson build. I had to install meson at this point (ninja
> came along for the ride). I have never used meson or ninja before.
> 
> At this point I had to fix another fallout from changing the base:
> 
>     diff --git a/meson.build b/meson.build
>     index 338d472bc6..54557eee03 100644
>     --- a/meson.build
>     +++ b/meson.build
>     @@ -194,7 +194,6 @@ libgit_sources = [
>        'reftable/block.c',
>        'reftable/blocksource.c',
>        'reftable/iter.c',
>     -  'reftable/publicbasics.c',
>        'reftable/merged.c',
>        'reftable/pq.c',
>        'reftable/reader.c',

This one, as well.

[snip]
> So, keeping in mind that I know absolutely nothing about meson, it seems that
> the 'configure_file' function is mangling the 'gitweb.perl' file. I assume
> that you are not seeing this, so I suspect that you are using a newer (fixed)
> version than me. :(

I didn't, no, so this is quite helpful to me.

>   $ meson --version
>   1.3.2
>   $ ninja --version
>   1.11.1
>   $ 
> 
> This is on Linux Mint 22.1, which is based on Ubuntu LTS, so not that old!
> 
> I am about to try converting the Makefile 'procedure' into a shell script
> to use in both the Makefile and in the meson.build file (I see that the
> 'configure_file' procedure can take a 'command' to generate the file).
> 
> Note that '$project_maxdepth' is a snowflake in the make procedure! :)
> 
> Any thoughts?

I'll investigate tomorrow and come up with a fix. I'd prefer to not have
to script our way around this, as eventually I would like to get rid of
shellscripts in the build system altogether. But that is something for
the future anyway, and for now I'll do whatever it takes to fix issues.

In any case, I'll try to reproduce the reported issues tomorrow and will
then come up with a fix. Thanks a lot for testing things!

Patrick
