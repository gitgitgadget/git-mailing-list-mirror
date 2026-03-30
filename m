Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84C3382F10
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774904479; cv=none; b=MOOGDljGUKB71LSO9TRd/5nlVk+PKUg+wZj03jhpxKjkILXh/QJ25TKIlpt8fugJeDZq72uvlzvvcN8aFqLmZVR5mUCh2+XkEaPzNxuYrqOshD2baO4qPueMLzOCddAOs+g3gOhY1EYk8qTg6OOjhwcd8Y7Pt2imNjRegmiSn7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774904479; c=relaxed/simple;
	bh=/HK1gw4DNaNDCvh9HXpwBN4n3NhonRGQxQB0AgsOai4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PSkmkuDk53WwfT9owBhgT/wZeJKsQacPpctrHi18VMzYKoAhWWm2Mlp3rU8bWaUGGHmrOTxIgiEPBJPvTgf6H9xJjFe77H9PAbTkrnw7uWWYd40xZl4iZ5QpnzZW85r5SF/bfI0gzL/iSrT9U3cIwyIpBMH0B+WzqBbSijbyiYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fGewbjib; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=anSxHhq6; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fGewbjib";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="anSxHhq6"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 08AF5EC0075;
	Mon, 30 Mar 2026 17:01:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 30 Mar 2026 17:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774904475; x=1774990875; bh=WsROvazYD2
	XTTSKFxG4E80ggvarAYuuPYrVKMAs3fws=; b=fGewbjibnRBwSfJcr7fAqRNcmF
	AJrks3niQjnyJ9xx68h0Y/nw78eTjluCrbNjKl1ed43hJgbFhlRXOKbJ+Fq+vKEM
	X35qRVTv5jVmQk6swd7Ovsbi1xJ8jZ1u38XUFVBhGLEMzyw8ouOcE8dcTa9BnDkt
	XJ8RBH6hIQM1lFxUEmtLNXzOzGMHNX97Bu+wPgw5Ye69hzDMFSLKC4Qjqh8e0UoW
	eAqNuWQtZ0E9TYXt5IVrxgyz0483hMrksdDkjXPZX1mQjBy4ANURreKJ3VtBv8m1
	QCsmii05qtVad77EdE74xEvJ5844+4wUnsK+m6d4DjQF7f+iVrCR+JfJPNEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774904475; x=1774990875; bh=WsROvazYD2XTTSKFxG4E80ggvarAYuuPYrV
	KMAs3fws=; b=anSxHhq6F9llSTf6Y5ap1xQIArWvvIISuBnj4QlWabRs5i3xUes
	OuLZgqROIj4XnIEa48epTweUkOLYNj7rCKztEzfm7n90CN+9698RBEkqYrxcURle
	K5dtM1MFjhFVWAHtAdVP3Ext98QnQaAvJq/GX86aYpRndnvm0gXoZ80HxvOnkXp7
	6y5E2x1LDzEMimFdh05pqSbaHeTTlXjGKQedSdJZCJ4J74gIfKbnb2q9TCgZmmDX
	s8IVj1mRs+DJimLMS0E8gOI0JhTKBadIhhf7ITEjODxK3x1o+k2PuL9hmrmzzBde
	JBNA68L0qRF8JBOfgjnu9DgkLD43e9jy6nA==
X-ME-Sender: <xms:muTKacmfQilQiry3xFxfxMCRpZCvBPjP5u43fKG7wWMQUNZpfVMwDg>
    <xme:muTKaSuFZSPsqLhUem_H63_9KDzDsINqhi1hIaKP7P-AsvbiH3S3PPuHSUVyNRFRe
    U_1bvN93xKjjvVvY4HeylV5dJ6nGzkR01jhjb-ySEI045SYGYH7zA>
X-ME-Received: <xmr:muTKaS_olPgyG3ZGp3m0QfuXYfHeklO2dPuKgHSJKuRUGCQCggIzlgC_xbHugGaVUdYbrxOv-s4xifzDscNmJbpdfSbdMLBQnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedttddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:muTKaUNA9vIkqO8yTzV4RQ_TlCWd4nbfUGclkUPPN-joJd6_9gpVrA>
    <xmx:muTKaYFLbz2STTnnRtJh5fW-T99drftIOL1SQthDXHmXzR7sKMen9w>
    <xmx:muTKaaRlIaN_TaVm9bo6ZHUT-IeQLbPPqS-eTuvuEezfkkXtQxvwTA>
    <xmx:muTKadvm8reNIdiMLvENyAsHQs3wqqhrZf38BPIy7IGuR8iD6iKipg>
    <xmx:m-TKaYq-7tRJazSR2kMVcs3iUXP_PsgnyrS-tb0ch2DuTduzOcHToNUN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 17:01:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Karthik Nayak <karthik.188@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v2 00/14] odb: generic object name handling
In-Reply-To: <874ilxm4wp.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
	(Toon Claes's message of "Mon, 30 Mar 2026 22:35:50 +0200")
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
	<20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
	<CAOLa=ZSeMS2iKzgMUWix_Sx+e24863PsOazRLrqHtS5hYSUk3A@mail.gmail.com>
	<ab0hy6AitZFMf3RO@pks.im>
	<874ilxm4wp.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Date: Mon, 30 Mar 2026 14:01:13 -0700
Message-ID: <xmqqh5pxdobq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> On Fri, Mar 20, 2026 at 03:04:02AM -0700, Karthik Nayak wrote:
>>> 
>>> I only got around to reviewing v1 now, but the range-diff here looks
>>> good.
>>
>> Thanks for your review!
>
> I did a full review of v2 and only got one comment about a stale code
> comment. Not worth a reroll if you ask me. Looks good to me.

Thanks, all.  Let me take a final look over the patches and then
mark the topic for 'next', then.
