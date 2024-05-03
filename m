Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD0C8495
	for <git@vger.kernel.org>; Fri,  3 May 2024 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714757465; cv=none; b=n/0DG9ft0BYK8PYRzIRVo/MYHuqorYqhBnFJkaf7X/ZFg9Ggi3w83xoVISTVtFtbKMColGhlZJNWjsXKB7tmzapnh6cFATgeH2OGqWpw4m1iHB9EUDauhEAzvIFLlIW3ZybD6dcK39BVs/6FswfmJIa4Zjkyv5q1OwmngiI7Df8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714757465; c=relaxed/simple;
	bh=0hyW9TFXemPxJ8MaCTC4CCE9BqeFV9TOtzsVXl9PMwk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ho+dTK87N66g5s6u/KSen7dd1++qmNr0rBdjXXuRHvNI8BwKZKo4grhBK4L8D7Iv33rTr4WmdDCo0YFZyVgZFFoiBqJGRZK4eD4VIqcVOzh+KIIA/hvtNvq7kg5D3kpGSDscXuXk7i6pFrSr4dyZz1Efa9Htp5z3yvNi2MihIZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=m64u/3BK; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="m64u/3BK"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9447026949;
	Fri,  3 May 2024 13:31:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0hyW9TFXemPxJ8MaCTC4CCE9BqeFV9TOtzsVXl
	9PMwk=; b=m64u/3BKciH2tyJEOSnAeM5SjoNWw40YX1J2CiOxTde2D/bB/A7B1q
	85gbkwGAaIA+7gGJkIIM9QzJsadlFIvi+gopLdnzeIPMrxRu690C4WhWpAwG0axQ
	HUn5i2Ah2g7u+8qK1m5fe25g1qHc/+KmrHTlczARTCXkGMbiGbchA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 77CF526948;
	Fri,  3 May 2024 13:31:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 92E2526947;
	Fri,  3 May 2024 13:31:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 1/3] doc: clean up usage documentation for --no-* opts
In-Reply-To: <20240503071706.78109-2-james@jamesliu.io> (James Liu's message
	of "Fri, 3 May 2024 17:17:04 +1000")
References: <20240430014724.83813-1-james@jamesliu.io>
	<20240503071706.78109-1-james@jamesliu.io>
	<20240503071706.78109-2-james@jamesliu.io>
Date: Fri, 03 May 2024 10:30:59 -0700
Message-ID: <xmqqa5l6950s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E8AB791C-0972-11EF-97B3-25B3960A682E-77302942!pb-smtp2.pobox.com

James Liu <james@jamesliu.io> writes:

> We'll be adding another option to the --no-* class of options soon.
>
> Clean up the existing options by grouping them together in the OPTIONS
> section, and adding missing ones to the SYNOPSIS.

Nice.  

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 7a1b112a3e..7fa75350b2 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -11,9 +11,9 @@ SYNOPSIS
>  [verse]
>  'git' [-v | --version] [-h | --help] [-C <path>] [-c <name>=<value>]
>      [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
> -    [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--bare]
> -    [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
> -    [--config-env=<name>=<envvar>] <command> [<args>]
> +    [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--no-lazy-fetch]
> +    [--no-optional-locks] [--bare] [--git-dir=<path>] [--work-tree=<path>]
> +    [--namespace=<name>] [--config-env=<name>=<envvar>] <command> [<args>]

Looks sensible.

There still are a few options (like noglob-pathspecs) missing, but
cleaning them up from this part of the documentation is totally
outside the scope of this topic (#leftoverbits -- we either make
this exhaustive, or make it clear that this is not exhaustive).

Thanks.
