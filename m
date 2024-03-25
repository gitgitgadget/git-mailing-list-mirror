Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019B125924B
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 02:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711335247; cv=none; b=WNGFlP3kuJDTwOFEXF7tXaujGu8xZoFDFj5TPM/nP6AA7w+C4ALsFzOErZPWla3t1xO+zc9uexP2DtGQRWFw+4KGq4yLVUownT4ic1TLHGRTrAGwUaKrkPaX0Ua+z5dZrOjbqw+OpyXtFsDfyoVXi2FNuKO+g38rx4HOv4hAzYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711335247; c=relaxed/simple;
	bh=u4xD05AebUD2Dx/0joKtfgu2/D3LDnrRd+38GSL/WNM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q+cag9FLC6m/Wr8q7uhvzQt3OMcHMwwGaJuyS/IFHerKlfDv0cNFdOVdW71av0pOpG+U42AK44D0uPk4iB78n2zKcFytZKY4qHlPVYRyFSit28LB7gqASkRjmYkOmMN5SU3uGEpTE+Gj4KoxmWGrIercMCLgwaJRi/9wtk725GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FxHGhi+W; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FxHGhi+W"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 77B8621168;
	Sun, 24 Mar 2024 22:54:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=u4xD05AebUD2Dx/0joKtfgu2/D3LDnrRd+38GS
	L/WNM=; b=FxHGhi+WADvav4YFX58hHJR/K/6jw1SWJQd97vDqZBNbV1vIX66QiL
	zYHaVdQ1ubDeY056aokSrTv5jeuCrt1ORQo5YfODw0A/vFZM2/AlhB4n3j0lZ8cZ
	YcxPvgInsoeKcrYrb2V+ZkyEgPE6AMuy+D3eb8PIkMPW1vXODy+Hc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 70F6721167;
	Sun, 24 Mar 2024 22:54:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0057B21165;
	Sun, 24 Mar 2024 22:54:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Max Gautier <mg@max.gautier.name>
Cc: git@vger.kernel.org,  Hans Jerry Illikainen <hji@dyntopia.com>
Subject: Re: [PATCH] editorconfig: add Makefiles to "text files"
In-Reply-To: <Zf_cSWY9DxVxKZu2@framework> (Max Gautier's message of "Sun, 24
	Mar 2024 08:54:49 +0100")
References: <20240322221813.13019-1-mg@max.gautier.name>
	<xmqqo7b5zy84.fsf@gitster.g> <Zf77gyA28KsZdOUs@framework>
	<xmqqr0g0yhoe.fsf@gitster.g> <Zf_cSWY9DxVxKZu2@framework>
Date: Sun, 24 Mar 2024 19:54:00 -0700
Message-ID: <xmqqwmprm37b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EF6CAF6C-EA52-11EE-BFF5-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Max Gautier <mg@max.gautier.name> writes:

> But yeah, "per-directory customization" isn't good, it multiplies the
> place to look when the config is not correct. I was mentioning by fear
> that using only one file would be hard to manage is there is too much
> patterns. 

Understood.

My primary point is that we are not using too many patterns
currently, and hence many files are *not* covered by .editorconfig
rules.  Some files may not even be meant to be edited by an editor,
but many others are allowed to be edited without enforcing any style
with .editorconfig and how to format them is up to the developers.
Applying a default rule to these files to enforce consistency may be
better than uncontrolled random mess each developer may leave
without any rules, and at the same time, doing so would mean we do
not have keep adding to the "C uses this rule, Shell uses this rule,
oh, now we also want Makefile to use this use" enumeration.

There may be fallouts (i.e., "For files of type X that currently are
not governed by .editorconfig, the indent-with-tab rule is not
suitable, but suddenly these files are subject to the default rule")
but adjusting the rules with exception would be more explicit and
clarify the rules.

