Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1AF15A863
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717748408; cv=none; b=GG899svsZYFZiSrI7qbbaopM9Iwc6e39To2cA6c2qf0V9rxQmvI+yNm/v4VwC/4NhcihNmD9c4Yf9LGMMpyGkuT/oxtW77fr2sGy1gR/aadZZu4WzT9g0pGXu1fY8UiubDEhMslQYZb6ElILV1zK841KZ+J7/0dFGdxC/ketOaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717748408; c=relaxed/simple;
	bh=1S571/SfQQrfcKHQcc7geXZpKapH4env9aSGG4CYJrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NwunySoyEyI/6oJIX0JmmMEyIg2T0/yPGh2nDHKZP9+HAE0Vv3hV97ZPUBpuwGBzdOHO1JrQAvIBGmPCSiFTPwYXs/Rq8FJnvetbLO+4vbicYqPpKUENUyvSxJ9X5Csz95tbF7yFmC4T+ND6Z+OmqVq0fMCqyV1IXicuP9ZxQ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=JtrV+Mfv; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="JtrV+Mfv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717748391; x=1718353191; i=l.s.r@web.de;
	bh=KcOHH77QZZUkbeOCVzi2wlyRHHJq45qCPH3SnyirEaQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JtrV+MfvJCg0iFSJ8OZQjjBu+Sbeurqx+CoyM8WEESpnl2yv25rWwO4TDK/mIP3m
	 rBn8Mn0AQutze8bzIWkj3G3Axv/PjdhU1DmBqg7LsBMocW4zGweGVueesCIePI1m7
	 jttbu6cQf9HrEuXIaEFeXFnf2MaQC9C9E1iTGTGd9pshYtkR3L5rIbMc2uyUHWsPC
	 Vo5Z7UOHkUNtYFw27Q4bS/YVqbe1VzGo10H/3r+WA1XHIK82Ecdisup4aphLfYFQI
	 Wcr/AA9GfUAo6gTn/OSr/f3X4ytuO0e02vvFNuZUwxcxZ0DSU2+fgzAx8wxP2QU1K
	 4DLR5t5j4KL8r/HmJw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mq182-1sjehp0Z0c-00gLQF; Fri, 07
 Jun 2024 10:19:51 +0200
Message-ID: <524e4728-a63c-46fc-af73-35933c1906ee@web.de>
Date: Fri, 7 Jun 2024 10:19:50 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] diff: let external diffs report that changes are
 uninteresting
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 German Lashevich <german.lashevich@gmail.com>, Johannes Sixt <j6t@kdbg.org>
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
 <82561c70-ec33-41bf-b036-52310ffc1926@web.de>
 <e2e4a4e9-55db-403c-902d-fd8af3aea05c@web.de>
 <6fa51a62-5dc1-4865-9f79-eaf7d65189ab@web.de>
 <99a99e5c-4fe4-413a-9281-363e280716b8@web.de>
 <7ef4a566-6d55-4924-b02c-38137c15791a@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <7ef4a566-6d55-4924-b02c-38137c15791a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A8aQl2hlVl3Fok4/HoXU8dal7Tj8z1lJdMxlAC2F0pxuXbywHpe
 SYbcWUeZbaLXXQP5GAbDvMKCGyl9sXglAL1BDRakcwZtCO2jU+6IAMtbixas4olVhYrNTR2
 mA5EbD9dBJcsFz+E/wZDvuNfhk93tR1DGgXhAR8Pr6X//MeT4pWvs6OdLd9N29RH9F9uLZb
 GJ6DaPtB/FmmMW5WCzeJw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y7m5mwNobNY=;/CRozLHKqOSdUmj+rIwZlUuqH3I
 IBFzn2t9NJ6HYZ4VUhZOEHxJ+esOzKy4j95IhdX90LTZQJSUDhbiPOyVTSsrrkV9+iOYWFpnB
 7CI7arYBaNMm1tnG+HEHqNj9h4uxvHBvxcmMd3zWrYLCstGBnWogaBIJW3vPB2pjPVX/3pb+L
 zW3ZkPwhkyD2C7D8poeOxmH6KFxH/QBOSntGY94s9gbhCRjn+2fpYLd8FQGOjngkneaxYvKAB
 krxpqwAeeo2KELTaZFxGVa0qyDE2OPabPn2T4lCGyeuqKea5pjJVA98mtKaPTVTIjSw78kxhh
 WDU/9CCNnLAXxhBzkWwAtC4TqT1sypk9Iy89GDMN6Mp9FytOZpL0sOWeFaP49z8pk5jZ3EiCC
 dCYISfbxmqUDscodCVlowCK7pcE4v1fpimYcGkEQp524SYzZGMCEBzjkmx76j50fqB+/e05KY
 sY0jJv10vkfzkaM+NG0ar/PtDuXVyBIxMCTKNfK66qa8NiTcVavWG1utPKx6srE2zcTCHrMWV
 f7HReW066wtt2oBDbDsBJ0zf7TtfnpqYFKb+SqnZ9YdmXd3spfgLU5azP4eJ2/OCBPLp561Ms
 eR7oLpmnKH8DNP41BR40Aue4PY2toNUmiwmVHwoa9I2zthzkjQiOG1m8UnB3Ibtnv/04Rs+ch
 auDL2wtYskRyG9AoWrI36tkbvAbT+e86DDIJ34TjfhEQSBe+fVdgIBgl65PCXYuRMUSTvNB7y
 phW5D3FDE+JK9XW3zyQaSVfRacZmMOc3SDBDddSOYTQGJP14fhOteU7TtHidvERD2heGqebNz
 eVJudXnbu86oFh4htHY9/rFVPZTK2PC7qUoCz+LfP4XAM=

