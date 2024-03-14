Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F24A73188
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 17:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436909; cv=none; b=I6qQemzOuQqXGXSB5feOgPGwQQb48qIqp1JLiVKWem8xbf69aEnn+//dk6fl8fgecxSIWVGenblRCuqRTQlkXKug8tIvE/8//H5KIlUgnDmLBLriLhseQ6ep/dRJfQgXtE3PWdxLjAlQA1R61bO1KciMvwlnuGrWDmEXL5IISuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436909; c=relaxed/simple;
	bh=CNSkvJcJae2iMDSTY10Ynm0ei0jPHOqrRaRpCaGfme4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DG6/mcdPLT2kC7+3vgNmcrA7rlhW9Dw5ayjg55PRWEUpm79fqkObGexB3+CJb4+QfDaWKDCJ9HvI38o8HJqCXLGm4a6RzEDUTXgGWqD/8edDK5KTdF/qOoDqne+aS9bUcxs3iDs1/vKUf721EZ+otcrWVX+i3mibCcSMg1QDww0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=euxjcz8m; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="euxjcz8m"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E2B2F2337C;
	Thu, 14 Mar 2024 13:21:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CNSkvJcJae2iMDSTY10Ynm0ei0jPHOqrRaRpCa
	Gfme4=; b=euxjcz8mSwPlaTPEtlZiPEFtUl4ewFvZjNnxKE30/aoszEIfecQfdG
	6KDRLfME/etl/LbNtghxw4qLY+IaJlj6gCFWo12AWyg+Rn3g0FD/f0e7e4xLqi4y
	1EhF4Lb+d1aWZiR8nRHMZO85a64tGVcjJcphdpSP0CncMRQg6shNQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DBA3A2337B;
	Thu, 14 Mar 2024 13:21:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7934423378;
	Thu, 14 Mar 2024 13:21:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 3/5] merge options: add a conflict style member
In-Reply-To: <47d0ec28a55a5c6604b30ad99953a078a789023a.1710435907.git.gitgitgadget@gmail.com>
	(Phillip Wood via GitGitGadget's message of "Thu, 14 Mar 2024 17:05:05
	+0000")
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
	<pull.1684.v2.git.1710435907.gitgitgadget@gmail.com>
	<47d0ec28a55a5c6604b30ad99953a078a789023a.1710435907.git.gitgitgadget@gmail.com>
Date: Thu, 14 Mar 2024 10:21:42 -0700
Message-ID: <xmqqsf0svie1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 53F346A0-E227-11EE-94F5-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> --- a/merge-ll.c
> +++ b/merge-ll.c
> @@ -128,7 +128,9 @@ static enum ll_merge_result ll_xdl_merge(const struct ll_merge_driver *drv_unuse
>  	xmp.level = XDL_MERGE_ZEALOUS;
>  	xmp.favor = opts->variant;
>  	xmp.xpp.flags = opts->xdl_opts;
> -	if (git_xmerge_style >= 0)
> +	if (opts->conflict_style >= 0)
> +		xmp.style = opts->conflict_style;
> +	else if (git_xmerge_style >= 0)
>  		xmp.style = git_xmerge_style;

The convention being negative ones are unknown/invalid/unspecified,
this if/else cascade makes sense.
