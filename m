Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEA6145345
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 22:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726784545; cv=none; b=okujZa2AGxVO4xE6Le2F0HN/YpT8psXjEWsTuoK2J906xT2m96TMQfLjQekRxFzYClBXhQYZMSb60xOV4i4VMoE+cS6YJQTovUsPwQum0mflRsB4we9zDhUwejMCbjQyQmkLF0lAWTust1UjqLc1mIoxJqRI5bi9lSppf+ZJR9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726784545; c=relaxed/simple;
	bh=5yHFU0ubb/eNZiLYppAYiB0AO46OWU+/2Us7xlegwvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p1eA66oFx9x1PcNYrkw4Iy97FY9NnSeixj6VZvGRWd0xpZoX16BUaN7sBy3W28IRTJJvcuB5XMfNxqz3L2Ta6DA19ZtxqAhg5DI0dv219jfU+PbEPYzT9XQ+JerSxJX+2KzIwOcasVZyFNqfZv0fkyboSZQXe9OIykTCr4z2eGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BPahwE6B; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BPahwE6B"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 931572D39F;
	Thu, 19 Sep 2024 18:22:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5yHFU0ubb/eNZiLYppAYiB0AO46OWU+/2Us7xl
	egwvI=; b=BPahwE6Bry83LdWPzNgA538hrEfZdJmrn9y7B/uBMGw9CzDXoNSjbj
	LqyCf81jNBdOv4q4G/BAN4uwHYdwo6p8wzXAPzRLnLQy7WzKwwUubWBhKWLLfM8D
	WnRcKluv7Pyz9AP19O017l7Uo4oaKHf12xS0Hr1j0DY1qQe4H5BL0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 889B92D39E;
	Thu, 19 Sep 2024 18:22:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E61BE2D39D;
	Thu, 19 Sep 2024 18:22:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  ps@pks.im,  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 3/6] pack-objects: add GIT_TEST_FULL_NAME_HASH
In-Reply-To: <48b3876a10247d2ba65a6e5f1ff8ed3a662813f8.1726692381.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Wed, 18 Sep 2024
	20:46:18 +0000")
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
	<pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
	<48b3876a10247d2ba65a6e5f1ff8ed3a662813f8.1726692381.git.gitgitgadget@gmail.com>
Date: Thu, 19 Sep 2024 15:22:20 -0700
Message-ID: <xmqq34lv5lnn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A3C75908-76D5-11EF-A714-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> Add a new environment variable to opt-in to the --full-name-hash option
> in 'git pack-objects'. This allows for extra testing of the feature
> without repeating all of the test scenarios.

This also allows the programmer on the C implementation side to be a
bit lazy, as the --full-name-hash option does not have to be plumbed
through from the end-user facing commands (like "bundle") down to
the underlying "pack-objects" command ;-).

As an end-user facing tweak mechanism, an environment variable is
the most clunky, followed by a configuration variable (which can be
used via "git -c" and exhibits the same clunkiness as an environment
variable), and a command line parameter is the most versatile in
allowing users to customize the behaviour per-invocation of the
commands.  So in the longer term, we probably want to plumb through
the option, like you did for "repack -> pack-objects" call chain,
for all end-user visible commands that call into pack-objects.

But for testing purposes, the solution presented here is of course
good enough.

> Second, there are two tests in t5616-partial-clone.sh that I believe are
> actually broken scenarios. While the client is set up to clone the
> 'promisor-server' repo via a treeless partial clone filter (tree:0),
> that filter does not translate to the 'server' repo. Thus, fetching from
> these repos causes the server to think that the client has all reachable
> trees and blobs from the commits advertised as 'haves'. This leads the
> server to providing a thin pack assuming those objects as delta bases.

In short, the tests are based on broken assumption and checking
bogus outcome?  Somebody familiar with the partial clone area should
probably take a look into it and fix the tests if that is the case.

> -	if (write_bitmap_index && use_full_name_hash)
> +	if (write_bitmap_index && use_full_name_hash > 0)
>  		die(_("currently, the --full-name-hash option is incompatible with --write-bitmap-index"));
> +	if (use_full_name_hash < 0)
> +		use_full_name_hash = git_env_bool("GIT_TEST_FULL_NAME_HASH", 0);

OK.
