Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193A6381AF
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 23:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791589303; cv=none; b=Ux6BZ7CU9xKVJZadlw+kGQztELuZ7mlHIZgtPg0xlBjXfaUEIdxuQLfZoYoruOFMX7Ijf90ygzIsQ3E6KsoE7U71iPcgoMdiVsyqhh0HfzDyegKKsK4oypzuUvl4tLetnBJwQKOFAYlzciGfQotUsEwaI1GVQ8BEzjs4FcUkKU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791589303; c=relaxed/simple;
	bh=1dKyqa3296OCftm5MdcrSU1ckG0fRJmG/XhrhPZVFMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KMKVi0rmoO6NdKaM83D1Zv3Bn4CsBS1BefQSnyuO8hM9YIOX2wTglXRr4EXhRdWeUQGsE9Hvln2+KEOoBOTR9IX5WDXUq91iYMQ1AUSB8sPDJsNZXGUOT62FUK5NHF7rOXUfVkP732xTP+pAqM8td9DDM9gJik7WoclQ9bPKyo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HxG4EKTQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wijlrs/G; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HxG4EKTQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wijlrs/G"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 47ECD7A00B4
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 19:41:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 09 Oct 2026 19:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791589299; x=1791675699; bh=2tixwYkSYh
	8wztvdD2ub5Ovmx9wTFRGkoUS+9KxbDbA=; b=HxG4EKTQ286dxDytzjdzMIePas
	/Oye4OW9gulnX36qKw1BozlQJiasdcL8e/N+3MPliAwPQseN7s5vRgEtbIfKM3FR
	9j/TImU4ehIRRCOdSgjQ9o2m/p2Kcn6Ulj+xQRqE3E7LuQrsJhJJ6GySHAuSH1Ua
	IWCX8XgO635sGq+OJCDKDY8co5n27UR2uAJ5JRj2gO1rGO5bu1FbDE9wzVrMXrpC
	b+jp4iDaYwAsSjjMj8Q3SwkOSSiVGHWNuguz7jeyT026rNXB8RoXay6S2M8svkwi
	rlZJuspy4rdZ4zowabaAIHOSfcOhhGpCmW+dwfe4asoLQm7JPQOTNMWbxNHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791589299; x=1791675699; bh=2tixwYkSYh8wztvdD2ub5Ovmx9wTFRGkoUS
	+9KxbDbA=; b=Wijlrs/GpY66KucVEaroRnEfpUQYrk7rlrUQ3rvydcHZyk+llFk
	vAUwxrur60lrjJ3KNZh9F6RGzJXqcV5xuDPLc1e+eZNV9qgQZLtqYNBYB2uxXgQH
	T7LxBOT0rdWIF/GxBOYUrc02vbgVS02j7JTeC4pTPkMMXDaws9q6keyYc5C+AWR8
	RfdDLxWumvl2TmV2n4EHIsS2aA8eSY37DFiCUinb79Q0Lrs+UxeTMBJ4gwzLGmGg
	42REDAM2YHoUSUH6SVgjUpKfH6ilKckOmTi5D/JbDYvqOPZzqn1tp9yQTMDQZwOd
	tRhFkzoypH8DgsGyNtopAT3yR6tXJqwGeqg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791589299; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:UuIIGEkFP+IwbSBXDJ8DlNN4NzC3Xt9yVcnbiIACiSrpfnm
	XqN1lwnKFc8x/9z6cFCcwXkfOPoPCxHQFYpNbyT2Zjsks+i8qT2e4ymMfHfWYlcW
	HnaFQOSha6VJQB97wvSgh7aG/EiV9K7QiSQRBHep0xUjuI4VEpOwLnko12lFt4B2
	gDJWp0wwSchw8sr9cmSYvJ+De57THRt+qOl/YQ+c1ygQsoNRoLDGUmGenOQc6Vd/
	1K999jEhle7kGyzHjHQEJvvCogKKnqR5f667zdVBC7fUOip9mE3VEEdZ1XvvtK0G
	1anIzpLfohub4CmY5KBU/1SgyY8R5jUEC5t5D9Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:z4BmoG/eXl0Q/h7rOjcRlmAo5CnPa0J93NWqFtNMf58=:1dKyqa3296OCftm5MdcrSU1ckG0fRJmG/XhrhPZVFMI=;
