Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11206195F3B
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979308; cv=none; b=R2+TF/HQ/eFWI6UdnZldrQwo7lOaG9fl2h5BOBVxxQE4DV72BVXjL9DhAihxbp8UDXWZsoRJ8CY6sZ+T1S3WBfFOtNyLP+f3kmwrtlVWpOHL+PtMP8RvhXmr53QD02lx+I1mwtHv3xwAazOezua5XAHQ5vy8blpiYGKfJjlCVaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979308; c=relaxed/simple;
	bh=7WPvlHnBa6v+4r7xL9eSpQglq5dekTJkzlTnl/b8Omo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aykDZEgVuz5iAAopoOC1zjZI+HExFu5gUvfV10ng93DR6YGZkn0Z0stDMRaxrPX7UwzVQV6oprRNuUP9D2J0a6Ux6cp+gv0rNWG0FcBQ+/QZaDzlb8w8kQYIZzHXe02hxEs2EkKEPHgRerQywvzL2ZY5M8VXzCovauR46VAdnpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=d76KnBku; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="d76KnBku"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BFF33040C;
	Tue, 10 Sep 2024 10:41:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7WPvlHnBa6v+
	4r7xL9eSpQglq5dekTJkzlTnl/b8Omo=; b=d76KnBkuBsMY795eVNC96vdmCuMq
	QcLZ/7E9QtoqbNZ86oSkaQgmbPpkAuCHuvYTCV/TD/0sGOuui1X+s76OYuopMG7m
	XCIoFfa198jqz6iRe/myfb/nyI5EJGrvlt5G5Ga43+4rLFnAivJhQ2/K5ldey72h
	TGJB1JksmF4xb90=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 63D5C3040B;
	Tue, 10 Sep 2024 10:41:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB07930409;
	Tue, 10 Sep 2024 10:41:39 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Shubham Kanodia <shubham.kanodia10@gmail.com>,  git@vger.kernel.org,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: Re*: What's cooking draft as of 2024-09-06 late night
In-Reply-To: <490bd831-836a-4d7e-9695-8cb50c83317d@gmail.com> (Phillip Wood's
	message of "Tue, 10 Sep 2024 09:42:10 +0100")
References: <xmqq7cboyq9s.fsf@gitster.g>
	<899eb2c2-bb18-4666-98d8-9255dedfac53@gmail.com>
	<xmqq8qw3xvob.fsf_-_@gitster.g>
	<CAG=Um+0X3Umt-2TQ-BGeefqdGxfVoy2Ug0tGKLycrX=_pj=oJw@mail.gmail.com>
	<125aab1b-d017-45c1-b93c-ee43fef9bd71@gmail.com>
	<xmqqseu8u8m0.fsf@gitster.g>
	<490bd831-836a-4d7e-9695-8cb50c83317d@gmail.com>
Date: Tue, 10 Sep 2024 07:41:38 -0700
Message-ID: <xmqqo74vo9jx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 CA13C830-6F82-11EF-B8AB-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 09/09/2024 16:53, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>=20
>>>> The only place `skipFetchAll` is currently documented is in this lar=
ge
>>>> master list of configs that are easy to miss =E2=80=94
>>>> https://git-scm.com/docs/git-config.
>>>
>>> We could perhaps expand the documentation of `git fetch --all` to
>>> mention skipFetchAll
>> Like this (interdiff at the end)?
>
> That looks good to me

Thanks.
