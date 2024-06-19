Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24CB17C64
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718808152; cv=none; b=B6Gin38yobGpGoYwINFnJ++u65CE9nyN98D1hb72EUcTXAj9YdnqDfCgg2DwRZd2rwFgFq0QYNze+XjuUkPz+UGrrg9cJNkFFQW67WEQKwoCcKtaZo67wvGgP9o19547b8YN0EneYZtSxT++S3A2CRW5Cs+6fMsIvSHAZkBicAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718808152; c=relaxed/simple;
	bh=oxU83Cy50AonkfbYgkSD0fZ3NNf4n7u67yRzjK+Egxw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=WUGJnch29/8HQixkzTgqBNyy/BlWwF31otAwFOkg/jeRiaCLWa8QwQSyOaE0jqp5AU3HpRo7NkE+enDkzyztwn231hcnQ9iXFUlJfsI6sqrn64XmsFoO/h0jX8jSyWnQ7Dz59qPIUZjEFlhcVrNyQcxhCrqQtm2wCXB5UxZDAzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 45JEfxUC3570076
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 14:42:00 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Dragan Simic'" <dsimic@manjaro.org>,
        "'Christian Couder'" <christian.couder@gmail.com>
Cc: "'Jeff King'" <peff@peff.net>, <git@vger.kernel.org>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Patrick Steinhardt'" <ps@pks.im>, "'John Cai'" <johncai86@gmail.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
References: <20240619125708.3719150-1-christian.couder@gmail.com> <0448495385b009f25a66b0712afb28f1@manjaro.org> <20240619134533.GA943023@coredump.intra.peff.net> <04b714d3e949c30bae0e26231e923fc4@manjaro.org> <CAP8UFD2k9YBoKf_=fj1UKNK+=J-2vMenwt8QyTXXSaf=uX6Otg@mail.gmail.com> <4ba6dececcfb3dcec5c8b7e64657a1ff@manjaro.org>
In-Reply-To: <4ba6dececcfb3dcec5c8b7e64657a1ff@manjaro.org>
Subject: RE: [PATCH 0/3] Advertise OS version
Date: Wed, 19 Jun 2024 10:41:54 -0400
Organization: Nexbridge Inc.
Message-ID: <000001dac256$d804a510$880def30$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHUvfRzK7z2XC+4Uuecgrzow0tdbQHeqvryAeKNQ2gB48xyzgJwsHEDAZIqZnmxjfJUwA==
Content-Language: en-ca

On Wednesday, June 19, 2024 10:20 AM, Dragan Simic wrote:
>On 2024-06-19 16:01, Christian Couder wrote:
>> On Wed, Jun 19, 2024 at 3:50=E2=80=AFPM Dragan Simic =
<dsimic@manjaro.org>
>> wrote:
>>
>>> > I don't mind if this is present but disabled by default, but then =
I
>>> > guess it is not really serving much of a purpose, as hardly =
anybody
>>> > would enable it. Which makes collecting large-scale statistics by
>>> > hosting providers pretty much useless (and I don't think it is all
>>> > that useful for debugging individual cases).
>>>
>>> I agree that it should actually be disabled by default, for privacy
>>> and security reasons, but that would actually defeat its purpose, so
>>> I'm not really sure should it be merged.
>>
>> One possibility is to send just the `sysname`, described as =
'Operating
>> system name (e.g., "Linux")', field of the struct utsname filled out
>> by uname(2) by default.
>>
>> It should be the same as what `uname -s` prints, so "Linux" for a
>> Linux machine, and might be acceptable regarding privacy concerns.
>>
>> And then there might be a knob to deactivate it completely or to make
>> it more verbose (which might be useful for example in a corporate
>> context).
>
>I'd be fine with advertising "Linux" (or "Windows") only by default, =
because it
>doesn't reveal much from the privacy and security standpoint, but =
allows rather
>usable statistics to be collected.
>
>A configuration knob that would allow it to be disabled entirely, or be =
enabled with
>more details to be sent would also be fine with me.

While in the code, can I suggest including the OpenSSL version used in =
the build? This came up in at a customer a few weeks ago and they could =
not answer the question of what git build they were using. Turned out it =
used the wrong OpenSSL header compared to what they had installed.