X-ME-Sender: <xms:s3vJahoTS3SQ3JwMu37S2OKYjLAkmdoN2jT6It97y152DIcdUOekdg>
    <xme:s3vJal6C5h3rcBoFKATgGXJ7dzdpWjUzwM1KZfk91RmDf6AyVQ3jX0BqGv2_pxX63
    PM7ubZJMOjzDtev0TnwRr15vvDeAWVcWhhPzdDV0BN0yHkfs5mifzfs>
X-ME-Received: <xmr:s3vJagfSMXKJ88voMe_k9RJ8eQ9XSAJ1Mfn_nsQe1eHs8ZeCbq9mOqMxr2oTwauJJwCWKYocjhvJ2V8y6sD6C8PLh3ygh4vDLbCj>
X-ME-Proxy-Cause: dmFkZTGPYXN3Vr49wiVG0mEBYDgE7GZG93KjxTWYomJlCNDCk94Luuf6JAeSYmQUH21ziv
    ciXJyC1Io2sjOHvpp2d0cBhBn1HpuZlgjTzq8EmgnmaEzpHYF5LOY0HOZO5pQTKAyvv3Iq
    Bq8zgnIb2gR/TJ4izoqrl25LkA8WVjwyitYnuKPf8bM1LRNodeFCQqQGDp8dtezXvGN36V
    2jgfGKG8FxBfJqLWHpr3QJc8kizPyIEcqjCloMgQTJ02OOOff/SkLZ6Au1XNwXr1rLqdyZ
    FjbMgGFQTN+dr8M5l7D8un8zQNRcKPBYY5gpRLMXU+00Z/9uiGhUCULt+op6WEM8lKKUi7
    Zd01Eo0yYt1fGzkWl8jcI02uvAcvdzu75w51vazX/Ol5gyu72ZmQByEUVyPbxQo0A4ZONM
    CLTsZUuGr3G7q/OhqnaJQR7g9F6g/kvMVAEe1ATktTS4iZiARZ68MnOgJsFzBlx6qsqOOa
    cF9erECKjkAZIxp+irgpRe8qBfj0zi8a20lLvrmVZIltZseKu8VRdT6tkWaOvDAZ/fsST1
    gLhjcr2d9/a9sPTOyfqdCHUGBBxOIn3+RlRkU8rZDksOCa7JGE4EJfYCUH8bQgIpSJjQb5
    lMcJYyAvP7THh/whBusXBpE9jpiXHdvB/PHlwrJBxfLPGfuGboEx8rss/vOg
X-ME-Proxy: <xmx:s3vJai4lDKHlQBnYwQiEey37MG6vGVpdgTN289GLhoCBsnShpuORCQ>
    <xmx:s3vJavv8r-33E22B4nrEZ_iOqCeuJ_EXHEfG2iJ24UtV0FtqDX--Qw>
    <xmx:s3vJaqiY6YQxBhST5cF6rHwHdf3vIWUsvPr_8tM0OscGTi3ml6WXhw>
    <xmx:s3vJaipLV1UNlhMWJPWIFfiv3FvMrUqUt5H5MHJG4HB4d9y_OtHf1A>
    <xmx:s3vJahrhGZFOtSmnxJg5M1oYsc7OlD9kbrCeegxfeWuLHG0azkmXZbx1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 19:41:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Sam Reis <sam@opencanopy.dev>,  Sebastian Thiel
 <sebastian.thiel@icloud.com>,  Scott Chacon <schacon@gmail.com>,  Scott
 Chacon <scott@gitbutler.net>,  git@vger.kernel.org
