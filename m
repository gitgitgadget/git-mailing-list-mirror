Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5581F3D56
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786467917; cv=none; b=Ty1KOImMJnUsuDx1DCX24vV1wEllUE+hC3cThihgFpdJ7G7Ul4MUaYP/X6wcqVd4kHaZr4/onvcrdPby2/wQ9nUxKDPgtiJsVXW6Cdb8XB5OOm553X2aqj9Lm3R/MWvm4ylSTH/3KePHm3u0llSQ8LIHx2j+NHMpa/udmWy1YHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786467917; c=relaxed/simple;
	bh=0xZssW8Uy0QUrZ3IyIjDjtkBxNL6gJF9c5XqBep8rdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbATLA2AQZ/RkGmtnx26qPhwbk6eIUCVEiamf0mrl0MUYIPXflnzeRqWqSSKbIXsodKJKyHzEyYNKtn4nU2Av7UU3/c3GWp3cgzJgasHBiuYHVLpwcz+FujYStWd5ouZqPRYKxb90tnA6p6OyN8Bu3giImmy5Tr9ZDJxfDAH+II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AmTRKu4C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fb497Oko; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AmTRKu4C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fb497Oko"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 704001400150;
	Tue, 11 Aug 2026 13:05:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 11 Aug 2026 13:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786467915; x=1786554315; bh=tAmdsJ7Dx9
	VFfb5ssng5AANovDMJZJgCCL+vRGFfjkM=; b=AmTRKu4CimlSUKytCkiPCAM55R
	eCcBOQEn75eepZmPDDyO1le5mNxKXy6MdVdAdbBQMB5Lv6cIeCXtmQSG1UHhEf0D
	ssnjAamJGP+2l13nAE9TidM3tZV+5RZpDOSoh+Caxr6j09me4EzExaA4z5lcvXvZ
	bgxqaKo5itEJeioEVNLsxOCyxmGeu/PhDQjJu7bRuOxI9TUVvZ3YlaQyh2F0Z/yw
	6IhoY8RhOloXL8Y9QuP3UObXWnWEMaRAy8rEgAGAx+zG3b1dsEOfq8OKlTkwg2eM
	CAQvvhHkHSsmIjlvBTnmnXY65IhAfEfpsd62QH+SV5ASx0XaLEtOXT7XSllg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786467915; x=1786554315; bh=tAmdsJ7Dx9VFfb5ssng5AANovDMJZJgCCL+
	vRGFfjkM=; b=fb497Oko++yB/ukZSWN0ai8i9GzqczSc3M/XO1p5bFaw9xBd/Wh
	Lz48hNOZa9tzTuMji32FjdplBd4n3zvYrgBed0INIUgnTlOIK8FEX5Pifd6sTwxP
	HxDrb6aCsZSF4JGyHwzlaLLfdGt5ltuatVq6C6HQchoweVrGxztDVhJeDpeURHY8
	1Zs3tG6jHs8s+/UjSXN4BlbuLMq4ouSQXaHKDS3uoVO42WocxEr5die3FQA9fpCh
	tQoUAN/u8kLQsocz1aQ/VWHRnNCbwsuf5dGRPi4Rk+y+yA+J6yj0b87oHPiu1fZL
	fXmNxPPzH2ic11Mfo/eZ6PhHxgL+dfF4yZQ==
X-ME-Sender: <xms:S1Z7ajhrBZrVpr8CD52rBBs_1a8e2GNoy3jEe3mBZ4XjL3c8i_vlfA>
    <xme:S1Z7aqAULE-LgyFys0REil3EPJ-9hiv78B8EXpTirPYxNoeE2x9u6PFhbhAKYCOr6
    vSMcWfqNhlzfW16GJi0n7n01W5igG-HT85vUDCPL6KA1wqlgsK2Gg>
