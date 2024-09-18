Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A521CA69A
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726699163; cv=none; b=ISlM3ATFMv5iK2DKzvj9o9b+nZYlvR4qHVwcH3rLBgpIq6lfK5Vr9DczOcPKySF6hLIavJSvqhvCW34K/2EHjYcpxIB73IDNP2jakdcw1LS7GqHLRaruXBqQ3AVp8SQue0BmqKhI2deegDhjWGh8XFy0xUfY4vPTQARmNL+QydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726699163; c=relaxed/simple;
	bh=N5er7BQ5RGLO6YvbzKky5AnXqglnRqr6VR5+tJhfXU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u/yCw8yFOccyaK8yZSi7cPGtL3o1QTGWEv0Fw7uNRzlolmZn05JVjU0prC07xNYW0FD2Bq6bz1LXPkCOLcKyPJf4fFw5l2xPzbmfk+SFIklGhYbvxy5oS7HitRjhs1pJA9LgiE+0NPgG9l4mOsm6jtkNsouk95NGwiBnYixcRps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uXIMHt13; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uXIMHt13"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 490E61ADA9;
	Wed, 18 Sep 2024 18:39:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=N5er7BQ5RGLO6YvbzKky5AnXqglnRqr6VR5+tJ
	hfXU8=; b=uXIMHt13Yhz2rWWOgWed2gNlo7WBShyB92vKo9OTAc+CSHtwZUBOW/
	hyuRxFJLaOv95clE+4AEAuod62E+1uTbOiDrIRB2J7dHAiIBv8hIRqnRKjoR1p3P
	xt8V8KPOvJUTQxPtwhutQ2vpArQ40kGdvhpnpBUsn91WUKOBvi0DE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 40EA51ADA8;
	Wed, 18 Sep 2024 18:39:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A3D081ADA7;
	Wed, 18 Sep 2024 18:39:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Henrik Holst
 <henrik.holst@outlook.com>,  "git@vger.kernel.org" <git@vger.kernel.org>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: ./configure fails to link test program due to missing dependencies
In-Reply-To: <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com> (Phillip Wood's
	message of "Wed, 18 Sep 2024 11:04:54 +0100")
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
	<xmqqldzsrhyp.fsf@gitster.g> <ZufjWR6AJM-DIWPR@pks.im>
	<29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com>
Date: Wed, 18 Sep 2024 15:39:13 -0700
Message-ID: <xmqqy13oa8oe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D4FF1CDA-760E-11EF-950A-9B0F950A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> We seem to get fairly regular bug reports about the configure script,
> presumably because most contributors are using the Makefile. It would
> certainly be nice if we could get the CMake support into a state where
> we could consider dropping the configure script.

While I would agree that two is better than having to support three
build procedures, I am not sure how improvement of CMake support
needs to be a prerequisite for removal of autoconf.



