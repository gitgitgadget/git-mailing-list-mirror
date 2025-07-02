Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CA932C85
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 02:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751424898; cv=none; b=OA1CIflbH+pAVht2H6jBMNuFcvBRi+S4g1vdHJHD77/JhAeGURSU8Z0tDeStboLVUX+f2rA8MY8P0l1I7Bg+bp23Xda8lP9f+LkEU8H0yeu7irqgV2UTtVCa29BsBZKg9c0T7in2HFBiAYTGsd/uIoBZyCEU6H6BfTc45XhcXK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751424898; c=relaxed/simple;
	bh=n9S2nxsSDSuY46Ewlhe7zKQhm0erno4TsqIYUTO2738=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fb3nG/jd/UA5fq4RjMBdMdM3eQr2wsfq7MVkacqqRJU2dZzjC5t7U8kZ091wdf2TzVVJAWDCMNtvCjvIpMnUfFiN5p3IGF22drxcSimCtDdj48ZhHVMB5cXA4OIwQhSCgXph4Ez/kUehIiNUjrQgmrnZ/8Mj9y/6o7ocPCNLCkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VE4HPIYL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NHmWDnWv; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VE4HPIYL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NHmWDnWv"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CBC9F1400335;
	Tue,  1 Jul 2025 22:54:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 01 Jul 2025 22:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751424895; x=1751511295; bh=RY9H9jC+qr
	lk8+g7I+EQhlH4ybKSGaxb4Cos5AnoqLA=; b=VE4HPIYLhEl8x9vcSgM9k5aHFA
	WV3aDAuQzWKfxcvHvofXXKDGurifq/r0Q6JtNyKJgHALSWHuNyOOV9Rx04q9hcDu
	ZGLiI1TgLMY8yBzX4fCWi/ufKwIl/51U8vWiL2JIy9z8F3VHqr4Uvr1lbFArpFNT
	SWW2P53QVQHMXChhjeCHfFlIdpQnCYI7nCOCa94eLSG7oHElgRox1lfs7OqNl4AN
	jvS9An4Kx0EViv5zncp4kRKWCablUA61R9sfuuXEo06rBA4/Y1MAV7IkaldzbtPj
	/0tE/z/ndwC7c//RefBsHj9qLenYRu6PuH/p/2gkL5IgE8tgvrJS2h6jSfbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751424895; x=1751511295; bh=RY9H9jC+qrlk8+g7I+EQhlH4ybKSGaxb4Co
	s5AnoqLA=; b=NHmWDnWvtI1MWmDrmk/6YmASlehSOjjGB5LlMz/0GC02HqqMYMF
	/lkpPD2e6xEDKD5qLLkKnftK7SjusNKLK4F+HZwp8GDZb1MNP8r1itt+ygBTb487
	iQpGFAZim5lxeUejX4wa5iM3Ov/1kejc+arClClTzmicxBRHl0l4x7JeuFrB+di1
	vrIsMe5yimH/hy6XSXXG8amGhElNcmuY2jnZFXLjsxYOeBSiWIXuBDQ4ckzd/h2p
	/Ksf/Uvt6rRoI+D/Z/Rtl/Ub8mXJo3CTv1h3JYfzbxzF60hFWZuoLJuR5V8gl6d7
	BcHQYeZHjXYxLoA9k8p4WhLbAQHj1XPx4kQ==
X-ME-Sender: <xms:f59kaIQuyMgM_5Fv-qYBNivLPBuDDEAeYKMgLloSYmPDPVm9DegPeA>
    <xme:f59kaFyCrPgWWFURI1HGkNMivI1L-b4x7O_nQLngHSRpBCrQEBkKr6kllui2_OmqV
    0R7wiXd1VC9vL1dgw>
X-ME-Received: <xmr:f59kaF2Bwsp3Ha3_QAPNhw5k1nZ-TQGq82ar1Poub1EFIXQnV4DobMqGom3ASOdeu4GJU2TKPsU7Vec6gVWmR-JByM6MjcORPUoiMA0X9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejtddtgeffkedujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhig
    fhgrmhhilhihrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopeht
    ohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:f59kaMAOqkH-Gmx8Cs-nfRBPXU-a4nXz8nlIypWKiHNBNFKUtqn9UA>
    <xmx:f59kaBiM7BPztVFiCJ24kFfUAO26uDPf_TAOuS-NMFdCmgJcXNTULQ>
    <xmx:f59kaIrSm3jAyTxwi2Tywy7VNjpWiaYKr46Nnq5Gih1XLqhAOsJ4Cw>
    <xmx:f59kaEgyVo_2qkTWXsc1thQmmsP7fextKc4PUluXJQGk9URliITILg>
    <xmx:f59kaPBlCO8XsGvFeOeAshgR8JehKeLUcr8WOsF4zrHUDNtzFFnDRKoZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 22:54:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c45a7694 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 2 Jul 2025 02:54:52 +0000 (UTC)
Date: Wed, 2 Jul 2025 04:54:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	chriscool@tuxfamily.org, jltobler@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 3/3] meson: add rule to run 'git clang-format'
Message-ID: <aGSfedFVoMnhwZbJ@pks.im>
References: <20250630-525-make-clang-format-more-robust-v2-0-05cbcdbf7817@gmail.com>
 <20250630-525-make-clang-format-more-robust-v2-3-05cbcdbf7817@gmail.com>
 <87bjq4qbxi.fsf@iotcl.com>
 <CAOLa=ZT6-Ea9iaNgYymmT6s5mjWk4i4RxZjcr+7G6HUbg4GdHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZT6-Ea9iaNgYymmT6s5mjWk4i4RxZjcr+7G6HUbg4GdHw@mail.gmail.com>

On Tue, Jul 01, 2025 at 11:12:16AM -0400, Karthik Nayak wrote:
> Toon Claes <toon@iotcl.com> writes:
> > Karthik Nayak <karthik.188@gmail.com> writes:
> >> diff --git a/meson.build b/meson.build
> >> index 7fea4a34d6..20ce0525a1 100644
> >> --- a/meson.build
> >> +++ b/meson.build
> >> @@ -2144,6 +2144,18 @@ if headers_to_check.length() != 0 and compiler.get_argument_syntax() == 'gcc'
> >>    alias_target('check-headers', hdr_check)
> >>  endif
> >>
> >> +git_clang_format = find_program('git-clang-format', required: false)
> >
> > I think we should include `native: true` as well.
> >
> 
> Does it really matter here? I must admit I don't understand the
> repercussions here.

It doesn't really, as `native: true` is the default. But we explicitly
say whether we want native or non-native binaries for all the other
calls to `find_program()` to make it more obvious, so I think it would
be a sensible addition here.

Patrick
