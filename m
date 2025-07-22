Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA6E44C94
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221893; cv=none; b=JegDJC1ziW6X3a6DKCUqfT3elDCnDoGfpn0FyGNLJByE10ydZXLQkVHLyelO3VjMVuJmc7b7O7y4BKkmxULVHot6SFocgQAGPw/74X4ek7bYnY0Wxo3yYWC0FkX4EQ748BKJGgbazxLKmxUlvv3MU0+OvHwhSANLWKDwGU7gLLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221893; c=relaxed/simple;
	bh=AwNiNaCn1auePNM1eaDU//c67Fe/M/Hv1sTXwWn0G/0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s7PyYNZmVpxmWJKjo8BbbA+M8v8ixNBBdMkTUtE9zNodpTadFf5na/sKCklmBJJV/JHMIMrfGIPx3IolhRAQSlAjYwe07mckDSuP2WwQQFtOJnircrizdxxCt5PAuzwLTrXxxNiKbmjyi/IhTdfh4LVhofdOi1vrtL0pE8l5JHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SVzCCjGc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LMXNbRTr; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SVzCCjGc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LMXNbRTr"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 352EB14005CE;
	Tue, 22 Jul 2025 18:04:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 22 Jul 2025 18:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753221891; x=1753308291; bh=0xlwYBsrGb
	XBq3JW2HUBfKfuS0V0BRtsWv2tIQpgN5o=; b=SVzCCjGcmMUsXGT/p7cxbkehl/
	sWdmrYZvRmFG33I8erNyINE9KYI0Y4h6NJYMTVK+3iPWPZCekRetSm5WDw4Re9W7
	y+ELzYBCOH5KAH7A2+RQU81A7F4NUkmc9nqH4xghmQ8vGO88z2rN7NNRD0Wqz71L
	OwzqikfEd1xlc6ZkN+EI8eXnJmABaRzH+fPblSiUS4141+tGYo0tD4oR7dKsuR+s
	3hdbAPWT692KMUK9dsRbKlDhue148uM2WjmY39Ra8wXgqHBftU4jxFqSAk680fA3
	J+L6B9DgPstvTLVdT1aQApMNwWJgUjrJfdKQnKB+J+gHGIjC81XFdnht1lig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753221891; x=1753308291; bh=0xlwYBsrGbXBq3JW2HUBfKfuS0V0BRtsWv2
	tIQpgN5o=; b=LMXNbRTrCNFssUGfHvfPNt9hoWGfqFfp/GNcTOs6JiYZlkGwbNN
	hPtEUUgBdYbOeQ7iooZUOtje6RqVb0u4GMqzLGZKNyVfdAB197IOQP+CP5E4p8xj
	dxrjtWtX101T3dCUq5acZcfyzMvOn61l4PNu9fueXvV4xc3Jo+VSsAkMy3uQl3v0
	lJUzQP0V7dnsTH3uCwSN+8Esnci5hh5dytS2CR7xAOXRvgzPTV01KRNLlmLl4EnW
	ZjPwpn5i5S9/31i1qezCbg2bOQJ1ZRvsohO/aB/kfbUwUmNtAUwQFU47iZEfAF94
	CmHnTMMJ9HK/s5yyQ3OjELnMoLJsdvTZM1g==
X-ME-Sender: <xms:AguAaL7Aq764_6z4iqI0saLFDfMgfYrY9DAlXUcr5DwkNCq-iMvOmg>
    <xme:AguAaLfSXV-Cz3qIgoI1ETvKm4MfqQjbz3911YjFdCXaMWJxI8jtyBs5LCpjRyqDF
    Y_Al4hf_Ho4y9it5w>
X-ME-Received: <xmr:AguAaPAvF7KwrF1b1eVDs6nt4fBpLr5mSQUUBEjWal-502Z88DPtq79qqudmHLsAveWxZ_nu2NVENoXxp7kUgzYZRDV7NHrw6sfob5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejiedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:AguAaO8-cqcb1Ci3SVIZ1R9CN63kU0cPjerIPZyQWODJuc03t0jLPQ>
    <xmx:AguAaKLTGYX6WsQeTcmdFU4U0qNQHXkIdSDjcIfeShMISOXXTTUrQw>
    <xmx:AguAaHi7Zf2xJmqQmopQiv11hV2baoAnEgXtW0pT9qMGM3cSTITHJg>
    <xmx:AguAaK6Ii0gG61y_vW1yxA2Fdkg6ZtTkc8fmX8bs-3ggYZLyVmeapA>
    <xmx:AwuAaLqpV_ESXtwMi_Nwmue_UXhP6F7FvJaO5kIAMZpDEr0eauLsXnjA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 18:04:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 1/8] Documentation/git-reflog: convert to use synopsis type
In-Reply-To: <20250722-pks-reflog-append-v1-1-183e5949de16@pks.im> (Patrick
	Steinhardt's message of "Tue, 22 Jul 2025 13:20:50 +0200")
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
	<20250722-pks-reflog-append-v1-1-183e5949de16@pks.im>
Date: Tue, 22 Jul 2025 15:04:49 -0700
Message-ID: <xmqqms8vrif2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> With 974cdca345c (doc: introduce a synopsis typesetting, 2024-09-24) we
> have introduced a new synopsis type that simplifies the rules for
> typesetting a command's synopsis. Convert the git-reflog(1)
> documentation to use it.

Good.

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-reflog.adoc | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
> index 412f06b8fec..707a9b39edb 100644
> --- a/Documentation/git-reflog.adoc
> +++ b/Documentation/git-reflog.adoc
> @@ -8,16 +8,16 @@ git-reflog - Manage reflog information
>  
>  SYNOPSIS
>  --------
> -[verse]
> -'git reflog' [show] [<log-options>] [<ref>]
> -'git reflog list'
> -'git reflog expire' [--expire=<time>] [--expire-unreachable=<time>]
> +[synopsis]
> +git reflog [show] [<log-options>] [<ref>]
> +git reflog list
> +git reflog expire [--expire=<time>] [--expire-unreachable=<time>]
>  	[--rewrite] [--updateref] [--stale-fix]
>  	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
> -'git reflog delete' [--rewrite] [--updateref]
> +git reflog delete [--rewrite] [--updateref]
>  	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
> -'git reflog drop' [--all [--single-worktree] | <refs>...]
> -'git reflog exists' <ref>
> +git reflog drop [--all [--single-worktree] | <refs>...]
> +git reflog exists <ref>
>  
>  DESCRIPTION
>  -----------
