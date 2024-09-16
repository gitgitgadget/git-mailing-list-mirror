Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0C22D032
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726508293; cv=none; b=WPDNbq9lrbWahHWETUIYGysA+uVyB5vEV6ESzhchQrHLSbPX45Ipk5TS2+q4S2LY938qwiyzAyJl016RvBmclalJSgAxW1Obta713tllJBl7GmGeMmgpHOKuGP+Ou0hlwZrI+m2Nr7WbTjcpwP+w/i0/TJtGCYWVgNHyOTFt4Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726508293; c=relaxed/simple;
	bh=MSrX9VR1w6SLjaEtMtQ5+RfL+yDCHeQTv2rGbLHOPGs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U+4EJ6M3cXNjPcCG6IOwaJ5X19MmokxF8pQP6Rtj6CCrTuUfzZxCcNhQIAq9RiNzMbOydnop5Ex+VllS87DMbrrZuVKN/XXRBO2cxx+ueIfYgFoo8cCnOwtWAD7zPoGcHWJucOVR/7uGVObFmouk23xG3x/7TQsa0khPnxrExRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lbN8Ri6t; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lbN8Ri6t"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 969D43C00F;
	Mon, 16 Sep 2024 13:35:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MSrX9VR1w6SLjaEtMtQ5+RfL+yDCHeQTv2rGbL
	HOPGs=; b=lbN8Ri6tgXxN17yofYPVM4jU/fDCTJ02gJaqAuBn3vRuDd1Lq4RrTD
	LqUbOhbvUzM3pShZiDs2t6l2WbQtzXNqIpv741tfA741SXV03ZCmGFgJeVltNYZs
	Vd6Bm1cFqwW7RnhhitfgbEyCSL5goUxNtDaJtlATmfaUwz/YqGiNE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D7523C00E;
	Mon, 16 Sep 2024 13:35:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E397C3C00D;
	Mon, 16 Sep 2024 13:35:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] add-patch: edit the hunk again
In-Reply-To: <cba63486-2186-4e8e-aad4-ed7f54606ec7@gmail.com> (Phillip Wood's
	message of "Mon, 16 Sep 2024 14:33:54 +0100")
References: <21ddf64f-10c2-4087-a778-0bd2e82aef42@gmail.com>
	<cba63486-2186-4e8e-aad4-ed7f54606ec7@gmail.com>
Date: Mon, 16 Sep 2024 10:35:41 -0700
Message-ID: <xmqq7cbbqz6a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 192106D0-7452-11EF-A785-9B0F950A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Because we know what the unedited patch
> looked like and that the pre-image lines should be unchanged it is
> possible to provide much better error messages than we get from trying
> to apply the whole patch with "git apply". It also makes it possible
> to restore deleted pre-image lines.
> ...
> [1] https://github.com/phillipwood/git/tree/wip/add-p-editing-improvements
>     Note that the later patches do not even compile at the moment. I've
>     been meaning to split out the first eight patches and clean them up
>     as they're mostly functional and just need the commit messages
>     cleaning up.

I'd love this.  With both patches before and after the edit session,
we should be able to give more accurate line counts than having "git
apply" look at only the post-edit shape of the hunk, which wouldn't
see where any brokenness of the hunk comes from even if it wanted
to.  We should probably be able to stop relying on "--recount" once
we do this right, which would be very nice outcome, too.

Thanks.


