Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8942727FC
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772270358; cv=none; b=hPyFQyV/owca1bAD7KxAoOP0OlnkxT3l/h2z1nNSTVD6QpPDIX4NSwUUWqx/3lltTOmCjDQjYNSI7PDmqRqJEntCmyHFL+fyBkWborWHIHTglndg6vPAZVtvP2lIOKqWRdYw7mwnZN80mv1V8qpkXrI0CJBDC6OKlcgP+cqFOT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772270358; c=relaxed/simple;
	bh=DfVRVSnlHaaEI4QrVyD34CiBkgnK2l0iGiZ223fRjvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLnhu1tSS+WZJKLefaMX+/Uqr+M4VsqYMK4YarTWy7dht2WuPHeswmW2WHOCW6hCDg0+9CdfHUr6IqV7YhHqYkpqAPWAI8d1yqn8mo6icHgzmbxzbI7LgnzmKxqc1zy73eYTm4HerigkMMboV7HyqGXTm7lTxn9XUvBESG25Ghc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=jdnN4hsU; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="jdnN4hsU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1772270352; x=1772875152; i=l.s.r@web.de;
	bh=HVc/4XjT2XQTe+MfZkZK9UNNBuSkfxisgFp1DorCYzI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jdnN4hsUb7nHZc+v0ToBw7opddDrrsXBHOf3mXTVvXNCXIZzLdGbaldRWJBC26NG
	 QxGc9zUPgccBRqJhsBd2Vuuhp8hrRnfE64IALo95sK6Da6jMn71tg+vYiybkpeAIH
	 vTMOj7FAAQsW1deb993D5vtlxo4NYAt2qk2TpPiVNfG+P4gsgcMHM/2FdppF4tBq6
	 J9PNuUor3A0amz8y7AmyUIV1WWrdbynvnZ67awO/b/xrZ8bMbeX9wW8BNxu/Zo63n
	 Xk28Uty2tk7GXAlVwa3tMbGdLLk2veK5RzsH0EhGVAd6wp6HoxFB0vKIatKo+mvoR
	 y8d7o34DfVKnIm3bTQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLzit-1wECrx09wH-00MDBZ; Sat, 28
 Feb 2026 10:19:12 +0100
Message-ID: <dc882c28-0846-41e3-a9e8-1a4bc44a1ebc@web.de>
Date: Sat, 28 Feb 2026 10:19:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] parseopt: check for duplicate long names and
 numerical options
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq5x7jujqb.fsf@gitster.g>
 <7693799a-91a2-480a-ae3e-29f8eed5b55a@web.de>
 <20260227225055.GC2956443@coredump.intra.peff.net>
 <20260227230822.GA2965111@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20260227230822.GA2965111@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5ZNeW9QnlWHgOUd5Iz9/u5qefd8Uyc98UlHGRIt4UuSZC5TjmVV
 Az3SZf+eIvHxEb3CV6lJ+UA1BHxj6OzTA8qXxBmH2qHXsMTlQMJ5TzOi5s1SCDDvsKaFXP4
 er2cnqIs6XJlYU7twyIxBlamv7pjb/0uqFzOJHSay+ktjw8iyLofFGx+tV/IFjv6RflDNvf
 uMsQRW4UeuPudrDFzNmkA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:25EawmWtA+Y=;6weqpn+c7ZY3nsmpjwqxWwAgC9f
 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

On 2/28/26 12:08 AM, Jeff King wrote:
> On Fri, Feb 27, 2026 at 05:50:56PM -0500, Jeff King wrote:
>=20
>> On Fri, Feb 27, 2026 at 08:27:02PM +0100, Ren=C3=A9 Scharfe wrote:
>>
>>> The check clearly has a cost, but I have a hard time measuring it.
>>> We already do lots of (kinda cheap) checks.  Turning them on only
>>> in DEVELOPER builds (and ideally demonstrating a speedup) left as
>>> an exercise for interested readers (with stronger benchmark-fu)..
>>
>> I agree it is probably not introducing a measurable slowdown. If we wer=
e
>> to make it conditional, I'd suggest a run-time toggle (so we could turn
>> it on for all test scripts, but not regular use).

Good idea.  We could piggy-back on -h.

> Just for fun, I was going to write a script that generated a test-tool
> parse-options list with 100k entries. But then I realized we already
> have something like that!
>=20
> If you do this:
>=20
>   (
>     echo usage
>     echo --
>     for i in $(seq 100000); do
>       echo "opt$i option $i"
>     done
>   ) >input
>=20
> then hyperfine reports (before and after your patches):
>=20
>   Benchmark 1: ./git.old rev-parse --parseopt -- --opt42 <input
>     Time (mean =C2=B1 =CF=83):      22.2 ms =C2=B1   0.4 ms    [User: 16=
.6 ms, System: 5.6 ms]
>     Range (min =E2=80=A6 max):    21.5 ms =E2=80=A6  23.9 ms    127 runs
>  =20
>   Benchmark 2: ./git.new rev-parse --parseopt -- --opt42 <input
>     Time (mean =C2=B1 =CF=83):      32.5 ms =C2=B1   0.5 ms    [User: 23=
.8 ms, System: 8.6 ms]
>     Range (min =E2=80=A6 max):    31.7 ms =E2=80=A6  34.8 ms    89 runs
>  =20
>   Summary
>     ./git.old rev-parse --parseopt -- --opt42 <input ran
>       1.46 =C2=B1 0.03 times faster than ./git.new rev-parse --parseopt =
=2D- --opt42 <input
>=20
> So it is measurable (even with the extra per-option costs to generate
> the option structs in the first place). Looks like on the order of 10ms
> for 100k options, or about 100ns per option. If you imagine that most
> option lists are smaller than 100, we're talking about probably the
> equivalent of 50-100 syscalls. If we are really looking to
> micro-optimize startup time, I suspect there's pretty low-hanging fruit
> to be found of that magnitude.

Interesting.  I don't like this percentage.  We won't have that many
options, ever, but we'd pay that small cost on every git invocation,
which add up.  The beneficiaries are just a handful of developers who
duplicate options, which seems like a bad deal.

>>> +		if (opts->long_name) {
>>> +			if (strset_contains(&long_names, opts->long_name))
>>> +				optbug(opts, "long name already used");
>>> +			strset_add(&long_names, opts->long_name);
>>> +		}
>>
>> ...if you want to micro-optimize, note that the return value of
>> strset_add() tells you whether the item was already in the set. That ca=
n
>> save one hash of the string.

Makes sense, good call.

>> Probably the allocation for each element is the dominating cost, though=
,
>> and it doesn't help with that.

My knee-jerk reaction is to use a fixed-size array and sort.  Gets rid
of allocations, needs some more CPU cycles and memory accesses.  That
would then either bug out on experiments like yours or detect
duplicates only in the first N long name options.  Not sure if it's
worth the limitations.

Ren=C3=A9

