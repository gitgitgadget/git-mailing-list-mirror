Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C572156F20
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 21:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770240428; cv=none; b=Tb24k1eB4M0pus0GK7v5Y4EOBMiJDET9CbrSCd2uTaw6yLY4QAXQE0w/Tnkg/ciOVpGo9iK+wkNrSQssckVyTrwt4FMOM1ZV1hPdtHzFe/pm3jwVsMANT8pEK+UN1ULTBsQga/NHuSAqRJgQ6R+EJf6sb9pJFpk3IcAUqZFSZjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770240428; c=relaxed/simple;
	bh=c3FDYy3hvXYELuqITU3Kjv/NdhjcO+Pir92N/MrNzyQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dXIzD10sW+ilHE4Isq4MlJbbSjXWQEBAZuCQGAvHMt4KQSpnohu/bdYpsieVcpwDym2T2U4cUsxTaE3/c1oLuRpNBe6oGShxack9pZ5KhViyhhDQIutvelkrP+lBF8QhBhiT9Z3McmQhPW3abZGfQFzyxodfkHsZ5hDCoS59jpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BAVgEShN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wi25+5gJ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BAVgEShN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wi25+5gJ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D587FEC0325;
	Wed,  4 Feb 2026 16:27:07 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 04 Feb 2026 16:27:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770240427;
	 x=1770326827; bh=b2k23JS2aQP9a3EiVK265uFmvwe9YHJsZlz8oITzw68=; b=
	BAVgEShNOp1cy9R0a2PVU2aWDK7pi6DCFOipdaTQHFQuXMudVVb9qYbfHFlwqcLK
	8ZGK0TLLIirLFPdkOQo2NItJ+rnoh0fiN/ZSUNPQp6MNT9rygqesTNESWenpP5HG
	JoSL1JaXqV88bKaIt9/bZtDjn0xmB2YWYq6OCD+Cd2LduacSQB7uEiI9A7GV1YWU
	a6zSeTto8zRrGMmhBN3E4oy2cn1NXwRUqWbsopAIZ3zfgD8RyOwu3qjJzxz8EQcv
	PrfYKWO9nam+GQsCITwQu2++sRMKnjxQIpdh1/VNpWTVKLGIQ3g39yM7m+iEQXZq
	OsJjzwBSDWjSBFSb4LVR0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770240427; x=
	1770326827; bh=b2k23JS2aQP9a3EiVK265uFmvwe9YHJsZlz8oITzw68=; b=w
	i25+5gJuf8T7xcCanIVY/c2xbw3hR5FM52JPyqymj7bJojMP8SpylabhdacNRe/S
	gf3TAr/7y2ZHymrkvKx8KE0Y1MY43q8pY2YCfzpU/xlaOevPZtzRKuGYuUsLggpM
	fyr7G6Zw/LRwmCO2LCKmqR8NMEtSGvGKXh6TuylvVx7lACnsfiYdx4o3ki1V40AL
	2k/Jm01C/nn2LpI+yFM/pIR6J7cIW0ybzVdexd6iShJWY+yHfY3BaHHIYktL6WeG
	zZdmmkhzWulAYe1ZlyUtrdSNOzpnqr6aGFYisBlVdPRGY/BFJS27smvstICjtoTH
	1qir8yekDEux2FZDl6+0Q==
X-ME-Sender: <xms:q7mDadidNGXuKn4ruw1-4IWGlGs_d1yoWTQJLiowuUjvyGQiDH95Ew>
    <xme:q7mDaY4rhEvx28PM3Apzy_-VgOpLkilz5VP2kvby5azUOEEMSQIKbLukml6KCbKkj
    prmdeFuBrmS-c1b-rStfH7fNq8jZs82zTkF9B6hiQVHH5t4b3RTGw>
X-ME-Received: <xmr:q7mDaVayYtRLKM6HUm4l9DBdMbJ7aCfUCU6Z8HG-4srWxVYgEUAqMMfXjNX0sX_lCKx_WiNjLMtGlDzj5glndmUUqeNbRraPaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeefheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeht
    ohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoh
    epnhgvrghlseifrghlfhhivghlugdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:q7mDad5cKJuhqz_RfGlT4A6zYSMu2PDx4RE7T12Thr1xw0EdHwprlA>
    <xmx:q7mDaYC7XKk3T5b-_YsP--Rsl6pxpiqMZGVHBLJc8sq5Z3kzKztzDA>
    <xmx:q7mDaTcv7Ur7YschVE1SmZZ8KZc1myXX7kUvhw8vHYBgSpTyl9w47g>
    <xmx:q7mDaXLMVY5viBxjDebroiSA_gXcLUN2L18VyYcdDWbFz_uIAh_H3w>
    <xmx:q7mDaVWsyCKCl4YX_-_O2JhHBFlHoNaGcBej6t4hogGiAHz1tDC0FQPH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 16:27:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: git@vger.kernel.org,  Linus Torvalds <torvalds@linux-foundation.org>,
  "Neal H. Walfield" <neal@walfield.org>
