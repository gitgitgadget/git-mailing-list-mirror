Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9663357302
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705688871; cv=none; b=dT+a/VKP4wWxU7iwn1HVyrBuIVYjSpl2Ts9cMSmOnuqrDXGfNBhiFKb4o5I3PlJdxRV40mc5EYACGZH++U1ux6QgIZie0pqRAxchJDaOdS/0JLZlQxniU71LCMp72a51NIIkW+dA8TI/8Flji4Wmn0MEvuqk/q8IH4ycclLsPtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705688871; c=relaxed/simple;
	bh=CSVZdHqOIdns5C3OsyomyE/f+fAF66TKlOGUn6dhb0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=alcqKMlXfg6+a+9JBUojKkmhBN9JTaEmugvsF1xVq2/MXwAdZFHqEmAH7C3/1kdQFarqYoPD8K6aMmvhRFPxZ4AlyfvngVFn0f21MqKKAs8NRBQ9StBeVtfNfhEmaVPIPUzMbDQXIAS7e7KHkkGR2obac2KIOQzCYje/2aK2x4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OLYFfKuq; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OLYFfKuq"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E21741D546C;
	Fri, 19 Jan 2024 13:27:47 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CSVZdHqOIdns5C3OsyomyE/f+fAF66TKlOGUn6
	dhb0o=; b=OLYFfKuqPqY2ZhH+TLHp1yh0N+6KkntTiM9DFur1UfrnLRBEZG7nMc
	T7D5pY5PkDNYnb/n4cHmj1AFeuPIg/6L6PsJbYGhAkRQn06K+quvHeTTi4uo6V/+
	wdMByfaF1qzVAZd+a9z29XrboTnf8fuWwlxc9xpebD62CR4s/wJO4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D2F501D546B;
	Fri, 19 Jan 2024 13:27:47 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 32C951D5468;
	Fri, 19 Jan 2024 13:27:47 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Britton Leo Kerin <britton.kerin@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 0/5] completion: improvements for git-bisect
In-Reply-To: <ZaofJhHsFjRxx7a3@tanuki> (Patrick Steinhardt's message of "Fri,
	19 Jan 2024 08:05:10 +0100")
References: <03fe3371-2b0f-4590-90ad-166b8fa4cbbb@smtp-relay.sendinblue.com>
	<20240118204323.1113859-1-britton.kerin@gmail.com>
	<ZaofJhHsFjRxx7a3@tanuki>
Date: Fri, 19 Jan 2024 10:27:45 -0800
Message-ID: <xmqq7ck5kwke.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 71C94F76-B6F8-11EE-B56F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Jan 18, 2024 at 11:43:18AM -0900, Britton Leo Kerin wrote:
>> CC to add: CC: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
>> 
>> Relative to v2 this only changes a wrong misleading commit message.
>> 
>> Bring completion for bisect up to date with current features.
>
> Thanks for your patches! I've got a few comments to bring them more in
> line with how we're doing things in the Git project, but I agree with
> the overall direction that they are going into.
>
> It might be a good idea to also add a few tests in t9902-completion.sh
> to ensure that the newly introduced completions work as expected.
>
> Thanks!
>
> Patrick

And thanks for your review.  Very much appreciated.
