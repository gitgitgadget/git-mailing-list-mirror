Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560BB280324
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 19:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768246630; cv=none; b=RDtzaJaS/y43H8hw9aauPhD0g+6a4quhV7lrA/B9TrRXwl0T848ITLWUys0kFQPZyMj+wbCFdrhOUNstfBt+/qbxYN5aGRb/k+pEdxcMrLole7kUKU5GBnzknh0iZ7I2eQgJaEwALs5T2fhYVcx961x4e9+AHx/lEav3C5/tz3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768246630; c=relaxed/simple;
	bh=IOL2f2ETvAjxgDJDgSpVJ8tcFeaCbjd/D/caxxuX73A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ny4+J8kHJa/jIzOCJ8jYX9Uu9qelPETR18qdYO0gr0OYiY2cQ+MZ8V6PFwQsMMEblyLy9NTrgLfOoPbkZfvL6k5WxlhZi8XkJVt1WcXGQ6daLba9TIFvIE9aqgY3wTQ4kXFw41L19/dGsTC4X/Hae5WOeKbJZZ2vFhL2vCrYK0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=C7oX4YPR; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="C7oX4YPR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768246623; x=1768851423; i=l.s.r@web.de;
	bh=aANr+TzQZJ3iQJkUoFzGtrP9my8Qnzl6lMcFxsHdxdY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=C7oX4YPRVVqnFZYK/xlQDFteu1jESql+7OwNUrxZLhbl6Mjsumzb1n7VHLye/mA+
	 cvp/7L4plDkGBNuHXEUleXm+DTazKvQvCfX0Qd56vy4Z1o4Q1/gSvTPOtcP4BC9ED
	 /ET2tV6+mAsC8K3CC8I7BHtAE8rZV2jk3WoVagRH9q8a9bnE1I9YxP+Zn5j9O/u6A
	 MQFAJGU/60IvVAZee/jFgX/qFCmxJnsIMV9IOPxx169IiZb3dHVrQaLTODf0HvwEp
	 DZWRhLbuuTw7fX1QwlYkinoa6KlqTAjBWoHDwi4IrvxbmDKghaPcWoeJqHHesZ32d
	 Iuc4rRq6irT73Plg3g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.19.215]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mm9VU-1w5x792pvM-00jOF4; Mon, 12
 Jan 2026 20:37:03 +0100
