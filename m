Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E75B5C615
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741430; cv=none; b=R4tKLQLwLHS0BojOXO9oH9cy6acVYo9EeUZ3Ds+TojwPt1HtpqIqF15kNVz3p/x1n460tAzqlWUiKVvUuf29HbZzpXX963abTPhxdjrSc0ko6jIXOpxGr5l7UAS/n9U8I/drVZAMj9UPUzYkXfYOXnmTwguhd15jrYw+0brmFG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741430; c=relaxed/simple;
	bh=9PQUM8t+h905GnzgFbrUhYuZwupVqkun7lYLcODeFVg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P2oYlUOPfQ8x/bWT0QRlQA1LZWeCf2XMOMlOnjUVmmlS9x5YfJLkjqZikLAbhorr3EZOiaau0W4GY/7uw+m08lxqRKSOYa8DpvFmWlmryDq5yDZqDTuOczBEwdNoFGdL94orJeUcdekJZ960JQenad09myF9dC8kLhJaVwYBPDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vVwyAV1s; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vVwyAV1s"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B02C51E42F;
	Wed,  6 Mar 2024 11:10:28 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9PQUM8t+h905GnzgFbrUhYuZwupVqkun7lYLcO
	DeFVg=; b=vVwyAV1sASePifrDJNzGFyz2vBTbxRTCDqiiHALNb1WCMw97aH5fEj
	4MA5QmyvYfhUTMcjn6kFXPiLl7fryAZs1p4TQ0KnwiCYiUS6emP1Hf9wayor1hMa
	zgWlwwj3h9o3xe8SCZcUkT4Fw4vlHtQOPWzsjXxgUQfGEXQE/M44I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A77541E42E;
	Wed,  6 Mar 2024 11:10:28 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 310721E42D;
	Wed,  6 Mar 2024 11:10:25 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Haritha via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Haritha D <Harithamma.D@ibm.com>,  Ghanshyam
 Thakkar <shyamthakkar001@gmail.com>,  rsbecker@nexbridge.com
Subject: Re: [PATCH v4] build: support z/OS (OS/390).
In-Reply-To: <pull.1663.v4.git.git.1709703857881.gitgitgadget@gmail.com>
	(Haritha via GitGitGadget's message of "Wed, 06 Mar 2024 05:44:17
	+0000")
References: <pull.1663.v3.git.git.1708841439516.gitgitgadget@gmail.com>
	<pull.1663.v4.git.git.1709703857881.gitgitgadget@gmail.com>
Date: Wed, 06 Mar 2024 08:10:23 -0800
Message-ID: <xmqqle6vtk7k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0A954D72-DBD4-11EE-BC40-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Haritha  via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Haritha D <harithamma.d@ibm.com>
>
> Introduced z/OS (OS/390) as a platform in config.mak.uname
>
> Signed-off-by: Haritha D <harithamma.d@ibm.com>
> ---
>     This PR enables a successful git build on z/OS.

Good.

>  config.mak.uname | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index dacc95172dc..d0dcca2ec55 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -638,6 +638,18 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>  	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
>  	SHELL_PATH = /usr/coreutils/bin/bash
>  endif
> +ifeq ($(uname_S),OS/390)
> +	NO_SYS_POLL_H = YesPlease
> +	NO_STRCASESTR = YesPlease
> +	NO_REGEX = YesPlease
> +	NO_MMAP = YesPlease
> +	NO_NSEC = YesPlease
> +	NO_STRLCPY = YesPlease
> +	NO_MEMMEM = YesPlease
> +	NO_GECOS_IN_PWENT = YesPlease
> +	HAVE_STRINGS_H = YesPlease
> +	NEEDS_MODE_TRANSLATION = YesPlease
> +endif

I somehow expected you to throw in the -L thing in this block,
perhaps like

	CC_LD_DYNPATH =

to help those who are on OS/390 but do not run configure (made from
configure.ac) to create the config.mak.autogen file, but if you are
always building with configure and not testing such a configuration,
then doing so and shipping an untested code would not be prudent, so
let's accept this patch as-is.

Thanks for working on this.  Will queue.
