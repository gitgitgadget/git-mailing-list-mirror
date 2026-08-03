Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA64B1F1537
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 00:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785717088; cv=none; b=szEdiv5JbkYO+nx9LBN4zPhAuhruVU4h2mu9yodJHL9/8s+oP95VgC3aNgN0M7JVTFe26OUNroNNCrPqINnrWD4lHqmaORO8KASy038CnOxA/Pf8OkhaIuTFJyqALxjQHdjT3hRAdDJo68oy0FH40WnwLVlEDK1mwLtHrSTS+lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785717088; c=relaxed/simple;
	bh=XGSQv03GeuiQo+jhTHETjXycNajXPy4bol2ffjCDUP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbQWnzLRj8bbevXugN8y5XcTXFoqESS1hcGSG1wbfkxjX6OTtATVt7gKVxRJH5Kago2FaeF6/XpLTZGpLGYUWeV3nBF5U7lexWAjXPHhEXi0Zrq02bpTqwp5C7QPwi5FjyATYls9M0ouqSHjqoEeKaVAimHwHUDiqSAIHGSPHFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=uZoMWEnH; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uZoMWEnH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1785717084;
	bh=XGSQv03GeuiQo+jhTHETjXycNajXPy4bol2ffjCDUP0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=uZoMWEnHyKq4Im1d/J96MiwpJ1yskWHvnkKAuqWxkFN7Exaiit3e8RsLrRqTZWbo7
	 usZmdlS7s9vAtBl1bUJAs/y8u7xlsq4Mo5okcEA4vY9a0zl5JzpPByi2k/mM/s5Mcz
	 vZ80CrK8wBXAZyu3/pxOHWEQm0HRQB8OYsfBUL+KvbWy8iI59jdOVWqGOvLnYM+Thl
	 CVpTi7y2jCibWesw3q/tNRuVSf4KW1KeHV89rlcMoTnybs5+0Tdk+P8ygBsVdlIjWn
	 LrWfWridMg9XF1FwnruYvy54eZIe7PQAtLTSETRNKg+sz8goU3cVrKvwXMoX7IWwii
	 1i+vo4rTHgdgPMocxgvCxoKdI8nMNn5nLmWON+Vy1Xg1j1gSjN6pl9B4dPxJU995U6
	 7v+rG5RlZwwN48Oq2kt+TKHvqWG1HD2aoL7Fmc2PKZkN1nSu3kVr/kBDknki9tgj/o
	 SEWRKxnUnKE9BN1YKPEl3xFuLJDWnPvkIoRpstCOSnql/Rqpjbx
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:117f:c26e:50ca:6746])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 88B10200C4;
	Mon,  3 Aug 2026 00:31:24 +0000 (UTC)
Date: Mon, 3 Aug 2026 00:31:23 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Arijit Banerjee <arijit@effectiveailabs.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Arijit Banerjee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Jonathan Tan <jonathantanmy@fastmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Arijit Banerjee <arijit91@gmail.com>
Subject: Re: [PATCH] index-pack: speed up promisor link recording
Message-ID: <am_hWvag32v8yuNM@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Arijit Banerjee <arijit@effectiveailabs.com>,
	Junio C Hamano <gitster@pobox.com>,
	Arijit Banerjee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Jonathan Tan <jonathantanmy@fastmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Arijit Banerjee <arijit91@gmail.com>
References: <pull.2191.git.1785706396130.gitgitgadget@gmail.com>
 <am-7_wSb-GNefKlB@fruit.crustytoothpaste.net>
 <xmqqcxw02lao.fsf@gitster.g>
 <CAFwoC-6EvoD-u7oceETi90MJ-FQA2zihdkn1i1wckKfoYRTKOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eqBhlv20JJinRjet"
Content-Disposition: inline
In-Reply-To: <CAFwoC-6EvoD-u7oceETi90MJ-FQA2zihdkn1i1wckKfoYRTKOw@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--eqBhlv20JJinRjet
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[please avoid top-posting]

On 2026-08-02 at 22:54:27, Arijit Banerjee wrote:
> Maybe software can ship experimental versions which is more indulging
> towards AI generated patches? Brave users get to try the features and they
> can baked into stable releases once there's enough soak time.
>=20
> I have been holding onto my patch around hardware acceleration for SHA1-DC
> :)

The rationale, as Junio said, is based on the Developer's Certificate of
Origin.  That is a legal statement that a person has the legal right to
contribute those changes under the license and if they make a false or
misleading statement to that effect, they are responsible=E2=80=94legally a=
nd
otherwise=E2=80=94for it.

Considering the extensive litigation over LLM output at the moment, I
don't think anyone can clearly make that assertion.  Most of the
arguments I've heard are that it's fair use, which is a U.S. legal
concept.  That does not exist in Canada or the U.K., where there is fair
dealing, which is much more restricted.

If Company X includes LLM-generated code in their proprietary product
and it's found to be infringing in say, Germany, then they can simply
not distribute their code in Germany.  Git cannot do that: it's
distributed in Linux distributions around the planet, even in countries
subject to sanctions, such as Russia[0].  We must comply with the
license and the law everywhere in every country or we risk liability for
our contributors and distributors.  I, for one, am not willing to be
sued over this project and the project does not have the financial means
to deal with extensive litigation.

There are also concerns about the quality of the code and whether
submitters adequately understand the code well enough to have evaluated
and reviewed it thoroughly.  It's well known that when creating code
becomes cheap, the burden shifts to review and review becomes extremely
important.  That has been seen in lots of places, but we are an open
source project and we can't force contributors to do review like a
company can.  As Junio says, we already have trouble getting reviews
through and we don't want to make the problem worse.

LLM-generated content also has a negative quality reputation (see the
reaction to AI content in video games and books for an example) and
while all software has bugs, I appreciate the reputation that Git has
for quality and wish to retain that.

Those alone are reason enough for the policy, but there are other
concerns about the environmental impact, the impact on electricity and
hardware prices, the ethics of incorporating open source code without so
much as a credit[1], and a lot more.

So I don't think it's likely we're going to accept nontrivial
LLM-generated content in any capacity anytime soon and I don't think
trying to argue this or persuade us to accept it is going to be
productive or well received.  Of course, anyone can distribute their own
fork of Git with additional patches if they prefer, but we won't include
them.

[0] Debian, which distributes Git, has mirrors in Russia and Belarus:
https://www.debian.org/mirror/list
[1] For instance, as a member of ACM, I have to follow =C2=A7 1.5 (Respect
the work required to produce new ideas, inventions, creative works, and
computing artifacts) of the Code of Ethics:
https://www.acm.org/code-of-ethics.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--eqBhlv20JJinRjet
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmpv4VoJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ1/7wDmaGuYSFcfBMc50yEuNphv/oNGBauD3mBKhcw+e
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAJBkAP9LwfBWlzaSdmv1k1vKoo98RX0J
OHRodUyRPB24Uz5vgwD/Xatcm08/dxS8MKvhTNMaHd6a4fqDGWQOB6JBLXGhGgs=
=VvRm
-----END PGP SIGNATURE-----

--eqBhlv20JJinRjet--
