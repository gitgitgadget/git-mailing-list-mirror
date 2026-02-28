Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60BC43636A
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772278129; cv=none; b=pX3sBjkyqNJC9paaKycMCeCbNhY0CRZ7NsO0orEul+jNscm+tPNYVC8z/cd6QnV3s7MafFUbt80eZefmSujadGOfpI8CkZpEoKkiL2Ldar0YnY953GO22WLk+hlC3kG2vT3g6tblV4fGNrzZaZG6sVXvRwUjYvSyi788eicNqTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772278129; c=relaxed/simple;
	bh=wI+83D+L54pKxWY8656eQTppEYKgiFoBzSj/8TbFFsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NX5AXpuFXCBd9kVlJU+hQ7cy5I8l5SDroprWFJj2a7fZPdiqH+kKD0NUJigI33c03zXTdcwGaUz4Rp7ErXXz84hXwCsqSNjFIaGRNyEXEWsb2fu2OKLUTkxXc0no6ezw9X9hg6BidEePN25KZgDM4+AlzdG58RfjD4y3bSCEb/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=R9MCRire; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="R9MCRire"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1772278120; x=1772882920; i=l.s.r@web.de;
	bh=Q5eCYImmZxhj89n5mNwrwbGiQKkbdzpKiV8XvYxQLSo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=R9MCRireUkC/YzNqLgWHO9e7ETk/2IA2yIlEI66Ni/kEmZkNxmuDO+eqDnrbQseA
	 5AUfaXVexQZwj4YqPHXPMw6jJt1wY8gWcTyaVWWTHKN3F3dhz3qverH07BRAp5TqQ
	 KbVdCYVd+79oyuQQkOnW5AbCFWcMM+BeBpeYUIP7NzJ13HRxF0xAOcxuOGBk2UfE8
	 MTGaFKZSlcI28he9+ZxV3BzjGFA2WGKmPeVbpPZL7FO7a+zW4c8n0B5IYVPfGikXA
	 VYx3mft4LY2eaG8GJ6xLd7SFydiiUymcPrY8UMWa3FJ9eEmHVeocnheQNYto2oDFz
	 lT6boid9m85fA4BknQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4eCL-1vWYdM3U6J-015kY2; Sat, 28
 Feb 2026 12:28:39 +0100
Message-ID: <7c221132-c2ac-4c6f-9d89-72677a74beb5@web.de>
Date: Sat, 28 Feb 2026 12:28:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] parseopt: check for duplicate long names and
 numerical options
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq5x7jujqb.fsf@gitster.g>
 <7693799a-91a2-480a-ae3e-29f8eed5b55a@web.de>
 <6b674316-9a6e-4f57-b32c-f1824869ba7e@web.de>
 <20260228105849.GA3626520@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20260228105849.GA3626520@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:868dPN/FHXSL4OfVUblnGX7FHWciALiC1xhcsjnUF5k3l56mZ15
 6BNSFeUzcN4+v3r0rVQBFkr/h/E5V8mkZ2A+56zCMvHStauy+uI49fyDrXCdiSlyZYvb+8+
 twR0KI0Q5LEeAtDTwb6mcC+I5/eqUDvL0HdFYmEBFIcW0zjqDuVaeF86Mc7XUPcxHJD0WIT
 x6lkq5ZGNC2qqAqGvuFGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:olKiPVR2bek=;xihSqaQgUpr3WjWgUOmsHu4qjfw
 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
 DPSNwCBKzsMDustn9Bld4ZXAkl8Gv

On 2/28/26 11:58 AM, Jeff King wrote:
> On Sat, Feb 28, 2026 at 10:19:16AM +0100, Ren=C3=A9 Scharfe wrote:
>=20
>> +static void parse_options_check_harder(const struct option *opts)
>> +{
>> +	struct strset long_names =3D STRSET_INIT;
>> +	for (; opts->type !=3D OPTION_END; opts++) {
>> +		if (opts->long_name) {
>> +			if (!strset_add(&long_names, opts->long_name))
>> +				optbug(opts, "long name already used");
>> +		}
>> +	}
>> +	BUG_if_bug("invalid 'struct option'");
>> +	strset_clear(&long_names);
>> +}
>=20
> I confirmed on my silly pathological case that invoking rev-parse with a
> real option shows no slowdown, and we now pay the same 10ms cost to show
> "-h".
>=20
> Your other email made me wonder how the sorted-array solution might
> perform (patch below). It shaves off 2ms of those 10. Probably not worth
> caring about for "-h" output (which is already spending another 5-10ms
> to generate the output, versus a normal parse).
Curious; sorting performs worse on my machine (Apple M1, 1 is 2cc719175,
2 is patch 2 v2, 3 is your patch on top):

Benchmark 1: ./git_main rev-parse --parseopt -- -h <input
  Time (mean =C2=B1 =CF=83):      77.5 ms =C2=B1   0.4 ms    [User: 73.1 m=
s, System: 3.5 ms]
  Range (min =E2=80=A6 max):    76.8 ms =E2=80=A6  78.5 ms    37 runs

  Warning: Ignoring non-zero exit code.

Benchmark 2: ./git_strset rev-parse --parseopt -- -h <input
  Time (mean =C2=B1 =CF=83):      82.6 ms =C2=B1   0.3 ms    [User: 77.7 m=
s, System: 3.9 ms]
  Range (min =E2=80=A6 max):    82.1 ms =E2=80=A6  83.7 ms    34 runs

  Warning: Ignoring non-zero exit code.

Benchmark 3: ./git_qsort rev-parse --parseopt -- -h <input
  Time (mean =C2=B1 =CF=83):      85.6 ms =C2=B1   0.2 ms    [User: 81.2 m=
s, System: 3.5 ms]
  Range (min =E2=80=A6 max):    85.3 ms =E2=80=A6  86.5 ms    33 runs

  Warning: Ignoring non-zero exit code.

Summary
  ./git_main rev-parse --parseopt -- -h <input ran
    1.07 =C2=B1 0.01 times faster than ./git_strset rev-parse --parseopt -=
- -h <input
    1.10 =C2=B1 0.01 times faster than ./git_qsort rev-parse --parseopt --=
 -h <input

