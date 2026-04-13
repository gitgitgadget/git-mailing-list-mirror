Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66F024676D
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 16:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096173; cv=none; b=fELdDXbblFz18xNfMmFtKaE7PvWS23iTKLT4R9AZdOjCmahdIsDHQ3wqbbYXqajVTgKdp9rM4A5Tj8YMzaaXUYlLz3OPlwN9HvT6z/qNVFjvxSRpaWClss7NVVKQXFc+JL79xmLt9pTDmhS9aIgbMWHYfyx/EWv37famCvbHLbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096173; c=relaxed/simple;
	bh=YohpVWYl0658yl2oOnu18ttXNno0NbkHQD3O7J5pTR0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IGmYRWPlKomcW3uXt5gMi2qBOf2ps9Cbb5YOG3hMqaLD34XwIxndAlcVnoABidKzCtsTYZuA95kswNJ7dOrcp9Th/9Monur33YDl6RXsuYJWeH3ctKLtwPOUCPrgSPDMS8Pyg4aEId5ar2ZZ2u57u7e0ciGtso9N3FBQjcdDrDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MSM6uEix; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EpZ+nEZx; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MSM6uEix";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EpZ+nEZx"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F24D57A0063;
	Mon, 13 Apr 2026 12:02:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 13 Apr 2026 12:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776096170; x=1776182570; bh=fx+yyxdpWJ
	e6drFlScFhpQZcu1+fGdtrbQoz4MK39yo=; b=MSM6uEixo9JxbK5EGi739LIng9
	9yhbCg4WZbu6gCDJx9U9LJNlxZvJtWacjaZaBL2UN0vn9jllpVbKW3Tg1nqqfPYq
	KikS7szAREDHapcLrjYkd+kFFMdf73vQTf/VoCKCvLz2fBx+729OSeD6k1CkazYp
	/3O0/gbIvNvcKmeLnrgWwv7GIakWC1nTP5r8uunqKAmYW5EfyCaKKM7r0GIj07Ip
	42hrj/r8Qiy+lCm1nwFH+eOxuEfVRnNKMLZ9hTzmmne7bxaCp/4++blip9TRZtaB
	E4piKvzSCxX7bfCiLRvZNLhEebe5BL1YCrsjrU+C5lPlLO0Qt1SV6ljiHRvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776096170; x=1776182570; bh=fx+yyxdpWJe6drFlScFhpQZcu1+fGdtrbQo
	z4MK39yo=; b=EpZ+nEZxBx7wHOHUN51KQx3+vJ21xIeb6pxAYDR3ZMT/g3DJkQN
	bbk74sWyo66FeS68UZWzcXP4rXgMNFIoLyI9PSulabqWRyTq2Kl1uUGyUQ+khFWc
	anHth8cCLJxVvYeyHNV1/Yr6Tpac+yvw09PHwW5RFnm7oTpYfK/O/7cTbltBjelA
	ryI4De74usnRgJF1SyNIppt/M8SfpjPRRWmfyujogzSrEFF9PB05qmGQvXgI+pYr
	CwtbCBevagJ95LBnYCTjWTA9UNEEEPmcjqT8rg3Tj31gntVWLFIvQJf9GyrIHWAv
	CqpoMLHUVCKCZo1Nq3NAvIvkzltunAix6PA==
X-ME-Sender: <xms:qhPdaSQqy5Pr_kiXoLH0_xA8AwwPaWn0TMTGBbGeGrunTzZse9k5Pw>
    <xme:qhPdafNAXziemyAY1dRFqW--PWe1rk4DQduIB_ZlaCRwXe5oNV0ADwxrdwCAiCPoz
    wZSdxtIjpiAEt--NV9Yx5dFdLC3i_KcZ0EIzYBg6RKVhH60YBsbvg>
X-ME-Received: <xmr:qhPdadMBa2N2T56usAmAIRSaggTIQT22ircMw7xnesqp2TRvlaIZOeFzRtEWMtepOiwxt6zCn4N0TAt66fNfQJnJ1gySXns0Tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehssgigihgrvdehsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qhPdaXvcgQlAq1rpJZMIcy_DwXLNjixqnzYv6ngV78Pu5viuOKqsDQ>
    <xmx:qhPdafXdJg4nYTWdJl9bDCBokIPftx6FHZcVIZXpiGd_HIHuhcpFog>
    <xmx:qhPdaXsgZBAXMHQ-FQplKnNSeyRZMGoShlZSlCH8h_AZB12Xg3w7Ag>
    <xmx:qhPdaTVgB_ngUbKbvTogzEKXRMEXt6N8ToLJ7XVabSPcXwwwPf6iUA>
    <xmx:qhPdafN4-aI-AyO0ZNdWPIKEy-2QvjFHJgI5niETfGtJN2rZa_yULXRc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 12:02:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Shibo Xia <sbxia25@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: How should submodules use different sshCommand during initial
 update?
In-Reply-To: <CAAC4ekqE0rGTeZA3fPKYePr3=J8pHe-KORgn5W026J8AAhRRHw@mail.gmail.com>
	(Shibo Xia's message of "Mon, 13 Apr 2026 23:45:53 +0800")
References: <CAAC4ekqE0rGTeZA3fPKYePr3=J8pHe-KORgn5W026J8AAhRRHw@mail.gmail.com>
Date: Mon, 13 Apr 2026 09:02:48 -0700
Message-ID: <xmqq1pgilufr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shibo Xia <sbxia25@gmail.com> writes:

> My use case is that different submodules may need different SSH identities or
> different SSH command settings.

Would it help to do "submodule init" separately from "submodule
update"?  Then you have a chance to tweak the submodule.*.url
configuration items in the superproject repository before the clone
actually happens, I would imagine?
