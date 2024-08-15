Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36A21537D4
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 21:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758746; cv=none; b=akLfKyqoJVzsHps2UURe66cQXqlrx24rB7fYznFjKO1W11CzKCeC4L30p/8j8rLxB4AYgShIyj2FbpGmmoBfbVJkG9MjMYrYaX6TDjYkdA3v/IQBUrxvhb0uhj5jHVk6jXZE9YBhAM29L1g5lRDWKKfcZKNtyg5JouX5iTEVqAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758746; c=relaxed/simple;
	bh=jYBYTWATmiKCnXhPdSU8EDg2/zbPh//PptIFDVNPWUc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gP2vLAh2w1Dfs+Q7YCZ+m/ed0jzTQd3aSUUvwAhVcxjYuquO6Pu79wxwvSHoIa/4k/w16HhTCJCCELr6VRCjFIEFAZEzSSzCFU/JtIL6vKC7TpKi9J6egqgRfkkHNlvu671Pu5AxIpZ/58PCgyi2fBRfRiue0GBbzKTbq5N0GBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=U2Ef0i/7; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U2Ef0i/7"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 76EB325B97;
	Thu, 15 Aug 2024 17:52:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jYBYTWATmiKCnXhPdSU8EDg2/zbPh//PptIFDV
	NPWUc=; b=U2Ef0i/7ncyKPFARYYrBoTOKpUnR4eD+BcU0t/MqprA9FbF1j+K1+e
	aEHcohhq6X9jMqPcTdFS3RXzLhy++wSSS8NBlyPlFjpwvTf9yAq7uhZhwy8XgK+U
	z+QaERcZdJTaI1Ed9qxbksgoHDuVnRz1BN3ktLOgY7FzNqU0B9CLQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6EF6825B96;
	Thu, 15 Aug 2024 17:52:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D347925B95;
	Thu, 15 Aug 2024 17:52:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: shejialuo <shejialuo@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org,  Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 0/5] Introduce configs for default repo format
In-Reply-To: <Zr5wODo8tgGtPEIM@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 15 Aug 2024 21:16:40 +0000")
References: <cover.1723708417.git.ps@pks.im> <Zr4dvybR6j6Ifyya@ArchLinux>
	<Zr5wODo8tgGtPEIM@tapette.crustytoothpaste.net>
Date: Thu, 15 Aug 2024 14:52:21 -0700
Message-ID: <xmqq4j7lsbca.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A6FBFEF8-5B50-11EF-B691-9B0F950A682E-77302942!pb-smtp2.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2024-08-15 at 15:24:47, shejialuo wrote:
>> If the user uses the following command:
>> 
>>   $ export GIT_DEFAULT_HASH_ENVIRONMENT=sha1
>>   $ git -c init.defaultObjectFormat=sha256 repo
>> 
>> The repo would be initialized with the sha1 algorithm. I think we should
>> think carefully which precedence should be higher. I cannot give an
>> answer here. I am not familiar with the whole database and do not the
>> concern. But from my own perspective, I think the precedence of the
>> config should be higher than the environment variable. This is a new
>> feature, the people who would like to use it, they will never use
>> environment variable and we should ignore the functionality of the
>> environment variable. But for people who do not know this feature, they
>> will continue to use the environment variable and they will never be
>> influenced by the configs.
>
> The standard behaviour we have with other environment variables is that
> they override the config, such as with `GIT_SSH_COMMAND` and
> `GIT_SSH_VARIANT`.  The reason is that the config in this case is
> usually per-user or per-system, but it's very common to override
> settings on an ephemeral basis with the environment.

Right.  It is good that somebody can give a clear answer when a new
person says they cannot and then give an answer that contradicts
with an established practice ;-).


