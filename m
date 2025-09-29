Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E8226B76C
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 23:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759188114; cv=none; b=r/4lVxMc9zRGDQ4DOxveb/I2Mf5cmlmgTm65qp9J42JX0TWv8KVBhrXFi3KZ/Sj81wWPPxe3VmmwPVoqBrvIbxckLlvW/K9pqqGwDt4pSr6OHFL/2t65qzNY7/Kt9yyGEvoqaejLSNaMlEUd2emneSYPp/Fn46bgmpWNl/5q30A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759188114; c=relaxed/simple;
	bh=Ll+wg2kHpb/EpIjEkSR5xWPubnZsxHcwRq6yiPavbkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8XD2rzOuXL6U5VpqccbdE7Do9U7rKJH2DluTI+g2UjOILO22C4uwdhI9/J7Fk9BvWn9rjXuX6dKutPZO9RZ1s+nKLX2/HgZSdaADQwm1Fbo/g4bBW2GQrxsmkYvD4NME2oqSk5JY9RM+VacoYju73ddntqo0ioSgokqB653i90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X2fDl2Mt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pEF3OOBG; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X2fDl2Mt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pEF3OOBG"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E7D5714000C2;
	Mon, 29 Sep 2025 19:21:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 29 Sep 2025 19:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759188111; x=1759274511; bh=WRq2NgGSlR
	DvVKY1Nz+ay+3RqUSSiqFYLG+xHUN6+DQ=; b=X2fDl2MtfKDWdqtmT3eVh/Wlnx
	72Za1FUFSo3RvJcHCaBlXReGqM0UmJgv0pKG9Y81oEgabvrMKP1V8SiXVVHOJafO
	xFQvbEkOWNKIfYXlGBkL8xJmkeDGcIOwttUr0hUyV4L1WrymBBvnRYwq5Bp2AcSr
	3wFSetALFOL23sS4ty0+aNl0Fcp08uSAgwspGKRlHJpfS+Is7Z6dEvgLp5yq+hcy
	+BOUdiczDH37Ytu5vsBX16bUQ442XL0jgfZKaZvrnl70atHywz79XcdoW6JXNf0g
	V7ymBzte+C+Km1SLasIeT0AwJvkBW4j6fVUCeaac3eBvqbeXaKjKK1k7n6aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759188111; x=1759274511; bh=WRq2NgGSlRDvVKY1Nz+ay+3RqUSSiqFYLG+
	xHUN6+DQ=; b=pEF3OOBG2hKbaEj6e9nsdtRPvq13PPPVqqfkIDVn2tDoofpnfQc
	nKv9sW+m24VP68q4f9KHgi7Pu4XkX0Jsjz1dW9k+LELI0Kk7LSDmQMvJXig15cDK
	63I0BsJ1arR1aq7hyRGLdIMKtaLSxBTitPrQ/4su9kjR+edXCkWEOeNSue6Z+VGp
	1yRXDCus4GXpUFlrzL+3GQd14SCbPvsjcXXpdFrh5fqp92T/mJnALLHBas1DL6EL
	KfqR8Neu0ptDBuIl3si5eF4ufZWAoFOf+Wp6iXJJ2s5fPL2yH8I/PEp2wxf0ZoB/
	RC2tGZZzPDeoKfR49N8qIJR8pyJyTEq3ShQ==
X-ME-Sender: <xms:jxTbaLJiKTSZhNLZSWjqx07tGJ_-patUNZyKuChUQL0GBdTBHjf-dg>
    <xme:jxTbaC0z1LPThKYQ6d9Fv4gXX6Eto4Qur6Id7RWgb8sW-HGv0oc_NlFuVPDEf0Pc9
    C8V7Vs3qUi_MqQSL3mk4K6nSl73pmJnBb_jcyhFpOlZI1EHtp0f2A>
X-ME-Received: <xmr:jxTbaNiSk7OpzjUn0OLadu2Zto460rC14kcUo4Q0whS2F2BH2pjFAE8vYi8jUwcq_OY8JwzoYY6hgJst-_yuwQPQ_GK854m2PbyCPxRvVlc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihloh
    hrrhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:jxTbaLUF0Z6mYnHDWC9PCYZAfJYQ0x3W1awYwP2nPoeD37ulAZWobw>
    <xmx:jxTbaEXbcQmPgpOKAZRE6-3SDDn3fhuTqiV3QWpVqpxUlPy_cadZKg>
    <xmx:jxTbaDh5RtmfeQ-5_lNiLVAfPgOop0-oCxQDoyU1RGjZvyCQrnpssw>
    <xmx:jxTbaHZjkjF22nc8SPbEcVzpHcML7435fsCHtm7kW6PhRlxagrS8_w>
    <xmx:jxTbaCk_Mrag4_1z5fjAf_2IfrijuH9EM6oVUA_JnpP6gbnCrJUM_yMi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 19:21:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b97b2111 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 29 Sep 2025 23:21:49 +0000 (UTC)
Date: Tue, 30 Sep 2025 01:21:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 21/49] builtin/repack.c: factor our
 "generated_pack_install"
Message-ID: <aNsUiho56-S4MQZg@pks.im>
References: <cover.1759097191.git.me@ttaylorr.com>
 <96d27261e75fd2ae46d9633b3d4eff243dbcc187.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96d27261e75fd2ae46d9633b3d4eff243dbcc187.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:08:31PM -0400, Taylor Blau wrote:

Is the "factor our" in the commit subject supposed to read "factor out"?

> diff --git a/builtin/repack.c b/builtin/repack.c
> index a4d80b6b04..8c3a5f4f80 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -1434,35 +1466,9 @@ int cmd_repack(int argc,
>  	/*
>  	 * Ok we have prepared all new packfiles.
>  	 */
> -	for_each_string_list_item(item, &names) {
> -		struct generated_pack *pack = item->util;
> -
> -		for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
> -			char *fname;
> -
> -			fname = mkpathdup("%s/pack-%s%s",
> -					packdir, item->string, exts[ext].name);
> -
> -			if (pack->tempfiles[ext]) {
> -				const char *fname_old = get_tempfile_path(pack->tempfiles[ext]);
> -				struct stat statbuffer;
> -
> -				if (!stat(fname_old, &statbuffer)) {
> -					statbuffer.st_mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
> -					chmod(fname_old, statbuffer.st_mode);
> -				}
> -
> -				if (rename_tempfile(&pack->tempfiles[ext], fname))
> -					die_errno(_("renaming pack to '%s' failed"), fname);
> -			} else if (!exts[ext].optional)
> -				die(_("pack-objects did not write a '%s' file for pack %s-%s"),
> -				    exts[ext].name, packtmp, item->string);
> -			else if (unlink(fname) < 0 && errno != ENOENT)
> -				die_errno(_("could not unlink: %s"), fname);
> -
> -			free(fname);
> -		}
> -	}
> +	for_each_string_list_item(item, &names)
> +		generated_pack_install((struct generated_pack *)item->util,

This cast should be unnecessary, right? `item->util` is a void pointer,
so C should do the cast implicitly.

Patrick
