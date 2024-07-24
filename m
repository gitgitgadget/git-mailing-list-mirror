Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCBE29CA
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721839845; cv=none; b=WFxR4r+OgsWIQwLrl8DQU5hFmJr5xC6mqTmqGfQOM0pSeyWKi+kpeiPJUqZcqXPrIC/NMze1ydYvb4pmdCcwyQ6GbrflRRqXu2rn4tx/g+eRwTpgo0ZfGmoM1shwSZ/3jT8QHNvjkC7O1cBB9QFrEkLzy62GEZrLL0SL+IZBiZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721839845; c=relaxed/simple;
	bh=6R/coflzywk4vbMpa6qEquRfwiFeJbwSSxxzP2nDWi0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uzLwIEafb0kzLizwwd4eMgc7PspbDGgPJ30GqyiF9rxYMZvQovz6XkzFgjXlzuo9ehdXIpsg466b2XpIo8b9897ilcu0mAQg5SwDYj9WT6P1PkhCquMKQn69zEv/4F9PneSkVpKUNzaSlH6BGd+v8U73Pw9woIX7iM1ShUST9MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OBFW7UhR; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OBFW7UhR"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 97CB229758;
	Wed, 24 Jul 2024 12:50:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6R/coflzywk4vbMpa6qEquRfwiFeJbwSSxxzP2
	nDWi0=; b=OBFW7UhRBLx9gjxLoI7KvEwdoAoJqPTvUKM3rwAbY63IstV7ukF2W+
	j5f4CqwZNYB9F6Zv7gFmImw8Ty65lHpXBzV7z1l2OCLIOCcv6YZFuBerYxZlqfBH
	G04XPttyTmsGzaLozu8IDCQpkKnGBt5fw8jtr5ByBbYojwBW19ETw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F2B229757;
	Wed, 24 Jul 2024 12:50:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0287A29756;
	Wed, 24 Jul 2024 12:50:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/3] Documentation: document naming schema for
 struct-related functions
In-Reply-To: <7f07bf1f3beee2f74a3572d2b9a8d28b6535053e.1721818488.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 24 Jul 2024 13:05:17 +0200")
References: <cover.1721818488.git.ps@pks.im>
	<7f07bf1f3beee2f74a3572d2b9a8d28b6535053e.1721818488.git.ps@pks.im>
Date: Wed, 24 Jul 2024 09:50:40 -0700
Message-ID: <xmqqikwuwx7j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DCF2A7EE-49DC-11EF-9920-BAC1940A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> + - Functions that operate on a specific structure and which are used by
> +   other subsystems shall be named after the structure.

I am not sure if this is a good guideline.  In the case of strbuf_,
you could say it is named after the structure, but I would actually
think that both structure and the functions are named after the
subsystem/API (i.e. we have "strbuf" that other subsystems can use).

> + The function
> +   name should start with the name of the structure followed by a verb.
> +   E.g.
> +
> +	struct strbuf;
> +
> +	void strbuf_add(struct strbuf *buf, ...);
> +
> +	void strbuf_reset(struct strbuf *buf);
> +
> +    is preferred over:
> +
> +	struct strbuf;
> +
> +	void add_string(struct strbuf *buf, ...);
> +
> +	void reset_strbuf(struct strbuf *buf);

Do we want to rename start_command(), finish_command(),
run_command() and pipe_command()?  child_process_start() sounds
somewhat ungrammatical.

By the way, some functions that have strbuf_ in their names do not
have anything to do with managing strings using the strbuf
structure, but they do things that are *not* about strings, but
happen to use strbuf as a way to either feed input to them or carry
output out of them.  They should be renamed away to lose "strbuf_"
in their names (e.g. strbuf_realpath() is about pathnames; it is
immaterial that the function happens to use strbuf to hold its
output but takes input from "const char *").
