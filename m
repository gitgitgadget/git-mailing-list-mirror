Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5685D5786B
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 20:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710793717; cv=none; b=o8AJMzAG6WyBNAoxlbpHUNArypMlzKB2DAF3cJQQx+3VlNWH64gsg8XPUm94fCkyKECVMV928XhVr1AANAKbWKZUtgdC3eNyaIRCa6kU/JTV2A9MzpLi1AhywWfbJP1YcFgD0n+W1/aBav8IMxGKJsABHe5X5ehaobD38p5kXyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710793717; c=relaxed/simple;
	bh=Obaa6UuWN/ZOKzuAKv4to7vJLjky8MiUkfh1Q49rIP4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JT8RPJ8gSHhgQzJQ8H+eOtkjQXOCG2995WnME9RMjGHwDrQjbk6FrY3EY/LZJ3ci9RjFlnDd+sXlmJhu+TvmBq360OOp3qqXk+n8vDqaj+4YNqWLwohimzP9z5aZoK3HP9VgdRU6YMVjuLK5tGbXt7MEtk7Ag8Esdmwu2dZRRHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lq2J1l5I; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lq2J1l5I"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A7A473026E;
	Mon, 18 Mar 2024 16:28:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Obaa6UuWN/ZOKzuAKv4to7vJLjky8MiUkfh1Q4
	9rIP4=; b=lq2J1l5IP7ONDvrXa1qex7KSvUI63maulyfD4VUjR+b3NhcJRK+GuJ
	A/V+XtBfW3kRaR8Hy6urBC5HUBurcnBqnFnCkNHn3pn3MLOndN9lvoriKRBYxFva
	mir+bveIjUOF0H2my5PV8MJ9a9c/18meixN3Gl/OlVk25ZAzugO84=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9FD753026D;
	Mon, 18 Mar 2024 16:28:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0154A3026C;
	Mon, 18 Mar 2024 16:28:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Dragan Simic <dsimic@manjaro.org>,  git@vger.kernel.org,
  rsbecker@nexbridge.com,  github@seichter.de
Subject: Re: [PATCH v2 4/5] t1300: add more tests for whitespace and inline
 comments
In-Reply-To: <CAPig+cSJdBm+sRcXSpdZYUqSqktN3ytcjD3kmhu6WfTRuqkPrg@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 18 Mar 2024 15:17:58 -0400")
References: <cover.1710646998.git.dsimic@manjaro.org>
	<9a73e7d3cbb9ea210ed1098c5a304b0f5d5e1a2e.1710646998.git.dsimic@manjaro.org>
	<CAPig+cTVmQzC38DympSEtPNhgY=-+dYbZmkr0RTRbhG-hp2fmQ@mail.gmail.com>
	<9996af464aabe2bf594c63c237d7a6e0@manjaro.org>
	<CAPig+cTLrsUpvKVjkFUgs1b1gvj54rm6FBa=5v3uoQtJnB4rZQ@mail.gmail.com>
	<c579edaac0d67a6ff46fe02072bddbb4@manjaro.org>
	<CAPig+cSJdBm+sRcXSpdZYUqSqktN3ytcjD3kmhu6WfTRuqkPrg@mail.gmail.com>
Date: Mon, 18 Mar 2024 13:28:30 -0700
Message-ID: <xmqqwmpze13l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 16659A30-E566-11EE-809B-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> As a reviewer, I'd like to see fewer and fewer changes between
> each version of a patch series; the series should converge so that
> it can land rather than diverge from iteration to iteration.

Well said.

Thanks.
