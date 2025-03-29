Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD8617A31A
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 19:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743275212; cv=none; b=obJm3NJzUCEKXx5Lm9fKntYcqnLQx2Tw4H3jTXCOV6FhdkeUcxgZvkIRsh0nXPxaTG9SQ9+owFmXYAYg50EL/Yur3mx/fg87L3A3kB5m/pOwbabePXunISl4Slf5k4R9CeireNOgMA60EcElsKhgfWSJ8A1cy65D/+QwccrdG9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743275212; c=relaxed/simple;
	bh=derwi5X8nSSmlq3M09UQINPjchK6z69SuASk9k6GhRo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XqZedNYoc2sZxFGHVoTIikVvDjU5E+lup/JtoXmUHPgv4Yyr+QcC/YURoUdb1bwlv8LxYRxp8Domksg/yN+pDNH+hqG8CcV1uKjnOTNmV/CeiODqKCq6/zBopad0bpc1Xzf3AZSBQRfF4Sj5WDK0yokjvCcOY/dnzq+Va4Bvwew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nerTv7Ct; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FQi09ixd; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nerTv7Ct";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FQi09ixd"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id B281011400E1;
	Sat, 29 Mar 2025 15:06:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Sat, 29 Mar 2025 15:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1743275208; x=1743361608; bh=w9OuiYbCfx
	Gh/sBu3GDn2X2tzdKHn8f6ZjYIPVi13Eg=; b=nerTv7Ctz5FL7tcSOYXO8Mvn+I
	h3NLB3zxOGoSGT/Wgpaboy0sQ3GP4WF6UnNOSe7h6rEHPaHbG40wSjmVePpfTlA9
	U05HzjNU5lO+RdtC6w/F/zLG7wSyN3DC4GxCpv9Oq/myRUrxa+o3m8jXi3LW+wY3
	PzcTc2mn4W87Ph4XulfLjSpt5kA5RF4H2lQ/s1ClMZOylXCbKp+QtlPP6KRhRtR2
	HMGNaoMgRzpJr451BHZKFbuV6Z9TyDJuXkI2fq+u19OlBPuy8xzPh4CyYSEJ4AuW
	3ykkD7g1cUo0GoZJje6SWfCAjUupP0J6yQR0Nrc47dFZtwa6aSJDYNkf5KXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743275208; x=1743361608; bh=w9OuiYbCfxGh/sBu3GDn2X2tzdKHn8f6ZjY
	IPVi13Eg=; b=FQi09ixd8eAy7LdHGVRhwN+WEfY5pbtKaIAX3g6dIuyE8Vwl60X
	xCHCVEG5A3H93B0EDa0GuDIWBW0c6yYm/s3uxvVbsbQp6BTz8o2We64gnZv2mroT
	HgVmXWAbiY9+QjQpzQzSp13jX3xIMKhd1RwiHZkyM2P56fEpilyvo6Moqhy2xbP1
	F8yZngzwpadnNPI3WTPsYoWuO69KSXwvQ1sAUVXAgztGmgxy9Y3Df3522zmMqe+n
	Wxvj5iNTt5gtmoOPzrp/pSn1wrFNm8rcIohX5dc6eWwOcTiZ6xU6LbZNLjWP4p1Q
	w5z5zbEcL7W177+Ie9029T99EnKA0JMjg1A==
X-ME-Sender: <xms:x0ToZz4MMWZEFu2cUuI5MtWg3km0ICo91r0CcDRq7LkWelFOy0_uLg>
    <xme:x0ToZ44GAOmaDX8O3eI8WHLgPcI74o9otFu4q4xRci1FADluTe1qeP5Ltxg-jAn6F
    vwU842bmSutg0Kzgg>
X-ME-Received: <xmr:x0ToZ6e2LmE18ffpv9Jz5bJYlZUrjzqr8H7EkwClvvbICghT7XP6OZJCKeXyfTTY-Yvs2xLp1Qs_tQksf5AbNciB9nnw2--TKndvKbs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeegleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeek
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtg
    hpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:x0ToZ0I71dGXtv6pCt6bFUttYS5Qm8NbDudZcKdqbLiSLO6qG__VYQ>
    <xmx:x0ToZ3JLIwQS9UqrblgKkR4919lZw01SaZcu-63HEEOcTKcpl8xSrg>
    <xmx:x0ToZ9wnzmIz-x9XKZStvFjMw3GtKpxizf-YSdluRyr7kVrVe-CTEw>
    <xmx:x0ToZzIyBEMbFF8csMKR_zbrKyP5ZgbtJRpwIA2oj4KvA1o4lE8Wcg>
    <xmx:yEToZ--WpKW7XuwzFfulASSENbCqqIVgPAjPvIW5v3D2ULESA4_qlyUa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Mar 2025 15:06:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  jltobler@gmail.com,  ps@pks.im,  toon@iotcl.com,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] blame: print unblamable and ignored commits in
 porcelain mode
In-Reply-To: <CAPig+cRLXDohGG0RLpC41hy=rTmbmNQ_qScFWMv2LP8pdM8_hg@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 26 Mar 2025 18:49:32 -0400")
References: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
	<20250326-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v2-1-79037e17a74b@gmail.com>
	<CAPig+cRLXDohGG0RLpC41hy=rTmbmNQ_qScFWMv2LP8pdM8_hg@mail.gmail.com>
Date: Sat, 29 Mar 2025 12:06:45 -0700
Message-ID: <xmqqldsnd5bu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +       test_expect_success 'mark_unblamable_lines with $opt' '
>
> This test title is going to display literal "$opt" rather than the
> intended option. Fix this by replacing the single quotes with double
> quotes:
>
>     test_expect_success "mark_unblamable_lines with $opt" '

Well spotted.  Sorry for making all developers suffer the
consequence of a mistake I made 20 years ago.  In retrospect, I
really should have anticipated that it would become a common pattern
to have test_expect_success inside a loop, and made this part also
be interpolated, to make it look similar to the next parameter.
