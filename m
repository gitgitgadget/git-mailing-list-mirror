Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75BF2E737E
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047499; cv=none; b=IcMgeg/EDYNxp4g+a7tyTESagsU4R8QZO77vz5rQzVa8YUzTu33aRvd7CS2k6JnCEduQ7Kc2zGxS51PPAsckB90PV/4UYCGvMBiVrKhy/KE9a4/mfmkXAS65QZhsF1qmeCJZq5UKiO3RAQvdT+6hxmWabs90OiyKabszjG6k+iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047499; c=relaxed/simple;
	bh=2UcFtoTZc/8Y9Hm0KsIZz1UHfY3faSYXu3awxO8me3g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CrdTylKmWtRqhg4Rco/Vi3gb0bDuv/5a6b5EZPkFPZLMWswtldLjwmQU0lEszT9571HbeN2hilt3k+Z6ogvN9DqhZdbDYXnIQ/6tY22Px6QAB0mbq5vFgDl2Eoit0YOqLFO+oFxllri0tOPxw5Yr02Lsj3tj3b7T35H5h4jp93I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Vg6s1dMy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e2FeQeGk; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Vg6s1dMy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e2FeQeGk"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 8E7B2EC0278;
	Thu,  6 Aug 2026 16:18:15 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 06 Aug 2026 16:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786047494;
	 x=1786133894; bh=OGwKj2WNBeYUyQAXx6Cf1Uolzj21mWjdEuOSuQSRB3c=; b=
	Vg6s1dMyb4w8fx0AoS/tGedEGxPxjhwYQv9tKEIStoblGrEesINl3m+TvsUMIvIP
	nGU26n1kmKItXBMpL1vCTt32XY4b9nv3LQR1fnZX0baI/IefYs8Hb1UIFmwQIJsA
	X11YeHx6+2QKEUrEKJv5rH4cWOLb3oti5+MX/GveZbl3nvMyVdbne9sL32mTsQmN
	DmL94Rhf9lXUivWoiParov+7PReFo9DiM6ZGBHIqsSHdd57n/U2dqGYbw2F2qj7p
	OcnnI+Jc4VH3/U2jVdZX69n+l6ATwwlaaxn841Tz7K2KeKBSXaetHwRf3+dGpy5R
	fj/0kg0oGrE1HkxUHq5ZZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786047494; x=
	1786133894; bh=OGwKj2WNBeYUyQAXx6Cf1Uolzj21mWjdEuOSuQSRB3c=; b=e
	2FeQeGk+v3Hp/Ob9hUc3jXEQZw4pwG5aCwkzzj7ytKrxX9IkESLc/L3UlM/ykBhD
	OA8ACNqcljuvgZc6nZGHGEcQcs3GB0sFver7pLPLCt+XYVgsRb+AA5LgZhXsJ7Z6
	O/le4J9aJCbHnUKXM5dqnLogTHEmI8asyJNNLJZb0MmpoKaBRzKavoOWK/lWwsCx
	k8Q2EtwciVYzsu6XFYTzqSbTLPqf7E5zlHR1bABIINFGsfZcBBGaC7HlQQTiQKwQ
	eLUw+ilV3yaUIwm+8REgl/Bbulqfvf5zqwRpoLd2LzQ0aKP33VsOvl+81vEbA56x
	0FMovN8AXNUBK9nw3VcnA==
X-ME-Sender: <xms:A-x0apzjGNJ3ADH0MBGuXZViylH5FD-rB30M06RrSP4U6PEORhznfcA>
    <xme:A-x0akHldcjlcMqFcduEN2_SkmzoYUu0g_XoDgP_l1qmUEtiXVGKlk928LvH1I0vv
    UfrkoIFJBoYp2Pk6K6asw5NkL3OpDqicyOqJmJRdVx1o1qKcxM0Z8U>
X-ME-Proxy-Cause: dmFkZTFty8Ewln7TAQ74dSV6hiqJHUY1Acbjdy8vyXH4B7jLY4YwuQ+EwrQGqCG9Ts4IzP
    GGC7Qljs1qagvxbi3saJp7kkD2dtRGHO7Fo+/KUECCviyYqPNLNFDvxC4KZbrmzKSAFVnT
    bAQHz8iaeQDFcNe7QxQZVdEdtd0YeKcEMFn3srfD4QHWENNaD/NGRPnR0KOAV/Ke0AZjNt
    1UYlCPKk8Q2rhqb4OdETQhq/Q9G5OXPlt+nUTBmiKfVCdo5BwWSWsNo4lhYeL/dtkUiFMp
    OuHkEO2RYniiTznb2f1AaKOuNZrEx8dJS3qJfsggq/kSG6+iApuZPb3Ccug1YW8shnAvkx
    3RwWzYc9J2aMZszEy/9upqGnWxv2jIJyYYG3JRsn/FFXGneFUTUhkQvTmMt7Uvyq76Z8OR
    GJax9q8qP+4uDmDrhFfVTJr7ZUED/So4lEUWAsOTSq+9PaF4bvAFNmssAEqVwH04em2zPq
    hhUZ9hkiAtyaNmurdvRI6F/5q3f9MGiYgDt92caW0sJuJFOHoP2po9Tw9WnCxDCUQISl+r
    RbdBxo69BA7ZVVeSuojtKV2T9fZikHbc3EYc/8GVG9a6xJITVnk1HtBVNMeDL9kjhW6x2k
    pmaMIfw1Q+Fes9sY02jiIGM16rkaVeXlgbZdeAueN+/jptbBiFku02HBQaSg
