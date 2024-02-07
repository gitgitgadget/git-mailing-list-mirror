Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E279127B58
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 21:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340087; cv=none; b=lCrz75Z368R3Z/+bQDAPpmCIrLhJw3P/IKl2+Y+oxTfnZzXUfOgyqDjANfeZp8ebN8N6XjOfNW+Xz417Ba6apuStHMqB1Y/mPNKHtjnqPLFK9DUDL0P7W151nUvul1WkS2G2t9fGusfIwrnSexuG6nBUx3i3wSGMq0/SE6KlH40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340087; c=relaxed/simple;
	bh=HWw0CJ/NVmggelCh/E7oG9MfOIqeKC6j4FMF1pg3zvk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bCAVclL+jfJCzVwxu+QslclrQZbCDTueX/wN0OqeSbrlnnxyXqTMPkNuWyzFvUn0NMJOJkr1j6SxVFeAjfVqrDdnq5H8zrSiDqJS37/75DWgYRG7kBM+LLDn+M+YdUob2aAxCCDFYfnh4Rgo5N3KAIlgVvXINoG0FcTmzw66R+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=txQIUb7L; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="txQIUb7L"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0B6922B950;
	Wed,  7 Feb 2024 16:08:05 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=HWw0CJ/NVmggelCh/E7oG9MfOIqeKC6j4FMF1p
	g3zvk=; b=txQIUb7LGzakpXriXMgnYTiNxgglakcCFQDcGh/yhyznF6CaQSosgY
	Vig5aj4opOWlS907ijPUphfYGf0PnxXzuBfLk0Ipbw7xARJAiGnr71JrbDd2RZ+1
	z17/7e5742UWk3yXPurDM1212Ny7OPyhJJ6TERJ2zYhX6e6WPdf7Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0395A2B94F;
	Wed,  7 Feb 2024 16:08:05 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A4E162B948;
	Wed,  7 Feb 2024 16:08:01 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ricardo C <rpc01234@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Interest in options for stash -k and -u by default
In-Reply-To: <3470180e-2ef7-4393-9d32-92cd419727f5@gmail.com> (Ricardo C.'s
	message of "Wed, 7 Feb 2024 15:59:54 -0500")
References: <3470180e-2ef7-4393-9d32-92cd419727f5@gmail.com>
Date: Wed, 07 Feb 2024 13:08:00 -0800
Message-ID: <xmqq34u46kzz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FA4D9F9C-C5FC-11EE-8991-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Ricardo C <rpc01234@gmail.com> writes:

> I am wondering whether this change is something that would even be
> considered for being accepted. The patch still needs some work (mainly
> documentation and tests), which I'd be happy to do if I knew there was
> upstream interest in this work.

There is a canned response for it ;-)

I've seen from time to time people ask "I am thinking of doing this;
will a patch be accepted?  If so, I'll work on it." before showing
any work, and my response always has been:

 (1) We don't know how useful and interesting your contribution would
     be for our audience, until we see it; and

 (2) If you truly believe in your work (find it useful, find writing
     it fun, etc.), that would be incentive enough for you to work
     on it, whether or not the result will land in my tree.  You
     should instead aim for something so brilliant that we would
     come to you begging for your permission to include it in our
     project.

