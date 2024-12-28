Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8D22AE84
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735405789; cv=none; b=DfUpDqBmAdNWAxssLtBvOGu6/cScA6C1t5eUQ+mLelfX137xSzSYuruiN38+Fl/yPfQRR0ZiY3b6tYguf6VUmbECTjwvY3LSuwfNbIxcGx9aMkZg4Q4OrBaJTSK1KKzD10npDBt9ZdqF6P4xJhAUcRx/unYFexeU8vFxyZwNsbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735405789; c=relaxed/simple;
	bh=TG363M2zPJrpVDaGeNTXRIPnV9u6AFIgfU8WA2irQ9I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RKN+RYcsgD9TgOp2pyPKjKd1MvxMlKw0I3UwpuNXe2MWW+NnZz2yRHTgj0FKE27C0Vm0aJ4eEdPrsiIr9m/ezLGGRyFNWG/IU0Zd/HqXXh49uxa6oMsLyvi1MrbnjSyxWpPMfMiOUBmbDXNM9HjTTAIxxQBY5IMSt4IW/13Lw98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bDmgRDQ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nqASXtOw; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bDmgRDQ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nqASXtOw"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1E7FE114002D;
	Sat, 28 Dec 2024 12:09:46 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sat, 28 Dec 2024 12:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1735405786;
	 x=1735492186; bh=1GMVK4HQUNEHL+CkevjpNQ0vhtULEXVwoFHBib1cd8c=; b=
	bDmgRDQ79i1vTwWk0bi0n/qVL/R+79FCwo3CsseTlazAKRga7KWWqMzx2nftlfe9
	5czWqi0yH3kzOr8OGUDevtgmQQhIUZuZrpQiQV4dpz49BGYhGXwJnri9zYWhd2Dk
	CHA8nyA/zqxDhFAoEi3dLwfF0hCGhEUUouAj6hnQUjftC9jxagfVYpE08zo35fwS
	BBiCEYDoIeaAmw2lCG+xV/zRqn2vz3rxuouu5SCfeq6ZKH91wBIOY1YLVJgSzNQW
	zTzZnbD4ficFnwcHDXw3Wt51dRHpcQr3RCA5dnF8sIEQ35ACndyT6L2YoR3o9puI
	8FJEWlRfOx0K7dkyseYwaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735405786; x=
	1735492186; bh=1GMVK4HQUNEHL+CkevjpNQ0vhtULEXVwoFHBib1cd8c=; b=n
	qASXtOwfrNc9ipYtF0nNJMqWNRyv5xA0ni/Qo0Eva1cE8WgQo18lvpWtQuljhdBL
	vySl1OAB0PtysdP02ScoX3cCGiylpzO7TpvFBWgbp3UynB0IjwUwA8DeDmbs5Vt5
	zNZjTCGdQuXCE5T6SJbYcn2nLtM1oF88DECx4IJzidGb2tlWP/ufYB3okW4mKnnn
	ftztlHZ9pqWUxkqk3NriGXLHVhv8kZRb8i7kaM6P6ZV3SfqfZNUCQPGkDdNIBNIE
	AgMoYfVAmrrTlvmkpGJswnrqMNXTdt+7GIl4haAF5f22jEv+HaN+xzePGZXvqQii
	5YjA8sOi/EsijZFdo83gA==
X-ME-Sender: <xms:2TBwZ_aqJjvHH0G9J_BTKThp2MmqNuSDF8R3_Q7puA7-2lGSCslRqw>
    <xme:2TBwZ-bqzSOpmJ9g1ls8eHHgf0Sc_kN5Dvm_DUlRwj3LR6cUjxWbUMZkiMiXvIKYp
    YR-oZFwlyoznhA5LA>
