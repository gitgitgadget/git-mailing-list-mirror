Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD6F19AD70
	for <git@vger.kernel.org>; Thu, 29 May 2025 03:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748488449; cv=none; b=QUNze9H/rLWudJjvJO/jToQMN6eBQ7iNhq+Y59daU/vH22Aj2rDBbpjp0sQNkVz+QUp1MbrvZm9qKe8Yp53e04bwa6NgE8O36OrLiqE3GCMte0Eok6bqJUc4W135Pm35iGjy/jgbHUbfSmZREPrZrS5cmil/McloVH2oF9lwGaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748488449; c=relaxed/simple;
	bh=aEhCtn1+uRthodkKyDPeYr01o5hUzWWz4T/fZbl6rnA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g4Qz7W0kOodRqKhEILKsDhoGDboOXDloONlElnffpw3k0/mpX2A12rUn4aAK1KzRZzhAQJwRIGk4dqxoiwZXtqifDVvfSL47+9JAxW2753DwfTiDgA4D/lLJtrIcEazCWt4YrqGvfh7wRQXhL0UI0VARmct8gchqzAR5QFgBgts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hO7eoWfR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=piILzwWc; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hO7eoWfR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="piILzwWc"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5B5F32540124;
	Wed, 28 May 2025 23:14:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 28 May 2025 23:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748488445; x=1748574845; bh=UIefH0gURH
	R3kJM342wBmKVyIy0kfY/EO0PAw1RuMik=; b=hO7eoWfRoskvCwBl5G/1vZtuMz
	T2DHViiKSjqpmDL7/P3TJou8CggI92XO7tt026b3+3gp6OZF70QCy0Euu/+szOQy
	ohOXYjtC2SOEkaiDu5qnsC8XrWQVanJUXoZmDy84sWDphzt2dTshyUjrNet+nXYg
	TDw6eBoZAGHFApKlQwBIVvu1rlDxEp9HCfFiZGan8IvN5kK+wuMMulFETG8Cntt3
	f/OsSIgzjAI2ocwXMkqnV1LaamE/w0wjVNV7LvXRP+vDy/DeWB/9DyfyWbM37ozF
	zbJDWHpv8rnzqzJXUN7zquxsTf/CaQb2VHcwSoQ2teIripijMmT8a6eD8s8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748488445; x=1748574845; bh=UIefH0gURHR3kJM342wBmKVyIy0kfY/EO0P
	Aw1RuMik=; b=piILzwWcxfOCROwUdqMtZz3JiQpYjmjcQIgwAC0WYeZrxMYuDEL
	VaqGvqNJv9sj6QitFgN56U/AjlfOdnGKR6kZPzSbgFvAPt3fs0bi81yme8Pguw3f
	PlVHjh4ty/9AGCN9dNnYpOyqvs36E7hjaEmA0aEwoKOZzg6rivgs7LzOQNmxFxiS
	+0QSRXhy+D9POHJl3yseWmybTvfb6mmIz+gdB9xtagOH74yQSYuwPpRwhoNUWVPo
	Y8mcJzoNdeKqGbUyFQmkDD2zyBQVcT9IAc1w6kPbsTK1XeslpV2yPf4uGPIho2JM
	Xlp1r81cii3Ui0NGTd31L/x53aYyFtXK6uA==
X-ME-Sender: <xms:_NA3aEqn1tz0i54Q25AoI3g9L9RqmBDH8gQGnDgr_e1nCb8jOTIrLw>
    <xme:_NA3aKrS342RZUopjJHwlcH4iV7vjkeLrruG-YzeGDl1FuKMUND4jYN1XVG_VwyEH
    mJ3skjex0Ff_PR_Bw>
X-ME-Received: <xmr:_NA3aJPGqRfij_9-qJlq80aQXt-gCUSES2-j5olODQx4yJ7OD-DOAp03Y2q6ZZvJcJuBPMV-FEz4PZ4-Hcec3oQqp8pjOlm1nAtENIE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvhedtfeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhi
    rghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehluhhkvghshhhuse
    gurghtrgifihhrvgdrihhopdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehg
    mhigrdguvgdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_NA3aL4KGWpAD41kX-ySzhbl79VnRrRgD5tzr_UQCWOdeo7Id0T7pg>
    <xmx:_NA3aD4LvJORK6U_CET7M91SThuE9DsCfj5lLI4T6-NDbskN1d0-HA>
    <xmx:_NA3aLgZOXsBxOW9upAqCFVX3flPUQmOivCZ3cAKBIMX6zGgDbY5Ig>
    <xmx:_NA3aN7UqHw0Jjmj6CdUPCC8Z1a1jJl_sisEuU1nicoKTvZBDUhwMw>
    <xmx:_dA3aJnJobtUguUtOWVGTdU35n1-r35G681wBstaQRXkh6qJW1ebO31O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 23:14:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,  Luke Shumaker
 <lukeshu@datawire.io>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>,  Jeff King <peff@peff.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] fast-(import|export): improve on the signature
 algorithm name
In-Reply-To: <CABPp-BFRhSB0zTY1m+gYOpfvmuTvN5Pu3STawJwx9P-ayJw6bA@mail.gmail.com>
	(Elijah Newren's message of "Wed, 28 May 2025 16:15:45 -0700")
References: <20250424203904.909777-1-christian.couder@gmail.com>
	<xmqqselxtfyf.fsf@gitster.g>
	<CABPp-BHudzADoYdBvoBZ1yDRj7Ra_V-or6ddAOV6nmXeMMpMaw@mail.gmail.com>
	<xmqq1pthtbdg.fsf@gitster.g>
	<CAP8UFD0OdqnoFeYY+7y-No_x_DknapoLzvqvsy-+x_602sYQbg@mail.gmail.com>
	<xmqqzfeyqdye.fsf@gitster.g> <xmqq8qmgsky8.fsf@gitster.g>
	<CABPp-BGe6r-X7NOiBFEvLGZH+GQvLkOYWn+qf3ZzzgT4sGAyOg@mail.gmail.com>
	<xmqq4ix4qtva.fsf@gitster.g>
	<CABPp-BFRhSB0zTY1m+gYOpfvmuTvN5Pu3STawJwx9P-ayJw6bA@mail.gmail.com>
Date: Wed, 28 May 2025 20:14:03 -0700
Message-ID: <xmqqwma0nm6c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> Personally, I kind of think abort makes more sense as the default --
> at some point.

Oh, of course.

> So I'm curious if you've just changed your mind
> completely from before and are against changing the default at all,

Yes, after seeing that the representation of the signature algorithm
and encapsulation format was not as well thought out as I thought it
would already be and its design still being discussed, I realized
that the new feature was way premature to have in the release.  At
some point, when things mature and we are reasonably sure we will
not have to make incompatible changes in the data stream, we might
need to switch, and the best default might turn out to be to refuse
to work unless the end-user makes an explicit choice, but as the
design of the feature stands now, I have a feeling that it is a bit
premature.  Certainly not ready for general consumption.

Of course, I could have just reverted the merge of the original
topic and give it a chance for a fresh restart the next cycle, but a
new feature clearly marked "highly experimental" would hopefully set
the end-user expectation straight, as long as the default is "do not
do anything different from before", which is the safest choice for a
feature whose design is still wobbly.