Subject: Re: [PATCH v1] gpg-interface: Signatures by expired keys are fine
In-Reply-To: <o2xni4463jlbmv226ngrlvepluqm43vg3fsifubanw6unhei77@wwzsa4ciqexw>
	("Uwe =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Wed, 4 Feb 2026
 22:18:08 +0100")
References: <20260204152306.1767112-2-ukleinek@kernel.org>
	<xmqqjywspgi6.fsf@gitster.g>
	<o2xni4463jlbmv226ngrlvepluqm43vg3fsifubanw6unhei77@wwzsa4ciqexw>
Date: Wed, 04 Feb 2026 13:27:06 -0800
Message-ID: <xmqqa4xonqs5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Uwe Kleine-König <ukleinek@kernel.org> writes:

> Hello,
>
> On Wed, Feb 04, 2026 at 09:26:09AM -0800, Junio C Hamano wrote:
>> Uwe Kleine-König <ukleinek@kernel.org> writes:
>> 
>> > If a signature is done with a valid key and that key later expires, the
>> > signature should still be considered good.
>> >
>> > GnuPG exmits in this case something like:
>> 
>> "emits".
>> 
>> > diff --git a/gpg-interface.c b/gpg-interface.c
>> > index 47222bf31b6e..6635c6c8e16f 100644
>> > --- a/gpg-interface.c
>> > +++ b/gpg-interface.c
>> > @@ -382,7 +382,7 @@ static int verify_gpg_signed_buffer(struct signature_check *sigc,
>> >  
>> >  	delete_tempfile(&temp);
>> >  
>> > -	ret |= !strstr(gpg_stdout.buf, "\n[GNUPG:] GOODSIG ");
>> > +	ret |= !strstr(gpg_stdout.buf, "\n[GNUPG:] GOODSIG ") && !strstr(gpg_stdout.buf, "\n[GNUPG:] EXPKEYSIG ");
>> 
>> Makes sense; I'll wrap this overlong line while queuing, though.
>
> Just to be sure: That means I don't resent with the typo fixed and an
> additional line break and you care to apply this patch?

Unless there are other things you want to update, no need to resend.

FYI, here is what I queued.

---- >8 ----
From: Uwe Kleine-König <ukleinek@kernel.org>
Date: Wed, 4 Feb 2026 16:23:06 +0100
Subject: [PATCH] gpg-interface: signatures by expired keys are fine

If a signature is made with a valid key and that key later expires, the
signature should still be considered good.

GnuPG emits in this case something like:

	[GNUPG:] NEWSIG
	gpg: Signature made Wed 26 Nov 2014 05:56:50 AM CET
	gpg:                using RSA key FE3958F9067BC667
	[GNUPG:] KEYEXPIRED 1478449622
	[GNUPG:] KEY_CONSIDERED D783920D6D4F0C06AA4C25F3FE3958F9067BC667 0
	[GNUPG:] KEYEXPIRED 1478449622
	[GNUPG:] SIG_ID 8tAN3Fx6XB2NAoH5U8neoguQ9MI 2014-11-26 1416977810
	[GNUPG:] EXPKEYSIG FE3958F9067BC667 Jason Cooper <jason@lakedaemon.net>
	gpg: Good signature from "Jason Cooper <jason@lakedaemon.net>" [expired]
	[GNUPG:] VALIDSIG D783920D6D4F0C06AA4C25F3FE3958F9067BC667 2014-11-26 1416977810 0 4 0 1 2 00 D783920D6D4F0C06AA4C25F3FE3958F9067BC667
	gpg: Note: This key has expired!
	      D783920D6D4F0C06AA4C25F3FE3958F9067BC667

(signature and signed data in this example is taken from Linux commit
756f80cee766574ae282baa97fdcf9cc). So GnuPG is relaxed and the fact that
the key is expired is only worth a "Note" which is weaker than e.g.

	gpg: WARNING: The key's User ID is not certified with a trusted signature!
	gpg:          There is no indication that the signature belongs to the owner.

which git still considers ok.

So stop coloring the signature by an expired key red and handle it like
any other good signature.

Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 gpg-interface.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 47222bf31b..5a58f333df 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -382,7 +382,8 @@ static int verify_gpg_signed_buffer(struct signature_check *sigc,
 
 	delete_tempfile(&temp);
 
-	ret |= !strstr(gpg_stdout.buf, "\n[GNUPG:] GOODSIG ");
+	ret |= !strstr(gpg_stdout.buf, "\n[GNUPG:] GOODSIG ") &&
+	       !strstr(gpg_stdout.buf, "\n[GNUPG:] EXPKEYSIG ");
 	sigc->output = strbuf_detach(&gpg_stderr, NULL);
 	sigc->gpg_status = strbuf_detach(&gpg_stdout, NULL);
 
@@ -680,7 +681,7 @@ int check_signature(struct signature_check *sigc,
 	if (status && !sigc->output)
 		return !!status;
 
-	status |= sigc->result != 'G';
+	status |= sigc->result != 'G' && sigc->result != 'Y';
 	status |= sigc->trust_level < configured_min_trust_level;
 
 	return !!status;
-- 
2.53.0-169-ga09cd4eb64



