Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E3B48A2A8
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784129998; cv=none; b=XBXSRyk7sk6MiJCAE2LyX3lSw9ugIjajE381iTJ3sxvH3RWtInj6K5wjWOugmW6PEr9hloo2JIU4tWNxw61zuqVOzTBTFbSs4BEYafogfJolcypdTQ2hStDJXsm9AzAnEi2YM9Ef9ChqZXaPLp+gaZKN5kCe7t1SsgPWi9fuNLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784129998; c=relaxed/simple;
	bh=g011v1QyepWc4jxRVKOnYDijPCyy7KQ7iUYn53MJyPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YkoCz5SGpfVd1x9SWpJXkX8mPQnRUqW2J7IbM28z9CJgkuSLUQDr7jaRwMGIDGStYBzHT8W2a1WQ+nE8tDPunAoTt9UpjrCduCcHoyTJwlQXV1ppwQPFBYh74n9Xd7CmA98G2DXzh6u0xzHFZIpFPmPXUJUefkmP8+iHjFUQfIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=BAYimpgs; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="BAYimpgs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784129992; x=1784734792; i=l.s.r@web.de;
	bh=rje+LmYTEZ+bSYh4AHpX6l785tBGCi4QfQus/IpXyr8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BAYimpgsyWRchhg1SZ8LN2RmXjDUMyMljj11q1v1lntIQHdAw1rXfZ0FLKAw89Az
	 r0y4ojSxYpKy/UhLSFlZ15UVntrjwZE/7XyENqr2dGMAeSyy+47RqNwrVop0rnpGQ
	 LemEqd6zH7aqnWT08srU2pwOqiQh9Xg8BptxOsDv2Iu7U4c4IIUwBMDgfshpbndXO
	 kym3aMZDYegVnodg9kW0u3NCfeAEr4ex8GZXaHSjj03/QU6AQFeR3giN7BKN0QU3n
	 1RfUe4BhI80UIivSkCwO7uC0nEgd7tEQpMstWijro32oGGmJmSA/2tg7RdQGJpfYT
	 5EVer6DDze24It0kSQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N30dV-1xB8mj13SX-0106l3; Wed, 15
 Jul 2026 17:39:52 +0200
Message-ID: <3b29757e-abcd-4235-a829-ea67c19e71d0@web.de>
Date: Wed, 15 Jul 2026 17:39:51 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remote-curl: simplify passing of push specs
To: Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>
References: <935883f3-3be4-4c51-9711-5208b9ef9ca1@web.de>
 <alcrhGUCVMCnm2-i@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <alcrhGUCVMCnm2-i@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SmwB0cj72xgWTEmohq0+y85kMT2KswwuBl/8AKjoSyM1RACYMGM
 JPqbXSpkMfLEevYiyVbhkMS9Kr+iqJ55ML4R49gz5mIK3lrnp2BIm8yZV6xyl2e9Sy8gyrG
 OO441/+aFhc2kVybDtBzfYHwC/DjwBSxeX27Y+GLYGvVq6SoS0vcYHBBeZQB11OnYnGXXpJ
 Ao8L4nLI5zapGOOqYkQAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9xEjrgfAub8=;JxPCPfwuslOEkFWSa1vMPnjROCr
 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

On 7/15/26 8:41 AM, Patrick Steinhardt wrote:
> On Wed, Jul 15, 2026 at 06:41:17AM +0200, Ren=C3=A9 Scharfe wrote:
>> diff --git a/remote-curl.c b/remote-curl.c
>> index 9e614c5567..2c35dd5240 100644
>> --- a/remote-curl.c
>> +++ b/remote-curl.c
>> @@ -1340,10 +1340,9 @@ static void parse_get(const char *arg)
>>  	fflush(stdout);
>>  }
>> =20
>> -static int push_dav(int nr_spec, const char **specs)
>> +static int push_dav(const char **specs)
>>  {
>>  	struct child_process child =3D CHILD_PROCESS_INIT;
>> -	size_t i;
>> =20
>>  	child.git_cmd =3D 1;
>>  	strvec_push(&child.args, "http-push");
>=20
> I wonder whether the interface would be even better if we simply passed
> around a `const struct strvec *` directly. That makes it explicit what
> kind of guarantees we have, and all transitive callers already have one
> available anyway.

You mean that passing a managed array instead of a plain NULL-terminated
one would make more places visibly safer at almost no cost?

>> @@ -1353,15 +1352,14 @@ static int push_dav(int nr_spec, const char **s=
pecs)
>>  	if (options.verbosity > 1)
>>  		strvec_push(&child.args, "--verbose");
>>  	strvec_push(&child.args, url.buf);
>> -	for (i =3D 0; i < nr_spec; i++)
>> -		strvec_push(&child.args, specs[i]);
>> +	strvec_pushv(&child.args, specs);
>=20
> I thought that we had something like `strvec_pushvec()` that knew to
> also optimize for this case so that we don't have to reallocate the
> vector multiple times. And if we had that function it would even be more
> efficient to pass it down the stack. But we seemingly don't have it, so
> that argument is kind of moot.
We could add one.  Not sure it would make a measurable difference; if
the number of specs is huge there are probably other costs that dwarf
pushing them to a strvec.

I have to admit that the simplicity of strvec_pushv() nudged me towards
using a NULL-terminated array here, though.  So just having a
strvec_pushvec() available could guide towards using the length-limited
strvec instead of a simpler NULL-terminated array (which explodes if
left unterminated).

Ren=C3=A9

