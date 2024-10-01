Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608321C6F7B
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802662; cv=none; b=nGEdTAWHLdP0nrVdw3rQbBmhlA4LMJCeUOwwllSiwXgyIrs3iQsJ1sI82664Ozed4slxQyGGZcuDy/IekODoMjZy7hHILvEgq82E68gI+p0eHLMlFklLaGz1QCmkvPNy/Xihjqin3WsFQ/odIFIVqBGzKVWaSt3slFR9pcpgGHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802662; c=relaxed/simple;
	bh=eygtzHBb+5J8AR/dJOxjEnDW0N+kjChtQM+QEviumDo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZPqyLy6hE9fquvlX9jDDON2VCpFqxdr2TjEmU5/oWvITEQ+VzHQo71/9mFf8NMxt1scnVnoFywXD/1jFGUYwydXXGQX/XJbOGALgTZLDAUw+st3o6+jG58J+RpdvOlbQju3NJ4e4EBN40bQnFNrO/ZE63oTkYvt6BWiiVl70wEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W3gn5hji; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QB5OHS5S; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W3gn5hji";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QB5OHS5S"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E67413815F5;
	Tue,  1 Oct 2024 13:10:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 01 Oct 2024 13:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727802659; x=1727889059; bh=Ry20APd9WO
	VDxKwyVpRMntUCXHka7pnc0tkrq4fbxyQ=; b=W3gn5hjiJHlI2jibFaRjCvSvEH
	Xau9kYMjgnnhUthTBmvZJh664GaNCOfMvNTHZ9wncv0gKIa+wf2rs5Tsm/LRIvtI
	PrXqvJyc7PN2WdsuxAfKXtf7tcat+Jya8jlJXP9gi54BkF+e9KRr4S+yKyofHq84
	zOzL/GCeeOsDkbvAfF46IzMzeiVCBUyR0QsWyZN7ZXhgLvxrDxn14uXbWo2LPlNM
	W5XHr2n6IWjjLgCu53ebU77jfNSMPqzY+qFu9Dfd6M+R0ZS0tP7gZ33WWjWBNOyK
	GCOsd2IOdhD2TaKd4HZtqnZza/5vc8me7GUMSyAjn/6NSgSc6Sssvl5GYUrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727802659; x=1727889059; bh=Ry20APd9WOVDxKwyVpRMntUCXHka
	7pnc0tkrq4fbxyQ=; b=QB5OHS5SdSX/y7wGq/BHaM/FcfsgAgz07hd3OIMPxZ5Z
	Saxiw9XWStkMWvY0LEt7wSun8YVaG/mHcsN4Cz7VPCnoah4fh41MsXexfx3PgfuY
	+c8T00ochTvj/NqPMWoxACRgLL6PbJWspyH5FftvSp2TKVvVXupdDbKfqcxubB8a
	ich1KBcZinbhxLtefUoUPJSjIGLKlHG+a3EsYPop172pwfzsgAaUWEX0WC4P0rXc
	CHXimCa9+ti8jVVPWEuZ2XScVVDZwbp8JTS1vmF3b/Bm6KSqESGZk0aDN4S3wt+1
	HJhoJc7vv+hqCSil94WtNEOfkAYOjADemRgfkcyC6Q==
X-ME-Sender: <xms:Iy38ZiMQMmH8GHAQoz1JaJ2zReFqC4s3NdzE7HU3g1EVQq8GxhHcDg>
    <xme:Iy38Zg9tCt-bN77RnGUQfEHZQK6jSwpAyJiKVywnFjnG8cb19Keyz5vjVKjbTcewA
    uAq86ZfQJZGqKXzLQ>
X-ME-Received: <xmr:Iy38ZpRBoNg2onBoY0QMejOOU_E1zLy-Fg6lF3uVWT4fE3JfTY38RhLRhShHaQqgGYvF9r9gHNDYC8AdkftcK5Qu6rTu6NqxtPJgG2I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhntggrihekieesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Iy38ZitQekiKIGV2-rw2I0ikxDAcqvkUipOu7WezF4vmpNLApA0n3g>
    <xmx:Iy38ZqeIAi7U3ojcYrHkZUmwus4qQHXT6wCYh1y_GldNMqrV8zyjrw>
    <xmx:Iy38Zm3VtCome12EDWZ_OiFFrfSmBZQglfFQpPpHSQ8Jkl5U-ZI--A>
    <xmx:Iy38Zu9e2F_LFnggQmV37lqD1AKdSCCgFeKHPi5Qy44D5jfe21Lc4A>
    <xmx:Iy38ZiTEHy0kE2jvfjFbruZaKOhpEe4szMrPvsEz7dJISkZ5kD_4qFre>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 13:10:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: shejialuo <shejialuo@gmail.com>,  John Cai via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  John Cai
 <johncai86@gmail.com>
Subject: Re: [PATCH v2 3/4] apply: remove the_repository global variable
In-Reply-To: <Zvvr1_9syRh1McVA@pks.im> (Patrick Steinhardt's message of "Tue,
	1 Oct 2024 14:32:30 +0200")
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
	<pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
	<d64955a2e277da138146020f6a0cf96f4636a162.1727718031.git.gitgitgadget@gmail.com>
	<xmqqy13852jk.fsf@gitster.g> <ZvuBduVg9TJeULpl@ArchLinux>
	<Zvvr1_9syRh1McVA@pks.im>
Date: Tue, 01 Oct 2024 10:10:57 -0700
Message-ID: <xmqqwmirzr32.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I disagree with this statement. If code isn't prepare to not handle a
> `NULL` repository we shouldn't fall back to `the_repository`, but we
> should instead prepare the code to handle this case. This of course
> requires us to do a ton of refactorings, but that is the idea of this
> whole exercise to get rid of `the_repository`.

I agree.  To me, the patch was screaming that the author was not
prepared to go the whole nine yards, though.  Adding back the
explicit reference to "the_repository" as a fallback is the next
best thing to do, pushing the "problem" closer to where it is.

> If a command cannot be converted to stop using `the_repository` right
> now we should skip it and revisit once all prerequisites have been
> adapted accordingly.

That is also a viable approach.
