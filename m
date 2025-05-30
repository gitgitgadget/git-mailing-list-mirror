Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D369F2D600
	for <git@vger.kernel.org>; Fri, 30 May 2025 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748625367; cv=none; b=RD6i6KnTIRu4/+6uZa2AjQFk5wIQKJNrbJYTG0diJ9V/x83i6Etr00qjaqUIx9aGWC7OSq2/ScgP4N0h40wQUesXaqFQ7vY7JbYEu0qaYIU2B4BgVs7k3G4dLiWx+p2e61OyuQLjyQ6nN3NUWIsIuxhIE0X2ZYuql7MoOWUsFL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748625367; c=relaxed/simple;
	bh=Ymy4E68AHlf01lLx18A9iFLPmgAyM1crUcI9gxQa+80=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GfwYoU2hMEvGKUa5RH29SxWqL9O7G0NdDzZTumf0BO2u5bDWh/NijueNvWe3Ls1Xl+JwTwLHg2uJ2jDCCV8eu+jq5DLoscWqAWkU697q6xzq97iY3SY931zYvBlwk+ZVJJht8p/SbUPEffkzqaeqiAIwyWNbgRYrd35Kjod1r3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kQeXOBKg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YEw5ShDD; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kQeXOBKg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YEw5ShDD"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B59DA114007A;
	Fri, 30 May 2025 13:16:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 30 May 2025 13:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748625361; x=1748711761; bh=W7VK+LrPnp
	MK9oq+D4aLOM+42UfU/nwahYa+KLlK/Z8=; b=kQeXOBKgjEyedsw4W8AU76d9mP
	DqjmBdqQm6j/RotK2ZaXGepyWoPYTJC5cEmLpevgaT2mDpDNytUIypx2dXqbaofX
	QsRfLSjGiQfMM7fQHcPrPGK/axbD9HqLCb8avq3rLf28EOVky4R/RcqC58XRbUCS
	AY0I/i3G0donjzbkOInns4YAU7us1Vs9bXLG90cpeEyzzO3pqikcrkCZUw3Bqwab
	7RZuJwHfIS8oZlHB4ViyZokeisYAr4DapHmPhs8qTJcsFdSnNfDyoYV2BJHMokcR
	lg/fFB+NKFPGhb/BedbcUduvrg7PrH7c+lpzvoDtQsB5lB5xtNqwBZjx96Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748625361; x=1748711761; bh=W7VK+LrPnpMK9oq+D4aLOM+42UfU/nwahYa
	+KLlK/Z8=; b=YEw5ShDDjD4YRFY0x0F9hmmnXKdOb50kpFVC5KsMpLdNEAIi197
	3Mhl22/cQWNqQR7E+H2rqfo2rh+s7kNlGw5JZfXrMi0yrX7TEv0IuFVnFP0ETh8Q
	8Fp+afqzjrIYsUMRGCvrBiJiv5WGex8OlnN3zMDSi9iBDeGfNsO+d/KG7BEKXhjc
	u6AizmFS2bAKZ+QtxB0++KxjURE2nOnZI25D7GDpkALgr+ZjlVU0zRDeHSD3AeCF
	BDgGorcpNOj26cmG9gVqgKKqEJrqLm7J8n+vofiph8yxYONDCCKbN7KMhoHEuSoV
	GuF/hnU21/5cJbUHABm/9WRSt1AX5h+tJTw==
X-ME-Sender: <xms:0ec5aAnd8kYkigS9Z8bTZumG-a7ceGy8iJQpZ3MKKLFXDroW3zdNGQ>
    <xme:0ec5aP1OQEJUKRsMsUhKex6drFSBjGlAOdrOzq675vZPXgMQgJ8pu8RcOQde16zQp
    v8JMalD_IYcM4sdbg>
