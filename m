Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16E81EC01D
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 22:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755554825; cv=none; b=XVInF28VSmPq3LxNtTjXULgxiEXwLujCWWpBl37wBDlD0Bx2Yt7kB9OhiTHPIhCVpFfvxw/9VH+JMcrQg//vvGR1wUy7hztEEn4wD65td1l896YtzfaTKty+Ntl8O8II3/FegqrMT6gbgZVlrRaSEBhwyONyCs4NMIxRtz6aJ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755554825; c=relaxed/simple;
	bh=vuwaKrVZ7udI+ylsakWUX0K04PIfCJz8R51UuuNS8Vw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EagHUzKtx9Z0ikQbQodRkiVo+cwK7wvzNujUd8R23w+gvbeymbnc9Gty402lGMy8V9NQ384iNcfxzF/5jtR0aTU09vIhwDE7Hz0eKsqbyV6XR7dZat30GblVfZxVYB8+KvFHLmU2bBunP88JEjwgOMJPJLXOelMHQqEhgwxZKeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IpInWoYF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hWfB/cTH; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IpInWoYF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hWfB/cTH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 580661D00071;
	Mon, 18 Aug 2025 18:07:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 18 Aug 2025 18:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755554821; x=1755641221; bh=DF93BO7EL5
	EdAMGYsCvuKjimpM4iMIi+p5UPSeP1V9I=; b=IpInWoYFsXAyzuarbe6BLlD1ny
	0miu8TDwBNwI5njMlT46m31vRf56fPK3F0jHpHKAeyXP0oltH89BqcHNcbkBlY1u
	dpQNnD8lVpsOKJqw9MJ+Kw0kfhLqhP6akQ7lLS1DmoOvmNG7+zI8n7tUjngJ+M80
	17LXGURGJgKML5l+Z7vVqS9ZJgsq+Bedwof5UL3eL0fspwARmQ+Y9vIFSeUEZ3CY
	kdGFiELFOXXqPK9knwBAy6G3aWpwxL0peX7o6SR69nILqmAW/XrcdjGH86xrBbb/
	0U2J0ElN7qaRSO4XWzK7Rma8Hg+VDdhucn+RnGc3c8pobuIdPbQp5NLdH1fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755554821; x=1755641221; bh=DF93BO7EL5EdAMGYsCvuKjimpM4iMIi+p5U
	PSeP1V9I=; b=hWfB/cTHoJNZsAvuTpsq07esbhljPfEPVQoUcCn2m52S0arxr24
	gRDHvEl049E0dwsN/NqbRyK2oyLAbjvFAxomEupPP42hSX/j48d3weLd1vT8xJdE
	dkAaUYLeCZ9DV28dPELsFCIlPUG/MvAWSXdFwqt3h5muSXxrqCNnDBmL5bHbsVY0
	/R3jA6OlURmaFF15QTvw09z6tXX6BewLNK7txppEVTZuCtxN62NKhc53l/fmxXnh
	HQOo8fmaddHhTlCvPVXijWao2pDrJFwb3Z77trQbX8BrYZXq0ZOquziy9cXCso/A
	J9SsV+m4xoDXiMHYL0hYbfljW7mgqMVYtVw==
X-ME-Sender: <xms:BKSjaKQp3lmE50IlfTcINwoyQwb1lTR6vt_JwSuEk9Ml2YGK4X_A9g>
    <xme:BKSjaLdL1-vbz7E143nMZgp7nhy6zQeI6g4TNqkWMsuvjxP_Nqt9ePBIXO4tag_wi
    wP9xiMPHboN7cinwQ>
X-ME-Received: <xmr:BKSjaESo2oef4-zQLlIpy4hjCjR5fg3w8XGZmdo5G_FCTksdajbLC8CD3lFj0r35loLLU7tKF4eHFrAm8bD_GYxHQzsALAUu_rO-HK8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheefjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsoh
    hrrgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehruggrmhgriihiohesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopegrrghrohhnsehstghhrhgrsgdrtghomhdprhgtph
    htthhopehjrhhnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehssggvlhhl
    vghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhm
X-ME-Proxy: <xmx:BKSjaPKUFL67OvqrKHYdnRU-FWEvlxvHYBeR5DCJhr-hspXsssskqw>
    <xmx:BKSjaJJOr3CZFBAjxHfm6hqobsb5jRPzd2xzb2fsaeRGCkEy4FHvzg>
    <xmx:BKSjaCgJlBks9Y0GZbZZH4D_EtNEkVIidPixKUwKNyuroLVV23zA-g>
    <xmx:BKSjaLPmk8dS9crP8-qr7iUQRoxMZdpQgPHUxhcGGdj4qdhhtVFVvw>
    <xmx:BaSjaB9ff9YMqfdFzN_yHRd4_AmSnJh8hK-lRGpG03KJMB9XB5Kpf_Gs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Aug 2025 18:07:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Rodrigo
 Damazio Bovendorp <rdamazio@google.com>,  Jeff King <peff@peff.net>,
  Aaron Schrab <aaron@schrab.com>,  Jonathan Nieder <jrnieder@gmail.com>,
  Stefan Beller <sbeller@google.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 9/9] t: add gitdir encoding tests
In-Reply-To: <20250816213642.3517822-10-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Sun, 17 Aug 2025 00:36:42 +0300")
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
	<20250816213642.3517822-10-adrian.ratiu@collabora.com>
Date: Mon, 18 Aug 2025 15:06:59 -0700
Message-ID: <xmqqplcsgu7w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> Add some tests to further exercise the gitdir encoding functionality
> alongside the existing mixed directory and nested gitdir tests.
>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  t/t7425-submodule-mixed-gitdir-paths.sh | 52 +++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/t/t7425-submodule-mixed-gitdir-paths.sh b/t/t7425-submodule-mixed-gitdir-paths.sh
> index 902b2560ca..cfdf487a56 100755
> --- a/t/t7425-submodule-mixed-gitdir-paths.sh
> +++ b/t/t7425-submodule-mixed-gitdir-paths.sh
> @@ -152,4 +152,56 @@ test_expect_success 'checkout -f --recurse-submodules must corectly handle neste
> ...
> +		longname=$(printf "%%%0.s" $(seq 1 $count)) &&

Use of 'seq' gets complaint from

    $ make -C t test-lint-shell-syntax

See the commit message of d17cf5f3 (tests: Introduce test_seq,
2012-08-04) and b32c7ec0 (test-lib: teach test_seq the -f option,
2025-06-23).  I think you should be able to do something like

	longname=$(test_seq -f "%%%0.s" 1 $count) &&

but I haven't even run the test with such a fix, so take it with a
grain of salt, please.



