Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC03486628
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 19:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871025; cv=none; b=iz3uI/aIcfEqKNc1Z8krB+6XO+v15xsYn3eCX0G6Ip8ZKU43SnyBjQ8UdPomSeRVTIX/4GechyW4o1hUGqtxlFcWT6Gyy6safIjg2taU7QYtxek5g/dU7kWJjYo5JKsDM4dog5RC1FM+p1OGWmo3QRM9W0LVP4RKXwRYXphqrBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871025; c=relaxed/simple;
	bh=GZK2TlqLflSpPaeZiWnEL2UKbWjeawK4zKUMtkq+xRo=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mnxz6R/YH81iVi4l4mozZzLIRIVj7c2Ujb3TAbHUDq5JqutQ9VooeKZqk9PGS2N6GfvBr2dThPVtVarsD0Pt/+yYTrB4iJ9nmGoAWLqg75d9RI02UotUH3EBO27kxwUqFJ8cPi0iy1kRcRbQhAA3BQSe6n9r9XQougwELQXp8NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=iE5yoiQh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y55fKAte; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="iE5yoiQh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y55fKAte"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 56FA0140003C;
	Tue,  4 Aug 2026 15:17:02 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 04 Aug 2026 15:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785871021;
	 x=1785957421; bh=Zr24Sf9aZJZKD7YyBMXOhrVu6r9854JFfAjvWmnJszo=; b=
	iE5yoiQhU3/JTcsw/vSBJDCtQnlo/JyfkPBwqjG/YFg3xaEyZuC4+afoyF59/EjK
	2hFMmY8ww9tgVmgBkV5XI8jUPnWVvYagzDvAJviL/7MpOTNs0m7MrJeze6qSzU1s
	D8gSMuP+4pi0t6XTZOTNNiVgljKERvRnq9M5aLVrJnRmP3qhYST960k/+A5Zx2Np
	uV31SEtFMVz1HHidXiaeoJY47pfWFQigZHgALpt4izALMwQNfYtQulCR1ddprzGj
	H+SRa0Z1p7Y7t7xr+cvue9wFokc6iczD3DAOEnSXRIFAoeqq/vVyejw/Hcy/5s5D
	UbCiAI7uJi+Id/Sw1Yq7ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785871021; x=1785957421; bh=Z
	r24Sf9aZJZKD7YyBMXOhrVu6r9854JFfAjvWmnJszo=; b=Y55fKAtey/hpc1m7U
	oCI81te8aTzYYMSKBw0zgx+aas6WYM69wnmc2qKws9GhcP09wUHXMBKuhiKjT82l
	0favO5MdcKQS308tQoDXlKbbbG/eGn1swj00QmdELtUzkvV/C+CNiVxQ4ybrnC2J
	16Gw48JmcS2huRei0DSd5tgBHiU7NrzFd9zvcPCmY0Y5qSS4ApR2shMNjLRF8hE9
	Zi93cnJqfFYkF/OHairCRpRoheVuDC47D59xSsWeWgcvKhaJGq/yeJSZfl4uNBaP
	cAh2WBOJYAOWNAlEP6lsgl2PyvKU4phhC7ZUhYtdOmDcg+F3X+k33KeYJ5MDNXAD
	HLczw==
X-ME-Sender: <xms:qjpyajJ1AZh0fQFKthHNeLC-XjkfgSTPHdgPeHGCma8DqPcQ3Hg_cvY>
    <xme:qjpyah-mkElXfQsRdgD0hQc8LGCsKEcZ9iHefyg2pvxXglOdHcxH3OXXdgh1Fq7wp
    iaYywSaNDsoYju3v7USJ3jO-Wg_UqMLmNVPwuyBnKD8wu-ADM7PqQ>
