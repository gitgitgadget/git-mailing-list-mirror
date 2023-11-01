Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A986615A8
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 03:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h+H+pkrC"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EC5B9
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 20:33:48 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 49F821C3D57;
	Tue, 31 Oct 2023 23:33:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=u/B5SVXUSaXpkSnnqaatrqXBmPafeReoWj6Cp7
	8dnBk=; b=h+H+pkrCe9uEqjsLqbAcDfl0hhNlRMBx93HDreOSD6u1j3UABbffMP
	eH5kE1/INawVdRhkMc1k6z98i66h3qaj7z384jrsu/vUfxMKI/J5snf9QLBE3Zo5
	MTN1zGCBrsdnI29JDET1dHRASUMIaoSBBubJ6eqrfAcOJolX4XyQw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 414AF1C3D56;
	Tue, 31 Oct 2023 23:33:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A202F1C3D55;
	Tue, 31 Oct 2023 23:33:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: phillip.wood@dunelm.org.uk,  Oswald Buddenhagen
 <oswald.buddenhagen@gmx.de>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org
Subject: Re: [PATCH v2 5/5] ci: add support for GitLab CI
In-Reply-To: <20231031193629.GB875658@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 31 Oct 2023 15:36:29 -0400")
References: <cover.1698305961.git.ps@pks.im> <cover.1698398590.git.ps@pks.im>
	<37a507e9b255dd40c0536438dfe3fa05b067f08f.1698398590.git.ps@pks.im>
	<ZTuYjzOfG0y27Sho@ugly>
	<d00b02e9-fb05-44bc-90ee-1851ef98dd26@gmail.com>
	<20231031193629.GB875658@coredump.intra.peff.net>
Date: Wed, 01 Nov 2023 12:33:45 +0900
Message-ID: <xmqqil6mw3ja.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 76E5E296-7867-11EE-B8B2-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> So it's possible that avoiding "export var=val" is mostly superstition,

Thanks for digging up the old thread.  I would not be surprised if
it was already superstition back in the days.

>   2. We won't really know if there is a odd-ball shell that rejects it
>      unless we make a change and wait for a while to see if anybody
>      screams. The existing ones in ci/ show that it is not a problem for
>      the platforms where we run CI, but I suspect the scripts in t/ see
>      a wider audience.

We could start with a single weather balloon use in t/ somewhere to
see if anybody screams.  It would be a good place to start if we
want to get rid of this particular superstition.