Message-ID: <89e23323-7e0f-42b6-9a89-dd8a682644dd@web.de>
Date: Mon, 12 Jan 2026 20:37:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] tree: stop using the_repository
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <20260109213021.2546-1-l.s.r@web.de>
 <20260109213021.2546-10-l.s.r@web.de> <aWS9Ll8CQ3eILx3z@pks.im>
 <xmqqh5sqoqr0.fsf@gitster.g> <aWUMn6G0C1cHA4qY@pks.im>
 <xmqqms2in9hb.fsf@gitster.g> <aWUTNU7WGTwHt6Ks@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <aWUTNU7WGTwHt6Ks@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qh/cOrS+EYfLgkLCX0ovCGRFpfTZbMkE+N0xFEB3kkYpvewDROR
 sFiUPChLHwo5MAI6GuODHzOQwljrCkwuVtM8vq3lXZIr7GIKN0klJKi3E07VUI1DPhG2fNU
 AfQBM4pkZYL2FvNWHEV1Es3Dl/wEDZKaDUAInK+2q7rDVwLU6GA9v+iVMfSaCLP/+J6120K
 PnAlWP11MHlgvCKMbxocQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aa0U5x3UDPk=;hL3gJ7pBtvHyUY62rrKuL38cvDM
 Rlf58SuJygP42rBomJREJmt8IwUa1qOqsTvXGgRLyxwX0Mz76A3hQnLhd1S4uWNa/YkGYJzYn
 PZIi8uKAXJuKgGR95/nEcCdUtfWKHBiz870+vdYw0rgIJP026aNz535GjM1RqyFLx4p7DGvP/
 Yv2Q5TXYiUblLl9A+PVcJtmvKkncc1kqq0R+VVxY0xLLukzyrAbud/jtzxJMRfRYucV9pssO7
 aZmLSDHl4poPcyK5HS3f2q/U+N/+lLF7Z6VDkyBN/u17/UrwXVO9ftsWBscU/z1pGKqtJKoJg
 IPpqqwvEoS8xYgMM0QMJLUcTXNN+LUScng+59sQlQIr6VzEDH5wM8Gpz1L/o+emyPZvb2FaiA
 yFxcAfsXg7EquKxp012QwGswfnYzDKLv85O5WIPVZV/RD1dsNc+iZItn0cpSPlltMULF49wlF
 flaHLu5wrs2o5/GFVB+Tw0ouF68ll6uDiJOjMrmxX/17D/FwF+J3sGJCPCUtHGtdUH1btqcmW
 a8dEacT/i1ZqR4bhw3EzENgHTFyrP6Erz6nhnUOCNoiixWGnv0Sq179Q5ZFa1hrRdJTzP+abq
 Gma/gj42wCAhIrzg24u0VrYZTv6v7o4KOWIZsZYY5yWqj7uk9mB8GyEvFe/sm2ubqoukF8cqe
 Rdh7zvN69QJvusWoLFmJbEAIybm4F8xhMwwQfeYRInVvTVYVgP9ZluQTS4f+bIv0LH5nVDJde
 aGXXG4iSInH0RhRhnRI/xuqeBiJily5JSmoCg+DIj2CFwI+UjCZR2+kBgVd5+Qds4db5bx2Wf
 m9Lbh+3g/Az38slSlhFz4VX4zqwyGD2w1ga35CyvM2d0Vebi53waSTMko93PesJtNCnRhP+0p
 BZvGyEz/Suvvm33qzQRtu0JIOKXRCdRPo86/h9rCBtob2UjhMxqCK5+90Klq95PaX6mplMdvo
 k8BvD9AcpbMaQUXXarID6EFUKbUInc7ELNuTW76vBxThAfyCu53oqN+fH0/j8vABZqzX8HIIx
 61tj4XrcI8seIRt7wtNIQB5ffyL5J0d8vQyWvd4anZCSlfQwBeRYY5KpSYOs46PNyoB2WdzWO
 hpXSr5JQ+Ni0fkxTVbq2z/LCjM3JpWWE8dsGOOqAOXcrk1lH6lXWHDHQG5MLcA5XzGcGSm0lz
 Fj2vVXzffFkyVxBnkMrnu5YPt6R35Ld/sXEAp5WTJ1xYomhOk07JBHv45E8vBUMRaz32RcF32
 vxSimFKS8+Lfy5GbzRsigcD/Hcr/NcQHsAFYgJRAsW4vEKbKfxj931201cvS4VHZjsSMeV61R
 +FC0itnjzEt4dCKFjHPSLviWnk8D5chRMSQgCS0qJQ5gsznSw3X/u4rym4+18VZ7ZIh8FQWv/
 7aDpiJzVElZF6CakNvdQbC2X+PZV0KQEnthaRqQ9ZNua1eKVBcLIp3y0T8iqOjbLEYpxdq5Mi
 otlBixcd2tUvvuT+mLPDz1S527QJwsMA4AYwyWLgb1m9uRtnRcCeO1go9Duz7kJ4fT+C4XVJz
 6AG4Y0piQNvRnn1TGbgKv+gskCs59QgZ+UHWokBZ76V9EG7v34Yu5EUdGstdcD3f4vBCZXISW
 B9gogaS9y40b5m/6CClWY12ldFGNvECXKT3A5V6ffTqN4tb3FTKq2LU/aiJvT8B/UZCtoD2tX
 6f/aoE8kIFz2HlMZLZhJG2rBOjwhHblbwl86WEcVvBjNitHgPyAYSG0Un7TN1voP//KuJ/z7v
 m3GgreJ4kHDViYXQZShr1fJAie5Zd/K+2nOL02v2ASE6BpcECMQgwmNDZar/bWEwxLrJKXmg7
 bBtg08jNVL2XK75LBAk2VqLDvCRuolJaHLLmozYey3ZggiVOEKWY83BTC3T7QbZ+xvUg/dE+3
 ADxgaXCLhH8r4dN1nX+M9zSRyYVARfb/3vMaMjvp09MfDlFZMIAtlG70DbHdFGVMFfNdgy6N6
 H4u9EchFPp8fn9k1AIIlggz1TmiOig0x9eUEuZ/qKDaWsi4WW5eQaKimSFfzgAlbxdezYTe3U
 6JTNhpXXrPFGUoxxPOHOubDPGikMZlqo85fbFyI5K+S+IR4xSTaLMySDTrEJ0M8Fu1uXPpgbN
 No315BEo+4FjoS/Td3Dy5O1+uYHV1mFT9ei02as6/kfm9BSEEuQfwU3b1L2c8Wf/5VjtV55WM
 gj5GVeOEiGa6UU7KipGJqEbt2bi8tts8dDVNsRuS7CbmqtgYy159CiOWluMmQJx5Y1GPkRoQj
 eBw6SDcjWBDgQ7VbGdSPykqdseOP/HGql5fWO4Z9JHjAH1+C6+qPKu3nf52KsV+oNHyL/nnwr
 qKU5UQP9z2UFbjbBtdQiuCuaU/h1+VA+IwsX2O+hGY+r78cCNtluFAktqGctwrCiwdwaPchTu
 RGxQkPxtT/OPmCal6kqAI/0BYhc1FLn3EMrZFxMoexyHJmyPkzUtoCKs0HhuNdD8ARn+ZQz+y
 lsyfj1HtW2fXUdBwGitum9agWiN+XGQCdRiZ4JPNdDks6rErkbcwTQUEFrvvee+0O8QRQ3JO6
 vVuLQ1gM/007KYB+4C3MiTU9YM9gt/u/rJiFUZ+4hNpPYF5TOMq5lVvfkTG/Jh+oPAttyiPlv
 1D0iAl3lXV8dhnTPkz/Mc3v3NnDpVrPaNhbvl2yJ9Q7Te41Q0cjVEbXx4JSYrKuIVI5MYTCFu
 ElCCQ2dOLhYBS8lR44ympVl8WkFiJiiGGpFfKh87Bqknb0EHK9eEFgyE/FYCoR/zH4nAVavYU
 u+D2tF0YzsnJ894FoSSVeHZEKa0zes7kNhDikJFCsnfkzWbSN6+y8N3amXBMEPpyaXaQ6jSS2
 DlGpbTYQM6IU4RN0fs5pxm8EwYO42q0gyJ0hMboL9dqO7abZJVqAodiaT4aaAa8KdBt+5i1Ru
 j8c4ziV6R+g1OPpF0i+h/eMNKFJd1VbqV4NET1j0wBpIkC0gpyUSBYHdAMcGYO0jb+2wuXPig
 sFBPeq7eU9EgDoptrF6ZKo94qb/lhwxF9qFdcrKW5jmOmxXiJdWJ7EMrgXxfv5sMH5PItBxsQ
 Ir0SSUCbimD1c9XPw0rVNBa+x7uRRpUgANT7HP0nb5fPTotdO1y5++7drARaaTOJz/j29ONxV
 j17Xzg5d4xCcCH9eEscQOKSkESoKgvj67ZqNvqKKEGuKHAU+bVHxb0S8E3R7Ho8yNgBs4NfdA
 /FhO3iFBUF44/S2MkLufGM1uX92wb5Ayep5F/8CUWUYsgh307JsrOYBYNLpfr96AVuNEHHcqX
 wgui6+4fMk2kfuefdWChtmik1Hc0NKshvUYDpvhcdagj6GwJUi2UOVIg+qoNNm94ZKXhI0bvg
 LKalSWuHB2r5T6+ks/UjyL55XCXzTDmAQF8q5PuxwzdfHQh16xC4UE7aCmlQYjYNs4KALdzN+
 EaTo6hKDPMxh/N78gJYunn1Gz9fQvEIvDdwGJ9VSySeoI98Uo8QBWIJqNaFxSfARa6I9pCtBP
 O/Y3ZvvVJ4eS/fB/8bqd1b7cGtRgVXRb7nuanVQ8La3ZjkUUNRqk8eRtKWjvd/3vC3Zk6RYl2
 wC7Wd9X5OoQos+jOAYi9FgZGAVhLs7sTX/KZRJQxaWOev+9v2yi8UgfhqYq34EjE0bmefI4zS
 QNsw2KYZ1y/HHvXKzun4MnTpcDQnPAs/lYKedjqHqQKO7RwK05RsNtkGphVJuIu4H/wYM+M7V
 AJRbBW30pdaVCLt2oNh0T0Y5vSeUINxeV1iohJK/oHNkbHl2M8VoOcEdB+YtmByXm9R+zI913
 5mg54GqZ6I74//r1BGW9p9s2chd4tm7qgT9MnHzCxmMllCKxI6WlfM7XUJZHMM5OXbuWeTB0s
 vP9gkT01rkM07Ua9DvhI8L6NEQPyFqPCyw5vk/1yToyZjB9onYJlDkOQTWVxr9GxGmTB128Qp
 RQnNwH/hT6qk1fxQA1830Uc2T/2/mbntMQwe3CK1LLlsKZHX5N1HHnLSv2Pvr6IG0Qzv8zwjS
 tSJmsYv6M7OiX76BTV32Pax6VLoFzKfopPVZhfg5rfjGLJAL2lgIBvD9nR+wwp+s0iGCdwB/P
 8gnHURSIzdUuN/EOMssKGBz9PBzRAzbrJbrjN+uPW4ugwWZUwFAfKLwHAyOMDfyhvD9W3Zmdy
 3WyrWU38KIV/fRUpx1FP7NwYR8s0e3Ak1+D+x5+2oeBxPDWLnBIkufT9eTVz/NLQwImEKAHU8
 /NJ7x+QJ67JAQXRsS10znakiw0QlWWl2cBfPX6Xe9HinY6h8PukYLQQL8Q6k955WSYaMUFnCf
 yZyJfTYhYY52GfdtACRDEGXeQwmEKD0mSoYLfb5e7nzcYNE3st3QHYHsFbv1xOdxWku6a7hFX
 Ko+Ac0HVJ5NQKCOUGcn6mtj1ncbPjqkrOBG+HX0NIqs3F5pKuo/Zo5a1OQ9u65YvkmMRYt6zY
 aHmNBA1h/mEiieyBKCww9arCPa/coo8sffys4JIrebP2AXjAGwMw5K8k3Y60N9sJ97RnAc+wi
 +2X9974eOhFYZANMb13uMo2/jJoT+aZgnQu8eM5JKh5gPwPEW1cgsZ8Mnmvqr68yletFMU2Mr
 rAysbUCryfJOUAgyBGemrZ6+gw2h4njpuPmsOTB/lGldjs0ASOSN2bb10+xr4nIp+XbErU0n6
 B9U4pJDGie4aZ3JDVs8h1+lE/ymWuc7wkmSg0avnUpB5yXnZGN3RAWm7JEuzNKbgdoI7YUPmU
 d3WaGQmHa8PRDRWUC7I8PZAKAXAIiD2gkvk2gomxuE2/JtJd6d7jOAv+RItBqGq8j4O1bPz2f
 3UuERo23FN/p3HGPE6cRhGCq0EbIEdLW40Vtkk7+BfZFzMk/Hs/cCUcDw23mF3bip7kKvoU1R
 LqQ4C1MGD2MS41kaL2i+l5l2DFmr6QHz1mjJXuT5zXUGmt1qOqbByqhLYVu4zfOnkLBK4tM+r
 ayCnl3HCSkzIhSNEE/xx1MREx6E04c/aURivVdTK5USiQT996kIysrKn6pV6pH/Bwdif829ir
 XhXoAD9JwSILUAki8fUJLSKRYnWwh9ZUAZMJM+OqkhqfEB2KQ7VpesEG9gMObOLpnFUvsyquV
 nVRC3Wasr36B3OaJ0DX0shsClJrGSWYgY3yXZLfhS2PUzt65lGx+A4xqlNHcgm/HGeP1jTedt
 h8JIXSb1oE0qKfJB0=

