Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1153E44EB
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784582765; cv=none; b=s84Zst3vKm3EpB3/bZrhq0e1QDtuJpLclf3JhaZujWqSLTBpG29qTHJx96TuG1gGLy54fqvs1dMD9vonVdCx3hzGGxt+9s0719tOhrX1y9A3AmKFO6IlnD0sqHLcGCvKv7jnEq4YBmRWzPKamPGfAAKWhMgLRFRmbpIr2PbFDjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784582765; c=relaxed/simple;
	bh=+kvsJ9DuzT7BKDdZxCFIWS582DtCkvV71KdUnstppbg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BjLCNCJ4aEwU+fj0dSuVRd1zeVHMaQA28B64NV8UP0eGr41d6mvXMGxeVhNa9GQlgt42u7+5UwMXqC/DV54O21T6bKM00fEzuJlECW2ogtWFdgtGAy+miIS5xDPNMGSdVB4QE18g/sceplYoLQcIeiIN1yPoDsUWP0EsUclu0TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WwCKfsZ9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T9Jiqz/y; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WwCKfsZ9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T9Jiqz/y"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BD52F7A00FF;
	Mon, 20 Jul 2026 17:26:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 20 Jul 2026 17:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784582762;
	 x=1784669162; bh=iCZpQUBFpXFsuzbKPXLkDC1yKQ97IFr7A2Kp7oAQV0A=; b=
	WwCKfsZ9X7vmH+4Th553dJmCa7o6TqW4WvbyV3rxVLs6qwFfXCJuY4+rTEJL6t0+
	4UxXchehhbm5sS5Z2UZlshhtennc0byBE2+0gPDLObqe0N09D81QjRBb9OiNteWK
	O9LgedyEIi0TzxLLozKoIRQlQwsMG5msfYljahBFuLLl516OrFGEnYSe0CrE+V/q
	deRxANeOPoRMTzpjv6fA3ZO7Gx5a0LmR/KghmvLXU7Up8g/+4Y7EbfJu3scO/Pjn
	wJAFPyokS2Ysmb+/n9MNYfrravv2txqGZ0ncGf1XD1L6b5tF3wNFkd5sIe3K43JJ
	Z7IIDliYfWtgQPKH+wtjog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784582762; x=
	1784669162; bh=iCZpQUBFpXFsuzbKPXLkDC1yKQ97IFr7A2Kp7oAQV0A=; b=T
	9Jiqz/yExiaPK9O9BdNONCowBCHmioBZB+2O/ecNoDUApSQ+ugr4gFqtOC5jPE/f
	uO5TFQqsywOBvFUNGLn6mCKJT098vE0RrGD1xRM+yfGrayE7kL9ZCTA0O7OXMoYF
	wGRHkzYjdmPtsOSf9q2vdR14nHHNvbc2vbRm83q65SyBU/TsZ9mhvgfZmTwf8C6I
	5zIJUTA2MtCUvrVDhGN+cgB7A4OuS1UkDYk5YMG7gh/2UaNqyJA/77hyxXpJ9B5O
	PnUsgrKir18/mg8bIVT5mqrfmTwvNRQXyXY06HunvFMIEFdICwHJTTqvP1vie74z
	sBlibc2h38V5GpHNXI+Wg==
X-ME-Sender: <xms:apJeal9JCX4n2tqXLUIVx3Rlg4KJ71w534CIVk5KJwhXzrvnquaI5A>
    <xme:apJeagtYomrFVWcSw-dsoNB86tpHyYm6HPNydS6QIdp84W1m9yCNDtvktyHYdhFL0
    kr3gtnXJihrrSNwrcIhGCEFuYPixqdYBEaFPntoKxEJlxb9W3dQ8w>