X-ME-Received: <xmr:S1Z7apsWCzy2ftcxQVPNgNeXhWCsVyfN6tFDwwo-Ks8-gFhgqZVE-fQQWSQJWvNSKHsWLhjwVNZJEnJY1QlxdmOct7IyzjK-2OcIZkgHnw>
X-ME-Proxy-Cause: dmFkZTGnB9STaXix3/SsZ0cJe8WxTrSTk5mJ6qoi1CEoZFh/hBGoG1RJqcPYtYcvEsdz1O
    2cg67JDT5P4vRB39gHDILSMvP06+pG2zpbxBk5HJbcoXnwiWZOQCDWE5iBwlocJGVbBYX9
    m4k/flVqmO17PGn9134rBF9FqB2MJ4OT7vKtk6s8d7JVEJ0Ub3SqJwTfKUuoGIhx4qlBRM
    hluGgT4/kkkbpSfkYVCTuci9KQC0zmIA573r5pNZ5sappopV17dGPxg0TfBlS8QssE1zf4
    46CWKtB0VfQGdcO+grbqJqullQ/O2pxKtFhMuiq3+sMTW9hOnP+uUX9bhSflB+nFJOF5g4
    JnXl5xsSpJmIqOARjA5zs86o5G5x1KperU2uSOQakmmdlQpGbSifGcU6CTyJ7BVrcJQ8T5
    kri4CyflKeddsbYq7ZjoDkSzMsChcMsfqUIFfUR2g7jGnKo+aI3WaigepFaJmQWjRSJSf7
    y+rD0OpjErq1xRRETNubEL5gEjyfpL0iOeOz9r8K6wL5/No1PAa5kr6W8/28wVQK+2hNKg
    OQJcsU5pvxM9zePOLUlEY/rIR/PSVrsF37+y5FsleEBmI96DIPR6riKS4hl77Yywlm7w4n
    xep7VuQuA0V9B9rf/dZAY6kRPMvaS/Zus9+qgKQ+do0NWZjM3pkAdBWSo7Ug
X-ME-Proxy: <xmx:S1Z7auffo6iYb-a87qxa9v0Hm5QkWPEhS0XX1UZaxhtJQVgdvf1uHg>
    <xmx:S1Z7au8vp0bK-pcfiXMqv6FB7khJrTFRQvN0qSPjeH-fs0QPpI--Vg>
    <xmx:S1Z7ahQDSO8dEP9upyvkx6xGsMBu7quKt0KNBFhXM7Oz8tS7ywN95A>
    <xmx:S1Z7anoc-0luRo0oMOCvLxuw7taCwTS6oKDljsfqMsVvFHwk58-6ng>
    <xmx:S1Z7auQWS0cbOanng8JwUYJ4SfQtYnRQCZksHkFTR0WHfeFyvYs8Oxt3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 13:05:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2e1f794a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Aug 2026 17:05:11 +0000 (UTC)
Date: Tue, 11 Aug 2026 19:05:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH RFC v3 2/2] Move libgit.a sources into separate "lib/"
 directory
Message-ID: <antWRHPHHES4a1KT@pks.im>
References: <20260701-pks-libgit-in-subdir-v3-0-5e4860056094@pks.im>
 <20260701-pks-libgit-in-subdir-v3-2-5e4860056094@pks.im>
 <alR9GDNTbdjWB4dq@szeder.dev>
 <2d455ecf-972e-e3ce-54bc-683050c04282@gmx.de>
 <xmqqjyqpb96n.fsf@gitster.g>
 <ansSg4qsPwh5FcR9@pks.im>
 <xmqqpkzo39d2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpkzo39d2.fsf@gitster.g>

On Tue, Aug 11, 2026 at 09:33:29AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> ... built-in commands in 'builtin', with subsystems like 'refs' and
> >> 'odb' in their own directories, and everything else at the root
> >> level, I would prefer to keep that organization until a substantial
> >> subsystem update wants to carve out a new location for itself, just
> >> as past updates to create 'builtin', 'refs', and 'odb' did.
> >> 
> >> Compared to those past moves, the proposed change looks more like
> >> churn for the sake of moving things around, without achieving any
> >> real organizational improvement.
> >> 
> >> I must say that I, too, remain skeptical.
> >
> > My main motivation isn't prettiness though, it's newcomers to the
> > project. Git is not an easy project to get started in, and the root
> > cause of that of course isn't our file layout but probably rather that
> > Git has been growing organically for 20 years. But the file layout
> > definitely doesn't help newcomers to find their way around in the
> > product.
> 
> What I gave as good examples were not motivated by prettiness,
> either.  Moving things around to lib/ as a whole ball of wax without
> further classification would mean readers, whether new or old, would
> not benefit from neatly classified set of files that gives readers a
> concise and easy to understand rules like "you can visit builtin to
> learn about individual command implementations".  To achieve a layout
> that makes it easier to find our way around, you'd need to move
> things again after moving everything into lib/.  Moving to lib/ by
> itself does not add much value, if any.  It certainly does not add
> any discoverability.

I think that a cleaned up root directory is by itself already adding a
lot of value because it makes the entry points into the Git codebase
more explicit. As I said elsewhere, the value is not in making the code
that is part of "lib/" itself more discoverable. The value is in making
everything else more discoverable.

Ultimately though it's a subjective change, so it's hard to argue about
that as I cannot present any hard facts.

Thanks!

Patrick
