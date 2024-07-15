Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC143F9EC
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721057985; cv=none; b=utXXAGEdE66MBAP2Lv9qAsFbKteQU3w01HZYvgp6Im7EEqkCfg4UyWM1H9ecjnR/v1adGVCYWj0SqJseoUJgDOtZk1xtPZXunW4SUrRUMpqk01LnA7rwEB+WI3RRxlQCsQiSuIQwPCCU1ZgsTgjkoARBdGoaj/JNMVcwvhNK0rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721057985; c=relaxed/simple;
	bh=3dgcuWf8G8Yrl/DZiD2e3kBvZnYaEm4eWpOxi+O9bzE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bGl86Pqe8rZdcOMaM8UgaMLy8SyA/Iu5bvzYtzfcFX13UUHUqUDaCHqNPU+gZ3mIJEMvj+b1gUNGLIS/1g91VZE4aj7Du6jxpwIDd1qG7zOHa7WBSBsgw9Wjf4YSP8OMCf30oWooDquSD74/znY6WwqoKOhygQW2qXDQLuGNouQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OHYTVlCw; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OHYTVlCw"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8D21221AA4;
	Mon, 15 Jul 2024 11:39:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3dgcuWf8G8Yr
	l/DZiD2e3kBvZnYaEm4eWpOxi+O9bzE=; b=OHYTVlCwwzwCD7rXLYHBBoWS7Lqt
	wzlfQ93WFoEI8a8X6k/F7X25NP/JTota8/r6E4ue0avMlHPDmuW44itJu9GOdTxd
	QyEyAXLBMgT94oyzggPIZR1FbPAsvSNw8SvnT7qyR4P8Zwwee55oTpNnv5IIr5P2
	cyLPTBOIXQz1aXQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 853AA21AA3;
	Mon, 15 Jul 2024 11:39:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 12DED21AA1;
	Mon, 15 Jul 2024 11:39:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Alexander Shopov <ash@kambanaria.org>
Cc: git@vger.kernel.org,  worldhello.net@gmail.com
Subject: Re: [PATCH 3 1/1] parse-options: localize mark-up of placeholder
 text in the short help
In-Reply-To: <CAP6f5MkGQssKyAdgN3rbzfTZtPgETaSjpm3JevuaLg-vh_pNug@mail.gmail.com>
	(Alexander Shopov's message of "Sun, 14 Jul 2024 22:41:28 +0200")
References: <xmqqttij86lc.fsf@gitster.g>
	<20240707153526.97984-2-ash@kambanaria.org>
	<CAP6f5MkGQssKyAdgN3rbzfTZtPgETaSjpm3JevuaLg-vh_pNug@mail.gmail.com>
Date: Mon, 15 Jul 2024 08:39:38 -0700
Message-ID: <xmqqjzhm7jgl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 72EA8B50-42C0-11EF-8F5B-DFF1FEA446E2-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Alexander Shopov <ash@kambanaria.org> writes:

> Will the patch for expose substitution hint chars be included in 2.46?
> Should I do anything more?

Sorry, I lost track.  Did we resolve why "<>" is special and but
"[]" is OK to leave out of the translatable text?  IOW, is there
much point in advising the translators that "<>" is something
specifically they are allowed to change?

Stepping back a bit, would translators (especially for languages
without any need for the ability to replace <> with something else)
understand when told

    TRANSLATORS: change `<>' to other characters or leave as is

why anybody would want to change it in the first place?  Stepping
back even a bit more, probably making it clear to them what these
instances of [<%s>], [=3D<%s>], etc., are doing would be sufficient
to help them making the right decision?

If a translator for a hypothetical language that uses say =E2=80=9E%s=E2=80=
=9C
reads

	/* TRANSLATORS: <%s> here stands for an command line argument */
	_("<%s>")

in the comment, wouldn't that be sufficient to tell them they are
allowed to change "<>" to "=E2=80=9E=E2=80=9C"?

Similarly, explaining [<%s>] as "optional command line argument",
would tell them that it is OK for them to replace not just <> but
also [] if their language requires such a change, no?

Thanks for pinging.

>> diff --git a/parse-options.c b/parse-options.c
>> index 30b9e68f8a..06d962b00e 100644
>> --- a/parse-options.c
>> +++ b/parse-options.c
>> @@ -1070,11 +1070,17 @@ static int usage_argh(const struct option *opt=
s, FILE *outfile)
>>                 !opts->argh || !!strpbrk(opts->argh, "()<>[]|");
>>         if (opts->flags & PARSE_OPT_OPTARG)
>>                 if (opts->long_name)
>> -                       s =3D literal ? "[=3D%s]" : "[=3D<%s>]";
>> +                       s =3D literal ? "[=3D%s]" :
>> +                         /* TRANSLATORS: change `<>' to other charact=
ers or leave as is */
>> +                         _("[=3D<%s>]");
>>                 else
>> -                       s =3D literal ? "[%s]" : "[<%s>]";
>> +                       s =3D literal ? "[%s]" :
>> +                         /* TRANSLATORS: change `<>' to other charact=
ers or leave as is */
>> +                         _("[<%s>]");
>>         else
>> -               s =3D literal ? " %s" : " <%s>";
>> +               s =3D literal ? " %s" :
>> +                 /* TRANSLATORS: change `<>' to other characters or l=
eave as is */
>> +                 _(" <%s>");
>>         return utf8_fprintf(outfile, s, opts->argh ? _(opts->argh) : _=
("..."));
>>  }
>>
>> --
>> 2.45.2
>>
