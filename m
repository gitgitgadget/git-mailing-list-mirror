Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B18C7261B
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 08:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763195173; cv=none; b=UP5ds3Bd/fTPanXE5VcPVge4WhIX1zjrvKJHOajmLkGvzOWrGGM959PjKsfb5eTp2QBs/qaNjWNwesw7OnhfBtDxJntIsG7PlZE1WnY6dtcSvbZUT/xpKzF/wx++9lELPHAiNlXzY2IATzHBXh43qFgMcpQPvj2ZsJ2SGyl73IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763195173; c=relaxed/simple;
	bh=y5UaZ0/QlaF3mLQ/VeT6lnntBpZEsUxCB3tCYqVpePs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZiCEA6D4Z7BIgO9KCbL5KB+6g+FZ9qgmMe80mv281+UHpKDlHo43euPnhfSQCo+1o7wc3iukIrlyw0rOTpXMyUjjg8iKhewL09SpthE2Wr5fu0g5CWueho0UqN6TAeS6Ok4uVMdZaF2PVZYqqazJv1NdXe3Ewe35f1UlV0q2usU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V0NU0iep; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hslvEiXB; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V0NU0iep";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hslvEiXB"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 36F55EC00C5;
	Sat, 15 Nov 2025 03:26:10 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sat, 15 Nov 2025 03:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763195170; x=1763281570; bh=4UTzf0eqtO
	+PGMaHzrO4TJjBKTYwP6kfFL9+207xNco=; b=V0NU0iep8Yh0duxBYlSQ41pBLR
	GlCC9zCEZ+bgmqGCpwQ24zRUNWVsfLNJ47rauIFdvEUPUPdK1CpSt/X1I/Wx+4ar
	1V0R5Mlhyeilkol+nPEz+nlHeNiEeOBWrJP66xrR96MiZkmJs+EIQKxZdB2gV6Ry
	lIzy/5KvSUrApZg+A0QEHjvW3XxkosWsGesTX4Yujcow9U5TPdLgIQWPtN4vnOBN
	e6nYN79VPVpj17ooe+Rfg7V7fyNBy8DH6LHETYXX23OOYurhCFEiclIzc/iWZiAb
	4of5lQZqABJwFY8DHXQzOJttj+2e01PuRnDdn20TyD1fBwoIRCaGvqQM9+wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763195170; x=1763281570; bh=4UTzf0eqtO+PGMaHzrO4TJjBKTYwP6kfFL9
	+207xNco=; b=hslvEiXBgUHgv1JrvCCyAiI/g69wDUQFCsTiSwHPzjcjv6wXpey
	5t0CVUIEcVyaqaOepGKI31OpuO1y/j416zXBY/I0AVPo7Kl5YOXQS8BLN/BF5zwX
	SOvpjWxTfjv7V5IetI5sK26wW4D8Y+Cwsplxtv3a3+iplQkA9HwrvIjNOQZBtPBw
	liTodxsvdFRKUmAxew96aQ6ZKvERNL8tizEdRVRPbkvXpsB6LBiehGlu5aoV8cWQ
	ZP+yoKSbTMf2GuFtm/qIaxEauzL3OUsxurO3V5mgM7cSD86XiSy3LjqxUHZnhH5T
	0it1iQ+dVKwSkTfA9aHZ9ojoGX6CfYMUJuw==
X-ME-Sender: <xms:IDkYaRszmU8CNe4-uAQABoWDRnzj4CwGN1HED9x9keDlrTIEizzfjg>
    <xme:IDkYaZj_cZ1fZJws0E0GcQqiE-_ewosqvcBOlRKOU1KVqGeU0gI6goxYoTLgxetK7
    UV2LzbhA5eUWsF2o4RxAtnfC8Sxs2aOr9RrwDRBvKmYxMK7rScvwbY>
X-ME-Received: <xmr:IDkYaa8h2XijeRFV5OaVyzDaPljGgmK2gD2PMdlVkZ9USLS_jVwJatRAHqNYbBXwgJvYh63vys4AW1ADiX7jcFP2a7T084FDpc_R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddvvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepjeejleehjefgheeghfeuveduudfgtdetjedvffethfdvteegteefkeeigfet
    hfdunecuffhomhgrihhnpeigughifhhfihdrtgifnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhr
    tghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtph
    htthhopegthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgii
    vghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:IDkYaUuv88xVEArZiM3PAKu9wIKlI_pwm_hRiHWTTc4dQe3QCTUNcw>
    <xmx:ITkYaWqTof6yYFxvvLZu0WEl5hH4MMInyaT6JfWIHkqnFkWzGgP3bg>
    <xmx:ITkYaQr-rEeJ8OWWOPRMHa5SMORiRtXHS1MQgYtqV-ibVEuqsx_S5w>
    <xmx:ITkYadZ24FDQXNQWuVbNGoky7D9EUxrsKGtYGQc2u8HAaAWzVlFelg>
    <xmx:IjkYaUPmbC2y2xY8I-iH7ZPOcfA_Z2R6TSPPz7MyyEoQPaWvbWzpTkEY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Nov 2025 03:26:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Phillip Wood <phillip.wood123@gmail.com>,  Chris Torek
 <chris.torek@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v4 03/10] xdiff: make xrecord_t.ptr a uint8_t instead of
 char
In-Reply-To: <042fbb11d03606879503846e86fac65e6e74d02a.1763159816.git.gitgitgadget@gmail.com>
	(Ezekiel Newren via GitGitGadget's message of "Fri, 14 Nov 2025
	22:36:49 +0000")
References: <pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
	<pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
	<042fbb11d03606879503846e86fac65e6e74d02a.1763159816.git.gitgitgadget@gmail.com>
Date: Sat, 15 Nov 2025 00:26:07 -0800
Message-ID: <xmqqy0o7g0rk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> In order to avoid a refactor avalanche, many uses of this field were
> cast to char* or similar. One exception is in get_indent() where the
> local variable `char c` was changed to `uint8_t c`.

I actually think keeping "char c" as in the original is a lot more
logical for that particular case, as the existing use of that local
variable are _all_ about C's 'char', and not about a very short
unsigned integer.  The variable is compared with C's character
constants like ' ' (whitespace) and '\t' (horizontal tab), or is
given to XDL_ISSPACE() macro, which is also about C's character.

But because it is so minor a thing, I do not think that it deserves
a reroll on its own.  Just in case if there are other things that
need to change and the series needs a reroll, here is the only
change required for this.


 xdiff/xdiffi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/xdiff/xdiffi.c w/xdiff/xdiffi.c
index 8eb664be3e..4376f943db 100644
--- c/xdiff/xdiffi.c
+++ w/xdiff/xdiffi.c
@@ -406,7 +406,7 @@ static int get_indent(xrecord_t *rec)
 	int ret = 0;
 
 	for (size_t i = 0; i < rec->size; i++) {
-		uint8_t c = rec->ptr[i];
+		char c = (char) rec->ptr[i];
 
 		if (!XDL_ISSPACE(c))
 			return ret;
