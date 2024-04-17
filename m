Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84C2140E29
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367653; cv=none; b=nKnYS++ortaLU7VD49mpiNugF5jLm3Tv7h+veaCshaXSTPBbHbrDLhFOd99VO202wNDGgvFu84/EaPvESDS2tvelOQDaayxYdiHJgCeU0gmNMgv2nhhwk/lgcQ2seaTiK91bK9N5UtsMWxGgQf6Z1DRZzGe21sGnOlTCsozCkkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367653; c=relaxed/simple;
	bh=B5IZsmW1+ZmjzES6aQlVQzgopAOx3R4r5Ry6NJCy8u8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IcjVp5DnwDc1dyD0YRT8PcPp/UMFhvecJT8doT/wv/PrjYSYfVxMi2y/EhtbPfFnG+HVef/HVIrSw7/ElHuxxKCv7ymMX60SRoME2MNcUCtTwbbWjMbBLcP6UcFFxvlEqIgNuGtRmLuBP0nktXxnOjw6hkVUMzfcU/VV+WUXiJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bcqUDc7x; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bcqUDc7x"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B342192F2;
	Wed, 17 Apr 2024 11:27:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=B5IZsmW1+ZmjzES6aQlVQzgopAOx3R4r5Ry6NJ
	Cy8u8=; b=bcqUDc7xJ1hirtDJZrJOUqXf8AXlXh+Juf4FVEV/HZyCsqYiVPZcTe
	2uBkPgKYrENPnjqL8sWK8QilLrctAr5s4OdBjH+gx7veC4KvE/FBq7KoJZtqLd8+
	wi6bb3ScBgn5GyShomdGGiJCj/cIva52z6X5p7gubsNGndBnboa6A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5270B192F1;
	Wed, 17 Apr 2024 11:27:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E70F1192F0;
	Wed, 17 Apr 2024 11:27:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>,  git@vger.kernel.org
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding
 "RESEND" to patch subjects
In-Reply-To: <154b085c-3e92-4eb6-b6a6-97aa02f8f07d@gmail.com> (Phillip Wood's
	message of "Wed, 17 Apr 2024 11:02:28 +0100")
References: <cover.1713324598.git.dsimic@manjaro.org>
	<1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
	<154b085c-3e92-4eb6-b6a6-97aa02f8f07d@gmail.com>
Date: Wed, 17 Apr 2024 08:27:24 -0700
Message-ID: <xmqq7cgwau1v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FE93CB5E-FCCE-11EE-8149-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Playing devil's advocate for a minute, is this really common enough to
> justify a new option when the user can use "--subject-prefix='PATCH
> RESEND'" instead?

The same applies to "--rfc", but the justification goes like this.

 * When you are working on a single subsystem in a larger project,
   your patches would want to carry the subsystem name.  You'd use
   "--subject-prefix='PATCH frotz'" (and more likely it comes from
   format.subjectPrefix in a working repository dedicated to work on
   the frotz subsystem) for that.

 * In the context of working on that subsystem, sometimes you would
   need to mark your patch as a RFC patch, i.e., "[RFC PATCH frotz]",
   and that is done per-invocation basis (i.e., you are not always
   constantly sending an RFC) with "--rfc".

Having orthogonal two mechanisms whose results are concatenated
together is handy than having to specify the whole thing.

I somehow thought that during the review of the "--rfc" option a few
ideas were brought up to deal with adornments other than but similar
to RFC.  I still think the approach to make "--rfc" take an optional
value, e.g., "--rfc=WIP" from the repository working in "frotz"
subsystem would produce "[WIP PATCH frotz v2 2/4]" a reasonable one.

cf.  https://lore.kernel.org/git/xmqqbkepep9k.fsf@gitster.g/

Thanks.

