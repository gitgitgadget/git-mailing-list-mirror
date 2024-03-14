Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB48D2E410
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434754; cv=none; b=qAopwB273IHSM5FFCIokmPSaHwGTp22rXcVkXgoA+sc9QAo5RIt3z2PPS7BA3cRb+kkaN0gNNGhPYsqqzvDby95jDvePzfU+668gC2SPpXWKZEVjJcmbvBPQpyTuLDhnuVhnLNPqdwZ0pddYyo3I70nwT4ji6SHd5m7wVpksHzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434754; c=relaxed/simple;
	bh=gZ3brBv7voZkmv6+NQZLQxPvN4H41TWuxqm6Y0ZtGDw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iRAqx155VJh0LLEGjVKWZVEiUGNj/Nex3LmaJYWGKHxmBWGyOIRvnz0skoz+yBYYRWawhMvFe8mgm3Itn7VVSSqLPVCgkpDRZAOYdZikoWwO88Iua3VOokboEBE8+/99ndZvBSP/N3JLMtD0QnHkJ1RwAZW4coDbckpEEijpVa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OKNPP+Tr; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OKNPP+Tr"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 282C22974A;
	Thu, 14 Mar 2024 12:45:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gZ3brBv7voZkmv6+NQZLQxPvN4H41TWuxqm6Y0
	ZtGDw=; b=OKNPP+TrDxHQ5Dp9K73cAH2kIdOpfryXJrIlMAdo0oB0jIxOskGuCc
	TZWT4ezaO3IUNn8G+IxGbTvAH4p0HYNc5Y9dUdHtz9fKQr0NVKgyPfeOE4WXzeMt
	5l+M5V4dyek1P6xLFLcETLDSBVhfUOuNoHZU2RZEwANZDhBEUoib0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 214FC29749;
	Thu, 14 Mar 2024 12:45:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B9DDE29748;
	Thu, 14 Mar 2024 12:45:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  rsbecker@nexbridge.com,  github@seichter.de
Subject: Re: [PATCH 1/3] config.txt: describe whitespace characters further
 and more accurately
In-Reply-To: <ff7b0a2ead90ad9a9456141da5e4df4a@manjaro.org> (Dragan Simic's
	message of "Thu, 14 Mar 2024 07:20:00 +0100")
References: <cover.1710258538.git.dsimic@manjaro.org>
	<1c670101fc29a9ccc71cf4d213545a564e14aa05.1710258538.git.dsimic@manjaro.org>
	<xmqqjzm51ugt.fsf@gitster.g>
	<ff7b0a2ead90ad9a9456141da5e4df4a@manjaro.org>
Date: Thu, 14 Mar 2024 09:45:47 -0700
Message-ID: <xmqqh6h8wymc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4FA0AC82-E222-11EE-947E-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Though, further investigation shows that setting a configuration value,
> by invoking git-config(1), converts value-internal tabs into "\t" escape
> sequences, which the value-parsing logic doesn't "squash" into spaces.

Correct.  It would have been nicer to just quote values that had
whitespaces in them, but replacing HT to SP while turning HT that
comes from our tool into "\t" would still let the value round-trip,
while breaking anything written manually in editors.  If you stay
within Git without using any editor, what ebdaae37 (config: Keep
inner whitespace verbatim, 2009-07-30) left us is at least
internally consistent.

> I'd be happy to include the bugfix into this series, if my
> above-mentioned
> fears prove to be unnecessary.

Documenting status quo is a good place to stop for now.  I do not
know if it is a good idea to add too many tests to etch the current
behaviour that we know is wrong and we'll need to update when we fix
the bug, though.

Thanks.
