Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1234C1372
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 23:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725490888; cv=none; b=asphGw47IkQrsyPYGg+IOns5zYfdd8VqIry8C4NXCjTJdNwzBAKuv1rw+2Lg+refYbc+rJzs5sc7RWCymQWtOfU3JIS9oqDDCZQ0h48aPSRXkW6CbMhsZVGL1KdVYl7tWC3rDNPguNjVGR+zylf1Zvd8O0neyqcZXQNsEUyrgSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725490888; c=relaxed/simple;
	bh=YHNrKH8DPKaLgcjH3AtGXnzYA2HxuIwdqb1yIKJguZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zg+43jqJdvPvakNFwgD6vDo43TSkpNl/rAMomdnyTXKE6Y0kQUS/j++hkUEIEhMUhXPxt7Y62VONC9YiSung6+mg/h71uypKonK9s+x4bqoRbEEwwJJJw4TVV3v2oyDNHqQAHvxvUeQfDc4UimZ5XOTctKqbya2YSX11H+3FjKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NWdktHRz; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NWdktHRz"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E660A1AB4A;
	Wed,  4 Sep 2024 19:01:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YHNrKH8DPKaLgcjH3AtGXnzYA2HxuIwdqb1yIK
	JguZ8=; b=NWdktHRzDlyuqCBweKK1l6WodF7qbXLD9Ifb2vKHyBiUA+GrA2bFUL
	i/WzAdVkBfY1E8R4VcIooba5WvRyOesjS91OQIbk3R6dx7Fymeksz+1UKb3nSFEj
	G7tHCrzP3iqBKVYuOcFv+MfrnQ9Uz2INJFfGVd4nuByu0fB1seQBQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DD4E11AB49;
	Wed,  4 Sep 2024 19:01:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4EEFA1AB48;
	Wed,  4 Sep 2024 19:01:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/22] Memory leak fixes (pt.6)
In-Reply-To: <cover.1724656120.git.ps@pks.im> (Patrick Steinhardt's message of
	"Mon, 26 Aug 2024 09:21:31 +0200")
References: <cover.1724656120.git.ps@pks.im>
Date: Wed, 04 Sep 2024 16:01:23 -0700
Message-ID: <xmqq1q1z6n24.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9BBFA8CA-6B11-11EF-ADF3-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> here's another round of memory leak fixes. This is the second-last round
> of "general" leak fixes -- so once this and the next series are merged,
> I have made a full pass over all failing test suites. There will still
> be a bunch of memory leaks, namely ~86 failing test suites.

I've read (or at least briefly scanned) most of the changes in this
series over the course of several days, and did not spot anything
glaringly wrong, other than a small typo or two whose fix should be
trivial.

Thanks.  
