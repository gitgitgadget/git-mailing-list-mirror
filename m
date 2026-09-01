Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116EA3B28D
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 05:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788238860; cv=none; b=lSVX2ocM4mV8gdD5A+7Ai25wqAmTIZDrSSGPc3z8CUfAKwCMqu3I4eYCO6ZyIwxW0J7JUbYDNwnOgDuYnlhsVOK/WYdlO/xnN4psV+VLVfu237p/AGsHHCjw3DNXh9nRvXjmhC48z8zyMr8zudvYEagzqlzQq+C5BD9FwRFxexU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788238860; c=relaxed/simple;
	bh=I+q8Kl5opJobGgNCNiI6lHUmKDCs1JsDOnwE+nC6PCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Df6TbYf4Xiu0Tyr1lPcnbn7THJQqwp/wDT1IoY2w8mlQHeEYhAOuWTzTp0A8/iXIABdN318KPG+e0YW6cSk7IUr4vqJsc0Zf8sq26VgitQGWyJxnb/teIHlEeslJoC35jTTK55kDkWMltelb30lGnW8hAys73zBJ9D8F/2JrlqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TGxc4BWI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CybNi/Md; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TGxc4BWI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CybNi/Md"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F21657A00BE;
	Tue,  1 Sep 2026 01:00:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 01 Sep 2026 01:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788238857; x=1788325257; bh=p2ACjmL/Kx
	eOfpbqKxP97wIuI6yqJlJlShxs5tTjvX0=; b=TGxc4BWIDe9+Y55UPsxgmQKdJr
	evbPqOU0DLKQJexCCLvQzqZp1S18fFO6iUgZiauVPFaMhkEaTBIy95AdApDvleIn
	45ogelabT2doIYavEi6A01faDBgNxJE0o5buolmvJM+Fep4pck1Zjx40LBPqAnJO
	xGUfQ5IOQEfeb4/1HWJGO4OE/RM5Zpxq1G27twOw6f8MAJhJikTQSVRqwNewaDow
	44AUAFMcw0Esk+Lisfq8pe1N1E0R4+cGuRVQCRCQdQIZITgdgPYdUCczoxxAONef
	Zj0ObZ/pgAhgndSGdYdwSNTyYh9nX4myfQngeXM8bCmB73NPALTNtXNrWJDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788238857; x=1788325257; bh=p2ACjmL/KxeOfpbqKxP97wIuI6yqJlJlShx
	s5tTjvX0=; b=CybNi/MdgQ7HvvzKCC99CwGVDsQJ1awPYNbPKYnNDaXRjnGdQ5y
	vZ9v79Fk36KybYFoGiuzAQafBehj3MPd8Z0fPklBzfA3HCfX1UvLazZBRBP/CH74
	XsHqZs3tlr4oN9RgQGZgJBdQz4jC5c0l7ALcUfpXKj4VgnOvES3d7J/3cT91dgvY
	jqAVsSrWPqZpAxMx1ZOC4rYedfrHu1XiBqejkDCPbumX+1iYGPrizkK52WSS7rwb
	ep93UnpfJSL0WWPpKnEQ+t6pmCHQdvO7wpC0WMZP7IzHsvKOJeW46VyLo3x7JjZJ
	dCBntaUKr5eWMh/c/yYQjLiJyErqlZW8Pmg==
X-ME-Sender: <xms:CVyWasl5hMt5i0cr7mymcY2E556jG6IPwlaqDJPhFKYkL3zlcZdqrA>
    <xme:CVyWavixjzc-bxp5pv7NQCtZQXHfaF-NBbjP71yaSwtnMXGvij_yNaj8MZRN6gMmk
    GqzGE0bJ10Ze5KqHrVv82Ii0NZZ2SkbBg8Hf4vQpGRwO4gcnOMvqA>
