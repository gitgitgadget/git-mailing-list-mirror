Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73CE30AADB
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767694843; cv=none; b=MpN81Hnf9WCrQjVjXhSQWYHRJ0BhhGDAjR33DkPBlptsCWQ4/CErnR0KvWT/34+2LBlZUR7YMYtOLDMsJmmFJdEaMbPatKIWG/1NtlRMUNexzfea6fqvg0qIPzeHEKM7Yb1/sfN7NQD4tR3SeuWekNkEN0lzjEmmgGOvBzcM91o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767694843; c=relaxed/simple;
	bh=aPSCTrcVCzsWWJ4+OF5N4ix6lSBtqjQOIk9hC8RriSk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kti+pMoW/ujjLaig4vuIcmjNGp+Wq9p3mYxa8EnXkA/gw8uiyFCoYH+YthzECExJ6teLxi1JqxmvsGDZIyR4soFIcOASjP3Cc5q9pQ1GGcH/LjxWDiUzi2xkp5Zs8FXPufO4l1eqDJHWWMs7ZMjAZZf1jLyslS+hyGnktxTyGaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BfLwEo1a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kI7CyfTV; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BfLwEo1a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kI7CyfTV"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 23B767A0160;
	Tue,  6 Jan 2026 05:20:37 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 06 Jan 2026 05:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767694836; x=1767781236; bh=CuOnL33Jm/
	OvBLFBtVEW0p2XkAYzFV9zrVmGhrNZJi4=; b=BfLwEo1aGNip0FdHy/Rj8b2U8i
	2TbOlktmyynctMPmcFPfj7yANF+yfKkopUfhcKkIstnjLABq6nX7ZiJgakga+VQA
	6LQClJgKycCLy/4F47Omrpj21HJ7/z2zLLBUsVbK5jmD+s26N0Z5dUS1dWh+zCOi
	ltyB34GpxaSXq3cGquvtn7UCjVYGST1E69zxXkGwid0j7F2/8r6VONf+mdFBTo2V
	XueAnylTDnjK3VKjTm4nyGZl73TKFSJnKliGwv/JZiO4yeFtL791eRismmu0Ca0F
	Fne/79OJOPlEQnrN22REJ7+oCJNySRvNhTg4YWsNylKgy8YQsjM1O6gKGwXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767694836; x=1767781236; bh=CuOnL33Jm/OvBLFBtVEW0p2XkAYzFV9zrVm
	GhrNZJi4=; b=kI7CyfTVpVOAXPBi3BWas0kOMLhw/TjNTl5Tu9Q5UaN0qGIqj5L
	ADVfyjN9E0qEkek/k/SPOPRN/oAnyA4i2PE3MnGmRGFGbNtGX5ZUhaZwApa/zjFe
	LYX7tSmNQnJgU+3/hRoaJBuo/sk5HSCU2uFPAJOHw4bLIKcxeYEa2E92UzjRm47i
	uaAkguCynxCfHco4OUI3THt1vN7tSFaWoUu7s7J1sh1vozGTPjEyq5HaJRKTuFzO
	7IClHWR7Yz1z+f7D0Lmhw2t5IZRsiX4iO+BUZqBwlV00YE9giniQmXPb4G6vcSvJ
	7keHLibgJo/9tnPDn1oT89EYhJb1JDIAFYg==
X-ME-Sender: <xms:9OFcaekFmvFIUXd0nD0n3Dkf09MDhc68mpTD81CiejCN6eqrzmVvgw>
    <xme:9OFcac2a3iNV-OQvlOD1MPj5iIzyn3C7PRbJIUGAWG_zLEIzwo5SfQNJzQSwTNM6W
    vKYuAZPwjtNrAbIhZ1thpiVOE-IgkUgfK6pEHH0RFYq1prbZu3SWg>
X-ME-Received: <xmr:9OFcaRolwi3trPhGg0dyk0jP5zFCb1kXV_yKBftWz72o2z10t9K-Szl_DVPApYtwSOPi9xz1hIWqU0NHRi0T5OzY6A8lBjhCbIHn0t4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelleelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfe
    ekveetveevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsegrshhhlhgvshhhrdhmvgdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshes
    tghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:9OFcaRc2F4LiekTCn7Dw5pkC1dGo_VqqP9SqoZhjQk29T3xGURc7Uw>
    <xmx:9OFcaYrn77pWm4NFQ84auMkFwyNZHQLZq3HewgeaQ_WbWxUpuuRIhA>
    <xmx:9OFcaaHf-Y_8XeWmw919NEAZSG_JTD_d5fhArqJsxS6P2iNY5i3uVA>
    <xmx:9OFcaQvxpRqTJnyurFxUxrTM_zaXAsGSrkvvi3NLJwQiZuPxzt3G9g>
    <xmx:9OFcac7somiO1kUplbYMUvDxl9J1GkUHehhpCncryxz5HS2f7nNcOrHA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 05:20:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ashlesh Gawande <git@ashlesh.me>
Cc: git@vger.kernel.org,  sandals@crustytoothpaste.net
Subject: Re: [PATCH] t5550: add netrc tests for http 401/403
In-Reply-To: <20260106093451.748761-1-git@ashlesh.me> (Ashlesh Gawande's
	message of "Tue, 6 Jan 2026 15:04:51 +0530")
References: <20260106093451.748761-1-git@ashlesh.me>
Date: Tue, 06 Jan 2026 19:20:35 +0900
Message-ID: <xmqqjyxvjb4c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ashlesh Gawande <git@ashlesh.me> writes:

> Signed-off-by: Ashlesh Gawande <git@ashlesh.me>
> ---
> Sending netrc test patches as suggested in: https://lore.kernel.org/git/aPAg3gYwzA9fHCC3@fruit.crustytoothpaste.net

At the conceptual level, I am happy to have tests for features that
we claim to support.  It is a different matter if we want to support
netrc, though ;-).

There are some nits.

> +set_netrc() {

Style.  SP on both sides of ().  I.e.

    set_netrc () {

> +	# $HOME=$TRASH_DIRECTORY
> +	echo "machine $1 login $2 password $3" > $TRASH_DIRECTORY/.netrc

Style.  No space between the redirection operator ">" and
redirection target.

Style.  Enclose the redirection target inside a pair of double
quotes if it involves variable interpolation.  I.e.

	echo ... >"$TRASH_DIRECTORY/.netrc"

> +}
> +
> +clear_netrc() {

Ditto.

> +	rm "$TRASH_DIRECTORY/.netrc"
> +}

Should this fail if .netrc did not exist in the first place, or is
the primary purpose of this helper to ensure the file does not exist
after it returns (in which case it would be desirable not to fail if
the file did not exist when it was called, with "rm -f")?

>  expect_askpass() {

Ditto.

> +test_expect_success 'using credentials from netrc to clone successfully' '
> +	set_askpass wrong &&
> +	set_netrc 127.0.0.1 user@host pass@host &&
> +	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc &&
> +	expect_askpass none
> +'
> +clear_netrc

We try not to run random shell functions outside the test_expect_*
blocks.  A clean-up function like this is better called at the end
of each piece, arranged with the test_when_finished helper.

	test_expect_success 'do random thing' '
		test_when_finished clear_netrc &&
		set_askpass wrong &&
		set_netrc ... &&
		...
	'

