Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBAD72622
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 06:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777530252; cv=none; b=dvIBDuZDRQXY1LvoFwDp6xmjAEucCTIoAq18rtQB7ELijFrr1cWEO2Lvr4ZnNZ2o0I5JdXhuVaAs3pDc5WpA6o/04ct0spg1+SPZgeZ5dnnhWQe0i8WqSpqrw6cumfMEy+7ZNxwY0u2TK33SV1elQ8Wyjf6bFMGsfJMLlMKEju8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777530252; c=relaxed/simple;
	bh=mkF47VpfLM/jYS0UxSVVuZAMmmPOA/aXncQMajD6CpI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=j93RMolG3DBotBQemRwe52QN+INKR4FcdbyqwNPHQOAbb3A++fUBWZvpTINGciIzoH7p3Cryjr4dK4jli7KjzHpxjMUjNmxN9KcjO7nwK5WLnjDkPDhiPd9kX7/j8dKxlHMrOip0WyhbPqlaYUxmjlfRK4DULGQdsCayGhXW5L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=j/5F/Zci; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sWRequwi; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="j/5F/Zci";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sWRequwi"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 90DA07A008F;
	Thu, 30 Apr 2026 02:24:09 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 30 Apr 2026 02:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777530249;
	 x=1777616649; bh=3/QpW4GEBPaaZ1HHoCmWtSPzwJ8oN6RUdImT3On62e8=; b=
	j/5F/ZciK4KNGMnWqQYFWsXEZw5Yyfp8VVFslmvfrxMCyv60GeuPKthOdSoy6J96
	CoMgHzDF/yFbKZ0RL8pFwIGBsbki8ru96Afobj9PaS+ohIujHIhffDucpqouRz3Y
	bH2ZaYOHF8qPgojB80qKSuK0jjpNdDyqTUfSiA06OfSDy1m4jvTSHzly5tMp8ZCY
	EAWysgg4pv1TTAlNKM4PdiPVClrw6sbPUwS4CJfizyV9OiQqkLza+ENy02o1CzbZ
	ghw3FIAHilkNeuQFoJl5xleTPqGQm4oB6TtWCHywzsZobA4lGcZSF0AFmSH3YnCm
	SoenIgoN3fv/8T+P3BWeJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777530249; x=
	1777616649; bh=3/QpW4GEBPaaZ1HHoCmWtSPzwJ8oN6RUdImT3On62e8=; b=s
	WRequwiRHN8Og2GfO2xknVVhMMOZ2+/UiTR0DwbKhpqGM862O+ZwuNYv7qh8Q/Gl
	O/gyoew8QKNG30i8dCgLN2CYncDZqERjzRSUxA1Xo4wlsz+v46HFXUsgei0TUo+n
	iFC6V4o1ffRRit5UTVRfiqhSlXfvrjMK8uJ5FVimQrxIDjnlQLHCne1mjqgZQJC6
	oVafuAX51nv93jwKYQRHXUJ9vOEW8bzdneZ5BJWhorbJ1KJJ4Ss7WxEv7jYNGuYS
	qad3CC8rsXXoypiqOm42/DbHLFab/3Lk89wiWu313U2/CcZn54YzetUIhdOzFijq
	ltJ54cROGCujLDb9Xxo5g==
X-ME-Sender: <xms:ifXyadZ6qUNhJi-XfGEELJAWzdJdtX7-Z18Poz--vL6RlixsAuHoGDU>
    <xme:ifXyafNkXMCvLM0MeJX7WPCdA3RDrtd3uRD4vPPB-JmqE5lp6y44GxvPUH--rMUW6
    GpltFCHYnKUPJKH54zEtwz3G83XhxxB1sfJhUFJ6AgktzP5LW1r6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekieehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeekteekhfekieev
    gffhveefieffuddutdeggefhjeduudejffdtudeuieetuddtheenucffohhmrghinhepmh
    grkhdruggvvhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggv
    nhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ifXyaYFDQGVYv-UGhhlwmgJ04PLe71BmnYTyy4NCFvhVAkfrnsd3NQ>
    <xmx:ifXyafTsyBn78tfeNk-h_sciccO9-uLbIy4yxckCx4uRVTpFJRtzsA>
    <xmx:ifXyaZuZJnLeDU3vH-QQbD8WIZfY4vMwxdwGMbvufinI5fvWjugHkw>
    <xmx:ifXyaWyU7OphFOI-FRmXASNM-KmKcrlynJYM533dXB3485m55bBczA>
    <xmx:ifXyaf-y87XQXbYDs0EcIfIPn_3Axe4rll4n0VCWE7VgyvwR3WTFYK68>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 443B61EA006B; Thu, 30 Apr 2026 02:24:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aq0cXLUbXG1o
Date: Thu, 30 Apr 2026 08:23:48 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <8cdfbf18-6137-47c0-8134-4cd9f767fa4f@app.fastmail.com>
In-Reply-To: <374661c1-4676-4538-af24-0564f38469ca@app.fastmail.com>
References: <V2_CV_name-rev_--format.51b@msgid.xyz>
 <V3_CV_format-rev.66a@msgid.xyz> <V3_format-rev_new_builtin.66f@msgid.xyz>
 <374661c1-4676-4538-af24-0564f38469ca@app.fastmail.com>
Subject: Re: [PATCH v3 5/5] format-rev: introduce builtin for on-demand pretty
 formatting
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026, at 15:41, Kristoffer Haugsbakk wrote:
> On Wed, Apr 29, 2026, at 00:25, kristofferhaugsbakk@fastmail.com wrote:
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>[snip]
>
> CI returned an error.
>
>     builtin/name-rev.c:893:25: error: =E2=80=98commit=E2=80=99 may be =
used
> uninitialized in this function [-Werror=3Dmaybe-uninitialized]
>       893 |                         get_format_rev(commit, &format_pp,
> &scratch_buf);
>           |
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Now Im using `config.mak.dev`.
