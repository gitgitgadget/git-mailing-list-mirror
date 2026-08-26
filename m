Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDDB1B4223
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787761432; cv=none; b=DN84FEBKBYeAHYPwHpMD8ggUmmrwRN4NaBnLXyM4QcqsdUbU4swFXEeMhsKZXvBPF/oshRLwVDK4HELOHpjk4UiM3ncadJ8MJ5doOeE+f/jDI2fVtF/aw6ZCzm9q1UTA3lJ35muszMo8gC+igIR1Z2QYCffjH34jvOXnQcMGlhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787761432; c=relaxed/simple;
	bh=6rPlGs9vTW8vs08E/xLh7lFhQTh537JfiyLWzG+KYmg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q2R6JnrObKm7Jf4u7Y6IQk6LLkma9e3BlrRCLxLp2NUTJ64SLl/oJKQfGdDl9owC9wIhyb4f7+brg2tzD5pYU/LHo67LWeUt4n26HnyhQqHZmlpKibRP9mMWKvdOcu4190NmwJEvjSmjwBC2A8BRd5GdDiIwpcnu8jogotUaSZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=capVY1yw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Za27IV/0; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="capVY1yw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Za27IV/0"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 49DB91D000E8;
	Wed, 26 Aug 2026 12:23:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 26 Aug 2026 12:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787761430;
	 x=1787847830; bh=G7vFU6r4cfTDrS9xG3HxB6gDv2RoMNURl1w/d5EG2Zw=; b=
	capVY1ywQEr9MoZJyy33Wrba1T2HkvQmHL706DHuBU9VgqQ4AmiWIqhPBesU6vbB
	qycUKRDMwoGDJonwWzlybgvTZXo3i9RARloCSujJKU8ZKMPk/Cn6cDiJW4AVxWWH
	mvjOpX0AFmU0sqMHvXBsg7zlWA9WYkNwHJznoojw0bxcn4CN9zGnnZ17cdg/yYo/
	JOk+jWG/D0VffW/hTUYl+lerJcDhywqZPpGZ25hDFKPJMPL1kHacpSD6o+UF2dBm
	qTnKl3OaddNjcBQWi1GHLnk/balM73otdut9Tdz08ztWSiduNfIFt7APjOl3cj2/
	SRgX3pAlvVz+qdg2uI+pNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787761430; x=
	1787847830; bh=G7vFU6r4cfTDrS9xG3HxB6gDv2RoMNURl1w/d5EG2Zw=; b=Z
	a27IV/0mTZopTTpp2cbLntlQUluaOoftE+1moVooVoDyaxlHOTRRgYA4+To3iG7D
	Obt3Y28DlkGKenHuQtkh0NlB1w7abPkneqmdbxye4KTDjyV3cZ+nH84a+80Z11MG
	1PIrdRhEzsG318G754eodpgt8J6PQhh4kb4KzNB6oYdz6sFBoaYVqHELlMyLpqwd
	3DTXj/LhSPn4FhOPnUbikd8Ss6PEqBNINm7+pMgsSJsX8iIN1AYhKZNuoZrfbxR0
	q1NlcixFSExN9+q0Dz+PGPHet5X8m6NSAKfiaVNqQiPG588hFtUpjd4rEgB4AlaY
	pYIZwNsTrlPCjFbp38Fhw==
X-ME-Sender: <xms:FhOPalrNmOcbbRRHvDuP03z0-VWGkW5655qWhVzROUDfeahJwbPFdQ>
    <xme:FhOPavFCWPG3L7JG4R_P3EgBOMqysAkBst_gGagL9gaiBLUbc5BKPGwM8TVQw4Qu6
    XZu2v07hj5qwu6lYW8qVW5G2aQBhb6LxI4YvDy33jFf07THJWH1Jw>
