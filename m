Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D473FBB5E
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791028350; cv=none; b=rWNOrKgBoF+khtklrTEspgQjDeCNWhrotoXk7x0RjQS3vstL6Wyzr4Ykv58SOhcmRBRaZ70FIcT4w3TnmKJJTvOklQzfqWrUNahmWjFCS04wePeiszRVzTfZov0xj9DuRn8pS1Au+lfZO1HZs5dWzBQ17e0ZM/v+iz91M6RUXa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791028350; c=relaxed/simple;
	bh=stOn/GQBWQ21lEHgtw/AbB7FzlthDdJq6WgUd3Fbmlc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VE4olUH3Vxm2gXx/9NvWvZQuKXwmfiBvIRqWVpmuQO1H9npj30f8K19AFNrHnklMFYn7e/yg13CQSQtvPnXSsejkEZgwveM7DGQqKH7GIOWkOW+Af7MwtQf9R7Vb7D0SePZVOtUzO1DunsfxGEakVOVpGPVJt01OviNk0ABjjxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=aE0C9lIW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VFJclJxY; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="aE0C9lIW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VFJclJxY"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A073EC03DD
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 07:52:25 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sat, 03 Oct 2026 07:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791028343;
	 x=1791114743; bh=MBBeTUlVwGcqqACNmiwy+DMHuf+E8hQDLb45RRItY2s=; b=
	aE0C9lIWSUkGKT0GDO2cTv1xCiWCyVn8B0zWWj3MXqmK/y0jghfSB3kP7a38vtUR
	fNQ0Hz9cIM6xlP4LJAqhZzSISMNP2c41ZqeCnDERyZnGWVBAXz/Tt3upOo+BWy9p
	M6AwLG8Gn+N9VCiQD5b3nyH+sFk9aa5bMuKDR4QRo+gPZ/nVyljJNk4a03+nGcYa
	zGJYf9DeZIcqBxCBxI9uBiDOCJU0ZvuTLHGgvkLSurBf0o4mdU6i62nBI1iVEFfQ
	WX7lhGS/Vj+dwlAqybd3SdzdaGsF/mnUISNcx0gapHrgX3/4GTemnP52sZK9Kg2j
	QcTBTLZV9Uect4Yf128hSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791028343; x=
	1791114743; bh=MBBeTUlVwGcqqACNmiwy+DMHuf+E8hQDLb45RRItY2s=; b=V
	FJclJxYWuKYdpjAQ1JEZuT81tzD4h+f31PzUM+1zH881/gYCmOf6Wp2lMR/ppXM2
	NjI84wDGl31DtiUsticzOVCQQj9W0Jh8e2gq9xbQTB9lAWzJ7vvgFQlcHrbpoFHp
	OUCi0aD05BmS1ry32YAs7s6YjQASkbUHORggi0NPbKpcaSPMlqQRanT1yS3mpCe0
	PeqGlOfFaV1rtPZ6DpMiOObr8dLc9Y0bsWJgF9gwkkTX+gLEbvCefJy0ssyJ3Aw4
	m3yOwm5vNRJlrZ/U9SkKkyLikwFVFEGpaWTquHdfxI16uu5/FCYb6tBx0HbHdhoO
	iEPoXaXvTNRCt2WwEi+sg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791028343; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:d1bJO0bCaZVoew6gpvWXM9Pc0JxVxnZiMCaNc/mrzsXrwa+
	ViPEO8R8PmtO8Cdxv+LDpb4YpzL0DgmRkj7YyQ2VOHK47Eq81jIkIH1CxdNkKuAy
	PuZTf3vr4oKBJf/BNqaPBI1c2vofvRgOXDbiwkf7mOJ44RXrAQldhkaWhwqbE216
	7WhcYN1UCXtRDZ+A+xIfRIb52d/DsTyCqXR6QQUVX6vz4EntZEvv75oxA/iclPMr
	242d4iCBo1T7GzMQUbmPd8uHhqZEkJfXJnmzC0Vnu1q5ZB7pl/D+Rsjrn0MTixw7
	EWiwjoK44JTD5m7lZlC6iLCeXc+OmkoLiyyPaBw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:IaqTYqSHWYpxR2y12xnXs8S9AvPWYkdaI/1FK+il+Lk=:stOn/GQBWQ21lEHgtw/AbB7FzlthDdJq6WgUd3Fbmlc=;
X-ME-Sender: <xms:dezAamKVwKrbH1lNJswA-EDFpdwUKnay5d9mU_1uZ3uVSS33t36TuZA>
    <xme:dezAao96HEiL2CJgU_HVLUNcxeM7o-h4TPoZibZxlciKfqRLdSXBjwieH8uuB3LkQ
    gS_k8X9PRliglUFDIOTTRPtjl_7ab7wvG59yhJoqaDVrN9fvJKVYg>
