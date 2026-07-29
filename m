Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100AB477292
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785326754; cv=none; b=uuTNVlvuPO1e1uu3etLefKUrl94h/AGH8jPOV0uyhJ/VbRpQPuKndQ1aZM2PhkU84zCRN8/+WCDvKDoJgIe5g0dRjqNl4Z70drsRsQZL8C44t19K96sJfpaqeA+ZUSD62TdNE3OQWzudkPTz4HXIKSKuoW7OKXWoU35fjPrR2cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785326754; c=relaxed/simple;
	bh=Tu7Tctilk9mhxpLFD1k7BKWPuAlQyGWiYvqsASft9bE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=roBJ+UjZstMlThXh99soiGvwp/RdD2d9ax8XkQEQsiby2TWhuvEMwJKG8oss0j7qvWBjaX8iK2kwukTP9ve96t5AuN5zi3WMjyk0cuO8FgY6qkOIvFnBkK0ahaNpQpk38YCxKY7bdaxq9g7+hOYsJMaa6WNHkqc976ceDKCv8WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McebbGuR; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McebbGuR"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f6609c657so464881f8f.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 05:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785326751; x=1785931551; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rLoAZRUvvC6YHfXjh37U5HedWTxLnzH/MOvFH2OPu1o=;
        b=McebbGuRLdePQdZfBbSpksBr4Johve4jcyS0zKaNJhcTLPRjlMpFNxsrHuvV65qxh0
         uVNhip2AwCbHStgDQP/sENiwWT9vKaM+r+KtZzgYtBruF4uuHP9RqtB6h4ksRSe03Bws
         ADKX8VQzhMhHAq+BRgNs9/dQma7XGtGg1hDtMDhmIp1UJ2YcK5+pJqOhYGF4eJAIVu/l
         Zgs9P15Lr8p4Nb3A1LY5sg9RYfDj5pavU3F1FviC+Ta6190RzEUlngXsZqKe0kdHfj5V
         1jmdVNyL3tXc9kVPBoY0pX+4zCw/njZetyL/1A1CaIvGVmDyDur/woqpp4xwZuSh5ZB6
         L6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785326751; x=1785931551;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rLoAZRUvvC6YHfXjh37U5HedWTxLnzH/MOvFH2OPu1o=;
        b=H/BZ3VpQ4nZwjiR/tfq+01Y2ZQQWPjoYIXZkNDzyhu/I8Ido/M+SrYmFb2jwYbEIel
         VIMWsVm5a+9nE5jrz9mUSO9mh3SAv6o9CIu2SbE0Tl1vryz154YB4Gue57XTkBsLc+Yr
         Em0af72HRfFqaDrVAmBdfygB3vEVycPlj95XV6ZJ58xWCNbxkzNAERhUgB8lD8EJ0K8p
         GUZOE76knx6mb5o/bDpLpZy1v92HJmTJIO5EffpFpIYadz8vhU5+/h0DN26s44HLQrcz
         6cBodT96iJbfxFp6/9f+gTUP+osrdkNnhDI6KljAsHjMtZXtdE8NnoLeegEle2uOPwop
         T1hA==
X-Gm-Message-State: AOJu0Yx+mHMCjLxScwQWTfyi2rNBxWVlaq/CVipnQ9cvcZFgYVlBiWnX
	8c3Yni8BUVoIQUcIbR3kdSxvNWAqMzZg02aXqqXCJzJ5KKMLRkFkPMX3
X-Gm-Gg: AR+sD10MDH+GOwhLCijZJTtt6jT2equHyL/y4yfbxBCsg8hZK1BNt9t6dpj2iERTnPx
	hKCtu1tbjX7nD2GKReGD+vbNTisv5d3Czi6lz+nMTQcWshfOr2MovJ7E4bcf3zUAxqi59vhpWcQ
	xfeM6gEGtewo8thGiAzrrzwPftIU0fii5fmdhDuSebVE5/cL9K8501x+wIM/3FiMvz3l+XMwpW+
	ef8F1FKBL3QHUq17qovg/1nK4qhl3WjMcZqxTHOF0SeUZcBEb0lMiaLPOiwqsM1mrWAsPeu/+8m
	cP9bBmxCcZAIG1N1urrvgfkneSH/OT//bXNYZ53TG92n4RTblsdZd7VcxT2KQNxtkDcOsAqI5qB
	uD/Roh4XQAAY+TqwBhHyGgGy9Qaf7lcB5wn9/L4BCOeoPMyv0DFlTbR5fC9vCboPRAgFlgFFigP
	QRxKrWx9k26pScLjSpnh4IZ1AwBat4ZwyV02yJi/vEj2hB0/T11IRioWOeZlsw0NqFtDOwOZoB2
	TKs0bBFpgVgVVslEbmI7Bjz7J5SZwhfDicYd4LYQ8uvd31LaQ5sV41JhsIi7KpkSzqdRGXPb4tz
	VX2v58CByb1zuXlObrlw8eK8w54+9z3+qFZ4mjo3QycSnbdueR73KDP8NOaE/m1p8gDrihwARjo
	=
