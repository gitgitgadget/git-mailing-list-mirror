Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3257E143C52
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597665; cv=none; b=Jt6Y65+S2VpTU4B6CqHJcBq0HfwfM9P8v0z6VlMEKVdFTaWG/oahV3pnSqLvWrf4at89UlN/T7TCNzDPAfqo9TEs6ZZr+sKcsGNzLkdlSx/3+SujF+/nLE/OibYiu87EvLQ9QF0So90xznhXS3X8uH9TdobcRM/NaZa+fBINZB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597665; c=relaxed/simple;
	bh=Hwnf8C/j2bL+UqD3jXLImqxvsl8NDyy2HKMo2VdnALs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lGWXotgj6sPDp5pj77LoSKB+psIU9YwaFN2rUd/GPRlkWCleBuUqtGaXfbMrUSz47wILpSW/ZDVBizha1qX52yBeha25e/VSN4FLJPIoMRizKD4gppHLTuo5Z5PWF80XgQCu/mB7btZ3pC7DriOsm6FRkV1pbSWKfjjn7k2mTC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JxziRSQR; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JxziRSQR"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B84E81E43B;
	Mon,  8 Apr 2024 13:34:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Hwnf8C/j2bL+
	UqD3jXLImqxvsl8NDyy2HKMo2VdnALs=; b=JxziRSQRjPzkCSF/p7wvKPAcyyPq
	lQTphQGHgM/+qK0sSUmq5fA1N76Bt3hbsOHue2p4VPqESTgeSTG+QHOxhXrZJk9h
	OuWHVyQN3B6AmKJ1rob5c8WOFhV2/7FrWNiH7I8ap38lO61T2akQoZlswct22sBT
	ll3Mdqap+ah1TYA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B0B581E43A;
	Mon,  8 Apr 2024 13:34:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 894F61E433;
	Mon,  8 Apr 2024 13:34:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t9604: Fix test for musl libc and new Debian
In-Reply-To: <ZhH5Aoc1WPKRYtpj@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
	"Sun, 7 Apr 2024 08:38:10 +0700")
References: <23a4298eababe54ca4b43d7b675b858605d20ec5.1712374021.git.congdanhqx@gmail.com>
	<xmqqsezylmh9.fsf@gitster.g> <ZhH5Aoc1WPKRYtpj@danh.dev>
Date: Mon, 08 Apr 2024 10:34:17 -0700
Message-ID: <xmqq5xwrdahy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 3A54BD18-F5CE-11EE-9778-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail.com> writes:

> Well, when I tried to make this change, I first started with Olson
> notation. Then I dig into the mail archive, and I see that we don't
> want to depends on IANA db [5].  Then I switch to POSIX notation but
> I forgot to update that.  I think a PREREQ would work better?
>
> 5: https://lore.kernel.org/git/7v4nlvulc2.fsf@alter.siamese.dyndns.org/

Interesting thought to use PREREQ here.  As long as it will avoid
tempting us into testing the feature only where we know that the
feature would work, I am OK with that direction ;-)

Thanks.