On 1/12/26 4:28 PM, Patrick Steinhardt wrote:
> On Mon, Jan 12, 2026 at 07:20:32AM -0800, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>>>>> In any case, I'd propose to move the compatibility macros into a sec=
tion
>>>>> that says something like:
>>>>>
>>>>>     /* Deprecated wrappers that will be removed once Git 2.53 is rel=
eased. */
>>>>
>>>> Please do not take release schedule hostage to one particular fix-up
>>>> series of patches.  Thanks.
>>>
>>> The intent isn't really to take anything hostage. It's rather intended
>>> as a hint that once a specific event has happened, we should take
>>> another look at removing these wrappers.
>>
>> I am OK with a comment that records the intent, e.g., "let's work
>> towards reducing the use of these wrappers", with the plan for the
>> next step, e.g., "and once we have done so, remove these."
>>
>> But the comment you wrote is forcing people to make sure we remove
>> the code that uses these wrappers and unless we finish it we cannot
>> release 2.53, no?
>=20
> That's definitely not my intent. It's really only intended as a hint
> when those should be removed at the earliest. Maybe something like the
> following instead?
>=20
>     /*
>      * These wrappers can be removed once Git 2.53 is released. If you
>      * see this comment and that release has been published then chances
>      * are high that we forgot to remove them.
>      */

Forgetting to remove the three macro definitions is very cheap.
Forgetting to remove their Coccinelle rules is a bit more expensive.
Can add a reminder.

Ren=C3=A9

