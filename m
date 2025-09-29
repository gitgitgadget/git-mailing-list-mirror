Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2441B424F
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 22:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759186012; cv=none; b=mVffMJC8tm9ekTNumcmp/OiM2yyQ2O+Alhod4mHGjbRrAl+c70nAn69TaRD2AXZ9REn3T8yEnjtcE90WzVnbMkylLTOTnOT9RTsSFHKznhuPZCIHPzejBbsl+Jb9EJIHZCyM3JE/9J45QD4Lpd6O37TYyIhSi0WxDIikf5Y+q2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759186012; c=relaxed/simple;
	bh=cjxRhexdh7zzJgq5LGw0Nmuz7/zAtBvFMZvqzEWk2sk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jM1zbBF7JO3+AkW30A/XsvCX4hmKenR7hW614LOfDZrte9QNJ2ZDLoEfKEDhYRHJLLHg724w7a2MqJwE72HPzYLLCOSRE+IfyJ4l0V8FOPmlqHK6GmwNlWEU66AdotbZO/S7uHpvwyjIRF40NDS+Lt+CyfcIkwAWwKRt2j0G1r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KZHw44fi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KbCA6xYv; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KZHw44fi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KbCA6xYv"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 75A3BEC01AD;
	Mon, 29 Sep 2025 18:46:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 29 Sep 2025 18:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759186009; x=1759272409; bh=cjxRhexdh7
	zzJgq5LGw0Nmuz7/zAtBvFMZvqzEWk2sk=; b=KZHw44fiLdUmcokqKVC0AJS8XT
	bxUGOaWQyWYEcNPJVULoPkIIW0hpb/Q1SlFRua/RZha3K0ldiXY7CVrmyKAPLITJ
	SPBufmsLXRvBQwunUKoPO4gOowVbPYvrQDBG97qYiAPS6lnG1nxvl7g7nJ0DoovX
	pKUp0gI+puLvjaEuMCRFvtPstyzCHO5an1GLH0/CXhAW7Kl7WAFje4D9wRbKhETE
	x/+boBqOrNg3PkA77VLW6De+Hc3iKGagj2CWegLtt9x8W7q3uuD0CsPBsOaVKq6I
	QRRIBqcvIw3h67fiRfsBb4tEq3x2BlLqQE+sGEYVhinHlgZvW1FdNkFwEzZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759186009; x=1759272409; bh=cjxRhexdh7zzJgq5LGw0Nmuz7/zAtBvFMZv
	qzEWk2sk=; b=KbCA6xYvdYR4QTzB29JapJ6GFfXu5Hxhu/sCFhnPDNT1Op9wGmw
	4r5fzFHXV6fmZRaBmp3FlF0SgOEwCVmuqRCOQbXeNkedboSEykP6SsbxuEt0bIHw
	MwF+6DKb5Mh8AocEWX8v1Et228PNeW19yDcSee7kBTaT/dwM7XOJnZj6z7uB7afW
	HAktQBUgwbqbZ15llCIq7zOaU1kIKbNH0YK+or9pun5PWXLP6H6OSeGzQimMd+Oz
	52TNrM1WxKau/bPpxdwYNOG2U6CniuHlbFPyX4XaXG2dzromLsknRHMUNmj8oyXs
	BQ2EINTG8YWfWODbW99dWshwdWiRGvMWGUQ==
X-ME-Sender: <xms:WQzbaOQsWMGiHucwjS-LOnP2cPrqqnBqb1BFIXEt4TnfkwCsahQPSA>
    <xme:WQzbaKy1Pgg3zDQFjHhGJrmm7YwciUFttdCObbwyqcTXCDEyIykyXcEo92RUgUS1n
    EVQyF0YrjyCzXcpVgqv4_4GUCQ5UesNyO333VOiaymPi8CXB2OzSbo>
X-ME-Received: <xmr:WQzbaA3wZeo_mL1utBV4Keez46xwWtITJphj4euZPp0yJN9cA2FRFmJsRMK4rYnN4mcT6O9Fl7mey8Y7WZ0jeUZGBwc9R41x1vtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejledvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:WQzbaI7xLs4p2MrVIR3_RGSfWFerTn64l38jFR4N1yxLJlvq5DMfhg>
    <xmx:WQzbaDWjK3d0aT6N3YxSJJwQmDOYw346jwgZCOR2MMDnzDS5VkLwDA>
    <xmx:WQzbaHBpqKtjTFd9472K4TMHs6d7YPfPr9BX4uIh25jUxusKwRBUrQ>
    <xmx:WQzbaC6YmkBiMol0JjPGIWjOHTkr2sLP7IV9r_fXWaHZGbG5pXLFiA>
    <xmx:WQzbaAH-tz6sxD7Gm4jkc7mPKAWbXZsNoXGpZx4DWPZjhnNUxKjQJr2->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 18:46:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org
Subject: Re: [RFC] How to accellerate the patch flow (or should we?)
In-Reply-To: <aNsG5Jd_YLgrwarI@pks.im> (Patrick Steinhardt's message of "Tue,
	30 Sep 2025 00:23:32 +0200")
References: <xmqqldm0am4b.fsf@gitster.g> <aNhX9AJ/zq4IYhmW@nand.local>
	<xmqqseg777k8.fsf@gitster.g> <aNsG5Jd_YLgrwarI@pks.im>
Date: Mon, 29 Sep 2025 15:46:47 -0700
Message-ID: <xmqqqzvo6fmw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Despite the potential awkwardness I have to wonder whether this would
> even help us with the goal to speed up the overall process. To me it
> rather feels like there's another step now that a patch series has to go
> through, so my naive expectation is that it will rather slow the process
> down even more.
>
> Am I missing something?

The above is an effort to reduce the chance/risk that the maintainer
is *not* made aware of the fact that a topic has already been well
reviewed, or the latest reroll has addressed all the issues
previously have pointed out and the reviewers are happy with its
shape, and ready to be merged to 'next', just left in 'seen' labeled
with "Will merge to 'next'?", etc.
