Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA55918EB0
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963011; cv=none; b=hSwOmhJIdoKNn6uSVCAqEEpzssUmLIz8xPxaJ/HXHHYbl5GTCsS/MCBExf5q3hesZ/gj4rfU2LjV6l9UNiRQ5C7HcJbSariTFjKFbF0fh7Rn42jQxqoODhld8SzoNowkIlSW/7PnfnUpevZp+cn7JM7HGqbYH856hYG0h8aJaP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963011; c=relaxed/simple;
	bh=qtnQAYpB52xGDt9fMPGvmk4DjxZQ34qIknkvALB4Nds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dhPCOlBfNbGs8OL04b9lpr5d4QUKsbs14cyQn1EmH8nqq2g4sRhNdrPEtzmHh6GxBiKbBpnPF3vL8HcOrTzigTpRzhP+magamjOOAEMhxR7IStve023GY0nJWshg16T0N1K9i6UtnBqSsraBPz2EA+oBZ2xFX93gQ2k5leyChG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=C2hj2gY7; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C2hj2gY7"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3CA73230AF;
	Tue,  6 Aug 2024 12:50:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qtnQAYpB52xG
	Dt9fMPGvmk4DjxZQ34qIknkvALB4Nds=; b=C2hj2gY7q0hy6Ux7tFUvEZAtZZtd
	+2qqbiBk250Axmq9Ik0qbSyRScYRfLjsPEWvyW3lW+W5dpU1wvVLzA7rmI465Pbc
	Zx127LtU2tz5i5V34FaDTA0KUXBUse6Yr+1jKWhJ2kpxWUg8DIlZ0g6GVyj4WXPN
	oRkzN+k/YbqMpJE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 35912230AE;
	Tue,  6 Aug 2024 12:50:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DA87F230AD;
	Tue,  6 Aug 2024 12:50:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v1 4/4] miscellaneous: avoid "too many arguments"
In-Reply-To: <CAPig+cQ563EVtWEYxZDaQ4awrOcemc4a9a6OSmGN2wVFeMidwA@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 5 Aug 2024 22:31:37 -0400")
References: <20240806003539.3292562-1-gitster@pobox.com>
	<20240806003539.3292562-5-gitster@pobox.com>
	<CAPig+cQ563EVtWEYxZDaQ4awrOcemc4a9a6OSmGN2wVFeMidwA@mail.gmail.com>
Date: Tue, 06 Aug 2024 09:50:03 -0700
Message-ID: <xmqqa5hpvbno.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 EE314DF8-5413-11EF-9C57-E92ED1CD468F-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Aug 5, 2024 at 8:36=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
>> Imagine seeing your command failing with "too many arguments" when
>> you run "git cmd foo bar baz".  Can you tell it will work if you
>> said "git cmd foo bar"?  Or is that trimming your command line too
>> much?  Too little?
>>
>> Instead, if the command reports "unknown argument: 'bar'", you'd know
>> that "bar" and everything after it is unwanted.
>>
>> Let's make it so for a few remaining commands.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> @@ -2503,7 +2503,8 @@ int cmd_receive_pack(int argc, const char **argv=
, const char *prefix)
>>         if (argc > 1)
>> -               usage_msg_opt(_("too many arguments"), receive_pack_us=
age, options);
>> +               usage_msg_optf(_("unknown argument: '%s'"),
>> +                              receive_pack_usage, options, argv[0]);
>
> Is this supposed to be referencing `argv[1]` rather than `argv[0]`...

You are right.  To the command, the first argument is acceptable,
and the unexpected ones are the second and later ones, so argv[1] is
what it should have said.

>
>> diff --git a/builtin/tag.c b/builtin/tag.c
>> @@ -641,7 +641,7 @@ int cmd_tag(int argc, const char **argv, const cha=
r *prefix)
>>         if (argc > 2)
>> -               die(_("too many arguments"));
>> +               die(_("unknown argument: '%s'"), argv[2]);
>
> ...similar to how this references `argv[2]` when the condition is `argc=
 > 2`?

Yes.
