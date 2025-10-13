Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E045F34BA34
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379289; cv=none; b=CikiwimQ3PV/34Fcy3CaklpJ22ysPv5T6HsIBc7JnNgjCqiTp6YyP23je5Yb5QF4X7jHcIsYXPOmvUrqvqbzZMcjcw6Czx57hZ2H5EUmC8VAf1YMiGwhG0MPZa2uMOlzriaaVWXYsQpfzOwMbhk5L2YbkbFbpK5TJ66uBGxvXTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379289; c=relaxed/simple;
	bh=+RPzheWueHZ8d+S3qjHuhgHzOF1Ceshf1ROlCg3XMgA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tLcTVNpHuvi55va115i6tTMUjzBzsJm6GicHSRPHz5j4AV4M8+GX9fUYYW/Cge/O52dfcZBgat9MdRK/gY4bwtnW+znX1uH+b0Su/rkiW+hfd+FKkfz/ZGRUI7cSxFqzcQPsRunVauQQZ93v1tmJr+QWv0B1eeCVNJShTvgMym8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gS3CT+/l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rgf4P94G; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gS3CT+/l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rgf4P94G"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AEF4C7A0630;
	Mon, 13 Oct 2025 14:14:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 13 Oct 2025 14:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760379285;
	 x=1760465685; bh=8Y2JF0kW4bWJmlNf5hfrleDNaHLyOIt6HJVITmrvAKs=; b=
	gS3CT+/l2VE4S+fhmOdg5xmO2mIqgSC4o9cKh/0n/SjXTCRvkwrmnG+DpwVX4lwr
	I0xxDTCEqHtCTLgKFJdvnzzYTxHQVtLxWbvQk3DZrrs+MtvttNV0MuRCOXSuWcy2
	B4JbXK1QyuOPyq2KX9o6yjOfI4+pr/2SZJ/mciCTR7ww/4UrF9cmomAzVgIZZfvP
	iOFDSHA59qWdAFBKNTnV/XHokZsEVVPqJllZhU81L4JhVHeCtYQB1vpYUN+6QZUe
	5waNLrRyLWrS3bmeifgvZgb/b8GISKaWc98XJvixbH0o+iZZIbh5mjn4pCO2j5GY
	MMoN+sSV4wACx8Q0aXWjiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760379285; x=
	1760465685; bh=8Y2JF0kW4bWJmlNf5hfrleDNaHLyOIt6HJVITmrvAKs=; b=R
	gf4P94Gq4OGAy0DMVIytfdGpdPFh+B8rEIgLqFdfz21mlOM+s9I8pfe/294CAyG5
	trr/azIRhlbFOfFYtjwkC6pJvyQPeNfYJhcfnwj4x7TKFHsrdBBd6SaHGX9O5Bum
	+lC5WzcLvKQDRsW8hd7uCGJk+lKx9YGrTFDAmaocB8HBUcaNYBf2t0E7bB47yNm6
	OLSsQAuSb/C4MfC9K8FaZUkzfmU4w9LufWztNx9Fx2slhiJTS15DSuhTfs55Olqf
	YOLguDPxJk+oYYNUimBPy60tqQlgZRqvSG0JlZneVKhESC9yI0b5zD42QH0VspPM
	vAt14x8cfGpmD+PIa7lVA==
X-ME-Sender: <xms:lEHtaPsAomuXqvBwG_qsi2qUIya0quqsEjUVGhxN5utHEirJ6Cpj-A>
    <xme:lEHtaIr9sbRv8N71xKF7ss45eeyyEgWG_1-3QwRTcnS_RsU7yFt_sjjA6COcojsQh
    KF1mlnUbsCXwT8UlhDNP3XtufYNcDXMfv9auk9OGLdSTgDfF8c67Ag>
X-ME-Received: <xmr:lEHtaOWxRcrzhF72ZxmJQP6_f_zKdLRNjNWSr0ScNEOo5CvxvO2Vxh1M21M8oVkGIizY94zGpwj2LXIjz2w6-jUkmgzdGro6UQNW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduuddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhp
    rghsthgvrdhnvghtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvges
    thhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoheprhhitghksehsfhgtohhnshgvrhhvrg
    hntgihrdhorhhgpdhrtghpthhtohepghhithesshhftghonhhsvghrvhgrnhgthidrohhr
    ghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
    dprhgtphhtthhopehpshesphhkshdrihhm
