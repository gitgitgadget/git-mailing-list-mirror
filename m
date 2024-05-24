Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23116EB4A
	for <git@vger.kernel.org>; Fri, 24 May 2024 06:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716533788; cv=none; b=LWRmwi0HSZtc7uiV6U7tk+G+iZ+xhVrOllBvqFg01WDh/Uokz6vFvUWijB9joGwAW3ODB/ECTdl2rqzXd15eqABfZopofpnJPvaUCuoeut6Y7InxAGwnzIbXLfjTEAUzduuelz4JGeaaJ9jkKA96md1qy7PZkFomz/Gi7BQLcys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716533788; c=relaxed/simple;
	bh=DMTPRQbar7GlMyZRYbRGxPD4L9oNqbRMNjlczUnJ9hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9o3TbIkT88CsbRs65HY57adlDhUkXlN/Ojj7HjKyOygsgUd2WrxFJz+1rd//uio7Rhsh8+BjRouChVSeLNjA+OHXf3mEPoZv6rkMGJ2DBaYHQ3ATTsDa6cK/ZZkM1ndv4cOt8yDYWhdxIgQJOO9PiggYu7WwnZfzIYC6x9hZwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZGQAppLa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pDUyzo29; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZGQAppLa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pDUyzo29"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id AC58B11401D1;
	Fri, 24 May 2024 02:56:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 24 May 2024 02:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716533784; x=1716620184; bh=UthaUhK78i
	gn+6oWq9wh82fayL/F96HO9cbHBXMdH+s=; b=ZGQAppLap3Lkx1D6pCQ6RsHJiv
	bM3x6d3ylKHFoj8jfsbCgbje3f1bruouzyQqkbDT/HodugHctjRrMziGEq119Gi4
	Y/mCSig0IfiKky2Dp5jyxzY3AVNZ2odcZZzoOqawZGxDv0RgK/GLVzIFZMki/GEE
	dZmZ4sdVUNQhXFpT7WjnUmu7NbU1pzfOP28QPAbb9wMdfDfpM6pTXPm76/gcySjV
	QyNAr2+6vVlzR1nXsDj41BCl7Lm4Rsr4NXv5GoDKo/UoPtUZmAhtWqxJtcwg09JN
	9lKVf6yl3AMj7LK2ge8IJWxYCtko53ZBB+oGIPU82GYbzmr2l3j1hl4WUCRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716533784; x=1716620184; bh=UthaUhK78ign+6oWq9wh82fayL/F
	96HO9cbHBXMdH+s=; b=pDUyzo29FfLRc6fJ6DD0An3wGuZg/CMYp6j3Hlyu/Ndq
	K9CGSrBaVr0n5gWhgwR1k/Sh9TeCQSzuixESOcVqBBRSnVoYdEDSbMyWkNaZj5Ma
	sesDmCuMqx8CLnTJORONirA98p4LANqIs7/7db2WAhk1MWsJvYTqlVC1kbEoezSO
	SOl6sFaASmmmVrjApChDZwkB11KN+XstTpcNP4kVJxWgqxF9hsqFHH36sFRyndm+
	atJh8/hK6q3sMxI3E4AYZ1Z7+X02DR2AcUOEOcVbdgWB2sBfZe77ATKT6EtCkKyV
	xMfpVlSe5TR2Tef8wDcGN5Ofg0z+srs6HvWrkS0Wjg==
X-ME-Sender: <xms:GDpQZjblrANL-OGkNtJlKvcjO_IClaiM27dZbnTn0yZRVO8pKhFmqA>
    <xme:GDpQZiY4SlAEKizAZyVj9PK37Kq-OMJ2IxpLPGIy-cl0lDQ9sBaBHvXe4ej6xLPVI
    i_JVqxfAVdF7lPdNg>
X-ME-Received: <xmr:GDpQZl9kdIxIjzJu7ixT7wzzyBfjim1nw9sW7IOFhduW53VG4bh6wZ_yHrWOxbT99A_-R8ytwv7soch_THdCuBPUBmv_fvNrnT3nDSkpM0uABd4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeijedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:GDpQZpqCM45n0VnvEVa546FXu6fUXThy_RTbfSINvupTUKfAiPfywg>
    <xmx:GDpQZuq7gAHE0N-pzMbUfJ_BnNBoVn5bOxGbGBOU2Q_ip4qDw0hDjA>
    <xmx:GDpQZvTaQvX0CKSJ3by6DziqNvQTBMhnxnR1XEZXuiMYl3lFmL26Iw>
    <xmx:GDpQZmoDvGHmt3_mlYy-bBnaSm1NttKa-_o-FCB5iLOIc7J95yhljQ>
    <xmx:GDpQZl2c62Ghia4_N1p74wB6A1e3n8eB-TZ3v-59u7vqY0ZXxr2lM7XK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 02:56:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 501c0374 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 06:56:19 +0000 (UTC)