X-ME-Received: <xmr:0ec5aOpH9Sr5yGgkgIG-zN7PXFE16LUz177AaYJNZdIVIt7_GAgQv9boLnVoDosy4mp5ifTdBA9lf5UQN7sDIKOkQR6zYCIzAYyXLrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvleehleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeltefhleff
    feektedtteehhfeuudeukeefuedvlefgfeefhedtuefghfeijeeftdenucffohhmrghinh
    epohhpvghnshhslhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtth
    hopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrghgrughithihrgdt
    keeslhhivhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehjuhhlihgrnhesshifrghgvghmrghkvghrshdrohhrghdprhgt
    phhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoh
    epiihihigrohesughishhrohhothdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgv
    rhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehsrghnug
    grlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehjohhh
    rghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0ec5aMlGpyVBMX_xdmIxkNW7E82Z_uZx6Evc3MHKBF0MuILkLf3kYQ>
    <xmx:0ec5aO19YR00pJaYjcu-YhQruUXPukywnhkROgBJPwff8oIy3oK_Uw>
    <xmx:0ec5aDsoCDc4p_cnIxpN4s00a3LcePuJTUXCbv1eZ2wchmZmDuDZiw>
    <xmx:0ec5aKW0n3X47V4jB8esqLcSE5tY8HSkjWXKN2EqDLC0ayvVTgP5Kg>
    <xmx:0ec5aAIHTXqIebxstIwQ9hQk1drRICP8j3OqwDFiUDP3oTRfKFt6EWtq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 13:16:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Julian Swagemakers
 <julian@swagemakers.org>,  Eric Sunshine <sunshine@sunshineco.com>,  Zi
 Yao <ziyao@disroot.org>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "sandals@crustytoothpaste.net"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 2/4] docs: improve formatting in git-send-email
 documentation
In-Reply-To: <PN3PR01MB9597DEE8C41CB1599B9A97CEB861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Fri, 30 May 2025 13:32:14 +0000")
References: <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<20250528070521.17379-1-gargaditya08@live.com>
	<20250528070521.17379-3-gargaditya08@live.com>
	<xmqqa56vl1uq.fsf@gitster.g>
	<PN3PR01MB9597008B30AB91C9539E7C8CB866A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<877c1yb53w.fsf@gitster.g>
	<PN3PR01MB9597DEE8C41CB1599B9A97CEB861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 30 May 2025 10:15:59 -0700
Message-ID: <xmqqbjraf29c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

>> But I do not see any link in ...
>> 
>>>>> -    by 'c_rehash', or a single file containing one or more PEM format
>>>>> -    certificates concatenated together: see verify(1) -CAfile and
>>>>> -    -CApath for more information on these). Set it to an empty string
>> 
>> ... the text that was removed.  The reference to verify(1) is a
>> command in the OpenSSL suite, right?
>
> If this is a command, its not phrased nicely imo. I'll just leave it as is.

In any case, there isn't an link in the document that is dangling,
is there?  It is not like I am trying to prove you wrong.  I am
trying to see if the change you made is still addressing a valid
concern, and if so if there is a way to make the result better,
possibly in some other ways.

I agree with you that this passage is not nice to expect that the
readers are familiar with what appears in

    https://docs.openssl.org/master/man1/openssl-verify/

where `-CAfile` and `-CApath` are two of the command line options
described there and has "more information on these".  The
description of these options on that page redirects us to

    https://docs.openssl.org/master/man1/openssl-verification-options/

and expects us to scroll down to #trusted-certificate-options
anchor, which is doubly unnice, but that part is not a fault of our
own documentation ;-).

Perhaps something like this would clarify the description?

 Documentation/git-send-email.adoc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git c/Documentation/git-send-email.adoc w/Documentation/git-send-email.adoc
index 7f223db42d..53f30fccf9 100644
--- c/Documentation/git-send-email.adoc
+++ w/Documentation/git-send-email.adoc
@@ -267,8 +267,10 @@ must be used for each option.
 	Path to a store of trusted CA certificates for SMTP SSL/TLS
 	certificate validation (either a directory that has been processed
 	by 'c_rehash', or a single file containing one or more PEM format
-	certificates concatenated together: see verify(1) -CAfile and
-	-CApath for more information on these). Set it to an empty string
+	certificates concatenated together: see the description of the
+	`-CAfile` _<file>_ and the `-CApath` _<dir>_ options of OpenSSL's
+	`verify(1)` manual page for more information on these).
+	Set it to an empty string
 	to disable certificate verification. Defaults to the value of the
 	`sendemail.smtpSSLCertPath` configuration variable, if set, or the
 	backing SSL library's compiled-in default otherwise (which should


