Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9700A13B5A8
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 18:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717613932; cv=none; b=IlM40azpxSUAjyqZz1VjUVBW0aI5dO+bnwFjZ3ZOcRPcyt2VgsaBX9sG1QREm8MimZrC1ZnXvsqTDE8gvzUWfs/sRrDic2dsIG02ebMdsOOzX0WCqBxFBCMi5Pfry9yqZk8Fczd9Fl/JHgCf4ZMuPLHMULJ2gF0fIp0jeC+Z3mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717613932; c=relaxed/simple;
	bh=IaCnvcuaBNb+3TTn4phQ+8waQOBfk/9/bESloJKWYI4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wdit3RUn3ks7CSYg0jvdKPYYQu61FvZKC+T/6NMFV7YxPcExBMmOOi0/Ciq9EOfHBnzQER0rf1SkWBnVDf7Lef58kuuoB2uTMseBzyVJ6hFo1Vvp09tLXxYLYvAWN/H5XxRimdy+VLgzQOiovy2gytrgkJTZhsTfl2xBImOmH4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pQFDI7aL; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pQFDI7aL"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EEAB21BFA9;
	Wed,  5 Jun 2024 14:58:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IaCnvcuaBNb+
	3TTn4phQ+8waQOBfk/9/bESloJKWYI4=; b=pQFDI7aLrHsTfxB8LbxStB+O9v4K
	fFENdrtveCioBM2K89fTFvatdlFoXbtl//3bN3CGf5gcnFlc0mqf4pvanVabCpbU
	LMkA4QDsfGy3jE8Kz47nLry9m6lt3kr3VgxfklQv6HPh1vMenxnQ/YbeRO3291zE
	5rsB9fzplC61lKU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E67F41BFA8;
	Wed,  5 Jun 2024 14:58:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 135841BFA7;
	Wed,  5 Jun 2024 14:58:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] format-patch: assume --cover-letter for diff in
 multi-patch series
In-Reply-To: <xmqqbk4fs185.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	05 Jun 2024 11:17:46 -0700")
References: <6269eed5-f1ff-43f3-9249-d6a0f1852a6c@gmail.com>
	<14365d68-ed04-44fe-823b-a3959626684e@gmail.com>
	<xmqqbk4fs185.fsf@gitster.g>
Date: Wed, 05 Jun 2024 11:58:45 -0700
Message-ID: <xmqqy17jqkre.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 A35CDDF0-236D-11EF-9C81-ACC938F0AE34-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> Rub=C3=A9n Justo <rjusto@gmail.com> writes:
>
>> diff --git a/builtin/log.c b/builtin/log.c
>> index c8ce0c0d88..8032909d4f 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -2277,6 +2277,8 @@ int cmd_format_patch(int argc, const char **argv=
, const char *prefix)
>>  	if (cover_letter =3D=3D -1) {
>>  		if (config_cover_letter =3D=3D COVER_AUTO)
>>  			cover_letter =3D (total > 1);
>> +		else if ((idiff_prev.nr || rdiff_prev) && (total > 1))
>> +			cover_letter =3D (config_cover_letter !=3D COVER_OFF);
>>  		else
>>  			cover_letter =3D (config_cover_letter =3D=3D COVER_ON);
>>  	}
>
> Interesting.  So those who really really hate cover letters can set
> the configuration explicitly to 'off' and giving an --interdiff
> option would still have the sanity check kick in.  Makes sense.

This is not covered by the added tests, is it?

We need to test this case: the user asks for --interdiff but at the
same time refuses with --no-cover-letter (or its config equivalent)
to create a cover letter.

As I said already, everything else looked OK in this patch.

Thanks.
