Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E7733993
	for <git@vger.kernel.org>; Mon, 11 May 2026 00:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778458587; cv=none; b=NFGyGOrySuNJCSRyfVVxY7jg1IVVm1ob/nRtvaHqx0uigltXhHygxzGFPlXKvhcQ5yx1d9c+J4iS24wugcT7NDfWtqzt4+SmV/5qc27BZ37jLGmJ2+9JF4aWhn4jXMqjU77+esEY9wM+GgxTCznxt5aEU5Wgqqr6R5MWsMR74HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778458587; c=relaxed/simple;
	bh=sGt1snVeS9C8K2UQWR9vEF47KnNma0jbfIb0B4GIZS0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GClNWAU/XdiTVCL8y0FDWE+5Yf/70k9jorZV2WPJXf/XzmlKmMTNTEZ2Z1JIKvniziNUIVJVSC6NHXwl6VgIba/FXUlSvQ+slrxbauKfG/Os2rl+X9D7hlC1YWQEwLbVrjsbrxRpj4etgH/Q8ZQAFEletREkzAaf5l5Y/5y7YDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G2HJBzMu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L95HP4Ac; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G2HJBzMu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L95HP4Ac"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 372571D000A1;
	Sun, 10 May 2026 20:16:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 10 May 2026 20:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778458585;
	 x=1778544985; bh=vbkRYNP6brcdVdquwxsEdmRMEHAgSiAv0HG1GDvAHGI=; b=
	G2HJBzMu9I8I8gPSUtlhWLpXiQ4usViiuHUVfa0CkPzYCmZ5vE8+bGK9glg+nIOf
	OaGzWBrYOXpL3Bw/+SgUkYCDGS+IpNVSON+FE/JKYCpAoRXxt3zv0mdabpePhj+b
	mdjOsKnj28MV5t7US/risi0thmADfd53ZQCNyg1h+BjNAoxNRs7EpZiEXqdqG2QI
	+chgSOUyIyBHbs8Of6i5IDoEqvsc56p1hhgJZsUA7h1PepY9FuWyQfJtriXJO7Px
	48htvdzGv9RoYuPMnrW0/+GVLuEwhNqt1XTNoijWONc1eLZUCrxADLhbbJNjYcyr
	Ktj9caUartJ3DcSI1SQmbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778458585; x=
	1778544985; bh=vbkRYNP6brcdVdquwxsEdmRMEHAgSiAv0HG1GDvAHGI=; b=L
	95HP4Acj/roc18H7eAl9vFGN1j1HlZGrksU0dfAyK7foeJJVmJ4/oRwK7KWt9Vi8
	IXSjP6WWYYNcuAeoU/T6KABeFuL2MvcZELJLDdzU1LgAwKTwGjk2gfmCmC4U73zB
	q5DC+eP/iR+93GNpGIz0yVNeUt+k/y9uB6HvpZ0QJYSZd64pDVNLr1dk6t1jXsge
	A2kYrT7yBeS1hOGdRfapZCfwUTpsC/NGHvhaSfwUDeSDMk7xLLSR6kHZTffmvB0+
	uyi1ngAVBGN6NcXyKsp4kVMFe0OTS7TAFCjLg3znqeOctnFwf0+QIUcyyw0bJ5Cc
	W6xv9Uq0u0F57zIU1jo2w==
X-ME-Sender: <xms:2B8BagiV8lvGbU87piej3BdkIEQYqQ9I8eFzBOSFr6sW39F-gv6tIw>
    <xme:2B8BalmLWuNSOWdhS85YbANMKhVkXd1-0aNPavdZU6KY96iVojfVhjbHsP3Rt3W1K
    B2KY1ZRER70nCaTlOY_H7RKWbthfiUJFtzAITN9DMTK3xEePcPTlA>
X-ME-Received: <xmr:2B8BasiDcT7zuiLEJgEmQRu53Hbk9iBOkm8QgRZedXMZwpJsK6Vj0lOP4aWyeXoF6EQrCkFfop7XwZEZe0M-wQCviukCnnHcZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehjrghvihgvrhgsrghsshhisehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrsghrrghhrghm
    rgguvghkuhhnlhgvhedtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfi
    gvsgdruggvpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:2B8BaoHNj68qFAf3ID20cwDr0r6qTxyQN4b0ZmFD6o2ADIhiaQvPXA>
    <xmx:2B8Baus95p967yYvLn-SSS_J5WEm2-ggFXS1Nrc6dez2WapHgJBbsA>
    <xmx:2B8Bapf2T6hR9Xhz2OTCJJzyqHkhplHud87L9WiUjUS_rzAbqZSlZg>
    <xmx:2B8BakkRjFqwL79JeBJMsTl1qCaEF-NWa3PIqQNcW9LXTTGz-j423w>
    <xmx:2R8Bagx7HoG7PZgpwMiPml3KjsuOTUT3JeCXf-dBGgkDLSSv1M6SwRkZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 20:16:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Javier Bassi
 <javierbassi@gmail.com>,  git@vger.kernel.org,  Abraham Samuel Adekunle
 <abrahamadekunle50@gmail.com>,  Rene Scharfe <l.s.r@web.de>,  Elijah
 Newren <newren@gmail.com>,  Ruben Justo <rjusto@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH] add -p: introduce 'w' command to view hunk with
 --word-diff
In-Reply-To: <CALnO6CCsOMyLxAhGW10L4duaahUORwedfmtdpY3zDGpQcZoP2Q@mail.gmail.com>
	(D. Ben Knoble's message of "Thu, 7 May 2026 10:39:03 -0400")
References: <20260506235459.529862-1-javierbassi@gmail.com>
	<e640ac2d-9e46-4f1e-9aef-deac80c65361@gmail.com>
	<CALnO6CCsOMyLxAhGW10L4duaahUORwedfmtdpY3zDGpQcZoP2Q@mail.gmail.com>
Date: Mon, 11 May 2026 09:16:23 +0900
Message-ID: <xmqqqznix0ko.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> I concur, though I wonder what other diff options would be useful. I
> can imagine a world where "add --patch" allows to reshow the patch
> with any set of custom options. Spitballing…
>
>      :show <opts>
>
> …could work, since we have room to allow long-form commands still.
> This could be extended to arbitrary git-* commands, and ":!cmd" could
> be used for shelling out.
> (Can you tell I use Vim?)
>
> Anyway, what I like about this is we don't have to worry about running
> out of (or thinking up new mnemonics for) single letters for different
> combinations of diff options, so it's a bit more extensible.


If you mean "don't waste a new letter, like 'w', every time you come
up with a use case to show the patch hunk differently", I had the
same reaction to suggest reusing 'p' but allow options after it,
just like the output from "git diff" can be modified by giving it an
option "--word-diff".  But how would it work for single-key folks (I
am not one of them so I have less sympathy than I should in this
case, but still...).

