Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C4C56B80
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 21:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D6Y3WAr7"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 351E71DCDD0;
	Thu, 11 Jan 2024 16:03:46 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zKi2Jzw63m+C7S/G5vDTHcveBaMfuXBikUowIq
	V2nh8=; b=D6Y3WAr74kwFUcCNI0chIN0uySa7uPsbwmLm1WMrg8+OHYUDgNvsO6
	suEO9JBruECcZp5wzNr0p/X5mSF5RtyucBcGL2E+zihsiWmO0hG9pOfzrDkHIuoK
	o7P3JS3IXcNceDV9nv4mExRuyVn6h1WTLRYQekhxgnHi9ONOGjUVs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C3901DCDCF;
	Thu, 11 Jan 2024 16:03:46 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 89B441DCDCE;
	Thu, 11 Jan 2024 16:03:45 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Stan Hu <stanhu@gmail.com>
Subject: Re: [PATCH 2/2] completion: silence pseudoref existence check
In-Reply-To: <24563975fca8df6ae73917e9ee3534933d47c429.1704969119.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 11 Jan 2024 11:41:59 +0100")
References: <cover.1704969119.git.ps@pks.im>
	<24563975fca8df6ae73917e9ee3534933d47c429.1704969119.git.ps@pks.im>
Date: Thu, 11 Jan 2024 13:03:44 -0800
Message-ID: <xmqqedenfuq7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E87FB1E4-B0C4-11EE-89E8-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> In 44dbb3bf29 (completion: support pseudoref existence checks for
> reftables, 2023-12-19), we have extended the Bash completion script to
> support future ref backends better by using git-rev-parse(1) to check
> for pseudo-ref existence. This conversion has introduced a bug, because
> even though we pass `--quiet` to git-rev-parse(1) it would still output
> the resolved object ID of the ref in question if it exists.
>
> Fix this by redirecting its stdout to `/dev/null` and add a test that
> catches this behaviour. Note that the test passes even without the fix
> for the "files" backend because we parse pseudo refs via the filesystem
> directly in that case. But the test will fail with the "reftable"
> backend.

Thanks.  Will queue.
