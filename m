Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188FE10E6
	for <git@vger.kernel.org>; Sat, 27 Apr 2024 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714238464; cv=none; b=jTsVVjYnLq5LdXyRO5CsRq1rN97wXNd3Gmeb/L9CdVVnuZVpYUp7jSH/Jhb17Bnv435I+sVe8MQExTedrxDhzcE9WO4E9jR0DaxxCTLRs/EetbXx+bBYIfHGQR8dGglF1fhZwFXfdYu6uDo+S87NMWkObMTE9zu91aZr+7zB6q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714238464; c=relaxed/simple;
	bh=nBLx9QKpiOXSYVhhTCao7aIF6FzqWmbt/UM4PtsNt/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nqEvxm8A+XomldVrfQw5HNI3lwbvoVjrMXTvUqiGDiVI7LIQQA97eFTAtSC9RwomcRrhe6kVE8QYjeIUHYWhDFX9XZCp9d8TZto1MFxsHzS7m67rrdWrmK+qllHG7+vwSWf+IBPzbSnfxt7tzgeU/izAPB72RjqhLEpEmtGUr3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LhWstPwp; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LhWstPwp"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D865D212F4;
	Sat, 27 Apr 2024 13:21:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nBLx9QKpiOXSYVhhTCao7aIF6FzqWmbt/UM4Pt
	sNt/s=; b=LhWstPwpIRWHw2fVITJRJeQoDqimTYL4Fo/cGSbgP2mu/Pht94d+SF
	DzJUKblY85L9/7vZFkPKFKqK5vqEH8e5NOCXUW2WqGzyWES2GSn6CFu2k75MZRWj
	5dEKZKBeyUImDPXc9BYVEJMn34kYqq2+G5IIWzlgTtqtucWokCLNg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D1317212F3;
	Sat, 27 Apr 2024 13:21:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1421C212F1;
	Sat, 27 Apr 2024 13:21:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Eric Sunshine
 <sunshine@sunshineco.com>,  Han Young <hanyang.tony@bytedance.com>
Subject: Re: [PATCH v2] t4126: make sure a directory with SP at the end is
 usable
In-Reply-To: <386aecc6-d94b-3f76-9a11-f05c68fb6767@gmx.de> (Johannes
	Schindelin's message of "Sat, 27 Apr 2024 16:47:50 +0200 (CEST)")
References: <20240319095212.42332-1-hanyang.tony@bytedance.com>
	<xmqqttl2qml9.fsf@gitster.g> <xmqqfrwlltjn.fsf@gitster.g>
	<xmqqsf0bz5oj.fsf@gitster.g>
	<20240328103254.GA898963@coredump.intra.peff.net>
	<20240328114038.GA1394725@coredump.intra.peff.net>
	<CAPig+cQe1rAN2MUFTwo7JoCt3sO2eCk_psnJL9D=Rs=Q9MWO9A@mail.gmail.com>
	<xmqqa5miuutd.fsf@gitster.g> <xmqqh6gqt674.fsf_-_@gitster.g>
	<xmqqil15srub.fsf@gitster.g>
	<20240329112730.GA15842@coredump.intra.peff.net>
	<xmqqplvd0y6c.fsf@gitster.g>
	<386aecc6-d94b-3f76-9a11-f05c68fb6767@gmx.de>
Date: Sat, 27 Apr 2024 10:20:59 -0700
Message-ID: <xmqqmspe67t0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 84E82324-04BA-11EF-A72A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Indeed, it should have been at another layer, but alas, I could not find a
> _better_ layer back when.
> ...
> I would have loved to work on it, and once I find a position where I am
> funded to work meaningfully on Git for Windows again, I will.

Well, I would think you are working meaningfully on GfW.  Putting
that logic somewhere is what GfW person needed to do.  Putting it in
a layer (if there is no existing one, inventing a layer for it and
properly rearranging the systme) is what a "libified Git" minded
person may want to have, but that is far beyond the scope of working
meaningfully on GfW.  That is one of the things "libified Git"
people would need to do.  And if the "libified Git" folks do not do
it themselves but ask for help from GfW folks for their area
expertise, that is a perfectly acceptable way for "libified Git" to
behave, too---after all making "Git as a whole" a better system is a
team effort.

Thanks.

