Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD212BE7D1
	for <git@vger.kernel.org>; Sun, 10 May 2026 23:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778456911; cv=none; b=oe5QTIamJtnIT9mdeLkm640amY7lJ3gDnh9J8PWO27wFlVLK/KLpxpBx0LzaygRPoHmlG4Jjl9gV12UQVQMNrZNowGqHQ+CbPWSVinD8d2yJdJIHWQmLLS4RADF9xqs2BJeqs6mRQ4uH8pMvAvE+bw8LGY5yq9wmscSnWF1/p2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778456911; c=relaxed/simple;
	bh=6IE7cMqNxFQZrqwlxSsO5Gm4qg0bBaL0p1TmMNyMwgs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R8sBqtIWtvQwoln3d3KHqRqoLtfmp0ArrKGY27ie09z2JfYAydReyRNZj80BleqOlBu66iNkxrwATCPNXrXNNSCaowPm/zteML+jm731CSMu5wasWCZcmp3gwleDLAOeb6jVRg5TmhLLFP4THP9FO3HKyJE4ZXrEhQ9ma1HegrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kAK7KKmJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OVZvI9HQ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kAK7KKmJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OVZvI9HQ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA244140007E;
	Sun, 10 May 2026 19:48:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 10 May 2026 19:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778456908; x=1778543308; bh=6IE7cMqNxF
	QZrqwlxSsO5Gm4qg0bBaL0p1TmMNyMwgs=; b=kAK7KKmJbYQsStpugCQwg/Q9AV
	fFT1x10maL+Ugv9bBsr/L9qBTny8p5vF1yXF8AGy7EBDHHFlHCoe9Q9OjJuTQvMw
	VTnfdcyLIl9XdnAfvjLHuT1eGFw8/CFRCzvkwiWPEYBZHIGaMw7H37BCaxou727r
	HfOqxCcBGAVKK3wsUwOyAqCjXoACvU189KwBTse1tG8avC/3LqKFrZrozkwnOP+2
	KNe+k6J7fZT+YF7iNjhGxPufni138UYgwhTUE3isLDaC+Lq9nLkJ63nI+9RzDtct
	fOsPv9gL3V6we6L+EtggPxvQNfMxz0c0iHfI6iAdqpDEGmlLH12XnuSODTNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778456908; x=1778543308; bh=6IE7cMqNxFQZrqwlxSsO5Gm4qg0bBaL0p1T
	mMNyMwgs=; b=OVZvI9HQ11iR0GLdNOrExDvQuDlia82kMDoAOk24xWy+729Voed
	2Tv7Wf8vVCxzN11NhGicAd3hkTly4dc1Az7VBrLyFy9oqnjIO7M0NOfuXeAQ8hjD
	ZqDkkIwd/xpwr26f1N24wAl7tXSl5me3OqLe6L/Dz/dvBQALFqCRVO3AxYf13gTX
	LjfNWTe/Xir22Pj39M0vzwxRIBs7AA/2lpFJ01P3ggF/W+Z5OaE0fxzXfXd8ZxP+
	XvpJljVGN0BjxY7vJbHBoj6P18K3shLDJTFku4VyUp1HaenShZV+HXjclKaCygUt
	1skAgZ8EHHAmHWkmWp+DZnTaZYaHZKSFbMQ==
X-ME-Sender: <xms:TBkBahYuhcN9zZ8YpA_tZCO1zxhjBXKuzYszVqHAds6EKbhveFRDcg>
    <xme:TBkBavYjk9oqDl3vrRslRHXj8ruXlBjP6rKtMJVW76o7te4vDpK5mCyn3zYpXhKMp
    CNzkALDmeq2if_ijS7pS3TuOOi2xVVZq-ljSZutUuar9brF0s6Grg>
X-ME-Received: <xmr:TBkBao9hpyuu_em7ExqIPkuiekA0fmcLE-SPM52hsqs1NaZmnCC4dBWTXSdHJsTuVZbMu-ECcaC6rOiDyn95TxgVH8WOt38JKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthgrmhhirhgusehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjnhdrrghv
    ihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:TBkBaugR38LheYhQ5o6C1uUczYHHYnxn2ETbUogm-AjmlGZQyJVYVQ>
    <xmx:TBkBaodFMsKdIhy3yuErUPLYz3xLUi9OCON4JZANUOC9OUKj_ZB_5Q>
    <xmx:TBkBaloy6VLoE1_f1TYFfd-SLp6pt2g1Vnvrf_aEsagQETzNk1H_Mg>
    <xmx:TBkBatBfas8ClKwUqceDqgE0PltxW-DQT6TjRd8sDXTkUZD_NJItgw>
    <xmx:TBkBat8P-nOJf9pgIp3Hl4PQE0yJp-na57USln3x5G1Y4AqQAxform2t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 19:48:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v2] doc: git-log: clarify --follow options
In-Reply-To: <CAJ-ks9nb1pebMLqZ+GunkXLSMYRb_RmpDuBDrDsgJ+6m7nbzMg@mail.gmail.com>
	(Tamir Duberstein's message of "Sun, 10 May 2026 18:30:06 -0400")
References: <20260507-document-log-no-follow-v1-1-46ce02490eba@gmail.com>
	<20260507-document-log-no-follow-v2-1-ee7bcbbe612f@gmail.com>
	<xmqqecjj9ckc.fsf@gitster.g>
	<CAJ-ks9nb1pebMLqZ+GunkXLSMYRb_RmpDuBDrDsgJ+6m7nbzMg@mail.gmail.com>
Date: Mon, 11 May 2026 08:48:27 +0900
Message-ID: <xmqqqzni967o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tamir Duberstein <tamird@gmail.com> writes:

> I will reroll to say that `--follow` follows a single file beyond renames, works
> only with exactly one pathspec, and that directory pathspecs do not follow
> directory renames even though they still use the same traversal mode and can
> therefore show a different set of commits. I will also fix the subject and
> option ordering as suggested.

To be quite honest, the "--follow" option being what it is (i.e., a
checkbox option to claim we do support such an operation, without a
serious design and implementation), I'd rather see our documentation
being more honest and do not claim it works with pathspec at all.
When you use "--follow", you have to give a single filename, and
that file is followed across commits that renames it from some other
name, and then that file with the old name is followed.

If multiple histories are merged and if the file being followed
turns out to have come from different files on these different
histories, the "old name" the traversal is currently following is
not kept track of per traversal path, so we cannot expect the
feature to work with anything but a linear history, either.
