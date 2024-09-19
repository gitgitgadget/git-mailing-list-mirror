Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B08E1B29BD
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 22:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726783882; cv=none; b=JnJPBmUtMUM22Y+LOMal2JzSY/9Q7UZhX4jFDZrih1tzMP6nxfT1zFvInNHHVXFIw/5J8CxemXDeMRkkX/LpRd9O/gFq5t0jfzw/wHhanp5SNLhY7NXTse+7zLWdt90i3X2+caWlhIn/qX5OfEczXlmXt4NbEsVC6hd4Gx5UoIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726783882; c=relaxed/simple;
	bh=hjLvm9igmU477sjaF7nZysqsPWv5cIqHNN/fod5BaF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S6cxnNF1SQwbwMnV6wFNxuqYeCE0MLGjKMgUHOjAGWeMs/mN+Qc4M+F12z45HcaIwT2BSvKhju6UG74g+ZE2rjSEz1UNVEsP1tRF/dAi3/T4hnvMtpP2mDZPg28apSF2RvTM9+Rk8t1Vxj669J9UjR+3r2xg+HZPI9Q7Fot95RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kr+MFLEs; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kr+MFLEs"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DD55D2D20B;
	Thu, 19 Sep 2024 18:11:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hjLvm9igmU477sjaF7nZysqsPWv5cIqHNN/fod
	5BaF8=; b=kr+MFLEs/UP69wvfL3Zo1+07IU3VhYE0DgWtnUE3jy7qdL2QUxloz1
	8WJDDDjU/yU59wSZ7g+7Dhv1IK3bWH+gL9lCGfU2pjaB3xAGPpBrhGJJpG/TMNT1
	D8ASK2korkeGMWDkUFhMtBjTi+JkuSYqKihsjCu61E0e6IF77CLlU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D3D822D20A;
	Thu, 19 Sep 2024 18:11:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4935D2D209;
	Thu, 19 Sep 2024 18:11:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  ps@pks.im,  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 2/6] repack: test --full-name-hash option
In-Reply-To: <48b87cccedb3d7920a3184ca86ca9eec77c0fd01.1726692381.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Wed, 18 Sep 2024
	20:46:17 +0000")
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
	<pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
	<48b87cccedb3d7920a3184ca86ca9eec77c0fd01.1726692381.git.gitgitgadget@gmail.com>
Date: Thu, 19 Sep 2024 15:11:17 -0700
Message-ID: <xmqq7cb75m62.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 18CF57DE-76D4-11EF-8122-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The existing test_subcommand method requires an exact list of arguments
> for the subcommand. This is too rigid for our needs here, so create a
> new method, test_subcommand_flex. Use it to check that the
> --full-name-hash option is passing through.

This is something I found need for in the past at least a few times.

> +# Check that the given subcommand was run with the given set of
> +# arguments in order (but with possible extra arguments).
> +#
> +#	test_subcommand_flex [!] <command> <args>... < <trace>
> +#
> +# If the first parameter passed is !, this instead checks that
> +# the given command was not called.
> +#
> +test_subcommand_flex () {
> +	local negate=
> +	if test "$1" = "!"
> +	then
> +		negate=t
> +		shift
> +	fi
> +
> +	local expr="$(printf '"%s".*' "$@")"

OK, so it works exactly like the comment said.  You allow arbigrary
garbage in between the given parameters that come in the order
given.  As long as this is used to make sure that the flags are
passed through, by somebody who knows how the code constructs the
command line, this should be fine, as we won't be permuting the
command line parameters.

Looking good.


> +	if test -n "$negate"
> +	then
> +		! grep "\[$expr\]"
> +	else
> +		grep "\[$expr\]"
> +	fi
> +}
> +
>  # Check that the given command was invoked as part of the
>  # trace2-format trace on stdin.
>  #
