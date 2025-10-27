Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC123090CE
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577800; cv=none; b=oW4RYtqG0qICiGQne/LEcNbaWB/C+ftVVWEGSIaCDQlG7Nm0NYOAEMVToerqn/nsOFTzatcalOhAO0uvVoSgB9THLS/wcaGi4e5X2TrAvVPS/HNtYVRsG2LLr7jXVjk9lJmpY5DAEY1EF0/dJ5ltHJcJfEjy+cGIsllIgTTET9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577800; c=relaxed/simple;
	bh=q9T7C9Ga5+wce8lEB+9srkXa79wdFBNG7NbEbmM1QaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C/SuIl0lyztHgRdSy2SdM/LsULdJkrxHmyp5FETeBupmk/jXirI9mip1RYSlxbPA8KTlytrU6ZagKuQPAV6Elta9d/ARLJMaO3k3iA3AbOoIp/Wdj0qEAbBvdQ912WLqKTe3eMQZueHnprjYIdFxkLUBVrQGxV8+4T6uudIMcro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NjrRXUG7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KxQc/0Bx; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NjrRXUG7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KxQc/0Bx"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 8C5171D001B9;
	Mon, 27 Oct 2025 11:09:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 27 Oct 2025 11:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761577797; x=1761664197; bh=gXTcEq7IT8
	uohjHMksgvFq9FcTK02eoZdleGZHP7ddg=; b=NjrRXUG7NZuVOfCEa6yrj9MwrX
	D8XayHgEV87mWkCYD+FK0VwfJc8C8BOhW4G/3jDNlaRpF12JOenyDqJ/7VODOFE8
	scfDFEYuBsLjb5M6Sm14Q8U8Q8wOr+XgYAp03aBeJzy5/Ej81ksAMhC7MHTj5L1i
	jK0gWoXPZ57vPhfAkJO3q68dGr6QDpe4KZof6B+eTM3IAKsqrRvriewfD+DdAiFQ
	2WzgvZA5fyILJL0v6lx+/y16eLKpwzpAek9D3wFUm6uJCCmZ6cnqfmOrYwXvv3lM
	+UiOx39hSDMhk6N0zE+Og7naDn2b++Tm6+oR3HLa25FncRbjrI1n2ZdpUtxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761577797; x=1761664197; bh=gXTcEq7IT8uohjHMksgvFq9FcTK02eoZdle
	GZHP7ddg=; b=KxQc/0Bxo8+X1UGDuqEyUdWrRQh7vZDA6Y2LU/tVQLahfxcTlV2
	HZPNFGZKpDES1dHDQyh+XeZkEaWZ5ldzSLYcUicTLifTd6EXS1D06Q4ZYyNdD9IN
	AHHQJccIv2knFFFPjLaQfoQYJF4vS8sVdzFo0Cz0axsOKC9JuVIY0I9jbSZyYSPk
	TDHMKegI1TsM+eV9gs8SylgHDDkyXRQYxoF/LaxIQv4HA9TF2BoYhmPOJmeE5swP
	xNi6hNfA5IJCLLY4+sRCY9ARRBxIHIxD/ymy+dokEXqw+VBkgYLGh5arFUZuzyom
	VfGl+tTyTdXmwzVR+nCa2Fpnjql9DVUP2kQ==
X-ME-Sender: <xms:RYv_aC0khKljLtqzA8w0h6VeUtYLbN6wrUKhX-qZKAzEslvs0tAbOQ>
    <xme:RYv_aL-7bGDFmNYcIELS7QVmMX0Bi0TH28jqHiz6T1CDMQWmKABntAFlj-OJpPeJV
    jY5u_Up5ksRkz1U7Ne26pI69n86R5A1u-iPUC3QAbVtFIX0eaX6aBM>
X-ME-Received: <xmr:RYv_aDMdIBiekyh1bF_eJJdkknyDGEmCgTKxO1B7i-jUgznJptZes5TRiEsWtxWOxh5BD8bB3-axkHF0t3kOnx51haPZ6JTfIVFE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheekvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigf
    efkeevteevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepqhhjvghsshgrieeivdesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghh
    rhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhsmh
    grnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:RYv_aPdqjcqDNDoJcoy-O8NQnxv0I3wejTjoo7X5o3X5QsOPoONVAg>
    <xmx:RYv_aCUyGk8mwyS_9gmsA01LXRK6gGFsgh7eaTic6V6hjQ9soL25cA>
    <xmx:RYv_aHjxTIsxoFvz3KGeP1nvKYoOs43xq1rFDgJD0bDcBm7IzqAm3w>
    <xmx:RYv_aB_ojXGZR6LCW1tQqjHdz6NwMDucbj5hRTEOERNo6BgK9PvHzg>
    <xmx:RYv_aOuHK2Ga233TcpQNoA6wI_8Piny3cfGBAiRRix1CdCRBbdem_dHi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 11:09:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: QueenJcloud <qjessa662@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  usmanakinyemi202@gmail.com
Subject: Re: [PATCH v3] MyFirstContribution: add note on confirming patches
In-Reply-To: <20251027111600.1481-1-qjessa662@gmail.com> (QueenJcloud's
	message of "Mon, 27 Oct 2025 12:16:00 +0100")
References: <20251027111600.1481-1-qjessa662@gmail.com>
Date: Mon, 27 Oct 2025 08:09:55 -0700
Message-ID: <xmqqms5cl6t8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

QueenJcloud <qjessa662@gmail.com> writes:

> Add a note after the `git send-email` section explaining how
> contributors can confirm that their patches reached the mailing
> list by checking https://lore.kernel.org/git/. This helps
> contributors verify that their emails were successfully delivered.
>
> Signed-off-by: QueenJcloud <qjessa662@gmail.com>
> ---
> Changes since v2:
> - Distinctive/correct name to the email
> - Added changelog note after '---'
> - Removed extra blank line at the end of the section
> - No other text or formatting changes

OK.  It is a bit unexpected that you have picked a less name-looking
author identity (it is more common to use some form of your real
name around here, as described in Documentation/SubmittingPatches),
but that's OK.


> ---
>  Documentation/MyFirstContribution.adoc        |  6 ++-
>  ...bution-add-note-on-confirming-patche.patch | 39 ++++++++++++++++
>  ...bution-add-note-on-confirming-patche.patch | 46 +++++++++++++++++++
>  3 files changed, 90 insertions(+), 1 deletion(-)
>  create mode 100644 v2-0001-MyFirstContribution-add-note-on-confirming-patche.patch
>  create mode 100644 v3-0001-MyFirstContribution-add-note-on-confirming-patche.patch

You didn't mean to add these patch files, I strongly suspect ;-)

> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index 02ba8ba5f6..95f96b8451 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -1153,11 +1153,15 @@ NOTE: When you are sending a real patch, it will go to git@vger.kernel.org - but
>  please don't send your patchset from the tutorial to the real mailing list! For
>  now, you can send it to yourself, to make sure you understand how it will look.
>  
> +NOTE: After sending your patches, you can confirm that they reached the mailing
> +list by visiting https://lore.kernel.org/git/. Use the search bar to find your
> +name or the subject of your patch. If it appears, your email was successfully
> +delivered.
> +
>  After you run the command above, you will be presented with an interactive
>  prompt for each patch that's about to go out. This gives you one last chance to
>  edit or quit sending something (but again, don't edit code this way). Once you
>  press `y` or `a` at these prompts your emails will be sent! Congratulations!
> -
>  Awesome, now the community will drop everything and review your changes. (Just
>  kidding - be patient!)

Will queue without these two extra files.  Thanks.