Subject: Re: [PATCH 0/4] faster SHA-1 collision detection
In-Reply-To: <CALnO6CBbtKomawqc81MPV5Ngtc9J3M1ej4enGD3ZUzWnPSfsgw@mail.gmail.com>
	(D. Ben Knoble's message of "Thu, 8 Oct 2026 09:25:08 -0400")
References: <20260929112544.86511-1-scott@gitbutler.net>
	<xmqq5wzda0h6.fsf@gitster.g>
	<CAP2yMaL51H1OAG25nQ0NuLQLb0wevd4CicCG1_ezsJfrZDqfUA@mail.gmail.com>
	<79ae606b-cf99-4867-9db3-bcd7ff03626d@icloud.com>
	<CA+Te0V+-O3avrvH353KfCDjAEzMa=_H57G4OmiJ8+d1dDzZ6aA@mail.gmail.com>
	<CALnO6CBbtKomawqc81MPV5Ngtc9J3M1ej4enGD3ZUzWnPSfsgw@mail.gmail.com>
Date: Fri, 09 Oct 2026 16:41:37 -0700
Message-ID: <xmqq7bjqjvbi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> The sha1collisiondetection submodule and the sha1dc code (extracted
> from that submodule's upstream, if I'm reading 28dc98e343 (sha1dc: add
> collision-detecting sha1 implementation, 2017-03-16) correctly?) are
> MIT licensed, too, so there is some precedent for Git here. I skimmed
> what I could find of the original threads:
>
> - https://lore.kernel.org/git/20170223195753.ppsat2gwd3jq22by@sigill.intra.peff.net/
> - https://lore.kernel.org/git/?q=sha1dc%3A+add+collision-detecting+sha1+implementation
>
> but I didn't see a discussion of licensing at that time. Perhaps the
> idea is that we are clear that such code carries a different license
> from Git?
>
> Anyway, I suppose the fair thing would then be for Scott's code to be
> MIT (and/or Apache2), in which case it would need similar
> clarifications? (Or are we prepared to take the stance that de nouveau
> code based on existing code can be license-washed, in this case to
> GPL-2?)
>
> Interestingly, Gentoo claims Git's license is only GPL-2, but I think
> they compile in the sha1dc code since it's the default in meson.
> Should we be claiming the Git package (with sha1dc) is actually GPL-2
> and MIT?

In the abov, Gentoo's mention is about "Git package" as a whole.
Git package as a whole can be distributed under GPLv2 only.

MIT, BSD-2 or BSD-3 are permissive and essentially says "you can do
whatever you want with the code (including combining with other code
or making it proprietary), as long as you keep our copyright notice,
keep our disclaimer, and (in the case of BSD-3) do not use our names
for endorsement".  Specifically, they do not forbid us from
incorporating their ware into our project that is licensed
differently, as long as we honor their licensing terms on the source
files we got from them.

Because we have mixed "permissive" code into GPLv2 code to form a
single "work based on the Program", GPLv2 Section 2(b) dictates that
the entire combined work must be distributed under the terms of the
GPLv2 (and again, the permissiveness of "other" licenses is what
allows us to do so).  You cannot distribute the finished binary or
the combined sources under a permissive license, because doing so
would violate the GPLv2's copyleft requirement.

The original "permissively licensed" files (and any modifications
made purely to those files) still maintain their original copyright
headers and original "permissive" license text.  This is because the
original copyright holder of the code granted a license to use their
files under the original "permissive" licensing terms, which
requires us to keep their copyright notice.  We do not own the
copyright to the original "permissive" code.  We are only licensed
to use them.  So we have no legal authority to strip these
"permissive" licenses or unilaterally "relicense" those files into
GPLv2.

So to answer your question in the last sentence, we should say "Git
package as a whole is GPLv2 only, but parts are borrowed from
copyright holders who licensed them under different terms, and these
parts can be used under these different parts.  For example, sha1dc
can be copied from our source tree to your non GPLv2 project as long
as you honor their MIT license".

