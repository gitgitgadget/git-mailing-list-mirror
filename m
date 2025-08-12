Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7446C2F8BF6
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015712; cv=none; b=ZdL0QMGqK2EKxExE47END6Kz6mrvA4jvbcCnvH8VPXcYyOh1JXCetmMp5ofM6BX0vq11SxGJnF0YRVFVakYkHHjr1++mYFqTYiL+3Od0B0zZAJ1hgZM9VrYOZH2//0oQEEhYowGVrIIDFPZU2ci9T+gV4SEmA10dtBfqDIbBa+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015712; c=relaxed/simple;
	bh=AICI0EOwlF5xZEi1S0spuGL+nYgzfAw7eKGJokVRT5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tV/LrLwzaEpxyF0SjBjhSd3sBE85ro/1IqSWYLGTDeFHYXj2Iu7OjAXdxprZvK5VsPhmlp/Ze53rrn4KUnFwH8ud7Ltr9MKWW2VfglnZuLpUzqTzVnlpNYe2B+FncJqsbaXlDbSsVV9qtlTp0TzN+m124lGVMAvMJploasqCFow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=RwSwQ9C/; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="RwSwQ9C/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755015702; x=1755620502; i=l.s.r@web.de;
	bh=AICI0EOwlF5xZEi1S0spuGL+nYgzfAw7eKGJokVRT5k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RwSwQ9C/9IdNplAt+SZVRbpWGnZUQ+a7a3Tf3aTZusSd9qRq8plmNlmBnoAOhaKN
	 LgCYVhRyN6iLmBhCkOV1Ajqzim/oI6UBuymH4scIWJRhu2DVAMjUPZgxrEX2abs90
	 fx9ri1HU3dd/A7xWQNRVAMblig2Khqfgc+ljkUms5SnHvSNmUqnUMznfkpXJFef52
	 erLFFueK0beUKXlKztC02Nn39oB4CsEXD+Vpjlpg13iLhEtyJSVfmQ9n91Y6nUIgM
	 bOpVvFlKo0gn9cHTcgOt9gb4OrEHj6iuul6sgvG3Gx2TdwwM5c+2xNdGhUit6JXqz
	 CjBBiGZQrNRszmWZ1A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.152.110]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXoca-1v6ftq07tE-00NWOd; Tue, 12
 Aug 2025 18:21:42 +0200
Message-ID: <5c7942a3-bccf-44e5-94c2-39fc50f9bab3@web.de>
Date: Tue, 12 Aug 2025 18:21:41 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] abbrev: allow extending beyond 20 chars to disambiguate
To: Jon Forrest <nobozo@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Derrick Stolee <stolee@gmail.com>
References: <xmqqfrdx517b.fsf@gitster.g>
 <aJpd2MYMWgEoxQWi@fruit.crustytoothpaste.net>
 <e463481d-b6a6-4928-86e1-63677f5a88b2@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <e463481d-b6a6-4928-86e1-63677f5a88b2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y4rLYeQYHGybeJM58mHlnTPDGo4RIKK/i7e+44ooIZOtNDIcqZb
 V6IUrDug/4ciCbkAa9PQV4/ONxEklyCe+EcxWtTetWJE0qHITIrAecPjUL7pYJX9yZ0Mf8i
 4sqa6xZq7Vc1IxZ6N/1QSQfsUCmIwczc5FgC+uaPyPRzBAzvfCEQZR6E02c+yUlbtrISp4u
 tACLMD+Ia/+sDklUiZh/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d6iHz+cIKiw=;idSiC/vHsta0IULxzSTfsBgh3L8
 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
 HaI5IL7WaDKXeqkT+s2TG7LufFBWKqos=

On 8/12/25 5:26 PM, Jon Forrest wrote:
>=20
>=20
> On 8/11/25 2:17 PM, brian m. carlson wrote:
>=20
>>> To see how many leading letters of a given full object name is
>>> sufficiently unambiguous, the algorithm starts from a initial
>>> length, guessed based on the estimated number of objects in the
>>> repository, and see if another object that shares the prefix, and
>>> keeps extending the abbreviation.=C2=A0 The loop stops at GIT_MAX_RAWS=
Z,
>>> which is counted as the number of bytes, since 5b20ace6 (sha1_name:
>>> unroll len loop in find_unique_abbrev_r(), 2017-10-08); before that
>>> change, it extended up to GIT_MAX_HEXSZ, which is the correct limit
>>> because the loop is adding one output letter per iteration.
>=20
> I'm new to all this but the way I did it is much simpler.
> What I did was to check all the files in the appropriate
> object store directory (e.g. .git/objects/XX, where XX are
> the first 2 letters of the object given on the command line.
> If any of the filenames in that directory start with the
> string given on the command line, minus the first 2 letters,
> then that's a match. If more than one filename matches then
> that's ambiguous.
>=20
> What's wrong with this approach?
You also need to check all pack files and alternate object databases
that you might have.

Ren=C3=A9