X-ME-Received: <xmr:2TBwZx8AIDdOFi8zJbmO6TsFiAKfgQ_nd920PYhbL3y2VzuxUivRWe-4MKw6gCZzSn-Vg7dIn3G1S60sEpwobx_4PRXtuhX89Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvvddgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepsgihohhunhhgtghhrghnrdhlvggvsehgmhigrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2TBwZ1pTM3wz-yB3eFXQTn1rBV0ij1WAayt0yLt64SDwi-zjtaLjsQ>
    <xmx:2TBwZ6od-R1G52We5ImncPjZlWz5ZpfmgwfhhiO0B8kcCuLQAs-sRg>
    <xmx:2TBwZ7T5VtmfRPzDdviSPcUsM6BnrACb0eUS4mHrST0yICi8zRtuOw>
    <xmx:2TBwZyqb7WqGsLhvHIgfJLDjTZP1IaT9d_RFu5B4Ly166A5LdrCBEQ>
    <xmx:2jBwZzmlAzQp5yD2xWP058egfaJhs-gDNdBS1yN3kvrZIjDXi7lphOWL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Dec 2024 12:09:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, Byoungchan Lee <byoungchan.lee@gmx.com>
Subject: Re: [PATCH] builtin/gc: Ignore random minute field when registering
 macOS services
In-Reply-To: <CABbmNUHA5F_ZMzngYHBzuqLLJ-3+87yVU_gZxGxhCYuMP64QKg@mail.gmail.com>
	(Byoungchan Lee's message of "Sat, 28 Dec 2024 12:13:03 +0900")
References: <CABbmNUHA5F_ZMzngYHBzuqLLJ-3+87yVU_gZxGxhCYuMP64QKg@mail.gmail.com>
Date: Sat, 28 Dec 2024 09:09:44 -0800
Message-ID: <xmqqmsgf3faf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Byoungchan Lee <byoungchan.lee@gmx.com> writes:

> In macOS, `git-maintenance` registers several launchctl services
> to periodically run Git maintenance tasks by creating plist files
> in `~/Library/LaunchAgents/`.
> To avoid re-registering services unnecessarily, we check if a service
> is already registered by verifying the existence and contents
> of the corresponding plist file.
>
> However, these plist files include a random value in the minute field
> to distribute maintenance tasks over time. Because this value changes
> with each registration attempt, a direct comparison of the entire file
> (via `strbuf_cmp()`) often fails, causing services to be erroneously
> re-registered. As a result, users may see multiple services registered
> and receive repeated “Background Items Added” notifications.
>
> To resolve this, introduce `launchctl_plist_cmp_ignore_minute()`,
> which compares the content of the plist file while ignoring
> the random minute field. This ensures that services are not
> needlessly re-registered when the only difference in the plist file
> is the randomized minute value.
>
> Signed-off-by: Byoungchan Lee <byoungchan.lee@gmx.com>
> ---
>  builtin/gc.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 47 insertions(+), 4 deletions(-)

A few comments on the design.

"ah, the minute part needs to be ignored when comparing with the
existing configuration" smells like a poor strategy for two reasons.

   (1) maybe the part that gets fuzzed would become different over
       time and this new code may need to ignore differently.

   (2) the need to compare with the existing configuration would not
       be limited to macOS, would it?  If anybody wants to avoid
       re-registering with the same configuration again, such a
       selective comparison needs to be reimplemented on every
       backends.

I wonder if we want to tweak get_random_minute() logic to be
deterministic to avoid need for such a fuzzy comparison at its root.

A few possible ideas are to read the value from the existing
configuration and reuse that instead of coming up with a new random
value, or to hash the hostname (or something similar that is
reasonably stable) to use the result as the seed.  Derrick, what do
you think?


As to the patch, as I suspect we may not want a code with the
proposed design, I won't look at it deeply at this point, but please
consult Documentation/CodingGuidelines and/or make sure your patch
will not be whitespace damaged during transit from your repository
to people's mailbox.  For example:

> diff --git a/builtin/gc.c b/builtin/gc.c
> index a9b1c36de2..6405f4d332 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1951,6 +1951,51 @@ static char *launchctl_get_uid(void)
>   return xstrfmt("gui/%d", getuid());
>  }

These two lines are supposed to be what already appear in our
codebase, but we of course do not use a single-space indent.  There
is something funny going on.

Thanks.
