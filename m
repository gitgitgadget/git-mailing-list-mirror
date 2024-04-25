Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ADA3C3C
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 04:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714019077; cv=none; b=QEWCCBlUx3TcPK94yfaHW1bmgpjaUN2Cm8Rzj5ardjFXW3HTeZl5o0CJ+4oI07FadAgJuIUY4w7rqR/pHD86LEAlPwhAdMg2znntuBKigY/S7HniHPTTRijhJAGJxGrgLYCJLOd8W633nxfUaDRT3AJfJPoMaJ1ugIPEXVBmH/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714019077; c=relaxed/simple;
	bh=+DKGuY8VZp543buxfqA7oZABOzr33+F0IfMMHVJEc7Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tBIvE9d9TGKNdmjYB+MyFcLUtoEBE0iyjBitkmLkYmxA5F7Zj5YOjMnJaaSNpNZxZS7oQAy5+ibSpdt630NmVKheHc787IUzM+BymF6mHndk0959h7YXx+W1y2l/6oGnJ+4JuqlMRgMeqsVJIXjy5OafiQ7ztXOCorWQwEybFig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PmdfpRpa; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PmdfpRpa"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DD1BB1FDCF;
	Thu, 25 Apr 2024 00:24:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+DKGuY8VZp543buxfqA7oZABOzr33+F0IfMMHV
	JEc7Q=; b=PmdfpRpaLQXdLBPhpxt1K51t28u9DjX9XBPCcl5qDwHOfuz4SV6Vbz
	0ZNE7Z3UYpLW7eIk+VNdIqYLUXYu/2/Gv2t/i4h3MhsXSh7NNkgc2UmWrMSdbf1v
	5J5wfTCdRJUDKJG/L2eLJWaXDB5+hzbjg20m1uszOxKBvQzBYG/eM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D38001FDCE;
	Thu, 25 Apr 2024 00:24:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3C06A1FDCD;
	Thu, 25 Apr 2024 00:24:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dan Demp <drdemp@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: Git Bug Report: git add --patch > "e" makes keyboard unresponsive
In-Reply-To: <CADs5QaY=dJ=MXNYgqyEQA9xmcBkeocZh5z9Tq_iNfnFgCHR_=w@mail.gmail.com>
	(Dan Demp's message of "Wed, 24 Apr 2024 23:13:03 -0500")
References: <CADs5QabwDtUpehNY3hr6BzKyfpp-Ts54TANGkygWPcN3T=OSOg@mail.gmail.com>
	<Zil_m_1B0wcLejNH@tapette.crustytoothpaste.net>
	<xmqqedauwgbk.fsf@gitster.g>
	<CADs5QaY=dJ=MXNYgqyEQA9xmcBkeocZh5z9Tq_iNfnFgCHR_=w@mail.gmail.com>
Date: Wed, 24 Apr 2024 21:24:32 -0700
Message-ID: <xmqqo79yhxxb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B7813434-02BB-11EF-BC9E-25B3960A682E-77302942!pb-smtp2.pobox.com

Dan Demp <drdemp@gmail.com> writes:

[do not top-post]

>> ... I would expect that there may be something more than a silly
>> "the editor is running elsewhere and the user is stuck, expecting
>> something to happen but the editor is waiting for the user" problem
>> here.  For example, could there be funny interaction with "single
>> key" mode with editor on Windows (which I do not use myself but I
>> think I saw the word in the original report)?  Is the configuration
>> "interactive.singlekey" enabled?
>
> To be clear, I did close the editor, at which point Git Bash shows me
> the next diff and asks me to choose an option (y, n, a, d, ...). It's
> at that point the keyboard is unresponsive. Not while the editor is
> still open.

Brian's comment was only concentrating on the possibility that an
editor is still open as his first probing effort; I suspected there
was something more than that going on (e.g., after closing the
editor, the control is still stuck), which you just confirmed.

Thanks for confirming my suspicion.

After this point, it is beyond what I know about the platform, and
I'll leave it to "Git for Windows" folks to take further look.

Thanks.