X-ME-Proxy-Cause: dmFkZTEsqOP9XYYn6gdAd3wzmWhkugLnutDDl/4sO7FXOhJMoKDSuKo+F/o1bFM3qj/PHI
    cfdhmN7IuZAs1F5Wcy4gsKOqQcriw0BC5tzyDxe/EaaZxkivZXlVW5Te4tvSWTpUfmdURw
    f7gdaQzVapxvCK6L7L+5ZC+CpUqzQkpHWHSURIYnP2h4tIRaZ+GYKZryzfGQC8lSmoM8Jg
    5uNod0pwroT4KRfy7EIFJdT43xXsMawjq4DRx8zE6JG4ZCgmOUgdBhb9g7hWMHFwr4wDI0
    o/ZYGl38AopCe+lZL8ycr8ShVEqkcedX8W/1cYi6CioPd+FMZpvQED7ODMm01EigiEHIAM
    c60Zzfxo3qRArEoM0cslfLKENIvXTEno5C3moaWh+sNR9/YCfBjTMNv3nVc9OgGVOwAV7K
    DXXdxowalWt8XTMUkvDcmlog2k59+KII75Xnc5WeESL2Fd9MclonwUIKz+AC59rFMLXpDf
    3SP5euzt+AwA3l1uEMa/T+5eyxV+zc0udtHwlWRKxccM+6yyU/6Eoiq4ERENNAb8WCn6+s
    UIhCoQc8Mnl/ElC6E0SHleUam4NCP0qijZtZ8D7kEgdoBpmqG1uLvv9CGCpAd23MkZdMuF
    FyXmXmPTm07SeTWNSZdXdzl2L0amX6gNlMtiN6t7BVEcQDVyoWhIJkjtG0CQ
X-ME-Proxy: <xmx:rDpyat2MO3EqNj4v9r9EYx9nstOYUPkXzHA27EJvortbrWolStXX5Q>
    <xmx:rDpyaiDRf2BedXVU2RQ9Fj6TR5tofFQeM5ZUcm78yFSvt7qxR2n-mg>
    <xmx:rDpyaldIlV_hS5eMEmM8MXdniKIHyqqAq3QgPPTPIAUwz8OLgsj0bA>
    <xmx:rDpyanjiWZF8404cOyp868k8hsxNB3Evfi1BvCvk8NL6J5IF9mDGtw>
    <xmx:rTpyasuhYrpwrh10w_YbKbAHYAQLAUzv5w0nyP1cor2FU5dxEUQjKN2k>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id C8BBC22C0061; Tue,  4 Aug 2026 15:16:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A9-6LbebrgRw
Date: Tue, 04 Aug 2026 21:16:38 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <b9d5e84b-a25d-40e3-826e-de555cba7fc1@app.fastmail.com>
In-Reply-To: <xmqqldanxbq9.fsf@gitster.g>
References: <xmqqldanxbq9.fsf@gitster.g>
Subject: kh/trailers-no-urls
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026, at 21:09, Junio C Hamano wrote:
> * kh/trailers-no-urls (2026-08-02) 2 commits
>  - trailers: stop recognizing URLs as trailers
>  - Merge branch 'kh/doc-trailers' into kh/trailers-no-urls
>  (this branch uses kh/doc-trailers.)
>
>  The trailers code has been taught to avoid mistaking a line that has
>  <token>:// at the beginning as a trailer line.
>
>  Will merge to 'next'?
>  cf. <20260803152025.GA189075@coredump.intra.peff.net>
>  cf. <xmqqmrv42lrg.fsf@gitster.g>
>  cf. <xmqqtspbz00x.fsf@gitster.g>
>  source: <URLs_not_trailers.b13@msgid.xyz>

The kh/docs-trailers topic that this uses isn=E2=80=99t ready for `next`=
 so I
don=E2=80=99t see how it can go to `next` yet.

I can make some improvements to the explanation based on my last message
and maybe the code could be improved too (`starts_with`?). I think I=E2=80=
=99ll
just let it sit for some days since it uses the in-review
kh/docs-trailers anyway. Maybe there will be other comments in the
meanwhile.
