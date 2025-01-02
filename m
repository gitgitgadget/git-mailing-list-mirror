Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C7D79D2
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735832400; cv=none; b=kNTK5R8yH8UZ3qInfwYmNuv65mtHAUMlLmNKOVxSj1ym6YfGOhWeu3VY4LlUgyYyQA6RubCVD63pvAzQOLb5q3YRnKvi4DrQhe5PSFWpxokhujHoarn8Qk16vx0DNdanmIbR5Au9pxwEnu9ZsETRuW4RmEstwNqXacKc519KrT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735832400; c=relaxed/simple;
	bh=xFBTGHQuPyWYtH7s/WW3KPwOCXuLn7Ab5z1CDnpJUKs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BihtRYUk5ufwYlsXIBEHuHFUjS2tpe5LLLp+vi0FDWUL5287uMMbpqZ0VwcQYQIH1+cKolysh5assirD7av8BDFBCLHRktmeR+YTzID4b+0/IdZKCWK0qItQYCOV825VflJd4WU3/XY6zctx1RIiR0o81OoZzzsjMXmZHuzMqwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0DJbvlfp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z5MDhyWb; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0DJbvlfp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z5MDhyWb"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 943FB11400B6;
	Thu,  2 Jan 2025 10:39:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 02 Jan 2025 10:39:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735832396; x=1735918796; bh=wPWGy006Yp
	EJ9zquzQt8MYcDMbkb2iKF0FF3eURp4uU=; b=0DJbvlfpmei3wBoE0DZH5U7Il6
	z+0cJqMwsdln8MykZlE4uwIy3i3RmHy1UPbvTIy2kOL9q9oGZxKDdLjGrhE1gykO
	4DFPVZ2qxVoZN41QnQsKIBNt+SpJuAT1cLbVNTD534FFCqHO2vQKGQQJQQ+KUJU9
	gH61laqwjnuL4dS1wXjctELJy9VUD6JcfaPhV9g+yXY8dVgYjBJDt21Bd6zY4LGG
	e5ITGe2fSvkrmHTHyZie+MnTmea+/A9IZQVtQM7WudS4MJkJdQpjBJ/dOQ9/2USP
	VdzR3hjPbb6D+lES9LT1WP1RYkhdh66Vr6w6/fEO3sFWnSAdz23v4MuCpHDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735832396; x=1735918796; bh=wPWGy006YpEJ9zquzQt8MYcDMbkb2iKF0FF
	3eURp4uU=; b=Z5MDhyWbZAE8sEoCSmTI3/2urRSSZpLKn5kiWUEzLu6WQTmhEaW
	69rwiLZf8VnCKwWLGUm8nofxObOES3c8M9mXDeS4QxNwhieJtnkxKXwpmxIhyoa+
	/425ErjVAFR0b9ONduW16HycZBOGsEPSEkAHSkVQ9w6ItMLL/YwqJ++PvLt14Nel
	7NtJUEcLJECf2Pu2s29qb7ndM+cdKc1vPh2u/McflQWSfbklQVpk+K13ROM8bdR1
	9NNHvceYS/OjhnB7mdYCRlNvtcR4hXFB9HxLI4xblFf+6K8KlWZ1NED24VQwVihh
	4wlxd+ERZknC2WFlxFai4QUGgzg/xRxiIxg==
X-ME-Sender: <xms:TLN2Z5k1lDVfmzCD1NYHTSePDMlTDiQtB7FMu4ucbbo6PYKJtRacCA>
    <xme:TLN2Z01kRFfAmcHO2FTWxjLEWjVWwuR6Ya-eFZO3_YTnW745dVxKdnY7DPW3slwuj
    6oeU0dFUaNJtSKjrA>
X-ME-Received: <xmr:TLN2Z_o6mM7YNiRkq0ak9iXaUurG0X41aNpjsFTKI4EmOPpyO7aExHpdYdMF8V6RWHRhh-XQej2zWstAJD33gIqp49KJf6KUpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefvddgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeekveet
    veevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehjrhhnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pegrnhguhidrkhhophhpvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:TLN2Z5kkKStOAumSAJZe8R7VvCc4k6-hcI8w72qxDT8a6ANzhdFrQQ>
    <xmx:TLN2Z33Ptf6tp2GJum2sbDV8VB9zT5Al8hETT8x2hVKaJ5kMRI16NQ>
    <xmx:TLN2Z4tC9vk5JdfiZ_E9BQG5Y3S2-FH4EBOnuNXBgCRj57895oR_cQ>
    <xmx:TLN2Z7XIZAJJiVJ-Y0Ru3i4bE_3lHpuxIxP3m3hkwqESInu8mzc3DQ>
    <xmx:TLN2Z3_CqyNuLHlMUbEXow1so7y2jjXF-zQS8sGOsxbQrJYG1z_0BIaA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jan 2025 10:39:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Andy Koppe <andy.koppe@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: meson-test syntax error
In-Reply-To: <Z3avRmaMr70FOs8A@google.com> (Jonathan Nieder's message of "Thu,
	2 Jan 2025 16:22:46 +0100")
References: <CAHWeT-boK3x6mup11boEinNDQiAxxf0vwvZkxsGRc_GRvXYA8g@mail.gmail.com>
	<Z3ah2YQSx4ZreBpK@google.com> <xmqq5xmxwabj.fsf@gitster.g>
	<Z3avRmaMr70FOs8A@google.com>
Date: Thu, 02 Jan 2025 07:39:54 -0800
Message-ID: <xmqqr05lusvp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>> Andy Koppe wrote:
>
>>>>   make[1]: Entering directory '/src/git/t'
>>>>   rm -f -r 'test-results'
>>>>   /bin/sh: 10: Syntax error: "(" unexpected
>>>>   make[1]: *** [Makefile:119: check-meson] Error 2
>>>>
>>>> Due to this line:
>>>>
>>>>   diff -u <(echo "$$meson_tests") <(echo "$$actual_tests");
> [...]
>>> I ran into the same today.  Let's discuss in the review thread
>>> (https://lore.kernel.org/git/20241213-pks-meson-ci-v2-5-634affccc694@pks.im/).
>>
>> Probably this one?
>>
>> <20241227-b4-pks-meson-docs-v2-11-f61e63edbfa1@pks.im>
>
> Ah, yes, that's the one I mean.  Sorry for the noise.

Sorry for being extra sloppy on this one.  A patch like that with
blatant bash-ism shouldn't have slipped the review process.

One thing I had trouble with is that, with /bin/sh linked to
/bin/bash, none of these

    $ SHELL=/bin/dash make test
    $ cd t && SHELL=/bin/dash make test
    $ cd t && SHELL=/bin/dash make check-meson

seem to fail for me.