X-ME-Received: <xmr:FhOPavkOY_ce8zpx0eSDphs8_tzagd3b5u0YrGEOt8p_zXiaySgEv-5igUlh0SzPurlPfsc0TooRA1LCwhe7zN-yDyofFZbQxQ>
X-ME-Proxy-Cause: dmFkZTGldF1uSS3MpTZMIKqicS6J8RerWB8uAdu6s3bQbfET7N2x3+FyHMkDm8w1ytarIs
    lo8dLwm0GLkM9IuuXZNKKW0x+lX5els20tg2s5d/8/U507RzcfAryVBKuS5mB8hbsSCdNX
    pT0tmz/HQrWx9krUV3CH3V/1+E3jr9bW8GApvH0+7DlPA+dYm+zmFlgFcIPwLy7Kh2Me5f
    +oBsSEGleGI65CtKRY7DSni9L2SeBqvkPSyVNb45tKtwzhrxq7KoH59tl8+MNp1+uUwpRR
    Ss2rlwaeUOdYqxDQD1cSjf/XEdxDsKlJoMLFmHBF7b3qW5q+63SeJfLdjOYhGCx8lnhSFP
    6AgBvs7A2xAnz96EQndA7oNTWhCevd1NBNGGhopzyyUK/RtzvOITPxUhpnWRHc53Wyk8Mf
    lbRCtixXhUzb6hAoUKqpNRxpfnwgR87VoE8/CMQr8uy/9S9YngC6bYpu4hL025vyCH4cJZ
    uDf+fxa9uiIVhIUQ1FZ4ltntbXV2IGkTM+iliyoMO3fXzcnjD2nzA/4+OVV2VXqyBigGW7
    qJ/0OljhkV3GM6tVjcLlxWhmj7AEHyYdzzQ/3j5d59CREBIUSmdg+FdWBfmOlg/vbdZ+wh
    6jH0yzJNkjVWFKgWjp7vrvNzB/Mp3IcNXbcatQszCfkniR3D8lT5T3/BYJxg
X-ME-Proxy: <xmx:FhOPaqmZ9_gEUfHwNK9wPkaH1CU3Dpdx9RR4qbRh2ALnmaCBLA8sPg>
    <xmx:FhOPaou-pxXYk0ciuuuT6rpbN5ZHxa8-Itx5CBT-vJCCIdjBLnmIVA>
    <xmx:FhOPalmEUirQsUB4oiRsqt721oBssvlhXSDvLGTpN4hgg8sxHSLKYA>
    <xmx:FhOPartZ6cX0ZGGmXNidvFCddBM17mmg6hCHHYSXtfehCFKjlbm_gw>
    <xmx:FhOPasOUSUBc5_14ldb2B8lR7_A1OA-uZBkD1UhNSQgDrQiz9PsE_5p7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 12:23:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] you_still_use_that(): reword the instructions
In-Reply-To: <CAC2Qwm+Gg3nhxtwhQjrvrk6Pm_R=XEpAwYxVKqT0Ps9UZ-DAyg@mail.gmail.com>
	(Michael Montalbo's message of "Wed, 26 Aug 2026 09:06:56 -0700")
References: <xmqqo6epj6is.fsf@gitster.g>
	<CAC2Qwm+Gg3nhxtwhQjrvrk6Pm_R=XEpAwYxVKqT0Ps9UZ-DAyg@mail.gmail.com>
Date: Wed, 26 Aug 2026 09:23:48 -0700
Message-ID: <xmqqv78wj1ez.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Michael Montalbo <mmontalbo@gmail.com> writes:

> On Wed, Aug 26, 2026 at 7:33 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> diff --git c/usage.c w/usage.c
>> index 3f0118ab2a..9933b9911c 100644
>> --- c/usage.c
>> +++ w/usage.c
>> @@ -392,15 +392,13 @@ NORETURN void you_still_use_that(const char *command_name, const char *hint)
>>                 fputs(hint, stderr);
>>
>>         fprintf(stderr,
>> -               _("If you still use this command, here's what you can do:\n"
>> +               _("If you need a replacement:\n"
>>                   "\n"
>> -                 "- read https://git-scm.com/docs/BreakingChanges.html\n"
>> -                 "- check if anyone has discussed this on the mailing\n"
>> -                 "  list and if they came up with something that can\n"
>> -                 "  help you: https://lore.kernel.org/git/?q=%s\n"
>> -                 "- send an email to <git@vger.kernel.org> to let us\n"
>> -                 "  know that you still use this command and were unable\n"
>> -                 "  to determine a suitable replacement\n"
>> +                 "- Read https://git-scm.com/docs/BreakingChanges.html.\n\n"
>
> I noticed there are now two newlines at the end instead of one like before. Same
> for the lore link below. Is that intentional?

Absolutely.

>
>> +                 "- Check what others on the mailing suggest as a replacement:\n"
>> +                 "  https://lore.kernel.org/git/?q=%s\n\n"
>> +                 "- Send an email to <git@vger.kernel.org> asking for help, only if\n"
>> +                 "  suggestions by others do not work for you.\n"
>>                   "\n"),
>>                 percent_encoded.buf);
>>         strbuf_release(&percent_encoded);
>>
