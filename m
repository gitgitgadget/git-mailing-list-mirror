Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031AE14AA3
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 18:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711219774; cv=none; b=vCF0uMzM43u49JHOXHeZ7WLz9R2SwsfXSacKjVB4Nh3dtEOZX8WVREuAU6ID2OgXw1c+h9jZP0DfZmMRmimiM53T4NuYZzClgFmqfz0AoO3EVFjnN7d4UtfZAXGNe5/ernDJ832VYSTv3+AfPDLvAHVEwR93Evss1wikRAR1l7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711219774; c=relaxed/simple;
	bh=vCtuZ3SW6zG6wYCr2D4c6hfv0GITT109gG+fAtU/Qoc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OEpmr/bQcg2lvkNMU2fzAEgSdkDsUmkKbMXzXFkMAmSVsNI6aAuntKw+27Ln2A2RzigUUzZlo9k9MBeE8hKFWMO1gqXpeH6/PVjjPx9HebObMXmt6IbcSQjJp7PiRmrEyuVahEPC09UBzNRPWpTzhNLAjAz5WYtCP1JF7RfBtCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vpu1/A8a; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vpu1/A8a"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CB6241D6E28;
	Sat, 23 Mar 2024 14:49:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vCtuZ3SW6zG6wYCr2D4c6hfv0GITT109gG+fAt
	U/Qoc=; b=Vpu1/A8aer/dh+ULvc3cHozBJG9mDvnInl0UkWmIhU7jYC67a1DPkR
	Sj0feI0xnNI7l/CSXGSFZfLNYSjza9yC1IGgjpV0hKNhp6wi4EA95HU8hoXhiW9M
	d67yLHG3WUmTgt+Jb0cMmwNIiib3SErQ3m6A40BFoHdsnNake1pMs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C32A51D6E27;
	Sat, 23 Mar 2024 14:49:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 040041D6E26;
	Sat, 23 Mar 2024 14:49:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Matthew Rollings
 <admin@stealthcopter.com>,  Stelian Pop <stelian@popies.net>,
  git@vger.kernel.org
Subject: Re: [PATCH] contrib: drop hg-to-git script
In-Reply-To: <20240322234354.GC2049941@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 22 Mar 2024 19:43:54 -0400")
References: <20240320094824.GA2445978@coredump.intra.peff.net>
	<01de5e16-a4ee-47df-03e6-67f5f0d601a7@gmx.de>
	<xmqqjzlu2r8n.fsf@gitster.g>
	<20240322234354.GC2049941@coredump.intra.peff.net>
Date: Sat, 23 Mar 2024 11:49:29 -0700
Message-ID: <xmqqh6gwwzpi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 155B1384-E946-11EE-B704-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> Anyway, the important takeaway to me is that searches are not likely to
> end up at contrib/hg-to-git, with people wondering where it went. They
> will point directly to the alternatives.

And what is most attractive is that the list of alternatives they
will see in there searches will be updated as new and better ones
appear, unlike contrib/hg-to-git/README that we would need to
conciously maintain, which we are unlikely to do.

We might want to see if there are other contrib/ ones with only
tombstone READMEs and remove them as a part of spring (in the
northern hemisphere) cleaning, #leftoverbits, citing what we
discussed in this thread as the rationale.

Thanks.
