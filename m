Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA75648CD55
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816001; cv=none; b=M6dTFX3mmX7hPhY3GAlYJeCKZr3i7xys4g3lIV4dxlwboHw+l5hRgCkoIfpYh0P0aayFYbuGH6mGs0g5z2yrNZR4+WLB1/kRB+V8t+m3L35Z7PRzMQZQmZnsOf0nMyyTWd6IR10ZucSkln8Jvkg7ORk/0jpU3D/yIEo4tYi0U9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816001; c=relaxed/simple;
	bh=iw4kBkxoy4MvNXetP0SpuV+cWoi1LeOmFE5ltXQvwCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZRSvrM9q84/NmZhHIj5C4RnciiAjEFgM/fowKYPFzzfoDXYOyiXfy5Ruy/eVcZgX7k5z5G7icKv+0BPOB8V8x7ytVbIXXJsupt34EmLt7MH9VJboZscToWUa7sOp9QMKp6JtuF5GymkOl4u3uWdjmSwk+iig3WOZiVFWfie9kfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=tuVV4ncq; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="tuVV4ncq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1791815997; x=1792420797; i=l.s.r@web.de;
	bh=NhJSn3AAJs9mMRmmk6y8jQ7mtNm3glrzX1ckNW3XU/E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tuVV4ncq5rJkwUW8LPYB/O12JJ4PsucXruU0f59BTkwz5UZwdjayIUqRh5LW66de
	 JRsA01uRI1UBoQhIQgILosJXhD2GiVzxuyu2IxfDUfKAuGug9Xh+r6FpbBDVv7+Tf
	 oRDWFs6BmU0j6ZfUAQaGTzwQ//2LSmpmWeXt4m+OCBiV61C1Su9ZKikhg7aqmhIUB
	 835aWQmo6DmOJSvwqHyiEH3dJvgtk5JT5Nrc8MLO6ALjrGQ4LT+Wv0S5O4u+JWK1n
	 nwf5dWRamHgWBV3PmPFrD65Omd3aSRKaD6ogdtqS+/ibXKaAeX03/53FihJdEnyNf
	 xfDEaoIGNcNZAk0fvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDvDi-1xNwgj1fZE-00AUf0; Mon, 12
 Oct 2026 16:39:57 +0200
Message-ID: <3a7868a2-a65d-4540-8ab1-70cfbae9754f@web.de>
Date: Mon, 12 Oct 2026 16:39:56 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] archive-zip: omit UT extra field if mtime is out of range
To: Junio C Hamano <gitster@pobox.com>
Cc: "Matthew E. Luallen" <m@sph3r3.com>, git@vger.kernel.org
References: <CA+h9NxRT-9QzLGihdL_Bp-yyt1AdXJ79YYgpK-OaegUz8e+HcA@mail.gmail.com>
 <595dafac-33c7-4c45-9cac-c868cf1f8bb0@web.de> <87jynn8ycv.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <87jynn8ycv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t/hKcpVzJf8hdK2kj9k5ooleQFJi7KuvhVGBkjhSLwrwPiPu6bH
 KYDH+ogKCbX4kWn1jUO41U3RXdqdSWLPU8cPgxH4TidnN9nkiJzIgic0I4ZfsSH75FTYOnF
 Mqg7DyYZrTmQNFbEmiqkL17iFiQzpSSZuPv27hv1mI/jGxTD12cWdpLBPOKtBGSfOMFX3o/
 BMBA4F6es8my2n/743d9Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:epFB2M8vCH0=;adTGLLjSjO2HL6LHlWQ6dQfCgqZ
 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
 =

On 10/12/26 4:08 AM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-c=
ases.sh
>> index 768b0ff85d..20bab21048 100755
>> --- a/t/t5004-archive-corner-cases.sh
>> +++ b/t/t5004-archive-corner-cases.sh
>> @@ -227,4 +227,32 @@ test_expect_success 'tar archive with long paths' =
'
>>  	git archive -o long_paths.tar $tree
>>  '
>> =20
>> +test_lazy_prereq ZIPINFO_UT_EXTRA '
>> +	"$ZIPINFO" -v "$TEST_DIRECTORY"/t5004/big-pack.zip |
>> +	grep "UT extra field modtime"
>> +'
>> +
>> +test_expect_success TIME_IS_64BIT 'zip archive with 32-bit mtime' '
>> +	blob=3D$(echo foo | git hash-object -w --stdin) &&
>> +	tree=3D$(printf "100644 blob $blob\tfile" | git mktree) &&
>> +	git archive --mtime=3D"@2147483647 +0000" -o with_ut_extra.zip $tree
>> +'
>> +
>> +test_expect_success TIME_IS_64BIT 'zip archive with mtime exceeding 32=
-bit' '
>> +	blob=3D$(echo foo | git hash-object -w --stdin) &&
>> +	tree=3D$(printf "100644 blob $blob\tfile" | git mktree) &&
>> +	git archive --mtime=3D"@2147483648 +0000" -o without_ut_extra.zip $tr=
ee
>> +'
>=20
> Both Ubuntu/20.02 i386 (which is going away so you do not have to
> deeply care) and Debian/latest i386 (which we plan to use to replace
> the Ubuntu/20.02 i386, so it would be superb to get it work) jobs
> seem to fail this one.
>=20
> https://github.com/git/git/actions/runs/38189684665/job/114619579067#ste=
p:10:321
> https://github.com/git/git/actions/runs/38189685137/job/114619583658#ste=
p:10:337
git archive --mtime=3D"@2147483648 +0000" fails in these runs with "fatal:
timestamp too large for this system: 18446744071562067968, which looks
like a preexisting bug.  I suspect the time_t conversion in dos_time().
Will take a deeper look later this week.

Ren=C3=A9