X-ME-Received: <xmr:apJeaoBsR2TlolV1EGV8V40TybMotz7nMpUbwY5TeLwwvbDpaa9ljs4CpPxQmv5sXcoMPHOuWRCJAwU8DNC3CjIDHxCXXxzt9w>
X-ME-Proxy-Cause: dmFkZTFFFSgcX4xO1SkiSd7bmtYzQlKVksVFmclmOuuW1DE4J0VTRyyu2zpDJhlwApGues
    CKRzVkzI9pbOo7OTquM2uxRmllyF5iN7y4kaXEVVLOphUitd0DHqul4BC32LzNPqT/54zj
    8wMM1ks4N/CyMPNFq9b25T7QqpOfgWVz1go+5vHuKQcPHZ0BeGcf1TTlrl4HdUEv3/R+S3
    VRSs7+AggaUlG/LEAhdB8ZKT9KUVzmdqAkOUD1nUIi+xcH0GEF7OigPAGXZ7/1onOvJ6JU
    oMPpNMOtDzqJGmUGEkUsx+97GgHW1RONrA5NrIrIgoWpVKc2ErvqLQT9PFVUSuOU1gvPnW
    mDxD7fke4GKvBv+xGgfqzDVNKgKGOzNluKNcqOdsibmyNQmH/fnMW9xdA/JiC50iAygsqj
    E6WAVdYdg+WikGdmIpozX5MWbBtSzTTLRpkOxPQMAwN2I19ohc7L1trAnGvpYnwxOpvi3J
    6nAWwL0nIkTfb0Ou+lwKwjbYH+RQmGfVjPGhWsPfPLoIM9LVqLVr9JbfUSLW30Epz8ghul
    2HTnb3L/PtbCFXJKqSfki8CA9Ss7/LQaMv2RtEy/CuF0ugVSkKipPcCEBBVPbOTOscBuft
    fcbzswiwzt60JuxpCM/x1i18JgJaZg2HKimim3Dglx3Dnvsl9dQVyu8B8Y9Q
X-ME-Proxy: <xmx:apJeaoVABL3ewFzkFFGN7o6GAmqEaT2GPjNujOYF5TlwYs8RH-zBwQ>
    <xmx:apJeamAspMpvMZsqRP-WB3cOh5djHbGx79CTCA3hjDsnsjnLePHGXQ>
    <xmx:apJear9y2z6U7CB_5xYjD857JrPCnzMEHL576xOWM6zArBkbaFQzjQ>
    <xmx:apJeatGIht5SYNCSkVdunjW-fE-PC1RASBSViT8XE3pzw6SUofPG8g>
    <xmx:apJeakAL3lI6NQ2nERJcnS4WPEvtt3GiZBGdBNbN1cFaUIjH5o8wfhti>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jul 2026 17:26:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 4/4] doc: convert git-request-pull synopsis and options
 to new style
In-Reply-To: <23179740.EfDdHjke4D@piment-oiseau> (=?utf-8?Q?=22Jean-No?=
 =?utf-8?Q?=C3=ABl?= AVILA"'s message
	of "Mon, 20 Jul 2026 22:39:29 +0200")
References: <pull.2185.git.1784490878.gitgitgadget@gmail.com>
	<5b6e9bd3f3569cf9977d1cfd120a92756ec86b29.1784490878.git.gitgitgadget@gmail.com>
	<xmqqfr1eleyx.fsf@gitster.g> <23179740.EfDdHjke4D@piment-oiseau>
Date: Mon, 20 Jul 2026 14:26:00 -0700
Message-ID: <xmqqy0f5bbfb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël AVILA <jn.avila@free.fr> writes:

> "Widely accepted", I do not know. I would better frame it as "because at least 
> four is needed and I'm lazy, then it's four". I'm not expert enough the 
> asciidoc specification to have a definitive answer of mine, but the 
> asciidoctor specification says exactly four [1]
>
> We could indeed apply the rule of 4 dashes by default.
>
> Note that this only applies because it is a listing block which does not 
> accept nesting.
>
> I will reroll.

Thanks.  Sounds like a good plan to me.
