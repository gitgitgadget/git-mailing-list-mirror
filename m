Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D2919BDC
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 22:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713997365; cv=none; b=T5Vc+eJVMVC2w7S1H3FPNlsvPmvGqTCw4STYdLnacQXY+p46f/lYJwe7ltqWe8509EsPJnhhbFFTuT8Utwg1iA9kbyGtQQ4mCeTHPKhd9R/TNVdFWnrh6uUeyKIrZIMLpZ3nuMOZFlW682+E0lKZ9y0DDCKEWIfUawNHZqev3SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713997365; c=relaxed/simple;
	bh=gTtRwZLLlh9G9a5Kk9dyNe7A1HQzmFfdjEoETsgS3UA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kWAdeG51FlZOyun3uLBR9D2UvcXW6PKuVlCFCrGYphf2IKaWQDLVh14z3DMD69l8bhn8uVc1a/aTiDVvMtb69YxHs6KRzt+DusNUhRphQlFuD9Tz/fiEFZ0ouHhgy2866R1mhSSfUcZDI+XpUYgcjnGW1r36RF8pFyveIq/+p4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dXwgPbcy; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dXwgPbcy"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4913D36EA0;
	Wed, 24 Apr 2024 18:22:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gTtRwZLLlh9G9a5Kk9dyNe7A1HQzmFfdjEoETs
	gS3UA=; b=dXwgPbcyxaiIsKnxV1/3wMQCzrXtxghX2McLF2YwW68jDtee2N3ZdH
	XwEJBkDmUDb0lkZ1yK2c2esSwqdbg4nPp1hSMTidSb0jFCl6zlYS7/huGeci7b5h
	AlTPKdjO6OGoRM4xSv0TA1sg8BdZ5MmlTMmYSQRahJ0i0s1CX3K0I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 41CA336E9F;
	Wed, 24 Apr 2024 18:22:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7589A36E9E;
	Wed, 24 Apr 2024 18:22:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Roland Hieber <rhi@pengutronix.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] completion: add docs on how to add subcommand
 completions
In-Reply-To: <20240424210549.256256-2-rhi@pengutronix.de> (Roland Hieber's
	message of "Wed, 24 Apr 2024 23:05:48 +0200")
References: <20240424210549.256256-1-rhi@pengutronix.de>
	<20240424210549.256256-2-rhi@pengutronix.de>
Date: Wed, 24 Apr 2024 15:22:32 -0700
Message-ID: <xmqqo79ywgd3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 261C98EE-0289-11EF-A472-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Roland Hieber <rhi@pengutronix.de> writes:

> It took me more than a few tries and a good lecture of __git_main to
> understand that the two paragraphs above really only refer to adding
> completion functions for executables that are not called through git's
> subcommand magic. Add a few sentences for that case.

OK.  Perhaps the two examples also need some more explanation to
save the next person from wasting their time figuring out what they
are trying to say?  That would be a separate topic, but it would be
nice to fix it while our minds are fresh on that issue.

As I already said, modulo confusion around "-my", the patch looks
good to me.

Thanks.
