Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B001273D8E
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725406; cv=none; b=K2v6PlmxCiG1LonREer9XIh3ZO7Ix2mkHvL9kUeRavIdAu33QxylnwkpZVj0kYF0KVZ51Z9hDYYImQOJ5Gjx5CM6kzB0wpUYykf/Z86wYPwbSvP9OOyheNC+EBRfT4vI4mtRbHR/eB3+SuJPVFrUgILVFhVwRUG7UQsnHKgv6PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725406; c=relaxed/simple;
	bh=07zaCKSnjugBoKYvxPR3a1AJYO9mKu0FtpHQAc8goxE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qiv/3DdUXwxc+XjBae/o7KKT5lkpdF6SuUmSIIup8mxqerCdOhZAWoSq1N1zitQTWMChtcd9PUYhpfh84ijBtBo2JpjlXH2bN7SP7W1jy87PYhDNbwYoZPXqtFt2m7bGIDxKPYcIRRKNQ9fEvBMm1A+L1IfcAEBHUEw7Zq0yjjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Plc/2xx8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y6O9nIXo; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Plc/2xx8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y6O9nIXo"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2B771140035A;
	Mon, 28 Jul 2025 13:56:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 28 Jul 2025 13:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753725403; x=1753811803; bh=pag6CTdID6
	/UTvwGMzi2ldAbAbb4gVO6QsoPuB8KKz8=; b=Plc/2xx8P9/w5swBRSh8NSV+qL
	rmuk0GqfOoJYpIoAGYrsw2a+iv5GWUSYv8vuWFK185l8UDsQ78LcbB+U2cygpvU+
	RlYgd4CqFtnFR2rP20clytDw8/xnG9FN3aD2O0AKk1JOITGc9cFp0G0MuVVTRzNV
	OkNADSiit+Isx+nx6n4US/BB5H6cWoZV3bDXaxaLpgYVpnQz6ROIqMmO22nnIbqp
	HmE34cxsvLqfnerp2YrWnm1DI8WTHzwWBRoHYfxfHu0kZTENXzAE7+wt+eKmEQuz
	0qv/f8e1DcUNlbZmRSY3XxxD0F94oRK1lLsXTIYAfepIQ7zPMetEWqKaMUhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753725403; x=1753811803; bh=pag6CTdID6/UTvwGMzi2ldAbAbb4gVO6Qso
	PuB8KKz8=; b=Y6O9nIXo7ExEaAssvrpE/IBdG2B2KgXgqs5C5pSzDC7VJEtpCxu
	98I7VHHJDwGBY4vV1prIOfJ0bzUNQW8Vlo7P5LQ0Mf1G3+MuaNqOgCAuXp3jvyJU
	xJjxAr4zD8ulXHSdHCE/j+nGV5VO/6f25FDww2al8O3NZf8u/KsJHo+6Sy/ouvBs
	4W1xhMLs6Ms25WNHA++vbcjh6JyZdAdJu3EVt2II8PLBKi7qDZqnzehkyOuT6wHH
	8xlfEbL8vY1sE2KI6vgDjJRUDlHvJJThHoPn6kaj7Z5CBgpg4dmmUMvFgBVLU2wp
	KatBJNbxWGkI6xA76eX+tYgD3IGfEso8Gug==
X-ME-Sender: <xms:2rmHaCrQ6j2MoI7q5P1vjJfkxv2hwNYfKkiwEIM3FhLcF9RrjFMWFA>
    <xme:2rmHaLSNOCjhAK8kyK4fAwY65rMhih0OsKsochEmyTvWv13ynymmNdRb7QCXgrNhB
    lDe_IWSD4R4meImiQ>
X-ME-Received: <xmr:2rmHaNPD9bqlzkWALk1GovH0w_5KBF4NHBVDngRd_6MmH3mKWX1ktINQlTs04jg2XzAuY8Vy8oINK4MtR4FKi59VZdIaPRL-8e4gdT0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilh
    drtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehg
    mhigrdguvgdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgt
    phhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2rmHaBjvHrK_vsiFGZoX2StRxkPTMIEU13qcj_WVX8uA-ihRKepD2w>
    <xmx:2rmHaClE51PYkqzUzhSXeeaEDhfRZj8ZLQ1UBqxlCv74t0KMOXfivw>
    <xmx:2rmHaFgUJ1iChz5XanZYn3-Onk76jZoWmaA33Ae7Aa7gDBfTnGp0Mw>
    <xmx:2rmHaNG6f-YQ-6zODvj4rQHFYVgHWsXlzOwIDiV1ZnbK-cZx3DUdZA>
    <xmx:27mHaAoYoYdRm8YC2-KA-kCtghwT9cXKl_mr3cecj6V3C6r6SLUlgQgF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 13:56:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Karthik Nayak <karthik.188@gmail.com>,
  git@vger.kernel.org,  oswald.buddenhagen@gmx.de,  ben.knoble@gmail.com,
  phillip.wood@dunelm.org.uk,  jltobler@gmail.com
Subject: Re: [GSoC PATCH v5 1/5] repo: declare the repo command
In-Reply-To: <1642D169-F952-4DD6-8D95-50D5F3C400F1@gmail.com> (Lucas Seiki
	Oshiro's message of "Sat, 26 Jul 2025 18:54:15 -0300")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250722002835.33428-1-lucasseikioshiro@gmail.com>
	<20250722002835.33428-2-lucasseikioshiro@gmail.com>
	<CAOLa=ZREo19jCj3i+XkRM15AzaAV9ZLOvt42pTiUFmcZpCyS5g@mail.gmail.com>
	<xmqqtt34tfna.fsf@gitster.g> <aIHRCz_qswp7RgSy@pks.im>
	<1642D169-F952-4DD6-8D95-50D5F3C400F1@gmail.com>
Date: Mon, 28 Jul 2025 10:56:40 -0700
Message-ID: <xmqqy0s8url3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Hmmm... I'm thinking about what is the "right thing" in this context.
> For example, `git config --list` doesn't quote when in its key=value
> format. Perhaps I'm citing `git config --list` too much :-), but it is
> because is the closer command to `git-repo-info` in that sense.

Yup.  If we do need to support non-z output format and keep it
parseable, I am afraid that we cannot avoid quoting.

An old mistake is not a good excuse to repeat the same one.  Even
though the config key names forbid <LF> and <NUL>, "git config
--list" still cannot be used without "-z" when the keys may contain
"=", for example, if the caller wants to parse the output correctly
because it was misdesigned to not use any quoting.