Am 06.06.24 um 11:48 schrieb Phillip Wood:
> On 05/06/2024 09:38, Ren=C3=A9 Scharfe wrote:
>> +diff.trustExitCode::
>> +=C2=A0=C2=A0=C2=A0 If this boolean value is set to true then the `diff=
.external`
>> +=C2=A0=C2=A0=C2=A0 command is expected to return exit code 1 if it fin=
ds
>> +=C2=A0=C2=A0=C2=A0 significant changes and 0 if it doesn't, like diff(=
1).=C2=A0 If it's
>> +=C2=A0=C2=A0=C2=A0 false then the `diff.external` command is expected =
to always
>> +=C2=A0=C2=A0=C2=A0 return exit code 0.=C2=A0 Defaults to false.
>
> I wonder if "significant changes" is a bit ambiguous and as Johannes
> said it would be good to mention that other exit codes are errors.
> Perhaps
>
> =C2=A0=C2=A0=C2=A0=C2=A0If this boolean value is set to true then the `d=
iff.external`
> =C2=A0=C2=A0=C2=A0=C2=A0command is expected to return exit code 0 if it =
considers the
> =C2=A0=C2=A0=C2=A0=C2=A0input files to be equal and 1 if they are not, l=
ike diff(1).
> =C2=A0=C2=A0=C2=A0=C2=A0If it is false then the `diff.external` command =
is expected to
> =C2=A0=C2=A0=C2=A0=C2=A0always return exit code 0. In both cases any oth=
er exit code
> =C2=A0=C2=A0=C2=A0=C2=A0is considered to be an error. Defaults to false.

The first part looks like an obvious improvement.  Stating that
unexpected exit codes are errors looks tautological to me, though.
Perhaps mentioning that git diff stops at that point adds would be
useful?  Or perhaps a tad of redundancy is just what's needed here?

>
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strvec_push(&cmd.args, pgm->cmd);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strvec_push(&cmd.args, name);
>> @@ -4406,7 +4424,10 @@ static void run_external_diff(const struct exter=
nal_diff *pgm,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 diff_free_filespec_data(one);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 diff_free_filespec_data(two);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd.use_shell =3D 1;
>
> Should we be redirecting stdout to /dev/null here when the user
> passes --quiet?

Oh, yes.  We didn't even start the program before, but with the
patch it becomes necessary.  Good find!

>
>> -=C2=A0=C2=A0=C2=A0 if (run_command(&cmd))
>> +=C2=A0=C2=A0=C2=A0 rc =3D run_command(&cmd);
>> +=C2=A0=C2=A0=C2=A0 if ((!pgm->trust_exit_code && !rc) || (pgm->trust_e=
xit_code && rc =3D=3D 1))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o->found_changes =3D 1;
>> +=C2=A0=C2=A0=C2=A0 else if (!pgm->trust_exit_code || rc)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 die(_("external =
diff died, stopping at %s"), name);
>
> This is a bit fiddly because we may, or may not trust the exit code
> but the logic here looks good.

Yeah, it's not as clear as it could be.  One reason is that it avoids
redundancy at the action side and the other is adherence to the rule of
not explicitly comparing to zero.  We could enumerate all cases:

	if (!pgm->trust_exit_code && rc =3D=3D 0)
		o->found_changes =3D 1;
	else if (pgm->trust_exit_code && rc =3D=3D 0)
		; /* nothing */
	else if (pgm->trust_exit_code && rc =3D=3D 1)
		o->found_changes =3D 1;
	else
		die(_("external diff died, stopping at %s"), name);

Or avoid redundancy in the conditions:

	if (pgm->trust_exit_code) {
		if (rc =3D=3D 1)
			o->found_changes =3D 1;
		else if (rc !=3D 0)
			die(_("external diff died, stopping at %s"), name);
	} else {
		if (rc =3D=3D 0)
			o->found_changes =3D 1;
		else
			die(_("external diff died, stopping at %s"), name);
	}

We should not get into bit twiddling, though:

	o->found_changes |=3D rc =3D=3D pgm->trust_exit_code;
	if ((unsigned)rc > pgm->trust_exit_code)
		die(_("external diff died, stopping at %s"), name);

>
>> -check_external_exit_code=C2=A0=C2=A0 1 0 --exit-code
>> -check_external_exit_code=C2=A0=C2=A0 1 0 --quiet
>> -check_external_exit_code 128 1 --exit-code
>> -check_external_exit_code=C2=A0=C2=A0 1 1 --quiet # we don't even call =
the program
>> +check_external_exit_code=C2=A0=C2=A0 1 0 off --exit-code
>> +check_external_exit_code=C2=A0=C2=A0 1 0 off --quiet
>> +check_external_exit_code 128 1 off --exit-code
>> +check_external_exit_code=C2=A0=C2=A0 1 1 off --quiet # we don't even c=
all the program
>> +
>> +check_external_exit_code=C2=A0=C2=A0 0 0 on --exit-code
>> +check_external_exit_code=C2=A0=C2=A0 0 0 on --quiet
>> +check_external_exit_code=C2=A0=C2=A0 1 1 on --exit-code
>> +check_external_exit_code=C2=A0=C2=A0 1 1 on --quiet
>> +check_external_exit_code 128 2 on --exit-code
>> +check_external_exit_code 128 2 on --quiet
>
> It would be nice if the tests checked that --quiet does not produce
> any output on stdout.

Right, we need this after unlocking external diff execution with
=2D-quiet.

Ren=C3=A9