X-ME-Proxy-Cause: dmFkZTGXf+JB/h9wIMmjFfaKF6PsdeGzWYthJtIbEOfFtJVrI67wSptOUQXEtF+o/YY4Wn
    e8nfvKyV7HkjC4/7j8+kC6kpCAVcdbOKOkOtMMbxh1OIUPnYduLHxVJdMY8sZvUUuGItKf
    tmNLHhB+m/EP7Ssw0e4jx63iBDp6HDRh2vW/fuXh8Fmby4lI2goaoNlfvxJaT8q+KaH2ir
    IS05VXwaHMtWjRqHh3VAGn1AJvL9QXyhP8W8D7+HlUfByLfL1uvcYlIDU6AzlaXCgPC2rA
    EP/dIPdFD9FSPSJZgMqejmshlizEiNUJ8iFyFTwwFTJ7XlH49gZJTILtdO8aI4osDLeJHu
    zZS1lTqJdJCbVRnxYSc5ePHtlJ3u0+TtemPizNwStStN/b1XvIs3NSMQkFYVDIULgy7qLF
    82dRVznZOGWhVpKUcM1ODLS+Banw7/saN02sDeWjLSBlJtLrHJsfMfEEFA73nH2+pNgXxk
    hBwKdemrKGri2gY7B8EmFWt1WsJ1goAEZGRIz2LYKIzQJqiSW8BLZDu1khL10ho+4xEWlN
    OeNQTP8xii25jYalacSzB+LcI4Kh3NhhYF6L9iNiq/9XtB8H0ptfTI38noviW94bwb4AM9
    5W8tMuIjVJWsQFlChh/zJrVlPJ2x630gsvbUiuUqVvF0zLDkI6AaecOk7Eng
X-ME-Proxy: <xmx:duzAaingRW6gTz9XXvg5__aq1vdgvFVBmwThtMDuRKkastOY87d2ZQ>
    <xmx:duzAahnLu9efWJ1EVgxzQQlgU08_BIRfnMJJBZ3UlcjrUYIlNAx3YA>
    <xmx:duzAajtr2-aEq8Gi9FpguVdVDxKBJVFBBR9zsbrmWsPAklmw2IW8sw>
    <xmx:duzAakkruXxTmFxJHf50vOZGpav1oFDYdGS-sIm7YgcH8BlILOnpgg>
    <xmx:d-zAaifJqzr6jxdHeF7q7XubRJh_uqH6wCFSjqbXO9rqUivSwTgY8cE6>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id CEE1122C009B; Sat,  3 Oct 2026 07:52:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5YEOc4Hum2Z
Date: Sat, 03 Oct 2026 13:52:01 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org
Message-Id: <533e2f52-2c9c-459a-9fa1-dff3ef4bb2f9@app.fastmail.com>
In-Reply-To: <xmqqeceaa5h9.fsf@gitster.g>
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
 <URLs_not_just_msg_ids.d1e@m5gid.xyz> <ar0OltAkeTiCx81c@pks.im>
 <xmqqeceaa5h9.fsf@gitster.g>
Subject: Re: [RFC PATCH 2/4] doc: gitbreaking-changes: replace msg-ids with URLs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026, at 21:45, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>> On Mon, Sep 28, 2026 at 12:41:26PM +0200, kristofferhaugsbakk@fastmai=
l.com wrote:
>>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>>[snip]
>>
>> Fair. The links may of course break if at any point in time
>> lore.kernel.org were to vanish or change its interface. But if so we =
can
>> adapt accordingly, also because the message ID can still be extracted
>> trivially.
>
> One caveat is that some "funny characters" in message IDs need to be
> URL-encoded.
>
> A recent example I saw was <20260930061524.GNkIK%taahol@utu.fi>;
> https://lore.kernel.org/git/20260930061524.GNkIK%25taahol@utu.fi/ is
> the URL you need to visit to view the message.
>
> Having said that, I am somewhat negative on what this particular
> patch does.  We should instead give both, having something like
>
>  cf.
> https://lore.kernel.org/git/xmqqa59i45wc.fsf@gitster.g/[<xmqqa59i45wc.=
fsf@gitster.g>^]
>
> in the source, and render a readable link text with reachable href
> when shown in the browser.

With that I get a regular `href` and a `mailto` href.

    <div class=3D"paragraph"><p>cf. <a href=3D"https://lore.kernel.org/g=
it/xmqqa59i45wc.fsf@gitster.g/">&lt;<a href=3D"mailto:xmqqa59i45wc.fsf@g=
itster.g">xmqqa59i45wc.fsf@gitster.g</a>&gt;^</a></p></div>

The `mailto` wins and prepares to send an email.

For HTML output at least (I haven=E2=80=99t tested man yet) you can use
`&commat;`:

    cf. https://lore.kernel.org/git/xmqqa59i45wc.fsf@gitster.g/[<xmqqa59=
i45wc.fsf&commat;gitster.g>^]

And that works.

But with this rendered output:

    =E2=80=A2 Support for core.commentString=3Dauto has been deprecated =
and will
      be removed in Git 3.0.

      cf. <xmqqa59i45wc.fsf@gitster.g>^

You have an exceptionally short (cf. UUID monstrosity) msg-id, like all
your msg-ids,[1] to the point that it looks as long as an email address
but more random-looking and with a weird domain name. And the exception
for email addresses (looking) that are formatted as links are that they
are `mailto` links. So what would the expectation be for someone who
hasn=E2=80=99t read a preamble about what these things with @-symbols ar=
e? That
they are contact addresses perhaps?

I don=E2=80=99t think this is an improvement. Now people unaccustomed to=
 using
msg-ids have to be cognizant of these things as links (not as weird
email addresses), which is even assuming that they read the
preamble. But with regular URLs you don=E2=80=99t even need a preamble.

As for the man format: my terminal lets me open links.

Maybe we should drop this patch if we disagree that either choice here
is an improvement.

=E2=80=A0 1: 3/11 of the existing msg-ids are from the maintainer
