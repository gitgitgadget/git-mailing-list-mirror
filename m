Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DFB2F2C
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710889186; cv=none; b=udwu4MpqjSiPYqYLFdN4FArQO2dQEWpLTh1Q3jlCqm/qJ/H3hPl+cJ7YiT5r4VD+FdzGXZpjNK8QN6QY3UzpZrsZdwUQyG5MnfxvqHNSY+wxirmXgjPHkfekSqFVWJACBPEmXOPk/34gXdjPC8xPPYGEQ8p/y29HhDVKLieqf4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710889186; c=relaxed/simple;
	bh=LXL/zBpRcZmdfWrWgdERUQlQIufQ50WZRC+M+D8E1QU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dYRLyWSVeK0Tle2n1aut5dimr4b5p2HvGqmBTGM1Fk/RvoYOPH99eQMhY8WgSH6t3/uymTKBrZtmYgK5jaM/xmKX+m4Og87CpiBL5bysZdTv63mTioRUJoxVeJVHiR7Iek+HxtokeX68TN0BDo0cEdC6WZFUVhvQZk4hRZ61eM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZvvRnqsh; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZvvRnqsh"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B2EEB1CEDD9;
	Tue, 19 Mar 2024 18:59:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LXL/zBpRcZmdfWrWgdERUQlQIufQ50WZRC+M+D
	8E1QU=; b=ZvvRnqsh2tJjAwQS1R5N099grujBIwtRMgR8pQGxXB4jZwtZrKQ8Zq
	BxvO1SR77o/o4dF4YgkkjA7ptzJStxvQVMwh3oG8NgOi66iNR2MU238ahnm5yrja
	ZkBz8GdYYSs0LM0oI8SwKz83zzQ8BuuZnH3+wV4NfAKKnjivcEDrQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A9FCC1CEDD7;
	Tue, 19 Mar 2024 18:59:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1B7B61CEDD5;
	Tue, 19 Mar 2024 18:59:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Dirk Gouders'" <dirk@gouders.net>,  "'Eric Sunshine'"
 <sunshine@sunshineco.com>,  "'Ignacio Encinas'" <ignacio@iencinas.com>,
  <git@vger.kernel.org>,  "'Jeff King'" <peff@peff.net>,  "'Taylor Blau'"
 <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/2] Add hostname condition to includeIf
In-Reply-To: <02d701da7a4d$3e60e960$bb22bc20$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Tue, 19 Mar 2024 18:31:47
	-0400")
References: <20240309181828.45496-1-ignacio@iencinas.com>
	<20240319183722.211300-1-ignacio@iencinas.com>
	<CAPig+cT4fpX7Kczu0+H5TZnmpVqqq0h8nBafj4UqDs7Xv2Nf4A@mail.gmail.com>
	<xmqqa5mulycz.fsf@gitster.g> <ghv85hj446.fsf@gouders.net>
	<02d601da7a49$3bbf1230$b33d3690$@nexbridge.com>
	<ghr0g5j1sc.fsf@gouders.net>
	<02d701da7a4d$3e60e960$bb22bc20$@nexbridge.com>
Date: Tue, 19 Mar 2024 15:59:42 -0700
Message-ID: <xmqqbk79ltep.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5F9C1402-E644-11EE-AE37-25B3960A682E-77302942!pb-smtp2.pobox.com

<rsbecker@nexbridge.com> writes:

> No worries. I only know this point because I was rather deeply in a related
> code base back in 1994. I did not know that glibc varied from an old UNIX (I
> think that's where the code was from) code base prior to this thread.
> Learning is good and never a problem.

It is not surprising that you were doing gethostname in 1994, but it
is very surprising that you still remember such details ;-)