X-ME-Proxy: <xmx:BOx0ahO7F_yoX8tsOPNIBTXiNps4CmSy1zZYAR6KEztsMJbCkMZzCQ>
    <xmx:BOx0ars8fIAJZVwFweTmCR8heTWul90rDjQR4q_7ttoSIRBpxV5tfw>
    <xmx:BOx0ajVZO-QPP0B1-2mKBcEtEkzbxJK5g1VPKA_dWQwH8ym0mKzyjQ>
    <xmx:BOx0arsa2LzbTpNCoxvGZafUOB8LkPioVsDl2AMUjPDwqZNrQ3_SfQ>
    <xmx:Bux0avDEYGKliQme11Jbx21cN-eMZlOhK2m0shnigaVAIbGJMj9PyZaI>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 7B7E822C0068; Thu,  6 Aug 2026 16:18:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ad5igGGZDhxo
Date: Thu, 06 Aug 2026 22:17:42 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jeff King" <peff@peff.net>
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <0594b8ef-57f8-4b5f-a8b5-894123e3cbc5@app.fastmail.com>
In-Reply-To: <20260803152025.GA189075@coredump.intra.peff.net>
References: <20260609004340.GF358144@coredump.intra.peff.net>
 <URLs_not_trailers.b13@msgid.xyz>
 <20260803152025.GA189075@coredump.intra.peff.net>
Subject: Re: [PATCH] trailers: stop recognizing URLs as trailers
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026, at 17:20, Jeff King wrote:
> On Sun, Aug 02, 2026 at 09:57:17PM +0200,
> kristofferhaugsbakk@fastmail.com wrote:
>
>> There are commits which contain intended non-trailer lines which start
>> with URLs. These are comments. Example with just the trailers:[2]
>>
>>     Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>     [bhelgaas: squash fixes:
>>     https://lore.kernel.org/r/20260108013956.14351-2-bagasdotme@gmail=
.com
>>     https://lore.kernel.org/r/20260108013956.14351-3-bagasdotme@gmail=
.com]
>>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>     Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>>     Link: https://patch.msgid.link/20251210132907.58799-4-xueshuai@li=
nux.alibaba.com
>>
>> Those `[]` pairs delimit the =E2=80=9Csquash fixes=E2=80=9D comment.
>
> This example makes me wonder if we ought to be smarter about brackets.
> I.e., could/should we realize that the opening bracket is a comment and
> then ignore everything up to the closing one? That would help this case
> and other weird cases like: [snip]

I think that it makes a lot of sense to special-case brackets as
delimiting non-trailer runs.

(for other readers) This support for non-trailer lines grew out of Linux
Kernel practices. At least according to this thread:

https://lore.kernel.org/git/CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPx=
gK0KQGw@mail.gmail.com/

(See also in particular: https://lore.kernel.org/git/20150905000745.GC11=
443@sigill.intra.peff.net/ )

And part of the back-and-forth in that thread is an inherent tension:
the trailer format is loose. All you need is a some
alphanumerics/hyphens and a colon. So it is simple to accidentally slip
in a *real* trailer line along with all the cruft. Like Peff=E2=80=99s e=
xample
shows:

>
>   Signed-off-by: whomever
>   [peff: there's a really interesting thing going on
>   here: the comment is free-form text that happens to
>   use a colon in a sentence, but we'll interpret it
>   as a trailer with key "here"]
>   Signed-off-by: another unlucky soul

Imagine you had internalized the trailer parsing rules (which you
shouldn=E2=80=99t have to but anyway); it would still be easy to acciden=
tally
write something like the above.

But with an additional `[]` rule you don=E2=80=99t have to worry:

=E2=80=A2 A run of non-trailer lines starts with regex `^[`
=E2=80=A2 And ends 0 or more lines later with regex `]$`
=E2=80=A2 In addition to the existing rules

And `[]` are illegal in trailer keys anyway.

This is a very Linux (and Git project) specific additional rule, but the
non-trailer lines rules were always like that.

>
> That said, I think there are cases without brackets that are also
> confusing. Like:
>
>   Let me finish this commit message by telling you all about this
>   amazing url:
>
>   https://example.com

Yeah exactly.

>[snip]
>> diff --git a/trailer.c b/trailer.c
>> index 6d8ec7fa8d8..971ae459596 100644
>> --- a/trailer.c
>> +++ b/trailer.c
>> @@ -635,8 +635,13 @@ static ssize_t find_separator(const char *line, =
const char *separators)
>>  	int whitespace_found =3D 0;
>>  	const char *c;
>>  	for (c =3D line; *c; c++) {
>> -		if (strchr(separators, *c))
>> +		if (strchr(separators, *c)) {
>> +			/* avoid accidental URL matches (://) */
>> +			if (*c =3D=3D ':' && c[1] =3D=3D '/' && c[2] =3D=3D '/' &&
>> +			    !whitespace_found)
>> +				return -1;
>>  			return c - line;
>> +		}
>
> As discussed elsewhere, we are free to match with short-circuiting
> because of the NUL termination. But that also means we could write this
> as:
>
>   if (starts_with(c, "://") && !whitespace_found)
>
> which is perhaps a little more readable.

Oh for sure, much more readable.

Thanks!
