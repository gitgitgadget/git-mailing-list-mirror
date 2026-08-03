Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448292F90C9
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 12:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759146; cv=none; b=M4KXo9IGQFA7LBa416+dKr3mUGm001JybDLNR2c3CnlC7rqQpf5RLAxXc4twWXd+TqZ9vYLAGX5V6qwabu8G/2MDliit+GxVhZ776JHt4vTHljaJoX+iIMPbt4K9HXsqMG5uYRE4CmInzJ1quSwh5UXKgpPk7jhV4Hzwlr292qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759146; c=relaxed/simple;
	bh=X/a64+rqDuFjRFeD+GUSauP5DizXHYJyaf+Jo6XZkMc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bG4eR2fAv9B4rjberEgYW8FplXIIecK8ab7DJtWjkYIsFJ2n5Ylny24AVn+dSoqnUIIPzfTJv4I08rSFwNEuMIxPrWcFFIBbpvc7JkOyzkmsx1/pq67req46boiiMwUG4j9JqTfZwdixL5IJUVj9eLV8S7Jmxk9dsebqnDPSOTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LpZLfqJ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GQgemhaw; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LpZLfqJ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GQgemhaw"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 04BCF7A003B;
	Mon,  3 Aug 2026 08:12:22 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Mon, 03 Aug 2026 08:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785759142;
	 x=1785845542; bh=Dt/cUcIPVUbBjf/vTEXbcONHZqhaAFV2fjk1bPMfgDg=; b=
	LpZLfqJ17RmSwUPbE4Kt7KRoQJKBElhwQl80+K1HN5tcOH9li8vgTYkI0LSdJfM0
	RXiXQmmd0lRdLAZCI+7+WdgBfm1kUT89r/AtQlj7IZ8I3U9gs3kKy1UJlauf9skS
	YihnPbOy4frTWivi9xofMeOBjZ6ykhu+iEF6owoh3CwHd7oANGAGFeMz3vOnzzIy
	0QNv96YImxBzjtxpfflURcEWTQC87v4T+EDaGStz1T9owFoEca/hbH2fz2sa/uUd
	+eEHxm9g1b8upNhJH05ACaDyD+5tLNgWUlPlGwcIydeUuAGATp49NBxoloyDjR5K
	jqS+Ak14qPeoJJgl8Ih6AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785759142; x=
	1785845542; bh=Dt/cUcIPVUbBjf/vTEXbcONHZqhaAFV2fjk1bPMfgDg=; b=G
	Qgemhawqrd+Ck3Mr5KyuTE8UrrnPqZPcLAzQfdrtnJhmMyn0O7PWmnrcT43wTQS4
	aqKpjpictkqB70xNl7eY8uGkUPQXaMv5cVOCR7WmZF0VWOyfvygA9L+EJ6NNkh9c
	mSPYAKoUp16zAKVfoEKBfA2G+bT7dc0QTK51zdvKKyUj6BZFrad5sWaMegdSTrpD
	2d58PVndGVMSEzFGnRFpFA2qu+SYW+3A+NA0ER9xiY+5ROOxS5RFO61qYMh+oOZn
	OHULSRi+NOHHCfbtQwsQZG3QYLdHfISeaH5XBGMeWmO6CjeuhSLIyT/xvFulT4PC
	14YYLdgT6VMMWXZJYonEg==
X-ME-Sender: <xms:ooVwan0tKC7ynv-O-3BpvXMsw-VqZokm_WqVL9IHBr8Mr5FsRFP2r5c>
    <xme:ooVwag6AxPBL50a-667CSwdtEbeoohyeZJDoERTivOU0VftEoxcWgwic61Ikv5_Bo
    q011zvrImqANrfVapPCMIbed5RE6NXTmj2X4E5nAXqlJKdrkW193A>
X-ME-Proxy-Cause: dmFkZTGUBqqoMsAWTCaOsggtJWHyHjdfiw3ryGXsB/jUJhFpDGOepYOX+4ZQ2Q+5o6vlcO
    enhbdm0EIrgYmNK3YbDshmFCsKH+gJcXHrUSULVRv0TrtTVhgaJQfIOYkOR3eRPNfQGtCt
    xAUsXJQ7HJSvD4AuLIGEipZbwxzAG5MUQYRVP0sXWe6MxPwkQBrwPfFEpQg1fTa0C5T+OF
    5wuzKS7vZnIyoC4cysAa/4wWWcGDx1+vpCaolIiXGd7Ieosrv/0L1KlHdPMc/txHV7SyEK
    4dn7p3GsndLXtY9iiGcHJm5oUoIMHJUX9dt5v1DgHXOqYaxLeOvWrFKG/Ks0x658nLkJOA
    ReygtwdgWaht1ChQVWFewyalkZcxYHVqc1bMx1lutGgs4nlghEBuMc/q4iICWwF9fICuJf
    oHZ96BC1VUkJQmobXDooSM5VaJpynWB0PZOiV5SVNR5nLoqWNLSomvO/aQk00vDDY9dD5K
    6XxWMzeyAcDA1nH1lPONnBzWDAADbpejklqtmcyYN50OBXJxBfwV+qYooXeQptbIloy3X3
    o0sWC2rL0tB01lGcNriDE960wzthBEf+MgkF4jO3oLbkrpYbHJji1H7hYZNDUsDLwOidih
    jdzjzmcUWJgFCbw6pH4E/fYVhqtDsk2r9TABbzIxlNWlUSvTa+t4q26N/BkA