X-ME-Proxy: <xmx:lEHtaI0CFbWVuDkL43MMfQC2hst-DIW7HBZfnbgwBdP7aE0fdNIBig>
    <xmx:lEHtaLsHh5HJoF_HjBpiot2tp5WgxM3p-vGfnwH7T9PorJi52J0ltQ>
    <xmx:lEHtaIUfuYj89m_w2R260ASdqRrZ2SoeRhWJB61pxGfS3Z-8SdUGoA>
    <xmx:lEHtaLwEi71DEI62ZAnuWxTf1Mf-ftPqLKUInez1zlf8UPVX4rvQNQ>
    <xmx:lUHtaN9_2V03TCDWpnaD2eRdVOdSfTaJkn6pj3Tu45QD2vLzdmyoI0Ib>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 14:14:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Elijah Newren
 <newren@gmail.com>,  git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,
  Rick Sanders <rick@sfconservancy.org>,  Git at SFC
 <git@sfconservancy.org>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Patrick Steinhardt <ps@pks.im>,  Christian
 Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] SubmittingPatches: add section about AI
In-Reply-To: <CAP8UFD1Bc0bRdty9O0et9T=UL9FtN-g_K3DYUmHUR31waTQ+GQ@mail.gmail.com>
	(Christian Couder's message of "Wed, 8 Oct 2025 11:28:44 +0200")
References: <xmqqcyalm0mh.fsf@gitster.g>
	<20251001140310.527097-1-christian.couder@gmail.com>
	<aN2fG-nS9fE5-2jD@fruit.crustytoothpaste.net>
	<CABPp-BFcg9M=XjqGPd+akrUOqJqREBmE9+NvO1Q05r4pUcOmEQ@mail.gmail.com>
	<aOBMHqLxNd86vgjH@fruit.crustytoothpaste.net>
	<xmqqh5wbq5z8.fsf@gitster.g>
	<CAP8UFD1Bc0bRdty9O0et9T=UL9FtN-g_K3DYUmHUR31waTQ+GQ@mail.gmail.com>
Date: Mon, 13 Oct 2025 11:14:42 -0700
Message-ID: <xmqqv7ki1xf1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Oct 6, 2025 at 7:45 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>> OK, so here is theirs for further discussion minimally adjusted for
>> our use.  I do not see much difference at least in spirit with what
>> started this thread, but phrasing is certainly firmer, and I have no
>> problem with it.
>
> I don't think it's a good idea to be too firm. It could prevent people
> willing to follow the rules from doing things that are actually
> acceptable while it won't prevent the risks from people not following
> the rules anyway.

>> How contributors could comply with DCO terms (b) or (c) for the output of AI
>> content generators commonly available today is unclear.  The Git project is
>> not willing or able to accept the legal risks of non-compliance.
>
> I think this could be understood as if the Git project is responsible
> for contributors submitting content they should not submit. I don't
> think we should go into this.

When the project distributes work that it has no right to
distribute, those who claim to be right holders would try to make
the project be held responsible for it.  It is a different story if
the court agrees.

> [...]
>
>> This policy does not apply to other uses of AI, such as researching APIs or
>> algorithms, static analysis, or debugging, provided their output is not to be
>> included in contributions.
>
> This is not realistic. If an AI does static analysis for example, it
> is likely to suggest a fix for the issues it finds. Hopefully the fix
> will be the right one, so it will end up being included in the
> contributions.
>
>> Examples of tools impacted by this policy includes GitHub's CoPilot, OpenAI's
>
> s/includes/include/

We are not in the business of typofixing QEMU policy.  Send that
patch in their direction  ;-).

I do not have strong preference either way.  Even if the wording is
firm, it is really up to each contributor to honor the guideline and
be honest with us.  You may see autocorrection in your editor fix a
typo for you, and more advanced tools may offer to rewrite what you
wrote, whether it is prose or code.  It is very plausible that,
especially for simple fixes, the result may be what the contributor
would have arrived on their own anyway, and in such a case, even the
contributor would not even know how much came from "AI" or simple
dictionary, or if that AI learned with things you should not have
seen.

So, I do not think it makes too big a difference in practice whether
we adopt the QEMU with minimum rewrite, or the version you posted.
As the one you sent is in line with what we give applicants of our
mentoring programs, and it was read over by our SFC lawyer, I'd
prefer to keep the version I already have in my tree.  Not moving on
either, I think, is worse than adopting either in this case.

Thanks.

