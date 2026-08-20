Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3865F370AFC
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 02:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787192301; cv=none; b=f4X3a10KoaMLa4ceoi8noDBxdxCYC4iDsB9Xl+Rsfz1ZJre7YYZoch131+VhtqX9a0nl72cWSeuJh6lFPZ7Ehlk3m2HUSlPPyEd+bW38F/cWwz2J/mLTW4JFCktyoNPEzqntjyh+UiD3p8PiW+PfFLB2/wy7oIwvKuZAA4/lLr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787192301; c=relaxed/simple;
	bh=T1RfDQuyanpLfSM6w7ZZzCzvQoKLDYeB0KBJEvpnC8M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XqVVTFzXgIev68G4mmvfkTRoakklNvKKDIybZHHW0kNzhyr4bP8sWZuzLO6ExFJBxjsxqLrR+mMvaBE47JT87yZ1yq+LubsQ9GwuQiwyhishaoseqXpSYBtUv5zqOgfuf8HzmFZrmtFPM92CBc/moO+AJdHeFq2r7C4qbOvyvy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ikSSZRAj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IGKidTso; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ikSSZRAj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IGKidTso"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4D8B9140014D;
	Wed, 19 Aug 2026 22:18:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 19 Aug 2026 22:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787192298; x=1787278698; bh=it7ZAc11ln
	Mfl85fod1XF/qsO6Vg3D7dn+C/CTak1us=; b=ikSSZRAjCGrEEwjG3huM5OPdgZ
	HvuTdB2Yvc9VkBAx54MDZgb0U1kwgLAHFVKNhqJUIBGzTw6WIEUO5I7MJPb6v/cc
	mFj5FEYOJ/HBeDBXgGFrmWglIivQAOoJjc8YN1nBSbhUvpGstSguBBHbzuY2wNLd
	0tV44yDduoTA2mL+cCSB2IkMw74AeVjsT9OYcJX5JPJzWOOa58EPzuP+yd+yBzCd
	KPY1Mpp32hBxJLQKhQ05g79MdNKzJooArEHZ4gQZ04orxxQLh6w8xB77HwbgBLqx
	bNtcX3RO4hxJlNKr54yZmZyH3wod8bFhvh8cGHpAV62YD8ufdCZtW7FkwjrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787192298; x=1787278698; bh=it7ZAc11lnMfl85fod1XF/qsO6Vg3D7dn+C
	/CTak1us=; b=IGKidTso6bkAixZywBav8x4IwKvSfgnCQUWYKhc1E6QltI2dhTY
	e0bmMtyR1dHqYo7w42ms/+qiwhulXYh2v/9VaM0DSHX0xqrDJamsAdVCBljO8UKv
	8S38DAt6D6ThRkPhzlWv15YA72kQ5dsvp+FO04badqYQ2fsS2DXuQqCUXdx+UjvD
	rsijJTD22HLDppDGRcX7hffLUlM0f6McH+1VY5RoLEnJ4sOkpWXlruU9mGMVqF/z
	Rki4L4uAZfyvTwKFfURctl00EfQAsEpc1veWCHeF4yf83CGfN0/TpimLsh4Z6iA3
	4pd3VyO+iT21hA52b8LEV3XnZmTLCxwSDMw==
X-ME-Sender: <xms:6mOGagGMCvgcKHhBMjixzvX8caq9yBP6jRim1wwlTupyF9ikEla83g>
    <xme:6mOGatDDo_zm1aP1Fw-zc0k8eblwTi5Vzr5VrCvqaSeZQTi_pw-EL04YyekNCCTMi
    6N7S54fCuJTpq5Jvtg7ztXAx_c2-P480TTZaDBRY1RsBycnx3HP3w>
X-ME-Received: <xmr:6mOGaj-aKuADwAms_YI6x7rlr-kQ_qfvAPOoL8JXhVPhWi9P6GU3O-UuUMIwUCDqvp5ImLG6wrc_BnhE9vwcPd36SW9s5OfvGg>
X-ME-Proxy-Cause: dmFkZTFO1pydFjZN2QJPTaJixNgkmrkXRM7tVBL/9g1Re1tHv2ZU59g8NwNuzPL9rvD3AD
    9igExLQ90p4IPRUey0nIkSCnHHbcbmCA1O26R5fElNPipy3j9WHZhgRijOlb479lZ5xgsk
    8kr07+lyQ6Rjg7ALpTqdUl+k7V1Km29obiHbhHfswCUtBpC/SQiu7YNV/RY7jIo9wuw6P2
    Ovqj///ev691r4FoHHrgs0xd/trbJPrcablLLtVv5sXLx41Z56L5ZTQ/YcRYm1f6PlsKcn
    fEqk9CyZH/r7sUzBwMwFVAYnwXOzEuKXiJIJpSfVHsvihXNJteefpcbN0pKKtREH/FQTDF
    yBZy1l4/sgZcW/+uT19vLHYWkZ9X2IVtyElQzhTuJRYLmolqFDShI/B2He1GB5EljpbeJd
    Jm5NU34HexsKDLHuoINnq2BXub6EVbfFb9hJm5/CdXOgxS+GKeqaX5U9IlGZ+iYqZdSZhl
    uH2w78r7L5D/fcr6IwTLVwatsdbXIGXtA39Tf9JAhkBbmDF07sKKiJR/8my6Imcf2SfgyK
    hbYd71akfACSeWA2S1Cd6pmxyOrPFHlFBIATVHKQdbM0/gcomk4diicQdudgdcmg+dYsXs
    +BA9rfgi8Oh6stlvgB1EbrOwK/VBFMPt2AwWC2MFeZySZg0K1GhbOkfX8Utg
X-ME-Proxy: <xmx:6mOGapC2uXDN9cQmlEgXuWr_MxfQeqhkZ6J8id5Q5vC--Vv0JpDMRA>
    <xmx:6mOGaoTqTWytkUVZqhx-ScTxJw_OlRxTbo7cA2Jq1c_HzGA8dhwxSA>
    <xmx:6mOGaguRv1aP4ozGdJxphcCvL4pyJ5pMrALhm55jsl6RKSSd97Mk9w>
    <xmx:6mOGak0aDVoTeNPykuU6mY49c7syI3ZY_6QRSCk-ubLVFGTny73l5Q>
    <xmx:6mOGaqpbsFDbMy422adVoJ2JjOE1_EY4hLTfl4ZP5dgc0eR5p4JJ7FJd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 22:18:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>,  Yoichi
 Nakayama <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH v5 1/2] checkout: improve message for ambiguous remote
 branch name
In-Reply-To: <CALnO6CCQppTnw1Y-6ibmcko0dM3hy8riPanD9BNyb+MW8a5nAw@mail.gmail.com>
	(D. Ben Knoble's message of "Wed, 19 Aug 2026 18:54:02 -0400")
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v5.git.1787143859.gitgitgadget@gmail.com>
	<b838fdabb7cd0d044294d54fd30cb51f040505ad.1787143859.git.gitgitgadget@gmail.com>
	<CALnO6CCQppTnw1Y-6ibmcko0dM3hy8riPanD9BNyb+MW8a5nAw@mail.gmail.com>
Date: Wed, 19 Aug 2026 19:18:16 -0700
Message-ID: <xmqqjyplttzr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> +static void be_explicit(const char *branch,
>
> Be explicit about what? Reading below, a better name might be
> "advise_ambiguous_remote_branch_name" or something, idk.

It stands for "tell the user to be more explicit".  I agree with you
that the refactoring should be done as a separate step, on top of
which we should add the new feature, i.e., "give list of possible
candidates", as a separate step.
