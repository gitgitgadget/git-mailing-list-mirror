Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A0E433B3
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581479; cv=none; b=HhlOj2X1gMW/0W2QI0EFnj+UuLx2v7BKC1KHPikuu8j9rRrhvMnqUPXJKnQWQ64FXa/MYB//34lbsT1yWZJzkY7SQYmQNzoJIuVFNvGoI9Ske0xaFpmAjCqWDjl2ilx/JnCAz1CSF6NwUUq8nfwRD4sU1Jur4PM+DH+H/+Jq1SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581479; c=relaxed/simple;
	bh=92H9vcRfFU9M0Q8Fx5BWvt/QLNj9/AQ0nhroFKLsBmA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RwZpbtTqtqY5ezgUZtPV58c36ohNKShH4NngTjfhZsj6xkmJ39oUzIuVxGKk7dOhHJkxe0EBEEZ+jdah3nNFU5U1MT2sme/AyePmwCC1G1q0MeUTU/Z35wSdR8CpH5GGjPxGGx8RXoPnIOh2G8+cszIazpfZeIiQYJ5POZzKfcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ynh6eV64; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qguHaSAV; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ynh6eV64";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qguHaSAV"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 002601400086;
	Mon, 27 Oct 2025 12:11:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 27 Oct 2025 12:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761581476; x=1761667876; bh=zCg774s7g2
	3EaxQ2iVxukh44QgyBdTCaBewJbu35We0=; b=Ynh6eV642LuUgKYjK2vFC2CUHI
	7gS++q2wKJqhekHXZxLBRLV0PsgmO6lkh/fomUX50FeFXhyr1nQB9WuCPZWgARRZ
	FKBoZWtiZ+f6vQ/X3Bo8duCPYMck4NVlcLDyy6ZqWSv4+pMcQlP7okKLVZjo3rC2
	IrwYXsu2ugyQ+0h43uAzbQqlQ1rjmuvBOjcIyCmRjhswaBoPSLcBC4P0b0GKNjsF
	z2+0Sz1UXkXOCZDcyQXF6D6Lzad2s2jkr6fEs1Dwpf7jOEoyetmjN51qz8ofnJvC
	S5txgyS8CcKswp2Yg0pOTZFHxXsok7LHZacGGMq6PnWqROtfqgsooHeaxrZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761581476; x=1761667876; bh=zCg774s7g23EaxQ2iVxukh44QgyBdTCaBew
	Jbu35We0=; b=qguHaSAVgb+RL/C6xVg0yZ+2pIh0Q1i/MFEpslg6DFp/+SlMFYU
	eFaM5nP6FzGLlOTGAGCSGe/vRhbSFEdVvITfYr3rTfODYcXhQsorHQ9UKPW0tCBa
	YgbrqerkQcR7Vo8FIC9wj4/CL1MMEyjK1oqcBz/mX8E+S0LLy417bL6niGR6tq6z
	nef4yZEhhkUFIdKFzuAgzca6eEtVb/4vjryij7fSy5s8RmUqqQQLcR0xIa45avHi
	NcTIMfwYZ6Tx59aZB4GV2ron4NYZJcNfDcF8jWBsvZDJLK1N9VUYq5QzUAIgELba
	uHY6ZqGoE09kRQs0h0dYdnYX5FqnE/0PqiQ==
X-ME-Sender: <xms:pJn_aK8j_DFO7HqKZ_j4y66eza6JdtddmkQNF4LELXyvcAYyJgAJZA>
    <xme:pJn_aBlS65JOKwdZ7sadbo97pVR84jjBBG_oyS_l07yPdilxiZRMXp8Dl1BcC_F62
    k1xpnmyzBvdDh8SIfSS48uV0GcyuYZDBrXUVEkiPMFysfOQIzgqWIA>
X-ME-Received: <xmr:pJn_aIX9EvqZpHjjNdbdvyuoOxa0xpH6nLWUQ2lHZk5s_Fg6TCAi7OTKGuPhO2gprIcuP8GLvSmJI11Avr3PdZzmv-51U5I0LxRr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheekgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqjh
    gvshhsrgeiiedvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:pJn_aOGZGBw-FNBk6XKq9iM4nwAoLT5S-Rr10OPaGyImIRDr3niBlw>
    <xmx:pJn_aMdnOz8fmB3WgSgBg-_6WPY7Fj1ol_U4iJdOnj00R8zuzINhtA>
    <xmx:pJn_aHJT-IwKTCCDFCH36hCg33-Fas5wbd4qMxdPebVjiA1Vsm6bnQ>
    <xmx:pJn_aJE7BUAyAntxZV5V7fJy655I4Mx2xR1MBWHgZ_-IoS2vflvYwA>
    <xmx:pJn_aI0immael_doOYrESmEQ2Q_MjI_PXYUxTt7O6j0APRo2crL8ORdG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 12:11:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Queen Jessa <qjessa662@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  usmanakinyemi202@gmail.com
Subject: Re: [PATCH v3] MyFirstContribution: add note on confirming patches
In-Reply-To: <xmqq8qgwjpo5.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	27 Oct 2025 09:05:30 -0700")
References: <20251027111600.1481-1-qjessa662@gmail.com>
	<xmqqms5cl6t8.fsf@gitster.g>
	<CA+JX8Fq+HwKX0Zkf59kiC=GaQwFJ1DPTgHGVnJ25t8c8vjw9yg@mail.gmail.com>
	<xmqq8qgwjpo5.fsf@gitster.g>
Date: Mon, 27 Oct 2025 09:11:15 -0700
Message-ID: <xmqq4irkjpek.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> I can make the author identity and sign-off of the version I queue
> consistent locally before applying to save an extra patch exchange,
> of course.  But now I am not sure if I understand your preference
> correctly.

For now, I'll queue the following for this topic.  Thanks!

----- >8 -----
From: Queen Ediri Jessa <qjessa662@gmail.com>
Date: Mon, 27 Oct 2025 12:16:00 +0100
Subject: [PATCH] MyFirstContribution: add note on confirming patches

Add a note after the `git send-email` section explaining how
contributors can confirm that their patches reached the mailing
list by checking https://lore.kernel.org/git/. This helps
contributors verify that their emails were successfully delivered.

Signed-off-by: Queen Ediri Jessa <qjessa662@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/MyFirstContribution.adoc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 02ba8ba5f6..f186dfbc89 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -1153,6 +1153,11 @@ NOTE: When you are sending a real patch, it will go to git@vger.kernel.org - but
 please don't send your patchset from the tutorial to the real mailing list! For
 now, you can send it to yourself, to make sure you understand how it will look.
 
+NOTE: After sending your patches, you can confirm that they reached the mailing
+list by visiting https://lore.kernel.org/git/. Use the search bar to find your
+name or the subject of your patch. If it appears, your email was successfully
+delivered.
+
 After you run the command above, you will be presented with an interactive
 prompt for each patch that's about to go out. This gives you one last chance to
 edit or quit sending something (but again, don't edit code this way). Once you
-- 
2.51.2-678-g0cd646409c

