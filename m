Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAFF36C5A1
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619909; cv=none; b=etwKtJNvrXCqbdk0GRMgScUrXhZbVAFLWw+sfswUm3xiB5UbLUG+CgBhq6riQBxTyD7pRuMngBBRPXACVJDrNuWIDDW7CQLRdRcXor981c/EICniJS7NWVl5gs4wWVKyX+aISxGprRgJo1ksCBPTnnPbZlsv8RT5FnerORcuW18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619909; c=relaxed/simple;
	bh=/DTAfAdHOa5QpVg1u1+P8PC4LHTdcuW2hhcRbPgmjHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PUDrvOsv31AtsC6qXHVx14KuhvNRu52KGRay4Cz/9P5//kK6af+cIuuYViizkdrTdoIjmVT4kpLl6EmShcb74nM2OJ4MSg4HcbnhVbhAuq5ddDyJISPLYk3Vb32tPJL9QiPTSSkSG1JXaGu1CxXnHXA6n/d2noAycpUkidnKPu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y/eDKrBw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ylt4dekS; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y/eDKrBw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ylt4dekS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 4D1A71D0002F;
	Tue, 16 Jun 2026 10:25:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 16 Jun 2026 10:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781619906; x=1781706306; bh=0+/LKMRCGm
	F3Go3CFNEBbh6YVskii671EJoeNz/oVxM=; b=Y/eDKrBwSL7idHHvD4CjyFEjdY
	vG7M2f2wX4D/0Jn46FmM5dSCHQPf+Kv2UI+R2/O0T3sf7FkPu/eazG8IMzdfdjA6
	0i+sxGXoTF8ovbGU5g0+YxHjSLxQhf4EKlNBSvLlmGIohccmNCK1AvjaoQpLkcg0
	r9D4WL6XB56mdB8YESsMH+sCcFe6vZJ/CS53/bxT70282xBLF0gB6v4C6l/0QMdh
	R/iaN+dNlCm5UX+jxg+CW2ozgNXtbmmV4GuzGBWNE+wcmv9M3KPFOXoQR0TZPii+
	p5W3EAp/XYuw/HoDcD+v7Y6ABbFddbEYsiFKysoi1Eg8ldje3ihuSAnVP6Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781619906; x=1781706306; bh=0+/LKMRCGmF3Go3CFNEBbh6YVskii671EJo
	eNz/oVxM=; b=Ylt4dekSmhAVO9CN+9HVWzrcTh7rc368F13NunC0xHAhBvqpdE2
	udrkzsW8caCa3hp9+rwPEckCaUiseGUw3swxYlYXKlY+4ZAyLmTREcyDhEvkM0OQ
	uTqkZj/Ww6RZa6jzkFK+Q5SVtkS6bMAo0VzvMhNWvZCJ6doSaCdeLcJtq0Hjk92d
	lMtBAnBuKHMnszBo2OEoqBSGGQnkJb1zm90asplfAMFjdMBl2Po/tYgn09tIyMnG
	7ujx2RiU+2tuXTanUw8rMyplYWXuoZNAmvvOWZCz6ufoXnbLQUemKsQT7GmX6wfy
	+1vTIYxJ1gutDBz3/zbgO/XGme0jVDM7HzQ==
X-ME-Sender: <xms:wVwxars7_Ir9q4r-EWUmMe3WufMFmuWNBoQLGYxSIYgv1Rwnl1lnlQ>
    <xme:wVwxajVXoCBysXwbtTbK2mTcWqfPq4B9jkeg-OAHBbwnr-L51zzWxQ6F3Rc745BOM
    VLAOnV7jK6JJsDFZAyEQBddL45HriaHXIt3N0MK-LhLFK-I1pUzBsQ>
