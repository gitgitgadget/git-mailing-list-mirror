Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A162EAFC
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w4E9aH3B"
X-Greylist: delayed 134 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Oct 2023 07:48:53 PDT
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B99D42
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 07:48:53 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 968501CD54;
	Thu, 26 Oct 2023 10:46:38 -0400 (EDT)
	(envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to:content-transfer-encoding; s=sasl; bh=/368eh9ftM9Xt
	AfrJJZN6Jg7KD3q3bmsT68Vr3Td5ek=; b=w4E9aH3BvM33eUTTYUjxTNdYUhi7P
	E19W0bml6E+8ZoxxR0ldC7mUchHzD3xGifkWx9YWNd6qFVnlwjZm+AqykuzwcISh
	rv1hDjiRih50QHYFS7WHer2pXS63Vi/5BHEmcue5Qwe00A0FXYUDf7BDA5uRfjaW
	VrPnsLo/i36CV0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8E1FA1CD53;
	Thu, 26 Oct 2023 10:46:38 -0400 (EDT)
	(envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 046931CD4D;
	Thu, 26 Oct 2023 10:46:32 -0400 (EDT)
	(envelope-from tmz@pobox.com)
Date: Thu, 26 Oct 2023 10:46:30 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Michael Strawbridge <michael.strawbridge@amd.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Luben Tuikov <luben.tuikov@amd.com>, git@vger.kernel.org,
	entwicklung@pengutronix.de
Subject: Re: Regression: git send-email fails with "Use of uninitialized
 value $address" + "unable to extract a valid address"
Message-ID: <ZTp7xvXDw1GF-NUB@pobox.com>
References: <20231013141437.ywrhw65xdapmev7d@pengutronix.de>
 <20231020100442.an47wwsti2d4zeyx@pengutronix.de>
 <68d7e5c3-6b4a-4d0d-9885-f3d4e2199f26@amd.com>
 <20231024130037.sbevzk2x7oclj7d7@pengutronix.de>
 <89712aea-04fc-4775-afd4-afd3ca24ad01@amd.com>
 <20231024204318.gi6b4ygqbilm2yke@pengutronix.de>
 <20231025072104.GA2145145@coredump.intra.peff.net>
 <xmqqsf5xr1xk.fsf@gitster.g>
 <a71f2f1f-b5f0-4628-a4f3-6fd1319062a3@amd.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <a71f2f1f-b5f0-4628-a4f3-6fd1319062a3@amd.com>
X-Pobox-Relay-ID:
 74F3F3C2-740E-11EE-89F6-F515D2CDFF5E-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Michael Strawbridge wrote:
> On 10/26/23 08:41, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>>=20
>>> Note that the bug will only trigger if Email::Valid is installed.
>>=20
>> I recall we chased a different bug that depends on the use/non-use
>> of this package a few years ago.  Is the difference significant
>> enough that we may want to install on one but not in another CI
>> environment, like we have a separate CI jobs with exotic settings, I
>> wonder.
>=20
> That would make sense to me.  We have had 3 regressions threads
> recently for git send email where Email::Valid was important.
>=20
> - [REGRESSION] uninitialized value $address in git send-email when give=
n multiple recipients separated by commas - (this thread)
> - [REGRESSION] uninitialized value $address in git send-email - https:/=
/public-inbox.org/git/20230918212004.GC2163162@coredump.intra.peff.net/T/=
#m9e0211a8ad387adbbadf31dcfcd7982d4046633d
> - Regression: git send-email fails with "Use of uninitialized value $ad=
dress" + "unable to extract a valid address" - https://public-inbox.org/g=
it/68d7e5c3-6b4a-4d0d-9885-f3d4e2199f26@amd.com/T/#m1411c155e11ad9c5d913d=
22d1d11180ed56eabc7

Alternately, perhaps having Email::Valid as an optional
dependency is worth reconsidering. If it's truly important
to validation, make it a requirement.  If it's not, then
drop it to simplify the code and avoid these sort of issues.

As a (former) distribution packager, having these optional
dependencies which change the behavior is always a tough
position to be in.

If I make the git package require it to ensure consistent
behavior then some folks will -quite rightly- complain that
it should not be a requirement.  If I keep it an optional
dependency, then debugging becomes more difficult for the
reasons we've seen in these recent (and not-so-recent)
threads.

I'd lean toward dropping the dependency entirely and leave
the more basic validation of git-send-email in place.  That
may not catch every type of address error, but I would argue
that what we do without Email::Valid is perfectly reasonable
for checking basic email address syntax sanity.

Further validation will happen along the path of mail
transfer agents and failures should be reported to the
sender in the same way as any other invalid email address.

On a related note, one issue=B9 we had reported in Fedora
after making Email::Valid a requirement was that it rejected
messages where the local part was too long, per the relevant
RFC's.  But these were generated addresses from GitLab.  The
addresses worked in practice.  While Email::Valid was
technically correct in rejecting such addresses, it didn't
improve the experience of git send-email users.

=B9 https://bugzilla.redhat.com/2046203

--=20
Todd
