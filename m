Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AB7296BBA
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781473977; cv=none; b=NUHIbUNHQCzF61Hg092xwnJQ4Y8GBHQHPL4jY23FjhD+1w68pfdxJm+TZuB6KgL/ZOLC8ZfKDAInRAXDba4etCZU/V7xsX/lNAq2He6nUI+UT7gL9YUdJ/eNUCh+s2OvMkSEYgwetXA7cW72mnokyX7wyPJvRl0FfByaRnzQSXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781473977; c=relaxed/simple;
	bh=1zE8ETGrl6ET++w2fN74RtCnXvwTxx8uA57AIAD9qV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gGGKq0b3b62yKZsZpk24/JDViUAXYI22jm3dr4fG4QEOPFQcdw6xD2hVb2I3vflo5ADVR6QG0RcrCslGJCR/HTqOuoSgwIisfDwNihazH8K+UOAt6PfI2zMzSwQYX5bM2LcxOsbfZC+vS5p0GQk8Aq7D84VlhMfDADJgHhu/76c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mO56qzNT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D3RfI6AW; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mO56qzNT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D3RfI6AW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1A9E6140002F;
	Sun, 14 Jun 2026 17:52:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 14 Jun 2026 17:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781473975;
	 x=1781560375; bh=ME2GHviGy2axXP4sOZ+TjmkaHlKcbNcPy6zGdo5HZVE=; b=
	mO56qzNTxsK8dh+6nyJAGoe8fHHhoMPs0fh+z53YAig1yCe/PU2/m9fm6yjIKm9g
	n5WJxU/a1YfYr9doy+01SpQqTHIGw716mggpjMVFvZlkn0LtVw18Q+udJmf+a4AN
	TOYP2gX6a1z3PGbRzd7EBn7ycrSwAsjdnWxEFJJQqqkn8DonU1K4MxtxirxuxQpf
	O+9oZoRHvB46Yz0Z/W9EMI36a07EAGI/lsTGOl86QY6rXRkLGCMZxS+GML+T/aNX
	SGokR9KQKF+2goNUP04CEWQi6GjZ22ma8c+BBmMies3aZeZq5XbQp2y3L7zA/Xj1
	SQKqGV+RCjvpPYG7MurpNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781473975; x=
	1781560375; bh=ME2GHviGy2axXP4sOZ+TjmkaHlKcbNcPy6zGdo5HZVE=; b=D
	3RfI6AWz1S5hCWYDE7SU54/g/i+ZOeVl5MpCHAcMCqG/w+mwzRp6wCVJJ7urPED+
	0aiE1HuBD1ssYZWKiAjjq0eBlvP0lLdRfrg3U3KFvWUjQGzyagKROyxKmqL8P274
	pRWm7c8zQ2fNoFuz/bw9OigT/++QItEyQ31S06ZCo4OW20LB9O7GoVBLe6xyoN9O
	7irmrv3f7xK3+hkjIyVovqTOdIYX7s4pOvjoTrUfC+r9Y8vQLhM0yxrjfwbHPiu7
	sBMWhuE+fUb7t8imos4XR01pKXaiqozO9WyvrUt2FAyzs/PFTqFIcGn3uAPMLDjd
	N5XhZaBo33jfadgI8llKw==
X-ME-Sender: <xms:tiIvahMGDH6wju7xvuoKZNALWnMhZu1pPydBtXbTgKW2jCltkC0reQ>
    <xme:tiIvaq9oRu8g7EPJyYT194ur7KTtHRS4mbTacXUIa3r8-I2Z9fmZPpOEtetcLkgx2
    ZdriFdNrP-ZFfAYudnNBaE0qUkFMHO_Fv_CXbE0adLm8o6dI-Ux>
X-ME-Received: <xmr:tiIvalTaRdR68n6SnE0zgQH31PDw91bF0bF9C6mpLqQTnlUgHlBSjXZ_4NfO0JQ-kh5Y0akpWdTdyQXVjSxul2gk7bJe9XQy5MP6>
X-ME-Proxy-Cause: dmFkZTFdeq6hX4wJvgOQXeEqQ4+DdSI4RM6R+co4HNvR+EUsCW9nQSt13pl3u1prPdvFPC
    A+vFt7dv1toRyt5LcgCK5kitplgxzwigEt0auc51IXScJsPKzfd/u6k8OBBT8fhJOUTtMG
    FtUdRbvTgXbda/dm/ZF+boMnPMLNjhvEllLjMDWa6psAwIem3axE13tbh1SNRGZIkk6wJz
    94kLoTyp1Oo2Np3AsFcnTxsqemz32087VjhNeSIR/aaUE/3dbvUZYjfR/Ldy7I36GRI06P
    GrVDgI1MwpycA/gNO9S9KDOpuR28miM5Mz9gPqQtr3ISkxnw/0tgA6I2wNTKUMHeeYYJiQ
    Zev/1mpZvKAg3DU3PQXGur1zGjGy4CL5mNnQVW7EfOB/GhvRCvEn6uygLq7lqJvWkOl/iD
    UjRgtpK1N/lvxbJcjtO4RtgCQ25+4FyQ1sQUCKsDEK6ard9o+dCPiPcy13xIngcD4iZ2yM
    h+CF3jNywYoLkfmfm8b5AXeY17x89lGpRqNcm86lZxIk6h+kW7jhgqI5DIVhDIfk+sFQHY
    96PIlzkV/fpw+Aq0HZUWy3q/leX6t+l5NwBcLwu7D+3vxLYA8Yca9DP0JVXaDqFJPEZg59
    kSMA37oIkDH9AZaHmP12FQD8G38pnkO3+eINzxXA5jgmtzwCGyeFaID4AC2w
X-ME-Proxy: <xmx:tyIvasl7dRrsWKY-YKl0lmddsVpyu45vlF4wBI1U_6MkP6NL3Vjdzw>
    <xmx:tyIvalSAyenf1VXg0NQXK1QoOTAOI_smyjxHCZ19T4MP1RlgYD6TZQ>
    <xmx:tyIvaqNpHQgzCFpT-5ukHbWrmZERRDGRXTZZS8CJo_8zFxIN-IZCSg>
    <xmx:tyIvauV_nSV31qvRu4vQPSeoU61kdsOd7g8KwXfcONX_6mMt78tkBw>
    <xmx:tyIvaoyxDZij6vTBqRtm6rjza_WlZMV088wXKwEsau5vP4qVT5pTrLQW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Jun 2026 17:52:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] doc: fix a small, old release notes typo
In-Reply-To: <645638cd87d6d919af6d4310be8176d49fba326e.1781456960.git.ben.knoble+github@gmail.com>
	(D. Ben Knoble's message of "Sun, 14 Jun 2026 13:28:31 -0400")
References: <645638cd87d6d919af6d4310be8176d49fba326e.1781456960.git.ben.knoble+github@gmail.com>
Date: Sun, 14 Jun 2026 14:52:52 -0700
Message-ID: <xmqq1pe8eqmj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
> No harm done if you choose not to keep this, I think. Stumbled upon it when
> trying to understand Elijah's message [1] about timestamp_t overflowing in 2106
> (I though 32-bit time_t overflowed in 2038, but timestamp_t is something
> different… except maybe when it's not? Anyway…)

Unless it fixes a glaring factual error that would harm end-users if
left unfixed, I would not very much be enthused to see fixes to
these ancient documents, quite honestly.

>     separate and dedicated timestamp_t (so that we can distinguish
> -   timestamps and a vanilla ulongs, which along is already a good
> +   timestamps and a vanilla ulongs, which alone is already a good

"timestamps and vanilla ulongs", as both are plural?