X-ME-Proxy: <xmx:pIVwatcvgVIsWe0DLvVMftaMgsZ-Pl25rFZ2kS7osFnBghicAxAsdg>
    <xmx:pIVwapCWUJcUdc1M5je6oo566FmD3WWzPSXguwvGcmfB7Tr678jwoA>
    <xmx:pIVwag-xli4MiHwz24ak-7XPLpryLreuB5ZT5-7IciUSKmDoz8JGTw>
    <xmx:pIVwakIrp8P_w1li1uph5L6qnnuB1RoozP9KK8zSP7Sy6s5c6mrnOg>
    <xmx:poVwaqhxwWMUalaXx6yoM3p3eZPVtpe_i_VgRoOvt3pCuQxvwpLaPKyl>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 9AA6E22C005D; Mon,  3 Aug 2026 08:12:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ad5igGGZDhxo
Date: Mon, 03 Aug 2026 14:11:02 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Jeff King" <peff@peff.net>
Message-Id: <53cc61d7-6206-453b-a0d4-a2fce00a2c29@app.fastmail.com>
In-Reply-To: <xmqqmrv42lrg.fsf@gitster.g>
References: <20260609004340.GF358144@coredump.intra.peff.net>
 <URLs_not_trailers.b13@msgid.xyz> <xmqqmrv42lrg.fsf@gitster.g>
Subject: Re: [PATCH] trailers: stop recognizing URLs as trailers
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026, at 00:36, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> An HTTPS URL starts with an alphanumeric scheme followed by a colon.
>> That means that they will be recognized as trailers in a trailer bloc=
k.
>> That turns out to be a problem in practice. Let=E2=80=99s stop recogn=
izing these
>> as trailers by failing the trailer parsing when we:
>>
>> 1. find the separator;
>> 2. the separator and the next two characters form `://`; and
>> 3. we haven=E2=80=99t parsed any whitespace yet.
>
> When I read the problem description, I would have expected you to
> say "If we find <token>: at the beginning of the line, check <token>
> against known URL schemes like https, ftp, etc. and declare that the
> line is not a trailer, if it matches".  Checking against "://" is
> much more robust, as it is less likely to happen in random text, and
> we avoid maintaining a whitelist of scheme names.  You are certainly
> smarter than I am ;-).

The credit for being smart goes to Peff.

https://lore.kernel.org/git/20260609004340.GF358144@coredump.intra.peff.=
net/T/#m03ac1a456648090c04cdf5141b7a3e638f1213d1

> Shouldn't we restrict the token preceding "://" more strictly than
> simply prohibiting whitespace?

Right now (with this code) we know that:

1. We have either parsed only alphanumerics and hyphens (whitespace is
   ruled out); or
2. We haven=E2=80=99t even parsed (1), but just found a line that starts=
 with
   `://`.

In both cases we bail out of the parsing with `-1`, i.e. =E2=80=9Cnot a
trailer=E2=80=9D.

Wikipedia[1] tells me that this current check *does* have a false positi=
ve:

    A non-empty scheme component followed by a colon (:), consisting of
    a sequence of characters beginning with a letter and followed by any
    combination of letters, digits, plus (+), period (.), or hyphen (-).

=F0=9F=94=97 1: https://en.wikipedia.org/wiki/Uniform_Resource_Identifie=
r#Syntax

A URL *must* begin with a letter, but a trailer can just be a
digit. Which means that this is not the start of a URL:

    1://

But the current code will reject it as a URL.

There are also other false positives like the strange but legal trailer
key `-`.

Other than that, the character set of trailers (alphanums and hyphens)
is a strict subset of URL <scheme>.

I also see that the git-interpret-trailers(1) doc update should say
alphanumerics and/or hyphens instead of just alphanums.

>
>> Helped-by: Jeff King <peff@peff.net>
>> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>> ---
>
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
>
> How do we know the references to c[1] and c[2] do not access an
> unmapped piece of memory?  The answer is that line[] is NUL
> terminated, so c[0] =3D=3D ':' guarantees that c[1] is safe to read and
> unless it is NUL (and c[1] =3D=3D'/' certainly means it is not NUL),
> c[2] is safe to read.
>
> OK.  Makes sense to me.

I=E2=80=99m mostly a Java programmer so I had the same thought (non-dida=
ctically
;) ). Yes, because of sentinel `NUL` and boolean short-circuiting we can
incrementally peak one character ahead. This would be wrong in any
language without `NUL` terminating strings, but here it is
correct. Indeed, checking the length first (which you would need to do
in Java) would incur a linear cost since you need to scan the string
until you hit the `NUL` terminator.

>
> Thanks.
>[snip]