X-ME-Received: <xmr:wVwxanFSjfBLfzjocY1qVxMhpnuvJiucmL2ZHwynkSYqq_I1v9N42I7jI7MCqf42uL-fsDUrIvErJMbrib6iU4CwWlsR_A0i4koS>
X-ME-Proxy-Cause: dmFkZTFlZDCNB41FZN/noeloGfksmeVkR3AlhKTBYhckFLrS4uqZ+38N6pyFZi36y5M2SI
    JRpExK1NZ8UbE037S/d+NZPzbRs4uexBZxZXHrGMmrx+EH8joFUBIMaxVqZ9aF0OX8JB5A
    mntsINswBTVmpHjC59UUI5RxglLjfjqFdwVgGskx/i76C8m7vpPAxAao/yXPkBhPijaCfU
    F4nSktQfNhmeDrp1iF9cVDJnnsSsOq8RltAKGAcelCD71aUpO0qivvhLsBhiWW66eWiXuU
    uv07+fcb/C9/UZ0wHsGo4ulF4vUvLi2FqLFIsW5Eyp6swkNxjtfOfHd1V6k7dPua9PlrB4
    GOp/PxqozI/soeP2CG8ShHDJs2ERwPv4L8dw0k7ECrXdbMV/mZJNAzYh/yuKNC9gs7p+fM
    tJ0krhJuQ00/pc+v0uygANpo04+S/XEUizlGfHAmo81ej1B849EZVNyaUHssUN+rp3wqo3
    X4v/TKab/uMNOEDAupLe8wcy9coypxH5RwSS/Ws2AQB1+GzW2ZSp+CzgtuLoTh5Ldom7/k
    JCtWsLbgWmnskEnbDPRtyIh/N436c2xwWvgzc15WNTTz60jt8Au4WUYRlIgfw9/WTP9VVq
    MCW9IfdVw9raaC9zOMPwS9UcaGW8mtxUkuj7RJLoVliXFya7987sFnUtC+Lw
X-ME-Proxy: <xmx:wVwxal3KCug9Y7bjC61EAx38pGwncJ0Ms0xcV5sLOT7crFrWNl5SdA>
    <xmx:wVwxapN0OeckNyF0chUAFrM0MgxKpdi3xLciU51nxyEoXgyr0VG4fQ>
    <xmx:wVwxak4Oswcc46MGHvAIkWMK1OvLYYAV0h88xPgFZYER0JebdwKdZQ>
    <xmx:wVwxaj1zOFCHrr0-3JGNmNc4evcg1QXC3coldwzOYB1gFIRiB1f6bQ>
    <xmx:wlwxagFj5R5ZzRluV7TlIaxaEkgYEQ-T3RlVdXtHrXagm3GTm79un9gK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 10:25:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Tian Yuchen
 <cat@malon.dev>
Subject: Re: [PATCH v3] read_gitfile(): simplify NOT_A_REPO error message
In-Reply-To: <20260616123516.GA2301231@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 16 Jun 2026 08:35:16 -0400")
References: <20260602061159.GA693928@coredump.intra.peff.net>
	<ah6WEtk2pXyViEQA@pks.im> <xmqqeciezh0w.fsf@gitster.g>
	<20260616111919.GC687438@coredump.intra.peff.net>
	<20260616123516.GA2301231@coredump.intra.peff.net>
Date: Tue, 16 Jun 2026 07:25:02 -0700
Message-ID: <xmqq7bnya7gh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Tue, Jun 16, 2026 at 07:19:20AM -0400, Jeff King wrote:
>
>> Here it is.

Thanks.

>     +@@ t/t7450-bad-git-dotfiles.sh: test_expect_success 'git dirs of sibling submodules must not be nested' '
>     + test_expect_success 'submodule git dir nesting detection must work with parallel cloning' '
>     + 	test_must_fail git clone --recurse-submodules --jobs=2 nested clone_parallel 2>err &&
>     + 	cat err &&
>     +-	grep -E "(already exists|is inside git dir|not a git repository)" err &&
>     ++	grep -E "(already exists|is inside git dir|does not point to a valid repository)" err &&

A few things.

 * Will we be happy to see only one of these possibilities, or do we
   expect to see these once for each kind?

 * a recently started in-flight topic tries to catch bare "grep" and
   fails until you write test_grep X-<.

> We also racily trigger this in t7450. During parallel cloning we might
> see one of several errors, including this one. And so we must update
> that message, too (you can otherwise find the failure pretty quickly by
> running t7450 with --stress).

