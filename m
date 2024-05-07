Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4D61635CF
	for <git@vger.kernel.org>; Tue,  7 May 2024 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715096819; cv=none; b=rTUh2ILjCd8uqsLEJ2kJXn04Y+of61UxqI3NkmGLrrQG/qDmmKuVs4qE911FPtmIL7fxjcr4QXY3hw0O84Hz8nOz/Q+UFaWE3otk0ULBsAA1opdrMnQ9VVCalFCG2Cerf8K1VqvcVPPdlmlXJYAjTp/OCrzctmMfi7KCoQt5xhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715096819; c=relaxed/simple;
	bh=YuSl7h+hZMD3DMfJToFjQD2Fq/mN53E1Bo2XaR+O1t0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UCJBonFIAPF/0e3pdXE0npukdMLO+d74Y74EFvoCKGOXDPLJv+UOZe0AQUKaLVdXuwR6TBilysz9Tc3wK/ERLShxsj4bh+UcNfQBfTdDGac1AhzdSWcIpJfc0sPWCrwj7kphsgCP+nDrUifNHz3xRQV3oZeDkxURNXvvfT1BAIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cOWQh/UG; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cOWQh/UG"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BDB2C1EBF1;
	Tue,  7 May 2024 11:46:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YuSl7h+hZMD3DMfJToFjQD2Fq/mN53E1Bo2XaR
	+O1t0=; b=cOWQh/UGIRidPUnM9PEpDjI33ME0xEhDi/D3vAYPzbimqbEexWgUbG
	mgYnUPTchyuLMlyqmk2Ratxp8E0A2jjwD95XwX2xQpOQZ3azZhtxKhFIs1n7ZCbU
	GwzPffWediRBaovybho3nOdNJyaTDtur08oZ5YiHjn4BxqH2w0l+8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B4A621EBF0;
	Tue,  7 May 2024 11:46:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 046A41EBEF;
	Tue,  7 May 2024 11:46:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH 0/5] refs: remove functions without ref store
In-Reply-To: <ZjnKfllMW9rGgWPL@tanuki> (Patrick Steinhardt's message of "Tue,
	7 May 2024 08:30:22 +0200")
References: <cover.1714717057.git.ps@pks.im> <xmqqikzu95cf.fsf@gitster.g>
	<20240503173553.GC3631237@coredump.intra.peff.net>
	<xmqq7cga7nzo.fsf@gitster.g> <Zjh8XWwJKp_I1dwE@tanuki>
	<xmqqseyu3ojk.fsf@gitster.g> <ZjnCoaVP9_wuYiHh@tanuki>
	<xmqqa5l2ta7e.fsf@gitster.g> <ZjnKfllMW9rGgWPL@tanuki>
Date: Tue, 07 May 2024 08:46:53 -0700
Message-ID: <xmqqwmo5sjyq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0843838C-0C89-11EF-92FE-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> What I had in mind was a lot more stupid like the attached.  For
>> illustration purposes, I just did only one, but you got the idea.
>> Thanks to "#if 0", the compilation will fail, the compiler telling
>> the developer "resolve_ref_unsafe()? what are you talking about?",
>> and the developer will grep for that name to find the hint at the
>> end.
>
> That works for me, too. Thanks!

And if I replace 0 with USE_IMPLICIT_MAIN_REFSTORE (which is never
defined anywhere, and only serves for documentation purposes with
its rather explicit name), you get an exact implementation of what I
meant by "an approach similar to USE_THE_INDEX_MACROS".

Having said all that, as I expect that the topic itself will go
through smoothly down to 'master' (once a topic hits 'next', unless
it still has dubious parts, it usually takes 7 calendar days before
it goes to 'master') because the other parts of the series are fairly
straight-forward, we do not need anything more than just removing them,
without the helpful documentation in this case, especially given that
the adjustment other people need to do is very mechanical (and the
recipe is already in the coccinelle step).  They can notice that
their new call to resolve_ref_unsafe() does not compile, grep for
resolve_ref_unsafe and find nothing, and then they'll know to use
"log -Sresolve_ref_unsafe" to find what series removed it, what
happened to its old callers, and then adjust their calls.

Thanks.
