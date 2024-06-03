Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DED13666E
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717431892; cv=none; b=CR/TWC0bpYiuVRAv5WOpwTHGB6qstyDIVeJrLnKTRwVF8B1FlwhWoJ6LHF1dIAWeVl8kM5I0hbXczrE0p3s9uosn10C5jyZFpssoJK8eja4k1M6JBNCPRcl8Z+0yKyvuxEVdGbU/4oxC3P+i0fIjLIZUMwrjGk2bhAWP01KkpDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717431892; c=relaxed/simple;
	bh=e8qNAgtIF4c4t1j4NiVt2jAFVoen0DcBvTEJK4WMLLs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fXtkuutR1dK+ChS7IBOn3yADtZspgC5HSzBI4o6ooKM8BezvgrHmm2+Z0ulFjqCyFnAXalIzujMEJx08/6z+J8Xr2XnsQ5WC6rLT2zPOj8NciEN4ouBo87ijIlJrl8r/KCKip6IvdcXG/orvMuDss7WVzO1oZ3ECXuK7iPSgHhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=f+GlcNZ7; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f+GlcNZ7"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 294A133A4E;
	Mon,  3 Jun 2024 12:24:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=e8qNAgtIF4c4t1j4NiVt2jAFVoen0DcBvTEJK4
	WMLLs=; b=f+GlcNZ7kTZKOTz3ajHNrfSHOe4VwWPAafOsP1o5MBK/oskT0TK+LF
	Mw1ZOfvwAh/CeYUkiIM/2EPluHqN9qKAMJ6TKH9MHmhsxeeqkJjPKuzEjFZPaeVk
	mKOIrDaKuxiLhbi2xNBhiG6DDWXaSGG5tlDRiUu29bn0vUULIt7Oc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 21D2333A4D;
	Mon,  3 Jun 2024 12:24:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8B44D33A4C;
	Mon,  3 Jun 2024 12:24:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Phillip Wood <phillip.wood123@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Dragan Simic <dsimic@manjaro.org>,  Karthik Nayak
 <karthik.188@gmail.com>,  Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v5 1/4] docs: introduce document to announce breaking
 changes
In-Reply-To: <67cb4de5cbbee7f7d4e22a7223a4838551956f26.1717402497.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 3 Jun 2024 11:28:22 +0200")
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
	<cover.1717402497.git.ps@pks.im>
	<67cb4de5cbbee7f7d4e22a7223a4838551956f26.1717402497.git.ps@pks.im>
Date: Mon, 03 Jun 2024 09:24:48 -0700
Message-ID: <xmqqv82q56zz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CC8DE862-21C5-11EF-BECF-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> +The intent of this document is to track upcoming deprecations for the next
> +major Git release. Furthermore, this document also tracks what will _not_ be
> +deprecated. This is done such that the outcome of discussions documente both
> +when the discussion favors deprecation, but also when it rejects a deprecation.

"next major Git release" -> "future breaking release(s)".  I do not
know offhand if we want to plan for longer timespans that may cover
multiple breaking releases, hence (s) in parentheses.

"documente" -> "document".

> +This is a living document as the environment surrounding the project changes
> +over time. An earlier decision to deprecate or change something may need to be
> +revisited from time to time. So do not take items on this list to mean "it is
> +settled, do not waste our time bringing it up again".

But you are expected to be aware of past discussion, and if you are
not bringing anything new to the table, you are wasting our time.
Note that pointing out an old rationale no longer applies to today's
world still counts as a new datapoint in a renewed discussion.
