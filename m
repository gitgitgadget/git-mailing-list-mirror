Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45AE2FE07D
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770661652; cv=none; b=CfvmqAq9ucHlzpcnSOWbdnmWXAa32abkYBZ6Ua8P0FqyuIKSfhXUDTvxim9VBjzgaocKm/ijpf0moRaTduMxdBKohnGcRCc77VCRYkkWRba/8IlV/0e5SuFxKjsLay59ZouXJVkA9zdwO9W0iCB+K6W4DY79lqcKapaKj+4nyhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770661652; c=relaxed/simple;
	bh=JWvgoRUgrUPmbbnjDy4pj80EsjQvljf29gdY8i8UE/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YDbPDeC6rYLESitnTkm+iXjkPgGidrO/9+PFk0Bcd2rWoXqzIJvXntFkJQgu4L2a5QHyC2H17+hGsGaMRPjKCGyBhhAs+1SPHEd2kQt2detfv7Q6zC32pNgPE3umI7DNA9kzZ5AKjef0ZV2jJlOmRMIfgZhqtMQNo/RemlNj9Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fd9xbiSS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l7EaxVDE; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fd9xbiSS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l7EaxVDE"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 370301400165;
	Mon,  9 Feb 2026 13:27:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 09 Feb 2026 13:27:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1770661651; x=1770748051; bh=Wt1xy0zABqu6HwZFXNcYausjg9b/ZwWJ
	aPk96hy0bC4=; b=Fd9xbiSS14lsgAxmnjmxeiF0RpKkpNXmz+NQxg3CSJT9UpAo
	6b7aFmzARbChyBoNmS6C77HHgdIVZv82iCFlr/TeO8f8PNrOaJ7Qvw9i4aILroeg
	+6paU1wzKrm4yRGyrBhjCFH9mUFagEN6q39re8YqGyUozxbDfWzGheJM1Atq2rPD
	7LLed0+gRrI4oDXSEHstTxcXb5h/I7JhmXBcI4/yYuIJ8SWF8YI2GFPa3UJx1q8J
	ZzVqZOPLKgH2wg6UiTM9Wj0ytyXxnREseVeh0WHl231U7sgHxS+lcC+pQXYY17cl
	z9dvo6u9EnifVWWWem7MmOq0al8/1/NE5SNAzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770661651; x=
	1770748051; bh=Wt1xy0zABqu6HwZFXNcYausjg9b/ZwWJaPk96hy0bC4=; b=l
	7EaxVDEBk2xqQ/vvb7ZWeZpdVV6wPw0NOsJ/UBjFkJ0lD093s20RUMdCCd4QE6hQ
	MozgVE94sp7g0+BO5nlYgG1amERG8al8XgBTZNvZP5Vbz9U0Z099EaINibgJ2zFG
	ybTVGoTJjkKg9Cw0Cp5tpzE/m0sv0H1HV2qJXo9SahN6Bd/tGGBQA7GLbq0L6wKl
	9E2Ts4mMXsfTtFUoB7ufsz/G+QjgRP7f1+NuIOMz4HQ9XokYPnOHv/EfV6QhpC2+
	tr/ZzuI/tNl6HoVuuGlUWiPa+Md2/hK6EeOeLHAAaRtBkMwGerCI47C6Cqmym7Xz
	kySwnu9oNQqqBfsiJ76+A==
X-ME-Sender: <xms:EyeKaSOfIIuZok7cdG3bWJ9tW86cJjNzXPTYjM9GuE2vs5_QmD57vg>
    <xme:EyeKaYYr80tHQPYWHi0Ue3Lvn7VynU5VoqzrKN1IGn5cHLrmA5m10w2CBJxLBKC9l
    MWWjR4OC2VyJoo6Y-zo9a77R3UVoTA-NKgoThOCQFG7sG_-4T8q7Q>
X-ME-Received: <xmr:EyeKaWr0qVeIysJgYTj8KzYAsClb6FJ01hO46Qh7gq-NzG45jr4_gwUvnN8KFg1WBLlIbBgep5i_fxVipSQlx7QXcnjPUDB4gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejhffgfedvkeeftdfhjeegffeiveeiie
    efgeeuiefhjeelueefffejteekffffjeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkh
    drnhgrmhgvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EyeKacbQdivWtbk9aRYF-1RuCvNI62DivNsXVRIlAXTuxlC330kxVg>
    <xmx:EyeKaeRDEtYrBIuMWxSRL74ofqgCGH53BGCevOtgQwAlaUwaovqBWQ>
    <xmx:EyeKaT5Bh-ecSIkltfIX8dFCdcUaOEvWHJHKqbCWIyDQGhcfy4I0Kg>
    <xmx:EyeKaTyFL3CZOjGhgIQpmAz9ITZQ3BKLH86OAK7_uvx1wUYc8UoqIQ>
    <xmx:EyeKaYjUOPBfy1JWXDMncQa52fqK-mJhMe5JeXbDtPicZ5Rg8jl-4eJZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 13:27:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] rerere: minor documantation update
Date: Mon, 09 Feb 2026 10:27:29 -0800
Message-ID: <xmqqikc54vse.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Let's not call our users "it".  Also "rerere forget \*.c" does not
forget resolutions for just '*.c'; it forgets for all the files
whose filenames end with ".c".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-rerere.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git c/Documentation/git-rerere.adoc w/Documentation/git-rerere.adoc
index 992b469270..99f967b7a4 100644
--- c/Documentation/git-rerere.adoc
+++ w/Documentation/git-rerere.adoc
@@ -32,7 +32,7 @@ COMMANDS
 --------
 
 Normally, 'git rerere' is run without arguments or user-intervention.
-However, it has several commands that allow it to interact with
+However, it has several commands that allow users to interact with
 its working state.
 
 'clear'::
@@ -44,7 +44,7 @@ will automatically invoke this command.
 'forget' <pathspec>::
 
 Reset the conflict resolutions which rerere has recorded for the current
-conflict in <pathspec>.
+conflict in paths that match <pathspec>.
 
 'diff'::
 