X-ME-Received: <xmr:CVyWakfxdivHjdTOeHDZnUfDjv6n7btuJ36opbFCsknycpVqExNFqFG9HNVzdOdxoQbIA5Fyr0nABcZwx_ujOSQnE4A8t5Zgbw>
X-ME-Proxy-Cause: dmFkZTEduq+HziRlbUNvG/pzXlnPebYXNv8hxTjiNdpboMj/5YrYntRKvy8pS+KnfVyts7
    iN3gUyA0LOqLxXdmEaIRBJSGK3jMQoe8QuOmMtZf9hEPQDhVGwnVBkZRWwLN3QdGi/y8ps
    rA7GvapRCLFP3nt8pROdRZ7Fkh0fO0GcuPKfP5lZet0kkxkvSH04O2v4xhEO0xxqzrVNx4
    A2dGTd6IBS7S81VC4YW9lp5viHQmsbMIL/0LptAWI7KUW9G9Pmt+BICqreIyxary8ynvDH
    hM+dVv0AtNtRmMWU/ADAC2hQB1OEgQUmbMYP8odtQ4cQA07eKHnMmy6ySzQxQcHNrjLiT8
    jsQqRa4LkTcpbFHQwS6cvkX3Z+Nzbe6rR0RgMyvmw5qIgwK5OppiIYHJfIALUgEVaDtxJv
    nkul62R83rJ7cWsJ1afxZeMEyt+T9TVPBGy6OcctirmbUGpzeR4VPSqxh0GzfM9JglELkH
    8/FBWA7bo3rZXa9hFRcNAjZVx0qYc+CtYbQy6FRI2wunogjTgQswqqWMmDmnhufsz9rVsS
    xQ6n0gCTpDiHAEgYgs3WdYbqMH9nSwHkB4Sv/gFrYcKQoE/orCROAOnEkDf9wOUti4E1TD
    fPs1hKw7ZPNEMA/BkyDzy6CQe7TjL7CkRIpOaAkeAOkpP4/OB/JIvvJK4Zvw
X-ME-Proxy: <xmx:CVyWavj0y0FPhR4CECFVBMtjUJuLzo8dbbQc50a1E9HdmCXSAIgARQ>
    <xmx:CVyWaszsA429JrtJReZ229sKvpxcPzh9-o6Zzq1EC5-Wzh5uyMuZfg>
    <xmx:CVyWarM5q1RxTyPfICArKgVvhkXo6OFc9KHWyAQfPn3OTgpLh3k8og>
    <xmx:CVyWatXZylutvghDj1y13yfVXk4vvfnIDQwec-g6qAa0YkEu3JOfHg>
    <xmx:CVyWarX8yMq0yWrByednRw45zuwDG_w5oYqquUSGQKO4TMDp2CvRUmUa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 01:00:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Andrew Pleeter via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Andrew Pleeter <andrewpleeter@gmail.com>
Subject: Re: [PATCH v2] builtin/ident: add new 'ident' command
In-Reply-To: <20260901043944.GA1074757@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 1 Sep 2026 00:39:44 -0400")
References: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
	<pull.2388.v2.git.git.1788220746663.gitgitgadget@gmail.com>
	<20260901043944.GA1074757@coredump.intra.peff.net>
Date: Mon, 31 Aug 2026 22:00:56 -0700
Message-ID: <xmqqzey1tvjr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Aug 31, 2026 at 11:59:06PM +0000, Andrew Pleeter via GitGitGadget wrote:
>
>> While existing plumbing commands like 'git var' and 'git config' expose
>> individual pieces of identity and configuration, discovering what identity
>> and signing key will actually be attached to a new commit requires multiple
>> independent queries and manual correlation. 'git config' only reads raw
>> values without performing environment overrides or GECOS detection, while
>> 'git var' returns full ident strings with timestamps without exposing
>> commit signing status.
>
> This is just my gut reaction, but: would it be simpler to teach git var
> to provide those broken-down pieces than to introduce a whole new
> command?

We long timers among our reviewer base already expressed the same
sentiment.

> My main feeling on suggesting this is that:
>
>   1. We already have a lot of commands, and this one feels very
>      specialized.
>
>   2. Most of these suggestions could make git-var better for reading
>      idents _and_ for reading its other variables.

And you said it the best among our responses, I think.

Thanks.
