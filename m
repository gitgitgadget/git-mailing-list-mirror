Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2352033E
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 19:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740695; cv=none; b=aIz+LJmHwfVXFDdIooJEA5YfwcGv2mGcO+nmrkLYuGAsFckexkL6oUUF7gcVD7PDzM/FHZf35S+M3ycKVelOSITkbApwjLn9AfjnAC1JeqUtdaId2hO6fSkAtrHty7Bzxh621oYV5wxRFua96/167ahjgD2humvBBERX2sm/jms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740695; c=relaxed/simple;
	bh=sO85QdIil9wywobhG7romXamtWU4a55y6dlsfJ251d0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AGZpCVb/m7Pbh9nYuvQvDWVhJUXYSOnO7vzu2gkL3Dz04Hg13NHxyBFp8yddsRraTjYS3znOq+SAoZUrIa7jZIcmTs+FyGeC0Ea+hxZbFjEPSdUhrc5UD9fcCP9A8vKznqo8MfJ+fo9sFuDyK+p08RLh8szMxJvm8kB0UAdwwEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JsoB+ZTH; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JsoB+ZTH"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F8331E6B47;
	Fri, 29 Mar 2024 15:31:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=sO85QdIil9wy
	wobhG7romXamtWU4a55y6dlsfJ251d0=; b=JsoB+ZTHIkImDvvdhgp5eExNLj3T
	4tT8JQXvBP+2GHGMovCoJ2d5FcQcIlsYNb7AIxrB9vBaB5RvxW+jbAmVi9YatFDq
	aPwHV8koRtyqWzFT/ilZDlG21tNPHv3edCeqSOu8fIwyFgLPsz7/q/BwpRKgQlxe
	5ftJkY57Tcr+gyQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 887451E6B46;
	Fri, 29 Mar 2024 15:31:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EC6491E6B45;
	Fri, 29 Mar 2024 15:31:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] add: use advise_if_enabled for
 ADVICE_ADD_EMBEDDED_REPO
In-Reply-To: <de916779-3c0c-4cf0-b78e-d0536c65af0e@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Fri, 29 Mar 2024 20:04:04 +0100")
References: <06c9b422-b22e-4310-ad5b-1686616ab860@gmail.com>
	<0e38da05-efd6-451e-bd8a-b2b3457c0c75@gmail.com>
	<xmqqcyrczzv7.fsf@gitster.g>
	<de916779-3c0c-4cf0-b78e-d0536c65af0e@gmail.com>
Date: Fri, 29 Mar 2024 12:31:30 -0700
Message-ID: <xmqqjzlkygvh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F2700084-EE02-11EE-94AB-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>> This one also needs a similar justification, but with a twist.
>
> May I ask what you would find a good justification?
>
> Perhaps "newer" -> "now preferred"?

That is merely shifting justification around.  You'd now need to
answer: Why do you consider it preferred?

A few obvious advantages of using if_enabled() form are:

 - you do not have to give "here is how to disable this piece of advice"
   yourself.

 - the code can become shorter.

and they may make it preferred to use it, when appropriate.

> Good point about the naming.  I'm not so sure about the "only once"
> part, but I do not have any strong objection.

I am not sure what you are not sure about ;-).

If you are adding a test for a feature because it is not covered by
existing tests, and if that feature consists of two parts, it is
naturally expected of you to cover both parts with the new test,
unless there is a strong reason not to.  No?

I would understand if you said because of such and such reasons, we
should not cover the "two instances of violation, only one advice"
half of the feature, though.
