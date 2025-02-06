Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA0315852E
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738868441; cv=none; b=tgs1ISbadgjEDQWbNJLVQjpj27bMCVWvPWLujpKWPfsJYdRDNAWhWlRoqVXcvoC45HHf7IVO/DMboxg9LS4mnjm2dYqBXuxkYqpwms6tTCDxI+RalyLn4v3SoFZabXLIFSQbwn4GTUp73jabZhp7ouvIEuPZzMYKfRpBXKvlZq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738868441; c=relaxed/simple;
	bh=6l7tlTr79uoPIbHFHkAfZlGIP7Y9KW5h3TzZqlTCC0c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hITlzKdwYbgB1yKLk4klu8QKlKYxt5DJ5g71lHqMHA8JXBdUlR6nlIGqwwFu/Zrc7Rr/i32LtFffDVd32PuhM0Zt0ANW8TwHv21Lc+YnSxpdDIKADqa7UMzhGeLOeX+grXweZB56gkFbShSe1TN/dQ+TGlsiIfVxzaWVUq9HpsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kVS6QKMO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PX4lRWsw; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kVS6QKMO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PX4lRWsw"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1CE371140167;
	Thu,  6 Feb 2025 14:00:38 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 06 Feb 2025 14:00:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738868437; x=1738954837; bh=aR5A8Z5ZDu
	JPsu5cUBihkyNycc/0VLoyi4ft5h7MhjQ=; b=kVS6QKMOYi0P74L8v8SlJjLu0H
	O7n6iHQb/G7TyjDnSHjNdVjtI2YdKwLUWdSnjcrpEqam7ByeA8vUuYwju6JrITg4
	C/0k+SHPyHLfJmKj7EY/vALFTZhMrhhoCNHc/3v8ZX6xLXqmif5MplzYvIgg8lA1
	H/LunUmulEAviCQHxDP3Cnj/fOE5SPUC/VXPmOKFbaxFePk31iHQDHV1xFrlmmxS
	8XePynFg0aj5g3+fnju7crmuMVq3OWDBsNsTbf0c25sl7aWTLQmNQPjp4uzuCb9d
	J1Kpf6af53yTFECj8GUNYVQHPwtRbovoA9d+oQyBYZBaySt+VI5aoyO0d4Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738868437; x=1738954837; bh=aR5A8Z5ZDuJPsu5cUBihkyNycc/0VLoyi4f
	t5h7MhjQ=; b=PX4lRWswEgsVvhDfpx2YgruSSh4JYgNqRRkY4H3PTOO3OyZY4pW
	Q4SY20xdL1T8hJBq0PqwplwUyddisgIhYIgdWqefb34lgdKuCOgMO+BHFs0MSFND
	9dDYo4E5n8LedfgO5+UBwV+BeaBWVxs1nQ41ymn+AlsH/E5rOv24pbCfFhLGTL7U
	D/HOY8Sztq701wVztwTUxeH7LhZO77ulXfCVXo+rZjGTMkbMOxZB2HRS5fV20AfQ
	d9sNpuYlFW4777unGimfVFqTYkWud2Tcwc8JKZoCgeZTcSPYis4owC2PfY3+Jwwb
	kD4CVV2a9cb7w41JVTW3n8BNTryb4FdTmDQ==
X-ME-Sender: <xms:1AalZ4UwUUGswtuXKKbRK-Y2ZxCAS8wqjXa5ddHSsOCoMhWYYviy-A>
    <xme:1AalZ8lCuxlz5NqBHgKrrKkq7ZuJpVdR-Tn2PWacCJQBKBNo1zBTJPX6KBK1QPOc_
    OytA-XxZDUMDr6ZrQ>
X-ME-Received: <xmr:1AalZ8ZdaAkhcPiPYyvmlyMN1HyAEGmg7cSCFUdmtCxVk81gkH4OSyxwr7JZIspTTWAJy1tEm1ReyJlI8fzyIBhqWvcxOEoxrGct>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhh
    phgrshhtvgdrnhgvthdprhgtphhtthhopehjfiesrhgrvhgvnhdrihhnkhgrrdguvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:1AalZ3U9GzEsrf7A8ynWkpKaUpGrB529F3SgEl5KujliLYnAr8kxcA>
    <xmx:1AalZykN8LvZ95QzLGruusGSSjtdQk_X2mQSEX6Os2A0RipY1LF1MA>
    <xmx:1AalZ8cMu-FdiuG03OmzDlfUTbNvhp4EJfcr8cnU8R86YEV85MzfAw>
    <xmx:1AalZ0HMMPbB9JtrSeWyZHpZUrulg6YFpcg0VtA-GazwZRtquH7hOA>
    <xmx:1QalZ5tEVYvYogbCvtK1z3laXXmabhFj1cA_RtgkmfUxInMEFd9DmIW6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 14:00:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Josef Wolf
 <jw@raven.inka.de>,  git@vger.kernel.org
Subject: Re: renormalize histroy with smudge/clean-filter
In-Reply-To: <CABPp-BHkUW7NVatPOVeBPybwSq9s-HjJ1FTgwU0eZRStatfXMA@mail.gmail.com>
	(Elijah Newren's message of "Wed, 5 Feb 2025 23:55:34 -0800")
References: <20250205214726.GA30202@raven.inka.de>
	<Z6PsXGnxM3UBR3nM@tapette.crustytoothpaste.net>
	<CABPp-BHkUW7NVatPOVeBPybwSq9s-HjJ1FTgwU0eZRStatfXMA@mail.gmail.com>
Date: Thu, 06 Feb 2025 11:00:34 -0800
Message-ID: <xmqqcyfukiel.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> I kind of think we need a way to ask git "how would renormalization
> modify this buffer if it were at this path" short of creating a full
> index and checkout.

That makes it sound as if you are asking for "diff/patch" between
pre- and post- renormalization operation, but wouldn't the question
be more like "pretend this buffer content were at this path in a
checkout of this tree-ish.  Now compute what 'git add --renormalize'
would give us for that path".


What would it take?  

 - An equivalent of the in-core index (but you need to specify from
   which tree-ish it should be taken from) so that you can learn
   what attributes are attached to the path in question.  You may
   want to grab`filter`, `ident`, `working-tree-encoding`, etc. out
   of the attribute subsystem.

 - Access to the "config" data, to learn what exact commands to
   spawn to filter the buffer for, and what encoding and line
   terminating conventions are used for given path.  You may want to
   grab values of "filter.<name>.{clean,smudge}", "core.eol", etc.,
   for example.

 - A sandbox to safely run these external commands needed for
   smudge/clean filters.

It does not sound entirely trivial, but it does not look too much
of recket science, either.
