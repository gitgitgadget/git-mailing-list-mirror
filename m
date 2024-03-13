Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DCC51C33
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710365974; cv=none; b=S4MXeWWz7EzLVFWNCAYBts5ih/5SLsA2/TfEdFWKS0MVzXlRpPhxYPMCFefYDwCzcCgYQVkhn3NYPaTnRmGq66qoGdDCBEOrSxZ4qw2UFfCm1mfP0+gn5yB0F0SAxsPDxXrS3ReIX35lrIyySMSGQggCsqKUV5sn19MKElsLD8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710365974; c=relaxed/simple;
	bh=mT0Jk5GKNbnTwtTUbnIBtv5Q2t4QRPAFVoyDNpSkknc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fHHXHxBKmzVp3cxrtUNjJPUtUh6OQ0vGmr8/zYVYlETTNMpxlM7f58T3RaV/bxPVcp9RjuflLBwbjs+2P9tbfvM+vIT16UaOUCrWADHGyP5qyUzxJGh2fhD0s/kYVd73XdnFK8uT9Jd4if4DdthITE/hrs867MMr+5Fo7otlfeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GszsUWef; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GszsUWef"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A61301D6962;
	Wed, 13 Mar 2024 17:39:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mT0Jk5GKNbnTwtTUbnIBtv5Q2t4QRPAFVoyDNp
	Skknc=; b=GszsUWefNDc/fyfJ4VH51qA12RTetZ5dhHL07E2U5gRFuGGoyqf1IS
	tabhPsb0svOlpet6xTE35ejZfgrCaqulht0WRnk99CUBEoYCrOrmuekPW7D+mUZA
	m0OGwJaXYxsEFmE0TaBmYJ0gu1Rmn9UOWWAsrYBbnMA/gBTB1gyRE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D5211D6961;
	Wed, 13 Mar 2024 17:39:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 14FD61D695E;
	Wed, 13 Mar 2024 17:39:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Aryan Gupta <garyan447@gmail.com>
Cc: git@vger.kernel.org,  karthik nayak <karthik.188@gmail.com>,  "Patrick
 Steinhardt [ ]" <ps@pks.im>
Subject: Re: [GSoC] Discuss: Implement support for reftables in
 =?utf-8?B?4oCYZHVtYuKAmQ==?= HTTP
 transport
In-Reply-To: <CAMbn=B7MtohTm=J+XL8iwx_CuWo47jM-v=e=p+k6hY2CKWX+Og@mail.gmail.com>
	(Aryan Gupta's message of "Wed, 13 Mar 2024 22:09:59 +0100")
References: <CAMbn=B7MtohTm=J+XL8iwx_CuWo47jM-v=e=p+k6hY2CKWX+Og@mail.gmail.com>
Date: Wed, 13 Mar 2024 14:39:24 -0700
Message-ID: <xmqqa5n1ak1f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 29F5AAFA-E182-11EE-8145-25B3960A682E-77302942!pb-smtp2.pobox.com

Aryan Gupta <garyan447@gmail.com> writes:

> In simple
> words what I understand is I just need to add support for the server
> side nothing is to be done for the client side.

Hmph.  The "dumb" transport is kept primarily to allow folks, who
can only use web hosting that serves nothing but static files, to
publish their repositories, and requiring more things to be done on
the "dumb" server side sounds somewhat backwards to me.

To be quite honest, I personally doubt that this topic makes much
sense in this age and day---I've felt that the dumb HTTP walker
outlived its usefulness for the past 10 years already.  But perhaps
I am biased by the first-world access to the internet?

Thanks.