X-Received: by 2002:a05:6000:2005:b0:47f:9107:9f1c with SMTP id ffacd0b85a97d-47fb1eb97femr6868850f8f.43.1785326750904;
        Wed, 29 Jul 2026 05:05:50 -0700 (PDT)
Received: from localhost ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6aa392asm6987585f8f.5.2026.07.29.05.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 05:05:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 14:05:49 +0200
Message-Id: <DKB1II4Z88SG.38KG7RAF9Q7VW@gmail.com>
To: "Chandra Pratap" <chandrapratap3519@gmail.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
Cc: <git@vger.kernel.org>, <karthik.188@gmail.com>, <gitster@pobox.com>
Subject: Re: [PATCH GSoC 2/5] fetch-object-info: parse type from server
 response
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
 <20260725-objecttype-support-v1-2-2d4ca3bbabf1@gmail.com>
 <CA+J6zkSQYuK-ZJoiQkEJDS9fBypOrBEmgYZRj1yYU00ws2u_HA@mail.gmail.com>
In-Reply-To: <CA+J6zkSQYuK-ZJoiQkEJDS9fBypOrBEmgYZRj1yYU00ws2u_HA@mail.gmail.com>

On Wed Jul 29, 2026 at 11:57 AM CEST, Chandra Pratap wrote:
> On Sat, 25 Jul 2026 at 17:25, Pablo Sabater <pabloosabaterr@gmail.com> wr=
ote:
>>
>> The server can handle type requests but does not advertise the
>> capability yet. Prepare the client to know how to parse the server
>> response once the server advertises the capability.
>>
>> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
>> Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
>> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
>> ---
>>  fetch-object-info.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/fetch-object-info.c b/fetch-object-info.c
>> index ba7e179c44..cf6b94afb8 100644
>> --- a/fetch-object-info.c
>> +++ b/fetch-object-info.c
>> @@ -50,6 +50,7 @@ int fetch_object_info(const enum protocol_version vers=
ion, struct object_info_ar
>>                       const int stateless_rpc, const int fd_out)
>>  {
>>         int size_index =3D -1;
>> +       int type_index =3D -1;
>>
>>         switch (version) {
>>         case protocol_v2:
>> @@ -101,8 +102,13 @@ int fetch_object_info(const enum protocol_version v=
ersion, struct object_info_ar
>>                         for (size_t j =3D 0; j < args->oids->nr; j++)
>>                                 object_info_data[j].sizep =3D
>>                                         xcalloc(1, sizeof(*object_info_d=
ata[j].sizep));
>> +               } else if (!strcmp(reader->line, "type")) {
>> +                       type_index =3D (int)i;
>> +                       for (size_t j =3D 0; j < args->oids->nr; j++)
>> +                               object_info_data[j].typep =3D
>> +                                       xcalloc(1, sizeof(*object_info_d=
ata[j].typep));
>>                 } else {
>> -                       BUG("only size is supported");
>> +                       BUG("unexpected object-info option: %s", reader-=
>line);
>>                 }
>>         }
>>
>> @@ -148,6 +154,10 @@ int fetch_object_info(const enum protocol_version v=
ersion, struct object_info_ar
>>                             object_info_values.items[0].string,
>>                             object_info_values.items[size_index + 1].str=
ing);
>>
>> +               if (type_index >=3D 0)
>> +                       *object_info_data[i].typep =3D
>> +                               type_from_string(object_info_values.item=
s[type_index + 1].string);
>> +
>>                 string_list_clear(&object_info_values, 0);
>
> Is there a risk of an out-of-bounds array access here if the server
> responds with a truncated or malformed packet?
>
> If object_info_values.nr <=3D type_index + 1, this will segfault.

This shouldn't be a possible case because of:

fetch_object_info()

	for (size_t i =3D 0; i < args->object_info_options->nr; i++) {

		[snip]

		} else if (!strcmp(reader->line, "type")) {
			type_index =3D (int)i;

		[snip]

type_index is set based of the range of object_info_options->nr so:
  type_index < object_info_options->nr

and a few lines below:

	if (args->object_info_options->nr + 1 !=3D object_info_values.nr)
		die("object-info: unexpected number of attributes: %s",
		    reader->line);

so we also know that type_index + 1 < object_info_values.nr.
After that we get to those lines that this patch introduced:


 +               if (type_index >=3D 0)
 +                       *object_info_data[i].typep =3D
 +                               type_from_string(object_info_values.items[=
type_index + 1].string);

 And because type_index + 1 < object_info_values.nr we can be sure that
 this cannot segfault once we reach this code.

>
> If there isn't a bounds check slightly higher up in this loop, we should
> add one. Either way, we should definitely add a test using a mocked
> server response (e.g., via test-tool pkt-line) to ensure the client
> gracefully dies with a protocol error rather than segfaulting when it
> receives a malformed packet.

Ok, that's sounds a good test, I think there's none where a malicious
server is simulated, in part because I don't know how and I think I
haven't seen a test that does that yet.
test-tool and pkt-line are used for the opposite: simulating the
client to test the real server.

I'll see what I can do about it.

Thanks for the feedback,
Pablo

