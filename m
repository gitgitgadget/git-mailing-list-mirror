Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4A745978
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 23:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713828422; cv=none; b=Bryuate1KWeY2gFTnl4+8+/VacOfXSrxpyu5OrNFZYlEYGUyn3TypQQUImamgvECxtUNV3a8ca1ODk2IksrvI2GqJVnV2EGhhSE/PMXcVTkJ8XUPv/mzUD5TuRwztCqjv+2Debp+qD00wb/CttK9C6BZoxTC2LagfH5mFDAomjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713828422; c=relaxed/simple;
	bh=7NhUMLQbTDnyERnTOZApqCovOObx+/mKD/KapyWEMxg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZDBnCnre4AtmdyfsHJwmM75kz4ZLtqZFIhO2WwbKQbPa/2XoIfbms+HA6Qg3bMlfrvl4zpG+si5PjoGelGfwvvMOcXrd45Z6AGlYCkoZjqbEAXf6FR3e56jEiF2OdBmDLGGKyAei+d154P7UMmlmsztmrb/Bb6RdQjlhG2EKp0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DnqH2cUb; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DnqH2cUb"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CE0D81ED0ED;
	Mon, 22 Apr 2024 19:26:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7NhUMLQbTDny
	ERnTOZApqCovOObx+/mKD/KapyWEMxg=; b=DnqH2cUb/qwTIIKhd/2ZzCPc2OVA
	mZ6RiHKaLh7NBdCoAV/XEna1mBj+WiqMQYBo6hU4qeDNAQ9yXgxu9qGRpJ++Po8T
	JET9mFM8tifCNZZi7WqzMubtFImG+eYjnqAyYFYlSH/UgPdC3CPT1IaNFQ7S8HN8
	0m0a9VtchYvpZl4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C51791ED0EC;
	Mon, 22 Apr 2024 19:26:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 327CB1ED0EB;
	Mon, 22 Apr 2024 19:26:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] mark t3701-add-interactive.sh as leak-free
In-Reply-To: <69f86760-96ff-4c62-9649-4627652b7c19@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Tue, 23 Apr 2024 00:51:04 +0200")
References: <b7b2d0d2-245e-440f-a7cc-fa0df1ce73ad@gmail.com>
	<69f86760-96ff-4c62-9649-4627652b7c19@gmail.com>
Date: Mon, 22 Apr 2024 16:26:58 -0700
Message-ID: <xmqq4jbtt1vh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 D0D78086-00FF-11EF-B793-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Range-diff against v1:
> 1:  18e4c7f653 ! 1:  75cb700eab apply: plug a leak in apply_data
>     @@ Metadata
>       ## Commit message ##
>          apply: plug a leak in apply_data
>     =20
>     -    Plug a leak we have since cfb6f9acc3 (apply: accept -3/--3way =
command
>     -    line option, 2012-05-08).
>     +    We have an execution path in apply_data that leaks the local s=
truct
>     +    image.  Plug it.

This is a nice improvement.

If a bug existed in an ancient version and survived across evolution
of the code for a long time, naming a random old version that
happened to already have it does not help very much.

Saying something like

    This is an ancient bug whose moral equivalent existed even
    before the data & code structure became the current shape in
    commit X

would give a bit more information, in that X gives a rough estimate
how far back in the codebase the fix in the patch can be applied
more or less cleanly.  In this case, X would be where the struct
image was introduced, I guess?

But the updated text is good enough and I do not see a need for
reroll.  Will queue.  Thanks.
