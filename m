Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7145918AEA
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016341; cv=none; b=M2CNYKseLLsMnogaew+lUiH/Bk1dVJNEH5LEHJjEMTJ7WGHaEIVFst+qyXJ4rHJ9H4W6xr6KqyiB7O3MPKMz7J6Nq+nW7tES+F9S+LjolHM0dIYMSomy42d0KB7LJRyXPtt9dhIj8fHOQ3EwrDaCg2yOkPw2Iy1pMHZUM81AqXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016341; c=relaxed/simple;
	bh=RaUo+BABVCAT6OMg0ymDtJP3oTKPlNH5wh3HIDDvGL8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dnQwlVr27gO5cG7ZvRIWAv06eKyHW4cbJY/kTDO0FUaiURtATftOv2WsgDGXkD4nI54rMNPZH3C4Q4g/X2poRomGp/0jSf0PUbcd6XAUiKIiBtYTEFEcllVXsQCHVv+94np0oJR9fkDd7e87yplNivPUUSHN+2zV7RJGffG+M08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=d2Xky+nG; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="d2Xky+nG"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1C19C35A4F;
	Fri, 26 Jul 2024 13:52:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RaUo+BABVCAT6OMg0ymDtJP3oTKPlNH5wh3HID
	DvGL8=; b=d2Xky+nG2zrM4m7+BDCsLwFQeDGFFjik9LdHS1EDHaggC9esGSPaEr
	Wnb4JkJ+MtcFJEoMK5lgCgB9Qs46iR4LZG/vRIQX85PyKlS1D3Dyo61yzZh4K98O
	xzclIyrLi9uSdbejFtIZGekID0KDrTaAyE8sZS42Hps8/Ne315dKA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1568B35A4E;
	Fri, 26 Jul 2024 13:52:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8FF1535A4D;
	Fri, 26 Jul 2024 13:52:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jayson Rhynas <jayrhynas@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: fix hex code escapes in git-ls-files
In-Reply-To: <xmqqh6ccvz2v.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	26 Jul 2024 10:32:24 -0700")
References: <CACStHN-Gs2Sxej+md6zWr3V1dFo+pp=B4yEPm9=uPambDR2NaQ@mail.gmail.com>
	<xmqqh6ccvz2v.fsf@gitster.g>
Date: Fri, 26 Jul 2024 10:52:15 -0700
Message-ID: <xmqq1q3gvy5s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CBE98A70-4B77-11EF-A1E5-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>>  --format=<format>::
>>   A string that interpolates `%(fieldname)` from the result being shown.
>> - It also interpolates `%%` to `%`, and `%xx` where `xx` are hex digits
>> - interpolates to character with hex code `xx`; for example `%00`
>> - interpolates to `\0` (NUL), `%09` to `\t` (TAB) and %0a to `\n` (LF).
>> + It also interpolates `%%` to `%`, and `%xXX` where `XX` are hex digits
>> + interpolates to character with hex code `XX`; for example `%x00`
>> + interpolates to `\0` (NUL), `%x09` to `\t` (TAB) and %x0a to `\n` (LF).
>>   --format cannot be combined with `-s`, `-o`, `-k`, `-t`, `--resolve-undo`
>>   and `--eol`.
>
> The change looks good.

I do not know what your MUA did to it, but this won't apply as a
patch.