Date: Fri, 24 May 2024 08:56:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/20] Various memory leak fixes
Message-ID: <ZlA6E69UdqLE_HzH@tanuki>
References: <cover.1716465556.git.ps@pks.im>
 <xmqqle40v5ms.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eD6BEyR+c+UgwkNU"
Content-Disposition: inline
In-Reply-To: <xmqqle40v5ms.fsf@gitster.g>


--eD6BEyR+c+UgwkNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 09:45:47AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > my mind had a couple of minutes where it was roaming, and of course it
> > immediately searched for and chased down the next rabbit hole. The
> > result is this patch series which fixes a bunch of leaks all over the
> > place. There isn't really any structure to the leaks that I did fix --
> > it's mostly things that I stumbled over. In the end, this series makes
> > another 56 test suites pass with leak checking enabled, 13 of which have
> > already been passing without any changes.
>=20
> ... meaning there were coverage gaps?

Well, we never run CI jobs with GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck. We
could add such a job, but the question is how important it is to notice.
The much more important part is to not regress, and that we do check in
our CI already.

The only oddball here is newly added tests. It's a bit of a shame that
the leak checking is opt-in rather than opt out, as this is the primary
way for how new tests land that do pass but aren't marked accordingly.
Also, it may raise more eyebrows during review if a new test suite is
marked as failing compared to not being marked as passing.

Ideally, we'd just get over with all the tests that currently fail with
the leak sanitizer. And honestly, that doesn't feel out of reach given
that you can fix >10% of all non-passing tests in a day or two. With
this patch series, we now have more test suites with the leak checking
enabled rather than disabled. If we continue on this track I could
certainly see this happening in a release or two.

But maybe that's just whishful thinking.

> >   - Patches 16 to 20 have the goal of making git-mv(1) memory leak free.
> >     I had a very hard time understanding how it tracks memory. I think
> >     this wasn't only me, or otherwise there wouldn't be calls to
> >     `UNLEAK()` in there. In any case, I decided to rewrite the arrays to
> >     use a `struct strvec`, which makes tracking and releasing of memory
> >     a ton easier.
> >
> >     It does come at the cost of more allocations because we may now
> >     duplicate strings that we didn't before. But I think the tradeoff is
> >     worth it because the number of strings we may now duplicate is
> >     bounded by the number of command line arguments anyway.
>=20
> Nice.  I have to admit that "git mv" is not one of the best-done
> code in this project X-<, and improving it with rewriting was long
> overdue.

Well, the patches only rewrite a very small part of git-mv(1). So while
the code may be a bit easier to understand now, I still think that it
leaves a lot to be desired after the refactoring.

Patrick

--eD6BEyR+c+UgwkNU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQOg4ACgkQVbJhu7ck
PpQe3g//W7y2QOpfrRVJ1fO+FdbZPwT+B+Rs8ybhPzP9u6ty8Nco7D+4rmZIncm6
NyoKrrWMJU1lIRSKWLvDLQMgkyDbeIuGJMlierRB+7MT6Z8N1JfPXTRcEYnx0A7v
pqFOqYBDMz9RuEl2pQIbgGZVXKXQ2VxhisrRLPLSS3wb4n7bjM/9NVK5cqq+MWrR
5FQ906UioUwLYbhgCvNU5/nLeWPjpAT0WSeGRtBULPBVDp+hXgIAOLagNB6leiIf
mQkGr0geZt9kKD9HRh0dTrkOe+mPwboUL18n9ZzaPQiq8Q5jt/h4C2oPLUzDZeBH
2aZpxCZ0/qWuJNajECUueAdM581qqMzboWOgV/tT25pD2V2p/edy1oarEbPgo937
tGAHLoTOjSLIuPZ13O6QlLb5Msrv/gaDMhd5n0/+7pKd6RVN39VZxR4ZmGyozJD7
mNl/JkiernwTyBJ2nEH83ZrYu4thfFLdYlIMSYG8ZbW7YgzRA92ZCjFWAJauPyRJ
7iKu1kuYOlB6TxRkQQiDByXbsMQOh8MRk5DD5YECND0G6dqlwNx3svsEuwbj+VfL
zAgBjWSuPY5sd3GAuXu4kb03bZaDw3LoinV1HBBss4aFXGapYB2+EdWhqkZn/fwp
6rb9Z6NYyIyVBUCDtm3TCNJpuPbQayootEO5A6WQfkhY2AmrXAk=
=oH5X
-----END PGP SIGNATURE-----

--eD6BEyR+c+UgwkNU--
