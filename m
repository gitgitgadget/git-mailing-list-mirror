Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E82630B529
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 19:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791230097; cv=none; b=CiuobppDIg48jNX3DlT9B2YBgg1skv0s1e/26z2k+BV2arTS/8QW8IWSyjoktPbjBpZMUdfKvq5bS8ZiR1LsR/6u/nEB3/LKR0W9X5C/HnJpWac/scp9e/IpCBv/ucSqwi/ALnDRqy5DrCRJL+DmpCoE0m4+dGb5B+WtWtmxONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791230097; c=relaxed/simple;
	bh=O5xGRh1+Kec3yMy9g1VDYK6aY9h+EYPsy1xlT13y4AI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pSfowHzEHxtE1gvOouWwXFxbnWV4MRNBJEi31zcvXeY7IB7Ke69349+5EIuzZ8HTPHCRUW5PoX4hucVRqsf0XMST237GQMH30J/1u62yKaVfebNwoGquzP2RnHfzw3nYWlOgRkpjcwcKrN9nbVu/wVLx5Ao5viYJ4EHDGUlg2G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=HlMrUHDz; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="HlMrUHDz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1791230087; x=1791834887; i=l.s.r@web.de;
	bh=F8BWpMnz62lJXECcFUaqraStxJPuYhzLoxf0QaKqe6c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HlMrUHDzxrPzL7mJX3X+PjSGvTRL8qhW9lx4qXRILGnCQtMHLc/mjIfo7oWmuBG0
	 apB3O44iU8FbpgvyOxE2vB0TpuyUuU7Bb4YfePbKdlZMAMQp2leRxKL1eAeNBq3Fi
	 /QoP2t/nAitAE6afJI7pT7uE1GA0BS+gONAyWRcMf3GEicZC+/jfyn95x/kPkZpq8
	 y2td1ae7DawJQtRSh89qocrySpOSrTvLceOdR9h4YCI/R6tvrCemGxfFc8uJEM2Rm
	 jlnas9gmyDOLb56v4XvRJgRBNtvjFsFepLGkJ6JGPCYs+PMj2jMhsnihb3rm4ZVfz
	 f7men8I03IT82VAp6A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXXRL-1xBksk3piZ-00JVpZ; Mon, 05
 Oct 2026 21:49:33 +0200
Message-ID: <f8dc40a4-920d-4dc5-9f71-7686bfc6255b@web.de>
Date: Mon, 5 Oct 2026 21:49:33 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ZIP timestamp conversion and strict fast-import date
 validation
To: "Matthew E. Luallen" <m@sph3r3.com>, git@vger.kernel.org
References: <CA+h9NxRT-9QzLGihdL_Bp-yyt1AdXJ79YYgpK-OaegUz8e+HcA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CA+h9NxRT-9QzLGihdL_Bp-yyt1AdXJ79YYgpK-OaegUz8e+HcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CeezAkh1Q2vJloubVHNSenVwLe9LVqVT3//A4zbrlaVz47WJtq5
 fk2joToDxC4Q0QdiHIVPONEnN7dB638o7umMhSs/w7rgzB9GW6svN+f5/mIbd/DNpej0mfd
 sU0Fak3YQkNynEDV6OGEU84Db+g/17hilEYpEAREFoKYGfj2XbTWaEbd1AFf5KdoaU9GeG+
 pO3w9gSOIQ36/qEBcThAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iPb2hy6CsBQ=;BgLup3HvM247fDGFkmvbTEB/69J
 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
 I=

On 10/5/26 3:48 PM, Matthew E. Luallen wrote:
> Hello Git community,
>=20
> I'm reporting three date-handling bugs reproduced on Apple Git 2.50.1
> and upstream Git 2.56.0:
>=20
> 1. Exporting a 1972-dated commit with git archive --format=3Dzip produce=
s
>    a legacy DOS date interpreted as 2100, while the extended Unix
>    timestamp retains 1972.

DOS timestamps can express years starting from 1980.  Unix timestamps
start at 1970.  We can't provide a DOS timestamp for 1972, but can we do
better?  zip(1) clamps DOS timestamps to zero =3D the DOS epoch =3D
1980-01-01 00:00:00.

Is anything using the DOS timestamp even though a Unix timestamp is
present?

> 2. Exporting a commit at epoch 4294967296 (2106-02-07 06:28:16 UTC)
>    wraps ZIP's four-byte extended timestamp to zero (1970). Exporting
>    the same commit as TAR preserves the original value.

tar's timestamp can range from 1970 to 2242 with standard headers and
beyond indefinitely with extended headers.

We cannot put a higher value than 4294967295 into the four-byte field
provided by the Unix time extension for ZIP, but we could clamp to that
value.  zip(1) wraps around as well, though..

(I'm using "Zip 3.0 (July 5th 2008), by Info-ZIP, with modifications by
Apple Inc.")

> 3. git fast-import --date-format=3Draw accepts -32184000 +0000, but
>    git fsck --strict then reports badDate and ISO rendering returns
>    literal placeholders. This occurs in strict raw mode, not just
>    the deliberately permissive import mode.

Well, raw mode passes on the timestamp value with only little checks.
strtoul(3) used in builtin/fast-import.c::validate_raw_date() happily
accepts negative numbers.  The latter function contains two NEEDSWORK
comments about perhaps adding more checks, though.

Ren=C3=A9

