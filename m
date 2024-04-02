Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9516F1F5FA
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 20:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712089870; cv=none; b=rAzc4yXwOaXgvW+z4Vr6JPZNEJjCFSinF+WKPgTfsRW5XyYINYXzdbWtdC95iKuLfo7cPr/mCA2auxInZGtTS05kY8t/rdHJ5Q4QlkRREvdtnANZIezDAdVvtHY4sdhJBZvBnviOYQzd2nCO05axAFCPHXVWD1lo2q9bT5MMPMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712089870; c=relaxed/simple;
	bh=6Ku3+OLkQo9mkmgM7UDKArM2gqiwzq+rD2uGhYsAMsY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YhIhJHVEuO8uTSIPTwy2unRA3iI6BKfd8HKY1A6Kboy0xXCSBgrdLWH+hjEdHrn6aMM7lP4avbd2rOTKLWn06jxyGQ/4RA8iwwHX/tzoH5oVY1G4LVBYuGMcIZoEiMgaE9FKMwM5fUhpZDtdqSrM2U0P31ybrqF8Sb1NHVZ17+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZQVqAAUf; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZQVqAAUf"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 30D1C2B6DA;
	Tue,  2 Apr 2024 16:31:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6Ku3+OLkQo9m
	kmgM7UDKArM2gqiwzq+rD2uGhYsAMsY=; b=ZQVqAAUfjLEVJqgjDiR95Powt6Fl
	H1FKPLwV9LPdf3Z+t456r+0hyYc8kZ2n/KSDZoFt+bIrdYUoPEp6BiiUEh4nN0kC
	+qHoMCCpeAHJ5KGCUQlChoLGtE/vStJHzt7bcoU3tCiit8aQyDuhvfNBtuEc7j/1
	jTIJxyVMXx4idCA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 280E52B6D9;
	Tue,  2 Apr 2024 16:31:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 977F42B6D7;
	Tue,  2 Apr 2024 16:31:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  Chandra Pratap
 <chandrapratap3519@gmail.com>
Subject: Re: [RFC][PATCH] t-prio-queue: simplify using compound literals
In-Reply-To: <520da361-1b80-4ba3-87b2-86d6fdfc18b5@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Tue, 2 Apr 2024 20:30:31 +0200")
References: <520da361-1b80-4ba3-87b2-86d6fdfc18b5@web.de>
Date: Tue, 02 Apr 2024 13:31:03 -0700
Message-ID: <xmqq7chf4id4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 ED8E82B8-F12F-11EE-9CE9-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Test names like "basic" are mentioned seven times in the code (ignoring
> case): Twice when defining the input and result macros, thrice when
> defining the test function, and twice again when calling it.  Reduce
> that to a single time by using compound literals to pass the input and
> result arrays via TEST_INPUT to test_prio_queue().
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> C99 added compound literals.  Are we ready to use them?

We don't know.  This might be a good weather-baloon, but I do not
know if people skip t/unit-tests/ without telling us.  After a few
releases with this patch in, perhaps we can find a more central
place to use them to deliberately break the build of these folks and
have them complain, and revert it if it becomes needed?

