Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E59273810
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 22:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758149556; cv=none; b=gfjSPPKEvL9F2IpKbVUDeJdIHYXU4UigQkzNA/vpYPYP66RU2x0vWSed3yfcjvhKNccwAP5Py8sZY0I1x8nlRHxVsJNnv0V0w08cBaS1FE/4/rDl57hXrvWwFJzKOfP41Frr5wQbTwLqH8c7UuvzxpJ/BZkfoY3GryNE6TbZrn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758149556; c=relaxed/simple;
	bh=snta0ZHxs+itjNS5do1eKzU3XwRsWAxG44owBn1tUYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V7CrZTGKhQMgZ+lV86lRLUvRcH8EW9rRAzsKcDnqH6LXT87ayRcadmWzFMX1zsYRzzryy/0unxwgbGVcltsQ197VVz+VvBcPMvytt4BfLSJtCtF5eCmULTQfWXH0M7I1YeaFQZinzVCjY0MZwZ4SKTOVPyDayVuJoV8DTUk0Rd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MXL88Bws; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UhprTJYZ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MXL88Bws";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UhprTJYZ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id AA242EC009D;
	Wed, 17 Sep 2025 18:52:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 17 Sep 2025 18:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758149553; x=1758235953; bh=QmXIF6Ju0Y
	LO/qKadyk4v/puJGNOvBUH55qEguh12Z4=; b=MXL88BwsdUXeCsQykMVDVxnMtF
	KpGU6gMYCrw4HXB/DpvOM/VrzqoWWXJVQwMAkGlNds43Mt2juf8pnv3d3p4RZwyu
	S64XaOQ4RmYuGmsbUTvGY9jtRHyr5U22GRK7yFDwiDzbLFqj9BMoeu1U9cKxNY5F
	lbSTt5blAq89ycO5IKCj+60GJe+Qgf/nyx0uzw6NEwmnUvnK9xfhD0RaaZdmpdQZ
	nWmf8auAhDZrvm3PjW5o9ONwjmySUO6ucPJRADvv5CBIDZs70R6fuQ+ordURvaV9
	jE80O43KI8uW3WuSfnrLFIrmRIwuzxyOUGvaEUeY+azxOkdtzP8aAqHdtcLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758149553; x=1758235953; bh=QmXIF6Ju0YLO/qKadyk4v/puJGNOvBUH55q
	Eguh12Z4=; b=UhprTJYZ21m0jTIWnZyGp0euVDABMWDenicAPAsmANnQB05ZgS9
	xN1H0osFAAFWqSt0pNgOHZ/5HPLcrUWgOSGkRJ6avK3nC5maRENqt7ZwREE2yu8D
	MayTz3L7GwQPKDViOQjMU1oxL1WFFEvfW7xS6x9a8PhX84dbPXl+i4DKdbqiT8pI
	BfWfD8HhW5yhJo9P6d7x6eab2AUS3kTtvZAn/ZyI4F5kaXeryyuo4Ls9ZTKCrIE+
	1oshFl+ZeNET/Htn/SNQH28qMSPaiMpeKFmtBkV+1f/MR6qYxmkqLUFqdYuvsQ20
	RVoaOXJJV4nxmx3xu4cC/cfYDf/Eg2uJ+EQ==
X-ME-Sender: <xms:sTvLaJJGv0g6p8AAmcQYvbf_B6cL9c8PLFKTcZBR_GBUgpZIwpS50Q>
    <xme:sTvLaArLgiCy8wuZ3XkUTFbbCtikuXOG0IX_sH4nPPJhTDxspNoJH4oWkSAY_kLKZ
    6N59VIjpC3Uqn-pig>
X-ME-Received: <xmr:sTvLaIKZ9LgCQG6tR-wKJPnENazd4fptR2sbE3iXfAiVYomvxv7Gj2QT8B5_ZDQB979T-1UOHNW42OZnzlJ_08KCOiTL5p5h2CtZJlk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmh
    igrdguvgdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hrvghgrdhhuhhrrhgvlhhlsegurghtrgguohhghhhqrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:sTvLaFTl_faQV28RoNpTB1OPUjjPrWAFoxQNu-eHy8BXRfhMwnvKAA>
    <xmx:sTvLaHt2kIvT6Kzm4mx1MicgolSRUiU9LpQoyhQNWMZtFcZNEqVwVA>
    <xmx:sTvLaGY8knCMsddfCmh4sFdueWfGCfQKtYVWGIapSa0zQNGYbpFmtg>
    <xmx:sTvLaNGcAGoq4kCcK18stSl-ArZ_vKOsIV-YVVqkLtUzDA7JIvBiug>
    <xmx:sTvLaKnnx-udto-N6bBnXPXoQuwKbfELbuPtvAuFLVJzXRFMECcvR6RM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 18:52:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Greg Hurrell via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Greg Hurrell <greg.hurrell@datadoghq.com>
Subject: Re: [PATCH] mailmap: consolidate multiple addresses into one
In-Reply-To: <4d47677c-787e-59ca-84f8-5ebf59947b0c@gmx.de> (Johannes
	Schindelin's message of "Thu, 18 Sep 2025 00:14:57 +0200 (CEST)")
References: <pull.1966.git.1756816258606.gitgitgadget@gmail.com>
	<xmqqldmubtnu.fsf@gitster.g>
	<4d47677c-787e-59ca-84f8-5ebf59947b0c@gmx.de>
Date: Wed, 17 Sep 2025 15:52:31 -0700
Message-ID: <xmqqtt10adzk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Consolidating to a single "forever" address is good.
>> 
>> It is a bit hard for us to convince ourselves that Wincent Colaiuta
>> and Greg Hurrel are the same person, though.  The only way I can
>> think of offhand is to leave this message in the mailing list
>> briefly and see if a different Wincent comes and complains ;-)
>
> I can vouch for Greg, having worked with him during our mutual time at
> GitHub that I greatly enjoyed, and can say with conviction that his GitHub
> handle @wincent corresponds to the name Wincent Colaiuta.

What a coincidence.

I declared "absense of objection is good enough" after waiting for a
few weeks, and applied the mailmap change directly to 'master' this
morning ;-)

Thanks.  It is nice to be supported by a positive confirmation, not
just absense of objection ;-)

> I can also guarantee that you will enjoy hearing the story behind it,
> although it might require you to buy Greg/Wincent a beer or two (which I
> guarantee you won't regret, either).
