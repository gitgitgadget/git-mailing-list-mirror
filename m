Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8AF16A94F
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 20:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718656431; cv=none; b=d4PiLIjfR1sAPfCJzCb17XgmGpRx7UsflyPAxTAKlkgAO8oWB8rSQTIUpFNTvr41UMfD7ajumiaMTUZnNNRzonS8/zXrn7RshTKU29rNqT54yfCPJVanP+pGz53PqJXuga+2X6TRrE6MqGfw2HkK0XwCIsszT9oFmATTUqnZUlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718656431; c=relaxed/simple;
	bh=HKcK10LFTNDswI1aIF4tUa+Y3bo/1jFM+bRNitTurc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gQbgrv5ReXVFGPwS8o97mteYgqtVMcgJupL5inxu+bn6ZT1BkuPPkbpH2ApdWKOKQpQSqXh4AGdMCaP62U6qy7k5JknuSJ4EEh8JM0yvaYEaIcawGbwGKjzjbQmWDa2HYI3b3YCfXGJ7qSyWG3VD7gzm6qC1QB+1dIGAhKbzMxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uToZ40ry; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uToZ40ry"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 214411F17F;
	Mon, 17 Jun 2024 16:33:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=HKcK10LFTNDswI1aIF4tUa+Y3bo/1jFM+bRNit
	Turc0=; b=uToZ40ryKi4kseMPEL9+ZTNSMQgr39BT4N3UDgXUVnwaIW3vn3k99Y
	SaX0vtqv25T1i9/F48vSYTZFKDSWO52L1dMR7BBfGQuMbFrvNwQs6cFu7cAr54WG
	ZRUmTACuLD4GEksiMSv/tQi2uvAeDWvHRv3rDGKtCTnMKVv7CR1Rk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 19DA51F17E;
	Mon, 17 Jun 2024 16:33:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 83B9F1F17D;
	Mon, 17 Jun 2024 16:33:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] Git.pm: use array in command_bidi_pipe example
In-Reply-To: <20240617104326.3522535-2-e@80x24.org> (Eric Wong's message of
	"Mon, 17 Jun 2024 10:43:25 +0000")
References: <20240617104326.3522535-1-e@80x24.org>
	<20240617104326.3522535-2-e@80x24.org>
Date: Mon, 17 Jun 2024 13:33:47 -0700
Message-ID: <xmqq8qz35mxg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E6A75EBC-2CE8-11EF-864B-965B910A682E-77302942!pb-smtp2.pobox.com

Eric Wong <e@80x24.org> writes:

> command_bidi_pipe takes the git command and optional arguments as an
> array, not a string.  Make sure the documentation example is usable
> code.

Makes sense.

>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  perl/Git.pm | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/perl/Git.pm b/perl/Git.pm
> index 03bf570bf4..aebfe0c6e0 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -418,7 +418,7 @@ sub command_bidi_pipe {
>  and it is the fourth value returned by C<command_bidi_pipe()>.  The call idiom
>  is:
>  
> -	my ($pid, $in, $out, $ctx) = $r->command_bidi_pipe('cat-file --batch-check');
> +	my ($pid, $in, $out, $ctx) = $r->command_bidi_pipe(qw(cat-file --batch-check));
>  	print $out "000000000\n";
>  	while (<$in>) { ... }
>  	$r->command_close_bidi_pipe($pid, $in, $out, $ctx);
> @@ -431,7 +431,7 @@ sub command_bidi_pipe {
>  calling this function.  This may be useful in a query-response type of
>  commands where caller first writes a query and later reads response, eg:
>  
> -	my ($pid, $in, $out, $ctx) = $r->command_bidi_pipe('cat-file --batch-check');
> +	my ($pid, $in, $out, $ctx) = $r->command_bidi_pipe(qw(cat-file --batch-check));
>  	print $out "000000000\n";
>  	close $out;
>  	while (<$in>) { ... }
