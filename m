Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7CA18C3D
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723570584; cv=none; b=MbOORy/nhZQr8+i8Bn76yLfsAHLt2k6uEJS21MeK5xYNP8KZTK0hkar2u1ns4fk9ZXiyCqbP1sQO76HG+b74xdUvY8JkX9UQ0FT59mkgWXVV+e6LYJ3Kl8hBuaMxhiq30MPzDqXmDNMDeOMAiMUAmdKu27YkY7yWmpCZ07GRPxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723570584; c=relaxed/simple;
	bh=sUiTsOd4yGN5ACqrKGzauhS1Ynk4wIu/Zcd2pj7bIZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C0r/dA60mUmZl4FiBXDJf5aqlBbiqHuaipqp3sS4dLslgNXkSBn3NNizT0/LN9aKDc/yoZvYRVBmec5C8RceNQ4vRdAAZB3G7/jVanEV0kvUd6TKE/5mM3NcxWBFfAkcUEX8Dwm3eJtbv7BvptaSfpzaxPrBr5qjhww/Xu28HXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OXmzR2GH; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OXmzR2GH"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A34F1F5F1;
	Tue, 13 Aug 2024 13:36:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=sUiTsOd4yGN5ACqrKGzauhS1Ynk4wIu/Zcd2pj
	7bIZ0=; b=OXmzR2GHjzqcqDiKfLqo8DuxEZuiPjHe8wPpfzgRfgV+qyg58bhPy1
	mVQkVYzfSY+IdwqNngBjG+c5gZtI8fSrAWd5bd2WK/ftEV1DwCNPIrRtpc7Lezvn
	f9RS7grS5mWsxgqJjCu8KxXUjd55Mqj3prODv9ZekRfQRbIfKfRGY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 522791F5F0;
	Tue, 13 Aug 2024 13:36:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 097281F5ED;
	Tue, 13 Aug 2024 13:36:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Alex Galvin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Alex Galvin <agalvin@comqi.com>,  Alex Galvin
 <alex.v.galvin@gmail.com>
Subject: Re: [PATCH] git-svn: mention `svn:globalignores` in help+docs
In-Reply-To: <pull.1766.git.git.1723500383989.gitgitgadget@gmail.com> (Alex
	Galvin via GitGitGadget's message of "Mon, 12 Aug 2024 22:06:23
	+0000")
References: <pull.1766.git.git.1723500383989.gitgitgadget@gmail.com>
Date: Tue, 13 Aug 2024 10:36:16 -0700
Message-ID: <xmqq4j7o5nqn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8C01DEAE-599A-11EF-82CC-E92ED1CD468F-77302942!pb-smtp21.pobox.com

"Alex Galvin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Alex Galvin <alex.v.galvin@gmail.com>
>
> Git-SVN was previously taught to use the svn:globalignores attribute
> as well as svn:ignore when creating or showing .gitignore files from
> a Subversion repository. However, the documentation and help message
> still only mentioned svn:ignore. This commit updates Git-SVN's
> documentation and help command to mention the newly supported attribute.

Thanks for tying these loose ends.  Very much appreciated.

> @@ -219,7 +219,7 @@ my %cmd = (
>  	                "Set an SVN repository to a git tree-ish",
>  			{ 'stdin' => \$_stdin, %cmt_opts, %fc_opts, } ],
>  	'create-ignore' => [ \&cmd_create_ignore,
> -			     'Create a .gitignore per svn:ignore',
> +			     'Create a .gitignore per directory with svn:ignore and svn:globalignores',

I do not know how likely it is that Subversion gains even more
sources of exclusion data in the future, but it makes me wonder if a
phrase like "Create a .gitignore file from ignore properties of svn"
so that we do not have to muck with the message.  Presumably those
who do use this feature know which properties Subversion uses to
record the ignored paths.  On the other hand, if it is not expected
to happen very soon, I think the text in this patch is good enough,
and we can revisit the issue of help text getting overly long when
we do need to add the third one.

The same comment applies to the runtime option help for the other
one.  I think listing the set of ignore properties we are aware of,
iow what you have in this patch, is perfectly appropriate for the
documentation.

Thanks.
