Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28282DB7AD
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770828764; cv=none; b=RHgOgfHR//aDt9n4kh8YRo4wBkaCySjSDZCFOaP5ixLOvf27Ipc8dPDAqQT9ErG5riCUpU1M3hZeVFUl86+QK6v5tEVY8rl/4UA+JXu0I/DAHXHzz4zua53eBV55i8reQUVciZBZEGbtWnuIYabn9ZgjaMBG+YQAkODcK7IvQ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770828764; c=relaxed/simple;
	bh=yI8XLX6sAV+cPdNJ6fSpAuCu9lhASGJMFh3/fa5p2pA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IFMNhelWTLPIabEsa8H9MaAY9z7GvOn+Dq183vtHPf85Ud5T7iwem6TuY5tTUvU6G1nPq6ecs2WCzOSehQT8InObSo44WEZHykHxSToe6ShgARq8abXrWxBPxr+s8P1K0PlmaC5xlhXV5ADSt9k23snnhtrYBWLuHUL2OAk5uSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b1micj6w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Aes239QH; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b1micj6w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Aes239QH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3390B14000AF;
	Wed, 11 Feb 2026 11:52:42 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 11 Feb 2026 11:52:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770828762; x=1770915162; bh=d+lXK1+E9j
	eAG5vrZWYpmquYp0M3gzxCvrfJPWRafWQ=; b=b1micj6w8w37jaVV8FgvGTO9CR
	yaM4Q0iXSHLqDJFEtGiFkpXDvd/AEInjHuJLd1V2j6432lDUBPK6FjMSqVK/5PqZ
	rmGwwWGxl2HMRgQ4FpLNjuAq9MeAnTIG3FtOfZbPxuPPWcm377++xpjePjSsdLdG
	xd8liXcVyRAMoSXkb7/+yrdFAwJRsOXe1tTZZXBvx3DbPwBt83dq6ruTFrEPYtkq
	XOUFBddFhVVSZwRxN/sEvdFZi8IqQa/mDz5Gp5trr06MdAUuWg3lVru8JeRPN3S+
	hxJtQPequG1I1bI6u4lvJAuDVeTpjTil1DlF3mJXFTZgCpc3C1rmQzIHeKHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770828762; x=1770915162; bh=d+lXK1+E9jeAG5vrZWYpmquYp0M3gzxCvrf
	JPWRafWQ=; b=Aes239QH/AF3xEjSfXCOT8RITChirBSqZeNLvyq0JpZG3E+hwdb
	Xks1hY12afL6NwNegjNPKwobTdKRSe5bV1jormeixKj9gf5JFyMDe2lygrE3MUhm
	2ze+9FLRCgaz75lvaEq87gtSKWUEiGRuhDE2ATWmsIWFTYwVAw1Xf/8Ubww+PR0C
	/hml4+b/MjplmM4DwPP9uaZbh0GaMuRNXQBWPoV1rch2tnjSa2tnFwaDDOfklHi+
	t7nwOPf0dAnkcjEjvnUm2Nsig6e/1BKbJygaIEueCPmR0i4qMWzgIWQ8kEwraWoD
	A64wRJ4W9o/teD+JpYiQvKFJgCYm22HOY2w==
X-ME-Sender: <xms:2bOMaXrc-nOvrEBQwwkT76Tj_DQmJU6gkRVznc_kgh4KqTc9tFJC_g>
    <xme:2bOMaYhiiuuU7n0O-udO3LfNcijTi-hpUP8oPiNrE7x_fxQmsrlVC8zxU9ogiO6FK
    i6_s4mGTmgD_fXJnXrKcl5SCKNfJjWnQnH9BP2yEFmavE_XsC-p>
X-ME-Received: <xmr:2bOMaci25Ab_sJ5GjPJDfzmgRc5WCcny8I4pK02qS8_MnA0Fh0TvsfY1rqLjFkxkHs5p2l7NFsapK0_9-W7kjvEBhPXsuiNw9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdeftdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:2bOMaWitmuEMcSzSQA_BFR2i38iwrKu0kSZjcEplwozpRh1rtc6kAQ>
    <xmx:2bOMaUICnUcCgAJoNUyoD8S0RKuHlO5wCEgMvpF-dkayZ-0bCjloVg>
    <xmx:2bOMadGbteLTN4CK9OjEKcXm6TheJauZ7lIcAOAWF4JAA1j_HlKp2A>
    <xmx:2bOMaQRmNuop2n9eC7UCvtpUiI4aPBbdSjIfmmP6PP9q8G9bciQnpQ>
    <xmx:2rOMaXA-DDy1wCXAwD9Hbf9TjxkqLK6ZNd2rWZJIJcD8evjgy_nyeCeV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 11:52:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH 0/7] Some assorted fixes for GitLab CI
In-Reply-To: <aYxf_S-tkgESckEN@pks.im> (Patrick Steinhardt's message of "Wed,
	11 Feb 2026 11:54:53 +0100")
References: <20260211-b4-pks-ci-meson-improvements-v1-0-cb167cc80b86@pks.im>
	<aYxf_S-tkgESckEN@pks.im>
Date: Wed, 11 Feb 2026 08:52:40 -0800
Message-ID: <xmqq1pirw7c7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Feb 11, 2026 at 11:34:26AM +0100, Patrick Steinhardt wrote:
>> Changes in v2:
>>   - Fix syntax in GitHub workflow.
>>   - Add another patch on top that fixes win+Meson tests in GitHub. Those
>>     tests didn't execute at all, even before this patch series.
>>   - This uncovers another bug in how we set up MERGE_TOOLS_DIR, so this
>>     results in another commit.
>>   - I've now tested also tested the changes on GitHub [3].
>>   - Link to v1: https://lore.kernel.org/r/20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im
>
> Oops, sorry, I've screwed up this version a bit. This is supposed to be
> v2 of the series at [1].
>
> Patrick
>
> [1]: <20260209-b4-pks-ci-meson-improvements-v1-0-38444dec4874@pks.im>

Will replace.  Thanks!
